Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1116C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9734824997
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Wwta/Nfz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfE3IRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 04:17:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60849 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfE3IRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:17:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U8Gte02905184
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 01:16:55 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U8Gte02905184
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559204216;
        bh=emgwORxdB8CkVtvtgC0tsEMlgEFIslty5A0OUQmTyKE=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=Wwta/Nfz9o1+A0c7zAF8Om89/fMTwlRCQ5l484v6EFW/9GDA4Zfbq3kD2VEiC50GY
         m+VZJIUj9jHmqO5q6tmc6WPLATgoUPTkEi57L6YcdhNgAP3kcMjtHbY9jpbE23oTgD
         pu7NF61mJJAuhCibhhwL9FSl2U+Vmo22l22N0PlFRPHbv5jZAx9DgG0n44ByZp01uL
         fPkScOVtDerp9MgrQbAe/jDuoWw8KGT5bI6+Wai4DYWnNs1HhrurVJTW2dy+AXNxXJ
         LYicA+jiqugGSY3xGODiyNUNUyK2U71TB0tpILcGPd+8FRLpLErtX2l7Nn4O8AnZS8
         254VEFDHh7sEw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U8GscR2905178;
        Thu, 30 May 2019 01:16:54 -0700
Date:   Thu, 30 May 2019 01:16:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-whpnfnw6xtd939odgt9bw9as@git.kernel.org>
Cc:     wangnan0@huawei.com, ast@fb.com, acme@redhat.com,
        daniel@iogearbox.net, kafai@fb.com, adrian.hunter@intel.com,
        lclaudio@redhat.com, tglx@linutronix.de, andrii.nakryiko@gmail.com,
        yhs@fb.com, songliubraving@fb.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, mingo@kernel.org
Reply-To: namhyung@kernel.org, mingo@kernel.org, jolsa@kernel.org,
          andrii.nakryiko@gmail.com, yhs@fb.com,
          linux-kernel@vger.kernel.org, songliubraving@fb.com,
          hpa@zytor.com, kafai@fb.com, adrian.hunter@intel.com,
          daniel@iogearbox.net, tglx@linutronix.de, lclaudio@redhat.com,
          wangnan0@huawei.com, acme@redhat.com, ast@fb.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf top: Lower message level for failure on
 synthesizing events for pre-existing BPF programs
Git-Commit-ID: 2d45ef7033ec90104ae8e4c3996227bdad24dc76
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

Commit-ID:  2d45ef7033ec90104ae8e4c3996227bdad24dc76
Gitweb:     https://git.kernel.org/tip/2d45ef7033ec90104ae8e4c3996227bdad24dc76
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 20 May 2019 11:04:08 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:45 -0300

perf top: Lower message level for failure on synthesizing events for pre-existing BPF programs

Move it from being a pr_warning() to a pr_debug(). Also capitalize BPF
and explain what gets missing when we're not able to synthesize these
events: we'll not be able to resolve symbols, etc.

Reported-by: Ingo Molnar <mingo@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexei Starovoitov <ast@fb.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/n/tip-whpnfnw6xtd939odgt9bw9as@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 31d78d874fc7..6651377fd762 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1215,7 +1215,7 @@ static int __cmd_top(struct perf_top *top)
 						&top->session->machines.host,
 						&top->record_opts);
 	if (ret < 0)
-		pr_warning("Couldn't synthesize bpf events.\n");
+		pr_debug("Couldn't synthesize BPF events: Pre-existing BPF programs won't have symbols resolved.\n");
 
 	machine__synthesize_threads(&top->session->machines.host, &opts->target,
 				    top->evlist->threads, false,
