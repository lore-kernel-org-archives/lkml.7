Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7374C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8336D24672
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781323;
	bh=g2ZdvR/qygmJ0fYfpEQW2Fu3sNskEi0SO6ZDcp7X/4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VHNZGeCPZp4H9KFureEgcg3zoB9/X8YIXTkYM+H2cZ0dX0+6LaDWgThnaMSJp8mfU
	 bL84lVz6POk63l9+WIX5hMaiQB0KPkf906SZUoMzDaTTomSF+Cby8JJ4lVjXXNq8Ke
	 13PR4HTxECGZD7cH9vQxpmd3xnfhr7Adsr+q+z6I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbfLSSsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:48:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:41780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728924AbfLSSsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:48:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FED724679;
        Thu, 19 Dec 2019 18:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781318;
        bh=g2ZdvR/qygmJ0fYfpEQW2Fu3sNskEi0SO6ZDcp7X/4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EAkK8N6XwWFXA1kpTjZ/0tOPb4GZKDxrJHo/mcZ718dgDB2L6nDWgalh2Cvbv4t+m
         QfIstfX36xxu3XnlCVPzyZMfffz4wGen6IH2yoHtw1UOoc4SFp4eBGIMeme2/X1xT5
         Q6og5at1BizpAsagP+vrz+ag8EEHE/rY/h15i+d4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 165/199] powerpc: Fix vDSO clock_getres()
Date:   Thu, 19 Dec 2019 19:34:07 +0100
Message-Id: <20191219183224.574785625@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183214.629503389@linuxfoundation.org>
References: <20191219183214.629503389@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

[ Upstream commit 552263456215ada7ee8700ce022d12b0cffe4802 ]

clock_getres in the vDSO library has to preserve the same behaviour
of posix_get_hrtimer_res().

In particular, posix_get_hrtimer_res() does:
    sec = 0;
    ns = hrtimer_resolution;
and hrtimer_resolution depends on the enablement of the high
resolution timers that can happen either at compile or at run time.

Fix the powerpc vdso implementation of clock_getres keeping a copy of
hrtimer_resolution in vdso data and using that directly.

Fixes: a7f290dad32e ("[PATCH] powerpc: Merge vdso's and add vdso support to 32 bits kernel")
Cc: stable@vger.kernel.org
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
[chleroy: changed CLOCK_REALTIME_RES to CLOCK_HRTIMER_RES]
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/a55eca3a5e85233838c2349783bcb5164dae1d09.1575273217.git.christophe.leroy@c-s.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/vdso_datapage.h  |    2 ++
 arch/powerpc/kernel/asm-offsets.c         |    2 +-
 arch/powerpc/kernel/time.c                |    1 +
 arch/powerpc/kernel/vdso32/gettimeofday.S |    7 +++++--
 arch/powerpc/kernel/vdso64/gettimeofday.S |    7 +++++--
 5 files changed, 14 insertions(+), 5 deletions(-)

--- a/arch/powerpc/include/asm/vdso_datapage.h
+++ b/arch/powerpc/include/asm/vdso_datapage.h
@@ -86,6 +86,7 @@ struct vdso_data {
 	__s32 wtom_clock_nsec;
 	struct timespec stamp_xtime;	/* xtime as at tb_orig_stamp */
 	__u32 stamp_sec_fraction;	/* fractional seconds of stamp_xtime */
+	__u32 hrtimer_res;			/* hrtimer resolution */
    	__u32 syscall_map_64[SYSCALL_MAP_SIZE]; /* map of syscalls  */
    	__u32 syscall_map_32[SYSCALL_MAP_SIZE]; /* map of syscalls */
 };
@@ -107,6 +108,7 @@ struct vdso_data {
 	__s32 wtom_clock_nsec;
 	struct timespec stamp_xtime;	/* xtime as at tb_orig_stamp */
 	__u32 stamp_sec_fraction;	/* fractional seconds of stamp_xtime */
+	__u32 hrtimer_res;		/* hrtimer resolution */
    	__u32 syscall_map_32[SYSCALL_MAP_SIZE]; /* map of syscalls */
 	__u32 dcache_block_size;	/* L1 d-cache block size     */
 	__u32 icache_block_size;	/* L1 i-cache block size     */
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -383,6 +383,7 @@ int main(void)
 	DEFINE(WTOM_CLOCK_NSEC, offsetof(struct vdso_data, wtom_clock_nsec));
 	DEFINE(STAMP_XTIME, offsetof(struct vdso_data, stamp_xtime));
 	DEFINE(STAMP_SEC_FRAC, offsetof(struct vdso_data, stamp_sec_fraction));
+	DEFINE(CLOCK_HRTIMER_RES, offsetof(struct vdso_data, hrtimer_res));
 	DEFINE(CFG_ICACHE_BLOCKSZ, offsetof(struct vdso_data, icache_block_size));
 	DEFINE(CFG_DCACHE_BLOCKSZ, offsetof(struct vdso_data, dcache_block_size));
 	DEFINE(CFG_ICACHE_LOGBLOCKSZ, offsetof(struct vdso_data, icache_log_block_size));
@@ -411,7 +412,6 @@ int main(void)
 	DEFINE(CLOCK_REALTIME, CLOCK_REALTIME);
 	DEFINE(CLOCK_MONOTONIC, CLOCK_MONOTONIC);
 	DEFINE(NSEC_PER_SEC, NSEC_PER_SEC);
-	DEFINE(CLOCK_REALTIME_RES, MONOTONIC_RES_NSEC);
 
 #ifdef CONFIG_BUG
 	DEFINE(BUG_ENTRY_SIZE, sizeof(struct bug_entry));
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -862,6 +862,7 @@ void update_vsyscall_old(struct timespec
 	vdso_data->wtom_clock_nsec = wtm->tv_nsec;
 	vdso_data->stamp_xtime = *wall_time;
 	vdso_data->stamp_sec_fraction = frac_sec;
+	vdso_data->hrtimer_res = hrtimer_resolution;
 	smp_wmb();
 	++(vdso_data->tb_update_count);
 }
--- a/arch/powerpc/kernel/vdso32/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
@@ -160,12 +160,15 @@ V_FUNCTION_BEGIN(__kernel_clock_getres)
 	cror	cr0*4+eq,cr0*4+eq,cr1*4+eq
 	bne	cr0,99f
 
+	mflr	r12
+  .cfi_register lr,r12
+	bl	__get_datapage@local	/* get data page */
+	lwz	r5, CLOCK_HRTIMER_RES(r3)
+	mtlr	r12
 	li	r3,0
 	cmpli	cr0,r4,0
 	crclr	cr0*4+so
 	beqlr
-	lis	r5,CLOCK_REALTIME_RES@h
-	ori	r5,r5,CLOCK_REALTIME_RES@l
 	stw	r3,TSPC32_TV_SEC(r4)
 	stw	r5,TSPC32_TV_NSEC(r4)
 	blr
--- a/arch/powerpc/kernel/vdso64/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso64/gettimeofday.S
@@ -145,12 +145,15 @@ V_FUNCTION_BEGIN(__kernel_clock_getres)
 	cror	cr0*4+eq,cr0*4+eq,cr1*4+eq
 	bne	cr0,99f
 
+	mflr	r12
+  .cfi_register lr,r12
+	bl	V_LOCAL_FUNC(__get_datapage)
+	lwz	r5, CLOCK_HRTIMER_RES(r3)
+	mtlr	r12
 	li	r3,0
 	cmpldi	cr0,r4,0
 	crclr	cr0*4+so
 	beqlr
-	lis	r5,CLOCK_REALTIME_RES@h
-	ori	r5,r5,CLOCK_REALTIME_RES@l
 	std	r3,TSPC64_TV_SEC(r4)
 	std	r5,TSPC64_TV_NSEC(r4)
 	blr


