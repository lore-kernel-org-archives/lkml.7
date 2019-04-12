Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E578C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6B92186A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l3YyFirG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfDLHT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 03:19:59 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37770 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbfDLHT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 03:19:56 -0400
Received: by mail-pl1-f196.google.com with SMTP id w23so4675873ply.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 00:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bIIDGU5Rwf2fFuegJzHqGLPfs4xhEbyGoQqnP916+kk=;
        b=l3YyFirGkLQLSxIFRy9SRpGNBcYwgZAGQN3KdHBQFf913ZChc1dlAhdZhWra6L6+/p
         tLEitNFN+U856bF2RSWqypLr4RBVDYgYilsj1OGQF3IDuV8EQSRwabC5WXXiYwlNBwar
         20m+SkRbOLcTcMPEJxj7357gufpRqpBPK2rpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bIIDGU5Rwf2fFuegJzHqGLPfs4xhEbyGoQqnP916+kk=;
        b=kIDurCcO5BEwIvNodNu3dHlceGarBv94l9mheop9u34Y/6PJ/vVMH0O5HtrJgOW6wc
         JI8muwuJFG/4gL7P/kstK3pHJKq+EsbsneN76pFLmH/0g4eqjvMbl75Kle0y08dDPj/y
         DvKYhebVnzINwsSu1TyKUWOBO1ZVFwLr2XNtvY9uVYGTS/gcuUuL3RBLKZVPEEqqMqM1
         t19rtw/WKVSXtxwRDqtINO+tlW40KYGC/j42k3CXEajaJauq5obH/cIdbiorL21WfR7c
         XOPqtKKYLQ7Aef6rWlj0Ey9OgTwYpZoXriZfee7r56Rntqq2K2U+iYi3XbQRlvk5JbD2
         yzXg==
X-Gm-Message-State: APjAAAWAb8KD1co6hkZJLXq525sDMOdeHXWNws7c4OALgHg3wQlJzSRF
        SHDRibRjiQ4etIefbW9dIxSttG68MtAKAA==
X-Google-Smtp-Source: APXvYqzvZ7ZQWvVShXigy4ITflcmTE78X8S3719acciMIx0Z7fzql4J2wEaJPWDAHhvo7V6Cb1kKXQ==
X-Received: by 2002:a17:902:8bc3:: with SMTP id r3mr56525988plo.53.1555053595367;
        Fri, 12 Apr 2019 00:19:55 -0700 (PDT)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id k124sm67466862pgc.65.2019.04.12.00.19.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 00:19:54 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 7/7] mfd: cros_ec: differentiate SCP from EC by feature bit.
Date:   Fri, 12 Apr 2019 15:18:51 +0800
Message-Id: <20190412071851.60332-8-pihsun@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190412071851.60332-1-pihsun@chromium.org>
References: <20190412071851.60332-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

System Companion Processor (SCP) is Cortex M4 co-processor on some
MediaTek platform that can run EC-style firmware. Since a SCP and EC
would both exist on a system, and use the cros_ec_dev driver, we need to
differentiate between them for the userspace, or they would both be
registered at /dev/cros_ec, causing a conflict.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
Changes from v7:
 - Address comments in v7.
 - Rebase the series onto https://lore.kernel.org/patchwork/patch/1059196/.

Changes from v6:
 - No change.

Changes from v5:
 - No change.

Changes from v4:
 - No change.

Changes from v3:
 - No change.

Changes from v2:
 - No change.

Changes from v1:
 - New patch extracted from Patch 5.
---
 drivers/mfd/cros_ec_dev.c            | 10 ++++++++++
 include/linux/mfd/cros_ec.h          |  1 +
 include/linux/mfd/cros_ec_commands.h |  2 +-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index a3b319913097..5b52b648abf2 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -432,6 +432,16 @@ static int ec_device_probe(struct platform_device *pdev)
 		ec_platform->ec_name = CROS_EC_DEV_ISH_NAME;
 	}
 
+	/* Check whether this is actually a SCP rather than an EC. */
+	if (cros_ec_check_features(ec, EC_FEATURE_SCP)) {
+		dev_info(dev, "CrOS SCP MCU detected.\n");
+		/*
+		 * Help userspace differentiating ECs from SCP,
+		 * regardless of the probing order.
+		 */
+		ec_platform->ec_name = CROS_EC_DEV_SCP_NAME;
+	}
+
 	/*
 	 * Add the class device
 	 * Link to the character device for creating the /dev entry
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index 109292a60499..a3e3d6beb19a 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -25,6 +25,7 @@
 #define CROS_EC_DEV_NAME "cros_ec"
 #define CROS_EC_DEV_PD_NAME "cros_pd"
 #define CROS_EC_DEV_ISH_NAME "cros_ish"
+#define CROS_EC_DEV_SCP_NAME "cros_scp"
 
 /*
  * The EC is unresponsive for a time after a reboot command.  Add a
diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index d5bf909af661..80a904ed7d7f 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -884,7 +884,7 @@ enum ec_feature_code {
 	EC_FEATURE_REFINED_TABLET_MODE_HYSTERESIS = 37,
 	/* EC supports audio codec. */
 	EC_FEATURE_AUDIO_CODEC = 38,
-	/* EC Supports SCP. */
+	/* The MCU is a System Companion Processor (SCP). */
 	EC_FEATURE_SCP = 39,
 	/* The MCU is an Integrated Sensor Hub */
 	EC_FEATURE_ISH = 40,
-- 
2.21.0.392.gf8f6787159e-goog

