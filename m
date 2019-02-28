Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0D6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778FB214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yEzZQbbS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731590AbfB1MVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:21:39 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54552 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731523AbfB1MVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:21:37 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so9068099wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 04:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=H2crl7RmZMvIJT00kHO5k98tCahG1bLmtk7Nv322/6A=;
        b=yEzZQbbSd8IxFs5neCEzP9oJ2DIiWndR7AngoPaboId/SzXcwwICvEfxF8YzepJ+Gi
         TMBThEPu9y+jNpbWjFM/S8rfYOF19y/Rm0YRH+AUEswvF61FgsB2/PfM9VgNnAppY/fn
         FY/rNopl3FmBqAtaGMs/ITKklYX423vE+TG8yvf3gwxDQ+q755cBd4fsSqJbJZrIKguZ
         8aZ0TDKEnnAarJBV3mJoLtadfM86Agpifss83Raqh+Lkks0b29qWxj712V90u1plRvqi
         U77dInHUHSVDi9bobG1IjSFcKE/AGF2GG8L/9e8aeu0UY1sRMULwtA21O9fHmrgfQvX3
         QF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=H2crl7RmZMvIJT00kHO5k98tCahG1bLmtk7Nv322/6A=;
        b=ef3wm80jguaVnPlqQI++PeceY4J+fUmkj4y2AW1e8emU0FHYPpJgnkr+MEGXXVr1/w
         bl1Cis5svizVQyD/l9UiHJ0LZXnBq6m1zwWvNR1eKtEmNH0zEq+sZowoIY9CbhkZRjD5
         osf8iD/X4QavyHlXV6FXXf7uyBzwM2ZVpSgXAACqco1P1ktRobN+x7PrnliJUsAgXCyf
         nNYDmSOWOkZ9jnT8DrnVRPIj5zyjmDAao/DMmfKzzupAGzZoLha27LIVu5ELDyANc+N4
         R+CQEE0n0etXrSDH1v9sUzUbxUvPQE6HwTjno/5mPGryQbLqBWiw5I2UIoAtuwwsQ/Q+
         /MAA==
X-Gm-Message-State: AHQUAuYSS3lzhUxNPbornW0hcryBz71kOhNLPnJGL8/adPeQ54BMAD5k
        rXS9djLNMnfgh68k+JdXAg84Sp0X+CQ=
X-Google-Smtp-Source: APXvYqw5EtuntVmwNkHAw3+zrjw+C6c5Qw3QEcic2hxXxAfxGVfFRLU3ELO63I7SeI5v+axw9ljFOA==
X-Received: by 2002:a1c:f011:: with SMTP id a17mr2668098wmb.89.1551356494718;
        Thu, 28 Feb 2019 04:21:34 -0800 (PST)
Received: from localhost ([49.248.54.130])
        by smtp.gmail.com with ESMTPSA id y20sm5556146wmi.34.2019.02.28.04.21.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 04:21:33 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v2 01/24] drivers: thermal: tsens: Document the data structures
Date:   Thu, 28 Feb 2019 17:50:51 +0530
Message-Id: <859106c7c660cffc752165a79c63ee4d636b3c44.1551355503.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe how the TSENS device and the various sensors connected to it
are described in the driver

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens.h | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 7b7feee5dc46..89318523c848 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -14,6 +14,16 @@
 
 struct tsens_device;
 
+/**
+ * struct tsens_sensor - data for each sensor connected to the tsens device
+ * @tmdev: tsens device instance that this sensor is connected to
+ * @tzd: pointer to the thermal zone that this sensor is in
+ * @offset: offset of temperature adjustment curve
+ * @id: Sensor ID
+ * @hw_id: HW ID can be used in case of platform-specific IDs
+ * @slope: slope of temperature adjustment curve
+ * @status: 8960-specific variable to track 8960 and 8660 status register offset
+ */
 struct tsens_sensor {
 	struct tsens_device		*tmdev;
 	struct thermal_zone_device	*tzd;
@@ -55,8 +65,8 @@ enum reg_list {
 };
 
 /**
- * struct tsens_data - tsens instance specific data
- * @num_sensors: Max number of sensors supported by platform
+ * struct tsens_data - tsens platform data
+ * @num_sensors: Number of sensors supported by platform
  * @ops: operations the tsens instance supports
  * @hw_ids: Subset of sensors ids supported by platform, if not the first n
  * @reg_offsets: Register offsets for commonly used registers
@@ -68,12 +78,27 @@ struct tsens_data {
 	unsigned int		*hw_ids;
 };
 
-/* Registers to be saved/restored across a context loss */
+/**
+ * struct tsens_context - Registers to be saved/restored across a context loss
+ */
 struct tsens_context {
 	int	threshold;
 	int	control;
 };
 
+/**
+ * struct tsens_device - private data for each instance of the tsens IP
+ * @dev: pointer to struct device
+ * @num_sensors: number of sensors enabled on this device
+ * @tm_map: pointer to TM register address space
+ * @srot_map: pointer to SROT register address space
+ * @tm_offset: deal with old device trees that don't address TM and SROT
+ *             address space separately
+ * @reg_offsets: array of offsets to important regs for this version of IP
+ * @ctx: registers to be saved and restored during suspend/resume
+ * @ops: pointer to list of callbacks supported by this device
+ * @sensor: list of sensors attached to this device
+ */
 struct tsens_device {
 	struct device			*dev;
 	u32				num_sensors;
-- 
2.17.1

