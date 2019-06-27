Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFACC48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51952086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEx5bAe2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfF0Ril (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:38:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34753 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfF0Rii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:38:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id p10so1350093pgn.1;
        Thu, 27 Jun 2019 10:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UrGOOwqXYdU4HnZf32fo0+WGpE9hhRvUmIwwr7eD1yc=;
        b=QEx5bAe2IDGhdbb/pyuhCrfIBoyhL7FlODV1yOG8ZjnWT5sOrxCVj6SlR7vbTnZanl
         aCxzh78YfzmbgbPeI6m/h9nOFRCwmq0MRjYUoUiD4mXBAD+Pc2MIo9BfGBeqEeomf8XO
         Ven/aiofV8Jdq6iDjAfb/FSDLeGbDzczd7KrVHpQ+qnNzzj2Kz7PF2DTf/7eFHDLkwBd
         BbSG5rpSLk6vbzMFxO0hynJB6/lRkL7GsU7nkvTOS/3HCurORBqObRy9rR0vO2hlgLnw
         zynlKIG8bwRCtNd3nplq+10N0wZ1Zb09Fj7/9SXFBWPA4+YJvPUkBwVh3DXA5PQJuHwd
         kVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UrGOOwqXYdU4HnZf32fo0+WGpE9hhRvUmIwwr7eD1yc=;
        b=GgBrwWt4A+vrpTUmenkV0QGaANMdCIGi13Qlldv+WBChLDlxip1oHFiwRF69RiiVOP
         T7xocikU29cJMLnMqZmyt2w7ka2WiBtDk0MdGHDd4JmXLctvmj5yQRcrxaGzBhuF07N4
         IPTX6/SYUWQoPFuLQwzSra3INIPWIM9XIg78ONx8J/T9kdpFnjzSi+4xJylAMX0hJKAg
         tZAxV9nTRAlikW3v95XMXvl2T7/mqtDOuOjhwIPjkMiPfHU5XxrdxjNYdpUWLB/3HLfg
         wcUnGEq0kQ8esaM/DgqgSv1CgP1R9QSx7RvD1XG9WBoxN4jw6N/M4R5eFaTmlgk5pqN4
         J5QQ==
X-Gm-Message-State: APjAAAVStpRRKNZ+RGXmws+QEd5PDOTdE61Rcg91YA7phnl8S+jV1/Xq
        +5jfdOLeTB13Vom1MIFhWzM=
X-Google-Smtp-Source: APXvYqysqhAusiUIFovXzQaY6v+uFPfSxgWZZNDiy+cXjWnBE7dy2ehmnGJY16jdPRVGrhp5EMnuyQ==
X-Received: by 2002:a63:d755:: with SMTP id w21mr4919171pgi.311.1561657118048;
        Thu, 27 Jun 2019 10:38:38 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id k22sm4057212pfk.157.2019.06.27.10.38.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:38:37 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 31/87] media: exynos4-is: remove memset after dma_alloc_coherent in fimc-is.c
Date:   Fri, 28 Jun 2019 01:38:31 +0800
Message-Id: <20190627173831.3467-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
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

