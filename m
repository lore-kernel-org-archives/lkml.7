Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E208C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 14:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9A62176D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 14:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575037874;
	bh=ysU6Uvk9pdWPHQ/cwCM/Ngg0+69Q8qgputUIYrAH7Wo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rnVLYuqet4fFqo6yypb+h5e/0raf97vKB/m2H8dG5SaLtv2s9g9zRjOSvqV27vuou
	 L58fxH3iTAt5FeBBOeOlzNqc4bwds+Q9KVZChDqHXYVyHHdJo8Aej7Bn2d55FjeYaY
	 RydQnz69hMsE2/Y2hjtaKsiDXBb/nR8S4nrG8roM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfK2ObN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 09:31:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:56062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbfK2ObM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 09:31:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F104B21736;
        Fri, 29 Nov 2019 14:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575037870;
        bh=ysU6Uvk9pdWPHQ/cwCM/Ngg0+69Q8qgputUIYrAH7Wo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i2IJsT1ihvKIL3Kqavfsq8w03kPgzni7rgCWNxHl3r9fXueYHh2IivV7uUdF7o/vO
         JQDuZo1GgwA0JwMII2VOUUvMmH+u758MLGh02T9fpTQiL9jO91Qpf5YxUbIJJL4o1z
         TbucC0ZtByJ3k4Fx9CAdC8dag4wOc+hMfDL4aAbE=
Date:   Fri, 29 Nov 2019 15:31:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Huazhong Tan <tanhuazhong@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 185/306] net: hns3: bugfix for buffer not free
 problem during resetting
Message-ID: <20191129143108.GA3708972@kroah.com>
References: <20191127203114.766709977@linuxfoundation.org>
 <20191127203128.798931840@linuxfoundation.org>
 <20191129110010.GA4313@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129110010.GA4313@amd>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 12:00:10PM +0100, Pavel Machek wrote:
> Hi!
> 
> > From: Huazhong Tan <tanhuazhong@huawei.com>
> > 
> > [ Upstream commit 73b907a083b8a8c1c62cb494bc9fbe6ae086c460 ]
> > 
> > When hns3_get_ring_config()/hns3_queue_to_ring()/
> > hns3_get_vector_ring_chain() failed during resetting, the allocated
> > memory has not been freed before these three functions return. So
> > this patch adds error handler in these functions to fix it.
> 
> Correct me if I'm wrong, but... this introduces use-after-free:
> 
> > @@ -2592,6 +2592,16 @@ static int hns3_get_vector_ring_chain(struct hns3_enet_tqp_vector *tqp_vector,
> >  	}
> >  
> >  	return 0;
> > +
> > +err_free_chain:
> > +	cur_chain = head->next;
> > +	while (cur_chain) {
> > +		chain = cur_chain->next;
> > +		devm_kfree(&pdev->dev, chain);
> > +		cur_chain = chain;
> > +	}
> 
> Lets take two iterations:
> 
> > +		chain = cur_chain->next;
> > +		devm_kfree(&pdev->dev, chain);
> chain freed here.
> > +		cur_chain = chain;
> 
> > +		chain = cur_chain->next;
> chain->next accessed here, after free.
> > +		devm_kfree(&pdev->dev, chain);
> > +		cur_chain = chain;
> 
> Should it do devm_kfree(&pdev->dev, cur_chain); ?

I think Sasha tried to backport a fix for this patch, but that fix broke
the build :(

If you want to provide a working backport, I'll be glad to take it.

thanks,

greg k-h
