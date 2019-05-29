Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20583C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB05E227C1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559137146;
	bh=emzLFUDQuhdJwQnbUToL/v8QNtt3gWilF44Xqyy7kKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eSI5+sZpS+mA/PDSFaENY/lAt6i3aD4kZ134J0oPrimoQcwysN3W651UrdocD3j22
	 Yc4IlF93VIcb33ffgVZ2WwbMcjc1NwTLY49n3YoYVLcCuQlWTcv5wirbmbCrZ9oETY
	 qVWesfW6BW2rfK4QWx5qObftL8FGudLaGDeElPm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfE2NjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:39:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbfE2NjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:39:04 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.211.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DC45223A1;
        Wed, 29 May 2019 13:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559137143;
        bh=emzLFUDQuhdJwQnbUToL/v8QNtt3gWilF44Xqyy7kKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ds7LpoFf/a2fDpvOQebNvinBQXPdBOeJlZOq2uywJPCJzFLipHlexnuQx7cfeqtdo
         SvlhuSepq2E55V5z7C8F+806/SpzNYvIobjJxIb2se2yeSg6qT1nvrwU+JXyeRb0Rc
         oHTXSDNkpVXw3r0GvbAw30qYIXzcxWP/zSj1ZaHg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Starovoitov <ast@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Wang Nan <wangnan0@huawei.com>, Yonghong Song <yhs@fb.com>
Subject: [PATCH 34/41] perf top: Lower message level for failure on synthesizing events for pre-existing BPF programs
Date:   Wed, 29 May 2019 10:35:58 -0300
Message-Id: <20190529133605.21118-35-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529133605.21118-1-acme@kernel.org>
References: <20190529133605.21118-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.20.1

