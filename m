Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13039C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 08:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0059206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 08:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ppdLC1lq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731441AbfIPI4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 04:56:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42435 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfIPI4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 04:56:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id q14so37920995wrm.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 01:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Vq1aoYedsFkETd/evvKj1kUDyrvtLgO2i4JpK9RUX4Y=;
        b=ppdLC1lqYnUcCqlKAXL7HjEJ0G2tfaDtIn7OYpN95IpPjKxBzBvhfnlS4AyyHrqzN9
         Yv9rCHNf0Jgq6U68/WxhZo9DvYbNDCpbTCJlYB6Ud5lWBKBBaEb8ATX6viqnSsrPF47l
         AWN6VdKdIF8OfmXz4gLZ8kkMEVmfzfgCdTYkjbtipvzn9yQuDyMLQGpHhMdHUtsfu0ty
         TtiqazeeogLybhaX2QuHeYg8VtkpCvaCkGYHCGN2pU8wv9Wikm4D5fKjY/9hkq5gJMml
         YFdF7ldiJCKvDd5WorvFISSxuO8DVy+jBL46kMLpp9fITlVRvVhMxsMciQFvyacXS4QU
         mn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Vq1aoYedsFkETd/evvKj1kUDyrvtLgO2i4JpK9RUX4Y=;
        b=TiWJSvaKsR39tRYLfp2yW5ZNa7miMpO7+MxG7PKqIaszMx8h2gPlBoKR8dXnp6z6nS
         TghbuwdlnW454dcTqrgdwB1YrsB4HagHDN+RL3Q/ilE3rvYF0DenJGy3xZ40vNezmucN
         +GWwobNceCFSNy7EEj/+djUHz2zkO0o9+Hlthse4TcRcTr04p0NpD6/YvZbBWuzEQlzL
         XU80HdiOzRzwG/7brpBC2WBQc4ON7tqReZPo8hl3+vOkQKtvBKP1HRJVRUiAFsiiA3VB
         DbQTq5fVFleHIU4LnKuA5uUAHAhaIxX0sUWUyfKomefn09CA+aLG+APOcyV3gwrB9xnf
         S8fQ==
X-Gm-Message-State: APjAAAWz3Vhnqk8o7FrEcm/X8ACbM58Mfimz/gx+oaW+6sCKRH9XIaTZ
        NywJbDhOklRP6LQHO5DhqKFwKK12Z+M=
X-Google-Smtp-Source: APXvYqwA04G2ppjP8w4yxN9UCn7ReOQlW2AxCrp7r38f6ObzSEOHesyMu1XgTZOuROKjFNVeucEGeA==
X-Received: by 2002:adf:fc0e:: with SMTP id i14mr19495430wrr.302.1568624190317;
        Mon, 16 Sep 2019 01:56:30 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id y14sm53847507wrd.84.2019.09.16.01.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 01:56:28 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: handle F/W failure for sensor initialization
Date:   Mon, 16 Sep 2019 11:56:26 +0300
Message-Id: <20190916085626.1085-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case the F/W fails to initialize the thermal sensors, print an
appropriate error message to kernel log and fail the device
initialization.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c          | 5 +++++
 drivers/misc/habanalabs/include/hl_boot_if.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 6fba14b81f90..09caef7642fd 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2328,6 +2328,11 @@ static int goya_init_cpu(struct hl_device *hdev, u32 cpu_timeout)
 				"ARM status %d - u-boot stopped by user\n",
 				status);
 			break;
+		case CPU_BOOT_STATUS_TS_INIT_FAIL:
+			dev_err(hdev->dev,
+				"ARM status %d - Thermal Sensor initialization failed\n",
+				status);
+			break;
 		default:
 			dev_err(hdev->dev,
 				"ARM status %d - Invalid status code\n",
diff --git a/drivers/misc/habanalabs/include/hl_boot_if.h b/drivers/misc/habanalabs/include/hl_boot_if.h
index 4cd04c090285..2853a2de8cf6 100644
--- a/drivers/misc/habanalabs/include/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/hl_boot_if.h
@@ -20,6 +20,8 @@ enum cpu_boot_status {
 	CPU_BOOT_STATUS_DRAM_INIT_FAIL,
 	CPU_BOOT_STATUS_FIT_CORRUPTED,
 	CPU_BOOT_STATUS_UBOOT_NOT_READY,
+	CPU_BOOT_STATUS_RESERVED,
+	CPU_BOOT_STATUS_TS_INIT_FAIL,
 };
 
 enum kmd_msg {
-- 
2.17.1

