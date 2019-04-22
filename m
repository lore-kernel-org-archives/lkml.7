Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31340C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7DD221900
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962306;
	bh=vVszk48zb7rcNd8exr3HZ1ozvbVDgkQiQF6O+xzrBTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j/sy74o7N8Mg1kzH4ytQ/W0IgsodFILgn7p3hIXW73DBmzs74Baao9zV5VF6CP5PZ
	 Jjc61FZQP2FbBCN+yJnbeq9SXV1WBzW5ntJj31W/eIeWmAtVIpUnynZohaLXvH70ZC
	 YcUdVhVKftIOFtbRu3pIUcblsmIY8SG/TEQoeVfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbfDVTpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729604AbfDVTpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:45:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ED51218B0;
        Mon, 22 Apr 2019 19:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962300;
        bh=vVszk48zb7rcNd8exr3HZ1ozvbVDgkQiQF6O+xzrBTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UrQp/HJXBz6cbTZ83EM/ZfQFhEtKCHRSUOtho2AI3zP9oA2sDkBBHjO+PcsM9k3pK
         6yYwE5dgAOiUvR6TAsGozlz4mSK5U337cPdfdSVNsglNeWxTvDANKGaNxT07HCPbw5
         eBsOYcNk0VzeEqB7YJ+R3jlx1g5byMFF/PxDZRyY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Solomon Tan <solomonbobstoner@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Robert Walker <robert.walker@arm.com>,
        Suzuki K Poulouse <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 91/98] perf cs-etm: Add missing case value
Date:   Mon, 22 Apr 2019 15:41:58 -0400
Message-Id: <20190422194205.10404-91-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Solomon Tan <solomonbobstoner@gmail.com>

[ Upstream commit c8fa7a807f3c5f946bd92076fbaf7826edb650dc ]

The following error was thrown when compiling `tools/perf` using OpenCSD
v0.11.1. This patch fixes said error.

    CC       util/intel-pt-decoder/intel-pt-log.o
    CC       util/cs-etm-decoder/cs-etm-decoder.o
  util/cs-etm-decoder/cs-etm-decoder.c: In function
  ‘cs_etm_decoder__buffer_range’:
  util/cs-etm-decoder/cs-etm-decoder.c:370:2: error: enumeration value
  ‘OCSD_INSTR_WFI_WFE’ not handled in switch [-Werror=switch-enum]
    switch (elem->last_i_type) {
    ^~~~~~
    CC       util/intel-pt-decoder/intel-pt-decoder.o
  cc1: all warnings being treated as errors

Because `OCSD_INSTR_WFI_WFE` case was added only in v0.11.0, the minimum
required OpenCSD library version for this patch is no longer v0.10.0.

Signed-off-by: Solomon Tan <solomonbobstoner@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190322052255.GA4809@w-OptiPlex-7050
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 tools/build/feature/test-libopencsd.c           | 4 ++--
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/build/feature/test-libopencsd.c b/tools/build/feature/test-libopencsd.c
index d68eb4fb40cc..2b0e02c38870 100644
--- a/tools/build/feature/test-libopencsd.c
+++ b/tools/build/feature/test-libopencsd.c
@@ -4,9 +4,9 @@
 /*
  * Check OpenCSD library version is sufficient to provide required features
  */
-#define OCSD_MIN_VER ((0 << 16) | (10 << 8) | (0))
+#define OCSD_MIN_VER ((0 << 16) | (11 << 8) | (0))
 #if !defined(OCSD_VER_NUM) || (OCSD_VER_NUM < OCSD_MIN_VER)
-#error "OpenCSD >= 0.10.0 is required"
+#error "OpenCSD >= 0.11.0 is required"
 #endif
 
 int main(void)
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 8c155575c6c5..2a8bf6b45a30 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -374,6 +374,7 @@ cs_etm_decoder__buffer_range(struct cs_etm_decoder *decoder,
 		break;
 	case OCSD_INSTR_ISB:
 	case OCSD_INSTR_DSB_DMB:
+	case OCSD_INSTR_WFI_WFE:
 	case OCSD_INSTR_OTHER:
 	default:
 		packet->last_instr_taken_branch = false;
-- 
2.19.1

