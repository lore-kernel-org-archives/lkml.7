Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6719C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B1320B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fPeG/D4H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbfHETQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 15:16:26 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43972 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbfHETQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 15:16:26 -0400
Received: by mail-oi1-f196.google.com with SMTP id w79so62980654oif.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 12:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SB9PCM35FSWuVi9z7hK4WLl0EufG465Q6bcQ2wNo7bY=;
        b=fPeG/D4Hqu47BMZb3UOQ87U5iajC3QZ4ivfrPnXbDsQoUIxO0SgtXUdhkh5QfAblsp
         0NXROtXwiO5QfX3dWJ5LtPE4SYREbzWPFv2HnQGbJ1WShc12rv5wtcnMFqDVeiLhcVcs
         Yy/BK/5cBrp1ZCVL1mQlZM5UCijWZEzZvrujG56PKPSeKUT507lxmVxNXSCNDJ2KYCvC
         Vw3dPfLw6HQX0X6GQz3F60VnbyousA9d0H49d0OdTgF1hv6M7SgNB+d+f6pUxPpSgi5K
         tGuAWJGFX67j+WG7qexUfiQc8rTs1qrcwADWRRiYXkLxTqP4Em8za0IEtQQwxzRR5+nZ
         z0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SB9PCM35FSWuVi9z7hK4WLl0EufG465Q6bcQ2wNo7bY=;
        b=o3Pd6UXI9BnHLTHvxXqHa+ezhm5XnYviTrNA3jCgAkl5PFQt6kmhg7jYaZ+agnl/hb
         T0R4sWsPe/F98A6wqNKIVoFFWRhzhG3A6NiyBzS/mspGEJKgXn3mVrPPFhF366AXxq9w
         xlRJSFyWAqX7KHV+Ev+XDQ6/Me3FTqHHFRR/Jqbv8W8RJmL4sx9VlTiboFVwcULZfdf2
         ANiJs+coxxw+hFwq8NR+Qk2kcrGeO090t5WaVHejdJrQeekPbKxxdW2x1mzYtUzRTbfY
         NQZWs2ka92vJ513JkJl/mmeZwf0qiJ7KC1xTUTqp1oMOFkPEe44faNErUX78hhqlHvaq
         Oyzg==
X-Gm-Message-State: APjAAAWG7Gcbj9v9bV51oxzXCsP1wnVZ7dO4RaZp5w9ZywO6pZyFmJEU
        z07kdfv/hpEMndoJNpqWbF5QSveY/5TnI1wf0w4=
X-Google-Smtp-Source: APXvYqzFT8IoyTFbzdFGvxOVX5N3A3720NSMyOcsf0yQEULh63dB+8S3SFHt/cHpUIrbyALl7n3dlEJWHcC2bmo/1TE=
X-Received: by 2002:aca:5c55:: with SMTP id q82mr12374312oib.15.1565032584908;
 Mon, 05 Aug 2019 12:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190727194647.15355-1-martin.blumenstingl@googlemail.com>
 <20190727194647.15355-2-martin.blumenstingl@googlemail.com>
 <9814939f-8580-c8f6-5c2f-7e64db60e6ae@baylibre.com> <CAFBinCC5Bz-Oe4G1dtABrU+RFWUmqpdgyuDdRPp=Mo_Cucz7Wg@mail.gmail.com>
In-Reply-To: <CAFBinCC5Bz-Oe4G1dtABrU+RFWUmqpdgyuDdRPp=Mo_Cucz7Wg@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 5 Aug 2019 21:16:13 +0200
Message-ID: <CAFBinCASC92TbPT-WU17iXfY7VL3-h1s8Bbt2ZVpO6mpfkRN0w@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: meson8b: add the nvmem cell with the
 board's MAC address
To:     Neil Armstrong <narmstrong@baylibre.com>,
        hexdump0815@googlemail.com
Cc:     linux-amlogic@lists.infradead.org, khilman@baylibre.com,
        linux.amoon@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, ottuzzi@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 11:45 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> On Mon, Jul 29, 2019 at 9:11 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >
> > Hi Martin,
> >
> > On 27/07/2019 21:46, Martin Blumenstingl wrote:
> > > Amlogic's BSP kernel defines that all boards with a MAC address stored
> > > in the eFuse have it at offset 0x1b4. It is up to the board to
> > > decide whether to use this MAC address or not:
> > > - Odroid-C1 uses the MAC address from the eFuse
> > > - EC-100 seems to read the MAC address from eMMC
> > >
> > > Add the nvmem cell which describes the Ethernet MAC address. Don't
> > > assign it to the Ethernet controller, because depending on the board the
> > > actual MAC address may be read from somewhere else.
> > >
> > > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > > ---
> > >  arch/arm/boot/dts/meson8b.dtsi | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
> > > index 30fca9bb4bbe..c7de58b71d08 100644
> > > --- a/arch/arm/boot/dts/meson8b.dtsi
> > > +++ b/arch/arm/boot/dts/meson8b.dtsi
> > > @@ -402,6 +402,10 @@
> > >       clocks = <&clkc CLKID_EFUSE>;
> > >       clock-names = "core";
> > >
> > > +     ethernet_mac_address: mac@1b4 {
> > > +             reg = <0x1b4 0x6>;
> > > +     };
> >
> > Is this a fixed position for all boards ? if not, I'll suggest moving
> > it to the odroid-c1 dt until you have more users.
> the 0x1b4 offset is hardcoded in Amlogic's kernel sources
> if some board uses another offset then the manufacturer had to patch
> the kernel to make it work (like Endless did)
>
> +Cc hexdump0815 - can you please run the following command on your
> Meson8b MXQ board:
> $ hexdump -C /sys/bus/nvmem/devices/meson8b-efuse0/nvmem | grep
> 000001b0 | cut -d' ' -f7,8,9,10,12,13
>
> this should print the MAC address that is also used by the stock
> firmware and/or printed on the board
> if it is then I'm happy to provide a patch also for your MXQ board so
> it also uses the correct MAC address
hexdump got back to me on IRC (thank you!) with unfortunate news:
the MXQ board doesn't seem to have the MAC address in the eFuse at all

thus I'll go with Neil's suggestion and move this to meson8b-odroidc1.dts


Martin
