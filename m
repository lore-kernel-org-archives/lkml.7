Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28B8C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A83C72068E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfLCQ0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 11:26:49 -0500
Received: from michel.telenet-ops.be ([195.130.137.88]:42250 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfLCQ0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 11:26:49 -0500
Received: from ramsan ([84.195.182.253])
        by michel.telenet-ops.be with bizsmtp
        id ZUSm2100U5USYZQ06USmFw; Tue, 03 Dec 2019 17:26:47 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1icB0g-0007fd-I3; Tue, 03 Dec 2019 17:26:46 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1icB0g-0005Cd-Fa; Tue, 03 Dec 2019 17:26:46 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/7] sh: Modernize printing of kernel messages
Date:   Tue,  3 Dec 2019 17:26:38 +0100
Message-Id: <20191203162645.19950-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

This patch series fixes the broken lines in kernel output, which I
presume have been happening since commit 4bcc595ccd80decb ("printk:
reinstate KERN_CONT for printing continuat ion lines").
Most annoying are the ones in call traces and disassembly dumps, as they
cause lots of small bits of information to fly by your serial console.

Thanks!

Geert Uytterhoeven (7):
  sh: kernel: disassemble: Fix broken lines in disassembly dumps
  sh: dump_stack: Fix broken lines and ptrval in calltrace dumps
  sh: process: Fix broken lines in register dumps
  sh: sh2007: Modernize printing of kernel messages
  sh: pci: Modernize printing of kernel messages
  sh: machvec: Modernize printing of kernel messages
  sh: fault: Modernize printing of kernel messages

 arch/sh/boards/board-sh2007.c    |   4 +-
 arch/sh/drivers/pci/common.c     |   6 +-
 arch/sh/drivers/pci/pci-sh7780.c |  23 ++++---
 arch/sh/drivers/pci/pci.c        |  11 ++--
 arch/sh/kernel/disassemble.c     | 103 ++++++++++++++++---------------
 arch/sh/kernel/dumpstack.c       |  24 +++----
 arch/sh/kernel/machvec.c         |   8 +--
 arch/sh/kernel/process_32.c      |  38 +++++-------
 arch/sh/mm/fault.c               |  39 ++++++------
 9 files changed, 124 insertions(+), 132 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
