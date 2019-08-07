Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E517C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 00:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7E8214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 00:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfHGAdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 20:33:45 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:35214 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726340AbfHGAdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 20:33:45 -0400
X-UUID: 37262de7528f4ec0ae64e19c3aa12211-20190807
X-UUID: 37262de7528f4ec0ae64e19c3aa12211-20190807
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 48035339; Wed, 07 Aug 2019 08:33:37 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 7 Aug 2019 08:33:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 7 Aug 2019 08:33:37 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Mark Rutland <Mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH v2] arm64: mm: print hexadecimal EC value in mem_abort_decode()
Date:   Wed, 7 Aug 2019 08:33:36 +0800
Message-ID: <20190807003336.28040-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change prints the hexadecimal EC value in mem_abort_decode(),
which makes it easier to lookup the corresponding EC in
the ARM Architecture Reference Manual.

The commit 1f9b8936f36f ("arm64: Decode information from ESR upon mem
faults") prints useful information when memory abort occurs. It would
be easier to lookup "0x25" instead of "DABT" in the document. Then we
can check the corresponding ISS.

For example:
Current	info	  	Document
		  	EC	Exception class
"CP15 MCR/MRC"		0x3	"MCR or MRC access to CP15a..."
"ASIMD"			0x7	"Access to SIMD or floating-point..."
"DABT (current EL)" 	0x25	"Data Abort taken without..."
...

Before:
Unable to handle kernel paging request at virtual address 000000000000c000
Mem abort info:
  ESR = 0x96000046
  Exception class = DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
Data abort info:
  ISV = 0, ISS = 0x00000046
  CM = 0, WnR = 1

After:
Unable to handle kernel paging request at virtual address 000000000000c000
Mem abort info:
  ESR = 0x96000046
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
Data abort info:
  ISV = 0, ISS = 0x00000046
  CM = 0, WnR = 1

Change since v1:
print "EC" instead of "Exception class"
print EC in fixwidth

Cc: Mark Rutland <Mark.rutland@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: James Morse <james.morse@arm.com>
Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 arch/arm64/mm/fault.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index cfd65b63f36f..ad4980a27edb 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -86,8 +86,8 @@ static void mem_abort_decode(unsigned int esr)
 	pr_alert("Mem abort info:\n");
 
 	pr_alert("  ESR = 0x%08x\n", esr);
-	pr_alert("  Exception class = %s, IL = %u bits\n",
-		 esr_get_class_string(esr),
+	pr_alert("  EC = 0x%02lx: %s, IL = %u bits\n",
+		 ESR_ELx_EC(esr), esr_get_class_string(esr),
 		 (esr & ESR_ELx_IL) ? 32 : 16);
 	pr_alert("  SET = %lu, FnV = %lu\n",
 		 (esr & ESR_ELx_SET_MASK) >> ESR_ELx_SET_SHIFT,
-- 
2.18.0

