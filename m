Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DFAFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738EA21928
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rUVvtmAd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406428AbfJPQmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 12:42:53 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41443 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389763AbfJPQmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 12:42:52 -0400
Received: by mail-pl1-f195.google.com with SMTP id t10so11521432plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 09:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=57uyxmoXhyIZG8+XPLz4fjpdkC+Q+fEOX17k+/hG6tY=;
        b=rUVvtmAdciiJfC7zc4iHMpw0uFh5wPbykASFgtkhhw4m6QvnfcyqH34IwbX3rt2paY
         S5eDisYcUokzkMN0ZlmKCeGbkDuF9ZpAO+PqcB9/zZacqIJvpbgiEQZKMVUEVyA5zNlz
         dkXXvQ867OpBmcb0Txd1GiCGy3r8/dK57xR4mNDDpRLHNaO0SM81tF4UH5eF5Kx8uQUY
         5E9cNIQMD0zJdPtVFt7+OEY2+ZJCDurQ07h3cRCzwpA59yudNtwCCW7htiobEkO5+sKy
         BY5woMUym4gpM5RN5h0C6g9T/oPCjR13uI5ktka4HojeQajPoJZHgLzDzzCLXmqZOtw9
         12jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=57uyxmoXhyIZG8+XPLz4fjpdkC+Q+fEOX17k+/hG6tY=;
        b=iW+18qyHZIclF7zpd77m5VxjBR4HKQ/wLAtnIS0IYrPJA+G1hoRDGUkGUsuB9LBphc
         iL7BVqSyOGtivGPJ/4abv5/68J3PrTyq3Q69wXlJOWv2eJMFSLbCHxlEuG56V6LkjZvu
         W94HdFrQzH4Saj/IFC78NeCbBK2BDIHn6N3YSR8hwGzJQPkmlJP4dw7F0xMRSqrV5sZW
         bMNA6UK9wMg9ISfyx1WE91gRWkU5TwCuiQ/JiH9BxVdX5PpkAPplhp8OwUROhsTZdKvO
         DugdbTvttu4j5pGBSHwxkR0qQtjSsuP0EJcAB4Fjm0tx7pRBhT6ZaGAZKCUYTA7TQ7Jg
         oGWA==
X-Gm-Message-State: APjAAAXfiXNlKyAZx4MUrUxmo8oMXm5OYxA1iLhDDrz5UdjbwHda/P18
        5JXfzQz4NwIEv2dVssenpNtC5dNvsFY=
X-Google-Smtp-Source: APXvYqzYGefqM+N97RnNolUGlVbbJgqvYENkUacnJagIFtdqHenQ0FP2dvlvfgAmmN8wCkoVChDPiQ==
X-Received: by 2002:a17:902:8505:: with SMTP id bj5mr6102750plb.31.1571244171732;
        Wed, 16 Oct 2019 09:42:51 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id n23sm23363431pff.137.2019.10.16.09.42.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Oct 2019 09:42:51 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Guillaume La Roque <glaroque@baylibre.com>,
        amit.kucheria@linaro.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v7 4/7] arm64: dts: meson: g12: Add minimal thermal zone
In-Reply-To: <20191004090114.30694-5-glaroque@baylibre.com>
References: <20191004090114.30694-1-glaroque@baylibre.com> <20191004090114.30694-5-glaroque@baylibre.com>
Date:   Wed, 16 Oct 2019 09:42:50 -0700
Message-ID: <7hsgnsfxpx.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume La Roque <glaroque@baylibre.com> writes:

> Add minimal thermal zone for two temperature sensor
> One is located close to the DDR and the other one is
> located close to the PLLs (between the CPU and GPU)

nit: subject should be "arm64: dts: amlogic" (not meson).

I fixed it up when applying,

Kevin
