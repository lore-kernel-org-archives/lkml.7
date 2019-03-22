Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0275EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 06:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC636218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 06:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfCVG4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 02:56:45 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:16084 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727375AbfCVG4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 02:56:45 -0400
X-Greylist: delayed 1156 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Mar 2019 02:56:44 EDT
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id x2M6bEqu036883
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 14:37:14 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id x2M6arHW036844;
        Fri, 22 Mar 2019 14:36:53 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Fri, 22 Mar 2019
 14:37:05 +0800
From:   Alan Kao <alankao@andestech.com>
To:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <palmer@sifive.com>
CC:     Alan Kao <alankao@andestech.com>,
        Greentime Hu <greentime@andestech.com>,
        Vincent Chen <deanbo422@gmail.com>
Subject: [PATCH] riscv: fix accessing 8-byte variable from RV32
Date:   Fri, 22 Mar 2019 14:37:04 +0800
Message-ID: <1553236624-31275-1-git-send-email-alankao@andestech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com x2M6arHW036844
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A memory save operation to 8-byte variable in RV32 is divided into
two sw instructions in the put_user macro.  The current fixup returns
execution flow to the second sw instead of the one after it.

This patch fixes this fixup code according to the load access part.

Signed-off-by: Alan Kao<alankao@andestech.com>
Cc: Greentime Hu <greentime@andestech.com>
Cc: Vincent Chen <deanbo422@gmail.com>
---
 arch/riscv/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index a00168b..fb53a80 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -300,7 +300,7 @@ do {								\
 		"	.balign 4\n"				\
 		"4:\n"						\
 		"	li %0, %6\n"				\
-		"	jump 2b, %1\n"				\
+		"	jump 3b, %1\n"				\
 		"	.previous\n"				\
 		"	.section __ex_table,\"a\"\n"		\
 		"	.balign " RISCV_SZPTR "\n"			\
-- 
2.7.4

