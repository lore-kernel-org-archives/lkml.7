Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB0DC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 527212229A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="pWOvxvAm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfGVIeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 04:34:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37635 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfGVIeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 04:34:13 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6M8Y8rZ3742976
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 22 Jul 2019 01:34:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6M8Y8rZ3742976
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563784448;
        bh=KbzzX5h3u5o9PV7iqxA9vUHWds11MMe9PsH2cmEW01g=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=pWOvxvAmzaNJrIJRzvSf1pPfFcqArInjqv4EDoLbR1dDBsXI+XX+8RoT60/jQ1fM+
         bJqaqH+A2BTfW7AGUtcP5pPy3V9CtzFZOQsJcago3cfxUAQ8H6IMtxqMPcikfjVk5S
         C8r2WWtYZZn3iIvcEYLmZpDH4wxM3sGgvAEjEKjHV3CurcmlJoxqOSFWBAf4SlkPiL
         m8GT2QRG4utZNC4lup6BhRQVuC1/0CqUdo9B5jffcg+EmQDko70BkzrBJxCbaaJ5g4
         aPQvv89WedCoN1CQ17+JoFf36fldCm7yvoZsUuB+A1evYg+Jk4qE2/vpdDhDGa9Eg3
         OuhGQ5vyN2G8A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6M8Y7EP3742973;
        Mon, 22 Jul 2019 01:34:07 -0700
Date:   Mon, 22 Jul 2019 01:34:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-45e29d119e9923ff14dfb840e3482bef1667bbfb@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, luto@kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
          luto@kernel.org, mingo@kernel.org
In-Reply-To: <99b0d83ad891c67105470a1a6b63243fd63a5061.1562185330.git.luto@kernel.org>
References: <99b0d83ad891c67105470a1a6b63243fd63a5061.1562185330.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/entry] x86/syscalls: Make __X32_SYSCALL_BIT be unsigned
 long
Git-Commit-ID: 45e29d119e9923ff14dfb840e3482bef1667bbfb
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

Commit-ID:  45e29d119e9923ff14dfb840e3482bef1667bbfb
Gitweb:     https://git.kernel.org/tip/45e29d119e9923ff14dfb840e3482bef1667bbfb
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Wed, 3 Jul 2019 13:34:05 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 22 Jul 2019 10:31:22 +0200

x86/syscalls: Make __X32_SYSCALL_BIT be unsigned long

Currently, it's an int.  This is bizarre.  Fortunately, the code using it
still works: ~__X32_SYSCALL_BIT is also int, so, if nr is unsigned long,
then C kindly sign-extends the ~__X32_SYSCALL_BIT part, and it actually
results in the desired value.

This is far more subtle than it deserves to be.  Syscall numbers are, for
all practical purposes, unsigned long, so make __X32_SYSCALL_BIT be
unsigned long.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/99b0d83ad891c67105470a1a6b63243fd63a5061.1562185330.git.luto@kernel.org

---
 arch/x86/include/uapi/asm/unistd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/unistd.h b/arch/x86/include/uapi/asm/unistd.h
index 30d7d04d72d6..196fdd02b8b1 100644
--- a/arch/x86/include/uapi/asm/unistd.h
+++ b/arch/x86/include/uapi/asm/unistd.h
@@ -3,7 +3,7 @@
 #define _UAPI_ASM_X86_UNISTD_H
 
 /* x32 syscall flag bit */
-#define __X32_SYSCALL_BIT	0x40000000
+#define __X32_SYSCALL_BIT	0x40000000UL
 
 #ifndef __KERNEL__
 # ifdef __i386__
