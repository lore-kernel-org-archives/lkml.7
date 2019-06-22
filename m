Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81396C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5125B206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="DFALrcBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfFVKN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 06:13:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49669 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfFVKN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 06:13:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5MADK972097959
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 22 Jun 2019 03:13:20 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5MADK972097959
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561198400;
        bh=RzdNB5kyxjyHy1NKN8iaDyUy1VHJEC9k9ScsNc4KmIQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=DFALrcBr1ORluVLHbMZEqo9BASNcCfK+0d1uRuE45o5B9ZR6CoQMSjKjoWzfRiVN3
         RaLY9EcTAdbEcMXdqSew5JOa4h+iQQhNm8XCL1a2HsL8BLQ5QHV7/IMy7180ddWM7L
         r9ZFtxCiSeH9dqtI3Iin9bITvgIJiuWRM8E/+S2Dp8lwpAzLrWc+1fWNVGSS6G+/oT
         HA1y8MyStH/DbJP1aUvi2UpMNLP9oeXiaZCiX6BywnLRP0Wdkxep26sm9P3wqKub1i
         mem7x/LsyKsnFuMoGs02zWMQ4/rXlvouBDhwaNM64+3JUK4N4XEWc0VJE7vNYivSJ5
         q3fKMo2+1iVhA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5MADJiL2097956;
        Sat, 22 Jun 2019 03:13:19 -0700
Date:   Sat, 22 Jun 2019 03:13:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Chang S. Bae" <tipbot@zytor.com>
Message-ID: <tip-a87730cc3acc475eff12ddde3f7d5687371b5c76@git.kernel.org>
Cc:     ak@linux.intel.com, ravi.v.shankar@intel.com,
        linux-kernel@vger.kernel.org, chang.seok.bae@intel.com,
        luto@kernel.org, mingo@kernel.org, tglx@linutronix.de,
        hpa@zytor.com
Reply-To: mingo@kernel.org, chang.seok.bae@intel.com, luto@kernel.org,
          ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
          ak@linux.intel.com, tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <1557309753-24073-16-git-send-email-chang.seok.bae@intel.com>
References: <1557309753-24073-16-git-send-email-chang.seok.bae@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] selftests/x86/fsgsbase: Test ptracer-induced GSBASE
 write with FSGSBASE
Git-Commit-ID: a87730cc3acc475eff12ddde3f7d5687371b5c76
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

Commit-ID:  a87730cc3acc475eff12ddde3f7d5687371b5c76
Gitweb:     https://git.kernel.org/tip/a87730cc3acc475eff12ddde3f7d5687371b5c76
Author:     Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate: Wed, 8 May 2019 03:02:30 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 11:38:56 +0200

selftests/x86/fsgsbase: Test ptracer-induced GSBASE write with FSGSBASE

This validates that GS and GSBASE are independently preserved in
ptracer commands.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Link: https://lkml.kernel.org/r/1557309753-24073-16-git-send-email-chang.seok.bae@intel.com

---
 tools/testing/selftests/x86/fsgsbase.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
index afd029897c79..21fd4f94b5b0 100644
--- a/tools/testing/selftests/x86/fsgsbase.c
+++ b/tools/testing/selftests/x86/fsgsbase.c
@@ -470,7 +470,7 @@ static void test_ptrace_write_gsbase(void)
 	wait(&status);
 
 	if (WSTOPSIG(status) == SIGTRAP) {
-		unsigned long gs;
+		unsigned long gs, base;
 		unsigned long gs_offset = USER_REGS_OFFSET(gs);
 		unsigned long base_offset = USER_REGS_OFFSET(gs_base);
 
@@ -486,6 +486,7 @@ static void test_ptrace_write_gsbase(void)
 			err(1, "PTRACE_POKEUSER");
 
 		gs = ptrace(PTRACE_PEEKUSER, child, gs_offset, NULL);
+		base = ptrace(PTRACE_PEEKUSER, child, base_offset, NULL);
 
 		/*
 		 * In a non-FSGSBASE system, the nonzero selector will load
@@ -496,8 +497,14 @@ static void test_ptrace_write_gsbase(void)
 		if (gs != 0x7) {
 			nerrs++;
 			printf("[FAIL]\tGS changed to %lx\n", gs);
+		} else if (have_fsgsbase && (base != 0xFF)) {
+			nerrs++;
+			printf("[FAIL]\tGSBASE changed to %lx\n", base);
 		} else {
-			printf("[OK]\tGS remained 0x7\n");
+			printf("[OK]\tGS remained 0x7 %s");
+			if (have_fsgsbase)
+				printf("and GSBASE changed to 0xFF");
+			printf("\n");
 		}
 	}
 
