Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0024C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13A420663
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbfDPPBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:01:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:26992 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbfDPPBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:01:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 08:01:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,358,1549958400"; 
   d="scan'208";a="292036372"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.178])
  by orsmga004.jf.intel.com with ESMTP; 16 Apr 2019 08:01:01 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
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
        stable@vger.kernel.org, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH] stm class: Fix out of bound access from bitmap allocation
In-Reply-To: <20190405122256.27840-1-saiprakash.ranjan@codeaurora.org>
References: <20190405122256.27840-1-saiprakash.ranjan@codeaurora.org>
Date:   Tue, 16 Apr 2019 18:00:59 +0300
Message-ID: <87mukqc7v8.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> writes:

> From: Mulu He <muluhe@codeaurora.org>
>
> Bitmap allocation works on array of unsigned longs and
> for stm master allocation when the number of software
> channels is 32, 4 bytes are allocated and there is a out of
> bound access at the first 8 bytes access of bitmap region.

Does the below fix the problem for you?

From fb22b9ab109b332e58d72df13563e270befbd0e3 Mon Sep 17 00:00:00 2001
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Date: Tue, 16 Apr 2019 17:47:02 +0300
Subject: [PATCH] stm class: Fix channel bitmap on 32-bit systems

Commit 7bd1d4093c2f ("stm class: Introduce an abstraction for System Trace
Module devices") naively calculates the channel bitmap size in 64-bit
chunks regardless of the size of underlying unsigned long, making the
bitmap half as big on a 32-bit system. This leads to an out of bounds
access with the upper half of the bitmap.

Fix this by using BITS_TO_LONGS. While at it, convert to using
struct_size() for the total size calculation of the master struct.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Fixes: 7bd1d4093c2f ("stm class: Introduce an abstraction for System Trace Module devices")
Reported-by: Mulu He <muluhe@codeaurora.org>
Cc: stable@vger.kernel.org # v4.4+
---
 drivers/hwtracing/stm/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index 5b5807cbcf7c..8c45e79e47db 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -166,11 +166,9 @@ stm_master(struct stm_device *stm, unsigned int idx)
 static int stp_master_alloc(struct stm_device *stm, unsigned int idx)
 {
 	struct stp_master *master;
-	size_t size;
 
-	size = ALIGN(stm->data->sw_nchannels, 8) / 8;
-	size += sizeof(struct stp_master);
-	master = kzalloc(size, GFP_ATOMIC);
+	master = kzalloc(struct_size(master, chan_map, BITS_TO_LONGS(stm->data->sw_nchannels)),
+			 GFP_ATOMIC);
 	if (!master)
 		return -ENOMEM;
 
-- 
2.20.1

