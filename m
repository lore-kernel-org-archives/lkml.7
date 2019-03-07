Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464D9C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1991120854
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="rO98Ekcu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfCGSCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:02:19 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53532 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726491AbfCGSCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:02:19 -0500
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x27I0H8h018751
        for <linux-kernel@vger.kernel.org>; Thu, 7 Mar 2019 10:02:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=v4CFG6GAoKDdVvUtX74CjwljSMlGo1gNsqjCsZJtPw0=;
 b=rO98Ekcu+2J32ZhtOxdIhXN+aCcvcAr79D+PhYe2JKwA5/z+gnjVWbQjuIsCyZfsT2KP
 ggJP5UJD9JptF+GXWq8D3e25A4Q1wEK6CTdoVhu6PqugxEp6LCcJ2PcaUgbVXTCAQBDt
 JM0OF9Yf2wZTPawsbKJO+VfXITZC21GDB8A= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2r35sd0kef-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 10:02:17 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 7 Mar 2019 09:58:37 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id ADF1B62E1750; Thu,  7 Mar 2019 09:58:35 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <peterz@infradead.org>, <acme@redhat.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v7 perf,bpf 10/15] perf-top: add option --no-bpf-event
Date:   Thu, 7 Mar 2019 09:58:05 -0800
Message-ID: <20190307175810.249857-11-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190307175810.249857-1-songliubraving@fb.com>
References: <20190307175810.249857-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-07_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bpf events should be tracked by default for perf-top. This patch makes it
on by default, and adds option to disable bpf events.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/builtin-top.c | 3 +++
 tools/perf/util/top.h    | 1 +
 2 files changed, 4 insertions(+)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 27d8d42e0a4d..ccdf5689452f 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1492,6 +1492,7 @@ int cmd_top(int argc, const char **argv)
 		    "Display raw encoding of assembly instructions (default)"),
 	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
 		    "Enable kernel symbol demangling"),
+	OPT_BOOLEAN(0, "no-bpf-event", &top.no_bpf_event, "do not record bpf events"),
 	OPT_STRING(0, "objdump", &top.annotation_opts.objdump_path, "path",
 		    "objdump binary to use for disassembly and annotations"),
 	OPT_STRING('M', "disassembler-style", &top.annotation_opts.disassembler_style, "disassembler style",
@@ -1651,6 +1652,8 @@ int cmd_top(int argc, const char **argv)
 		signal(SIGWINCH, winch_sig);
 	}
 
+	top.record_opts.bpf_event = !top.no_bpf_event;
+
 	status = __cmd_top(&top);
 
 out_delete_evlist:
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index 19f95eaf75c8..862a37bd27ea 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -32,6 +32,7 @@ struct perf_top {
 	bool		   use_tui, use_stdio;
 	bool		   vmlinux_warned;
 	bool		   dump_symtab;
+	bool		   no_bpf_event;
 	struct hist_entry  *sym_filter_entry;
 	struct perf_evsel  *sym_evsel;
 	struct perf_session *session;
-- 
2.17.1

