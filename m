Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9433DC46460
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 21:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654372182B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 21:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Gixex1Az"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbfD2V2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 17:28:05 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:37434 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbfD2V15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 17:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556573278; x=1588109278;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=674EX0iIftC/tP47ciQ2WAq8p0Blf4MJzfJ6YEpD/54=;
  b=Gixex1Az6UlvmaCFT1ZaGcJumU2WGl8kXzdSafJvYxPUzcwk3UGSsZln
   qCVgjcpE4Cwp27Mc8vPb6AC/VIFscZVlwI6QJuBuSl5Ln4MmtxRx4XPOr
   jvlugyVEr7pqymQBawjoVtmS/osaiSftBcGcWZlAPDZNZDOqxTJMy6Pki
   SsG3jJXMmxEzHlDqxRoWufDtfYhPaTn+Po/GrMgG5gW+QfqGqnLOqwc5d
   JkJCABxj2UrKrphop7bUQMGyX9B5Jww4u2wXlScs41y1ZlcPykIl63NpR
   LdUvAX8bZp80BlRb2rqY5h6ueriu+f/6TGBBzjR8Gt0RDJk3ojvxzg+37
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,411,1549900800"; 
   d="scan'208";a="108317116"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2019 05:27:57 +0800
IronPort-SDR: LKgUSq1ZMIHzoVgQj31y2xZX5nVF3XsaR9ltnhC+igCzTG/nguU8ZWfvCe07INLmZkzoMhnJuh
 vBBy85dd60v4cHfgYFRDkbYHVeHxppq4UktjEKY3VG8ccsI8aaw3J9sqPXsDoo539oSPFq+QbB
 wU/TsNeod+Bg6v016i7+YPd6HY5ROmnM50a8+MKn1C06V7acuE5j+nTKISJrw7VzDvML9BmLky
 +/phmsXLyV6gW6nBffVNgZQO0YQ5tXf2L2bByPjRGhjX4ibQpbGcz2BCc47LuXCaMo3Wc/7oZP
 f+DpzzAQN3Y0fV+vanBLuBcX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 29 Apr 2019 14:06:27 -0700
IronPort-SDR: YKuQOaUGXWtvH6yMxnbX+5T8aKt+xMu1UOys2MqMN9CNGPcNGH4YnoS70RHEai/+/Dum58K/mC
 XFPRVsEpiOt3g5p92g5To6ydWIgV9ypo/MTkjzd06pojtdh+/P/oQUeywSO6jT8onKm5pitIXw
 aaM1FvzE3F8rjP1lzuGf9XKPsK0Q6nceqmHgrOGZaUT7EtHOCWqLPwyq+uZipCVjFTbwv1zRtJ
 cQeDkzSR2TxSz7tEs88qTe1xk1rgl6YPggLJ9AGDzG5yhhpSIJRqxGR/ImMmzo3mU1rODfO2sq
 RXU=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Apr 2019 14:27:56 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        Borislav Petkov <bp@alien8.de>,
        Changbin Du <changbin.du@intel.com>,
        Gary Guo <gary@garyguo.net>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v3 2/3] RISC-V: Enable TLBFLUSH counters for debug kernel.
Date:   Mon, 29 Apr 2019 14:27:49 -0700
Message-Id: <20190429212750.26165-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190429212750.26165-1-atish.patra@wdc.com>
References: <20190429212750.26165-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TLB flush counters under vmstat seems to be very helpful while
debugging TLB flush performance in RISC-V.

Add the Kconfig option only for debug kernels.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index eb56c82d8aa1..c1ee876d1e7f 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -49,6 +49,7 @@ config RISCV
 	select GENERIC_IRQ_MULTI_HANDLER
 	select ARCH_HAS_PTE_SPECIAL
 	select HAVE_EBPF_JIT if 64BIT
+	select HAVE_ARCH_DEBUG_TLBFLUSH if DEBUG_KERNEL
 
 config MMU
 	def_bool y
-- 
2.21.0

