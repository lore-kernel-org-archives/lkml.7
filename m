Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E1CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517F42184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MSmDp5uW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfCTNS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:18:27 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:39260 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbfCTNSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:18:25 -0400
Received: by mail-pg1-f177.google.com with SMTP id h8so1794447pgp.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 06:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=H2crl7RmZMvIJT00kHO5k98tCahG1bLmtk7Nv322/6A=;
        b=MSmDp5uW3BX6y3KhbP9xWW2vwYPursYhQEFnwNeuVagnLQCzXKWL3ZmTpBHyZRClW7
         5jhCmddOzQrbTkYUW8H7oZn3TjS2cJrpZZsnZ5I2q7mP8gatgd86d7GwBnWAaVfkmv6f
         o066pYIrihQjGB0OxDOqZAv4lm6LTGYVW6tIlAtnR85KtMgIcHx7gv22KAIfqpZgf25Z
         jT1cjaMXFSRugYacznPQdetgnBGFA6PWlY9IxljCbHUtG56XDxBEbSm9qZ8Ldn7CWE4K
         AAta9fCRGaR2pLEUqRNta+4uc8KjANpdpI5Ehf2QES5bn1L2bHDv2NjseNbuaOWjuZsa
         8W2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=H2crl7RmZMvIJT00kHO5k98tCahG1bLmtk7Nv322/6A=;
        b=lLViOF6VDAJrB3FF9WfB6nirl+DFVm1FlEHgFZg7FJdCcfG1w7gzDHVqowVQpBXBWe
         OHnDFPzW2A+Vc6JFDj2NXawfJsbTAorJda3xMuCLnrCyytYXy+Pq6oasG78AQFZCf4rD
         b9D58/ZqztfDueOxN/a/f25Ucw43T2vu/EsrcM4n0aen2Uje3NcVcL3OQ/98GLBQ+Ki+
         RsZ1zyaZxdKpmlDIQWGpjW5SrQ5hmwsMR16ajd6Iaci9hk3XUR7qu9HZxehg5F3dM7WT
         Eemx+8JWHDyiYMCM8p2qbaa/h6gGcutJrgXuvjbzqhWXDgsybgTJ/6jFIVDJwyJ5FAYT
         wSVw==
X-Gm-Message-State: APjAAAXWDOuw84YRTRcf8xV1AEAbuuHxgl4bJ+lBB1N6nI9rxldFQgn5
        NCMXw0Iqs6g06e3gDZh6DIpfxE7R0MU=
X-Google-Smtp-Source: APXvYqwwmKuE6A8EVwY/xPnKi+ovvY5XPA4E2XApd1Xl1xiE8+lJmuwir9QiYcMczVdyVBQMLW0+TA==
X-Received: by 2002:a17:902:728b:: with SMTP id d11mr8062194pll.257.1553087904578;
        Wed, 20 Mar 2019 06:18:24 -0700 (PDT)
Received: from localhost ([114.143.122.221])
        by smtp.gmail.com with ESMTPSA id u62sm7579877pfa.124.2019.03.20.06.18.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 06:18:23 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCHv3 01/23] drivers: thermal: tsens: Document the data structures
Date:   Wed, 20 Mar 2019 18:47:41 +0530
Message-Id: <643831e7268ec289adcb6817b348689ff029ae46.1553086065.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
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

