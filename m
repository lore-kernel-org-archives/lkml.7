Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186B4C606C7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 18:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC71121852
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 18:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387770AbfGHS3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 14:29:06 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:57534 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731142AbfGHS3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 14:29:06 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 9426972CC6C;
        Mon,  8 Jul 2019 21:29:04 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 83ECE7CCE2E; Mon,  8 Jul 2019 21:29:04 +0300 (MSK)
Date:   Mon, 8 Jul 2019 21:29:04 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kbuild test robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
Subject: [PATCH] selftests/seccomp/seccomp_bpf: update for
 PTRACE_GET_SYSCALL_INFO
Message-ID: <20190708182904.GA12332@altlinux.org>
References: <20190708090627.GO17490@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708090627.GO17490@shao2-debian>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The syscall entry/exit is now exposed via PTRACE_GETEVENTMSG,
update the test accordingly.

Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index dc66fe852768..6ef7f16c4cf5 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1775,13 +1775,18 @@ void tracer_ptrace(struct __test_metadata *_metadata, pid_t tracee,
 	unsigned long msg;
 	static bool entry;
 
-	/* Make sure we got an empty message. */
+	/*
+	 * The traditional way to tell PTRACE_SYSCALL entry/exit
+	 * is by counting.
+	 */
+	entry = !entry;
+
+	/* Make sure we got an appropriate message. */
 	ret = ptrace(PTRACE_GETEVENTMSG, tracee, NULL, &msg);
 	EXPECT_EQ(0, ret);
-	EXPECT_EQ(0, msg);
+	EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
+			: PTRACE_EVENTMSG_SYSCALL_EXIT, msg);
 
-	/* The only way to tell PTRACE_SYSCALL entry/exit is by counting. */
-	entry = !entry;
 	if (!entry)
 		return;
 
-- 
ldv
