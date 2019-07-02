Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC787C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85EB42184B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GeU2YXEC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfGBKgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 06:36:06 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40527 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfGBKgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 06:36:05 -0400
Received: by mail-oi1-f193.google.com with SMTP id w196so12611747oie.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 03:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3cNHVq2PaBuyPCbFNTx86WJww564kzf0LCV7McgViLQ=;
        b=GeU2YXECtSWfuOvAG0IXrfrSQ9GC6wKTPBTdhMDvUYYBgeNMHH44ObcVpAgJxIHjRu
         XicPO2ucq+5oUDudXs2mJPojY613jYIPnec60fr4ppTayNR73/TdwAy6ls50oh3kWzLz
         7HggTaX71y4bEubqd8qL21lfZrHDsHmxgB/kbv2nqyzqpxo+YLTG5wwfi7mIlckvsUgs
         HfLJIS9EQrhuPFz8avWFKQpZmAWMl0i5FDmd225UflwLKM80U0o4VKBdwejuQMcstKgQ
         WU9+yflbRfrpdlPHRtZKIL7/IVZwM8i2kU9fiS76WHQBh44fB3J4FGPT+d9dVKxxJUkV
         P4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3cNHVq2PaBuyPCbFNTx86WJww564kzf0LCV7McgViLQ=;
        b=fDWuVrY4aU/xQqqK8697sjSAHvBlz3OATrFo8A5JaTgIzmAWsvVzIcOUnfrSBzoBvs
         qp3uObgEMnpQQhnRUD/mLwd6405yviLk5PppfZ+/dCNtoXRlUidHeExAdPa+kJ2IkmW/
         dUNpJ05vDhbFdXCtiRFcmalKOMUzcnxXbvCbzRZ/9Ii8b+KrDrhVIXTnynmUpTNOwL22
         XPK+56YuiH5ByC9qO97/SHTrPSzls/0gO7CiOtutBsuP9HdTr2cesDO/O4mmpVzlBFMG
         re3AQl9APfXZPZtvT810qEKyaGPuQTMazHMIo1Nkwk+OMVz4V9JWuZPNupZj1VG8jnBt
         JrXA==
X-Gm-Message-State: APjAAAXuCNp0wxmqrb1rS9eX1npxiH9TJWPPpw9E8f0p3zgaWFOJKyn/
        a3Ns9VQCOhzF0xY7OpWTDMShQQ==
X-Google-Smtp-Source: APXvYqzYGnFN38aJObgZOgp3dai/yecgeBWLFTPbjdxix9QcSJeEiglV4RCPb23llBR9J88wkSzRow==
X-Received: by 2002:aca:3dd7:: with SMTP id k206mr2332669oia.47.1562063765056;
        Tue, 02 Jul 2019 03:36:05 -0700 (PDT)
Received: from localhost.localdomain (li964-79.members.linode.com. [45.33.10.79])
        by smtp.gmail.com with ESMTPSA id 61sm5139805otx.8.2019.07.02.03.35.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 03:36:04 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Changbin Du <changbin.du@intel.com>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 10/11] perf intel-pt: Smatch: Fix potential NULL pointer dereference
Date:   Tue,  2 Jul 2019 18:34:19 +0800
Message-Id: <20190702103420.27540-11-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190702103420.27540-1-leo.yan@linaro.org>
References: <20190702103420.27540-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the following report from Smatch, fix the potential
NULL pointer dereference check.

  tools/perf/util/intel-pt.c:3200
  intel_pt_process_auxtrace_info() error: we previously assumed
  'session->itrace_synth_opts' could be null (see line 3196)

  tools/perf/util/intel-pt.c:3206
  intel_pt_process_auxtrace_info() warn: variable dereferenced before
  check 'session->itrace_synth_opts' (see line 3200)

tools/perf/util/intel-pt.c
3196         if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
3197                 pt->synth_opts = *session->itrace_synth_opts;
3198         } else {
3199                 itrace_synth_opts__set_default(&pt->synth_opts,
3200                                 session->itrace_synth_opts->default_no_sample);
                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^
3201                 if (!session->itrace_synth_opts->default_no_sample &&
3202                     !session->itrace_synth_opts->inject) {
3203                         pt->synth_opts.branches = false;
3204                         pt->synth_opts.callchain = true;
3205                 }
3206                 if (session->itrace_synth_opts)
                         ^^^^^^^^^^^^^^^^^^^^^^^^^^
3207                         pt->synth_opts.thread_stack =
3208                                 session->itrace_synth_opts->thread_stack;
3209         }

To dismiss the potential NULL pointer dereference, this patch validates
the pointer 'session->itrace_synth_opts' before access its elements.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/intel-pt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 550db6e77968..88b567bdf1f9 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -3195,7 +3195,7 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 
 	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
 		pt->synth_opts = *session->itrace_synth_opts;
-	} else {
+	} else if (session->itrace_synth_opts) {
 		itrace_synth_opts__set_default(&pt->synth_opts,
 				session->itrace_synth_opts->default_no_sample);
 		if (!session->itrace_synth_opts->default_no_sample &&
@@ -3203,8 +3203,7 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 			pt->synth_opts.branches = false;
 			pt->synth_opts.callchain = true;
 		}
-		if (session->itrace_synth_opts)
-			pt->synth_opts.thread_stack =
+		pt->synth_opts.thread_stack =
 				session->itrace_synth_opts->thread_stack;
 	}
 
-- 
2.17.1

