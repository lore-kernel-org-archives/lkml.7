Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647C6C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 03:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF052071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 03:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LjR29wJr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKZDUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 22:20:47 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:55206 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbfKZDUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 22:20:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1574738440; x=1606274440;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IgYu5GqhtLGHsR5EyD+8NnLQ92UJLx33aAXmO0z7fuY=;
  b=LjR29wJrLYJ+TK3ySwN5vHZu9d1kkI8KlhcMYJxiu0vHN1FU8u1+JxEd
   NIycns7EBDj9pWvIeuQ9TGi1soXflIkRmD3yFA5A3IXpXxoJZ9ayVR4O2
   2YEMPj53Ym7OGRBu9yj1Mk7E8v48XQlkVEMvCZqdIaOO5QV//hS/ekdXz
   yNywtcjxE5WIejJj3HXOjUMvIHAAtHXwDkWSsvuKqQ7etWiIib3aFOK7Y
   SbFk14tVoeEJiZdLuoXfJHUnRyD2BEUVbaNx3U/jIlc8vmn0afhz5oi/x
   RsUeyYRjrdTFmZui0d0iI/gudvYFTuTof2E8f1tph9ib1x72KGMxLTrtp
   Q==;
IronPort-SDR: SmcV5jXJNaxCGJsq8AhfdkbU+xwK8sO4gcBjRWwkoIpampkN3TrNQfptlDrR4XKOUgg6NRD3kM
 KI3Q/OV0oMFujyOm1TushQKuPPVLNp8+yda2SUQEaV0Q8CxtqFD93VSeSwJIyn1y6Ua1MvyIQO
 KlJS7XGgFOEMK3j7X6ecj89h7b9Od6idg2Oubac4aUC7yhmpEGQSTcpTfQaZBvTZPe4ueVXem2
 RDL/sIdreYbL2lNTJfcjmWxLzzzTxmXJLTF/TdmHDf184oursuwKMjtY52aOV8iSQT5vZp0DXr
 t9Q=
X-IronPort-AV: E=Sophos;i="5.69,244,1571673600"; 
   d="scan'208";a="124761544"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2019 11:20:40 +0800
IronPort-SDR: sJk8rNb3jwDcfkGfrDkhpzXPPvH75L2LFwxxSCVSYbq7CGNpIy9aHn3uMor55RPQ4fbik85hjo
 QPOujUZn/e748V3daFDrtXTMhk3A+H8Ll1dWIxqIktESkUcLbo6/N76uDNymy9xJ6to9f5wybr
 GvrBwlCioynI7fa2NOzvwZClI7SkwG9PZIsT8BzDwuN+mszLWCghKWf6trMZsWc+dNGDhGA69y
 T3hNXiXw8gJpYJqlPkUSGR0/qjPjkM+KOAlld2eTtPeM4kIQumJwIoOejuwGy/aIDl6xq2pD9Y
 BY4ruFePnoXSzaR0v91FRW9b
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2019 19:15:18 -0800
IronPort-SDR: 4B8lcNHAW/REcZtZOi5U+Bru7/oOlNNnhhRFh5EElL5MrQyA0U9545Rsec2cdPb0QQc2402oX7
 j7TDLE4b2ZEuNr+iI4xWMqhNGts/HudrG3+JmacJhjU6w/eKg0q0D3lWfBrTsl4VoUXduz4r9k
 w0Fpn7rjNNs49EB7j7Igg91bMNgSoO0AU/ayD6EH04V8gZtSjHQF9XCBcQau53fKGYnnmzyra3
 VU509UoIIxA4ARQC9qhy05TaR1pky6CXYYEP+Zhr4Bb2eoYvlHzPFqgQRVDgJFWKUMRw5jAKUi
 IGI=
WDCIronportException: Internal
Received: from usa003951.ad.shared (HELO yoda.hgst.com) ([10.86.50.226])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Nov 2019 19:20:38 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v4 4/4] RISC-V: Implement new SBI v0.2 extensions
Date:   Mon, 25 Nov 2019 19:20:33 -0800
Message-Id: <20191126032033.14825-5-atish.patra@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191126032033.14825-1-atish.patra@wdc.com>
References: <20191126032033.14825-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few v0.1 SBI calls are being replaced by new SBI calls that follows
v0.2 calling convention. The specification changes can be found at

riscv/riscv-sbi-doc#27

Implement the replacement extensions and few additional new SBI
function calls that makes way for a better SBI interface in future.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/sbi.h |  35 +++++++
 arch/riscv/kernel/sbi.c      | 197 ++++++++++++++++++++++++++++++++++-
 2 files changed, 229 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index cc82ae63f8e0..54ba9eebec11 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -22,6 +22,9 @@ enum sbi_ext_id {
 	SBI_EXT_0_1_SHUTDOWN = 0x8,
 #endif
 	SBI_EXT_BASE = 0x10,
+	SBI_EXT_TIME = 0x54494D45,
+	SBI_EXT_IPI = 0x735049,
+	SBI_EXT_RFENCE = 0x52464E43,
 };
 
 enum sbi_ext_base_fid {
@@ -34,6 +37,24 @@ enum sbi_ext_base_fid {
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
@@ -74,6 +95,20 @@ void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
 				unsigned long start,
 				unsigned long size,
 				unsigned long asid);
+int sbi_remote_hfence_gvma(const unsigned long *hart_mask,
+			   unsigned long start,
+			   unsigned long size);
+int sbi_remote_hfence_gvma_vmid(const unsigned long *hart_mask,
+				unsigned long start,
+				unsigned long size,
+				unsigned long vmid);
+int sbi_remote_hfence_vvma(const unsigned long *hart_mask,
+			   unsigned long start,
+			   unsigned long size);
+int sbi_remote_hfence_vvma_asid(const unsigned long *hart_mask,
+				unsigned long start,
+				unsigned long size,
+				unsigned long asid);
 int sbi_probe_extension(long ext);
 
 /* Check if current SBI specification version is 0.1 or not */
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 8574de1074c4..74b3155b570f 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -205,6 +205,101 @@ static int __sbi_rfence_v01(unsigned long ext, unsigned long fid,
 }
 #endif /* CONFIG_RISCV_SBI_V01 */
 
+static void __sbi_set_timer_v02(uint64_t stime_value)
+{
+#if __riscv_xlen == 32
+	sbi_ecall(SBI_EXT_TIME, SBI_EXT_TIME_SET_TIMER, stime_value,
+			  stime_value >> 32, 0, 0, 0, 0);
+#else
+	sbi_ecall(SBI_EXT_TIME, SBI_EXT_TIME_SET_TIMER, stime_value, 0,
+		  0, 0, 0, 0);
+#endif
+}
+
+static int __sbi_send_ipi_v02(const unsigned long *hart_mask)
+{
+	unsigned long hmask_val;
+	struct sbiret ret = {0};
+	int result;
+
+	if (!hart_mask)
+		hmask_val = *(cpumask_bits(cpu_online_mask));
+	else
+		hmask_val = *hart_mask;
+
+	ret = sbi_ecall(SBI_EXT_IPI, SBI_EXT_IPI_SEND_IPI, hmask_val,
+			0, 0, 0, 0, 0);
+	if (ret.error) {
+		pr_err("%s: failed with error [%d]\n", __func__,
+			sbi_err_map_linux_errno(ret.error));
+		result = ret.error;
+	} else
+		result = ret.value;
+
+	return result;
+}
+
+static int __sbi_rfence_v02(unsigned long extid, unsigned long fid,
+			     const unsigned long *hart_mask,
+			     unsigned long hbase, unsigned long start,
+			     unsigned long size, unsigned long arg4,
+			     unsigned long arg5)
+{
+	unsigned long hmask_val;
+	struct sbiret ret = {0};
+	int result;
+	unsigned long ext = SBI_EXT_RFENCE;
+
+	if (!hart_mask)
+		hmask_val = *(cpumask_bits(cpu_online_mask));
+	else
+		hmask_val = *hart_mask;
+
+	switch (fid) {
+	case SBI_EXT_RFENCE_REMOTE_FENCE_I:
+		ret = sbi_ecall(ext, fid, hmask_val, 0, 0, 0, 0, 0);
+		break;
+	case SBI_EXT_RFENCE_REMOTE_SFENCE_VMA:
+		ret = sbi_ecall(ext, fid, hmask_val, 0, start,
+				size, 0, 0);
+		break;
+	case SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID:
+		ret = sbi_ecall(ext, fid, hmask_val, 0, start,
+				size, arg4, 0);
+		break;
+	/*TODO: Handle non zero hbase cases */
+	case SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA:
+		ret = sbi_ecall(ext, fid, hmask_val, 0, start,
+				size, 0, 0);
+		break;
+	case SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA_VMID:
+		ret = sbi_ecall(ext, fid, hmask_val, 0, start,
+				size, arg4, 0);
+		break;
+	case SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA:
+		ret = sbi_ecall(ext, fid, hmask_val, 0, start,
+				size, 0, 0);
+		break;
+	case SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID:
+		ret = sbi_ecall(ext, fid, hmask_val, 0, start,
+				size, arg4, 0);
+		break;
+	default:
+		pr_err("unknown function ID [%lu] for SBI extension [%lu]\n",
+			fid, ext);
+		result = -EINVAL;
+	}
+
+	if (ret.error) {
+		pr_err("%s: failed with error [%d]\n", __func__,
+			sbi_err_map_linux_errno(ret.error));
+		result = ret.error;
+	} else
+		result = ret.value;
+
+	return result;
+}
+
 /**
  * sbi_set_timer() - Program the timer for next timer event.
  * @stime_value: The value after which next timer event should fire.
@@ -237,7 +332,7 @@ EXPORT_SYMBOL(sbi_send_ipi);
  */
 void sbi_remote_fence_i(const unsigned long *hart_mask)
 {
-	__sbi_rfence(SBI_EXT_0_1_REMOTE_FENCE_I, 0,
+	__sbi_rfence(SBI_EXT_0_1_REMOTE_FENCE_I, SBI_EXT_RFENCE_REMOTE_FENCE_I,
 		     hart_mask, 0, 0, 0, 0, 0);
 }
 EXPORT_SYMBOL(sbi_remote_fence_i);
@@ -255,7 +350,8 @@ void sbi_remote_sfence_vma(const unsigned long *hart_mask,
 					 unsigned long start,
 					 unsigned long size)
 {
-	__sbi_rfence(SBI_EXT_0_1_REMOTE_SFENCE_VMA, 0,
+	__sbi_rfence(SBI_EXT_0_1_REMOTE_SFENCE_VMA,
+		     SBI_EXT_RFENCE_REMOTE_SFENCE_VMA,
 		     hart_mask, 0, start, size, 0, 0);
 }
 EXPORT_SYMBOL(sbi_remote_sfence_vma);
@@ -276,11 +372,93 @@ void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
 					      unsigned long size,
 					      unsigned long asid)
 {
-	__sbi_rfence(SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID, 0,
+	__sbi_rfence(SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID,
+		     SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID,
 		     hart_mask, 0, start, size, asid, 0);
 }
 EXPORT_SYMBOL(sbi_remote_sfence_vma_asid);
 
+/**
+ * sbi_remote_hfence_gvma() - Execute HFENCE.GVMA instructions on given remote
+ *			   harts for the specified guest physical address range.
+ * @hart_mask: A cpu mask containing all the target harts.
+ * @start: Start of the guest physical address
+ * @size: Total size of the guest physical address range.
+ *
+ * Return: None
+ */
+int sbi_remote_hfence_gvma(const unsigned long *hart_mask,
+					 unsigned long start,
+					 unsigned long size)
+{
+	return __sbi_rfence(SBI_EXT_RFENCE, SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA,
+			    hart_mask, 0, start, size, 0, 0);
+}
+EXPORT_SYMBOL_GPL(sbi_remote_hfence_gvma);
+
+/**
+ * sbi_remote_hfence_gvma_vmid() - Execute HFENCE.GVMA instructions on given
+ * remote harts for a guest physical address range belonging to a specific VMID.
+ *
+ * @hart_mask: A cpu mask containing all the target harts.
+ * @start: Start of the guest physical address
+ * @size: Total size of the guest physical address range.
+ * @vmid: The value of guest ID (VMID).
+ *
+ * Return: 0 if success, Error otherwise.
+ */
+int sbi_remote_hfence_gvma_vmid(const unsigned long *hart_mask,
+					      unsigned long start,
+					      unsigned long size,
+					      unsigned long vmid)
+{
+	return __sbi_rfence(SBI_EXT_RFENCE,
+			    SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA_VMID,
+			    hart_mask, 0, start, size, vmid, 0);
+}
+EXPORT_SYMBOL(sbi_remote_hfence_gvma_vmid);
+
+/**
+ * sbi_remote_hfence_vvma() - Execute HFENCE.VVMA instructions on given remote
+ *			     harts for the current guest virtual address range.
+ * @hart_mask: A cpu mask containing all the target harts.
+ * @start: Start of the current guest virtual address
+ * @size: Total size of the current guest virtual address range.
+ *
+ * Return: None
+ */
+int sbi_remote_hfence_vvma(const unsigned long *hart_mask,
+					 unsigned long start,
+					 unsigned long size)
+{
+	return __sbi_rfence(SBI_EXT_RFENCE, SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA,
+			    hart_mask, 0, start, size, 0, 0);
+}
+EXPORT_SYMBOL(sbi_remote_hfence_vvma);
+
+/**
+ * sbi_remote_hfence_vvma_asid() - Execute HFENCE.VVMA instructions on given
+ * remote harts for current guest virtual address range belonging to a specific
+ * ASID.
+ *
+ * @hart_mask: A cpu mask containing all the target harts.
+ * @start: Start of the current guest virtual address
+ * @size: Total size of the current guest virtual address range.
+ * @asid: The value of address space identifier (ASID).
+ *
+ * Return: None
+ */
+int sbi_remote_hfence_vvma_asid(const unsigned long *hart_mask,
+					      unsigned long start,
+					      unsigned long size,
+					      unsigned long asid)
+{
+	return __sbi_rfence(SBI_EXT_RFENCE,
+			    SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID,
+			    hart_mask, 0, start, size, asid, 0);
+}
+EXPORT_SYMBOL(sbi_remote_hfence_vvma_asid);
+
 /**
  * sbi_probe_extension() - Check if an SBI extension ID is supported or not.
  * @extid: The extension ID to be probed.
@@ -361,6 +539,19 @@ int __init sbi_init(void)
 	} else {
 		pr_info("SBI implementation ID=0x%lx Version=0x%lx\n",
 			sbi_get_firmware_id(), sbi_get_firmware_version());
+		if (sbi_probe_extension(SBI_EXT_TIME) > 0)
+			__sbi_set_timer = __sbi_set_timer_v02;
+		else
+			__sbi_set_timer = __sbi_set_timer_dummy_warn;
+		if (sbi_probe_extension(SBI_EXT_IPI) > 0)
+			__sbi_send_ipi	= __sbi_send_ipi_v02;
+		else
+			__sbi_send_ipi = __sbi_send_ipi_dummy_warn;
+		if (sbi_probe_extension(SBI_EXT_RFENCE) > 0)
+			__sbi_rfence	= __sbi_rfence_v02;
+		else
+			__sbi_rfence	= __sbi_rfence_dummy_warn;
+
 	}
 
 	return 0;
-- 
2.23.0

