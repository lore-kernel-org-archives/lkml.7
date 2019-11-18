Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81947C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 22:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F8B2230C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 22:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eHZuQ0ek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfKRW5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 17:57:10 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:53672 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbfKRW5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 17:57:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1574117827; x=1605653827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2Cl3Yy4laR6Em8oB4Zv8FAgT/XtNVIz5adorAyEv8c0=;
  b=eHZuQ0ekX9zIKSQdDmZPXr0XE3dhkYrFN1FfN9FYf+5eg9d5ztJHesJN
   HHaN90G0q4n0A5CuBZ0rXKEKZmiVbjggMRl6DSgdl7cq0A+xIs3DrYXnA
   UqgCj0wD5pdv5ygYWMCLkpl8S1bcs+0mbg1ZHB8Elc6TtK3j3RLJOD4CC
   M2Gxe/7zVspBoiX4r6qeQR4wu31Hl0P+XgBkLmvE1oiNabBRrpJONku0b
   zSlHLHHxPWHK3gZ5HJhi/REW7erHPLD2prP72xB6ou+eX/Q9wqvzYE0Fj
   xdZrjbZ5dpQQhDJXnVpv/vErgRuGoDvxgpw8zi52cjiOTNxYvIrtNMMwx
   g==;
IronPort-SDR: AzB6uU2K5pBLQW4pekFWrVBREC6doMI0kKnTXm/Gf43obSRyX+8OEDBp8IyYqGLByr/kFch/Xo
 ihwbI7wIifjS1bMeIuFm13gwFVP6RWSZfvc0l5ZRoZ+zJPwXlDs2msxpZ4iVcZ1tHE/M0tCAII
 4qKUOaTa4hBafyhcPaaTx2AxF3h1/O+i23TmCkVxI5s4IaKz0/7O97iKXqmnRVH608iEXFFQOP
 MvEX/vDy20nkEqBQ3UV86FE8M25zCHPNF5c/xBUgxLNSQTD37FCB/hwigFCCropBdS/pXTTimb
 plU=
X-IronPort-AV: E=Sophos;i="5.68,321,1569254400"; 
   d="scan'208";a="230735393"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2019 06:57:06 +0800
IronPort-SDR: 7fNldVHw0XxGelWh60tBcEgucdxsJKi5pMcF8RUL3MuB52dLt02Th6NivaNTb42k7SzdRVPjWr
 uqBdinynXO+488TVohoY4HxpAMa3fnEMqBt74Sj68fu5e4how8GvDfNvdAM+FxrvDiTIIhaO9i
 hA1o14H6uZVkZAMnzyc5Fqd0wGZjVkOtJSAQs+R8jgUlJql8Isgv5dDWM/yFtXYz5DizNVPFsd
 FL5fbwZsvV7xANbO5Bj/9uoV+3kCo31tuavA8RosxeMr7ckbKcneQsNZfaVGOE2zNOAGhRfhtb
 Pm+n++v0CbpQgtjWueL7rALG
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 14:52:20 -0800
IronPort-SDR: 23SWddq2Pkm9apBV1nKKaB2btadRLUgOpJYF3Iq4CYXbv1XQ+fa+Q3PtfqUAfZlrkwfFeNqOMc
 tC0OftSgpKyENBIeqsRbQ7mgMBQV91b9jHmAYWrjyn8qObEF5L+5K2rIoW32EQBo1N0ZuDZ6/Z
 pCB5SIlloSevTDgnY4HNnz1XuoH3bzboYqUHv0PDOQNdVqduunUe7yTKB16cKAEkZcg4HvpYUS
 y3485++2vy4P0HUXTcu5JqP7ef/4aIl6Uj/k5mmU5ZgslAeL/qpXNB/LCwjXUVAs/+x9IjYB87
 G8s=
WDCIronportException: Internal
Received: from yoda.sdcorp.global.sandisk.com (HELO yoda.int.fusionio.com) ([10.196.158.237])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Nov 2019 14:57:07 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Anup Patel <anup@brainfault.org>, Gary Guo <gary@garyguo.net>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Behrens <behrensj@mit.edu>
Subject: [PATCH v3 4/4] RISC-V: Implement SBI v0.2 replacement extensions
Date:   Mon, 18 Nov 2019 14:45:39 -0800
Message-Id: <20191118224539.2171-5-atish.patra@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118224539.2171-1-atish.patra@wdc.com>
References: <20191118224539.2171-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few v0.1 SBI calls are being replaced by new SBI calls that follows
v0.2 calling convention. The specification changes can be found at

https://github.com/riscv/riscv-sbi-doc/pull/27

Implement the replacement extensions that makes way for a better SBI
interface in future.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/sbi.h | 22 ++++++++++++++
 arch/riscv/kernel/sbi.c      | 57 ++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 75ad7a190b1b..09beb0bfa3b4 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -19,6 +19,10 @@ enum sbi_ext_id {
 	SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID = 0x7,
 	SBI_EXT_0_1_SHUTDOWN = 0x8,
 	SBI_EXT_BASE = 0x10,
+	SBI_EXT_TIME = 0x54494D45,
+	SBI_EXT_IPI = 0x735049,
+	SBI_EXT_RFENCE = 0x52464E43,
+
 };
 
 enum sbi_ext_base_fid {
@@ -31,6 +35,24 @@ enum sbi_ext_base_fid {
 	SBI_BASE_GET_MIMPID,
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
 #define SBI_SPEC_VERSION_MAJOR_OFFSET	24
 #define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 6c864fd7fb95..02e7bf581183 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -120,6 +120,14 @@ void sbi_set_timer(uint64_t stime_value)
 	}
 #endif
 
+#if __riscv_xlen == 32
+	sbi_ecall(SBI_EXT_TIME, SBI_EXT_TIME_SET_TIMER, stime_value,
+			  stime_value >> 32, 0, 0, 0, 0);
+#else
+	sbi_ecall(SBI_EXT_TIME, SBI_EXT_TIME_SET_TIMER, stime_value, 0,
+		  0, 0, 0, 0);
+#endif
+
 }
 
 /**
@@ -130,6 +138,8 @@ void sbi_set_timer(uint64_t stime_value)
  */
 void sbi_send_ipi(const unsigned long *hart_mask)
 {
+	unsigned long hmask_val;
+	struct sbiret ret;
 #ifdef CONFIG_RISCV_SBI_V01
 	if (sbi_spec_is_0_1()) {
 		sbi_ecall(SBI_EXT_0_1_SEND_IPI, 0, (unsigned long)hart_mask,
@@ -137,6 +147,16 @@ void sbi_send_ipi(const unsigned long *hart_mask)
 		return;
 	}
 #endif
+	if (!hart_mask)
+		hmask_val = *(cpumask_bits(cpu_online_mask));
+	else
+		hmask_val = *hart_mask;
+
+	ret = sbi_ecall(SBI_EXT_IPI, SBI_EXT_IPI_SEND_IPI, *hart_mask,
+		  0, 0, 0, 0, 0);
+	if (ret.error)
+		pr_err("%s: failed with error [%d]\n", __func__,
+			sbi_err_map_linux_errno(ret.error));
 }
 
 /**
@@ -147,6 +167,8 @@ void sbi_send_ipi(const unsigned long *hart_mask)
  */
 void sbi_remote_fence_i(const unsigned long *hart_mask)
 {
+	unsigned long hmask_val;
+	struct sbiret ret;
 #ifdef CONFIG_RISCV_SBI_V01
 	if (sbi_spec_is_0_1()) {
 		sbi_ecall(SBI_EXT_0_1_REMOTE_FENCE_I, 0,
@@ -154,6 +176,16 @@ void sbi_remote_fence_i(const unsigned long *hart_mask)
 		return;
 	}
 #endif
+	if (!hart_mask)
+		hmask_val = *(cpumask_bits(cpu_online_mask));
+	else
+		hmask_val = *hart_mask;
+
+	ret = sbi_ecall(SBI_EXT_RFENCE, SBI_EXT_RFENCE_REMOTE_FENCE_I,
+			hmask_val, 0, 0, 0, 0, 0);
+	if (ret.error)
+		pr_err("%s: failed with error [%d]\n", __func__,
+			sbi_err_map_linux_errno(ret.error));
 }
 
 /**
@@ -169,6 +201,8 @@ void sbi_remote_sfence_vma(const unsigned long *hart_mask,
 					 unsigned long start,
 					 unsigned long size)
 {
+	unsigned long hmask_val;
+	struct sbiret ret;
 #ifdef CONFIG_RISCV_SBI_V01
 	if (sbi_spec_is_0_1()) {
 		sbi_ecall(SBI_EXT_0_1_REMOTE_SFENCE_VMA, 0,
@@ -176,6 +210,17 @@ void sbi_remote_sfence_vma(const unsigned long *hart_mask,
 		return;
 	}
 #endif
+	if (!hart_mask)
+		hmask_val = *(cpumask_bits(cpu_online_mask));
+	else
+		hmask_val = *hart_mask;
+
+	ret = sbi_ecall(SBI_EXT_RFENCE, SBI_EXT_RFENCE_REMOTE_SFENCE_VMA,
+		  hmask_val, 0, start, size, 0, 0);
+
+	if (ret.error)
+		pr_err("%s: failed with error [%d]\n", __func__,
+			sbi_err_map_linux_errno(ret.error));
 }
 
 /**
@@ -194,6 +239,8 @@ void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
 					      unsigned long size,
 					      unsigned long asid)
 {
+	struct sbiret ret;
+	unsigned long hmask_val;
 #ifdef CONFIG_RISCV_SBI_V01
 	if (sbi_spec_is_0_1()) {
 		sbi_ecall(SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID, 0,
@@ -201,6 +248,16 @@ void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
 		return;
 	}
 #endif
+	if (!hart_mask)
+		hmask_val = *(cpumask_bits(cpu_online_mask));
+	else
+		hmask_val = *hart_mask;
+
+	ret = sbi_ecall(SBI_EXT_RFENCE, SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID,
+		  hmask_val, 0, start, size, asid, 0);
+	if (ret.error)
+		pr_err("%s: failed with error [%d]\n", __func__,
+			sbi_err_map_linux_errno(ret.error));
 }
 
 /**
-- 
2.23.0

