Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEFDC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048AB2086C
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731773AbfCaWKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 18:10:49 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57641 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731620AbfCaWKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 18:10:35 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hAiev-0004rf-8B; Mon, 01 Apr 2019 00:10:33 +0200
Message-Id: <20190331215136.039902969@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 31 Mar 2019 23:40:34 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [patch 14/14] x86/exceptions: Enable IST guard pages
References: <20190331214020.836098943@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All usage sites which expected that the exception stacks in the CPU entry
area are mapped linearly are fixed up. Enable guard pages between the
IST stacks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/cpu_entry_area.h |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -25,13 +25,9 @@ struct exception_stacks {
 	ESTACKS_MEMBERS(0)
 };
 
-/*
- * The effective cpu entry area mapping with guard pages. Guard size is
- * zero until the code which makes assumptions about linear mapping is
- * cleaned up.
- */
+/* The effective cpu_entry_area mapping with guard pages */
 struct cea_exception_stacks {
-	ESTACKS_MEMBERS(0)
+	ESTACKS_MEMBERS(PAGE_SIZE)
 };
 #endif
 


