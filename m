Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAD8C48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD39521874
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbfF0AfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:35:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42526 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727435AbfF0Ae7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:34:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 06DF9C05678B;
        Thu, 27 Jun 2019 00:34:51 +0000 (UTC)
Received: from treble.redhat.com (ovpn-126-66.rdu2.redhat.com [10.10.126.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A5DFF5D9D6;
        Thu, 27 Jun 2019 00:34:48 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Kairui Song <kasong@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v3 0/4] x86: bpf unwinder fixes
Date:   Wed, 26 Jun 2019 19:33:51 -0500
Message-Id: <cover.1561595111.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 27 Jun 2019 00:34:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3:

- Drop even more NACKed BPF changes.

- Coincidentally, a separate fix has already been merged for JIT frame
  pointers:

    fe8d9571dc50 ("bpf, x64: fix stack layout of JITed bpf code")

- 32-bit JIT frame pointers are still broken.  I have a small patch
  which should fix it, if anybody wants to try interacting with the
  maintainer.

- Split the objtool jump table detection feature into a separate patch
  to clarify that it's a generic objtool feature.

Josh Poimboeuf (3):
  objtool: Add support for C jump tables
  bpf: Fix ORC unwinding in non-JIT BPF code
  x86/unwind/orc: Fall back to using frame pointers for generated code

Song Liu (1):
  perf/x86: Always store regs->ip in perf_callchain_kernel()

 arch/x86/events/core.c       | 10 +++++-----
 arch/x86/kernel/unwind_orc.c | 26 ++++++++++++++++++++++----
 kernel/bpf/core.c            |  5 ++---
 tools/objtool/check.c        | 16 ++++++++++++++--
 4 files changed, 43 insertions(+), 14 deletions(-)

-- 
2.20.1

