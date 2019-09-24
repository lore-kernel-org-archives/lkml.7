Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC240C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 18:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51F2207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 18:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fecu14KJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436905AbfIXSg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 14:36:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45250 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392031AbfIXSg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 14:36:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id y72so1847125pfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 11:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=qezDz9bspudrXAh4YzmNmsdn0fgIjx8hse3GBBdt44w=;
        b=fecu14KJIkEqCODinTGcjcMfGpRWzcjnZFogT0JUIu66bFQC7+q3cF+TSdz2tUBHVj
         fFZeKGbqEQ0gZlbZk6x76vdE4CG243uv7ZO5mnjbL0M21t6bj9W+TZkirqRhfIWl+2R3
         NKTqpZfjVK4lurojreAu4MZPBFoexZ6PKU7qEYt6Yku6GMh3zZgZ+td9CBcQ/LmRQXow
         nUpIN8KQl7L1BbI9xKd4zoSQLITcTOXqNuczc7HFJnToYmzc3xny21pWhN21/2m0D9w/
         aQqJ4YmdakJ7+6PyC2cTFa9YcebBvUBQpv4iD36RKymbFRO/BootG5dBQBQ686NWpkxq
         KuBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=qezDz9bspudrXAh4YzmNmsdn0fgIjx8hse3GBBdt44w=;
        b=lk7M4O2ZBeT2eIShpZrc5BZEG3eTQ+jmD4Ianuj+R98dpBYJquSuj8JsJMkpN6PnC3
         QrAXPUSsvM4fgTepgzgeBz0uYnop/saA3eqZR8ajmN+HWsouHkzX/TugZ27xMGnBYJbx
         L2l6Nqpodfb3A15wD/Nf1xr0H8D8k7GV8UbDw8tuAfkFy9MzGNhQvkaXghPLBEsM9EzV
         dGcndwSSIaD6VVhIrO9AR4eF4c12DyKhXzR7CKsr9vCWnmLRDkpbMlL8JNyyRS3jTv1k
         DEK3cVChEVm5ROiFnXveZc+Czb8WrA+dJQ0wA/MQcGwIc+GB+8C1j3NiIqD443B8lT95
         1s/w==
X-Gm-Message-State: APjAAAVTlp3CwhwmFyZ9B6HJAkDhRaRSRQCjk44+zmMZ0Z4w7aXm3un9
        jh2MR/O1lrmqHA0PQPhPwgkuvQ==
X-Google-Smtp-Source: APXvYqxr2Opu6oYUEulaL+1hVz4ZRODiRh23zAlZPgvT6KnZjaIacvduxLwlgaFt8Ai95zGjaIFHdw==
X-Received: by 2002:a17:90a:5ae4:: with SMTP id n91mr1528924pji.143.1569350216705;
        Tue, 24 Sep 2019 11:36:56 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id a18sm2429300pgm.25.2019.09.24.11.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Sep 2019 11:36:56 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 00/15] arm64: dts: meson: add keep-power-in-suspend property in boards SDIO nodes
In-Reply-To: <20190829152342.27794-1-narmstrong@baylibre.com>
References: <20190829152342.27794-1-narmstrong@baylibre.com>
Date:   Tue, 24 Sep 2019 11:36:55 -0700
Message-ID: <7hh8517d88.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The WiFi SDIO firmwares requires power to be kept while entering a system
> wide suspend state to keep current connection state and eventually wake up
> on packet reception/new AP connection, thus add the keep-power-in-suspend in
> each boards enabling SDIO.
>
> For the record, drivers requires it are :
> - brcmfmac: drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c line 1125
> - mwifiex: drivers/net/wireless/marvell/mwifiex/sdio.c line 426
> - libertas: drivers/net/wireless/marvell/libertas/if_sdio.c line 1327
> - wl1271: drivers/net/wireless/ti/wlcore/sdio.c line 411
> and bcmdhd out-of-tree driver.

Queued for v5.5,

Kevin
