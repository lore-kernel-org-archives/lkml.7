Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F340C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E495A2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="VV5jfWMF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbfFQTYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:24:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58915 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfFQTYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:24:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJNdr13561096
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:23:39 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJNdr13561096
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560799420;
        bh=UfRS/s43/jQRx7zMDkXsPBH2z5HCMWUOvSMIjsEMIw4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=VV5jfWMFHUY/oZMgwZLLtd/0uls4uMBOvZdj5zLZohc2lDewWQ9Ig1/unRwvs65kU
         YXAe4P+amToMxTsF7cT/sfTZw98qv7ERllNy0IVIQjmn50FWFRHcgu+yrm/dYFfGwN
         FW2kI4+Kp9nvzL3NArlifiK6GG5k3bO6VGGFFz+MX9581fbohetltWKohnfJ8oWdSA
         8TA2tD5oumKSGC5vcfpPgfiEBD72SgKlo4hzXF+Ag9/2fl4LiJgZRALw9lJHqNp6YL
         LP1D8EHj9SCNclBL1H9Ey8x/vATzCe5j0nfgF0oBYyE3ACsoUqHXbCJBTpV3pw4UAf
         1H6jrrcSPy0tA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJNdeu3561091;
        Mon, 17 Jun 2019 12:23:39 -0700
Date:   Mon, 17 Jun 2019 12:23:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Poirier <tipbot@zytor.com>
Message-ID: <tip-3470d48a4ef30c554934d4a188a97a53656bff57@git.kernel.org>
Cc:     jolsa@redhat.com, acme@redhat.com, peterz@infradead.org,
        leo.yan@linaro.org, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de, mingo@kernel.org, suzuki.poulose@arm.com,
        hpa@zytor.com, mathieu.poirier@linaro.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org
Reply-To: peterz@infradead.org, jolsa@redhat.com, acme@redhat.com,
          tglx@linutronix.de, suzuki.poulose@arm.com, mingo@kernel.org,
          hpa@zytor.com, linux-kernel@vger.kernel.org,
          mathieu.poirier@linaro.org, namhyung@kernel.org,
          leo.yan@linaro.org, alexander.shishkin@linux.intel.com
In-Reply-To: <20190524173508.29044-7-mathieu.poirier@linaro.org>
References: <20190524173508.29044-7-mathieu.poirier@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Refactor error path in
 cs_etm_decoder__new()
Git-Commit-ID: 3470d48a4ef30c554934d4a188a97a53656bff57
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3470d48a4ef30c554934d4a188a97a53656bff57
Gitweb:     https://git.kernel.org/tip/3470d48a4ef30c554934d4a188a97a53656bff57
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Fri, 24 May 2019 11:34:57 -0600
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 15:50:01 -0300

perf cs-etm: Refactor error path in cs_etm_decoder__new()

There is no point in having two different error goto statement since the
openCSD API to free a decoder handles NULL pointers.  As such function
cs_etm_decoder__free() can be called to deal with all aspect of freeing
decoder memory.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190524173508.29044-7-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 39fe21e1cf93..5dafec421b0d 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -577,7 +577,7 @@ cs_etm_decoder__new(int num_cpu, struct cs_etm_decoder_params *d_params,
 	/* init library print logging support */
 	ret = cs_etm_decoder__init_def_logger_printing(d_params, decoder);
 	if (ret != 0)
-		goto err_free_decoder_tree;
+		goto err_free_decoder;
 
 	/* init raw frame logging if required */
 	cs_etm_decoder__init_raw_frame_logging(d_params, decoder);
@@ -587,15 +587,13 @@ cs_etm_decoder__new(int num_cpu, struct cs_etm_decoder_params *d_params,
 							 &t_params[i],
 							 decoder);
 		if (ret != 0)
-			goto err_free_decoder_tree;
+			goto err_free_decoder;
 	}
 
 	return decoder;
 
-err_free_decoder_tree:
-	ocsd_destroy_dcd_tree(decoder->dcd_tree);
 err_free_decoder:
-	free(decoder);
+	cs_etm_decoder__free(decoder);
 	return NULL;
 }
 
