Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF9CC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A9A2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="b+GfRiSj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfFQKcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 06:32:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38435 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfFQKcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 06:32:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HAV8TZ3369191
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 03:31:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HAV8TZ3369191
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560767469;
        bh=e0kXkJR0gIc7SXCshghIijZzrlmT1sJ/eJo84cwVjqc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=b+GfRiSjUL/GyuJ5yOFMsKXtAiTWx5NJRtFsS0HjQx013ZE3BA4lZOBgFMkX6nyNI
         O0mwhtsHbwzM5jAE7CHVt091qtNzJzosVEoCh/GOtsZCCmuNVBD+lCPSxwM79dVh5u
         6DdIH+EwraX3rrB64xcjztZjcS1kSqXfrXcTpgqurG2G+qhaupwEb6xXyj0WIwHSBp
         OrQIiIuAE+3zPbBK8NOSsR1T+OxnUJMxBB6dU5stydTDCBdk1+JosfJ42HN7GnwyF3
         JVRTqzXJ91I9YjhFYZ0wnjjCSkkXaTrHXbs7NjTAslBvaeVStrdwlJNQCOkJRdjub2
         GTyd4HkWiOj+g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HAV8tn3369188;
        Mon, 17 Jun 2019 03:31:08 -0700
Date:   Mon, 17 Jun 2019 03:31:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Christoph Hellwig <tipbot@zytor.com>
Message-ID: <tip-b78ea19ac22fd7b32d7828066cce3d8f2db5226a@git.kernel.org>
Cc:     tglx@linutronix.de, bigeasy@linutronix.de, hch@lst.de,
        mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, nstange@suse.de, dave.hansen@intel.com,
        bp@suse.de, hpa@zytor.com, riel@surriel.com
Reply-To: x86@kernel.org, mingo@redhat.com, riel@surriel.com,
          hpa@zytor.com, dave.hansen@intel.com, bp@suse.de,
          mingo@kernel.org, nstange@suse.de, linux-kernel@vger.kernel.org,
          hch@lst.de, bigeasy@linutronix.de, tglx@linutronix.de
In-Reply-To: <20190604071524.12835-2-hch@lst.de>
References: <20190604071524.12835-2-hch@lst.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/fpu: Simplify kernel_fpu_end()
Git-Commit-ID: b78ea19ac22fd7b32d7828066cce3d8f2db5226a
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

Commit-ID:  b78ea19ac22fd7b32d7828066cce3d8f2db5226a
Gitweb:     https://git.kernel.org/tip/b78ea19ac22fd7b32d7828066cce3d8f2db5226a
Author:     Christoph Hellwig <hch@lst.de>
AuthorDate: Tue, 4 Jun 2019 09:15:22 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 17 Jun 2019 10:43:43 +0200

x86/fpu: Simplify kernel_fpu_end()

Remove two little helpers and merge them into kernel_fpu_end() to
streamline the function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190604071524.12835-2-hch@lst.de
---
 arch/x86/kernel/fpu/core.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 649fbc3fcf9f..8e046068d20f 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -49,12 +49,6 @@ static void kernel_fpu_disable(void)
 	this_cpu_write(in_kernel_fpu, true);
 }
 
-static void kernel_fpu_enable(void)
-{
-	WARN_ON_FPU(!this_cpu_read(in_kernel_fpu));
-	this_cpu_write(in_kernel_fpu, false);
-}
-
 static bool kernel_fpu_disabled(void)
 {
 	return this_cpu_read(in_kernel_fpu);
@@ -115,11 +109,6 @@ static void __kernel_fpu_begin(void)
 	__cpu_invalidate_fpregs_state();
 }
 
-static void __kernel_fpu_end(void)
-{
-	kernel_fpu_enable();
-}
-
 void kernel_fpu_begin(void)
 {
 	preempt_disable();
@@ -129,7 +118,9 @@ EXPORT_SYMBOL_GPL(kernel_fpu_begin);
 
 void kernel_fpu_end(void)
 {
-	__kernel_fpu_end();
+	WARN_ON_FPU(!this_cpu_read(in_kernel_fpu));
+
+	this_cpu_write(in_kernel_fpu, false);
 	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(kernel_fpu_end);
