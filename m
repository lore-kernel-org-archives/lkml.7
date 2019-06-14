Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9831FC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 08:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 104532084E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 08:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuqPHbm9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfFNIaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 04:30:10 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:41870 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfFNIaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 04:30:09 -0400
Received: by mail-yb1-f195.google.com with SMTP id d2so748719ybh.8;
        Fri, 14 Jun 2019 01:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nzVcHF0m70Fw+qIor/h4e6MpGLGe8ekBloVHLUtwVtM=;
        b=kuqPHbm9jWzSzqRNBz098asTFfYK0VOUq+5FpWwWh3z6y8vIzdmbN4jHIJT1AKnoi/
         DWqmluxBy1qkR88hqRC53qsxCflNkUKxWdV/XJ+otdmaBVNKEhJKgPO/l/0OD20U8e0Y
         bL18x5wplBC6K9lv1VPa0S79QMnytw+QJaqrDviiMez0vOzpXEyuaK6QX44UzUKqUlbv
         6U5c49IHHv5j6vz6z/nBYcvi5hClp7cbL8V9YAc7xQYfPRjq+zYk9v7LGVDhqSb0ONq9
         CWtHyWSJP1CIWjUPA3IKWfYLb/YGMREJSNsm/MDsMt6zWBzVzQPSWlUEEXqGM2cnGFW3
         OSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nzVcHF0m70Fw+qIor/h4e6MpGLGe8ekBloVHLUtwVtM=;
        b=oxv/fyg2g799wjbAF52dDDTYWrrk8LEjYrcvFCy/OMGO8DoQ3GE2KCsDsPlTp2XcRF
         OW5JcZF5u9kPtcub83O5EVjV32WKsjKw8bjG8SRn3O4bvWYJoH3MVFdl3ymqsLoLPQyc
         gMgroKmFGP2xAhjQe0HwOa+s8AiWeAm2FwZtBCCjJKbjSJ+Dmekv7ycUav34awmT712h
         4LI6X/pl8Iwljt5PUIzXWWAW5fOhLYEuLEzy8DYpZ4KP/YIX0RoDpYfQXTrWEFl9yXwh
         pv1SoO/RGsMiTqhV8RlRRnWfjUJaaL9xeUDTUX2LDdqtzlV8TDV+P8dBxbU6/ATttrj6
         8qPw==
X-Gm-Message-State: APjAAAWmxqGSY9BeKa6nhJiOp/Gulu3u9r10hqFAYw177X3rMZ3Skb9S
        LdSKdn5LUmKBMXcPz3XV5rt4PR0k5GZhD1pVraU=
X-Google-Smtp-Source: APXvYqy2kxodppWZiVypCM4BCxN56xAjgKw4jxOCVlJIgXRgaBJbPrms6UcdTL2C9gu+ZsfB0hqWyMivsi8hKhOyo9s=
X-Received: by 2002:a25:ca8d:: with SMTP id a135mr42871828ybg.438.1560501008839;
 Fri, 14 Jun 2019 01:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190527200627.8635-1-peron.clem@gmail.com>
In-Reply-To: <20190527200627.8635-1-peron.clem@gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Fri, 14 Jun 2019 10:29:57 +0200
Message-ID: <CAJiuCcfUhBxEr=o7VVpPROQZadQh7z1QC0SkWSYt-53Sj3H2qw@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Allwinner H6 SPDIF support
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 27 May 2019 at 22:10, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com=
> wrote:
>
> *H6 DMA support IS REQUIRED*

DMA has been merged, so this series can be merge when ASoC maintainers
have reviewed it.

Regards,
Cl=C3=A9ment

>
> Allwinner H6 SoC has a SPDIF controller called One Wire Audio (OWA) which
> is different from the previous H3 generation and not compatible.
>
> Difference are an increase of fifo sizes, some memory mapping are differe=
nt
> and there is now the possibility to output the master clock on a pin.
>
> Actually all these features are unused and only a bit for flushing the TX
> fifo is required.
>
> Also this series requires the DMA working on H6, a first version has been
> submitted by Jernej =C5=A0krabec[1] but has not been accepted yet.
>
> [1] https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=3D=
89011
>
> Changes since v3:
>  - rename reg_fctl_ftx to val_fctl_ftx
>  - rebase this series on sound-next
>  - fix dt-bindings due to change in sound-next
>  - change node name sound_spdif to sound-spdif
>
> Changes since v2:
>  - Split quirks and H6 support patch
>  - Add specific section for quirks comment
>
> Changes since v1:
>  - Remove H3 compatible
>  - Add TX fifo bit flush quirks
>  - Add H6 bindings in SPDIF driver
>
> Cl=C3=A9ment P=C3=A9ron (7):
>   dt-bindings: sound: sun4i-spdif: Add Allwinner H6 compatible
>   ASoC: sun4i-spdif: Move quirks to the top
>   ASoC: sun4i-spdif: Add TX fifo bit flush quirks
>   ASoC: sun4i-spdif: Add support for H6 SoC
>   arm64: dts: allwinner: Add SPDIF node for Allwinner H6
>   arm64: dts: allwinner: h6: Enable SPDIF for Beelink GS1
>   arm64: defconfig: Enable Sun4i SPDIF module
>
>  .../sound/allwinner,sun4i-a10-spdif.yaml      |  1 +
>  .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  4 ++
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 38 ++++++++++++++
>  arch/arm64/configs/defconfig                  |  1 +
>  sound/soc/sunxi/sun4i-spdif.c                 | 49 ++++++++++++++++---
>  5 files changed, 87 insertions(+), 6 deletions(-)
>
> --
> 2.20.1
>
