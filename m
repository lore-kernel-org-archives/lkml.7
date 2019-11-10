Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACADDC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 21:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C632077C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 21:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tepStVoi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfKJVzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 16:55:39 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34302 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfKJVzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 16:55:39 -0500
Received: by mail-wr1-f65.google.com with SMTP id e6so12621935wrw.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 13:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=802X/0I8nW87iZxQ0qhEL5M55KFKYdUCM0ggeRN6az8=;
        b=tepStVoiDlO3fAQzsMKbUMTj4bM+ceo8m1lHfvZl52eI5B2Cojs0KWLoNS6vt57wP0
         yoYLH5BlQiyU7SyGONyjdayUbNO/meA7IzLFS9hyco+s/JPr8t1UZWNSbceWgsZMGVpA
         PL3i6y+//xGTaSaJNPkEVUqYPwi/QvLBq1DtH97GphWUv0/NpCWh8ml2ZOh5NnI8xaz+
         OkciJp+HqBk22aabcBZ0zFcKDKnq6CQV4V8Dsz33uqwfHuu7eM9i8xgOJxZpZGbwX3rb
         Li16n7yJkltDRIa6OnuOYCSbOvvu8wkdpdfBQ0IXLb9ZqPA+MuIAseAhehvXakGugLG4
         QwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=802X/0I8nW87iZxQ0qhEL5M55KFKYdUCM0ggeRN6az8=;
        b=cZSSOfqzD4Kd7xO0/NTK8QCyMC91Fe74yOS/kBAsqah+JLGh8XLQbIZw+ePu2GZsry
         +fiwYvS9cQXSw5Je1aIgBuLVjqd54O6BVsCpltwylTRE6nd0HAVFkzKseIRY0GU8vTll
         dB+VXdOMPc33vkx1uuj12q77w2uSio3HD4EyMqIatGHHYv6hvw6RnKimxG6X+c70mxv8
         T1f2eXCzGXChDtOxki5eQw+lEkXMFj/A2w6uyhmFrPTXzTJQoAzTmahvBjzN5V3sDmCJ
         7X06UpSF6MJi1QGm18Ak2nd1cF3p758g8GvtVwcia/iIEB52wu00unSic9BEag2q4VvB
         Pqsw==
X-Gm-Message-State: APjAAAU+19c0X2l1bLzwgEktXdT5Z5NcPMT41g10/2ofAnD4XbWn3G3Q
        kXPhpTWV/voi0L3VVNWZIDv0+HEdr5k=
X-Google-Smtp-Source: APXvYqz5EiBqezEmST9bha5x5Er1nMydqsxXCG40ssy+ZbUFURh7omWR+KF7gNWqC1i37SbjxGxlSw==
X-Received: by 2002:a5d:67c2:: with SMTP id n2mr9997135wrw.222.1573422935619;
        Sun, 10 Nov 2019 13:55:35 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id d11sm14555824wrn.28.2019.11.10.13.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2019 13:55:35 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 1/6] habanalabs: read F/W versions before failure
Date:   Sun, 10 Nov 2019 23:55:28 +0200
Message-Id: <20191110215533.754-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the read of the F/W boot versions before exiting on possible failures
of the F/W boot. This will help debug boot failures as we will be able to
know the F/W boot version.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index d3ee9e2aa57e..4e767e1d78e4 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2296,6 +2296,10 @@ static int goya_init_cpu(struct hl_device *hdev, u32 cpu_timeout)
 		10000,
 		cpu_timeout);
 
+	/* Read U-Boot version now in case we will later fail */
+	goya_read_device_fw_version(hdev, FW_COMP_UBOOT);
+	goya_read_device_fw_version(hdev, FW_COMP_PREBOOT);
+
 	if (rc) {
 		dev_err(hdev->dev, "Error in ARM u-boot!");
 		switch (status) {
@@ -2347,10 +2351,6 @@ static int goya_init_cpu(struct hl_device *hdev, u32 cpu_timeout)
 		return -EIO;
 	}
 
-	/* Read U-Boot version now in case we will later fail */
-	goya_read_device_fw_version(hdev, FW_COMP_UBOOT);
-	goya_read_device_fw_version(hdev, FW_COMP_PREBOOT);
-
 	if (!hdev->fw_loading) {
 		dev_info(hdev->dev, "Skip loading FW\n");
 		goto out;
-- 
2.17.1

