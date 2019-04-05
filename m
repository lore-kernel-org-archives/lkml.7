Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE59EC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB7E218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TMXHlKgv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PGvqBadW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbfDEMXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:23:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40466 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfDEMXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:23:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7A73B60F3E; Fri,  5 Apr 2019 12:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554466995;
        bh=VdLQ+pvShXErJhD2SzInzqS+Emmcdl/7Bmayue6mIjA=;
        h=From:To:Cc:Subject:Date:From;
        b=TMXHlKgvhOEcD0CgV9e8qdKPLLspHU9IDyaGkHj0ak3HyCcabXN35P56db+OjSDOb
         zxK8J2R9seGcqbb10cKxmZxTEmpD0jFJRvigIHCZUkMD0HaBT9n/BefmkzcTP9dsDP
         9RWWAXytbFx4kaeGKWQq4lARglLYovSdIQ2XFMA0=
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B717C60DAD;
        Fri,  5 Apr 2019 12:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554466993;
        bh=VdLQ+pvShXErJhD2SzInzqS+Emmcdl/7Bmayue6mIjA=;
        h=From:To:Cc:Subject:Date:From;
        b=PGvqBadW6Gv0vu5F3eylkRTQ9Wyll3nMHaSkjvYu+hVAyRgEdIJO4gGEderxkyMBf
         aLsYuR2cg7HgtzrikdedW6yolLYBnipa17lYgN1bgGgfcIX4OIg0Ob++jR6xEG7ywE
         HBJi099KwPLcGzWn0pT1iYxwRsxkf1dqt7Y2LJdg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B717C60DAD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mulu He <muluhe@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        stable@vger.kernel.org
Subject: [PATCH] stm class: Fix out of bound access from bitmap allocation
Date:   Fri,  5 Apr 2019 17:52:56 +0530
Message-Id: <20190405122256.27840-1-saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mulu He <muluhe@codeaurora.org>

Bitmap allocation works on array of unsigned longs and
for stm master allocation when the number of software
channels is 32, 4 bytes are allocated and there is a out of
bound access at the first 8 bytes access of bitmap region.

Fixes: 7bd1d4093c2f ("stm class: Introduce an abstraction for System Trace Module devices")
Signed-off-by: Mulu He <muluhe@codeaurora.org>
Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc: stable@vger.kernel.org
---
 drivers/hwtracing/stm/core.c | 2 +-
 drivers/hwtracing/stm/stm.h  | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index 93ce3aa740a9..21a5838f6e67 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -168,7 +168,7 @@ static int stp_master_alloc(struct stm_device *stm, unsigned int idx)
 	struct stp_master *master;
 	size_t size;
 
-	size = ALIGN(stm->data->sw_nchannels, 8) / 8;
+	size = ALIGN(stm->data->sw_nchannels, STM_MASTER_SZ) / STM_MASTER_SZ;
 	size += sizeof(struct stp_master);
 	master = kzalloc(size, GFP_ATOMIC);
 	if (!master)
diff --git a/drivers/hwtracing/stm/stm.h b/drivers/hwtracing/stm/stm.h
index 3569439d53bb..10eac550c75f 100644
--- a/drivers/hwtracing/stm/stm.h
+++ b/drivers/hwtracing/stm/stm.h
@@ -12,6 +12,8 @@
 
 #include <linux/configfs.h>
 
+#define STM_MASTER_SZ sizeof(unsigned long)
+
 struct stp_policy;
 struct stp_policy_node;
 struct stm_protocol_driver;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

