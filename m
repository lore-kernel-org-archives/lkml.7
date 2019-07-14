Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9AEC73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 12:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C592720820
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 12:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbfGNMCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 08:02:08 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:51676 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728259AbfGNMCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 08:02:08 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 69FDE72CA65;
        Sun, 14 Jul 2019 15:02:06 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 5C4D37CCE3A; Sun, 14 Jul 2019 15:02:06 +0300 (MSK)
Date:   Sun, 14 Jul 2019 15:02:06 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     Anatoly Pugachev <matorola@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] clone: fix CLONE_PIDFD support
Message-ID: <20190714120206.GC6773@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The introduction of clone3 syscall accidentally broke CLONE_PIDFD
support in traditional clone syscall on compat x86 and those
architectures that use do_fork to implement clone syscall.

This bug was found by strace test suite.

Link: https://strace.io/logs/strace/2019-07-12
Fixes: 7f192e3cd316 ("fork: add clone3")
Bisected-and-tested-by: Anatoly Pugachev <matorola@gmail.com>
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 arch/x86/ia32/sys_ia32.c | 1 +
 kernel/fork.c            | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/ia32/sys_ia32.c b/arch/x86/ia32/sys_ia32.c
index 64a6c952091e..98754baf411a 100644
--- a/arch/x86/ia32/sys_ia32.c
+++ b/arch/x86/ia32/sys_ia32.c
@@ -239,6 +239,7 @@ COMPAT_SYSCALL_DEFINE5(x86_clone, unsigned long, clone_flags,
 {
 	struct kernel_clone_args args = {
 		.flags		= (clone_flags & ~CSIGNAL),
+		.pidfd		= parent_tidptr,
 		.child_tid	= child_tidptr,
 		.parent_tid	= parent_tidptr,
 		.exit_signal	= (clone_flags & CSIGNAL),
diff --git a/kernel/fork.c b/kernel/fork.c
index 8f3e2d97d771..2c3cbad807b6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2417,6 +2417,7 @@ long do_fork(unsigned long clone_flags,
 {
 	struct kernel_clone_args args = {
 		.flags		= (clone_flags & ~CSIGNAL),
+		.pidfd		= parent_tidptr,
 		.child_tid	= child_tidptr,
 		.parent_tid	= parent_tidptr,
 		.exit_signal	= (clone_flags & CSIGNAL),
-- 
ldv
