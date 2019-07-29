Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CBDC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A8E2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Sxm6JuVI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbfG2VqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:46:04 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35711 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbfG2VqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:46:03 -0400
Received: by mail-oi1-f193.google.com with SMTP id a127so46370739oii.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N3q7xJdwh8PFVLuqry097P3Xvdg3K97aXzT+h+VJXcs=;
        b=Sxm6JuVIa/VBOyYU6R6afowaBbcZWBLQ8edTLaMy6eWWGnu2Do83jIjFSm89RTjzLQ
         WNcZYaXlNOS1PN98f4DahJMh63AQ54FoFxJyE8SGfv08OEpnF+XHgHKz1NpvWKuurj3s
         uRo6TgOuKm0klWbvezGd+QDPTLlLkmywlgospjfgk5xrWKas/gu25VksFkXytRpBjemG
         8lEbYNCYq/Qw9xroqwUx9dGGV1OVktApy0a++h+hf9a11R2CrgkyyH7ZMRRPA+0F82m3
         wepW205mRdVUF6qELog6dHXbdBJzGJFNDHBIIlBIXbow1EsTA8UFXLDw8fm2efcoMP04
         7b5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N3q7xJdwh8PFVLuqry097P3Xvdg3K97aXzT+h+VJXcs=;
        b=qZrSJpl4JkzaFojDfIyDeUWvZqmZkhhoo0W6Qb4UDDvej4592oD8lm2BfNvj7Z9mC9
         NEpqP10FzsoSdsYNtAM1AVuazirnVo/Y0xqgaBYogQL+oLsps6totQii2IT83ITkjJ41
         KNZwlB6l1qmzIMHuJs5qIqQGJ6SB1b7svQsqHOEyqUtYQEoCK2avMUcPtqsUrbCGRpaF
         jfuS+jOTfXBcm2szfR4iofoYVhuiW6G+Bd5AkxpG3HvtQH/Ax/eC36aVf4Y1qAMb5cEM
         y7v2lP10BYpe/VP/bD2UQD9DSI6Z9LBEA6m3xbjmwuEy/R6EXVCwDtJFB3KahjubJogs
         7U8Q==
X-Gm-Message-State: APjAAAWVn2OgpqsyzL4N/sTuvRJ2zyM9LCrbiE1qXuHF3wauXMs2xXv1
        9jGdYnVog9wgHis+uRpBmzAdVfN0aixBF3SbUJ4=
X-Google-Smtp-Source: APXvYqzH9o6vMPXW5m2jTBkNKSzRv8Plc0jl6T3q9UDoCcIxmNEvygjudEsgt5EPfe13VReOdigLLl5CWKltcKD27jY=
X-Received: by 2002:a05:6808:8f0:: with SMTP id d16mr57350197oic.47.1564436762794;
 Mon, 29 Jul 2019 14:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190727194647.15355-1-martin.blumenstingl@googlemail.com>
 <20190727194647.15355-2-martin.blumenstingl@googlemail.com> <9814939f-8580-c8f6-5c2f-7e64db60e6ae@baylibre.com>
In-Reply-To: <9814939f-8580-c8f6-5c2f-7e64db60e6ae@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 29 Jul 2019 23:45:51 +0200
Message-ID: <CAFBinCC5Bz-Oe4G1dtABrU+RFWUmqpdgyuDdRPp=Mo_Cucz7Wg@mail.gmail.com>
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

On Mon, Jul 29, 2019 at 9:11 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi Martin,
>
> On 27/07/2019 21:46, Martin Blumenstingl wrote:
> > Amlogic's BSP kernel defines that all boards with a MAC address stored
> > in the eFuse have it at offset 0x1b4. It is up to the board to
> > decide whether to use this MAC address or not:
> > - Odroid-C1 uses the MAC address from the eFuse
> > - EC-100 seems to read the MAC address from eMMC
> >
> > Add the nvmem cell which describes the Ethernet MAC address. Don't
> > assign it to the Ethernet controller, because depending on the board the
> > actual MAC address may be read from somewhere else.
> >
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > ---
> >  arch/arm/boot/dts/meson8b.dtsi | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
> > index 30fca9bb4bbe..c7de58b71d08 100644
> > --- a/arch/arm/boot/dts/meson8b.dtsi
> > +++ b/arch/arm/boot/dts/meson8b.dtsi
> > @@ -402,6 +402,10 @@
> >       clocks = <&clkc CLKID_EFUSE>;
> >       clock-names = "core";
> >
> > +     ethernet_mac_address: mac@1b4 {
> > +             reg = <0x1b4 0x6>;
> > +     };
>
> Is this a fixed position for all boards ? if not, I'll suggest moving
> it to the odroid-c1 dt until you have more users.
the 0x1b4 offset is hardcoded in Amlogic's kernel sources
if some board uses another offset then the manufacturer had to patch
the kernel to make it work (like Endless did)

+Cc hexdump0815 - can you please run the following command on your
Meson8b MXQ board:
$ hexdump -C /sys/bus/nvmem/devices/meson8b-efuse0/nvmem | grep
000001b0 | cut -d' ' -f7,8,9,10,12,13

this should print the MAC address that is also used by the stock
firmware and/or printed on the board
if it is then I'm happy to provide a patch also for your MXQ board so
it also uses the correct MAC address


Martin
