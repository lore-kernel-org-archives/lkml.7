Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EAAC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 22:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4499217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 22:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UEfBh7LH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbfEJWpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 18:45:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42198 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbfEJWpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 18:45:19 -0400
Received: by mail-pg1-f193.google.com with SMTP id 145so3657833pgg.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 15:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=d97YmyA/3LiD+Mv8la+sVqazB0Wi/v83PJRamaL8IZA=;
        b=UEfBh7LHUprotWgJPz47HT61WOt99NIYruH7UVlYWzGp4leqNw7BqhT7vDvqv9kY05
         FKyz/tgBrTPfjkcCh+21RVlmTBikMUeRlhdmfQi2wjrPwKMwMcKuqBtLEZeGcfxg905Q
         kUq7k+hsUcLNGqIkhh0wrUlGl7hetNo3FVVXHaKarX2zcWMGTqkRnOvAKXvkvW4ZFFKV
         WBPXBZAr93pQ3oHpHnxaTB2Dg0sPKef+ipSQ4xkc9mMH5hymm66nUugkVooCXyVjAtFl
         WXsorAy2Z+x+GyF+wCZ8MmIxQvXHD4VC84TEeCHm9ezcB3cYMYi3E58GHtX/yygFUdaJ
         5mVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=d97YmyA/3LiD+Mv8la+sVqazB0Wi/v83PJRamaL8IZA=;
        b=j6zsBTpQ7NLWp5uyelvtw+YkdLjTFE6WFfIrFw/VTvXUZ+zCpb3sFV0SnnQRVMSx5B
         w40tjF4DJSMEiEHF5lAJFr7dbtKhSrjwVZ1dcZZj3mj0hh9JnEgBEjijDB4DyVfrM7ZU
         kw60pUI0Qi7b009p79Yf5Rle8sMwCSueS+rIVLGWWLyd2lEeOULfkz1F297aWC7YIMPa
         ViLD9vhozNKfLrATlDXW1FTTYA+DYWtQpcwDm05hHtxpHqfFc78jSXheXlg5NNgbSK1l
         yOVBbCilO4LRQMCFIYN4oC7TTfyDT6LF8Nhs5+s1zvm292hZevaYPxRJiswQPk6DBQYU
         EnVw==
X-Gm-Message-State: APjAAAWkiaUhzvpqgU7h3xLwuP6UXwuUuqWF7gVGXNPb0IWmDrouh4o+
        3tsr6JRNWUgDYkNdOxMJDhfVfQ==
X-Google-Smtp-Source: APXvYqxp0q0ql6/xwfvXB+jKs9bE8hhgTE2r8MIvm/sZG0/ChzNNxXC/9dZEpANHwGlx3k2JIC4I9Q==
X-Received: by 2002:a62:56d9:: with SMTP id h86mr18128439pfj.195.1557528318502;
        Fri, 10 May 2019 15:45:18 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:fd66:a9bc:7c2c:636a])
        by smtp.googlemail.com with ESMTPSA id i3sm8675360pfa.90.2019.05.10.15.45.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 15:45:17 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 5/5] arm64: dts: meson: sei510: add network support
In-Reply-To: <20190510164940.13496-6-jbrunet@baylibre.com>
References: <20190510164940.13496-1-jbrunet@baylibre.com> <20190510164940.13496-6-jbrunet@baylibre.com>
Date:   Fri, 10 May 2019 15:45:16 -0700
Message-ID: <7ho94ac4jn.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Enable the network interface of the SEI510 which use the internal PHY.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

I tried testing this series on SEI510, but I must still be missing some
defconfig options, as the default defconfig doesn't lead to a working
interface.


I tried adding this kconfig fragment[1], and the dwmac probes/inits but
I must still be missing something, as the dwmac is still failing to find
a PHY.  Boot log: https://termbin.com/ivf3

I have the same result testing on the u200.

Kevin

[1] amlogic network kconfig fragment
CONFIG_STMMAC_ETH=y

# following are needed, but automatically enabled if above is set
#CONFIG_STMMAC_PLATFORM=m
#CONFIG_DWMAC_MESON=m

CONFIG_PHYLIB=y
CONFIG_MICREL_PHY=y
CONFIG_REALTEK_PHY=y

CONFIG_MDIO_BUS_MUX_MESON_G12A=y
CONFIG_MESON_GXL_PHY=y
