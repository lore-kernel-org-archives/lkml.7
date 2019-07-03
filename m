Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCD1C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A792218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562186065;
	bh=Syx8RsgjST+l3fqOTS3aX5LDnIDUEzopFPEzyXrQvN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fi+McT6caW2jVQIT/CwQka7qHqbA0qbbT2VruOeIP4s6g5b2UbbhNItmG5CxvkWpW
	 dDcqefwtElowP4h3OCr6EZzd6txhC8/DgVFf6XwFfNJCf0Qdx51rrML872xS/oxnfW
	 LGy7/vMPBPjiMkadKsyCDdOYcwCTxZBRq2OyRoZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfGCUeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 16:34:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbfGCUeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 16:34:09 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D163218A3;
        Wed,  3 Jul 2019 20:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562186048;
        bh=Syx8RsgjST+l3fqOTS3aX5LDnIDUEzopFPEzyXrQvN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HTsWEbBC6Yx7DcE0Java24HEUFQZHQ4+Je62UEgtUVC0gM3wfS8jVPEDve+jpR5Co
         0iln5MWitEdFoX9P/wpf7FgipAoahUj4XmdHYEhT/7ApYRlwOprUvl0Hp28Dx5jIFf
         viEF0DIt6Yg37hjSIKL25OzjWhOeSU+w+dwtONDw=
From:   Andy Lutomirski <luto@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 1/4] x86/syscalls: Use the compat versions of rt_sigsuspend() and rt_sigprocmask()
Date:   Wed,  3 Jul 2019 13:34:02 -0700
Message-Id: <51643ac3157b5921eae0e172a8a0b1d953e68ebb.1562185330.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1562185330.git.luto@kernel.org>
References: <cover.1562185330.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on some code that detects at build time if there's a
COMPAT_SYSCALL_DEFINE() that is not referenced in the x86 syscall
tables.  It catches three offenders: rt_sigsuspend(),
rt_sigprocmask(), and sendfile64().

For rt_sigsuspend() and rt_sigprocmask(), the only potential
difference between the native and compat versions is that the compat
version converts the sigset_t, but, on little endian architectures,
the conversion is a no-op.  This is why they both currently work on
x86.

To make the code more consistent, and to make my upcoming patches
work, this patch rewires x86 to use the compat vesions.

sendfile64() is more complicated, and I'll address it separately.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/syscalls/syscall_32.tbl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index ad968b7bac72..8e82e0270b24 100644
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
-- 
2.21.0

