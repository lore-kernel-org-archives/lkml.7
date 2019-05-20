Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE43DC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15E720863
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gmI2WSwZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfETSFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 14:05:17 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43244 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfETSFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 14:05:16 -0400
Received: by mail-oi1-f196.google.com with SMTP id t187so10679842oie.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 11:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sqegw++Yw9W0senX8mZTb0hrOapXpOg1QLniaiwM7Vo=;
        b=gmI2WSwZdASnVy5GAPRxwVNe9ATPQyv5f3tewWssV57Rz/5OlchcFxDcUPh4s5pe1m
         4Qtmnyz44KZ5CyIeovQ+G2uRFCqsePreMPvZl6jxj19iQ5CwQqd52ca+mXWUuyc6uNPp
         v3iI5d5v1WOXCO9h8zq9A7vcFclv2o5iN2DaDYk9apSSXB9ZJ4E9Avnwufyb0zy24PtS
         gjsWJ0ez4jerYdKcx3UDerwvoFAeSfyX+J8XeyQquvYDnhTXK9OTCwk/tG70XtSzMdeI
         Fow6mAvapkp9RA2syZp48mhZwzILKTlrWVOrUn7a3jjVBmWZgGupVui/YCMxKEQGiibc
         MKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sqegw++Yw9W0senX8mZTb0hrOapXpOg1QLniaiwM7Vo=;
        b=Mmwhl3l+z7SIGx7CoQERwmmYKA7Bxme+f3ywM6ZWulKfyzCMme50x9puuvFy1oCXth
         Sct5fodT5NpJmvVcJjt8i1JfFphGqPN4uuNhJlmdC3VG7Rxo2QA1uud8vjBzMA6k1fmY
         pM6mKJMqjYya2CTGOGyk7Ot6ykB8kWmA7xTzdJR4n0JqKb6LNYFPNuvR+XGwi3hwS3oo
         z9JjmREJphWAIVCvXE4zsSxiKgW0/W8E5M70ZC+pH+pQZfIVTKh99V26c/pbC1txFVhv
         5c49Z8Pt6SyBI8DlJmCOkIghD0FGgeUw38h79jSmVzEi6Qyyrx5vxAJ2plmHKFzRSdxj
         GChQ==
X-Gm-Message-State: APjAAAXq+OMEDv/1nIbhFoo5Qgh9dWiG87oIljugN/L8UXgp+JFmGiqg
        LtK7Ef2Rf3JLxJ8eGfSBQJCNH6CMdNVpb9MS6pM=
X-Google-Smtp-Source: APXvYqy5wrpiF0Oa7atFdm07772NlHGHpDzWywsOAOFzEgmadfaQe9V+SUAWUu2O7uDlntw1Oj2zjL0GOE0plQd4DLc=
X-Received: by 2002:aca:5b06:: with SMTP id p6mr312861oib.129.1558375515793;
 Mon, 20 May 2019 11:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190520143812.2801-1-narmstrong@baylibre.com> <20190520143812.2801-4-narmstrong@baylibre.com>
In-Reply-To: <20190520143812.2801-4-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 20 May 2019 20:05:04 +0200
Message-ID: <CAFBinCAdruBA0MygM3iCOsMT3L=ncuuXK_MVPEFD7FK=Vu0BBQ@mail.gmail.com>
Subject: Re: [PATCH 03/10] ARM: dts: meson6: update with SPDX Licence identifier
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, May 20, 2019 at 4:39 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm/boot/dts/meson6.dtsi | 44 +----------------------------------
>  1 file changed, 1 insertion(+), 43 deletions(-)
>
> diff --git a/arch/arm/boot/dts/meson6.dtsi b/arch/arm/boot/dts/meson6.dtsi
> index 65585255910a..39903172ea7c 100644
> --- a/arch/arm/boot/dts/meson6.dtsi
> +++ b/arch/arm/boot/dts/meson6.dtsi
> @@ -1,48 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0 OR X11
I believe this should be GPL-2.0+ OR MIT as explained in [0]


Martin


[0] https://patchwork.kernel.org/patch/10951479/
