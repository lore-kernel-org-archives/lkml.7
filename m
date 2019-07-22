Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEFEC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763242229A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="KfNK5C7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbfGVIfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 04:35:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39717 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfGVIe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 04:34:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6M8Yri13743038
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 22 Jul 2019 01:34:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6M8Yri13743038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563784494;
        bh=2Rp/sr+UzFuRTVLYqP3WpMf662GasiewtDdWZzg+iYk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=KfNK5C7LLT+WEHmCIRIuqF4GRhvpZKt6B5wOS+DD4rhK4t2hkxMS8WaSIALiqNomE
         8YtzyY7pHmOyt/dEwFiGC5zQnGuBlcv6cr/8OMzRAYjLCBxrQx50T7HvXlUfQHhKd7
         KJaBNt+2ynd5flMHCkFRQASjYRM026pQx56XS8GFaM1UFhEicsT24ksS2AfROk5Urn
         r6AtlM8Ru0VEMexs9k/8tOlqe4xrf+EyB0JL5csN1iV5mRqNJkxiuv7g+6aTJRgVr5
         ViGpMaDQIU9eFzwQqet/EN3C5HCFxolz1/N+tNDmud4Tjx8JofeMfFeuU33EQ5mzus
         9t5sbCsl7XZaQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6M8Yr8e3743035;
        Mon, 22 Jul 2019 01:34:53 -0700
Date:   Mon, 22 Jul 2019 01:34:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-a8d03c3f300eefff3b5c14798409e4b43e37dd9b@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, luto@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: hpa@zytor.com, luto@kernel.org, linux-kernel@vger.kernel.org,
          mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <51643ac3157b5921eae0e172a8a0b1d953e68ebb.1562185330.git.luto@kernel.org>
References: <51643ac3157b5921eae0e172a8a0b1d953e68ebb.1562185330.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/entry] x86/syscalls: Use the compat versions of
 rt_sigsuspend() and rt_sigprocmask()
Git-Commit-ID: a8d03c3f300eefff3b5c14798409e4b43e37dd9b
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

Commit-ID:  a8d03c3f300eefff3b5c14798409e4b43e37dd9b
Gitweb:     https://git.kernel.org/tip/a8d03c3f300eefff3b5c14798409e4b43e37dd9b
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Wed, 3 Jul 2019 13:34:02 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 22 Jul 2019 10:31:22 +0200

x86/syscalls: Use the compat versions of rt_sigsuspend() and rt_sigprocmask()

I'm working on some code that detects at build time if there's a
COMPAT_SYSCALL_DEFINE() that is not referenced in the x86 syscall tables.
It catches three offenders: rt_sigsuspend(), rt_sigprocmask(), and
sendfile64().

For rt_sigsuspend() and rt_sigprocmask(), the only potential difference
between the native and compat versions is that the compat version converts
the sigset_t, but, on little endian architectures, the conversion is a
no-op.  This is why they both currently work on x86.

To make the code more consistent, and to make the upcoming patches work,
rewire x86 to use the compat vesions.

sendfile64() is more complicated, and will be addressed separately.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/51643ac3157b5921eae0e172a8a0b1d953e68ebb.1562185330.git.luto@kernel.org

---
 arch/x86/entry/syscalls/syscall_32.tbl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index c00019abd076..3fe02546aed3 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -186,11 +186,11 @@
 172	i386	prctl			sys_prctl			__ia32_sys_prctl
 173	i386	rt_sigreturn		sys_rt_sigreturn		sys32_rt_sigreturn
 174	i386	rt_sigaction		sys_rt_sigaction		__ia32_compat_sys_rt_sigaction
-175	i386	rt_sigprocmask		sys_rt_sigprocmask		__ia32_sys_rt_sigprocmask
+175	i386	rt_sigprocmask		sys_rt_sigprocmask		__ia32_compat_sys_rt_sigprocmask
 176	i386	rt_sigpending		sys_rt_sigpending		__ia32_compat_sys_rt_sigpending
 177	i386	rt_sigtimedwait		sys_rt_sigtimedwait_time32	__ia32_compat_sys_rt_sigtimedwait_time32
 178	i386	rt_sigqueueinfo		sys_rt_sigqueueinfo		__ia32_compat_sys_rt_sigqueueinfo
-179	i386	rt_sigsuspend		sys_rt_sigsuspend		__ia32_sys_rt_sigsuspend
+179	i386	rt_sigsuspend		sys_rt_sigsuspend		__ia32_compat_sys_rt_sigsuspend
 180	i386	pread64			sys_pread64			__ia32_compat_sys_x86_pread
 181	i386	pwrite64		sys_pwrite64			__ia32_compat_sys_x86_pwrite
 182	i386	chown			sys_chown16			__ia32_sys_chown16
