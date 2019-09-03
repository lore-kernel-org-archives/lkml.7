Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44829C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D66221897
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HzRKecXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfICTDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 15:03:16 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43817 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfICTDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 15:03:15 -0400
Received: by mail-oi1-f193.google.com with SMTP id t84so3899629oih.10;
        Tue, 03 Sep 2019 12:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y+QuqQ5++lkMqKXAYS/qi7zuU0EGpIbrM4hWDE1pS1I=;
        b=HzRKecXRQc4ExW+83ZEnLKUXuhrCgR06x+QKiDNatgm0jYlBQc+fPxZhAdJJ2fbjDi
         Z1rKhL4a3zU7OAJEaiAlBLfDYxb1jd+sEqab69iiJ9hJJm27ERx8N+o5cZn6qnoej8MS
         AMvP9/ELOTmp3KfjXISKJF0L1R9C+GKMxP2G3Q6XPv35Jchy303oNe/fmRIum69ZaEPm
         CBO9fKUKGDkpU/xju9GsKxst5O489aKBQK/V63U+vT2N3fRd8mO0kOhUylXQttBJw7wk
         +jRbcG921YoSp4VgLI4JCx9iyLomJZ0NfXJHOIx1wkJ87vs6l63nXZG/sXXQsHMGMXnf
         bZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y+QuqQ5++lkMqKXAYS/qi7zuU0EGpIbrM4hWDE1pS1I=;
        b=fnphn21QPok3PvOixvfpr5RIvZN9GSeax68yoYBftbxq70xxaW5cFQXaEbxxFYB5B9
         V6PGfJ9xA4fhnjWptnyulgrIu+fvagrci6PjjSX2k7eeNNxEmbFguyQw9JWYtGSw5JJt
         X6vQaokBWGscdT01zoPu1vgyN5KBuFslq6oT1iMccAkaPR+wXi/gUOOSb7/fiLF3kG+q
         jBwb5MbwG6t27YGkRzSt2fA+/2osWuKrCA1gzlDoPP7lTIH7XoelHfINALcHPQQUC7eC
         yazvDq7e3FkL5qeA2mge28GrkTDl+sZd9erUKRHSFfBzNIOa0LSNZ/7+6SqzqO3ypT3q
         XpRw==
X-Gm-Message-State: APjAAAU4rKV4yNmjOqJwE9C3qbhLryjnOwadZ4NVeCmzZvN5pYT9Xpo2
        RWGOvvzRutQpRBI1tMBHp9wbbEUHahwY5Eki18c=
X-Google-Smtp-Source: APXvYqwwUFNlfZebjM0zqVSX8dnNMtHXyb2ra3QenhJNz0G1ArgBXYzzOe9IIQBqxw3GDmpjOcvMWXXUIO6FHm0Clv4=
X-Received: by 2002:aca:574c:: with SMTP id l73mr615459oib.47.1567537394795;
 Tue, 03 Sep 2019 12:03:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190902085821.1263-1-linux.amoon@gmail.com> <20190902085821.1263-2-linux.amoon@gmail.com>
In-Reply-To: <20190902085821.1263-2-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 3 Sep 2019 21:03:03 +0200
Message-ID: <CAFBinCDSbWedtH6mtdyw2Oy3ZxHU160-NUMa3nBXn4B9BJ--pg@mail.gmail.com>
Subject: Re: [PATCHv2-next 1/3] arm64: dts: meson: odroid-c2: Add missing
 regulator linked to P5V0 regulator
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On Mon, Sep 2, 2019 at 10:58 AM Anand Moon <linux.amoon@gmail.com> wrote:
>
> As per schematics VDDIO_AO18, VDDIO_AO3V3/VDD3V3 DDR3_1V5/DDR_VDDC:
> fixed regulator output which is supplied by P5V0.
>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
one comment below, but overall this looks good:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[...]
> +       vddc_ddr: regulator-vddc-ddr {
> +               compatible = "regulator-fixed";
> +               regulator-name = "DDR3_1V5";
I prefer if the node name matches the regulator name, so in this case
I would write above:
  ddr3_1v5: regulator-ddr-1v5 {


Martin
