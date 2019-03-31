Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE154C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834722084B
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731559AbfCaWK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 18:10:26 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57577 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731172AbfCaWKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 18:10:25 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hAiel-0004qA-F5; Mon, 01 Apr 2019 00:10:23 +0200
Message-Id: <20190331214020.836098943@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 31 Mar 2019 23:40:20 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [patch 00/14] x86/exceptions: Add guard patches to IST stacks
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

While looking for something different I stumbled over the comment in struct
cpu_entry_area:

         * Exception stacks used for IST entries.
         *
         * In the future, this should have a separate slot for each stack
         * with guard pages between them.

As usual with such comments they are added in good faith and then
forgotten. Looking what it takes to fix that let me stumble over some other
leftovers like orig_ist[], now unused macros, useless defines and a bunch
of assumptions about the exception stacks being a big lump. Aside of that I
found a too broad check of the exception stack in the x86/64 stack overflow
detector.

The following series cleans that up and gradually prepares for guard pages
between the IST stacks.

Thanks,

	tglx

8<-------------------
 Documentation/x86/kernel-stacks       |    8 ++--
 arch/x86/entry/entry_64.S             |    4 +-
 arch/x86/include/asm/cpu_entry_area.h |   35 ++++++++++++++++---
 arch/x86/include/asm/page_32_types.h  |    6 ---
 arch/x86/include/asm/page_64_types.h  |   13 ++++---
 arch/x86/include/asm/processor.h      |    9 -----
 arch/x86/kernel/cpu/common.c          |   41 +++-------------------
 arch/x86/kernel/dumpstack_64.c        |   49 +++++++++++++++++----------
 arch/x86/kernel/idt.c                 |   19 +++++-----
 arch/x86/kernel/irq_64.c              |   31 ++++++++++++-----
 arch/x86/mm/cpu_entry_area.c          |   61 +++++++++++++++++++++++-----------
 arch/x86/mm/fault.c                   |    3 +
 12 files changed, 159 insertions(+), 120 deletions(-)





