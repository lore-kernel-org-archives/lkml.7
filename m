Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C37DC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 21:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB502467A
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 21:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ZCtFipn4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfLOVMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 16:12:37 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36960 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfLOVMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 16:12:37 -0500
Received: by mail-wm1-f68.google.com with SMTP id f129so4528231wmf.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 13:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y3g/A/VhKALqZSKzxwKBBQCqFaLT6bu0ReDrDf4DLQc=;
        b=ZCtFipn4ACffkMmwhawkSiNoVgx0+1I/zetuvwljhG+tWyZ0QQPaYyTf0tYB3xkngk
         6Zdhi3lnfLaSVuaQ1DqhKu1f/SKPj5x54V3ruUFI3TrsEfeMqsB2gcJLKV59QYW9WVrS
         Tf8W2Vez+GWK2BdLTjqd69ZTyInxjiH22HRxCj3h2cYInl4jj2OhyBxX+t1t8OIcaBPU
         d8YwQjidrlvmNzBDYimEfKgMzxiXGIffGNSy509VGvm+HlZ5Yy9P3bC9XKTeKsS2VAR5
         tuUCD+Wzn/d1Wq8Qko4UIOccdH5ozey4wwt1KKWzVwWjaCUvOt2jN1q22S5O/YmLQMQR
         GrFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y3g/A/VhKALqZSKzxwKBBQCqFaLT6bu0ReDrDf4DLQc=;
        b=ErmWnKCPtBxklmCt12OataZ5RO93kxG7P/2IjR6AQkRB/xAgWNQB52W0FTUzyQfyp+
         QmxjVurulE25F2785+7EktIifqz6tqXSh/0tc2JKBh4rHj+HKf+QMgVskKrDpxt3rdFt
         Gfu6spsm8xKpqfXOIdQkGF5rffZDgoyzA8rLp4j1PPSB9nFmVMdbMoZpRL4tlaKNexK7
         eEqgDBu0FAOdFluguKHExVOR3viINyWUJUm3omd5O2cqFGN3qxCFxlbA7ITPLx5OeLjX
         c6BLACJGKL5+BgUeSLGwys1ZEh13a6mL5KdDSq6gwdKKWaKGF6we1y1ZW1P+X+47SgN9
         Kg6A==
X-Gm-Message-State: APjAAAWVvinXdoxuXTdsmM1AOKUnFVsr0MrSwUveTYxEh+f+4xPsvW5u
        bKWndpzjq85Qt+sa+1VnX4c=
X-Google-Smtp-Source: APXvYqxJS/WP2zOOmRW0orqTzZD1jmdig6IvEjlAtgAQFwQIvIMmtkBtCQxOdm7tqfX0VPIRQxJT0Q==
X-Received: by 2002:a7b:c342:: with SMTP id l2mr27920141wmj.20.1576444354953;
        Sun, 15 Dec 2019 13:12:34 -0800 (PST)
Received: from localhost.localdomain (p200300F1370FCC00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:370f:cc00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id j12sm19888598wrw.54.2019.12.15.13.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 13:12:34 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     yuq825@gmail.com, dri-devel@lists.freedesktop.org,
        lima@lists.freedesktop.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        tomeu.vizoso@collabora.com, robh@kernel.org, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org, wens@csie.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC v1 0/1] drm: lima: devfreq and cooling device support
Date:   Sun, 15 Dec 2019 22:12:22 +0100
Message-Id: <20191215211223.1451499-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is my attempt at adding devfreq (and cooling device) support to
the lima driver.
I didn't have much time to do in-depth testing. However, I'm sending
this out early because there are many SoCs with Mali-400/450 GPU so
I want to avoid duplicating the work with somebody else.

The code is derived from panfrost_devfreq.c which is why I kept the
Collabora copyright in lima_devfreq.c. Please let me know if I should
drop this or how I can make it more clear that I "borrowed" the code
from panfrost.

I am seeking comments in two general areas:
- regarding the integration into the existing lima code
- for the actual devfreq code (I had to adapt the panfrost code
  slightly, because lima uses a bus and a GPU/core clock)

My own TODO list includes "more" testing on various Amlogic SoCs.
So far I have tested this on Meson8b and Meson8m2 (which both have a
GPU OPP table defined). However, I still need to test this on a GXL
board (which is currently missing the GPU OPP table).


Martin Blumenstingl (1):
  drm/lima: Add optional devfreq support

 drivers/gpu/drm/lima/Kconfig        |   1 +
 drivers/gpu/drm/lima/Makefile       |   3 +-
 drivers/gpu/drm/lima/lima_devfreq.c | 162 ++++++++++++++++++++++++++++
 drivers/gpu/drm/lima/lima_devfreq.h |  15 +++
 drivers/gpu/drm/lima/lima_device.c  |   4 +
 drivers/gpu/drm/lima/lima_device.h  |  11 ++
 drivers/gpu/drm/lima/lima_drv.c     |  14 ++-
 drivers/gpu/drm/lima/lima_sched.c   |   7 ++
 drivers/gpu/drm/lima/lima_sched.h   |   3 +
 9 files changed, 217 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/lima/lima_devfreq.c
 create mode 100644 drivers/gpu/drm/lima/lima_devfreq.h

-- 
2.24.1

