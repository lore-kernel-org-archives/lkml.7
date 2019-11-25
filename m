Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7772DC43215
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 00:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 443782073F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 00:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574640694;
	bh=phZqQ51DaGnCQflW3J09B6LC13NsFK9mZ6NFiZrDYeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=unQgr4rj8fNqHNJ5p8xn6zM5rYuCBsVZCi7rtmh+KMoywpkpTXG8aXUNaKA00s2M6
	 zKEMPcssXFzR2kTXoTE16wQDntXV/kBHtECbSdKJ4mE0obJ49ciACWqJ9WKU+WCey+
	 IP0VUh/mJtQyZIx130OU1h/aBK6cxj2TXIoF4EEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfKYALd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 19:11:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:35712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbfKYALd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 19:11:33 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 798C72071A;
        Mon, 25 Nov 2019 00:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574640692;
        bh=phZqQ51DaGnCQflW3J09B6LC13NsFK9mZ6NFiZrDYeo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MZIx9bJOIqFRHKslUcx4faGD1QYi3etEZibNn2mCDTItU7Ff/rikesjRLStjSZ97N
         UwTiN+sMH7lwuFnPVb2stGX6zSHP4WrdpykpiwvBUDn+dzYRCzlu51Y0wfi4fGj84z
         yJSSgCQ9nt4Rg6cIeaWuNhE32hNzU9O2EqC73Hmc=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH v2 2/3] selftests/ftrace: Fix ftrace test cases to check unsupported
Date:   Mon, 25 Nov 2019 09:11:29 +0900
Message-Id: <157464068938.2006.2309427604804731225.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157464067201.2006.6413506591718899129.stgit@devnote2>
References: <157464067201.2006.6413506591718899129.stgit@devnote2>
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
index 86a1f07ef2ca..7757b549f0b6 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
@@ -15,6 +15,11 @@ if [ $NP -eq 1 ] ;then
   exit_unresolved
 fi
 
+if ! grep -q function available_tracers ; then
+  echo "Function trace is not enabled"
+  exit_unsupported
+fi
+
 ORIG_CPUMASK=`cat tracing_cpumask`
 
 do_reset() {

