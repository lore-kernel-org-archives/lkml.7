Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D957FC282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D3720645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Q0nrulOV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbfDSTFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:05:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42949 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729127AbfDSTDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:03:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JFqmEg332720
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 08:52:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JFqmEg332720
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555689169;
        bh=OBCV4fhJep5HJwfWaXhzEpUR75KqJZcqBp+PkEvsCX8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Q0nrulOV/glJTRVXfz6BtH0v5GTosfjYNal/hDq9CX1EkuYgttF4Q87kcOp/au7DE
         xqocRfUCHnlTeaoNNMBDrbPErCNO7L2hMf/Tqb+e9fvQK9Ps+4XRQSEl1kIsgFQ0nL
         ox4nv+NS3hHSKOHAr2Sh48jGYJ4Be062j8KwLjrRpM8Ci/snml/Nq74rghsjzTajUL
         otoUTdF9X12Rks+Cb/O1FtyGZXbEdb5s4mb9mwCA+S1qzSC6xmp165mUnyWZDjZlOQ
         jZ6N9DvKvUaIdvwVSGyzRBddPaLQWNZ+TowNDNtMJZFO5QmjwXVJkKZKoP1od9qMSz
         ydiDxfbAU+myg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JFqlb5332717;
        Fri, 19 Apr 2019 08:52:47 -0700
Date:   Fri, 19 Apr 2019 08:52:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-26b31f46f036ad89de20cbbb732b76289411eddb@git.kernel.org>
Cc:     tglx@linutronix.de, ak@linux.intel.com, mingo@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, mingo@kernel.org, ak@linux.intel.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <20190330004743.29541-2-andi@firstfloor.org>
References: <20190330004743.29541-2-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/cpu/amd: Exclude 32bit only assembler from 64bit
 build
Git-Commit-ID: 26b31f46f036ad89de20cbbb732b76289411eddb
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

Commit-ID:  26b31f46f036ad89de20cbbb732b76289411eddb
Gitweb:     https://git.kernel.org/tip/26b31f46f036ad89de20cbbb732b76289411eddb
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Fri, 29 Mar 2019 17:47:36 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 19 Apr 2019 17:47:35 +0200

x86/cpu/amd: Exclude 32bit only assembler from 64bit build

The "vide" inline assembler is only needed on 32bit kernels for old
32bit only CPUs.

Guard it with an #ifdef so it's not included in 64bit builds.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190330004743.29541-2-andi@firstfloor.org
---
 arch/x86/kernel/cpu/amd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 1bcb489e07e7..fb6a64bd765f 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -82,12 +82,14 @@ static inline int wrmsrl_amd_safe(unsigned msr, unsigned long long val)
  *	performance at the same time..
  */
 
+#ifdef CONFIG_X86_32
 extern __visible void vide(void);
 __asm__(".text\n"
 	".globl vide\n"
 	".type vide, @function\n"
 	".align 4\n"
 	"vide: ret\n");
+#endif
 
 static void init_amd_k5(struct cpuinfo_x86 *c)
 {
