Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE0AC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5622184E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279753;
	bh=+3ubRWRo1wANoyVrgfncqjZE7VEfMBb3KeSEqdxH6rU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jt5wd6LE0WRLPxYvc1Om3liBqnbrOWrWRN37myKQqMW6gwHUsSOuZXxd3m4gqtLzk
	 ug33HcMVr8NcN79kkE2VhtpH/2CZP/7LjXDWd2CLG+duldHo3/kyS/NLNrRo/x8JH6
	 /rvboyVF+5O9krHbuUdWxyE7jvsw2xa9Da06b7Ow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405220AbfFKTCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:02:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391889AbfFKTCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:02:31 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06306217D6;
        Tue, 11 Jun 2019 19:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279750;
        bh=+3ubRWRo1wANoyVrgfncqjZE7VEfMBb3KeSEqdxH6rU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ExMlfIt3QoITULHe4q0+ptcJ+ndHcQu9C3zLHimFpdxh7BGdJHyqEPooj9wKCMfTD
         mSU4JfEUzw0Iq5/CNm7Na9tUVGmUdCzXO+WiwS6iYpMxSH++oAj+EAoABxSpBV9TFx
         +uLijHyRPLciFm4X93h5ZmM77g1J3nZVTzKOLl8g=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 42/85] perf cs-etm: Refactor error path in cs_etm_decoder__new()
Date:   Tue, 11 Jun 2019 15:58:28 -0300
Message-Id: <20190611185911.11645-43-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

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
 
-- 
2.20.1

