Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179B9C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAAA220880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBBwDtpK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731403AbfGPJCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 05:02:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37445 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfGPJCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 05:02:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id f17so17827428wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 02:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Y8N+WQ8vFvhuK+iDw7SzengsJ8xM3eLZ1NcZ88yLqJE=;
        b=lBBwDtpKYnwj5om08Ld9G7MzFqUi2XQUS3hoolE7MbvD+IP5pGy7hoaNmH0ZVjQQzX
         lOe/Gd9oBymwrEy7NIds1XP9IfK5HxUWPa2AkuLbCYKFApHuEgYdxUGShc3GGdFjmEie
         rDO4DkfzNTQKgVWcZaGfp6iy/5BQgaWkWExcqz05DeOBORTx/bLVki6D3adq7utg3l8Y
         bgt+uUzQT05kvdAXacF1la9HxT2OFxPKXosPndZah8jV1Qq+Z2XK7XfhHfWTLAEjqT39
         v9mNNRuGF8PWYL0sZmhacwxfDBvFMC5FG1TngmQorrNHUgvKpODE45n/ebOvSP410ZJZ
         uvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y8N+WQ8vFvhuK+iDw7SzengsJ8xM3eLZ1NcZ88yLqJE=;
        b=BUl1KcX37cAIyXsXClAC7yEXCwzS1S84mup63NTDmZoP0bh+7HpnFhvB62Md9E2IKV
         h7OXHPizzxAzwHeSynAgnSEz0A+nIvU29sS61zFWcp3EHqpPoXRcsfi+AxZFhwPXn2Th
         bxOetjBB8mHpCIYqb+nZqxLHCZ15WaQhbOCQvRmnf6LKhb6lGhXJi8Anp4IeTkdhfPJr
         xwZP7c4zwYXB3LVGRaMJ90wZvjvHL1ZuQ5FptHu5ji0yKDNp4FIU4XUw8UJuJU1C7ZEX
         r96gZAvUrsoOMssqG4tTfkLHGYvw0ezEzlPCH+ruFG/W55JZuUMJpuDZoS4G3RVYofmZ
         t3iQ==
X-Gm-Message-State: APjAAAXuuD2DnL9uoz6UvMZecwqiC0nduGqWZ8gDJLNsvJczbl7bPoLT
        eFmoPmEzHeIE1O+BxeXp7jL8gTyb
X-Google-Smtp-Source: APXvYqwHIc20ODAPb6mulMbAtNMWYn4LwUWctw2oHTq5NzXI9hJt77iTnNT2kS7l0SbH8w7LtYPzLQ==
X-Received: by 2002:a1c:7d4e:: with SMTP id y75mr29719243wmc.169.1563267740927;
        Tue, 16 Jul 2019 02:02:20 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id b15sm32361803wrt.77.2019.07.16.02.02.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 02:02:20 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: add comments on INFO IOCTL
Date:   Tue, 16 Jul 2019 12:02:18 +0300
Message-Id: <20190716090218.12379-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds some in-code documentation on the different opcodes of the
INFO IOCTL.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 include/uapi/misc/habanalabs.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 3956c226ca35..a5a1d0e7ec82 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -75,7 +75,19 @@ enum hl_device_status {
 	HL_DEVICE_STATUS_MALFUNCTION
 };
 
-/* Opcode for management ioctl */
+/* Opcode for management ioctl
+ *
+ * HW_IP_INFO         - Receive information about different IP blocks in the
+ *                      device.
+ * HL_INFO_HW_EVENTS  - Receive an array describing how many times each event
+ *                      occurred since the last hard reset.
+ * HL_INFO_DRAM_USAGE - Retrieve the dram usage inside the device and of the
+ *                      specific context. This is relevant only for GOYA device.
+ * HL_INFO_HW_IDLE    - Retrieve information about the idle status of each
+ *                      internal engine.
+ * HL_INFO_DEVICE_STATUS - Retrieve the device's status. This opcode doesn't
+ *                         require an open context.
+ */
 #define HL_INFO_HW_IP_INFO	0
 #define HL_INFO_HW_EVENTS	1
 #define HL_INFO_DRAM_USAGE	2
-- 
2.17.1

