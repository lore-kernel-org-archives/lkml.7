Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4702FC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7C921848
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PbMf7J/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404041AbfEXRfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:35:32 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39925 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403760AbfEXRfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:35:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id g9so4428410plm.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 10:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YLacy1WPwP51koJcLQmVsZoOnuNjPchkGCoMeaoSKY0=;
        b=PbMf7J/qOFFHjE14/KNNPvY5OfVNXGAe0ZimeRsh0+rhLDvruXtj++2+flmB2aGIaC
         s9IJ4Q07SsfQ0xgio00zDFvPj04UUUwFfL2LAk3O66Ap8wxFMqF/d3OXCMQpafm0tCHM
         FgZEG9btQkW6KQsNFbFWhBsijEyH9j+cCvnkdNzUOwt83fDO3QC2DTAO1QCt0zZIHQnh
         B3OfDA+GZvx5L3HchUBTZIUHB8wvcq1YktzCW9t5ZDB4awLNqgYxfn1UoET7UMavxAde
         WeaIBdbapBVQriocvrZnP5kONla55nKGETkfkzVPYaGxZkUTkEwl3iv8Qw9/sDpM0E8F
         SOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YLacy1WPwP51koJcLQmVsZoOnuNjPchkGCoMeaoSKY0=;
        b=sd/B6iVdcvRWrvWwHuyO8GiOTvoTgAsW0xb3ksyeyskpMymozc8v1onIZx8pv0wfN8
         /AZY/Q26/bNO20KwzEhY8PuVIRyiwVE92/raT2tI3yIKzb9gKwsFRiRyDzamyUXi0lX1
         1yKlYhwBZIeRGdCbGee5Jgu/tYDlXFQitGbWhbLhq/WSFBeLHicHKFylr7imjrTZlV9p
         cpQD1fLuxELCyBt7275Shw3AFrYKl8VQRiOCahd04CVLJklOnubMKYvP1OjEDHDzQpFi
         dJD9V/CW99qOmumlCuxdRGK9QZ26Bm1iBX+VytaP2y9n78NTfBDtkT79OQB9JWCLTF4j
         byGQ==
X-Gm-Message-State: APjAAAVVKJCvXyu+i2MdjX6pgkPopeOcD/gtxDcLhEKPmhxmoFSWUCaz
        NVTHxVhYxGJxhi1nfocSijWxBA==
X-Google-Smtp-Source: APXvYqyEljwtF2aPGLMaaB5XZlYvbtIkfWwLGbfe1U2CTiCp3BNkwG9mfjnNV/YIhKuF/Cj/mAqX1w==
X-Received: by 2002:a17:902:b095:: with SMTP id p21mr56107478plr.270.1558719329130;
        Fri, 24 May 2019 10:35:29 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id k13sm2809575pgr.90.2019.05.24.10.35.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 10:35:28 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, suzuki.poulose@arm.com, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org
Subject: [PATCH v2 15/17] perf tools: Linking PE contextID with perf thread mechanic
Date:   Fri, 24 May 2019 11:35:06 -0600
Message-Id: <20190524173508.29044-16-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524173508.29044-1-mathieu.poirier@linaro.org>
References: <20190524173508.29044-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Link contextID packets received from the decoder with the perf tool thread
mechanic so that we know the specifics of the process currently executing.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 20 ++++++++++++
 tools/perf/util/cs-etm.c                      | 32 +++++++++++++++----
 tools/perf/util/cs-etm.h                      | 10 ++++++
 3 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 87264b79de0e..ce85e52f989c 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -402,6 +402,24 @@ cs_etm_decoder__buffer_exception_ret(struct cs_etm_packet_queue *queue,
 					     CS_ETM_EXCEPTION_RET);
 }
 
+static ocsd_datapath_resp_t
+cs_etm_decoder__set_tid(struct cs_etm_queue *etmq,
+			const ocsd_generic_trace_elem *elem,
+			const uint8_t trace_chan_id)
+{
+	pid_t tid;
+
+	/* Ignore PE_CONTEXT packets that don't have a valid contextID */
+	if (!elem->context.ctxt_id_valid)
+		return OCSD_RESP_CONT;
+
+	tid =  elem->context.context_id;
+	if (cs_etm__etmq_set_tid(etmq, tid, trace_chan_id))
+		return OCSD_RESP_FATAL_SYS_ERR;
+
+	return OCSD_RESP_CONT;
+}
+
 static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 				const void *context,
 				const ocsd_trc_index_t indx __maybe_unused,
@@ -440,6 +458,8 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 							    trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_PE_CONTEXT:
+		resp = cs_etm_decoder__set_tid(etmq, elem, trace_chan_id);
+		break;
 	case OCSD_GEN_TRC_ELEM_ADDR_NACC:
 	case OCSD_GEN_TRC_ELEM_TIMESTAMP:
 	case OCSD_GEN_TRC_ELEM_CYCLE_COUNT:
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index afc2491f9f2a..17adf554b679 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -907,13 +907,8 @@ cs_etm__get_trace(struct cs_etm_queue *etmq)
 }
 
 static void cs_etm__set_pid_tid_cpu(struct cs_etm_auxtrace *etm,
-				    struct auxtrace_queue *queue,
 				    struct cs_etm_traceid_queue *tidq)
 {
-	/* CPU-wide tracing isn't supported yet */
-	if (queue->tid == -1)
-		return;
-
 	if ((!tidq->thread) && (tidq->tid != -1))
 		tidq->thread = machine__find_thread(etm->machine, -1,
 						    tidq->tid);
@@ -922,6 +917,31 @@ static void cs_etm__set_pid_tid_cpu(struct cs_etm_auxtrace *etm,
 		tidq->pid = tidq->thread->pid_;
 }
 
+int cs_etm__etmq_set_tid(struct cs_etm_queue *etmq,
+			 pid_t tid, u8 trace_chan_id)
+{
+	int cpu, err = -EINVAL;
+	struct cs_etm_auxtrace *etm = etmq->etm;
+	struct cs_etm_traceid_queue *tidq;
+
+	tidq = cs_etm__etmq_get_traceid_queue(etmq, trace_chan_id);
+	if (!tidq)
+		return err;
+
+	if (cs_etm__get_cpu(trace_chan_id, &cpu) < 0)
+		return err;
+
+	err = machine__set_current_tid(etm->machine, cpu, tid, tid);
+	if (err)
+		return err;
+
+	tidq->tid = tid;
+	thread__zput(tidq->thread);
+
+	cs_etm__set_pid_tid_cpu(etm, tidq);
+	return 0;
+}
+
 static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 					    struct cs_etm_traceid_queue *tidq,
 					    u64 addr, u64 period)
@@ -1866,7 +1886,7 @@ static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
 			continue;
 
 		if ((tid == -1) || (tidq->tid == tid)) {
-			cs_etm__set_pid_tid_cpu(etm, queue, tidq);
+			cs_etm__set_pid_tid_cpu(etm, tidq);
 			cs_etm__run_decoder(etmq);
 		}
 	}
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index f16082d37ab5..b2a7628620bf 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -181,6 +181,8 @@ struct cs_etm_packet_queue {
 int cs_etm__process_auxtrace_info(union perf_event *event,
 				  struct perf_session *session);
 int cs_etm__get_cpu(u8 trace_chan_id, int *cpu);
+int cs_etm__etmq_set_tid(struct cs_etm_queue *etmq,
+			 pid_t tid, u8 trace_chan_id);
 struct cs_etm_packet_queue
 *cs_etm__etmq_get_packet_queue(struct cs_etm_queue *etmq, u8 trace_chan_id);
 #else
@@ -197,6 +199,14 @@ static inline int cs_etm__get_cpu(u8 trace_chan_id __maybe_unused,
 	return -1;
 }
 
+static inline int cs_etm__etmq_set_tid(
+				struct cs_etm_queue *etmq __maybe_unused,
+				pid_t tid __maybe_unused,
+				u8 trace_chan_id __maybe_unused)
+{
+	return -1;
+}
+
 static inline struct cs_etm_packet_queue *cs_etm__etmq_get_packet_queue(
 				struct cs_etm_queue *etmq __maybe_unused,
 				u8 trace_chan_id __maybe_unused)
-- 
2.17.1

