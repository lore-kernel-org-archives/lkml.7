Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1040AC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 09:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B7C20835
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 09:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5dfoIff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfEAJ6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 05:58:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36391 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfEAJ6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 05:58:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id o4so12121775wra.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 02:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=j7DKKMxaLQu9us8VQ+qsRX5RqdhD8dj0HhBnf8jY/mo=;
        b=H5dfoIff9/xzuWIY4G8ErpsYCuuffF5HECzMjHWg4q6/lihmHyt+1dhQnP3hDovW10
         JGpU8dqULvPqMhngeT/YTKiU0RBqEUkWVqy7u9a23xSR5FRGzFWjoU+kttIvUacxpvwN
         DVNZgF7vCNWuP/OOYaDkltQvn/Kd7aCfCC1gq4JFE9zJt460fQUG4lTrsAktsKD6oz81
         mza7tt+q8LIJCFRMwhz1DDdz2stfJiVNnGQRFbnL4y9w1IFyOjyGKb2u+ulR4ONUSooT
         j8V/s0Eo85KgXE9jjT+xeuC6/jrrJ8FQGV8cApTmNPNzk6uvB5nFVPRHTo9YueCcjKVX
         MAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=j7DKKMxaLQu9us8VQ+qsRX5RqdhD8dj0HhBnf8jY/mo=;
        b=Qtea8htSIVRLfEAP9UR2ZN+DbwWxni2ZYUvlnlnqXEH+FGFRWoRBu5iREu93GhStd3
         3E2rF483NxM3GMQKQWlWfWK1tfdrcCWkiWaM6vHjSoFpeslLADQZf71I3fioPfT50dwX
         upktUnDxjdO4vvwK+sOLltijtwCSMk0spWNdMU5sgNRgIuUUgzYajtCZTQ9rR4S6+ufQ
         /EZQN5QwlOT7J/Duz/XPdS3djUjh+E5zlXUt88/V3s55OyIpMM3xslWaNvR4lR1E3tvv
         EfNG/U5E4UAhqlfC7hqk0NJRlsksPhsyyr1TmHp5L87nyT2P+Pe5Pi+lhlBi1AeL25KY
         oVtg==
X-Gm-Message-State: APjAAAUrCjgWkKuqSvdM61JfHSpk3MLvMZWv6TqzTy5ctx2tv7I0exrQ
        ap9pO2LtzCF+qz9B37m4wIyteKZB
X-Google-Smtp-Source: APXvYqwETLc7n0z1tL1lm5bTddbjf8CoDhxAHOJAAOWS8Cz/DXICXjX9Cstx8M6kGDCY+XqTnDSw5g==
X-Received: by 2002:adf:e684:: with SMTP id r4mr32993979wrm.169.1556704693520;
        Wed, 01 May 2019 02:58:13 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id c18sm17683519wrb.16.2019.05.01.02.58.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 02:58:12 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Dalit Ben Zoor <dbenzoor@habana.ai>
Subject: [PATCH 1/2] habanalabs: remove call to cs_parser()
Date:   Wed,  1 May 2019 12:58:08 +0300
Message-Id: <20190501095809.6956-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dalit Ben Zoor <dbenzoor@habana.ai>

There is no need to parse the command submission when doing memset
of the device memory using the DMA engine because only the driver calls
the memset function and therefore, the CS is trusted and doesn't require
validation and patching.

Signed-off-by: Dalit Ben Zoor <dbenzoor@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c | 27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 04e4ed8a0be6..9fc8b6e1369d 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4398,7 +4398,6 @@ static int goya_memset_device_memory(struct hl_device *hdev, u64 addr, u32 size,
 				u64 val, bool is_dram)
 {
 	struct packet_lin_dma *lin_dma_pkt;
-	struct hl_cs_parser parser;
 	struct hl_cs_job *job;
 	u32 cb_size, ctl;
 	struct hl_cb *cb;
@@ -4438,36 +4437,16 @@ static int goya_memset_device_memory(struct hl_device *hdev, u64 addr, u32 size,
 	job->user_cb->cs_cnt++;
 	job->user_cb_size = cb_size;
 	job->hw_queue_id = GOYA_QUEUE_ID_DMA_0;
+	job->patched_cb = job->user_cb;
+	job->job_cb_size = job->user_cb_size +
+			sizeof(struct packet_msg_prot) * 2;
 
 	hl_debugfs_add_job(hdev, job);
 
-	parser.ctx_id = HL_KERNEL_ASID_ID;
-	parser.cs_sequence = 0;
-	parser.job_id = job->id;
-	parser.hw_queue_id = job->hw_queue_id;
-	parser.job_userptr_list = &job->userptr_list;
-	parser.user_cb = job->user_cb;
-	parser.user_cb_size = job->user_cb_size;
-	parser.ext_queue = job->ext_queue;
-	parser.use_virt_addr = hdev->mmu_enable;
-
-	rc = hdev->asic_funcs->cs_parser(hdev, &parser);
-	if (rc) {
-		dev_err(hdev->dev, "Failed to parse kernel CB\n");
-		goto free_job;
-	}
-
-	job->patched_cb = parser.patched_cb;
-	job->job_cb_size = parser.patched_cb_size;
-	job->patched_cb->cs_cnt++;
-
 	rc = goya_send_job_on_qman0(hdev, job);
 
-	job->patched_cb->cs_cnt--;
 	hl_cb_put(job->patched_cb);
 
-free_job:
-	hl_userptr_delete_list(hdev, &job->userptr_list);
 	hl_debugfs_remove_job(hdev, job);
 	kfree(job);
 	cb->cs_cnt--;
-- 
2.17.1

