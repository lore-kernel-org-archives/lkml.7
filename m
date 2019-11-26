Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E15C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 23:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47CA8207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 23:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574811746;
	bh=xEjJUKBizA1h6LRBMtaK8Yxgw1yJRoT2MEgw3AULkzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q+TyHf++bm+4qEtcWUhJSXB7UMmHgUr3Yam3695XXwgF2mfaZx0xWHIFvyl2IcdCG
	 jLfnoqx5kqHXsYopiSs4L6s7UNF/W0GJcRWnQoj1yTHHgzAer/VG/a/TMPDOiTV6RC
	 txWq2hjXzMKF9xUa5KTqK+Nafhl7estGED/n1wV8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKZXmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 18:42:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:46528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbfKZXmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 18:42:24 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 851E620722;
        Tue, 26 Nov 2019 23:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574811744;
        bh=xEjJUKBizA1h6LRBMtaK8Yxgw1yJRoT2MEgw3AULkzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aRkJ6rT6U1vHnAJ2d4iODgs3b02SQL3IHxWCTB1G7ewih9k0mtV7fKZTF9xVTY77P
         aOLKfi2R54xr+px0UbkF4UAgZakgQ5Bc0yZU9fz9Y2yRgX7bAcRmc6dhAysPkANY1A
         L2Ny12AQg6tnhCEY9urLWTEVcLnwnsTM6tt5e+D4=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH v4.1 2/4] selftests/ftrace: Fix ftrace test cases to check unsupported
Date:   Wed, 27 Nov 2019 08:42:21 +0900
Message-Id: <157481174125.14250.15128095352741182690.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191127083123.0257d2c450bfd87b0691300d@kernel.org>
References: <20191127083123.0257d2c450bfd87b0691300d@kernel.org>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since dynamic function tracer can be disabled, set_ftrace_filter
can be disappeared. Test cases which depends on it, must check
whether the set_ftrace_filter exists or not before testing
and if not, return as unsupported.

Also, if the function tracer itself is disabled, we can not
set "function" to current_tracer. Test cases must check it
before testing, and return as unsupported.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Changes in v4.1
  - Add double-quote to "function" word for checkbashisms clean
    (Thanks Steve!)
---
 .../ftrace/test.d/ftrace/func-filter-stacktrace.tc |    2 ++
 .../selftests/ftrace/test.d/ftrace/func_cpumask.tc |    5 +++++
 2 files changed, 7 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
index 36fb59f886ea..1a52f2883fe0 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
@@ -3,6 +3,8 @@
 # description: ftrace - stacktrace filter command
 # flags: instance
 
+[ ! -f set_ftrace_filter ] && exit_unsupported
+
 echo _do_fork:stacktrace >> set_ftrace_filter
 
 grep -q "_do_fork:stacktrace:unlimited" set_ftrace_filter
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
index 86a1f07ef2ca..71fa3f49e35e 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
@@ -15,6 +15,11 @@ if [ $NP -eq 1 ] ;then
   exit_unresolved
 fi
 
+if ! grep -q "function" available_tracers ; then
+  echo "Function trace is not enabled"
+  exit_unsupported
+fi
+
 ORIG_CPUMASK=`cat tracing_cpumask`
 
 do_reset() {

