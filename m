Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C49C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B532053B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbfICIcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 04:32:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59245 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbfICIcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 04:32:07 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i54EJ-0002pa-B9; Tue, 03 Sep 2019 10:31:59 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E1F171C0772;
        Tue,  3 Sep 2019 10:31:58 +0200 (CEST)
Date:   Tue, 03 Sep 2019 08:31:58 -0000
From:   "tip-bot2 for Christoph Hellwig" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Unexport set_memory_x() and set_memory_nx()
Cc:     Christoph Hellwig <hch@lst.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20190826075558.8125-2-hch@lst.de>
References: <20190826075558.8125-2-hch@lst.de>
MIME-Version: 1.0
Message-ID: <156749951872.13279.5570680731854717726.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     ec46133d3b81053701e2a29047dfb6228ff487bd
Gitweb:        https://git.kernel.org/tip/ec46133d3b81053701e2a29047dfb6228ff487bd
Author:        Christoph Hellwig <hch@lst.de>
AuthorDate:    Mon, 26 Aug 2019 09:55:54 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Sep 2019 09:26:37 +02:00

x86/mm: Unexport set_memory_x() and set_memory_nx()

No module currently messed with clearing or setting the execute
permission of kernel memory, and none really should.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190826075558.8125-2-hch@lst.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/pageattr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index e14e95e..08a6f04 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -1977,7 +1977,6 @@ int set_memory_x(unsigned long addr, int numpages)
 
 	return change_page_attr_clear(&addr, numpages, __pgprot(_PAGE_NX), 0);
 }
-EXPORT_SYMBOL(set_memory_x);
 
 int set_memory_nx(unsigned long addr, int numpages)
 {
@@ -1986,7 +1985,6 @@ int set_memory_nx(unsigned long addr, int numpages)
 
 	return change_page_attr_set(&addr, numpages, __pgprot(_PAGE_NX), 0);
 }
-EXPORT_SYMBOL(set_memory_nx);
 
 int set_memory_ro(unsigned long addr, int numpages)
 {
