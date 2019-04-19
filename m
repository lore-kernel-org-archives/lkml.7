Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73A6C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8461A20693
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555701741;
	bh=zmMx37s3JzOIhq08bbXup23KSsDRHNtGTeN8Y7kENLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F984QsPtztCDSHKHg2E57+Ru5FLZbqq98ozeXDz/SSV1t4WFNfOrp/M+25PmkFkc8
	 qgZs8ZyFabWc6gOfxtlvW9Vgn2rNlpGL4ngmwfPmLqDJVuJApnip55PgehzPrJGyOh
	 dRl7ZmfhJ2OwrIjZ/mR5ajiUACilFqg4gmUA2lsg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfDSTWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:22:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbfDSTWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:22:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB45120693;
        Fri, 19 Apr 2019 19:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555701739;
        bh=zmMx37s3JzOIhq08bbXup23KSsDRHNtGTeN8Y7kENLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tUliQfqqusHljxjzAsXggQ66GvJfbwxhXehq94e5SvJQT9sJuSheKERmVdsX+Qari
         kJTM8wAnaI7gfBfNs77BdXIluL9GiEHpS/a7F1CX6B5WhrbB0/7Jc1r1fyt4RKYL8j
         VYR/GjPcFnbSRPV6SkJURROYTEY48WWn5hYD5Evk=
Date:   Fri, 19 Apr 2019 21:22:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bhanusree Mahesh <bhanusreemahesh@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rtl8723bs: core: Replace rtw_malloc with kmalloc
Message-ID: <20190419192217.GB11144@kroah.com>
References: <1555669363-19782-1-git-send-email-bhanusreemahesh@gmail.com>
 <20190419112232.GB14886@kroah.com>
 <CAB0Mk-M72dSoT4y7_JfOA6M8TNeGsRoTH5MpX9zwr1h8KPdjUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB0Mk-M72dSoT4y7_JfOA6M8TNeGsRoTH5MpX9zwr1h8KPdjUg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 07:02:47PM +0530, Bhanusree Mahesh wrote:
> On Fri, 19 Apr 2019 at 16:52, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Apr 19, 2019 at 03:52:43PM +0530, Bhanusree Pola wrote:
> > > Replace rtw_malloc with kmalloc to make code OS independent
> > > use kmalloc second argument as GFP_ATOMIC as these are called by functions
> > > that holds lock.
> > >
> > > Signed-off-by: Bhanusree Pola <bhanusreemahesh@gmail.com>
> > > ---
> > >  drivers/staging/rtl8723bs/core/rtw_ap.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
> > > index 18fabf5..6a6683c 100644
> > > --- a/drivers/staging/rtl8723bs/core/rtw_ap.c
> > > +++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
> > > @@ -128,7 +128,7 @@ static void update_BCNTIM(struct adapter *padapter)
> > >               }
> > >
> > >               if (remainder_ielen > 0) {
> > > -                     pbackup_remainder_ie = rtw_malloc(remainder_ielen);
> > > +                     pbackup_remainder_ie = kmalloc(remainder_ielen,GFP_ATOMIC);
> >
> > Always run checkpatch.pl on your patches so you do nto get grumpy
> > maintainers telling you to run checkpatch.pl on your code :)
> 
> >
> > Why not fix up all of the callers of this function?
> 
> There are many callers of this function. Should I send the whole thing
> as of patch series?

Yes, that would be good.

> >And are you sure
> > that GFP_ATOMIC is the correct thing to do here?
> 
> yes, because it is called by the function which holds the lock.

What lock?

> correct me if I'm wrong.

I don't know, but you should document why you did it this way in the
changelog comment so that people can review it.

thanks,

greg k-h
