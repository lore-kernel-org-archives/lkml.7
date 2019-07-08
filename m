Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B05DC606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1A5216F4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C+MArnBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731870AbfGHOkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 10:40:13 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44786 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731855AbfGHOkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 10:40:12 -0400
Received: by mail-ot1-f67.google.com with SMTP id b7so16389189otl.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 07:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iIj/D2uFckhktV/1D81+BNHiSe7rGxGISfmtPBSrlSM=;
        b=C+MArnBQMr2fem13xnS9J64lNmtz6x3eb264CDVGZm7lK3pxHAy8901qu3ZTI2HIS6
         7K9WLnI/UgnLLE1IK0Nh+pHlhLXmB4gPUEqugQmc+xsgLxMQ0G8jeB+9KL1O/cfTMvXt
         erNEljQYc3VzgMUZRXI+YJ1J59KILFnMJ3P2X1PNJo3Nx/w2yYFWGaccpDUTST0tS3yU
         mXnMUWw1nnC/DFX/QkIj/wO9Sc2SGyy6oYCYidmXzXXV4Z+KDev9igsREiqaE5fOpfx0
         DwfbUepPKKEmN0tnUtPOleWgPURufqT8O7xB3E3KtQGRrDjQ3fFnI4EDjpeLJ4WO90dI
         zo/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iIj/D2uFckhktV/1D81+BNHiSe7rGxGISfmtPBSrlSM=;
        b=gImuxAI2nWfuOeI/xrbI1rUMW62d/XccnHwFQ2InuipXa7oWNtxKf2MfHltfsc6AC1
         4+XcTGCN5F2nlAhK2tpipW0KxdNtRdMS99G3gUTtMhW91HCYYxTDc4cgMyrNh+98igML
         PzBFxr1UfmWNcxj1D+0cvAQRTszbs1RDABuAyY4vE1kubnaT4iWlAU0WknpJQa3lfBdh
         S6IknQtdx1aruXEjk1jSIhC3s5H/52thoGSBY944yuMkjUdLTit94iFAmhuvctsDeSJl
         uSLXdqCZq8sLRnFwSrpJtB55xCJJSvf5qf2LWDuWkwINTu8D37Jub/ZGB1L8664Td09D
         QuUA==
X-Gm-Message-State: APjAAAWb50aED54qRL2jhNt8JlHPyIJnpGYoJ5YVBNROrnXQ14GySw+w
        riK8lzBJ40ES5cvoVFrkxIB8xw==
X-Google-Smtp-Source: APXvYqyCIgpXl9aMrnWlPCMuhtjBzNRKlFd2j+pNfi8a5y8SglLuLFVH3QGHkoz8B9mgc19PYS+Iiw==
X-Received: by 2002:a05:6830:18a:: with SMTP id q10mr15142642ota.114.1562596812197;
        Mon, 08 Jul 2019 07:40:12 -0700 (PDT)
Received: from localhost.localdomain (li964-79.members.linode.com. [45.33.10.79])
        by smtp.gmail.com with ESMTPSA id x5sm6386021otb.6.2019.07.08.07.40.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 07:40:11 -0700 (PDT)
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
Subject: [PATCH v2 2/4] perf intel-bts: Smatch: Fix potential NULL pointer dereference
Date:   Mon,  8 Jul 2019 22:39:35 +0800
Message-Id: <20190708143937.7722-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190708143937.7722-1-leo.yan@linaro.org>
References: <20190708143937.7722-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the following report from Smatch, fix the potential
NULL pointer dereference check.

  tools/perf/util/intel-bts.c:898
  intel_bts_process_auxtrace_info() error: we previously assumed
  'session->itrace_synth_opts' could be null (see line 894)

  tools/perf/util/intel-bts.c:899
  intel_bts_process_auxtrace_info() warn: variable dereferenced before
  check 'session->itrace_synth_opts' (see line 898)

tools/perf/util/intel-bts.c
894         if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
895                 bts->synth_opts = *session->itrace_synth_opts;
896         } else {
897                 itrace_synth_opts__set_default(&bts->synth_opts,
898                                 session->itrace_synth_opts->default_no_sample);
                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^
899                 if (session->itrace_synth_opts)
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^
900                         bts->synth_opts.thread_stack =
901                                 session->itrace_synth_opts->thread_stack;
902         }

'session->itrace_synth_opts' is impossible to be a NULL pointer in
intel_bts_process_auxtrace_info(), thus this patch removes the NULL
test for 'session->itrace_synth_opts'.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/intel-bts.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 5a21bcdb8ef7..5560e95afdda 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -891,13 +891,12 @@ int intel_bts_process_auxtrace_info(union perf_event *event,
 	if (dump_trace)
 		return 0;
 
-	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
+	if (session->itrace_synth_opts->set) {
 		bts->synth_opts = *session->itrace_synth_opts;
 	} else {
 		itrace_synth_opts__set_default(&bts->synth_opts,
 				session->itrace_synth_opts->default_no_sample);
-		if (session->itrace_synth_opts)
-			bts->synth_opts.thread_stack =
+		bts->synth_opts.thread_stack =
 				session->itrace_synth_opts->thread_stack;
 	}
 
-- 
2.17.1

