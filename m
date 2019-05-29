Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF89C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 17:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861EA23FD6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 17:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="0PbmZkMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfE2Rh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 13:37:59 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38690 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfE2Rh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 13:37:58 -0400
Received: by mail-pl1-f193.google.com with SMTP id f97so1363248plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 10:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P5qFwG17SpgYEBbMd24uDFEzDrg0W0gjzgec9qjRsHI=;
        b=0PbmZkMnPHejgFz0ujeFGYBWNbO4/H3W/KxnYLZaFEqXlSXGHK64PdfnVL3N3XS5Fh
         cO0vVaJFVjkC/1yxSL4/LstpbDi+lUKYCpV3ynymmCkkM1bjOA6CyTR+Oe6vEqhh2Y3g
         w6l440tAk31jw0qycOfa2SLV8CwgweEfE8ZZOd+mG9/7KCGiM/Qd6bibeQqz4k5Es4vz
         /Bhzc3NDT8LtD0ZNGZV3fsiGgKl9nze6GVVFSJ0RmKJa688f+qwfR9ByNd+QDM9zzHj1
         ChODFTtnDp427elF/SP6xVbHGIZEoVg9Ot8sl6LVolM5csBwXT8ja0oUlbfl2m0xVPsS
         lCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P5qFwG17SpgYEBbMd24uDFEzDrg0W0gjzgec9qjRsHI=;
        b=umEdUOyJZqkNwmpzaeqjormUKKrcx1auU8fOeviocnAgJ2YnIg++B1bk3OcHhiYUij
         MorHQ9b4oSJHxL3ycaoXOB0e4ElVVwqOCxHaIFISHjrk+WCx1+qkHMtrP2Uru/vjIZFI
         pjxrS4g2seJ6tnFE+9SKd6lv/T2Y6/+lb04RFLIbOLxgpYpvrxRkcyELYCXRSlQk9dYm
         /DZYqeeDna227GWmKkZ1iSdIg6xgKPjzX3UgOk6Q8tNyHgVrdoN4g2lSDgaF2lupMjy4
         FuBICY/ZWPgdARVLkDRZOHlDI5wRcG9oYqrWwg3gMxHMoqGxio0dR6ka+xXF7uWWsAFQ
         fafg==
X-Gm-Message-State: APjAAAX8QfQcFjxypQARr9CbYbId7LzHudcBftYi7oIaySFBBBGGGnr7
        aWJQGEM8tOS/WBOP4VIXIWwBWASvz3mmibGYtF1JBA==
X-Google-Smtp-Source: APXvYqwaYqW814HlTpJTnPLyf9EGoJyfyL3ZLMVxQs89o0QOJMRGM12E60Fe6HC4/QLB/stvv0pzGNInpud79CXyefA=
X-Received: by 2002:a17:902:54f:: with SMTP id 73mr20211625plf.246.1559151477493;
 Wed, 29 May 2019 10:37:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190521062837.3887-1-hdegoede@redhat.com> <CAOcMMifdq8PcnwANKxGtAmB+5nNOv-aEW3aFJyfPNngXeYCK5A@mail.gmail.com>
 <1026f860-e961-cefe-3695-aaeaa8896597@redhat.com>
In-Reply-To: <1026f860-e961-cefe-3695-aaeaa8896597@redhat.com>
From:   =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>
Date:   Wed, 29 May 2019 10:37:46 -0700
Message-ID: <CAOcMMid6p8_1i=NpD+GHDV4c6WmwWs=FseC345USaF_etj956A@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: asus-wmi: Only Tell EC the OS will handle
 display hotkeys from asus_nb_wmi
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        acpi4asus-user@lists.sourceforge.net,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 1:55 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Jo=C3=A3o,
>
> On 5/28/19 11:22 PM, Jo=C3=A3o Paulo Rechi Vita wrote:
> > On Mon, May 20, 2019 at 11:28 PM Hans de Goede <hdegoede@redhat.com> wr=
ote:
> >>
> >> Commit 78f3ac76d9e5 ("platform/x86: asus-wmi: Tell the EC the OS will
> >> handle the display off hotkey") causes the backlight to be permanently=
 off
> >> on various EeePC laptop models using the eeepc-wmi driver (Asus EeePC
> >> 1015BX, Asus EeePC 1025C).
> >>
> >> The asus_wmi_set_devstate(ASUS_WMI_DEVID_BACKLIGHT, 2, NULL) call adde=
d
> >> by that commit is made conditional in this commit and only enabled in
> >> the quirk_entry structs in the asus-nb-wmi driver fixing the broken
> >> display / backlight on various EeePC laptop models.
> >>
> >> Cc: Jo=C3=A3o Paulo Rechi Vita <jprvita@endlessm.com>
> >> Fixes: 78f3ac76d9e5 ("platform/x86: asus-wmi: Tell the EC the OS will =
handle the display off hotkey")
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >> ---
> >>   drivers/platform/x86/asus-nb-wmi.c | 8 ++++++++
> >>   drivers/platform/x86/asus-wmi.c    | 2 +-
> >>   drivers/platform/x86/asus-wmi.h    | 1 +
> >>   3 files changed, 10 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86=
/asus-nb-wmi.c
> >> index b6f2ff95c3ed..59f3a37a44d7 100644
> >> --- a/drivers/platform/x86/asus-nb-wmi.c
> >> +++ b/drivers/platform/x86/asus-nb-wmi.c
> >> @@ -78,10 +78,12 @@ static bool asus_q500a_i8042_filter(unsigned char =
data, unsigned char str,
> >>
> >>   static struct quirk_entry quirk_asus_unknown =3D {
> >>          .wapf =3D 0,
> >> +       .wmi_backlight_set_devstate =3D true,
> >>   };
> >>
> >>   static struct quirk_entry quirk_asus_q500a =3D {
> >>          .i8042_filter =3D asus_q500a_i8042_filter,
> >> +       .wmi_backlight_set_devstate =3D true,
> >>   };
> >>
> >>   /*
> >> @@ -92,26 +94,32 @@ static struct quirk_entry quirk_asus_q500a =3D {
> >>   static struct quirk_entry quirk_asus_x55u =3D {
> >>          .wapf =3D 4,
> >>          .wmi_backlight_power =3D true,
> >> +       .wmi_backlight_set_devstate =3D true,
> >>          .no_display_toggle =3D true,
> >>   };
> >>
> >>   static struct quirk_entry quirk_asus_wapf4 =3D {
> >>          .wapf =3D 4,
> >> +       .wmi_backlight_set_devstate =3D true,
> >>   };
> >>
> >>   static struct quirk_entry quirk_asus_x200ca =3D {
> >>          .wapf =3D 2,
> >> +       .wmi_backlight_set_devstate =3D true,
> >>   };
> >>
> >>   static struct quirk_entry quirk_asus_ux303ub =3D {
> >>          .wmi_backlight_native =3D true,
> >> +       .wmi_backlight_set_devstate =3D true,
> >>   };
> >>
> >>   static struct quirk_entry quirk_asus_x550lb =3D {
> >> +       .wmi_backlight_set_devstate =3D true,
> >>          .xusb2pr =3D 0x01D9,
> >>   };
> >>
> >>   static struct quirk_entry quirk_asus_forceals =3D {
> >> +       .wmi_backlight_set_devstate =3D true,
> >>          .wmi_force_als_set =3D true,
> >>   };
> >>
> >> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/as=
us-wmi.c
> >> index ee1fa93708ec..a66e99500c12 100644
> >> --- a/drivers/platform/x86/asus-wmi.c
> >> +++ b/drivers/platform/x86/asus-wmi.c
> >> @@ -2131,7 +2131,7 @@ static int asus_wmi_add(struct platform_device *=
pdev)
> >>                  err =3D asus_wmi_backlight_init(asus);
> >>                  if (err && err !=3D -ENODEV)
> >>                          goto fail_backlight;
> >> -       } else
> >> +       } else if (asus->driver->quirks->wmi_backlight_set_devstate)
> >>                  err =3D asus_wmi_set_devstate(ASUS_WMI_DEVID_BACKLIGH=
T, 2, NULL);
> >>
> >>          status =3D wmi_install_notify_handler(asus->driver->event_gui=
d,
> >> diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/as=
us-wmi.h
> >> index 6c1311f4b04d..57a79bddb286 100644
> >> --- a/drivers/platform/x86/asus-wmi.h
> >> +++ b/drivers/platform/x86/asus-wmi.h
> >> @@ -44,6 +44,7 @@ struct quirk_entry {
> >>          bool store_backlight_power;
> >>          bool wmi_backlight_power;
> >>          bool wmi_backlight_native;
> >> +       bool wmi_backlight_set_devstate;
> >
> > Wouldn't it be better to add this field to struct asus_wmi_driver
> > instead, and set it in asus_nb_wmi_driver only? This way we wouldn't
> > need to make sure it is present in all quirk entries from this driver,
> > current and future.
> >
> > I've tested both the original patch and my suggestion above and in
> > both cases the "turn off backlight" hotkey continued to work fine on a
> > machine where asus-nb-wmi is used (I don't have access to any machine
> > using the eeepc driver).
>
> I deliberately put in the quirks struct so that if necessary we can
> enable / disable it easily on a per model (rather then per driver)
> case in the future.
>

You are right that it will be easier to change it if we ever need to,
although I don't expect it to happen in the near future (famous last
words). It would be nice to not have to add it to every quirk entry,
current and new though. But I do not have another suggestion atm, so
I'm fine with your original approach.

Reviewed-by: Jo=C3=A3o Paulo Rechi Vita <jprvita@endlessm.com>

...........................................................................=
...........
Jo=C3=A3o Paulo Rechi Vita  |  Endless
