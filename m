Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB185C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C41B20656
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbfFYLYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 07:24:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41860 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728706AbfFYLYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 07:24:39 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfjYu-0004r2-UI; Tue, 25 Jun 2019 13:24:33 +0200
Message-Id: <20190625111353.863718167@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Jun 2019 13:13:53 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Robert Hodaszi <Robert.Hodaszi@digi.com>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>
Subject: [patch 0/5] x86/irq: Cure various interrupt issues
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series addresses a few long standing issues:

  1) The spurious interrupt warning which is emitted occasionally for
     no obvious reason. Partially harmless but annoying

  2) The spurious system vector detection which got wreckaged quite some
     time ago and can completely wedge a machine. Posted yesterday already
     in a preliminary version. Now actually verified that it does what it
     claims to do.

Details in the various patches.

For your conveniance the series is available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.irq

Thanks,

	tglx

8<-----------------
 arch/x86/entry/entry_32.S      |   24 ++++++++++++++++++++++++
 arch/x86/entry/entry_64.S      |   30 ++++++++++++++++++++++++++----
 arch/x86/include/asm/hw_irq.h  |    5 ++++-
 arch/x86/kernel/apic/apic.c    |   33 ++++++++++++++++++++++-----------
 arch/x86/kernel/apic/io_apic.c |   39 +++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/apic/vector.c  |    4 ++--
 arch/x86/kernel/idt.c          |    3 ++-
 arch/x86/kernel/irq.c          |    2 +-
 include/linux/irq.h            |    2 ++
 kernel/irq/autoprobe.c         |    6 +++---
 kernel/irq/chip.c              |    6 ++++++
 kernel/irq/cpuhotplug.c        |    2 +-
 kernel/irq/internals.h         |    1 +
 kernel/irq/manage.c            |   41 +++++++++++++++++++++++++++++++++++------
 14 files changed, 168 insertions(+), 30 deletions(-)

