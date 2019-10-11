Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D04C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05EC21D6C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570784581;
	bh=h5qJF0hmtg1wCO55oJJVfVPaqfb/n18+4ePM3MinMNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tO7+HZnvPwl1zVnHBOZ+CFsSvWS46AA3rg33BvPvoykVelgjQKT2lVtXfnuIj1cov
	 j1lhZwMxB61JFly76B9I7cCyfaxZAnYl+oIY3sYUNqoFmXVMcEJjYX+XkS4cKkHWh6
	 AK8x5KpFUiPazKGEQQxTEZlZd36a3JTxKwk408EE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfJKJC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 05:02:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbfJKJC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 05:02:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54D6D2084C;
        Fri, 11 Oct 2019 09:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570784578;
        bh=h5qJF0hmtg1wCO55oJJVfVPaqfb/n18+4ePM3MinMNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jV8gVVhvuKQW7F0hZ3ZG5r9VfQHGO5OVzNZKbgFT/g4t2VSaVsxJ0/p3XjLhiCMQN
         uFWR9Rx0hNF2XpT+zNXirlZZ68mOR4P8F44NYajP5guO7iiqkvuyMyyhi4lOe3bU9+
         p0f2G6WgbHd6XsruQTmfda/yUSfwmsteGyKMpcN8=
Date:   Fri, 11 Oct 2019 11:02:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jerome Pouiller <Jerome.Pouiller@silabs.com>
Cc:     zhong jiang <zhongjiang@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: wfx: fix an undefined reference error when
 CONFIG_MMC=m
Message-ID: <20191011090256.GC1076760@kroah.com>
References: <1570762939-8735-1-git-send-email-zhongjiang@huawei.com>
 <20191011042609.GB938845@kroah.com>
 <3864047.FfxYVOUlJ1@pc-42>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3864047.FfxYVOUlJ1@pc-42>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 08:40:08AM +0000, Jerome Pouiller wrote:
> On Friday 11 October 2019 06:26:16 CEST Greg KH wrote:
> > CAUTION: This email originated from outside of the organization. Do not 
> click links or open attachments unless you recognize the sender and know the 
> content is safe.
> > 
> > 
> > On Fri, Oct 11, 2019 at 11:02:19AM +0800, zhong jiang wrote:
> > > I hit the following error when compile the kernel.
> > >
> > > drivers/staging/wfx/main.o: In function `wfx_core_init':
> > > /home/z00352263/linux-next/linux-next/drivers/staging/wfx/main.c:488: 
> undefined reference to `sdio_register_driver'
> > > drivers/staging/wfx/main.o: In function `wfx_core_exit':
> > > /home/z00352263/linux-next/linux-next/drivers/staging/wfx/main.c:496: 
> undefined reference to `sdio_unregister_driver'
> > > drivers/staging/wfx/main.o:(.debug_addr+0x1a8): undefined reference to 
> `sdio_register_driver'
> > > drivers/staging/wfx/main.o:(.debug_addr+0x6f0): undefined reference to 
> `sdio_unregister_driver'
> > >
> > > Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> > > ---
> > >  drivers/staging/wfx/Kconfig  | 3 ++-
> > >  drivers/staging/wfx/Makefile | 5 +++--
> > >  2 files changed, 5 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/staging/wfx/Kconfig b/drivers/staging/wfx/Kconfig
> > > index 9b8a1c7..4d045513 100644
> > > --- a/drivers/staging/wfx/Kconfig
> > > +++ b/drivers/staging/wfx/Kconfig
> > > @@ -1,7 +1,8 @@
> > >  config WFX
> > >       tristate "Silicon Labs wireless chips WF200 and further"
> > >       depends on MAC80211
> > > -     depends on (SPI || MMC)
> > > +     depends on SPI
> > > +     select MMC
> > 
> > How about:
> >         depends on (SPI && MMC)
> 
> I dislike to force user to enable both buses while only one of them is 
> sufficient. I would prefer to keep current dependencies and to add
> #ifdef around problematic functions.

Yes, that's the better thing to do here overall.

zhong, can you work on that?

thanks,

greg k-h
