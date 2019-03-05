Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA09C00319
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B4D2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfCEDYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 22:24:06 -0500
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:33338 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726522AbfCEDYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 22:24:05 -0500
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id x253MhqC044022;
        Tue, 5 Mar 2019 11:22:43 +0800 (GMT-8)
        (envelope-from vincentc@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Tue, 5 Mar 2019
 11:23:40 +0800
From:   Vincent Chen <vincentc@andestech.com>
To:     <palmer@sifive.com>, <aou@eecs.berkeley.edu>,
        <ebiederm@xmission.com>, <jimw@sifive.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <deanbo422@gmail.com>, <vincentc@andestech.com>
Subject: [PATCH v2 0/3] riscv: Support trap-based WARN() and fix bug in do_trap_break
Date:   Tue, 5 Mar 2019 11:23:32 +0800
Message-ID: <1551756215-22299-1-git-send-email-vincentc@andestech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com x253MhqC044022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
  - Remove unnecessary non-functional diff
  - Rearrange the order of the patches
  - Edit the commit description

The trap-based WARN() will help developers to analyze the cause of WARN()
because if the debugger is connected, the control flow will be transferred
to debugging environment.

BUG() is currently not working properly. When the C extension is supported,
the assembler translates the "ebreak" to "c.ebreak" opcode. Hence the trap
is possibly triggered by "c.ebreak" instead of expected the "ebreak". This
will cause the check mechanism in is_valid_bugaddr(bugaddr) to think that
the trap triggered by "c.ebreak" occurs in an invalidate bug address. This
patch set will add "c.ebreak" into the check mechanism. In addition, BUG()
is also unable to work in the kernel module due to an inappropriate
condition in is_valid_bugaddr().

Vincent Chen (3):
  riscv: support trap-based WARN()
  riscv: Add the support for c.ebreak check in is_valid_bugaddr()
  riscv: Support BUG() in kernel module

 arch/riscv/include/asm/bug.h |   34 ++++++++++++++++++++++++----------
 arch/riscv/kernel/traps.c    |   22 ++++++++++++++++++----
 2 files changed, 42 insertions(+), 14 deletions(-)

