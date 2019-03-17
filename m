Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB3EC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 19:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A733020896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 19:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajVZgXQm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfCQT75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 15:59:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40722 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727555AbfCQT7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 15:59:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id t5so14763146wri.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 12:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JyVLZC+X6VRpOp18n/UYdDfLCV96Jbo0mbfSyUoMhZA=;
        b=ajVZgXQmOMhLzecb8Q9PIr1Y2NSey1vQYEePK6rotoD8mJXqr+HOTd0vhe2xv86qui
         0NiwhmvDaL8AMtmR4TU1HAdRG5s6Y8YbhVkFWCFiplNHUC4ahnsn8qN/a6HU5YZC7IUt
         uk29mONgmLWEsfdBDVQvgVGzK1UqQWCM9LfZBJp0siioLyfAPTIDUQdfvSkZFQ7Hv39v
         6rVldsZso8kT0E6Uneq8toK27FtAB5VQiieHwvdBMYh5EhNmmaCTFVNllVRh1qqFslBQ
         l8QWoth89cnR5mGAsqH8M8VjHF3EIKS5LrcP8axp0R9d23P4lc0GH5jWjxDdIGkjrYY4
         lBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JyVLZC+X6VRpOp18n/UYdDfLCV96Jbo0mbfSyUoMhZA=;
        b=phA+rJEPh4kR85gvSnC70W0/gWCnkflDTCQzxh/sVhuIntDGgUlJbmH6rdf6E/QDlm
         N+07lGgH059AJOhuV0MdcfDYQoex3IR/lZtPC4yqwgHmplNqiQvSg+JKBq/q/AlKx0Tr
         2G9H/Kj5hfmrwG3TEpFHIZX9NTfoKptJA3xSAHIZOGN5bpVncl5WX9e24cuAuWEbjt7K
         Ie5OcqsEN4RiSr/GrAPTEfYBj28seXjydtmbj7B6qzzfDHoUbA49cITqGSUrIYAib84R
         kejpSGxx6su1Pz/NuUsP392XAqZ/ABC8MWQnmceLzGwLdX/qHJWabAzYB2vv2Ascwoid
         S2RA==
X-Gm-Message-State: APjAAAXXJqWimqhk6OqOlA2pxXNQnTitZ+szU8RWE6mnYQttsjD+ngDT
        iU7CsemmoCZJd/YUMmKJULGE/LKM
X-Google-Smtp-Source: APXvYqwzxmyg67Bvocu4NODPKpY4kN0pIq/fgab5+hyb/PUbxMtHLib84L4wy+pGKLtKcJa4faUhVQ==
X-Received: by 2002:adf:fa8c:: with SMTP id h12mr9355653wrr.75.1552852791922;
        Sun, 17 Mar 2019 12:59:51 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id z1sm7039785wrw.28.2019.03.17.12.59.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 12:59:51 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 09/15] habanalabs: Remove unneeded function pointers
Date:   Sun, 17 Mar 2019 21:59:21 +0200
Message-Id: <20190317195927.26238-10-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190317195927.26238-1-oded.gabbay@gmail.com>
References: <20190317195927.26238-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

Remove pointers to ASIC-specific functions and instead call the functions
explicitly as they are not accessed from outside the ASIC-specific files.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c  | 12 +++---------
 drivers/misc/habanalabs/goya/goyaP.h |  4 +---
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 7e98383ec774..466464c026e0 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -299,7 +299,6 @@ static u32 goya_all_events[] = {
 	GOYA_ASYNC_EVENT_ID_DMA_BM_CH4
 };
 
-static int goya_armcp_info_get(struct hl_device *hdev);
 static void goya_mmu_prepare(struct hl_device *hdev, u32 asid);
 static int goya_mmu_clear_pgt_range(struct hl_device *hdev);
 static int goya_mmu_set_dram_default_page(struct hl_device *hdev);
@@ -539,10 +538,9 @@ static void goya_fetch_psoc_frequency(struct hl_device *hdev)
 static int goya_late_init(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	struct goya_device *goya = hdev->asic_specific;
 	int rc;
 
-	rc = goya->armcp_info_get(hdev);
+	rc = goya_armcp_info_get(hdev);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to get armcp info\n");
 		return rc;
@@ -629,9 +627,6 @@ static int goya_sw_init(struct hl_device *hdev)
 	if (!goya)
 		return -ENOMEM;
 
-	goya->test_cpu_queue = goya_test_cpu_queue;
-	goya->armcp_info_get = goya_armcp_info_get;
-
 	/* according to goya_init_iatu */
 	goya->ddr_bar_cur_addr = DRAM_PHYS_BASE;
 
@@ -2969,7 +2964,6 @@ int goya_test_cpu_queue(struct hl_device *hdev)
 
 static int goya_test_queues(struct hl_device *hdev)
 {
-	struct goya_device *goya = hdev->asic_specific;
 	int i, rc, ret_val = 0;
 
 	for (i = 0 ; i < NUMBER_OF_EXT_HW_QUEUES ; i++) {
@@ -2979,7 +2973,7 @@ static int goya_test_queues(struct hl_device *hdev)
 	}
 
 	if (hdev->cpu_queues_enable) {
-		rc = goya->test_cpu_queue(hdev);
+		rc = goya_test_cpu_queue(hdev);
 		if (rc)
 			ret_val = -EINVAL;
 	}
@@ -4657,7 +4651,7 @@ int goya_send_heartbeat(struct hl_device *hdev)
 	return hl_fw_send_heartbeat(hdev);
 }
 
-static int goya_armcp_info_get(struct hl_device *hdev)
+int goya_armcp_info_get(struct hl_device *hdev)
 {
 	struct goya_device *goya = hdev->asic_specific;
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index ae5e41bc8f7f..b99d92f197eb 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -143,9 +143,6 @@ enum goya_fw_component {
 };
 
 struct goya_device {
-	int (*test_cpu_queue)(struct hl_device *hdev);
-	int (*armcp_info_get)(struct hl_device *hdev);
-
 	/* TODO: remove hw_queues_lock after moving to scheduler code */
 	spinlock_t	hw_queues_lock;
 
@@ -176,6 +173,7 @@ void goya_debugfs_led_set(struct hl_device *hdev, u8 led, u8 state);
 void goya_set_pll_profile(struct hl_device *hdev, enum hl_pll_frequency freq);
 void goya_add_device_attr(struct hl_device *hdev,
 			struct attribute_group *dev_attr_grp);
+int goya_armcp_info_get(struct hl_device *hdev);
 void goya_init_security(struct hl_device *hdev);
 u64 goya_get_max_power(struct hl_device *hdev);
 void goya_set_max_power(struct hl_device *hdev, u64 value);
-- 
2.17.1

