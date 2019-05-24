Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259F1C282E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9062184E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hSBPmd0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391641AbfEXRfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:35:19 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36368 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391421AbfEXRfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:35:15 -0400
Received: by mail-pl1-f196.google.com with SMTP id d21so4439635plr.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 10:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bHfFo/ORpsa03SvyTpjVHtc4WYRwtr5BeZCOvFgzYZo=;
        b=hSBPmd0yHRq5YPvvnYa5Gx0AuXkJSH3B/lf9UvmmoD/BV8lpht4l4I20wq2uLPOEPs
         u7ufCc6pRQ3OIj5ikzw7wj6tCJb8XA05l+3Ag8o3CxvMzdRYsLnd4zvezjzSjKixKYF9
         tCi1s+z/0fQW6n6IyymDffRnqsMm0576GcSIFZko3qMfIcB7H2Yn1EIFnLBxojtntpDI
         up25DcEbYTZjo+CzyW8v3n6/ZyYz/e/SGmtK8MXqs7PkzM0602OyS2k2oNGTq/ntRLDa
         9thUJP0L0kIiwr1tfYWkIzSUvthKBLIhli1z9zahMaCO5znW4HJDhWd/ywN2Z6EnDT0n
         do3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bHfFo/ORpsa03SvyTpjVHtc4WYRwtr5BeZCOvFgzYZo=;
        b=Cm+GQC/PbgYaMjnm5rd8cALxFZx/M3Noc1nl3NWjtuEcKaWG856wE1LYSKyh2iM0gw
         ayT2N1DP9Jb/SbaQZ+D/m+Wp4Pg2qB0IdH04qlMDOHTpFOJqDo+MRFgScEafdIc02Uh2
         LhqS5o7YAUsVVJSw0Tvx0+ZcZfKbe9HUJqYiH2+KOGAb5mLRzq4/VHfPDps28gvBS0C4
         gMTZeLoiJ0LQ5O6xYfUmTr3b7kIx4nu8rkEqAXNUoLKVIgAyHS7fCRkYiiLt2mIfhB9Z
         nbS7RXBca9lhnejZCqK4WppfJzIz2RwVGtU+FET8ObsQIm6aD73vMwHjdNZFkaJxGhbx
         Z2Xw==
X-Gm-Message-State: APjAAAUprWX43ySPIqGLV6JGgEl0gOdBFctnP8egogjCtFwGp5C6Up9P
        iqh8Drw7JHkY98SfASFag/JUcw==
X-Google-Smtp-Source: APXvYqw3jFqGsxy+JmYpU6cE0TmMJET0MNIbWGdNxRz1i1yMAvwnbNIlpfoAHYWR6fWUT4Gq5Oe/rw==
X-Received: by 2002:a17:902:2e81:: with SMTP id r1mr91812796plb.0.1558719314882;
        Fri, 24 May 2019 10:35:14 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id k13sm2809575pgr.90.2019.05.24.10.35.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 10:35:14 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, suzuki.poulose@arm.com, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org
Subject: [PATCH v2 04/17] perf tools: Add handling of itrace start events
Date:   Fri, 24 May 2019 11:34:55 -0600
Message-Id: <20190524173508.29044-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524173508.29044-1-mathieu.poirier@linaro.org>
References: <20190524173508.29044-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add handling of ITRACE events in order to add the tid/pid of the executing
process to the perf tools machine infrastructure.  This information is
later retrieved when a contextID packet is found in the trace stream.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index de488b43f440..0742c50fce46 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1657,6 +1657,29 @@ static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
 	return 0;
 }
 
+static int cs_etm__process_itrace_start(struct cs_etm_auxtrace *etm,
+					union perf_event *event)
+{
+	struct thread *th;
+
+	if (etm->timeless_decoding)
+		return 0;
+
+	/*
+	 * Add the tid/pid to the log so that we can get a match when
+	 * we get a contextID from the decoder.
+	 */
+	th = machine__findnew_thread(etm->machine,
+				     event->itrace_start.pid,
+				     event->itrace_start.tid);
+	if (!th)
+		return -ENOMEM;
+
+	thread__put(th);
+
+	return 0;
+}
+
 static int cs_etm__process_event(struct perf_session *session,
 				 union perf_event *event,
 				 struct perf_sample *sample,
@@ -1694,6 +1717,9 @@ static int cs_etm__process_event(struct perf_session *session,
 		return cs_etm__process_timeless_queues(etm,
 						       event->fork.tid);
 
+	if (event->header.type == PERF_RECORD_ITRACE_START)
+		return cs_etm__process_itrace_start(etm, event);
+
 	return 0;
 }
 
-- 
2.17.1

