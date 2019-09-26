Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB266C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 08:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D37E222BE
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 08:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qHZuGOjU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbfIZILv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 04:11:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46371 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfIZILv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 04:11:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id o18so1262418wrv.13;
        Thu, 26 Sep 2019 01:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gDALH1LBbhi9Y7gQ8eErUzmJUJ1kd3iAMb/qez5kxcs=;
        b=qHZuGOjUmO1mYR7HEbj6/LE7vY302STFSNUPRMSIle9LIa4NJsT1AvcRvP9wjGAjQC
         7eYlDNs9BfNmIydRTz2VaS6F1QFd798bBLKip+ITNF46bYNJHZEhXnh/YeVayZw5rFPJ
         58R/bjemDaxuvXFh4ezRM6GlSq9qmH7dNwJ1YSNpBUi7+lYievP0nf2fqeGyWl15IJOJ
         rltwlaVMeMvIwiB8zraRrCOzH4gRg1ZUMcc60N0+cPJJYbvUuIEH57tL+4AyEvpxpWHU
         0JTJiLBJgPZcgZESrd/q++1kFQAjZ65bwijxAG5P4uy/bCz8nZ8Jl+5Lx+b2xZxl+Eor
         w5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gDALH1LBbhi9Y7gQ8eErUzmJUJ1kd3iAMb/qez5kxcs=;
        b=H2dM4tFWI3HyqP9RSN2isBNEPYU4lng2h+H95+NkEtprf0YNHcsCNpc6bJ3npbXtEf
         KQ9439aKIkQTT9Yd0RHsLyrRPKfoS4iA/jMii5I7nTXUKCkqnPTlCGrAH6r+uZPJINFN
         HZZIV3wxrdlpbTaUhGwq/EZntDDSJrEXWgRAamYQx3w/wGRASBVbMiqq29yIvMuWPoWv
         GBsMSoXCCqDwRlLKtqD/a8Q+XPeQyiWiOCrcm5K1W0T60nuVTnvonhHZ/F2HRekyksJQ
         bj5WIsN/a6tKBZyXYbWzaYzZyp4CLOtKYWA2ZskcfP0u39UvkXM6sISXZj//kWDKyZze
         V6SA==
X-Gm-Message-State: APjAAAVCveU384Er/hNlMLD9M7LAMBRkrthBHWkn3lFTODaStc7VPUI3
        EF9KJWIoMbul/43skAZCTqPZ6g+l
X-Google-Smtp-Source: APXvYqz3V5Vk5x+FIf12+jsNaGJQrfDBLBRpUm7ZB6mLNL8jaZF83U9H7rZqvmU2qPIUaFaKQr8t3A==
X-Received: by 2002:a05:6000:14b:: with SMTP id r11mr1681937wrx.58.1569485507938;
        Thu, 26 Sep 2019 01:11:47 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id x129sm2136914wmg.8.2019.09.26.01.11.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Sep 2019 01:11:47 -0700 (PDT)
Date:   Thu, 26 Sep 2019 10:11:46 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Pacien TRAN-GIRARD <pacien.trangirard@pacien.net>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] platform/x86: dell-laptop: fix broken kbd backlight
 on Inspiron 10xx
Message-ID: <20190926081146.f4f26kun7ekwqsgj@pali>
References: <20190925082149.yjhmmb64i4h6sddi@pali>
 <156940489220.8635.14349142383780268583@WARFSTATION>
 <CAHp75VfkL3QGXYjeEEqr75SWCKo1SDEqS9q3YEQWYM4iXbUzcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VfkL3QGXYjeEEqr75SWCKo1SDEqS9q3YEQWYM4iXbUzcg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 September 2019 18:06:40 Andy Shevchenko wrote:
> On Wed, Sep 25, 2019 at 12:48 PM Pacien TRAN-GIRARD
> <pacien.trangirard@pacien.net> wrote:
> >
> > This patch adds a quirk disabling keyboard backlight support for the
> > Dell Inspiron 1012 and 1018.
> >
> > Those models wrongly report supporting keyboard backlight control
> > features (through SMBIOS tokens) even though they're not equipped with
> > a backlit keyboard. This led to broken controls being exposed
> > through sysfs by this driver which froze the system when used.
> >
> 
> Pali, are you okay with this one?

So the real problem is that kbd backlight is not broken, but rather
laptop is without backlight keyboard? I thought that just API was broken
and keyboard backlight needs to be configured somehow else (via
dedicated buttons, etc...).

If yes, then I guess that check for quirk should be in kbd_init()
function which do detection if keyboard backlight is present or not.
And better name for quirk could be "kbd_led_not_present"...

> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=107651
> > Signed-off-by: Pacien TRAN-GIRARD <pacien.trangirard@pacien.net>
> > ---
> >  drivers/platform/x86/dell-laptop.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
> > index d27be2836bc2..ffe5abbdadda 100644
> > --- a/drivers/platform/x86/dell-laptop.c
> > +++ b/drivers/platform/x86/dell-laptop.c
> > @@ -33,6 +33,7 @@
> >
> >  struct quirk_entry {
> >         bool touchpad_led;
> > +       bool kbd_broken_backlight;
> >         bool kbd_led_levels_off_1;
> >         bool kbd_missing_ac_tag;
> >
> > @@ -73,6 +74,10 @@ static struct quirk_entry quirk_dell_latitude_e6410 = {
> >         .kbd_led_levels_off_1 = true,
> >  };
> >
> > +static struct quirk_entry quirk_dell_inspiron_1012 = {
> > +       .kbd_broken_backlight = true,
> > +};
> > +
> >  static struct platform_driver platform_driver = {
> >         .driver = {
> >                 .name = "dell-laptop",
> > @@ -310,6 +315,24 @@ static const struct dmi_system_id dell_quirks[] __initconst = {
> >                 },
> >                 .driver_data = &quirk_dell_latitude_e6410,
> >         },
> > +       {
> > +               .callback = dmi_matched,
> > +               .ident = "Dell Inspiron 1012",
> > +               .matches = {
> > +                       DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > +                       DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 1012"),
> > +               },
> > +               .driver_data = &quirk_dell_inspiron_1012,
> > +       },
> > +       {
> > +               .callback = dmi_matched,
> > +               .ident = "Dell Inspiron 1018",
> > +               .matches = {
> > +                       DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > +                       DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 1018"),
> > +               },
> > +               .driver_data = &quirk_dell_inspiron_1012,
> > +       },
> >         { }
> >  };
> >
> > @@ -2040,6 +2063,9 @@ static int __init kbd_led_init(struct device *dev)
> >  {
> >         int ret;
> >
> > +       if (quirks && quirks->kbd_broken_backlight)
> > +               return -ENODEV;
> > +
> >         kbd_init();
> >         if (!kbd_led_present)
> >                 return -ENODEV;
> > --
> > 2.19.2
> 
> 
> 

-- 
Pali Rohár
pali.rohar@gmail.com
