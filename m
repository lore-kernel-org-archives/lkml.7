Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA33C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 17:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E352081C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 17:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8p3HJyr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfEARoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 13:44:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38282 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfEARoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 13:44:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id k16so25407342wrn.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 10:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wJZDS0KIBPXQ6pbUj5uv9TOZTIGNklQftlad1Elqw0s=;
        b=A8p3HJyr5b69poobuxyFrsvV4+jZ/U76GvrzE/KM6Il66fFKfep+oboBBniJPCCXR6
         Tla4dA9wCd0B+TL+by/pY8qjHhpVGFT+Xf5fYketN+NrP+xGlBr3HF4zCR3nBNLUKPLK
         yBvOvq4K8zORIFPczf10Obewn1EzmhQwYK/MuMyOx3wNItGGmVg9iZYKggmJhXteZWra
         gul3nXRNGGEpDjz8PeVtw9uAaPXgMW7kmcVZzK7AYugBCp326qUyvFLmaq2BST4DQkh5
         dvQFf4tKDTH4ux7F94cSFywn6ZwIPGV90CJNqIgde0XOSBRlvPqod76usbDfGSGybVST
         pEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wJZDS0KIBPXQ6pbUj5uv9TOZTIGNklQftlad1Elqw0s=;
        b=HcW7imDDDTfvkExXw4G2j7upRMzwA3yK2ZS8cSDl+r7JAvF1AZ16q8eR/9/HxZCkFn
         VmX2cgKYe3qNLxZNXpQTQypXcrSly3FyzokOxQlK4M8BMxbspr9E7KYRRZB/xG6JW221
         Y7jwI2VcGHddF81XhMBs+MEswuYfzOdHrBT0ytISSpQUFmrxQF3890omEJRfHammj1cB
         D4y5p7xL+3hoQCU6EdGI8kFucvtHW3pd5kMqJPekzU5UhLVn9mkA00tfJQbuEbHWKVu7
         3U6poDASZ5MkdiydwBrwelIFm9GsPY4y/CTI1ZoGr0mN+xsJIcc7cKC9OxIo/oNWYLfZ
         Edog==
X-Gm-Message-State: APjAAAWdrGUdWjPAWCoeN+zhRGoOq92Bg3VNhDxNVYFqdqjkqnGUCbSW
        HrU0mQ57KM1tF3E1/FS0XsBQVGoG
X-Google-Smtp-Source: APXvYqy6xOmcxBaOfI3KzWzqsu0dgJF+TCvXQCJ7lFtr3xGBJepWaLX8V72KNDpBnPbe3fSm/pzlXA==
X-Received: by 2002:a5d:6384:: with SMTP id p4mr3756492wru.208.1556732683902;
        Wed, 01 May 2019 10:44:43 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id h81sm9923329wmf.33.2019.05.01.10.44.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 10:44:43 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Dalit Ben Zoor <dbenzoor@habana.ai>
Subject: [PATCH 1/3] habanalabs: remove redundant member from parser struct
Date:   Wed,  1 May 2019 20:44:38 +0300
Message-Id: <20190501174440.28557-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dalit Ben Zoor <dbenzoor@habana.ai>

use_virt_addr member was used for telling whether to treat the
addresses in the CB as virtual during parsing. We disabled it only
when calling the parser from the driver memset device function,
and since this call had been removed, it should always be enabled.

Signed-off-by: Dalit Ben Zoor <dbenzoor@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/command_submission.c | 1 -
 drivers/misc/habanalabs/goya/goya.c          | 2 +-
 drivers/misc/habanalabs/habanalabs.h         | 3 ---
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
index c4ab694b51b5..6fe785e26859 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -93,7 +93,6 @@ static int cs_parser(struct hl_fpriv *hpriv, struct hl_cs_job *job)
 	parser.user_cb_size = job->user_cb_size;
 	parser.ext_queue = job->ext_queue;
 	job->patched_cb = NULL;
-	parser.use_virt_addr = hdev->mmu_enable;
 
 	rc = hdev->asic_funcs->cs_parser(hdev, &parser);
 	if (job->ext_queue) {
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 31dc3b872f9e..ba6790f9ec6b 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -3903,7 +3903,7 @@ int goya_cs_parser(struct hl_device *hdev, struct hl_cs_parser *parser)
 	if (!parser->ext_queue)
 		return goya_parse_cb_no_ext_queue(hdev, parser);
 
-	if ((goya->hw_cap_initialized & HW_CAP_MMU) && parser->use_virt_addr)
+	if (goya->hw_cap_initialized & HW_CAP_MMU)
 		return goya_parse_cb_mmu(hdev, parser);
 	else
 		return goya_parse_cb_no_mmu(hdev, parser);
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index f08f71982585..0da80e8eab42 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -779,8 +779,6 @@ struct hl_cs_job {
  * @patched_cb_size: the size of the CB after parsing.
  * @ext_queue: whether the job is for external queue or internal queue.
  * @job_id: the id of the related job inside the related CS.
- * @use_virt_addr: whether to treat the addresses in the CB as virtual during
- *			parsing.
  */
 struct hl_cs_parser {
 	struct hl_cb		*user_cb;
@@ -793,7 +791,6 @@ struct hl_cs_parser {
 	u32			patched_cb_size;
 	u8			ext_queue;
 	u8			job_id;
-	u8			use_virt_addr;
 };
 
 
-- 
2.17.1

