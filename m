Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C4AC79DA6
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE83E2470A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Y9roHoe4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbfLMQvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 11:51:22 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36701 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728194AbfLMQvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 11:51:21 -0500
Received: by mail-pg1-f195.google.com with SMTP id k3so95601pgc.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 08:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=CAKYbgJOuPrQjZzMU15duDzEPoqOHPryHWVB0LlLVJ0=;
        b=Y9roHoe4knC/3BeSYJfMTn6bay+pT2YhyVNHvcWdl3A8J7dp63no9Ekvt1JsYnoaHY
         vixMt2a9ZIF+VpZCiLfqaF2+Qi91TDmH48MdsevifKtcEMPwo8ThbhsPJtVU/DX3SPGT
         hozgRBw67+xOvh61BGiu/pj8aspFRnxjXdEAx9WReUQNZcfB5mw4371fWOrp/1xZSa25
         DjaByZ9CuvGnurGZFRES5Thm6CY+r6na325r5TRh9PVZDAykJPzB8gcpQDig6tzpk1nQ
         gE+1JvbnCl7LRzMaO9F7wvvv0XpXmTLwYcpXgri3ros2x8HNdTjJkIbRG9NX/W5AcVjP
         BIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=CAKYbgJOuPrQjZzMU15duDzEPoqOHPryHWVB0LlLVJ0=;
        b=BS86QeVP5d4o03yBAfeyp9B8qrdaqw1slTkNca+FpTfk17KUpCIdsfjdxzuD1AP9/7
         lGJkCoZeRK40VnRagTxIL8kQ/sAjIbiV0RgSLM/N8q1xKnHCx+p4xkNmLPcjjQeFW8qo
         Y3v682Y4lRcqK+BzbVvcDMNLN0HvgCGVX43/iGvUwkbtzsNCTTKerYSmrlB0ZUzqvQke
         d0b/j0SYyrcvWU5OpwH+pH0pprmDiJy/lxpQ5NmXYdtMZSlLpbLmjEGz1q73vAqYY2LG
         8kWVMsAJNiQH2dR0CIQwrZsyzaDKh2k+olSJHU7+6HUZi38EJRoRsHVR9fF/l75wi8OC
         uyiw==
X-Gm-Message-State: APjAAAVuarLVIKW3B2BTW0HzC70mF8aIVwM8hgN3K6RPKVDKntgFpgIm
        kSTT8DQihMJzF4wnAasOen/sgw==
X-Google-Smtp-Source: APXvYqx8c6YOAASRXq1y4Uky+FLljcRzDfb1EqKwF5yKxzGUufqLyOLiT0Js4vaXwqrz7WYzNKz0zQ==
X-Received: by 2002:a62:5544:: with SMTP id j65mr381415pfb.121.1576255880888;
        Fri, 13 Dec 2019 08:51:20 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id 91sm10649806pjq.18.2019.12.13.08.51.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Dec 2019 08:51:19 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, mjourdan@baylibre.com
Cc:     linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 4/4] arm64: dts: meson-g12-common: add video decoder node
In-Reply-To: <20191120111430.29552-5-narmstrong@baylibre.com>
References: <20191120111430.29552-1-narmstrong@baylibre.com> <20191120111430.29552-5-narmstrong@baylibre.com>
Date:   Fri, 13 Dec 2019 08:51:19 -0800
Message-ID: <7hwob088zc.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> From: Maxime Jourdan <mjourdan@baylibre.com>
>
> Add the video decoder node for the Amlogic G12A and compatible SoC.
>
> Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Queued for v5.6,

Kevin
