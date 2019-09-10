Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A04C49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F2F21D79
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405208AbfIJOq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 10:46:58 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:46346 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393645AbfIJOqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 10:46:40 -0400
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8AEfMsL006251;
        Tue, 10 Sep 2019 14:46:22 GMT
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 2uxbxdsuf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Sep 2019 14:46:22 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id 97D7E72;
        Tue, 10 Sep 2019 14:46:21 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 5508)
        id 3F506201FCF22; Tue, 10 Sep 2019 09:46:21 -0500 (CDT)
Message-Id: <20190910144610.300020245@stormcage.eag.rdlabs.hpecorp.net>
References: <20190910144609.909602978@stormcage.eag.rdlabs.hpecorp.net>
User-Agent: quilt/0.46-1
Date:   Tue, 10 Sep 2019 09:46:12 -0500
From:   Mike Travis <mike.travis@hpe.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Hedi Berriche <hedi.berriche@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] x86/platform/uv: Add return code to UV BIOS Init function
Content-Disposition: inline; filename=add-bios_init-rc
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-10_10:2019-09-10,2019-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 spamscore=0 impostorscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909100142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a return code to the UV BIOS init function that indicates the 
successful initialization of the kernel/BIOS callback interface.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
---
 arch/x86/include/asm/uv/bios.h |    2 +-
 arch/x86/platform/uv/bios_uv.c |    9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

--- linux.orig/arch/x86/include/asm/uv/bios.h
+++ linux/arch/x86/include/asm/uv/bios.h
@@ -138,7 +138,7 @@ extern s64 uv_bios_change_memprotect(u64
 extern s64 uv_bios_reserved_page_pa(u64, u64 *, u64 *, u64 *);
 extern int uv_bios_set_legacy_vga_target(bool decode, int domain, int bus);
 
-extern void uv_bios_init(void);
+extern int uv_bios_init(void);
 
 extern unsigned long sn_rtc_cycles_per_second;
 extern int uv_type;
--- linux.orig/arch/x86/platform/uv/bios_uv.c
+++ linux/arch/x86/platform/uv/bios_uv.c
@@ -184,20 +184,20 @@ int uv_bios_set_legacy_vga_target(bool d
 }
 EXPORT_SYMBOL_GPL(uv_bios_set_legacy_vga_target);
 
-void uv_bios_init(void)
+int uv_bios_init(void)
 {
 	uv_systab = NULL;
 	if ((uv_systab_phys == EFI_INVALID_TABLE_ADDR) ||
 	    !uv_systab_phys || efi_runtime_disabled()) {
 		pr_crit("UV: UVsystab: missing\n");
-		return;
+		return -EEXIST;
 	}
 
 	uv_systab = ioremap(uv_systab_phys, sizeof(struct uv_systab));
 	if (!uv_systab || strncmp(uv_systab->signature, UV_SYSTAB_SIG, 4)) {
 		pr_err("UV: UVsystab: bad signature!\n");
 		iounmap(uv_systab);
-		return;
+		return -EINVAL;
 	}
 
 	/* Starting with UV4 the UV systab size is variable */
@@ -208,8 +208,9 @@ void uv_bios_init(void)
 		uv_systab = ioremap(uv_systab_phys, size);
 		if (!uv_systab) {
 			pr_err("UV: UVsystab: ioremap(%d) failed!\n", size);
-			return;
+			return -EFAULT;
 		}
 	}
 	pr_info("UV: UVsystab: Revision:%x\n", uv_systab->revision);
+	return 0;
 }

-- 

