Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2006EC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED56E2513D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559189424;
	bh=fftdQk/7amfLgc7ki+wpqJ+JdSTVNsCzjgwyklgGKRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OJiDIlFnw9vthSIg9G3mPu2eBn3hd3dB9sPh5p2XMo4CLjr1VlBCHNbAQh5Qa+3y2
	 9dlSqPLLH45DD9d2rRfzr/TzMC4uYf2wbwWZP1ks1p+bpdNu9Dj9HweR8FeE8s/Wzl
	 rzSZfBysCYa/vD+VjaUj/K3XEOpmLyTs+G4N33ac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfE3EKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:10:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730888AbfE3DRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:17:01 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B887924656;
        Thu, 30 May 2019 03:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186220;
        bh=fftdQk/7amfLgc7ki+wpqJ+JdSTVNsCzjgwyklgGKRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vv0NMyj7RTM0yPtglW/Z6mrNXfRVxJNluW8NVXamKUH9k84UVJQgrEcZ5BcFOhCga
         K2z1d5V3dTliHDLSfdXVKiEZWIwQg1TmeIyWabkRLxNGA8J60pM3iV6iOn9zR1Y92g
         Bx2VhF3x2YmE+oFL7jJ8NRNG2IVUug1WJanJLLPM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolai Stange <nstange@suse.de>,
        Jiri Kosina <jkosina@suse.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Joerg Roedel <jroedel@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 112/276] x86/mm: Remove in_nmi() warning from 64-bit implementation of vmalloc_fault()
Date:   Wed, 29 May 2019 20:04:30 -0700
Message-Id: <20190530030532.968779573@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit a65c88e16f32aa9ef2e8caa68ea5c29bd5eb0ff0 ]

In-NMI warnings have been added to vmalloc_fault() via:

  ebc8827f75 ("x86: Barf when vmalloc and kmemcheck faults happen in NMI")

back in the time when our NMI entry code could not cope with nested NMIs.

These days, it's perfectly fine to take a fault in NMI context and we
don't have to care about the fact that IRET from the fault handler might
cause NMI nesting.

This warning has already been removed from 32-bit implementation of
vmalloc_fault() in:

  6863ea0cda8 ("x86/mm: Remove in_nmi() warning from vmalloc_fault()")

but the 64-bit version was omitted.

Remove the bogus warning also from 64-bit implementation of vmalloc_fault().

Reported-by: Nicolai Stange <nstange@suse.de>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 6863ea0cda8 ("x86/mm: Remove in_nmi() warning from vmalloc_fault()")
Link: http://lkml.kernel.org/r/nycvar.YFH.7.76.1904240902280.9803@cbobk.fhfr.pm
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/mm/fault.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 47bebfe6efa70..9d9765e4d1ef1 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -427,8 +427,6 @@ static noinline int vmalloc_fault(unsigned long address)
 	if (!(address >= VMALLOC_START && address < VMALLOC_END))
 		return -1;
 
-	WARN_ON_ONCE(in_nmi());
-
 	/*
 	 * Copy kernel mappings over when needed. This can also
 	 * happen within a race in page table update. In the later
-- 
2.20.1



