Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D43C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 417F12171F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552356275;
	bh=OVt5cs6TCmQOcdU5mAm7H7fnww+ZY6CUnPwC6Nkv64s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TvOLPQqo6IfbxMTh5I1c/+cboRTLPxuHbe0he6qQ7F5IRK69j9DXeE0LQKsoaEnkf
	 WmWxynfaBDWI0B2NO7d31n9aPTYSC+bLzgHQzzkMeidKIzrxAKYHIxrZP5/AbZ2YF+
	 vgzzfuZ4v5mCQJ3nRAz4GJHgORWBYUadhwz9Rjsc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfCLCDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 22:03:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:37374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbfCLCD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 22:03:29 -0400
Received: from quaco.meukeo.local (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9ED0621773;
        Tue, 12 Mar 2019 02:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552356209;
        bh=OVt5cs6TCmQOcdU5mAm7H7fnww+ZY6CUnPwC6Nkv64s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vIhIHIGSO7O2YzAw8k3JuaRZ9UKWJ9/Lu0DJPm/GqOgo5uggvYPX2pCFsn8rMwgH0
         cw1lGMrKejsAogOAMWtTfXD1agVPR1kpQUW91lUd3yzsCkRn0mNZwV3ntQORG5R268
         DOJNoLCcvzXezu+vtG8QyvZa8Jo95/fAi6y7izdc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 19/30] perf tools: Update x86's syscall_64.tbl, no change in tools/perf behaviour
Date:   Mon, 11 Mar 2019 23:01:53 -0300
Message-Id: <20190312020204.22092-20-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312020204.22092-1-acme@kernel.org>
References: <20190312020204.22092-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick the changes in 7948450d4556 ("x86/x32: use time64 versions of
sigtimedwait and recvmmsg"), that doesn't cause any change in behaviour
in tools/perf/ as it deals just with the x32 entries.

This silences this tools/perf build warning:

  Warning: Kernel ABI header at 'tools/perf/arch/x86/entry/syscalls/syscall_64.tbl' differs from latest version at 'arch/x86/entry/syscalls/syscall_64.tbl'
  diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-mqpvshayeqidlulx5qpioa59@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index f0b1709a5ffb..2ae92fddb6d5 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -343,6 +343,8 @@
 332	common	statx			__x64_sys_statx
 333	common	io_pgetevents		__x64_sys_io_pgetevents
 334	common	rseq			__x64_sys_rseq
+# don't use numbers 387 through 423, add new calls after the last
+# 'common' entry
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
@@ -361,7 +363,7 @@
 520	x32	execve			__x32_compat_sys_execve/ptregs
 521	x32	ptrace			__x32_compat_sys_ptrace
 522	x32	rt_sigpending		__x32_compat_sys_rt_sigpending
-523	x32	rt_sigtimedwait		__x32_compat_sys_rt_sigtimedwait
+523	x32	rt_sigtimedwait		__x32_compat_sys_rt_sigtimedwait_time64
 524	x32	rt_sigqueueinfo		__x32_compat_sys_rt_sigqueueinfo
 525	x32	sigaltstack		__x32_compat_sys_sigaltstack
 526	x32	timer_create		__x32_compat_sys_timer_create
@@ -375,7 +377,7 @@
 534	x32	preadv			__x32_compat_sys_preadv64
 535	x32	pwritev			__x32_compat_sys_pwritev64
 536	x32	rt_tgsigqueueinfo	__x32_compat_sys_rt_tgsigqueueinfo
-537	x32	recvmmsg		__x32_compat_sys_recvmmsg
+537	x32	recvmmsg		__x32_compat_sys_recvmmsg_time64
 538	x32	sendmmsg		__x32_compat_sys_sendmmsg
 539	x32	process_vm_readv	__x32_compat_sys_process_vm_readv
 540	x32	process_vm_writev	__x32_compat_sys_process_vm_writev
-- 
2.20.1

