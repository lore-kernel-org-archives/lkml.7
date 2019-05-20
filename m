Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159E3C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E12CB206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="d/QiLwSw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfETRta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:49:30 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45965 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfETRt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:49:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id i21so7109530pgi.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=me1hOjgWTri45Cc6hO9sgRzbDQwaWnoPUzfvVUbP8Uw=;
        b=d/QiLwSw40EjvxwHCoBy3JWseUPcQPvj4auj0c7ZAV6OKodF1NvnM2hOAOdrKopZjE
         z1TqPkMCjHuXZYkHxVjL4TRbCv8RlImwtrVTHTaQggD5Cxo9AQHwpqNUyk9RusnPyO0F
         3mU4YL7YU2vzL7rzy3003fROJc64CQMa7tAuUKK9CYwpGekMkMa20Lscc1Jz5OFTtdfj
         29jjvyM7sJ7dzn129bnFYI0dKuAdoVmheVZc9iXFeOtqJLEN9CFeqtP6W66FfPgHb3O3
         l5nF/Pt63UZNRclggayxHiMiul7NSEG7d1434MGHCWBdSMDu6YVqpR1CxE7E7wDl9R8k
         0dyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=me1hOjgWTri45Cc6hO9sgRzbDQwaWnoPUzfvVUbP8Uw=;
        b=s6mB6r50nwWduOb8hQ31cd8gMjLGBH50OW6vBe0e8caub/3Y0amTp4sqcd3wO3uv+7
         fDNPXmDCkiUP+wnM3uBtDBunxoj18UqrO/q2M0WJPVYVtAQkDQNi/FXSW9c+yCRFSftw
         9tSMZpFebPX6qziziZtVRTQU63vIqBdYxSQvS3WyViq93UGi9zzC1otnlZieLnCgNH0f
         CUd4HiHYRsoZKJ78FjpYtgeeZnjP83T/QOdAja9Q2/Jodcj0yJa2hu1ycii8hEy3OHXl
         nYSkAovol5g5rMZM0rcyKX9iwpAm+jlqcYBGHlkREDrOI6jm1eVx02ZgRUd89fpzl/aW
         Tu0A==
X-Gm-Message-State: APjAAAU1doPM4MJ/CAXhgWufhk8TEpONEgOluhyrAN1hRRuW+urnBE0x
        s4Y8M+91z7KXOITrUSMBH1pZ8w==
X-Google-Smtp-Source: APXvYqyk9OeosmdVRNKnZ4nmNCQduMXDaoErB894LgjM/sAuCd4TBUUogmj2zXI/rVGiZTJf8fb28A==
X-Received: by 2002:a62:e10f:: with SMTP id q15mr81286283pfh.56.1558374568375;
        Mon, 20 May 2019 10:49:28 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:e483:1cc0:e2c2:140d])
        by smtp.googlemail.com with ESMTPSA id s12sm28713070pfd.152.2019.05.20.10.49.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 10:49:27 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] arm64: dts: meson: g12a: add ethernet support
In-Reply-To: <20190520131401.11804-1-jbrunet@baylibre.com>
References: <20190520131401.11804-1-jbrunet@baylibre.com>
Date:   Mon, 20 May 2019 10:49:26 -0700
Message-ID: <7himu58195.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Add network support to the g12a SoC family
>
> This is series is based on 5.2-rc1 and the patches I already sent last
> week. If this is not convient for you, please let me know, I'll rebase.

Could you apply this on top of the "consistently order nodes" patches
that are already in my v5.3/dt64 branch?

More specifically, if you rebase this onto this commit[1], I'll be able
to easily replace the v1 of this series that's already in v5.3/dt64.

Kevin

[1] 5b9533f6de2a arm64: dts: meson: u200: consistently order nodes

> Also, you will need to get the clk tag "clk-meson-5.3-1-fixes" (to get
> the update MPLL50M id) from clk-meson [0].
>
> Changes since v1: [1]
>  * rebased on v5.2-rc1
>  * s/eth_rmii_pins/eth_pins
>  * fix MPLL50M typo
>
> [0]: git://github.com/BayLibre/clk-meson.git
> [1]: https://lkml.kernel.org/r/20190510164940.13496-1-jbrunet@baylibre.com
>
> Jerome Brunet (5):
>   arm64: dts: meson: g12a: add ethernet mac controller
>   arm64: dts: meson: g12a: add ethernet pinctrl definitions
>   arm64: dts: meson: g12a: add mdio multiplexer
>   arm64: dts: meson: u200: add internal network
>   arm64: dts: meson: sei510: add network support
>
>  .../boot/dts/amlogic/meson-g12a-sei510.dts    |  7 ++
>  .../boot/dts/amlogic/meson-g12a-u200.dts      |  7 ++
>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   | 90 +++++++++++++++++++
>  3 files changed, 104 insertions(+)
>
> -- 
> 2.20.1
