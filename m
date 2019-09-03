Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D65C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84138238AB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbfICPn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 11:43:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:22285 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729693AbfICPn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:43:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 67A53307D88D;
        Tue,  3 Sep 2019 15:43:56 +0000 (UTC)
Received: from flask (unknown [10.43.2.55])
        by smtp.corp.redhat.com (Postfix) with SMTP id 475B360461;
        Tue,  3 Sep 2019 15:43:53 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Tue, 03 Sep 2019 17:43:52 +0200
From:   =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?q?Jirka=20Hladk=C3=BD?= <jhladky@redhat.com>,
        =?UTF-8?q?Ji=C5=99=C3=AD=20Voz=C3=A1r?= <jvozar@redhat.com>,
        x86@kernel.org
Subject: [PATCH 1/2] x86/mm/tlb: include tracepoints from tlb.c instead of mmu_context.h
Date:   Tue,  3 Sep 2019 17:43:39 +0200
Message-Id: <20190903154340.860299-2-rkrcmar@redhat.com>
In-Reply-To: <20190903154340.860299-1-rkrcmar@redhat.com>
References: <20190903154340.860299-1-rkrcmar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 03 Sep 2019 15:43:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asm/mmu_context.h is a tree-wide include that will unnecessarily break
the build if CREATE_TRACE_POINTS is defined when including it.

Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
---
 arch/x86/include/asm/mmu_context.h | 2 --
 arch/x86/mm/tlb.c                  | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 16ae821483c8..e59f230ff981 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -7,8 +7,6 @@
 #include <linux/mm_types.h>
 #include <linux/pkeys.h>
 
-#include <trace/events/tlb.h>
-
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/paravirt.h>
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index e6a9edc5baaf..83cd66a0db99 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -18,6 +18,8 @@
 
 #include "mm_internal.h"
 
+#include <trace/events/tlb.h>
+
 /*
  *	TLB flushing, formerly SMP-only
  *		c/o Linus Torvalds.
-- 
2.23.0

