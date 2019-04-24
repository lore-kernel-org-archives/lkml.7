Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8DCC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA81D21907
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556089504;
	bh=5unMs6PDUk8kD2aRo6nsVxOEJhoXRitbAaBWb0qfUYU=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=ffPfI3Ukoq2P17NJjOyoT/4w8qOg/ZeS0VJdoU3eXa50WUHAe3L/m4tU3RcJoC3td
	 xCJiWdPKiulpFebnSgiyJP0vvUVlVMmAoQY6jQNCPPbaZASoTLEy2xxyjTiidW8QRd
	 p3gLNARRbOS/V7UQXZRbjSUHu8fcCVW079A0Fbac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbfDXHFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:05:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfDXHFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 03:05:03 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E01972148D;
        Wed, 24 Apr 2019 07:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556089502;
        bh=5unMs6PDUk8kD2aRo6nsVxOEJhoXRitbAaBWb0qfUYU=;
        h=Date:From:To:cc:Subject:From;
        b=XlZtOI12n7unWK/D457YNm90NnNvlYRRexkUCmwKXpk8KlCv/KSF+LUxN8l9Qn+Gu
         QXNnJxb97oV9Fs7AE5c+w44JNJIF90LvLau6eFJg0cyKMtvC0vSgvRz5OtTv167ht+
         M8GV9R8d2ny+uFplXhL0zYGpO3icUk2cabeeM9og=
Date:   Wed, 24 Apr 2019 09:04:57 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
cc:     Joerg Roedel <jroedel@suse.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Nicolai Stange <nstange@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/mm: Remove in_nmi() warning from 64bit implementation
 of vmalloc_fault()
Message-ID: <nycvar.YFH.7.76.1904240902280.9803@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

In-NMI warnings have been added to vmalloc_fault() via ebc8827f75 ("x86: 
Barf when vmalloc and kmemcheck faults happen in NMI") back in the time 
when our NMI entry code could not cope with nested NMIs.

These days, it's perfectly fine to take a fault in NMI context and we 
don't have to care about the fact that IRET from the fault handler might 
cause NMI nesting.

This warning has already been removed from 32bit implementation of 
vmalloc_fault() in 6863ea0cda8 ("x86/mm: Remove in_nmi() warning from 
vmalloc_fault()"), but 64bit version was omitted.

Remove the bogus warning also from 64bit implementation of vmalloc_fault().

Fixes: 6863ea0cda8 ("x86/mm: Remove in_nmi() warning from vmalloc_fault()")
Reported-by: Nicolai Stange <nstange@suse.de>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 arch/x86/mm/fault.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 667f1da36208..5eaf67e8314f 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -359,8 +359,6 @@ static noinline int vmalloc_fault(unsigned long address)
 	if (!(address >= VMALLOC_START && address < VMALLOC_END))
 		return -1;
 
-	WARN_ON_ONCE(in_nmi());
-
 	/*
 	 * Copy kernel mappings over when needed. This can also
 	 * happen within a race in page table update. In the later

-- 
Jiri Kosina
SUSE Labs

