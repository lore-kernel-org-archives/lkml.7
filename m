Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC732C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48BC20862
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="SS8ITlKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387742AbfJCSNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 14:13:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45512 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732618AbfJCSNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 14:13:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id q7so2211003pgi.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 11:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=5ijW82wqEyt50B/p7BmRF9XDSziktvxTJK/8Iy++vOE=;
        b=SS8ITlKQvqVuJU6DaryZFkNa9oHm8I6oJ6WYZI1b3WOVoNUQTwTmly3kah5Jc1VhxV
         OAfDnS4OADGWY4KamAHVz4GQzMn21dgeeZgwrMKTsBV7Kr0rdPMqIrMn5vYFHBw4Fkof
         +JHevQa6Hgb59t0XU3WTewtsQyQzZAGdXVhov4VTsFTLOqIUTSFfnWEDH3CSLHX5umJa
         KHx8pgjifYrbZXYxEAyLOLhl1xKyJV0GKk2h/+Ce30eI926m1R0vUKjikJC0Qr7AGOt1
         57/RJFjW5PmDC1nXGHoFjpBO+OLW/sf1JkhMjO9matHvYV4uEuCA0fH2E1EIxv8v5wmW
         LqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=5ijW82wqEyt50B/p7BmRF9XDSziktvxTJK/8Iy++vOE=;
        b=IMDYxqrrUc3y+VWdAxDeJyNY9QHB+kpRpRzKR5URmFHTcrQNPUQLaj3SL2PB/YVkbP
         VNLYEuGDI3DrSNktYi8Cj9BOmehuC28O3mlIOPNwSsE7Q684MUCxOP+8BJpbb4jLmrWi
         cFy0HFP/JFGelaOXuKRQKcSc6GzJUn7/ClU/2ly9xrl9T308+bwAtr3skew11S6dfags
         Nc2Gb3HyslI9PaQzqoHLlBTwCtO30ZQgl0mryUijMj9NDVNc08dMXiIvQrpFRzGU6SUS
         YZ1CFqXujNbh9Xlbd88QSOYpMcfGO0DYYMhXAIFfjU+7VwC1bQdDge+TvCrQH4yOV9Lz
         WPLg==
X-Gm-Message-State: APjAAAWj+PdD5WUpdNGnuWG96VEU0nEza7D/encTZvmLp/iKZ/Ur1jNv
        0Ggsv+LGtk2iiENpobDg1CH05Q==
X-Google-Smtp-Source: APXvYqxvCuQEnHzAam3ZE2fCm+0SADsW+/L6538BpVWWRoA8JBVstrzxK625nTHVnkYYHMxGfyBxbA==
X-Received: by 2002:aa7:8bc2:: with SMTP id s2mr11957989pfd.13.1570126385442;
        Thu, 03 Oct 2019 11:13:05 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:a084:116f:9da0:2d6c])
        by smtp.gmail.com with ESMTPSA id b5sm3968458pfp.38.2019.10.03.11.13.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Oct 2019 11:13:04 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maxime Jourdan <mjourdan@baylibre.com>
Subject: Re: [PATCH] arm64: dts: meson-g12: add support for simplefb
In-Reply-To: <20191003130841.8412-1-narmstrong@baylibre.com>
References: <20191003130841.8412-1-narmstrong@baylibre.com>
Date:   Thu, 03 Oct 2019 11:13:04 -0700
Message-ID: <7hmuehvgsv.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> SimpleFB allows transferring a framebuffer from the firmware/bootloader
> to the kernel, while making sure the related clocks and power supplies
> stay enabled.
>
> Add nodes for CVBS and HDMI Simple Framebuffers, based on the GXBB/GXL/GXM
> support at [1].
>
> [1] 03b370357907 ("arm64: dts: meson-gx: add support for simplef")
>
> Cc: Maxime Jourdan <mjourdan@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
> This will be handled in the in-review U-Boot Video support for G12A at [1]
> and the simplefb handling code at [2] and simplefb removal in DRM driver at [3].

Nice!  This will help for the corner cases of the VPU power domain
handling.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

Queuing for v5.5,

Thanks,

Kevin
