Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2342C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2D021955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563817348;
	bh=nVoF7HQDXKKom6WszyBiiO+d/fSfn94PtvavAI2lHww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h4wOs0y6i2DnP4KeZD7YBuznJbH+gJEZAnh9IzB50pGayRbnFL/9FWlqkbVGaQGpM
	 XTF5c4g/3KYZZXePgtk1xTaiXEl+xLhFQRLTUCTp3vGmGHLoOIUqGRlP26CJoFwa2e
	 IP8RpSzrUo9fGDbIx4ndK23VpMd2k9P56BzVhriY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbfGVRm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:42:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728762AbfGVRmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:42:25 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BBD321901;
        Mon, 22 Jul 2019 17:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563817344;
        bh=nVoF7HQDXKKom6WszyBiiO+d/fSfn94PtvavAI2lHww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rtu7Ttcq4y9uFnRX8lt9GrulaC+ndCfAfVaDVaxHTiYe6wb5CXCrxOXXZv3Qj/pnm
         Bnq26PRvUvb0i1qIXTsMGYSmRgl8sKK2BT/cqi15gGWbJ8vyPyHKjrwZsQuWGQJ9aB
         NghacmEW1g9UKKWivO1hKrO3wDKCfpPpqbSKSfKo=
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
Subject: [PATCH 31/37] perf trace: Mark syscall ids that are not allocated to avoid unnecessary error messages
Date:   Mon, 22 Jul 2019 14:38:33 -0300
Message-Id: <20190722173839.22898-32-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722173839.22898-1-acme@kernel.org>
References: <20190722173839.22898-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

There are holes in syscall tables with IDs not associated with any
syscall, mark those when trying to read information for syscalls, which
could happen when iterating thru all syscalls from 0 to the highest
numbered syscall id.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-cku9mpcrcsqaiq0jepu86r68@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 5dae7b172291..765b998755ce 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -976,6 +976,7 @@ static struct syscall_fmt *syscall_fmt__find_by_alias(const char *alias)
  * is_exit: is this "exit" or "exit_group"?
  * is_open: is this "open" or "openat"? To associate the fd returned in sys_exit with the pathname in sys_enter.
  * args_size: sum of the sizes of the syscall arguments, anything after that is augmented stuff: pathname for openat, etc.
+ * nonexistent: Just a hole in the syscall table, syscall id not allocated
  */
 struct syscall {
 	struct tep_event    *tp_format;
@@ -987,6 +988,7 @@ struct syscall {
 	}		    bpf_prog;
 	bool		    is_exit;
 	bool		    is_open;
+	bool		    nonexistent;
 	struct tep_format_field *args;
 	const char	    *name;
 	struct syscall_fmt  *fmt;
@@ -1491,9 +1493,6 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	struct syscall *sc;
 	const char *name = syscalltbl__name(trace->sctbl, id);
 
-	if (name == NULL)
-		return -EINVAL;
-
 	if (id > trace->syscalls.max) {
 		struct syscall *nsyscalls = realloc(trace->syscalls.table, (id + 1) * sizeof(*sc));
 
@@ -1512,8 +1511,15 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	}
 
 	sc = trace->syscalls.table + id;
-	sc->name = name;
+	if (sc->nonexistent)
+		return 0;
 
+	if (name == NULL) {
+		sc->nonexistent = true;
+		return 0;
+	}
+
+	sc->name = name;
 	sc->fmt  = syscall_fmt__find(sc->name);
 
 	snprintf(tp_name, sizeof(tp_name), "sys_enter_%s", sc->name);
@@ -1811,14 +1817,21 @@ static struct syscall *trace__syscall_info(struct trace *trace,
 		return NULL;
 	}
 
+	err = -EINVAL;
+
 	if ((id > trace->syscalls.max || trace->syscalls.table[id].name == NULL) &&
 	    (err = trace__read_syscall_info(trace, id)) != 0)
 		goto out_cant_read;
 
-	err = -EINVAL;
-	if ((id > trace->syscalls.max || trace->syscalls.table[id].name == NULL))
+	if (id > trace->syscalls.max)
 		goto out_cant_read;
 
+	if (trace->syscalls.table[id].name == NULL) {
+		if (trace->syscalls.table[id].nonexistent)
+			return NULL;
+		goto out_cant_read;
+	}
+
 	return &trace->syscalls.table[id];
 
 out_cant_read:
-- 
2.21.0

