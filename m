Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AB9C606BF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C1E216C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rMnUN1r+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731905AbfGHOk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 10:40:28 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34422 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728823AbfGHOk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 10:40:28 -0400
Received: by mail-ot1-f67.google.com with SMTP id n5so16460014otk.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 07:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CCSoHq1Uo4IBnCwfeuA+GvIGXoY8z0TTGOk4Tw+sVOA=;
        b=rMnUN1r+KicSBHv/XyAGYU6dbXI3N+TcAG/o+Ydxv13ZCBB0c/O2uu9G4vqrLCytct
         AEKFHYY+SHopfy3uStEBvIMEspHQMmadm9wEmnta9CgMRDdfOnpwGL+PB2/POmpXHUru
         /MlsSUF/JzCed/TIDJCNcEyJODeNFhMRwfZWmGaKDJfrVJgMDTYz0U8MLjvjQGJDDUsK
         kaqgF3izPU2FROV8J+mfY6t97vifqIqb/sJvvFV9+XMLcxYIMSnX9vQhtJdxdxWjDUXJ
         NPnoBwSTkxC7AmqTwW6gwUncSzbtlw0O7Aaaj9ZmAZA8Uczsbth2wNfWlo5oh6QrJWYq
         iW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CCSoHq1Uo4IBnCwfeuA+GvIGXoY8z0TTGOk4Tw+sVOA=;
        b=LNVA0AWcXVtfDLeuaNa5L3BYhQTotr7tXnEpmplGOzV9E3ClU/L6B0ymwqQ140UNyf
         QkTjJNAW3K5zC4AiG0TQRKiPsGWDf2quYRf32RKQyQeCFU5WOjiAmNu5ZI2T/loHhvR9
         wfiQLN/awEMPf/UNeNgul2KOJSSNvJSH1USQNmGZJ6DfbV881ZczHG59TWsUDkuGNmRe
         VK56D6+UiJq/zeGLCTPMhdPeGUU/nbMbvvHA4pBa/VrOHLYV82m1+L6XAR/TM9QHEz2c
         gpw1QXQqhqbF7j8TprJJMF7BGgu6zavxgM887SqvHuJpBECyU55qM/dY+ST7b8kj2FYI
         fWcA==
X-Gm-Message-State: APjAAAXOaNqjbz3utsklwBCVmXDqBq1DU9G3bsF5TpcSb5r33cVXzRh7
        /rGkHMmB6DUDca1KViS2cI2C7w==
X-Google-Smtp-Source: APXvYqy5KuHIa3DLT0x0ETCwurZ9OZctjHOGlUf9bAzAIBS0BmrvEY0SlDNj99jk2L87sMy7YLCtsA==
X-Received: by 2002:a9d:4b88:: with SMTP id k8mr9349423otf.285.1562596827664;
        Mon, 08 Jul 2019 07:40:27 -0700 (PDT)
Received: from localhost.localdomain (li964-79.members.linode.com. [45.33.10.79])
        by smtp.gmail.com with ESMTPSA id x5sm6386021otb.6.2019.07.08.07.40.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 07:40:26 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 4/4] perf cs-etm: Smatch: Fix potential NULL pointer dereference
Date:   Mon,  8 Jul 2019 22:39:37 +0800
Message-Id: <20190708143937.7722-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190708143937.7722-1-leo.yan@linaro.org>
References: <20190708143937.7722-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the following report from Smatch, fix the potential
NULL pointer dereference check.

  tools/perf/util/cs-etm.c:2545
  cs_etm__process_auxtrace_info() error: we previously assumed
  'session->itrace_synth_opts' could be null (see line 2541)

tools/perf/util/cs-etm.c
2541         if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
2542                 etm->synth_opts = *session->itrace_synth_opts;
2543         } else {
2544                 itrace_synth_opts__set_default(&etm->synth_opts,
2545                                 session->itrace_synth_opts->default_no_sample);
                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^
2546                 etm->synth_opts.callchain = false;
2547         }

'session->itrace_synth_opts' is impossible to be a NULL pointer in
cs_etm__process_auxtrace_info(), thus this patch removes the NULL
test for 'session->itrace_synth_opts'.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index ad43a6e31827..ab578a06a790 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2537,7 +2537,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 		return 0;
 	}
 
-	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
+	if (session->itrace_synth_opts->set) {
 		etm->synth_opts = *session->itrace_synth_opts;
 	} else {
 		itrace_synth_opts__set_default(&etm->synth_opts,
-- 
2.17.1

