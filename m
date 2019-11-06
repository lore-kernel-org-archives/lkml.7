Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7E2C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 00:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D5421A4A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 00:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572998919;
	bh=d8eua9epBG5FR3oyfrO8a6KH1Z3GMMnPGdw78PUjkOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d10KOzaM89Z3emgKoG4UlHxidZOBTnOLz3oTm2f+J9I9qQXaiJZMgAX9+etzKahwi
	 ZjNDhUQILFuyKBJT60N3qmm2JVvqko4KGcFqnXLw2g3IAtisO3mosq3GVnfC9qZCl7
	 UrRCgZB7rCe1ShN5y+YDoLVjVj6lNr+YbP9tAvUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbfKFAIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 19:08:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:50568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727252AbfKFAIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 19:08:38 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FC65214D8;
        Wed,  6 Nov 2019 00:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572998917;
        bh=d8eua9epBG5FR3oyfrO8a6KH1Z3GMMnPGdw78PUjkOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IgO5vzyKQlxiswiCAv0ySsNr5xM1suuJtgO7N2+x28RU45JBffkFf8N1OQ1FM5xwj
         5iRqXhFjvhJhQoqhcEIHBCXDk/TGpDXiYcaexlLUYr3xOGgo7y+HdR7OdCAAaLAvmg
         Sz8QqvITUCvfXHe1KPDcbG8ywsRAAk7yZZLnQ94A=
Date:   Tue, 5 Nov 2019 19:08:36 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Marta Rybczynska <mrybczyn@kalray.eu>,
        Charles Machalow <csm10495@gmail.com>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        kbusch <kbusch@kernel.org>, axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] nvme: change nvme_passthru_cmd64 to explicitly mark rsvd
Message-ID: <20191106000836.GH4787@sasha-vm>
References: <20191105061510.22233-1-csm10495@gmail.com>
 <442718702.90376810.1572939552776.JavaMail.zimbra@kalray.eu>
 <20191105153144.GA12437@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191105153144.GA12437@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 04:31:44PM +0100, Christoph Hellwig wrote:
>On Tue, Nov 05, 2019 at 08:39:12AM +0100, Marta Rybczynska wrote:
>> Looks good to me. However, please note that the new ioctl made it already to 5.3.8.
>
>It wasn't in 5.3, but it seems like you are right and it somehow got
>picked for the stable releases.
>
>Sasha, can you please revert 76d609da9ed1cc0dc780e2b539d7b827ce28f182
>in 5.3-stable ASAP and make sure crap like backporting new ABIs that
>haven't seen a release yet is never ever going to happen again?

Sure, I'll revert it. I guess I wasn't expecting to see something like
this in a -rc release. How did it make it into one if it's not a fix?

-- 
Thanks,
Sasha
