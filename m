Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8C3C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615A6218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbfDXNrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:47:36 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53806 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730653AbfDXNrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:47:35 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hJIFI-0001AU-SK; Wed, 24 Apr 2019 15:47:33 +0200
Message-Id: <20190424134115.091452807@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 24 Apr 2019 15:41:15 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Juergen Gross <jgross@suse.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [patch 0/3] x86/paravirt: Rework paravirt patching
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andi tried to make the paravirt patch magic work nicely with LTO. It turned
out that the DEF_NATIVE() macro is clever but fragile. Even without LTO it
works by chance and not by design.

As the paravirt patch tables are not changed frequently it's reasonable to
convert them to regular data which is initialized with byte sequences.

Looking at Andi's attempt to change the existing code made me realize
that there is no real reason to have two variants for 32 and 64 bit
which just differ slightly.

The following series unifies the 32/64bit implementation and converts
it to use regular data at the end.

Thanks,

	tglx

8<--------------
 a/arch/x86/kernel/paravirt_patch_32.c |   67 ------------------
 a/arch/x86/kernel/paravirt_patch_64.c |   75 --------------------
 arch/x86/include/asm/paravirt_types.h |    4 -
 arch/x86/kernel/Makefile              |    4 -
 b/arch/x86/kernel/paravirt_patch.c    |  126 ++++++++++++++++++++++++++++++++++
 5 files changed, 128 insertions(+), 148 deletions(-)


