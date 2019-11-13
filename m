Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22630C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2CCE206EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfKMVDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:03:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38949 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfKMVCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:02:25 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUzmR-00068M-BN; Wed, 13 Nov 2019 22:02:23 +0100
Message-Id: <20191113210105.169922940@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 13 Nov 2019 21:42:55 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [patch V3 15/20] selftests/x86/ioperm: Extend testing so the shared
 bitmap is exercised
References: <20191113204240.767922595@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Add code to the fork path which forces the shared bitmap to be duplicated
and the reference count to be dropped. Verify that the child modifications
did not affect the parent.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
V2: New patch
---
 tools/testing/selftests/x86/ioperm.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

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




