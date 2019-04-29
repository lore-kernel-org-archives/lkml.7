Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1155AC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 19:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEDD121670
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 19:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ff13Igzt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbfD2T7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 15:59:25 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:31849 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbfD2T7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 15:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556567953; x=1588103953;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=674EX0iIftC/tP47ciQ2WAq8p0Blf4MJzfJ6YEpD/54=;
  b=Ff13Igztq1BhHXLOmv/zPs7vcNXbh9nmEMXF+UByyat8/mAjoVC4KD4I
   w+ZixSv4nq8TuJo9FhLfTginPUozi7AYnXoRMIsq+F85L2QGDt+TxgXfN
   527guK1V3eY86KKiCMIMrflwS5uBQhXqxqGv6642/a/SxizTzIt03/MUo
   8BBpgss+dE1f7oBh7BsNTqfrxglH9fsewQyD/PINgjUx7BbEZ8SbAz4NS
   aDkClC/A4Oo4XlJItKDqjecaMrCdXqr59EOu8LdYooH2uY6Jc1p11EX6j
   hcNDu6k1jORdNPGSKKrgyaoUDRqc0YiOAdk+06UIHqEF/fNvviPy67Nwo
   g==;
X-IronPort-AV: E=Sophos;i="5.60,410,1549900800"; 
   d="scan'208";a="108309669"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2019 03:58:12 +0800
IronPort-SDR: UPGqvhVmzeoCoFXWgKZjdHtguGnyHIjWJvzlGqZrvOgXLfx6BFOiNtCt7tUi0XzR8WeUADihfs
 VOvqiUXsCCJfRVio0EH2cQ6Ur5R1FUWE9wLysBle24CNq+pHDbVAy1cs7igdtxSlvR1waj6PkD
 z+z336vR9RN7uWkvenyu1exingNQUCvniTJ4qyF5Z513TnnfWyQsDV87IbhPudqevAhQSesWS4
 eqsC5Szfdkx5LytIkQ4SmVnitqKVZ13V8lefdYdeUfMr/2gG6ini6IvoUX/Mo4WMgF12NdhE76
 NLKx5tTEEUUrbGYLrs6CgffF
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 29 Apr 2019 12:34:35 -0700
IronPort-SDR: Bt0jcdD1gm6d1cRvYD8xLZ7OUU/7ALDxMP8bBhd/gEWwUm0ZOsyuoXKhnV/Htgbmrf1RFmzG5a
 KdmEWUvthppVLvTA/Wn2Wuh9DNVRFYVw78A+JrkdrPf+GhM2TyGnTWr7XZAa/3XETeB0z6VmGW
 Nr8nyyN1U1289sezewNwGRjArVhMrC560i55lAnYqYS4xUqANmVFYO1xUWVEonuy8UVyPN4UZY
 SpvkvHtvLuG2nrfaNqKYpDrYj+YxmwOv76nBf9H3mxnpjf3yRS75QhSJzUH0vhLsZUtfAEVqHj
 T54=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Apr 2019 12:58:11 -0700
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
Subject: [PATCH v2 2/3] RISC-V: Enable TLBFLUSH counters for debug kernel.
Date:   Mon, 29 Apr 2019 12:57:58 -0700
Message-Id: <20190429195759.18330-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190429195759.18330-1-atish.patra@wdc.com>
References: <20190429195759.18330-1-atish.patra@wdc.com>
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

