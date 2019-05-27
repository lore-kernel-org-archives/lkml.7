Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470DBC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 17:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D1120883
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 17:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="TlKlSZ39"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfE0R72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 13:59:28 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43212 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfE0R72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 13:59:28 -0400
Received: by mail-oi1-f193.google.com with SMTP id t187so12408801oie.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 10:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EJGfKoNTtpHONAVVUy19xvP3ls9YinFzlhtPvuaaZVE=;
        b=TlKlSZ398+uKs8zrRJn+n5ZCxMASWZOWoRpwb/v1xRubZfj4EfH4TbS1Im4gJ3BxlW
         RS/MfkHzp0Y0zDIu44W/ZwMUbHjuC8TeawiGy6x1dpyNpKF2ltyoxFXHfYZnpTZU9H2z
         EI2jcg7Iifru4vK1s0ED8+JY1Jf5l4rGEy4C82b6A9p/x6iNPchqKyEAKBBKzPxzJaD0
         dxmaZai1MYO5bpF2MznXexA1FneahbyAbk3l07g+TvKj02TnsMkf4kGzJh7R2h0LdS/x
         gK0adkSqtjqbTC08gpj96V+YKrIs7pTOvpKH2ukDKFKcbII7X1bPmNzLp6aQWMFgQk9/
         0GWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EJGfKoNTtpHONAVVUy19xvP3ls9YinFzlhtPvuaaZVE=;
        b=IoFE0PPZsMzhNI/zKWkk2NPotDXJLW2oOzo2Q7/yljL9nvkXJRNsfzyAJl2Diy/zCd
         GHuI4lFHUCguOU2kxTZsx+mQ6x0uKALN3a20SjpoV80PQkKKorwFWB5gYLPC9SaJnmhI
         c0tDFZ3UsmoTcqXW1dOfYUFtNfdH31mB8dQWOEYkdpKbvSfkbuIhpudhMtvJTxu5XZ7n
         pAh2R+sdH4BXlhYbU7XKuS2H+suimwwktfVT8HuJaxArsvym4yqeh5194jWt5N6v8K+B
         8f5psmq46wK4bt12/+qbyjqgLYBpegvmzr54O10Ir19k35Glh+2WproIzZBkMjuoKMFG
         h/Pw==
X-Gm-Message-State: APjAAAWqXkAbmp7etPrC+ZWVmHP2ka1/9C3mBnJ91EztK3u58xnImPuJ
        ILwP735l2/X5iJbcyeqA1lfHewrPk4xb5HF7p64=
X-Google-Smtp-Source: APXvYqyztf2KYxq0XQAdm49QKiZVOTLlyp/9w5kkaygaCobcIDARngGgN8JL9uLHbk6VK7SzwYqlTkjQZchECqhZCkY=
X-Received: by 2002:aca:3545:: with SMTP id c66mr110836oia.129.1558979967712;
 Mon, 27 May 2019 10:59:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190527125059.32010-1-narmstrong@baylibre.com>
In-Reply-To: <20190527125059.32010-1-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 May 2019 19:59:16 +0200
Message-ID: <CAFBinCBJO3J1wG1wa6X26VT6yGT_c_1XHOPiPpMRZGW8KKxopg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: meson: g12a: Add hwrng node
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 2:51 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The Amlogic G12A has the hwrng module at the end of an unknown
> "EFUSE" bus.
>
> The hwrng is not enabled on the vendor G12A DTs, but is enabled on
> next generation SM1 SoC family sharing the exact same memory mapping.
>
> Let's add the "EFUSE" bus and the hwrng node.
>
> This hwrng has been checked with the rng-tools rngtest FIPS tool :
> rngtest: starting FIPS tests...
> rngtest: bits received from input: 1630240032
> rngtest: FIPS 140-2 successes: 81436
> rngtest: FIPS 140-2 failures: 76
> rngtest: FIPS 140-2(2001-10-10) Monobit: 10
> rngtest: FIPS 140-2(2001-10-10) Poker: 6
> rngtest: FIPS 140-2(2001-10-10) Runs: 26
> rngtest: FIPS 140-2(2001-10-10) Long run: 34
> rngtest: FIPS 140-2(2001-10-10) Continuous run: 0
> rngtest: input channel speed: (min=3.784; avg=5687.521; max=19073.486)Mibits/s
> rngtest: FIPS tests speed: (min=47.684; avg=52.348; max=52.835)Mibits/s
> rngtest: Program run time: 30000987 microseconds
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
