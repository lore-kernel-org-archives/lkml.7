Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB1BC33CB8
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 07:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB5A217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 07:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfK2HeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 02:34:22 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43005 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfK2HeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 02:34:21 -0500
Received: by mail-ed1-f67.google.com with SMTP id e10so4860682edv.9;
        Thu, 28 Nov 2019 23:34:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GFt0Cmb0a1kRp5wwWCragfEc3sNuRvk3PTWifHDArig=;
        b=Uap7SQHfc0sbWAmfcTq417dzCNiP9RnHAfzoMnydV32Ecg50AzRq4PCKz2lYc2E06e
         5fJp18u+6B52SyAjpQzGBMF95iWOcqkwA7yIqNqRcEK9GmDYMhEHUnNahQDn3Be/au2i
         uj1ctAEAr/sa1pNcc5dnSs6MJAM4uoY7F7dcj9QTb6DjTUQaoGQHcUspK4xm1/8gvKbD
         WPDUwo9K1tlU8UR7g28lofecQp0W7KMKRvrcjerD/enujuvfgPAU6zb/B4mNCNYB96xr
         efE7cKmR+36Opyd0TlpjLNBiDaicLduv7R+GkD7XSrNI4rhr8s+kzPmNJOsLB3GAQ+8A
         vGxg==
X-Gm-Message-State: APjAAAWnqvVhks8QHkDg3cm8FoQlytSKFRyO4ls06csDAvgsHjM+wDXl
        zHLeYCyaVRGj8/ah0xx7GCSmIxrOFk0=
X-Google-Smtp-Source: APXvYqy0+6aLRp42RkHD0ujD4B7a37asn//HKdn/MKrjaIxHS2BT5bdL9E7jRqg5jpENvBR7diqwAA==
X-Received: by 2002:a17:906:f191:: with SMTP id gs17mr59511844ejb.207.1575012858688;
        Thu, 28 Nov 2019 23:34:18 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id df3sm1033861edb.1.2019.11.28.23.34.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2019 23:34:18 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id b18so33810329wrj.8;
        Thu, 28 Nov 2019 23:34:17 -0800 (PST)
X-Received: by 2002:a05:6000:11c6:: with SMTP id i6mr2401488wrx.178.1575012857752;
 Thu, 28 Nov 2019 23:34:17 -0800 (PST)
MIME-Version: 1.0
References: <20191126110508.15264-1-stefan@olimex.com> <20191126162721.qi7scp3vadxn7k2i@gilmour.lan>
 <0c1d7377-7064-f509-ffc5-bd1e8f2fbaa8@olimex.com> <20191128103301.vjpkvjscy45ycgwg@gilmour.lan>
 <1e0509cc-4afc-d46f-84a9-5e54c60c9d7b@olimex.com>
In-Reply-To: <1e0509cc-4afc-d46f-84a9-5e54c60c9d7b@olimex.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 29 Nov 2019 15:34:04 +0800
X-Gmail-Original-Message-ID: <CAGb2v67Dt1=2PMg6mgn5OUumrtgmvwnTFxFqrWjD-VcxWyVwRA@mail.gmail.com>
Message-ID: <CAGb2v67Dt1=2PMg6mgn5OUumrtgmvwnTFxFqrWjD-VcxWyVwRA@mail.gmail.com>
Subject: Re: [PATCH 1/1] arm64: dts: allwinner: a64: olinuxino: Add VCC-PG supply
To:     Stefan Mavrodiev <stefan@olimex.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 3:22 PM Stefan Mavrodiev <stefan@olimex.com> wrote:
>
>
> On 11/28/19 12:33 PM, Maxime Ripard wrote:
> Hi Maxime,
> > Hi Stefan,
> >
> > On Wed, Nov 27, 2019 at 09:07:40AM +0200, Stefan Mavrodiev wrote:
> >> On 11/26/19 6:27 PM, Maxime Ripard wrote:
> >>> Hi Stefan,
> >>>
> >>> On Tue, Nov 26, 2019 at 01:05:08PM +0200, Stefan Mavrodiev wrote:
> >>>> On A64-OLinuXino boards, PG9 is used for USB1 enable/disable. The
> >>>> port is supplied by DLDO4, which is disabled by default. The patch
> >>>> adds the regulator as vcc-pg, which is later used by the pinctrl.
> >>>>
> >>>> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
> >>>> ---
> >>>>    arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts | 4 ++++
> >>>>    1 file changed, 4 insertions(+)
> >>>>
> >>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> >>>> index 01a9a52edae4..c9d8c9c4ef20 100644
> >>>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> >>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> >>>> @@ -163,6 +163,10 @@
> >>>>            status = "okay";
> >>>>    };
> >>>>
> >>>> +&pio {
> >>>> +  vcc-pg-supply=<&reg_dldo4>;
> >>> The equal sign should have spaces around it.
> >>>
> >>> Also, can you please list all the bank supplies while you're at it?
> >> Sure. Should the supplies defined as regulators names be added also to the
> >> pio node?
> >> For example reg_aldo1 is named "vcc-pe".
> > As far as I can tell, the A64 has regulators for PC, PD, PE, PG and
> > PL, so you should list those (PL being under r_pio)
>
> After quick check I've found a bug (maybe?). It's not possible to specify
> vcc-pl-supply, because of this:
>
> https://elixir.bootlin.com/linux/latest/source/drivers/pinctrl/sunxi/pinctrl-sunxi.c#L778
>
> During the probe of the pmu, the pinctrl tries to get a regulator, that
> doesn't exist yet.
> Because of this the system doesn't start (as expected).

It's a circular dependency. The pinctrl driver requires a regulator, which
is provided by the PMIC, which requires the pinctrl driver to mux a pin
for the bus.

For now there's no way to fix it, other than breaking the dependency.

> I've tried to ignore -EPROBE_DEFER. This seems to work, but only because
> the regulator for
> PL is defined as "regulator-always-on". The problem is that the refcount
> is not incremented.
> So if you export one gpio and the unexport it, the regulator will be
> disabled. I'm not sure
> how this can be resolved.
>
> Should I skip vcc-pl-supply for now and list the other bank supplies?

Yes. That is the preferred and probably only way to deal with it.
Please leave a comment saying why vcc-pl was skipped.

ChenYu

> >> Also, since the commit message will be different for better representation
> >> of the changes, should I send the next
> >> patch as v2 or as a new one?
> > Either way works for me as long as the commit message matches the changes.
> >
> > Thanks!
> > Maxime
