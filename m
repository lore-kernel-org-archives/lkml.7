Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3858DC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 101F12082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfCEDY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 22:24:26 -0500
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:42061 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726993AbfCEDYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 22:24:25 -0500
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id x253MwJ7044096;
        Tue, 5 Mar 2019 11:22:58 +0800 (GMT-8)
        (envelope-from vincentc@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Tue, 5 Mar 2019
 11:23:58 +0800
From:   Vincent Chen <vincentc@andestech.com>
To:     <palmer@sifive.com>, <aou@eecs.berkeley.edu>,
        <ebiederm@xmission.com>, <jimw@sifive.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <deanbo422@gmail.com>, <vincentc@andestech.com>
Subject: [PATCH v2 3/3] riscv: Support BUG() in kernel module
Date:   Tue, 5 Mar 2019 11:23:35 +0800
Message-ID: <1551756215-22299-4-git-send-email-vincentc@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551756215-22299-1-git-send-email-vincentc@andestech.com>
References: <1551756215-22299-1-git-send-email-vincentc@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com x253MwJ7044096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel module is loaded into vmalloc region which is located below
to the PAGE_OFFSET. Hence the condition, pc < PAGE_OFFSET, in the
is_valid_bugaddr() will filter out all trap exceptions triggered
by kernel module. To support BUG() in kernel module, the condition is
changed to pc < VMALLOC_START.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
---
 arch/riscv/kernel/traps.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 0cd0137..9551388 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -156,7 +156,7 @@ int is_valid_bugaddr(unsigned long pc)
 {
 	bug_insn_t insn;
 
-	if (pc < PAGE_OFFSET)
+	if (pc < VMALLOC_START)
 		return 0;
 	if (probe_kernel_address((bug_insn_t *)pc, insn))
 		return 0;
-- 
1.7.1

