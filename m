Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0BBC2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 10:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2A4206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 10:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="MqNoyAvZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfLXKDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 05:03:35 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36618 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfLXKDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 05:03:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so19406906wru.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 02:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0ZsZKg1YffuHIcf56+MEUis8ScLI3mY9i8Ph7Sk75GI=;
        b=MqNoyAvZ3bGV01kIgcBYs1dNiN581FYUQQc5XaPPAIQrRYR8jRjcW5+NOmrQLnXOMy
         +rAdfSiseXRONB7FOkhf3d2UzhrhonApn8hApIqDWdT3mMkVA5qtjmzHize2rHJq6hjh
         x5Gypq5oQKI0hV9OgmDdUDui/m/s+7/fEenqycRCKy4Yj4mgkR+GxPr4/AJiaCecatAg
         gxLmy1Fmsh7QSvkVHgzctxYdMS6cJFILWzYj2oSBN5RZtO47skOpMwIH0g8ytPcq8Xtg
         RDFRBsnqmmUfF4hVtceBDuXn8lfTiN+q8SPTGf5Nr5H45LD+39BRm+KcvoIf1gD3uBFD
         Ivyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0ZsZKg1YffuHIcf56+MEUis8ScLI3mY9i8Ph7Sk75GI=;
        b=sd3dzhmMm7IK5ddOgy6I5U8Y3YJCPOGpYCRZC0l5vp3o01m/Xpe6HClb2qMevpsM7D
         rUQG01vMe/6mM+2i98cArFsipitO3dlOINQQLyR5SWCwrKQ1NjWaEMJkCr30IAf78GKM
         UIa5Z/l0Yfn3eXhFJnyR18dlAyvm2VPSos37pv1JtDTfe5aJAbDp69knLPw2NJ8NqRL8
         LWhfVjSuFGKXWv9HqHZ2a1ddNSKLmHpHYHQUTMZFPpU4RAgFkKjOykbdMPrb9t076Suy
         Vzl1dCsjMLJXJmcw9E+3aV5YH5c953AwhDLZV7pwfLQ/5Dl2eIFy8x2eHPKcEIy1JgX3
         40+Q==
X-Gm-Message-State: APjAAAU/zOvBTd4r1TaywiwAA+4Yzu91TdY9ulE4aBn/XIa2hqdSBt61
        WYagcm8MCA6L4VxO5NL/K6/YBNiUyO0=
X-Google-Smtp-Source: APXvYqxnYJvSlllHtbmLwHwhMKGkVlozEQqfStZhaKxgmu+TbXc2bIVZQuE3KOYfHzT0kcTJo5Ol/Q==
X-Received: by 2002:a5d:6305:: with SMTP id i5mr35261141wru.119.1577181812545;
        Tue, 24 Dec 2019 02:03:32 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a184sm2164048wmf.29.2019.12.24.02.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 02:03:31 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 0/3] ARM: davinci: convert dm365 to using the new clocksource driver
Date:   Tue, 24 Dec 2019 11:03:25 +0100
Message-Id: <20191224100328.13608-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Hi Sekhar,

I'm resending this (with fixes) as other solutions have failed and I
think that this is a correct thing to do after all. In the end: with
this patch we do bring the clock to a defined state before enabling it.

Let me know what you think about it.

---

This is a follow-up to the big series converting DaVinci to using
a proper clocksource driver. Last time we couldn't merge the entire
series because of a bug that only appears on dm365 Soc when using
ancient u-boot.

This series contains a workaround for this problem, a patch finally
converting the platform as well as a removal of all obsolete code.

v1 -> v2:
- simplify patch 1/3 by using a boolean flag instead of caching the
  value bits for TIM34

Bartosz Golaszewski (3):
  clocksource: davinci: only enable tim34 in periodic mode once it's
    initialized
  ARM: davinci: dm365: switch to using the clocksource driver
  ARM: davinci: remove legacy timer support

 arch/arm/mach-davinci/Makefile              |   3 +-
 arch/arm/mach-davinci/devices-da8xx.c       |   1 -
 arch/arm/mach-davinci/devices.c             |  19 -
 arch/arm/mach-davinci/dm365.c               |  22 +-
 arch/arm/mach-davinci/include/mach/common.h |  17 -
 arch/arm/mach-davinci/include/mach/time.h   |  33 --
 arch/arm/mach-davinci/time.c                | 400 --------------------
 drivers/clocksource/timer-davinci.c         |  13 +-
 8 files changed, 25 insertions(+), 483 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/include/mach/time.h
 delete mode 100644 arch/arm/mach-davinci/time.c

-- 
2.23.0

