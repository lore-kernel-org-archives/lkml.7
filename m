Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1031C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C0921582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aGbA7+iM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfLRVjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:39:43 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:31484 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfLRVjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:39:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576705178; x=1608241178;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+loTlbtAVmDNqKG5gyPbZ0rjffG1s2UyA+gSQE4hEM0=;
  b=aGbA7+iMJlZOYOysw+n7tyXuPGr6UPfXnUsaokfTLFyRfT1830SAi2Nx
   o89eEkrjC1REYXy57R23SWYAMnhyfWPeYHzEd7nVBeYcgiOXphKfrnjPX
   ClZHs+8NJvOsiCbEa05KxLGJtBEq/slltlI1l/kH8rcrBqyueD8fuWnxu
   QOMtDH+JIEJ0yd/MDxvIKawiaR6TkkyJwJLLYIgK/l7iUSDd/jTILItnD
   oNtWI6I9yaWPiIvcEx6ZftHyMvMgVDwHYvrRIwSMsSBMBHR8vaR1Pigo5
   P3DMEgTAH3IlIY5Fgyjfc8gj7Nywpam290/BMhxCWG1K0ElKWnl2abd1Y
   w==;
IronPort-SDR: hAjvk77c2treLKW8Yh+yLC9h9g+yAo5G/cUOJcrfQkCNe05Bs8ZSwMuta5iS/WYnnbqNk2kLmr
 Mew950oEayJK5laDTkJjyLayyZL+yhNVezdWq0qy5W7aXpzsAKBraNSRNV70ykUshcNJfsE/Rj
 X1RhZ1ngsV83FKSoUmvLtiWBMBXAnGs2hj3yo3PeiZsfNEr3gONu/NY3MkMQljd/RqEkfM7M+T
 hpM//dJbq4cbTI+ugDFt8ZtpKsyO6ywSikZ6M6667jc++hMeI51xyUS4YVZJWmszjhgLTIvECw
 l/s=
X-IronPort-AV: E=Sophos;i="5.69,330,1571673600"; 
   d="scan'208";a="127281466"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Dec 2019 05:39:37 +0800
IronPort-SDR: F28lHl5mw7nsiEEQO2+aD64dRukwFayR4S8QtGSEpkuB/HAsTSpV1JAHRxQKeeKz+xrF2GTe0z
 rSx9Wn+r+ElBMEdzo8urnVd4hKxc3c5D0CdqZDcVDooQ2Ol2L1822zQ7FDsFgj3fnCmpO2fTg4
 C2aNoVQfCvG1+kCjgIjpXja0nHdg3V49CQQKw5KzpVFrL4Zixg05mSge2o1E3OzgKznFWnxrB8
 jSm/j5cuShWBAxQ32sbPjTPQGQO7PZRa42bpwE/0bacJEOijOsSh88mXjRhifH3rt1WXvJSR6o
 w/AmlL1BlFprKQhqbqVYYTL8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2019 13:33:39 -0800
IronPort-SDR: xQtxRi5tOp6wtw3UFUFR8RLs/sz8SPKL5YegLH+fLmwbLuGpaRhr13w1P7+0yGrtqav+M/2sp2
 yyjSE/QjG0m+ybkav//p7yzzr4ku/R0+hjhMrt9yFWvK7QbYAGEyNb6oZCEyTk4sqFN5IcG6GG
 jerb3VEbEGtNSBjAI2Uw93tY4KwYCNVxsGgZVzgDyuLZrMe5Z53iiXGWSKkFOL5I/STDpEXu2x
 E4g284Cyy98Dfjr1LZAbMFU3wbvo9UGh6ul4bQkhccYEc4wFLzpiJsc6a9VnL4lXakTWcpglUh
 LLo=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Dec 2019 13:39:38 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v6 3/5] RISC-V: Add SBI v0.2 extension definitions
Date:   Wed, 18 Dec 2019 13:39:16 -0800
Message-Id: <20191218213918.16676-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191218213918.16676-1-atish.patra@wdc.com>
References: <20191218213918.16676-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few v0.1 SBI calls are being replaced by new SBI calls that follows
v0.2 calling convention.

This patch just defines these new extensions.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/sbi.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 1aeb4bb7baa8..9612133213ba 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -21,6 +21,9 @@ enum sbi_ext_id {
 	SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID = 0x7,
 	SBI_EXT_0_1_SHUTDOWN = 0x8,
 	SBI_EXT_BASE = 0x10,
+	SBI_EXT_TIME = 0x54494D45,
+	SBI_EXT_IPI = 0x735049,
+	SBI_EXT_RFENCE = 0x52464E43,
 };
 
 enum sbi_ext_base_fid {
@@ -33,6 +36,24 @@ enum sbi_ext_base_fid {
 	SBI_EXT_BASE_GET_MIMPID,
 };
 
+enum sbi_ext_time_fid {
+	SBI_EXT_TIME_SET_TIMER = 0,
+};
+
+enum sbi_ext_ipi_fid {
+	SBI_EXT_IPI_SEND_IPI = 0,
+};
+
+enum sbi_ext_rfence_fid {
+	SBI_EXT_RFENCE_REMOTE_FENCE_I = 0,
+	SBI_EXT_RFENCE_REMOTE_SFENCE_VMA,
+	SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID,
+	SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA,
+	SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA_VMID,
+	SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA,
+	SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID,
+};
+
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
 #define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
-- 
2.24.0

