Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7294AECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4070921835
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824510;
	bh=fxTRJmPP8/Q6231A05L/6xoeZpBKEqZck5iOLaN2ChE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K+qZOclHMnZftxmmBJjGFUd2HjNCHm9Y/C5Mj3/gEH9+CWftuXRlfBQD0B5E3SKUH
	 Sce5wgVaWwDQ8aKUN34dMCY83ha4X0I02ioZ4PlSK+vR9m++HPmUxtqiOUsh9WK7RL
	 jfwb+OrtU7Qf6Q6Aw0289DsBuKvhp0bEAVMsNjkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbfJKUI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:08:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729032AbfJKUI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:08:27 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3497B222C3;
        Fri, 11 Oct 2019 20:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824506;
        bh=fxTRJmPP8/Q6231A05L/6xoeZpBKEqZck5iOLaN2ChE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ju+5usehVdtRC78Q8rZ3g5O5XYsk4ttNUiHWQA2l8xXlVP+H8wXNvMYn0LKQDADT6
         q3VHjBH2vJd4/zZIAIZsy0xv1/dwTYi/PmFoi1FHI+kRHcwTa8li2kB6QDHubGXSZc
         tjash4uMlzhXrqGNrdrAx/LV4ReQ6dcPwhvVZeVw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 22/69] perf trace: Add array of chars scnprintf beautifier
Date:   Fri, 11 Oct 2019 17:05:12 -0300
Message-Id: <20191011200559.7156-23-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Needed for sched's traceoints prev/next comm, where, unlike with
syscalls, we are not dealing with an integer or pointer, but an array
straight out from the ring buffer.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-rlll7tmcqe1g4odtaifil5re@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index f30296c72415..b3fb208cbd30 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -91,6 +91,7 @@ struct syscall_arg_fmt {
 	unsigned long (*mask_val)(struct syscall_arg *arg, unsigned long val);
 	void	   *parm;
 	const char *name;
+	u16	   nr_entries; // for arrays
 	bool	   show_zero;
 };
 
@@ -522,6 +523,16 @@ size_t syscall_arg__scnprintf_long(char *bf, size_t size, struct syscall_arg *ar
 	return scnprintf(bf, size, "%ld", arg->val);
 }
 
+static size_t syscall_arg__scnprintf_char_array(char *bf, size_t size, struct syscall_arg *arg)
+{
+	// XXX Hey, maybe for sched:sched_switch prev/next comm fields we can
+	//     fill missing comms using thread__set_comm()...
+	//     here or in a special syscall_arg__scnprintf_pid_sched_tp...
+	return scnprintf(bf, size, "\"%-.*s\"", arg->fmt->nr_entries, arg->val);
+}
+
+#define SCA_CHAR_ARRAY syscall_arg__scnprintf_char_array
+
 static const char *bpf_cmd[] = {
 	"MAP_CREATE", "MAP_LOOKUP_ELEM", "MAP_UPDATE_ELEM", "MAP_DELETE_ELEM",
 	"MAP_GET_NEXT_KEY", "PROG_LOAD",
@@ -1491,7 +1502,10 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 			arg->scnprintf = SCA_PID;
 		else if (strcmp(field->type, "umode_t") == 0)
 			arg->scnprintf = SCA_MODE_T;
-		else if ((strcmp(field->type, "int") == 0 ||
+		else if ((field->flags & TEP_FIELD_IS_ARRAY) && strstarts(field->type, "char")) {
+			arg->scnprintf = SCA_CHAR_ARRAY;
+			arg->nr_entries = field->arraylen;
+		} else if ((strcmp(field->type, "int") == 0 ||
 			  strcmp(field->type, "unsigned int") == 0 ||
 			  strcmp(field->type, "long") == 0) &&
 			 len >= 2 && strcmp(field->name + len - 2, "fd") == 0) {
-- 
2.21.0

