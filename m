Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F246C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526982186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DAybXbOS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nVUwHoXl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbfDEK0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 06:26:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37982 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730467AbfDEK0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 06:26:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C4C4961791; Fri,  5 Apr 2019 10:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554459959;
        bh=ecfe3QXZi1M0P/wrkMh/PeD8+1p8Ao18xx7AYBbOP38=;
        h=From:To:Cc:Subject:Date:From;
        b=DAybXbOSvr598IxSExehXC10CxSbpOl6T+PVF+NXZpg7Pawowx0fLuM0zQSWsfxoB
         kyOAffjHFTpxo2Q4m17Xq74b+DDajrTRH4O9tmgEPnvFjrcvXGZpc7Jt5/CpgqcMOT
         7KUY14oBX98KeAfEas3GpogucQp9B+J+7VCxSg5k=
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2EDB96177C;
        Fri,  5 Apr 2019 10:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554459929;
        bh=ecfe3QXZi1M0P/wrkMh/PeD8+1p8Ao18xx7AYBbOP38=;
        h=From:To:Cc:Subject:Date:From;
        b=nVUwHoXlhGYXf4pfk93QNCIPvh1uowlBZGNrTfm7l9AV03f8Ub3W8y6BDikA/SZNv
         LSAKeS9EEKdz8/mCnjSX32tITFS7LoZcPX7bUtRClE/gSVJeBIDwTlYuAy0hlj9mvj
         yiUf7h6dvjat4+B/mnWmWCv5YPu+7bV1SdE/xlWg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2EDB96177C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Tingwei Zhang <tingwei@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        stable@vger.kernel.org
Subject: [PATCH] stm class: Fix channel free in stm output free path
Date:   Fri,  5 Apr 2019 15:54:42 +0530
Message-Id: <20190405102442.25718-1-saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tingwei Zhang <tingwei@codeaurora.org>

Number of free masters is not set correctly in stm
free path. Fix this by properly adding the number
of output channels before setting them to 0 in
stm_output_disclaim().

Currently it is equivalent to doing nothing since
master->nr_free is incremented by 0.

Fixes: 7bd1d4093c2f ("stm class: Introduce an abstraction for System Trace Module devices")
Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc: stable@vger.kernel.org
---
 drivers/hwtracing/stm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index c7ba8acfd4d5..5b5807cbcf7c 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -218,8 +218,8 @@ stm_output_disclaim(struct stm_device *stm, struct stm_output *output)
 	bitmap_release_region(&master->chan_map[0], output->channel,
 			      ilog2(output->nr_chans));
 
-	output->nr_chans = 0;
 	master->nr_free += output->nr_chans;
+	output->nr_chans = 0;
 }
 
 /*
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

