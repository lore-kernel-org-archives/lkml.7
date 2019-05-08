Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76448C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44DE721479
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tv8Z8svL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfEHKGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 06:06:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44937 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfEHKGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 06:06:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id c5so1153692wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 03:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=W76017xpCMGd/eRYNl/6tdtFy+bghvWppnjb8gEgLwo=;
        b=tv8Z8svLeF/GtceXkMecES5sO7KooVIDDL6QYugLmBuDt8JA+ODM9uZG0AGVsyAO7k
         UjZs11IHZbvaZ/Db3orpmOFdzX9//tq5JxpXkxkviH+YF0VeThH3w6dSMgH4/t6j0VDC
         yXqJAwpcTRWDTwfxwCO/F/HWMKy/IcqlJR/GDvsa8PREccPQS4TZLPXLbh+LM5DfvmVt
         1hwAIaO0QXl+qhWYxO2XCKOdrVM93OJa7RPu/MaBuY2tXWPokVhNZrHWgcbehYN+/UfY
         a3KcjLjwzNBmpFBET1eqpCoIVWdxbBjF+CQeewWyR1NceUr4gwd7GJCsx083WoloM6vu
         Azmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=W76017xpCMGd/eRYNl/6tdtFy+bghvWppnjb8gEgLwo=;
        b=lhPwetmG02PN8KxCuLtXmjWC6gPKffx8H72TYP5s7gRSaYdbtmhZ18Y67OAHFJNCKJ
         jmP0K9jyjuuCUbgbPfPvpYcS38DOUtjaRdk47VV2pvrJkBpWYec1rk+WFDt24gUeJNAZ
         3Vx8rUgbv5B/rmqyPW8NCsosK+TWVdin590QB5fr7aRXA8AY7341VnA2ULknnrHIUCna
         klcABp8lteYnLo9GZRLjxMGG0tfX6X0BhQD3PNjpr0/+7rnOiJX1w0TWkLI+6PAQEvsO
         6vBgWoRRDs4ZH6u5PDLdmi0ZgJrZXc3cZPOIzRGjqEJBmmlYc1/rEP3bxWwVQaucDRX3
         51Rw==
X-Gm-Message-State: APjAAAUp1gHSVAcL6gktP416WsMnj+oOf0kl/jXd6LEMjyRCFaCFaHMG
        a0hvd4RUsSEXVMxk46E2EF/a15mK
X-Google-Smtp-Source: APXvYqw4vYnN0BlzV5FVJgNHBZdG5eUUVXLEsMYQeCRKmNyLiB4w4NoBU+sQP+0C+IGnnTwPFu0acQ==
X-Received: by 2002:adf:b611:: with SMTP id f17mr7662506wre.162.1557309978886;
        Wed, 08 May 2019 03:06:18 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id d3sm4583273wmf.46.2019.05.08.03.06.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 03:06:18 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: check to load F/W before boot status
Date:   Wed,  8 May 2019 13:06:16 +0300
Message-Id: <20190508100616.2703-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the order of checks when initializing the device CPU.
We want first to check if we need to load the F/W, and only if we need to,
then we want to check the status of the CPU boot program.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index aaa88d442ffe..ccf9d925b6ed 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2277,14 +2277,14 @@ static int goya_init_cpu(struct hl_device *hdev, u32 cpu_timeout)
 	goya_read_device_fw_version(hdev, FW_COMP_UBOOT);
 	goya_read_device_fw_version(hdev, FW_COMP_PREBOOT);
 
-	if (status == CPU_BOOT_STATUS_SRAM_AVAIL)
-		goto out;
-
 	if (!hdev->fw_loading) {
 		dev_info(hdev->dev, "Skip loading FW\n");
 		goto out;
 	}
 
+	if (status == CPU_BOOT_STATUS_SRAM_AVAIL)
+		goto out;
+
 	rc = goya_push_linux_to_device(hdev);
 	if (rc)
 		return rc;
-- 
2.17.1

