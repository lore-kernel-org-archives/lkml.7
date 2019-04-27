Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6787C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 20:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735352077B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 20:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HwsHKR6O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfD0UVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 16:21:04 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46760 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfD0UVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 16:21:03 -0400
Received: by mail-ot1-f65.google.com with SMTP id s24so5484409otk.13;
        Sat, 27 Apr 2019 13:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n8Sb3tDJVImkB0zIvqUNX/1u9RCQM+Iqq9MF+QaVX+o=;
        b=HwsHKR6O7oYk6gzDrFLWDWr00L+GargDSoGdxBfjtZOR8CBR3KidRbmiylzrgQHwxm
         MJ/Xnr45lPAcbOQj6p/l1s7U55IPUx5uCo+gRTp9nF41i2vlxKoRreX7EShpj7z8XdfT
         34nursl4YBNh16tgdb34l83xRQUqmbdHPQNWUT6KkR2dUApVNTTpDTyWyJWOgOY8iEYy
         ervKIWZ3WRu3RlaPDfOmm9PSmP8uLy/r2PGgoX59NyeuVL9o3pHSknvkeinla7xsj9HH
         PMHwMEfIrc/s1zTmgDbsr0gCJKnFHRb25iDYU0rdM4zutJgNNYX3J94RY87mHWKdSCb7
         7zPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n8Sb3tDJVImkB0zIvqUNX/1u9RCQM+Iqq9MF+QaVX+o=;
        b=itpPW8TtccnOKTfQBsh4YOXJMqKo2isqiGn4Th5H2exBbShXGCsHOvAgkbuWsp5pps
         VoWpm8BwN2Ah87ps2b8nXtVIZhmbe7HjjUjPAfyv4S5nMr3R9tWJIs9Zo6QW+OsHBL+d
         G1RKuSyYIU5vJv3Kj7isbo6bPvvXsSnxuT09sbQ/tZOlKIB4qoylCxhLB0qqaKIK8trS
         fHNaVb2DqY+Q5hHWn/taTKaQkVjvZ6io8HU2ip0Qg+Y0AnhE3cA/pn0x71jUV7BTrEQp
         fjMXVfKG4HSdNIrf+JsjyV1l6vQcGHMs1nSCj76NCrYn7tc+zgbTyAm3jZDARt/QPhT1
         005A==
X-Gm-Message-State: APjAAAWBtfKhskGYmwgFM0m+EVZEYqxjOK7zOv839GTbPg0jAP4AjjPa
        QNvaaGLMWZg6rIBKP28yX3rTcCKNsbXUNVu9Qa8=
X-Google-Smtp-Source: APXvYqywHHIypHdHq0I41rAZEA+6VJ9TxGQ+E16M1jSVmeWMFHtvuuU+DN61Bjd+1sPF5MYTnsCJUcorqrRMGVgg0i0=
X-Received: by 2002:a9d:5e90:: with SMTP id f16mr31076242otl.86.1556396462982;
 Sat, 27 Apr 2019 13:21:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190423091503.10847-1-narmstrong@baylibre.com> <20190423091503.10847-3-narmstrong@baylibre.com>
In-Reply-To: <20190423091503.10847-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 27 Apr 2019 22:20:52 +0200
Message-ID: <CAFBinCBHDf8N7J5C7SkCF44k+-H686EYbK9zm6TOg_oUWJ+vTw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] clk: meson: g12a: Add support for G12B CPUB clocks
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 11:15 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This patch support for the specific Amlogic G12B clocks.
>
> G12B clock driver is very close, the main differences are :
> - the clock tree is duplicated for the both clusters, and the
>   SYS_PLL are swapped between the clusters
> - G12A has additional clocks like for CSI an other components
>
> Here only the cpu clock tree is handled.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

while reviewing I used the public S922X datasheet from hardkernel to
verify the implementation.
I noticed that HHI_SYS_PLL_CNTL1  and HHI_SYS1_PLL_CNTL1 seem to have
a 19-bit fractional part for the sys_pll and sys1_pll clocks.
Neil, do you know more about the fractional parts on these clocks?


Regards
Martin
