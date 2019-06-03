Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09679C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 03:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B6E27B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 03:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LoVX3ACS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfFCDqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 23:46:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46175 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfFCDqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 23:46:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id y11so9737679pfm.13
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 20:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sylSLCQVSO44gThLUf89SvYA0i4320oG/Vj4A4WtxwI=;
        b=LoVX3ACS38bmDeiow/5CpIE2OnQgCBuPQOkKG8O+Av2gN5n979RBzCTMfsGwZhjam1
         RoVaQih4KR0Wz6gjOBSeNarjh2FxfIRfSANfYDupC5t5KZIHcEsrL9C6qYZRMvzsOiDF
         gIPK8BsQsWqpranEo7EZrSBUpMew0/8Gap2nU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sylSLCQVSO44gThLUf89SvYA0i4320oG/Vj4A4WtxwI=;
        b=QoYMmXbHR8TJBqPvWcdze6Dmho4APLDIDA30qeqFx4Szk4jmXTqSGyjsofTGTAADig
         t9t4CDOs093JL2U3dERcoF2VkWP/qimq06mxTPpwMguORgQwpf2jpTpzXdnGGJYTRWQU
         LRbV26+gWzeCaUvGSbjg4ZjUv+YG3kFqPAdhwB2C5C2YGOcdUnaZ0+tYht/yLeXyve4/
         rch/Tgg5NE19G1q7cg6qi5NbqXp2XTlI3S/1Czpb1TZRCJezT7xsY2V86qMbJYhXBdQr
         iMOx945cCpw1OPI4OCcY5JgkoWSej1hhRoMWmxuQI2rrbp5pUnKx2KmnIkEYhAvS9esy
         X0RA==
X-Gm-Message-State: APjAAAXe3MbDyqcmIsmwFqVh5YqlJKFvSe58YPnXQimkKESHT5KmMZ+D
        EUu0F9K+M2nb3uUEpYnBKV587g==
X-Google-Smtp-Source: APXvYqzXlIA9FuJMf6mvY/3K6C5ZUixrME28M/b+m9bVoqwymCS4AfaBOhASN55ANEmFivBsMy1avg==
X-Received: by 2002:a63:441c:: with SMTP id r28mr23392896pga.255.1559533589783;
        Sun, 02 Jun 2019 20:46:29 -0700 (PDT)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id i73sm11878960pje.9.2019.06.02.20.46.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 20:46:29 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v10 6/7] mfd: cros_ec: differentiate SCP from EC by feature bit.
Date:   Mon,  3 Jun 2019 11:45:11 +0800
Message-Id: <20190603034529.154969-7-pihsun@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
In-Reply-To: <20190603034529.154969-1-pihsun@chromium.org>
References: <20190603034529.154969-1-pihsun@chromium.org>
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
Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Changes from v9:
 - Remove changes in cros_ec_commands.h (which is sync in
   https://lore.kernel.org/lkml/20190518063949.GY4319@dell/T/).

Changes from v8:
 - No change.

Changes from v7:
 - Address comments in v7.
 - Rebase the series onto https://lore.kernel.org/patchwork/patch/1059196/.

Changes from v6, v5, v4, v3, v2:
 - No change.

Changes from v1:
 - New patch extracted from Patch 5.
---
 drivers/mfd/cros_ec_dev.c   | 10 ++++++++++
 include/linux/mfd/cros_ec.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index a5391f96eafd..66107de3dbce 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -440,6 +440,16 @@ static int ec_device_probe(struct platform_device *pdev)
 		ec_platform->ec_name = CROS_EC_DEV_TP_NAME;
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
index cfa78bb4990f..751cb3756d49 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -27,6 +27,7 @@
 #define CROS_EC_DEV_PD_NAME "cros_pd"
 #define CROS_EC_DEV_TP_NAME "cros_tp"
 #define CROS_EC_DEV_ISH_NAME "cros_ish"
+#define CROS_EC_DEV_SCP_NAME "cros_scp"
 
 /*
  * The EC is unresponsive for a time after a reboot command.  Add a
-- 
2.22.0.rc1.257.g3120a18244-goog

