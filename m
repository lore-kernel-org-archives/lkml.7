Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35023C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 20:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009FB206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 20:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="azjuJOvh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbfFFUAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 16:00:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39235 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfFFUAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 16:00:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id j2so2147825pfe.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 13:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=+S2za5E2ysBthBJN8nhvqwmLKKW4lZ4JrfmGBXCW9Do=;
        b=azjuJOvh9vVcco4+dB9mpQHAleMSqSKTlia7Zb76u47A8WR6wIsrbR4J2n43c40KV3
         GSF+MLvTz9qnbY1ZNCfHMS21210wyHO4i+xzLdxCaCXd1mqZv1OoUtxKv+L372BLP+Ke
         hSgFngB1ugHgmfjgMO4YVokX3nADOSAvdKDp8nXZGwELJfVRwMkyWU6ziWl6KmY+mVLH
         GL9PKZVR/LAbYRo85ihbUQFiVjdQsxDrYRVOHfJhSQu7qJd7CAq1Zahsbo6caUycZcJg
         UGHPpkAn55D+E3ujXQGW/Xn2CqdL4L/fipYX8WkD+sBQufCxM3D3sgGC1udlwoZ+MJWT
         40vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+S2za5E2ysBthBJN8nhvqwmLKKW4lZ4JrfmGBXCW9Do=;
        b=lnUoBibJzSPteMOIMRU9Q61bsB3W8jTvBHLIS7e02ACSyYOlsA9CZE7eeo3hKbeX+1
         Yufty7l9YyXMsmjayo1JZP8oqB2GEnDh7qmTnauXXUPckqU3LFI1WMxj4TbF4t2txvBD
         fUBuNkM8TzjleUWvcbrEZfdQN/hbydfZzs9AWsf8pDfbK3ZlSjA5deuSnUpAb7BRokBw
         0aZdyHLLhijILN47EKIQH8tvKxYjJKTMIPjoCAl8iZzbA/GI+iODPJ6zjgJk5iEKmFcz
         5Lg2qjkBjOcyaHespVcnVVIfQDIJQ2Pd74hzyMz7NQZ/zKH0WctnJFrhW35pBLMYnudB
         8arA==
X-Gm-Message-State: APjAAAVL9EmO3CTDX6m+oV/gr41FaOz+/R7E/CStrHPnOS4OwPDnqrge
        CbcJyyYNEWPljG6oD1QYqcrfOQ==
X-Google-Smtp-Source: APXvYqydS8Cff5YUUoLMVkPtd/Z9+fZKmczr/F25Y/oh1KKo7VIe1z4GFo73+LucbRJ/GmjyBOa0zA==
X-Received: by 2002:a63:fb01:: with SMTP id o1mr251166pgh.410.1559851246224;
        Thu, 06 Jun 2019 13:00:46 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id s42sm3271040pjc.5.2019.06.06.13.00.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 13:00:45 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 01/10] arm64: dts: meson-gxm-khadas-vim2: fix gpio-keys-polled node
In-Reply-To: <20190527132200.17377-2-narmstrong@baylibre.com>
References: <20190527132200.17377-1-narmstrong@baylibre.com> <20190527132200.17377-2-narmstrong@baylibre.com>
Date:   Thu, 06 Jun 2019 13:00:45 -0700
Message-ID: <7hy32ecwlu.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> From: Christian Hewitt <christianshewitt@gmail.com>
>
> Fix DTC warnings:
>
> meson-gxm-khadas-vim2.dtb: Warning (avoid_unnecessary_addr_size):
>    /gpio-keys-polled: unnecessary #address-cells/#size-cells
> 	without "ranges" or child "reg" property
>
> Fixes: b8b74dda3908 ("ARM64: dts: meson-gxm: Add support for Khadas VIM2")
> Suggested-by: Christian Hewitt <christianshewitt@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

This patch is missing a S-o-B from the author (Christian?)

The From, Suggested-by and Signed-off-by send mixed messages.  Please
clarify if if this is missing a signoff from Christian or if the author
is Neil.

Thanks,

Kevin
