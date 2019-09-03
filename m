Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE683C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C447C2077B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbfICPnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 11:43:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50750 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728679AbfICPnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:43:52 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 50B168553F;
        Tue,  3 Sep 2019 15:43:52 +0000 (UTC)
Received: from flask (unknown [10.43.2.55])
        by smtp.corp.redhat.com (Postfix) with SMTP id CBC3D194B2;
        Tue,  3 Sep 2019 15:43:48 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Tue, 03 Sep 2019 17:43:48 +0200
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
Subject: [PATCH 0/2] sched/debug: add sched_update_nr_running tracepoint
Date:   Tue,  3 Sep 2019 17:43:38 +0200
Message-Id: <20190903154340.860299-1-rkrcmar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 03 Sep 2019 15:43:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a tracepoint for monitoring nr_running values, which is helpful in
discovering scheduling imbalances.

More information and most of the code is in [2/2], while [1/2] fixes a
build issue that popped up because CREATE_TRACE_POINTS is now defined
for several includes.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Jirka Hladký <jhladky@redhat.com>
Cc: Jiří Vozár <jvozar@redhat.com>
Cc: x86@kernel.org


Radim Krčmář (2):
  x86/mm/tlb: include tracepoints from tlb.c instead of mmu_context.h
  sched/debug: add sched_update_nr_running tracepoint

 arch/x86/include/asm/mmu_context.h |  2 --
 arch/x86/mm/tlb.c                  |  2 ++
 include/trace/events/sched.h       | 22 ++++++++++++++++++++++
 kernel/sched/core.c                |  7 ++-----
 kernel/sched/fair.c                |  2 --
 kernel/sched/sched.h               |  7 +++++++
 6 files changed, 33 insertions(+), 9 deletions(-)

-- 
2.23.0

