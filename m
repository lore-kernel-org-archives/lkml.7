Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0128AC2D0C1
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 00:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBAE52465E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 00:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqmnkOWI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfLTAcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 19:32:36 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41825 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfLTAcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 19:32:33 -0500
Received: by mail-pg1-f194.google.com with SMTP id x8so4014343pgk.8;
        Thu, 19 Dec 2019 16:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RCTh5+RkVcHHfeVRQucg+CwnAKVBZiOfF164k68a6LU=;
        b=gqmnkOWIqwskobsCM7hMzG4V5zbCceVSTaL3qRCI9EJMbB/K5/CvTJUO5x3q0wRzCi
         4M2o+QHIYdfnXxxYiVCGldx8G4FbDwF6DvT2NVQIo+THjMeywRKUfNUUerqwz6xgPHE1
         t5lG8Qmvdwbd2dBHEDgVXy2qKa0GykKryXpBXyHpLhfCcm2Qh770UMYfMnVXU5jvlozK
         CPc1l7ZVtcZ3S/feuRZiaGzjVhb7XAF4aCOQ0kvvL0V3fmAM2QAn2vxDyztUNM96emHJ
         r1qVBDDbrAkopPe8bSUHA4nj9OAvUCtWFbRk/HrIXYxZhsuq7iZJcZcdGcn+Zd23Qi+4
         Chpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RCTh5+RkVcHHfeVRQucg+CwnAKVBZiOfF164k68a6LU=;
        b=CaXmZnZ8jZFsiuQ/O2avGyG3Z1poCP8dXbsKresHUGgfCpUb49Y5E2Y3/7y2O4Bn54
         GmkL85uTXQklwJ4KZxjw/U0UCre6ZEEIPgt7idH1vJGZjR80s+2YOl4ncDpqgm2WycdT
         ncLOIY5knAH1zP14b+RX6NHB3vEGw3/cXzrDnK7OQMy2WU8gQHAKv+lcxhSrNbQwKwgm
         L6JxB35YbwttldHx16s4j/IxziccqfZaHj3GoNVfgkg4qcgmbnVFWHGQkg9g6NJOEWzl
         qJYsitYVobW443eVFUvZd/IKUuzN5g2weyCtYR1FYcPSiP41MrV57rjKyGjmQsVgHjf+
         uy3w==
X-Gm-Message-State: APjAAAWKXIGVor2BgOF3T5OnHL+FhUqaYoDCP+jYmfakfX0vJo/7J3OC
        lo15LSxuYrf7ZqRCATsDvO4=
X-Google-Smtp-Source: APXvYqyTEohHA9IDpoOAHJBlun53OSwwiCttKkjPXp1sh+v9hL5rBdRt1F0HiyLxbwdezOYcXB6i2w==
X-Received: by 2002:aa7:8699:: with SMTP id d25mr12741708pfo.139.1576801952820;
        Thu, 19 Dec 2019 16:32:32 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id a23sm10145845pfg.82.2019.12.19.16.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 16:32:32 -0800 (PST)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     thierry.reding@gmail.com, joro@8bytes.org
Cc:     jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] memory: tegra: Correct reset value of xusb_hostr
Date:   Thu, 19 Dec 2019 16:29:11 -0800
Message-Id: <20191220002914.19043-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220002914.19043-1-nicoleotsuka@gmail.com>
References: <20191220002914.19043-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Tegra X1 (Tegra210) TRM, the reset value of xusb_hostr
field (bit [7:0]) should be 0x7a. So this patch simply corrects it.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/memory/tegra/tegra210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/tegra210.c b/drivers/memory/tegra/tegra210.c
index a3918a96467f..eab4bc01c8bc 100644
--- a/drivers/memory/tegra/tegra210.c
+++ b/drivers/memory/tegra/tegra210.c
@@ -436,7 +436,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.reg = 0x37c,
 			.shift = 0,
 			.mask = 0xff,
-			.def = 0x39,
+			.def = 0x7a,
 		},
 	}, {
 		.id = 0x4b,
-- 
2.17.1

