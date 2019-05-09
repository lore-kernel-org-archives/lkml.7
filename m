Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39268C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E7D2177E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBI0XAob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfEITBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 15:01:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34173 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbfEITBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 15:01:44 -0400
Received: by mail-wm1-f68.google.com with SMTP id m20so4794127wmg.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 12:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Rgk9P1zlX9vNqq+N6qE9gQvpeBtUXd8/IvWvzeY1nZI=;
        b=UBI0XAobkjKTEaKxKiq6t8fiTA77iK7IuKR1KZ9/joqc6wZy5FVQsHmkiGsIsRAHz5
         ZiAV2S41OG0DDrRnm5wG5JNoR74pi2zIMq+ypL7PEbxenrk25duyMbjHF83YyjPxvkLZ
         lW5oy+hGXBWE33Ph5OpTuau6rSwfidErkgEEtd94cVUEiLWAE07sH8fgjHLnsAr/YXwS
         lUTvp/6z6OE26bYD1ALODMGw2v/uiSYe/PkG60t/l6/wUdJ/5aIdYf4hiSv/nJDXUBct
         wyUkwDYmPxah35cbcMLhFKnB3Ol6HbhnhGNsAM0692u3ordcuhRv031j4BjoUeHVmEjU
         WXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Rgk9P1zlX9vNqq+N6qE9gQvpeBtUXd8/IvWvzeY1nZI=;
        b=bJrkayOWa1WFYN46ORIu1CM6ohiF+fjBvOZjeLyViek8kiv/Rgrz4QhomwU7FJmIio
         d/C1OtYkXRYdaqMwrXVABj7CF325S1d+i7po7vxZnK8pQtju4p10fCpjh2JenUCvwG6a
         s5WaaSZK4X2PJbZ/Ew5t7qI5eAD+iK9IfdAT5b182KzoOUJBUrQwr1RYjO5VkaIjkTxQ
         vpuW14bYLPl7inaU97oADCuDnvmF9GV5u/mwH/dp73XHb4d0rvj7g2GyhX3p/ws2Kfam
         uIkXlFIzCEQ5Liq4MB87MYQKm7INOdxmqo0hQYqmzUkJAITqOpEMmYnfTuQRc2H+mhpF
         NJSg==
X-Gm-Message-State: APjAAAUedc4xZ1ggRQVnYmvNzYenBJ+9+nyqQxJd/hTH7pbdcpTflXon
        ffUK/9uV+WdvdGy999abS9sbkF7s
X-Google-Smtp-Source: APXvYqxzRx5Buz6EIjtvH4aOM216ZGEdBxGMzOgsH9RJNJ7kb5Iu+8LMVo5yg552CohYRcgdWhEA1Q==
X-Received: by 2002:a05:600c:24ca:: with SMTP id 10mr4189542wmu.45.1557428502270;
        Thu, 09 May 2019 12:01:42 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id j1sm2833671wrt.52.2019.05.09.12.01.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 12:01:41 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 1/3] habanalabs: remove redundant CB size adjustment
Date:   Thu,  9 May 2019 22:01:33 +0300
Message-Id: <20190509190135.5634-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver-initiated DMA jobs are synchronized jobs, i.e. the driver polls on
fence object until the job is finished. There is no interrupt from the
device. Therefore, no need to add space for 2 * msg_prot packets to the
end of the CB. Only a single msg_prot is needed (to write the fence).

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index ccf9d925b6ed..756921c52cf7 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2827,12 +2827,6 @@ static int goya_send_job_on_qman0(struct hl_device *hdev, struct hl_cs_job *job)
 
 	goya_qman0_set_security(hdev, true);
 
-	/*
-	 * goya cs parser saves space for 2xpacket_msg_prot at end of CB. For
-	 * synchronized kernel jobs we only need space for 1 packet_msg_prot
-	 */
-	job->job_cb_size -= sizeof(struct packet_msg_prot);
-
 	cb = job->patched_cb;
 
 	fence_pkt = (struct packet_msg_prot *) (uintptr_t) (cb->kernel_address +
@@ -4452,8 +4446,7 @@ static int goya_memset_device_memory(struct hl_device *hdev, u64 addr, u32 size,
 	job->user_cb_size = cb_size;
 	job->hw_queue_id = GOYA_QUEUE_ID_DMA_0;
 	job->patched_cb = job->user_cb;
-	job->job_cb_size = job->user_cb_size +
-			sizeof(struct packet_msg_prot) * 2;
+	job->job_cb_size = job->user_cb_size + sizeof(struct packet_msg_prot);
 
 	hl_debugfs_add_job(hdev, job);
 
-- 
2.17.1

