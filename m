Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A472C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F188214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561370744;
	bh=tsibFGeCM9kozJlvLSct5i3Ff8kYIeVStbM5u+Zsugk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JmeLUATMD9Qhvxj+8fjg8EA/GBuR9TJYc13oGsIMbnzMjYXYQ4G6QXnl8DNlbg6mY
	 aXOOe8bta4wZBJjG9Bp+iRCsMCCsnDNvVzOjHu36PbhkXQ3zikzi0CeeDPsYGgjuID
	 V0B+4wXL1JapsOx/OxHowaYvWQ6ibXYtzmRHbqwM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbfFXKFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:05:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:37600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729799AbfFXKFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:05:37 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D01F121473;
        Mon, 24 Jun 2019 10:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561370736;
        bh=tsibFGeCM9kozJlvLSct5i3Ff8kYIeVStbM5u+Zsugk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2e/ypiZo03yVTnrT69Z5asUZiwkwXZKhsm15dLWTQ0+ONYQuKLqVDct7985HTPm7b
         SMY27DoEdRFbmEHIM/N6QZx2xnoMA9U3IDQLh66cGHKb3jFBz89mf4EK728Xz+yA+m
         S8FsjPQsQy3p4magk17fvgtN6Xe4wBK2pVSiL2Gg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, ShihPo Hung <shihpo.hung@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: [PATCH 4.19 72/90] riscv: mm: synchronize MMU after pte change
Date:   Mon, 24 Jun 2019 17:57:02 +0800
Message-Id: <20190624092318.729317368@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092313.788773607@linuxfoundation.org>
References: <20190624092313.788773607@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ShihPo Hung <shihpo.hung@sifive.com>

commit bf587caae305ae3b4393077fb22c98478ee55755 upstream.

Because RISC-V compliant implementations can cache invalid entries
in TLB, an SFENCE.VMA is necessary after changes to the page table.
This patch adds an SFENCE.vma for the vmalloc_fault path.

Signed-off-by: ShihPo Hung <shihpo.hung@sifive.com>
[paul.walmsley@sifive.com: reversed tab->whitespace conversion,
 wrapped comment lines]
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: linux-riscv@lists.infradead.org
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/riscv/mm/fault.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -29,6 +29,7 @@
 
 #include <asm/pgalloc.h>
 #include <asm/ptrace.h>
+#include <asm/tlbflush.h>
 
 /*
  * This routine handles page faults.  It determines the address and the
@@ -281,6 +282,18 @@ vmalloc_fault:
 		pte_k = pte_offset_kernel(pmd_k, addr);
 		if (!pte_present(*pte_k))
 			goto no_context;
+
+		/*
+		 * The kernel assumes that TLBs don't cache invalid
+		 * entries, but in RISC-V, SFENCE.VMA specifies an
+		 * ordering constraint, not a cache flush; it is
+		 * necessary even after writing invalid entries.
+		 * Relying on flush_tlb_fix_spurious_fault would
+		 * suffice, but the extra traps reduce
+		 * performance. So, eagerly SFENCE.VMA.
+		 */
+		local_flush_tlb_page(addr);
+
 		return;
 	}
 }


