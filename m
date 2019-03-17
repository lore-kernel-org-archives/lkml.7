Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88527C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 19:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501C020896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 19:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vPFp2opo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfCQT7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 15:59:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40399 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfCQT7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 15:59:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id u10so8132494wmj.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 12:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JNlU4Y+Fl2ftKNKHbVDXmkOuyhXPOFmvteiR7RHWUss=;
        b=vPFp2opoRCZyMZOYhAzS5g/W5g8VUOy9zdH4KjFi/zi9js0pE9ZTz4EgLBmx+38SCq
         bG31RcFXTJtlx8S/isiMPd9fpGNPIBK9rGHZaHSWx/XIIsfQaj2bV+Gaba3M9AhbU1ih
         V0m4L4YkaLYBAh/a/2+DMYDZK4DI6lNLOmK4OCeED2eCe/QKc9hhStfw8Ldf9nJNjge1
         0sAYGQd6VAjgwmBFwniYjR1fsw5RYuhCkFALQap7d7zOuOlVE/mM4Xxc8ZlrlDcaaE46
         rnwqokKjrmjJfz/2Y8/J/yz/A+3QF5ogg1uqVEjqtPS9W9LkfH/hi+XQTh2OGlecdY67
         LPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JNlU4Y+Fl2ftKNKHbVDXmkOuyhXPOFmvteiR7RHWUss=;
        b=Oxt/ftSDytQpc2H2HJxsgsl7S2ZNmUwu+IJhcGkpNP42XI2RWkWAqyKZgtKicuFMJ9
         cgys7TvTVYcD4ppAfZb/nrS7Bdx4rJafaFjUJ3BikdWhPXq1c0m3N8RiiRK6n/k3DxX5
         3k6mahxxBEygbQ/aXHiuwqCIPAI0Ql0QUWz0dUUxGQp0KUcMJwTPjWCn14qGBGiYYyq2
         kDqcgScEPrj48x0AKqHoSqiYY0zXxPZP3htqWeyer8xMMSQcV1eMUIsmAjGU4yaV8Oub
         ZH0LAaPLznvC8f3bIqBxvx+oA2VXNUpzqwYAG+EGYI0sZBPwst/qfLdMktTjHzuGovwH
         kbuQ==
X-Gm-Message-State: APjAAAVlPFUhoDdjSPd7DEaLHN9vi1yKZk9knrgwjZmKahkx62eVNGMB
        2fHXfTL5RR72sO6DsbuXoiHFzHnO
X-Google-Smtp-Source: APXvYqwGne1UKfBM3ZLINvyIWldE9KtrHS0leQ+lA+gz6lPkQiqF0WF93FTSpZnRiS6KUq8uqKDZEA==
X-Received: by 2002:a05:600c:2301:: with SMTP id 1mr8401109wmo.116.1552852776242;
        Sun, 17 Mar 2019 12:59:36 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id z1sm7039785wrw.28.2019.03.17.12.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 12:59:35 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Igor Grinberg <igrinberg@habana.ai>
Subject: [PATCH 01/15] habanalabs: add new device CPU boot status
Date:   Sun, 17 Mar 2019 21:59:13 +0200
Message-Id: <20190317195927.26238-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190317195927.26238-1-oded.gabbay@gmail.com>
References: <20190317195927.26238-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Grinberg <igrinberg@habana.ai>

This patch adds a definition of a new status in the device CPU boot stages
and add the handling of the new status.

Signed-off-by: Igor Grinberg <igrinberg@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c          | 5 +++++
 drivers/misc/habanalabs/include/hl_boot_if.h | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index ea979ebd62fb..0185f11c5577 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2550,6 +2550,11 @@ static int goya_init_cpu(struct hl_device *hdev, u32 cpu_timeout)
 				"ARM status %d - DDR initialization failed\n",
 				status);
 			break;
+		case CPU_BOOT_STATUS_UBOOT_NOT_READY:
+			dev_err(hdev->dev,
+				"ARM status %d - u-boot stopped by user\n",
+				status);
+			break;
 		default:
 			dev_err(hdev->dev,
 				"ARM status %d - Invalid status code\n",
diff --git a/drivers/misc/habanalabs/include/hl_boot_if.h b/drivers/misc/habanalabs/include/hl_boot_if.h
index 7475732b9996..4cd04c090285 100644
--- a/drivers/misc/habanalabs/include/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/hl_boot_if.h
@@ -18,7 +18,8 @@ enum cpu_boot_status {
 	CPU_BOOT_STATUS_IN_SPL,
 	CPU_BOOT_STATUS_IN_UBOOT,
 	CPU_BOOT_STATUS_DRAM_INIT_FAIL,
-	CPU_BOOT_STATUS_FIT_CORRUPTED
+	CPU_BOOT_STATUS_FIT_CORRUPTED,
+	CPU_BOOT_STATUS_UBOOT_NOT_READY,
 };
 
 enum kmd_msg {
-- 
2.17.1

