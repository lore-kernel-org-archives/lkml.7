Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC76C3A5A3
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 21:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B90A20674
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 21:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kGmCMbR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbfHXVSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 17:18:15 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45987 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbfHXVSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 17:18:14 -0400
Received: by mail-ot1-f66.google.com with SMTP id m24so11866744otp.12;
        Sat, 24 Aug 2019 14:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fC0UloVJVd7/NU/uEaCTd2LLUTCDIdGGkP7UNozA/vg=;
        b=kGmCMbR7sxG2Q8arZgcNRhhxUCcaNY2s4M5AYWXatkqZrkrTiw/az6vmKkeQ+y9dEc
         v/tuz6wuTkTI+rnsAVPp40XfYO2EoxITAIk1/RQOMwzzCZGZD/2BHWKJxT8XClRRv/xK
         ZTOEXs62AfMNAwgwqtj2J57M+qDI1UHhG4F+4rTJDFWLkOf/8DAj9PCcuxoVKAYCXgG0
         PY/sPTQrqZbxlgZ6vUvOlcRkZcYcbvnEVu+pC+dgYb71mZ5gNgMbJtsMCquMhVKBtRE5
         4gdy1e76nRnZBVcr8neWFQ3hJ8x4zUEq36HSDhNvg07d4h00Jx5DyUsC0mVfkfTEt393
         c1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fC0UloVJVd7/NU/uEaCTd2LLUTCDIdGGkP7UNozA/vg=;
        b=V5hSO8RjJpdkcXh1T1UhO4frhJE9cxpXN+f9DkYOS1XIMLPJcJcatUJIrDXZRal18Y
         2UGSpDvLnhFPTRzo+SQ6cDtDE+iRcdLxUhyuim99wl/MPCkV1e7QNEWj6nS7UQKMro0E
         KX5vyAMlwNlpUg15A16RgSb6glSRRu3TuXYFP0S9c5KJteXu5jR+Nf71W68W7j//pCJ/
         EzjpR++s5aGHw469SF2OtNITAqmaGjDlgZka4xsFhdZczezmjBHDxo7t1JZkXra8E+/V
         zB9RAl1Thae8vqGH4kk3gVY8V9mHoWlphXUKiXOR4M4f1xv6BZOdfF+TbXl1AuypksZy
         8HeA==
X-Gm-Message-State: APjAAAUwqXaClXtfsJ629Azgf5JaXnz+tkkAsMCDGBFTXbLAZuhh8zAe
        +hkd3oPXVenOTWOqZFAW2IpTgEwGZEXoS62PEn0=
X-Google-Smtp-Source: APXvYqyc9UMrt0FZO+Czm5ynmHfnj9YArOYB/nd6DV6XFFx7to8SEBFvn4jOe+dwqxaAVKBg8HIXBX6GFOg3lVZAIRY=
X-Received: by 2002:a9d:7b44:: with SMTP id f4mr895020oto.42.1566681492890;
 Sat, 24 Aug 2019 14:18:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190824184912.795-1-linux.amoon@gmail.com>
In-Reply-To: <20190824184912.795-1-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 24 Aug 2019 23:18:01 +0200
Message-ID: <CAFBinCCkEE8==-Sqqj_=Ofnx7_H-970dETwEmEPohs74806ZMw@mail.gmail.com>
Subject: Re: [PATCHv4 0/3] Odroid c2 usb fixs
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

thank you for the patches

On Sat, Aug 24, 2019 at 8:49 PM Anand Moon <linux.amoon@gmail.com> wrote:
[...]
> Anand Moon (3):
>   arm64: dts: meson: odroid-c2: p5v0 is the main 5V power input
>   arm64: dts: meson: odroid-c2: Add missing linking regulator to usb bus
>   arm64: dts: meson: odroid-c2: Disable usb_otg bus to avoid power
>     failed warning
this whole series is:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
