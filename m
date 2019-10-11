Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEC9C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC94021835
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824498;
	bh=rrprCC+fpmEsp9dkj8+1FKi2vkw345N6V9a/L2yUAb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eUaPEAXQe6CdW3iwfZjKM1TR9+q6cZgT00BF5VLTnxn4iRsbHkAVpyvAmyDlOkPvX
	 NKAaCgLRQ1JcxVJn01PWsbuUD/WvMWnNyvImxlk2u33TnewCW6DJ4L6xN7uMVsgiuc
	 +S9TmB4GRFNsGl/nx3M6//vclwlEAA+aimSLxEj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbfJKUIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:08:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729032AbfJKUIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:08:16 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F13121D7F;
        Fri, 11 Oct 2019 20:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824496;
        bh=rrprCC+fpmEsp9dkj8+1FKi2vkw345N6V9a/L2yUAb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HsgB7E3nHgbpQYXuTqPFO0rWpZDPgU7FQFOVX+CW0GXG1v+wXkLt48xuGj7QcZIO0
         sZP1gVGEJfQ9OpTJUf4ZBO0f8nAu5evLLtcCrAoUkmNHZi3SNB82j2H4Y0Ay3EHSrE
         TafZOCum4/IStL62XIZO86RQUVPaqo8M1wkw/UvY=
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
Subject: [PATCH 20/69] perf trace: Move some scnprintf methods from syscall to syscall_arg_fmt
Date:   Fri, 11 Oct 2019 17:05:10 -0300
Message-Id: <20191011200559.7156-21-acme@kernel.org>
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

Since all they operate on is on a syscall_arg_fmt instance, so move them
to allow use it from the upcoming tracepoint fprintf routine.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ynttrs1l75f0x9tk67spd7jd@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index aa70602c2808..82d39ef43d9c 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1715,22 +1715,22 @@ static size_t syscall__scnprintf_name(struct syscall *sc, char *bf, size_t size,
  * as mount 'flags' argument that needs ignoring some magic flag, see comment
  * in tools/perf/trace/beauty/mount_flags.c
  */
-static unsigned long syscall__mask_val(struct syscall *sc, struct syscall_arg *arg, unsigned long val)
+static unsigned long syscall_arg_fmt__mask_val(struct syscall_arg_fmt *fmt, struct syscall_arg *arg, unsigned long val)
 {
-	if (sc->arg_fmt && sc->arg_fmt[arg->idx].mask_val)
-		return sc->arg_fmt[arg->idx].mask_val(arg, val);
+	if (fmt && fmt->mask_val)
+		return fmt->mask_val(arg, val);
 
 	return val;
 }
 
-static size_t syscall__scnprintf_val(struct syscall *sc, char *bf, size_t size,
-				     struct syscall_arg *arg, unsigned long val)
+static size_t syscall_arg_fmt__scnprintf_val(struct syscall_arg_fmt *fmt, char *bf, size_t size,
+					     struct syscall_arg *arg, unsigned long val)
 {
-	if (sc->arg_fmt && sc->arg_fmt[arg->idx].scnprintf) {
+	if (fmt && fmt->scnprintf) {
 		arg->val = val;
-		if (sc->arg_fmt[arg->idx].parm)
-			arg->parm = sc->arg_fmt[arg->idx].parm;
-		return sc->arg_fmt[arg->idx].scnprintf(bf, size, arg);
+		if (fmt->parm)
+			arg->parm = fmt->parm;
+		return fmt->scnprintf(bf, size, arg);
 	}
 	return scnprintf(bf, size, "%ld", val);
 }
@@ -1776,7 +1776,7 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 			 * Some syscall args need some mask, most don't and
 			 * return val untouched.
 			 */
-			val = syscall__mask_val(sc, &arg, val);
+			val = syscall_arg_fmt__mask_val(&sc->arg_fmt[arg.idx], &arg, val);
 
 			/*
  			 * Suppress this argument if its value is zero and
@@ -1797,7 +1797,8 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 			if (trace->show_arg_names)
 				printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
 
-			printed += syscall__scnprintf_val(sc, bf + printed, size - printed, &arg, val);
+			printed += syscall_arg_fmt__scnprintf_val(&sc->arg_fmt[arg.idx],
+								  bf + printed, size - printed, &arg, val);
 		}
 	} else if (IS_ERR(sc->tp_format)) {
 		/*
@@ -1812,7 +1813,7 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 			if (printed)
 				printed += scnprintf(bf + printed, size - printed, ", ");
 			printed += syscall__scnprintf_name(sc, bf + printed, size - printed, &arg);
-			printed += syscall__scnprintf_val(sc, bf + printed, size - printed, &arg, val);
+			printed += syscall_arg_fmt__scnprintf_val(&sc->arg_fmt[arg.idx], bf + printed, size - printed, &arg, val);
 next_arg:
 			++arg.idx;
 			bit <<= 1;
-- 
2.21.0

