Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FF7C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 07:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A752339F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 07:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Nbv7gu0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731812AbfHVH67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 03:58:59 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:20003 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730431AbfHVH67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 03:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566460739; x=1597996739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j1ObqNXDvM0ZAwJARyDgXPV48mXMzUSdIC2C+2BkImY=;
  b=Nbv7gu0wM0KVa0CME18+x2aAPEwaWCro1q0QlXZxqUTpz9Cd0N0QFlIW
   GNHtiFciIo0YjsFwAQB111RoEbQio481fp74KHwfdtoYHhos+lWS2HyU4
   snlMb34rPTohDW7han0akxDKmeieOuXFCbV4GyPOryquRzKrD2xc9ayBd
   zeSSW35GoBxuCXnwBJlD4ZVQ4BBR2L/zDxCp4/NKckyQ6KBocZqkEBATv
   ZkyALkdnPgf8AY29ugFStFfgexQFrwIbPej4I7YY+WB2Ek7rI46sLS4Rv
   HzPfsNh+CsL94dHEZi7G6StBhojI8ZdkWA4F4Y79P2x0mv+O2Cqz01joq
   g==;
IronPort-SDR: OSidCQ5doQF2kMOZG5bDRTLmDjBZQB7H0G7C3t7Nl2VZvfQtZqbakM61P11/02qrbCRhcmEkFo
 S/T24csiJVO3bEJ+tZneQAdwwxpQec85wsW8BqYMzp6J7CKrad+ThJ07FFBNDS2TTKanDqeayN
 tzYvL7onRmw3urS/CM7G4NLFCQ318Wa/zkoAqsljCEDS0KDnotAkvOmkg8Dv3Fu+GapWx2FTwo
 z7FOEKxC72tNnZJ4ydFIT2xjbgfD0gzHGM0lGqh5MBGwGqW7etKOg+U7fs4J6JrbAUJS29pGBg
 +34=
X-IronPort-AV: E=Sophos;i="5.64,415,1559491200"; 
   d="scan'208";a="116397478"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2019 15:58:59 +0800
IronPort-SDR: zUtC8O9eX33viny11s6xGIjixrSydv/yVx3YKDVtHcYS4nS+nkdHul1uCFtwpSpggDjEOPpoZn
 war6CGGB3yqRWeuCtTQuqKIxBxGAdCil3H5mM1cLzLCjYtfMirlClk5K+ibiEK21aiM2hYaQ9N
 1e6dOHpRiK9/aZYvSYW7CEFhvNvLLXYhWJOmphYsAcHse33EXv6XO0TrKju3a6HJ06I69Iw/81
 Xmz/Y0+80Y2JwfRlhQRyWjyovt3OFLN0mrPeD9JGn1uXiCCjAzcTb1IVZuCTtkr2XPYqlCWeBD
 GQiB5jL39ERwGhzRwHVDIFIP
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 00:56:19 -0700
IronPort-SDR: LMuHXB3z06ZWti+mKQI/IsLz8aTtCS18D19F4tFR9Hrk6jSZb6zcimTZHv+wNvksstATECV2qP
 73q5WejYVS1IPw7eHpwmJtow4z6SFnGiXATYL9CsI3PWZhNNgQBbi18SRs5cQzOrk9rcStHT1D
 XizVxDssMCr3aoDxRre3qw11iWCVVz2nQUJ2kTVcvJOGKJkiH99h06ONnxBUaIFUBVmIu+1i1R
 eGdJNPvoccxtLCS4DMyC2Uh1uWdhlJWF5r1znhYcGTMNtzJv8lxszy3a0XZVCPQS/qt/NvGtsm
 WSE=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Aug 2019 00:58:58 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@lst.de>, Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v4 1/3] RISC-V: Do not invoke SBI call if cpumask is empty
Date:   Thu, 22 Aug 2019 00:51:49 -0700
Message-Id: <20190822075151.24838-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822075151.24838-1-atish.patra@wdc.com>
References: <20190822075151.24838-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SBI calls are expensive. If cpumask is empty, there is no need to
trap via SBI as no remote tlb flushing is required.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/mm/tlbflush.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index df93b26f1b9d..1293b8017ee0 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -14,6 +14,9 @@ static void __sbi_tlb_flush_range(struct cpumask *cmask, unsigned long start,
 {
 	struct cpumask hmask;
 
+	if (cpumask_empty(cmask))
+		return;
+
 	riscv_cpuid_to_hartid_mask(cmask, &hmask);
 	sbi_remote_sfence_vma(hmask.bits, start, size);
 }
-- 
2.21.0

