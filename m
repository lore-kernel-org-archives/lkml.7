Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2212EC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E692F20835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PG9Kk3k9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfD3PKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 11:10:47 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52242 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfD3PKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:10:47 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3UFAhn6102546;
        Tue, 30 Apr 2019 10:10:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556637043;
        bh=PyjPXxQDLD7OrC57FpZWZ3HgMp8P6I8TlGFCKvjI1a4=;
        h=Date:From:To:Subject:References:In-Reply-To;
        b=PG9Kk3k9s2bA12V3msMGYu5ppdPrEMreOt4Xv1toqdr+/tCWUW7cD/1Q979HjWway
         kWp1IiD95I+JhoRr+qXSCeWhDB3vTqd9IXQ8sWUIOfIngdh/lIxRA7CAoDo47PJOGk
         f2B/t9aLPlc+bgTBW+yW71e1i2jLEuaoBVkykRc8=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3UFAh0V107532
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Apr 2019 10:10:43 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 30
 Apr 2019 10:10:43 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 30 Apr 2019 10:10:43 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3UFAhoi114023;
        Tue, 30 Apr 2019 10:10:43 -0500
Date:   Tue, 30 Apr 2019 10:10:43 -0500
From:   Bin Liu <b-liu@ti.com>
To:     Paul Cercueil <paul@crapouillou.net>, <od@zcrc.me>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: musb: Disable pullup in gadget setup
Message-ID: <20190430151043.GG20993@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Paul Cercueil <paul@crapouillou.net>, od@zcrc.me,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190404093743.6470-1-paul@crapouillou.net>
 <20190404161046.GA30182@uda0271908>
 <20190430150506.GF20993@uda0271908>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190430150506.GF20993@uda0271908>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 10:05:06AM -0500, Bin Liu wrote:
> Hi Paul,
> 
> On Thu, Apr 04, 2019 at 11:10:46AM -0500, Bin Liu wrote:
> > On Thu, Apr 04, 2019 at 11:37:43AM +0200, Paul Cercueil wrote:
> > > The pullup may be already enabled before the driver is initialized.
> > > It has to be disabled at init time, as we cannot guarantee that a gadget
> > > driver will be bound to the UDC.
> > > 
> > > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > > ---
> > >  drivers/usb/musb/musb_gadget.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
> > > index ffe462a657b1..094dc59c834c 100644
> > > --- a/drivers/usb/musb/musb_gadget.c
> > > +++ b/drivers/usb/musb/musb_gadget.c
> > > @@ -1794,6 +1794,7 @@ int musb_gadget_setup(struct musb *musb)
> > >  
> > >  	musb->is_active = 0;
> > >  	musb_platform_try_idle(musb, 0);
> > > +	musb_pullup(musb, 0);
> > >  
> > >  	status = usb_add_gadget_udc(musb->controller, &musb->g);
> > >  	if (status)
> > 
> > Applied.
> 
> Sorry, I have dropped this patch from my tree. I realized the gadget
> core already defines callbacks to control the pullup. I think the
> proper fix should be calling usb_udc_vbus_handler() in musb gadget or
> glue layers.

Basically besides the problem your patch tries to fix, there is another
problem related to the pullup, which is enabled right after bind a
gadget driver, regardless of vbus status. This violates the USB Spec.
Implementing the udc core callbacks should fix both issues.

-Bin.
