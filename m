Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D5AC4360D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0418217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SRkhwVFd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbfIZAjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:39:37 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38140 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbfIZAjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:39:37 -0400
Received: by mail-qk1-f193.google.com with SMTP id u186so365888qkc.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 17:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8eElvPCoM/FfEnn5Y4ueHDwedd4HgZwZRPzixoGrG8Y=;
        b=SRkhwVFdVzU6Xd8hDe1fjb+pbOsZaE2zoac5LpFpNUAq5387VnUQYu66P9pKspY4QS
         tyx/JCI8DmzLJyHnqqsJ4cys0kdlwdoTZUjr6txj2JT0y671xbzHCXGyc44Fp1J/VQwx
         qP76nOzMumdSVfW0J+k14XJdC3gtD8dYXnqgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8eElvPCoM/FfEnn5Y4ueHDwedd4HgZwZRPzixoGrG8Y=;
        b=fcdMh4fmVqpgOZ0ddtUhksFXN4/40MZOFdRlteerPTn/qvE4Z51CFp8uw3/Mof7DO1
         AtCMOTDpXvZdyBC/Tabc8ebCcIeizJDWIpyZA+NuZQDhOY1gYCGuXdtwbei/M3pFzNrg
         bKEoKiCtucwphjmFvYYEt30rG+qLsti/ljivUx65usEn2auiYA714+5QDsq5rtp1CQkK
         YwnbQH/N1D+lKNi/L5gv/W2oOBw+LXCqM3bHAXBCjjzs4sTzvXJ+ZkRDGQR6StlGBlrk
         t6w/bWWYbawEY+NjFxMOUVM5oZ6eD7Yf/zxJjXfgU6HmaNEvKsuw3zVSwC/5nDGVEGmb
         fr3g==
X-Gm-Message-State: APjAAAXzAqfFeooWmK5nHFjQkH8VFckZylLzEbIonXouFntR0/DDSJMe
        wjItsg5FdDZCJC078lYnxsBjNwgJNw+5SpGsNXk3Jg==
X-Google-Smtp-Source: APXvYqysEFiOA5JsgMZ41RNUUxUa7Or5sDYleM9GT9IE+iSk5HjBjZ/LqeLOrwmBKEcZCtSL7jmzfEV43UKJ/AQUUqU=
X-Received: by 2002:a37:dcc1:: with SMTP id v184mr805620qki.258.1569458376178;
 Wed, 25 Sep 2019 17:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190924024958.GA229906@dtor-ws> <20190924082143.GS2680@smile.fi.intel.com>
In-Reply-To: <20190924082143.GS2680@smile.fi.intel.com>
From:   Alex Levin <levinale@chromium.org>
Date:   Wed, 25 Sep 2019 17:39:25 -0700
Message-ID: <CAPBFDX+Bjd7CZg2ZqBANJ6=pb9SA7bnpxOo=Lv4BS1CJUytEmQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: cherryview: restore Strago DMI workaround for
 all versions
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 1:21 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Sep 23, 2019 at 07:49:58PM -0700, Dmitry Torokhov wrote:
> > This is essentially a revert of:
> >
> > e3f72b749da2 pinctrl: cherryview: fix Strago DMI workaround
> > 86c5dd6860a6 pinctrl: cherryview: limit Strago DMI workarounds to version 1.0
> >
> > because even with 1.1 versions of BIOS there are some pins that are
> > configured as interrupts but not claimed by any driver, and they
> > sometimes fire up and result in interrupt storms that cause touchpad
> > stop functioning and other issues.
> >
> > Given that we are unlikely to qualify another firmware version for a
> > while it is better to keep the workaround active on all Strago boards.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Tested-by: Alex Levin <levinale@chromium.org>

>
> >
> > Reported-by: Alex Levin <levinale@chromium.org>
> > Fixes: 86c5dd6860a6 ("pinctrl: cherryview: limit Strago DMI workarounds to version 1.0")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/pinctrl/intel/pinctrl-cherryview.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
> > index 03ec7a5d9d0b..bf049d1bbb87 100644
> > --- a/drivers/pinctrl/intel/pinctrl-cherryview.c
> > +++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
> > @@ -1513,7 +1513,6 @@ static const struct dmi_system_id chv_no_valid_mask[] = {
> >               .matches = {
> >                       DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
> >                       DMI_MATCH(DMI_PRODUCT_FAMILY, "Intel_Strago"),
> > -                     DMI_MATCH(DMI_PRODUCT_VERSION, "1.0"),
> >               },
> >       },
> >       {
> > @@ -1521,7 +1520,6 @@ static const struct dmi_system_id chv_no_valid_mask[] = {
> >               .matches = {
> >                       DMI_MATCH(DMI_SYS_VENDOR, "HP"),
> >                       DMI_MATCH(DMI_PRODUCT_NAME, "Setzer"),
> > -                     DMI_MATCH(DMI_PRODUCT_VERSION, "1.0"),
> >               },
> >       },
> >       {
> > @@ -1529,7 +1527,6 @@ static const struct dmi_system_id chv_no_valid_mask[] = {
> >               .matches = {
> >                       DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
> >                       DMI_MATCH(DMI_PRODUCT_NAME, "Cyan"),
> > -                     DMI_MATCH(DMI_PRODUCT_VERSION, "1.0"),
> >               },
> >       },
> >       {
> > @@ -1537,7 +1534,6 @@ static const struct dmi_system_id chv_no_valid_mask[] = {
> >               .matches = {
> >                       DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
> >                       DMI_MATCH(DMI_PRODUCT_NAME, "Celes"),
> > -                     DMI_MATCH(DMI_PRODUCT_VERSION, "1.0"),
> >               },
> >       },
> >       {}
> > --
> > 2.23.0.351.gc4317032e6-goog
> >
> >
> > --
> > Dmitry
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
