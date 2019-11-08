Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9ADCFC6196
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76D7215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733262AbfKHVfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 16:35:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:34906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732944AbfKHVew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:34:52 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4FA3222C4;
        Fri,  8 Nov 2019 21:34:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iTBu6-0007z1-S9; Fri, 08 Nov 2019 16:34:50 -0500
Message-Id: <20191108213450.748178236@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 08 Nov 2019 16:28:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 08/10] ftrace/selftests: Update the direct call selftests to test two direct
 calls
References: <20191108212834.594904349@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The register_ftrace_direct() takes a different path if there's already a
direct call registered, but this was not tested in the self tests. Now that
there's a second direct caller test module, we can use this to test not only
one direct caller, but two.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../ftrace/test.d/direct/ftrace-direct.tc     | 16 +++++
 .../ftrace/test.d/direct/kprobe-direct.tc     | 59 +++++++++++--------
 2 files changed, 52 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc b/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
index 8b8ed3cad51b..cbc7a30c2e0f 100644
--- a/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
+++ b/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
@@ -51,3 +51,19 @@ done
 
 echo nop > current_tracer
 rmmod ftrace-direct ||:
+
+# Now do the same thing with another direct function registered
+echo "Running with another ftrace direct function"
+
+rmmod ftrace-direct-too ||:
+modprobe ftrace-direct-too
+
+for t in `cat available_tracers`; do
+	if [ "$t" != "nop" ]; then
+		test_tracer $t
+	fi
+done
+
+echo nop > current_tracer
+rmmod ftrace-direct ||:
+rmmod ftrace-direct-too ||:
diff --git a/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc b/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
index 1561106765e4..d901416cb014 100644
--- a/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
+++ b/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
@@ -44,28 +44,41 @@ disable_probe() {
 	echo 0 > events/kprobes/kwake/enable
 }
 
-# probe -> direct -> no direct > no probe
-enable_probe
-start_direct
-stop_direct
-disable_probe
-
-# probe -> direct -> no probe > no direct
-enable_probe
-start_direct
-disable_probe
-stop_direct
-
-# direct -> probe -> no probe > no direct
-start_direct
-enable_probe
-disable_probe
-stop_direct
-
-# direct -> probe -> no direct > no noprobe
-start_direct
-enable_probe
-stop_direct
-disable_probe
+test_kprobes() {
+	# probe -> direct -> no direct > no probe
+	enable_probe
+	start_direct
+	stop_direct
+	disable_probe
+
+	# probe -> direct -> no probe > no direct
+	enable_probe
+	start_direct
+	disable_probe
+	stop_direct
+
+	# direct -> probe -> no probe > no direct
+	start_direct
+	enable_probe
+	disable_probe
+	stop_direct
+
+	# direct -> probe -> no direct > no noprobe
+	start_direct
+	enable_probe
+	stop_direct
+	disable_probe
+}
+
+test_kprobes
+
+# Now do this with a second registered direct function
+echo "Running with another ftrace direct function"
+
+modprobe ftrace-direct-too
+
+test_kprobes
+
+rmmod ftrace-direct-too
 
 echo > kprobe_events
-- 
2.23.0


