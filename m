Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC76BC10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D292186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbfDEOBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:01:05 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49730 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731545AbfDEOBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:01:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9576A1BB0;
        Fri,  5 Apr 2019 07:01:00 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B0E613F68F;
        Fri,  5 Apr 2019 07:00:56 -0700 (PDT)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-arch@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 18/21] scsi/qla1280: Remove stale comment about mmiowb()
Date:   Fri,  5 Apr 2019 14:59:33 +0100
Message-Id: <20190405135936.7266-19-will.deacon@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190405135936.7266-1-will.deacon@arm.com>
References: <20190405135936.7266-1-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All mmiowb() invocations have been removed, so there's no need to keep
banging on about it.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/scsi/qla1280.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
index 93acbc5094f0..327eff67a1ee 100644
--- a/drivers/scsi/qla1280.c
+++ b/drivers/scsi/qla1280.c
@@ -3363,16 +3363,6 @@ qla1280_isp_cmd(struct scsi_qla_host *ha)
 
 	/*
 	 * Update request index to mailbox4 (Request Queue In).
-	 * The mmiowb() ensures that this write is ordered with writes by other
-	 * CPUs.  Without the mmiowb(), it is possible for the following:
-	 *    CPUA posts write of index 5 to mailbox4
-	 *    CPUA releases host lock
-	 *    CPUB acquires host lock
-	 *    CPUB posts write of index 6 to mailbox4
-	 *    On PCI bus, order reverses and write of 6 posts, then index 5,
-	 *       causing chip to issue full queue of stale commands
-	 * The mmiowb() prevents future writes from crossing the barrier.
-	 * See Documentation/driver-api/device-io.rst for more information.
 	 */
 	WRT_REG_WORD(&reg->mailbox4, ha->req_ring_index);
 
-- 
2.11.0

