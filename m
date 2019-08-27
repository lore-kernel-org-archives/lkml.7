Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001A6C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 18:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1332186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 18:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ohF//mfh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbfH0SNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 14:13:17 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39538 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbfH0SNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 14:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4GBJd/6CpXINlrjly9Ph5quH3fSBp0S16BuevuJTZa4=; b=ohF//mfhCIMWBylzf7/JOCKps
        2oKLR4wscTrHyB+NYXBUNSPCh6BwzGbr06n0n7vfU/uAJyjc5LJmZTa5BPGQh61BlDGZd9OYS1YW/
        5UYIi4VvzS/p8pJfeXqwkoakn++ttk/6e6ljIbSHkIgfPNIJIdoIs3Lt10SyIAb9y7burXHXdz6Gq
        UTQvh4KE5NtXGbqNLPwen69w9uuDEkLCna+rqUn8yL8nAUdiHZYfTGVGOx3YWj7dKjvm4JqTJ5Dqr
        n0cYFxakGMWV+e6S03jl2lJ5ewpZSUwhOxGWtjVBwtPERL1MmhIk1hXmUm+QaSWr10IwJAZ4TdVLA
        I2PGISd1g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2fxe-0006iw-Aj; Tue, 27 Aug 2019 18:12:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D59C8301FF9;
        Tue, 27 Aug 2019 20:12:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 92419203CEC08; Tue, 27 Aug 2019 20:12:50 +0200 (CEST)
Message-Id: <20190827180622.159326993@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 27 Aug 2019 20:06:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 0/3] Rewrite x86/ftrace to use text_poke()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ftrace was one of the last W^X violators; these patches move it over to the
generic text_poke() interface and thereby get rid of this oddity.

The first patch has been posted before and was/is part of my (in-progress)
static_call and jump_label/jmp8 patch series; but is equally needed here.

The second patch cleans up the text_poke batching code, and the third converts
ftrace.

---
 arch/x86/include/asm/ftrace.h        |   2 -
 arch/x86/include/asm/text-patching.h |  28 +-
 arch/x86/kernel/alternative.c        | 156 +++++++--
 arch/x86/kernel/ftrace.c             | 620 +++++------------------------------
 arch/x86/kernel/jump_label.c         |  83 ++---
 arch/x86/kernel/kprobes/opt.c        |  11 +-
 arch/x86/kernel/traps.c              |   9 -
 7 files changed, 261 insertions(+), 648 deletions(-)

