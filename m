Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FDDC5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 06:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F354F206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 06:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="N9ZBzTlq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfGBGt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 02:49:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52667 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfGBGt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 02:49:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x626njBH2680303
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 1 Jul 2019 23:49:45 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x626njBH2680303
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562050186;
        bh=70HKby+9x+b9astIMUJmnz4LELiPsGhC6DGfic4pAgc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=N9ZBzTlqMGIAgnmvTRrT6S/y4EomFS7qfLmCJsjCeBLv+UwTxQrUiYTu3ff25kR6E
         dAxHyp867L7zCUQjnBlIVabmgdwDdxI3c2oroOvyuNZP5Rxko8R7bc/ACo1JqjGrjz
         8rhnSYh+F3iYO10VoyzJxxWWSm1jQ4vYXqE6i0rAt81N7gclnA7L8I9KR1cWx1WQ2Y
         N2vZ8d8FTQPXCGIAS83WJnFHGpEiYBzutHWo1nJhysHaiB3JupSj2WDX/NgyRlZ4sz
         29i8j0sBkLDSf2D61/rkMa03RdjJffzidKhT5WSwVomjhsylXNX4/FaN060Tkn7gdf
         /Yo3qNSZIbEhw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x626njHo2680300;
        Mon, 1 Jul 2019 23:49:45 -0700
Date:   Mon, 1 Jul 2019 23:49:45 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-dffb3f9db6b593f3ed6ab4c8d8f10e0aa6aa7a88@git.kernel.org>
Cc:     peterz@infradead.org, mingo@kernel.org, bp@alien8.de,
        linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, chang.seok.bae@intel.com
Reply-To: peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de,
          chang.seok.bae@intel.com, hpa@zytor.com, bp@alien8.de,
          linux-kernel@vger.kernel.org, luto@kernel.org
In-Reply-To: <0f7dafa72fe7194689de5ee8cfe5d83509fabcf5.1562035429.git.luto@kernel.org>
References: <0f7dafa72fe7194689de5ee8cfe5d83509fabcf5.1562035429.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/entry/64: Don't compile ignore_sysret if 32-bit
 emulation is enabled
Git-Commit-ID: dffb3f9db6b593f3ed6ab4c8d8f10e0aa6aa7a88
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

Commit-ID:  dffb3f9db6b593f3ed6ab4c8d8f10e0aa6aa7a88
Gitweb:     https://git.kernel.org/tip/dffb3f9db6b593f3ed6ab4c8d8f10e0aa6aa7a88
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Mon, 1 Jul 2019 20:43:20 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 2 Jul 2019 08:45:20 +0200

x86/entry/64: Don't compile ignore_sysret if 32-bit emulation is enabled

It's only used if !CONFIG_IA32_EMULATION, so disable it in normal
configs.  This will save a few bytes of text and reduce confusion.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc:  "BaeChang Seok" <chang.seok.bae@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Bae, Chang Seok" <chang.seok.bae@intel.com>
Link: https://lkml.kernel.org/r/0f7dafa72fe7194689de5ee8cfe5d83509fabcf5.1562035429.git.luto@kernel.org

---
 arch/x86/entry/entry_64.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 7f9f5119d6b1..54b1b0468b2b 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1743,11 +1743,17 @@ nmi_restore:
 	iretq
 END(nmi)
 
+#ifndef CONFIG_IA32_EMULATION
+/*
+ * This handles SYSCALL from 32-bit code.  There is no way to program
+ * MSRs to fully disable 32-bit SYSCALL.
+ */
 ENTRY(ignore_sysret)
 	UNWIND_HINT_EMPTY
 	mov	$-ENOSYS, %eax
 	sysret
 END(ignore_sysret)
+#endif
 
 ENTRY(rewind_stack_do_exit)
 	UNWIND_HINT_FUNC
