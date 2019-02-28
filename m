Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9919C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 05:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C612171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 05:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="YzXWeraF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbfB1FHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 00:07:19 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48324 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730888AbfB1FHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 00:07:11 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1S53BcW016047
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 21:07:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=v4CFG6GAoKDdVvUtX74CjwljSMlGo1gNsqjCsZJtPw0=;
 b=YzXWeraFgk62pg7UYTjA3Te6HeSHG1Jo0XyCpgQ8Q/gJxL6LcOAe73YJK+FNeXMgjImZ
 Wi31tFxOeNMFjIUVLZnJcvzmUgPVp9MTian25Y1OgaM3/mRMdcuNTAwg6lB3UuCx8+RA
 x+k1qVJ9jVNcp3czPAek9YKJU1x+uyJ+rIk= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qx7ej08tt-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 21:07:11 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Wed, 27 Feb 2019 21:07:10 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id BC48362E2B27; Wed, 27 Feb 2019 21:07:08 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <peterz@infradead.org>, <acme@redhat.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v5 perf,bpf 10/15] perf-top: add option --no-bpf-event
Date:   Wed, 27 Feb 2019 21:06:38 -0800
Message-ID: <20190228050643.958685-11-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228050643.958685-1-songliubraving@fb.com>
References: <20190228050643.958685-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_02:,,
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

