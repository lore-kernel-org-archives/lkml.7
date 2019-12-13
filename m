Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1A1C4BA0E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D68D246AF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Adt3PMoX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfLMQZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 11:25:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38584 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbfLMQZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 11:25:08 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so51196wrh.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 08:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DNUp596ZddGOax8pFd4t+4vyG8zhBsCGAZAw/KReX/E=;
        b=Adt3PMoX5OBm6bSlz3GKd8g56Kg52X+ybqY1NTzIR6q1djD8cneBfVfzHtdsoHmiMl
         EufFsQNT9xwDoLiyVXejbC+yTJzKqdFvKuVVa8GNB1NggGBssYR5ME0t2ImkiPtJC/bH
         eIh9drLKzfFLPaIg367l6RZrPyxkzsovHQnyWAqzCz8yw0RwTgLAiB/Qw0bsd1b2PdQQ
         BlP9GAZK2579VIQN2ofENJkpxwnYW7NnJ05lgZGushSPTsLOI3NIREkpkfcYVDmSQvY/
         iG/Xije3sH3GawzNT8m5UCL/YR1aRogLCzAsoZdiO1cZQQ+lc1b6I0aJwWIsi2BO2ZD8
         ispg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DNUp596ZddGOax8pFd4t+4vyG8zhBsCGAZAw/KReX/E=;
        b=kJCKRAhxdnvUSlarjXXIC1eq0lWrbedGWfNv9+vSzRDazQHKTouImvagHc+qQUA/iO
         SWHRf0UFNxiRVssltm/oDjTMKBkaqqQJCVlgf8mn180gpdkpDR8QgOEELKHICqFvWE4P
         jHmqVU1mYCzLysPGvuwNN6EhS8hs6zHyOoH0RKIgXFd/mKTsba1NXTXQrok3o9yBKswd
         x4/rPuxpDNNRXmrhO/Qay3/uN+vq5HsM23uxgNoum3DK6qgActIKd5zzbXk5rkr7ARbu
         QghQRBIv+iqk9W0tiRX+PWBFwIoS5Q5/d+36PZ86DNWHYmoDLqodslwS4X4jkMlKrkrU
         psUg==
X-Gm-Message-State: APjAAAUR0X9JJe62aXszDt36ua2wbXTPE5HlPbFW0xL93yzYj3CUHDJv
        7Ht/XyMuCIn6X5QrG6a67I9AZg==
X-Google-Smtp-Source: APXvYqyU6Z/dNDOhwWaYR15YpjIssxVYX/MERaSiGB29YqksLf4lDQ/uUhAvSDCJO7fTsU1N6F3JdA==
X-Received: by 2002:adf:fe0e:: with SMTP id n14mr13658527wrr.116.1576254306335;
        Fri, 13 Dec 2019 08:25:06 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:3d17:b245:8f4:3043])
        by smtp.gmail.com with ESMTPSA id h8sm11139330wrx.63.2019.12.13.08.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 08:25:05 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/3] ARM: davinci: convert dm365 to using the new clocksource driver
Date:   Fri, 13 Dec 2019 17:24:50 +0100
Message-Id: <20191213162453.15691-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This is a follow-up to the big series converting DaVinci to using
a proper clocksource driver. Last time we couldn't merge the entire
series because of a bug that only appears on dm365 Soc when using
ancient u-boot.

This series contains a workaround for this problem, a patch finally
converting the platform as well as a removal of all obsolete code.

Bartosz Golaszewski (3):
  clocksource: davinci: work around a clocksource problem on dm365 SoC
  ARM: davinci: dm365: switch to using the clocksource driver
  ARM: davinci: remove legacy timer support

 arch/arm/mach-davinci/Makefile              |   3 +-
 arch/arm/mach-davinci/devices-da8xx.c       |   1 -
 arch/arm/mach-davinci/devices.c             |  19 -
 arch/arm/mach-davinci/dm365.c               |  22 +-
 arch/arm/mach-davinci/include/mach/common.h |  17 -
 arch/arm/mach-davinci/include/mach/time.h   |  33 --
 arch/arm/mach-davinci/time.c                | 400 --------------------
 drivers/clocksource/timer-davinci.c         |   8 +-
 8 files changed, 22 insertions(+), 481 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/include/mach/time.h
 delete mode 100644 arch/arm/mach-davinci/time.c

-- 
2.23.0

