Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE7CC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 03:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E68D20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 03:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFnD7fwF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbfGODS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 23:18:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45761 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfGODS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 23:18:58 -0400
Received: by mail-pf1-f195.google.com with SMTP id r1so6715435pfq.12;
        Sun, 14 Jul 2019 20:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1UsNuU488bAaTj0JaLnojkSixQzmMg2zbCbBzMy0HWw=;
        b=oFnD7fwF5cyg4cvqJ7TqdFhRAWPdTc49K7YANgPbnWatdlA3Gl4VvwGJhu+olffQAg
         hR1eOySY2bND8nyvHT1JNUlY8n+gM986kC5KEl7wXtomxPfOTAZb95mxOT6XdU/RI1BR
         s1RMmHD3jvfy9ROmTY78VfeImpAeNmcdYQXv8wongDc6w4t7tf4nyLAfAtEcER7CPHEn
         PkCVuICpM5E0D2dXNH0UXhiiL0vlGduXdC9HbJK7kZfupSR7xlrihLbWz2TQmw6J7ibq
         k2BaAiqHKv50H0lyI2AEwvjyrJ2hxniHZbx18GL33ugmH95DYiSUdjTDS1bLUVANKPa3
         ma3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1UsNuU488bAaTj0JaLnojkSixQzmMg2zbCbBzMy0HWw=;
        b=PuByujQLcydKFRhjD8a0Txgc8R6INzH9MwPuKs/+x2TbF+RsckXdGWv/uHHMJz7WLU
         4LfV+M14nkAA8UbTLik22kzjJFPqJQmGIUA3GzOjEVBVZJiFQ3apocGjI5VSPBym0+7h
         GBuQrv0IWymmgoS27m6807FWYkUyroRjs4zBXw/GoToexBWg+MBXDxPvQUSgs9PYZ4yw
         F7IHxbDZtsDke4bnXFhyelIc2UiV3h69ZWoUxBFcP8y07uQWukh5sdAn96YoAAPDdhuK
         BApHL1X+XW0+4HkugEgEtmQwZ8kjOMbDrQGmvFfeeFTwJTasHkL9F3sFJz7iLwmQxzpz
         HCrg==
X-Gm-Message-State: APjAAAUziqfXEFYgt2NCPog9IUfUzki8HwXqghnrQ06Sx8LIbH4a2p1d
        axSWKfvpETU8uzlHLgSHmio=
X-Google-Smtp-Source: APXvYqxdGGfZzS2r8XUhIoyjjIamvtltkvX9H3ARnR8MQSfG3WcpmiOIKoWbP95GlNFhqEhr6orhiA==
X-Received: by 2002:a65:5183:: with SMTP id h3mr24502771pgq.250.1563160737715;
        Sun, 14 Jul 2019 20:18:57 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id f64sm16421304pfa.115.2019.07.14.20.18.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jul 2019 20:18:57 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 15/24] media: exynos4-is: Remove call to memset after dma_alloc_coherent
Date:   Mon, 15 Jul 2019 11:18:51 +0800
Message-Id: <20190715031851.6890-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 518a2f1925c3
("dma-mapping: zero memory returned from dma_alloc_*"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  - Use actual commit rather than the merge commit in the commit message

 drivers/media/platform/exynos4-is/fimc-is.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/exynos4-is/fimc-is.c b/drivers/media/platform/exynos4-is/fimc-is.c
index e043d55133a3..77633e356305 100644
--- a/drivers/media/platform/exynos4-is/fimc-is.c
+++ b/drivers/media/platform/exynos4-is/fimc-is.c
@@ -341,7 +341,6 @@ static int fimc_is_alloc_cpu_memory(struct fimc_is *is)
 		return -ENOMEM;
 
 	is->memory.size = FIMC_IS_CPU_MEM_SIZE;
-	memset(is->memory.vaddr, 0, is->memory.size);
 
 	dev_info(dev, "FIMC-IS CPU memory base: %#x\n", (u32)is->memory.paddr);
 
-- 
2.11.0

