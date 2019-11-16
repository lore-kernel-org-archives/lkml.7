Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059F7C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 11:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3C82068D
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 11:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfKPLwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 06:52:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45263 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbfKPLva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 06:51:30 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVwbw-00026x-58; Sat, 16 Nov 2019 12:51:28 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B4CF61C0089;
        Sat, 16 Nov 2019 12:51:22 +0100 (CET)
Date:   Sat, 16 Nov 2019 11:51:22 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/iopl] selftests/x86/ioperm: Extend testing so the shared
 bitmap is exercised
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157390508270.12247.14220890977150047609.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/iopl branch of tip:

Commit-ID:     0907a09c2e52210a67a9616427ea71f14b37e826
Gitweb:        https://git.kernel.org/tip/0907a09c2e52210a67a9616427ea71f14b37e826
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 11 Nov 2019 23:03:26 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 16 Nov 2019 11:24:04 +01:00

selftests/x86/ioperm: Extend testing so the shared bitmap is exercised

Add code to the fork path which forces the shared bitmap to be duplicated
and the reference count to be dropped. Verify that the child modifications
did not affect the parent.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 tools/testing/selftests/x86/ioperm.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/ioperm.c b/tools/testing/selftests/x86/ioperm.c
index 01de41c..57ec5e9 100644
--- a/tools/testing/selftests/x86/ioperm.c
+++ b/tools/testing/selftests/x86/ioperm.c
@@ -131,6 +131,17 @@ int main(void)
 		printf("[RUN]\tchild: check that we inherited permissions\n");
 		expect_ok(0x80);
 		expect_gp(0xed);
+		printf("[RUN]\tchild: Extend permissions to 0x81\n");
+		if (ioperm(0x81, 1, 1) != 0) {
+			printf("[FAIL]\tioperm(0x81, 1, 1) failed (%d)", errno);
+			return 1;
+		}
+		printf("[RUN]\tchild: Drop permissions to 0x80\n");
+		if (ioperm(0x80, 1, 0) != 0) {
+			printf("[FAIL]\tioperm(0x80, 1, 0) failed (%d)", errno);
+			return 1;
+		}
+		expect_gp(0x80);
 		return 0;
 	} else {
 		int status;
@@ -146,8 +157,11 @@ int main(void)
 		}
 	}
 
-	/* Test the capability checks. */
+	/* Verify that the child dropping 0x80 did not affect the parent */
+	printf("\tVerify that unsharing the bitmap worked\n");
+	expect_ok(0x80);
 
+	/* Test the capability checks. */
 	printf("\tDrop privileges\n");
 	if (setresuid(1, 1, 1) != 0) {
 		printf("[WARN]\tDropping privileges failed\n");
