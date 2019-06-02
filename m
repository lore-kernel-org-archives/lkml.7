Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9049BC282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 10:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6493C278A6
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 10:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVNFRgac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfFBKMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 06:12:53 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36291 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfFBKMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 06:12:53 -0400
Received: by mail-oi1-f196.google.com with SMTP id y124so10896949oiy.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 03:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7qacIANq562EgTHRqJG9jDAeUGiZDxPSfHGATxPq4ws=;
        b=oVNFRgacvtu/duMu6f1pvyGu2CDIHlJ7aJwuG+cjjh5sMqZSQR1qHuniKj/1c76QrJ
         qgaVenOQR81SxYUAfb+j8fLt9pL4JympAhEc22guvIuhi6fbzmhibm3xRwnaaOwIkuxE
         bbAqLaLs894e9iY+SHZf9L89LjUsySeKkUXDOoVCPjHlW0vjaVw1WHH6T83M6/S20H0C
         h1Pyrk0Joyo6zHciKkvac7S7zdd83RjPLwulIVpaHK6iyMooJ5pHQNP7Etgj1RkX1/MH
         iZYkeLO1UPZPzZP4Wnne9/SC8++bc8gVkhMfqyXyHJ3BqrVx7/kr4xmAX/glKkrEBrq4
         TkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7qacIANq562EgTHRqJG9jDAeUGiZDxPSfHGATxPq4ws=;
        b=FCP/5kHEq2sphALfL/cinH9pz8LsEKOXiu7ZUeIL88Omq4X+0X4JbIM4/RZDl37Q9T
         xOAAaJUvRhZpBDmCC6FXpy4uZYkm8ZumMjfuMGmEW5+apDXoEwOyxSD1zpmckanAFExn
         YN4/WUT1PybMjIIc5KjYj8XR2V4+CqvmnoSUyrZikSJHhFgRRxrRTuvtRFZ4Vjy2ytIG
         pejS60yYuxBrr+ega/EEjE9+lWL5GAkCg24Qvomv5M4rRCCm7tKPiBOcGdBCnVWWyAIP
         kVwL8qiiqSIHZLupbASSfOWauGDiBxC3PqdwqYBPMZ2oqM4SGJkgbuI5/ZME3l49KQC6
         d6jA==
X-Gm-Message-State: APjAAAWwF4ThLPH6voT/p+Oh1BIOQ2WYr17oc6OsdEdbxkNhgvFd4ScT
        RvbmshWHf+O3I3VTwkNJZYu15t+Rw0AylxuB+t0=
X-Google-Smtp-Source: APXvYqxZD7LMPq0FsVDfYzP9t1D5jZxRrHuaOry7yIhVsrT1UGENer0OhPxAeJKdevFuhxem76CLbJVCyPaj+eSAp/w=
X-Received: by 2002:aca:6c1:: with SMTP id 184mr4258973oig.122.1559470371918;
 Sun, 02 Jun 2019 03:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559412149.git.linux.dkm@gmail.com> <ad9dad01b15d233cbded3f0693c3c33e21f8d286.1559412149.git.linux.dkm@gmail.com>
 <a88b259e59c6a713a819266d9ad5c248efa43295.camel@perches.com>
In-Reply-To: <a88b259e59c6a713a819266d9ad5c248efa43295.camel@perches.com>
From:   Deepak Mishra <linux.dkm@gmail.com>
Date:   Sun, 2 Jun 2019 15:42:40 +0530
Message-ID: <CAHkoDDZc4ua7N8Y-rQfgBCXARu83mpQwYDp0sYOUE0AGmvsiFg@mail.gmail.com>
Subject: Re: [PATCH 8/8] staging: rtl8712: Fixed CamelCase in struct _adapter
 from drv_types.h
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc:     wlanfae <wlanfae@realtek.com>, gregkh@linuxfoundation.org,
        Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        himadri18.07@gmail.com, straube.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 01, 2019 at 12:26:02PM -0700, Joe Perches wrote:
> On Sun, 2019-06-02 at 00:13 +0530, Deepak Mishra wrote:
> > This patch fixes CamelCase blnEnableRxFF0Filter by renaming it
> > to bln_enable_rx_ff0_filter in drv_types.h and related files rtl871x_cmd.c
> > xmit_linux.c
>
> One could also improve this by removing the
> hungarian like bln_ prefix and simplify the
> name of the boolean variable.
>
 Thank you for your suggestion and I am modifying accordingly and
 sending a V2 patch.
> > diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
> []
> > @@ -164,7 +164,7 @@ struct _adapter {
> >     struct iw_statistics iwstats;
> >     int pid; /*process id from UI*/
> >     struct work_struct wk_filter_rx_ff0;
> > -   u8 blnEnableRxFF0Filter;
> > +   u8 bln_enable_rx_ff0_filter;
>
> e.g.:
>
>       bool enable_rx_ff0_filter;
>
> > diff --git a/drivers/staging/rtl8712/rtl871x_cmd.c b/drivers/staging/rtl8712/rtl871x_cmd.c
> []
> > @@ -238,7 +238,7 @@ u8 r8712_sitesurvey_cmd(struct _adapter *padapter,
> >     mod_timer(&pmlmepriv->scan_to_timer,
> >               jiffies + msecs_to_jiffies(SCANNING_TIMEOUT));
> >     padapter->ledpriv.LedControlHandler(padapter, LED_CTL_SITE_SURVEY);
> > -   padapter->blnEnableRxFF0Filter = 0;
> > +   padapter->bln_enable_rx_ff0_filter = 0;
>
>       padapter->enable_rx_ff0_filter = false;
>
> > diff --git a/drivers/staging/rtl8712/xmit_linux.c b/drivers/staging/rtl8712/xmit_linux.c
> []
> > @@ -103,11 +103,11 @@ void r8712_SetFilter(struct work_struct *work)
> >     r8712_write8(padapter, 0x117, newvalue);
> >
> >     spin_lock_irqsave(&padapter->lockRxFF0Filter, irqL);
> > -   padapter->blnEnableRxFF0Filter = 1;
> > +   padapter->bln_enable_rx_ff0_filter = 1;
>
>       padapter->enable_rx_ff0_filter = true;
>
> etc...
>
> Then you could rename padapter to adapter, and maybe
> "struct _adapter" to something more sensible like
> "struct rtl8712dev" etc...
>
  Thanks for suggestion again. I am going to take it in a diferent patchset
  and submit that.

> And one day, hopefully sooner than later, realtek will
> improve their driver software base and help eliminate
> all the duplicated non-style defects across the family
> of drivers for their hardware...
>

Best regards

Deepak Mishra
