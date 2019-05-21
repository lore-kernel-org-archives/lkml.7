Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E69C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C3521743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558453366;
	bh=YVqGX7wPjOLgTlzR5jmtZLS+DKkLdxVEO+PlCNfxMZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Wjgd+wEphq8z+gkLocTxU+BBJOmCjo9PYswCQKv1LHlCvJ3c5n5qU4nUa3pFwtJjs
	 MtPThaEeSftV522+POaEL0/63EMZr5p+huvLK/jvSFZfqhznrqmERSWgFaQGSP1MLi
	 ALx7yx4cpfO8gCuXj+1+TYES/4QcNFnruzn1kwBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbfEUPmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:42:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728533AbfEUPmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:42:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8A46208C3;
        Tue, 21 May 2019 15:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558453364;
        bh=YVqGX7wPjOLgTlzR5jmtZLS+DKkLdxVEO+PlCNfxMZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bRIh4826Y5QBpUzIJG1tI+RLUmDl0Z2OvLJ4ibal5FrYGZyjhcM4HfiBtkm+GktY2
         wuk4rJkBVFh36nGG1W+7gdxjEFiL9bf+fm0DmtwHfTHBynvQmG4fim8XRUridN7lDv
         35aCs0LXQmFBgX55Plpdkdss/VJ2qI8I1RgExZws=
Date:   Tue, 21 May 2019 17:42:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: fieldbus: anybuss: force address space
 conversion
Message-ID: <20190521154241.GB15818@kroah.com>
References: <20190521145116.24378-1-TheSven73@gmail.com>
 <20190521151059.GM31203@kadam>
 <CAGngYiXLN-oT_b9d1kRyBrrFMALhKO-KnuwXB0MjVq0NFc01Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiXLN-oT_b9d1kRyBrrFMALhKO-KnuwXB0MjVq0NFc01Xw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 11:19:59AM -0400, Sven Van Asbroeck wrote:
> On Tue, May 21, 2019 at 11:13 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > There is no need to use __force.  Just:
> >
> >         void __iomem *base = (void __iomem *)context;
> >
> > For the rest as well.
> 
> Yes, that appears to work for 'void *' -> __iomem, but not the other way around:
> 
> +       return devm_regmap_init(dev, NULL, (void *)base, &regmap_cfg);
> 
> sparse generates:
> drivers/staging/fieldbus/anybuss/arcx-anybus.c:156:16: warning: cast
> removes address space of expression
> 
> Would it be a ok solution to use __force in this instance only?

Ick, if you are using __force, almost always something is wrong.

thanks

greg k-h
