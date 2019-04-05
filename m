Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA40C10F13
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBFAE218A6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731577AbfDEOBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:01:07 -0400
Received: from foss.arm.com ([217.140.101.70]:49776 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730587AbfDEOBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:01:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE7ED1BF7;
        Fri,  5 Apr 2019 07:01:04 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D7CC03F68F;
        Fri,  5 Apr 2019 07:01:00 -0700 (PDT)
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
Subject: [PATCH v2 19/21] i40iw: Redefine i40iw_mmiowb() to do nothing
Date:   Fri,  5 Apr 2019 14:59:34 +0100
Message-Id: <20190405135936.7266-20-will.deacon@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190405135936.7266-1-will.deacon@arm.com>
References: <20190405135936.7266-1-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mmiowb() is now implicit in spin_unlock(), so there's no reason to call
it from driver code. Redefine i40iw_mmiowb() to do nothing instead.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/infiniband/hw/i40iw/i40iw_osdep.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_osdep.h b/drivers/infiniband/hw/i40iw/i40iw_osdep.h
index f27be3e7830b..d474aad62a81 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_osdep.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_osdep.h
@@ -211,7 +211,7 @@ enum i40iw_status_code i40iw_hw_manage_vf_pble_bp(struct i40iw_device *iwdev,
 struct i40iw_sc_vsi;
 void i40iw_hw_stats_start_timer(struct i40iw_sc_vsi *vsi);
 void i40iw_hw_stats_stop_timer(struct i40iw_sc_vsi *vsi);
-#define i40iw_mmiowb() mmiowb()
+#define i40iw_mmiowb() do { } while (0)
 void i40iw_wr32(struct i40iw_hw *hw, u32 reg, u32 value);
 u32  i40iw_rd32(struct i40iw_hw *hw, u32 reg);
 #endif				/* _I40IW_OSDEP_H_ */
-- 
2.11.0

