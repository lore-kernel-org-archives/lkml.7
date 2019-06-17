Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50112C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2043A2084B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="LHwPyqm0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfFQTkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:40:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35507 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfFQTkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:40:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJeJnu3566767
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:40:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJeJnu3566767
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560800419;
        bh=zfyILpZPjASIQuP0wYQ38vLOiJOJAIHpiX2PdGe4qc8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=LHwPyqm0fbMhw0xVJJNIOZRQGPErJswWBI1vUMQjEle5BSVqGDlr6EsiES/gvZ1j1
         6nw/1k5NWURY1kuvkYt8C933hJ3t5PFCKtBOoTaq0AkEfpUrq3OvdG/Q8OYxZNE5j9
         Zek1WAe4ZO69TBSHKbmtLOCnIlknridkUiI5zD7NgyDIAxucrTGMF6qM0UBqTtXCyT
         RzYg84z7XnhdmexjlmcGvdKf5IkbXBAfYN8eT6dS7WH9NZ7/yQ4xbz3UtMToQ85TfC
         iDEmKOFmk7qiWATgISWk71ggT+OO/Lt66atf9FwJ+eLQdcLEl/5V7QndmouqdNSdPW
         EpyKKVcgpxETw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJeJdW3566764;
        Mon, 17 Jun 2019 12:40:19 -0700
Date:   Mon, 17 Jun 2019 12:40:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-4d678e9039b075f9418600dc87ec5e61cfb57115@git.kernel.org>
Cc:     acme@redhat.com, hpa@zytor.com, yao.jin@linux.intel.com,
        adrian.hunter@intel.com, mingo@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, jolsa@redhat.com
Reply-To: jolsa@redhat.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, mingo@kernel.org, acme@redhat.com,
          adrian.hunter@intel.com, yao.jin@linux.intel.com, hpa@zytor.com
In-Reply-To: <20190604130017.31207-5-adrian.hunter@intel.com>
References: <20190604130017.31207-5-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Add lookahead callback
Git-Commit-ID: 4d678e9039b075f9418600dc87ec5e61cfb57115
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

Commit-ID:  4d678e9039b075f9418600dc87ec5e61cfb57115
Gitweb:     https://git.kernel.org/tip/4d678e9039b075f9418600dc87ec5e61cfb57115
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 4 Jun 2019 16:00:02 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 16:20:12 -0300

perf intel-pt: Add lookahead callback

Add a callback function to enable the decoder to lookahead at subsequent
trace buffers. This will be used to implement a "fast forward" facility
which will be needed to support efficient time interval filtering.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 2 ++
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 9eb778f9c911..13123b195083 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -104,6 +104,7 @@ struct intel_pt_decoder {
 			 uint64_t *insn_cnt_ptr, uint64_t *ip, uint64_t to_ip,
 			 uint64_t max_insn_cnt, void *data);
 	bool (*pgd_ip)(uint64_t ip, void *data);
+	int (*lookahead)(void *data, intel_pt_lookahead_cb_t cb, void *cb_data);
 	void *data;
 	struct intel_pt_state state;
 	const unsigned char *buf;
@@ -233,6 +234,7 @@ struct intel_pt_decoder *intel_pt_decoder_new(struct intel_pt_params *params)
 	decoder->get_trace          = params->get_trace;
 	decoder->walk_insn          = params->walk_insn;
 	decoder->pgd_ip             = params->pgd_ip;
+	decoder->lookahead          = params->lookahead;
 	decoder->data               = params->data;
 	decoder->return_compression = params->return_compression;
 	decoder->branch_enable      = params->branch_enable;
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
index 6a61773dc44b..de36254c6ac9 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
@@ -102,12 +102,15 @@ struct intel_pt_buffer {
 	uint64_t trace_nr;
 };
 
+typedef int (*intel_pt_lookahead_cb_t)(struct intel_pt_buffer *, void *);
+
 struct intel_pt_params {
 	int (*get_trace)(struct intel_pt_buffer *buffer, void *data);
 	int (*walk_insn)(struct intel_pt_insn *intel_pt_insn,
 			 uint64_t *insn_cnt_ptr, uint64_t *ip, uint64_t to_ip,
 			 uint64_t max_insn_cnt, void *data);
 	bool (*pgd_ip)(uint64_t ip, void *data);
+	int (*lookahead)(void *data, intel_pt_lookahead_cb_t cb, void *cb_data);
 	void *data;
 	bool return_compression;
 	bool branch_enable;
