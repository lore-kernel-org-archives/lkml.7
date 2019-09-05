Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05D4C43140
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 18:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE38A20825
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 18:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391397AbfIESsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 14:48:17 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:20676 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731401AbfIESsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 14:48:16 -0400
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x85Ikj15024468;
        Thu, 5 Sep 2019 18:47:43 GMT
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com with ESMTP id 2uu37cjfny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Sep 2019 18:47:43 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 8B5E75D;
        Thu,  5 Sep 2019 18:47:42 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 5508)
        id 4DC69201EAAA6; Thu,  5 Sep 2019 13:47:42 -0500 (CDT)
Message-Id: <20190905184742.195335597@stormcage.eag.rdlabs.hpecorp.net>
References: <20190905184741.256857552@stormcage.eag.rdlabs.hpecorp.net>
User-Agent: quilt/0.46-1
Date:   Thu, 05 Sep 2019 13:47:48 -0500
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
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 7/8] x86/platform/uv: Check EFI Boot to set reboot type
Content-Disposition: inline; filename=check-efi-boot
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-05_06:2019-09-04,2019-09-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909050176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change to checking for EFI Boot type from previous check on if this
is a KDUMP kernel.  This allows for KDUMP kernels that can handle
EFI reboots.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
To: Thomas Gleixner <tglx@linutronix.de>
To: Ingo Molnar <mingo@redhat.com>
To: H. Peter Anvin <hpa@zytor.com>
To: Andrew Morton <akpm@linux-foundation.org>
To: Borislav Petkov <bp@alien8.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Cc: Russ Anderson <russ.anderson@hpe.com>
Cc: Hedi Berriche <hedi.berriche@hpe.com>
Cc: Steve Wahl <steve.wahl@hpe.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/apic/x2apic_uv_x.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

--- linux.orig/arch/x86/kernel/apic/x2apic_uv_x.c
+++ linux/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -15,6 +15,7 @@
 #include <linux/export.h>
 #include <linux/pci.h>
 #include <linux/acpi.h>
+#include <linux/efi.h>
 
 #include <asm/e820/api.h>
 #include <asm/uv/uv_mmrs.h>
@@ -1483,6 +1484,14 @@ static void __init build_socket_tables(v
 	}
 }
 
+/* Check which reboot to use */
+static void check_efi_reboot(void)
+{
+	/* If EFI reboot not available, use ACPI reboot */
+	if (!efi_enabled(EFI_BOOT))
+		reboot_type = BOOT_ACPI;
+}
+
 /* Setup user proc fs files */
 static int proc_hubbed_show(struct seq_file *file, void *data)
 {
@@ -1571,6 +1580,8 @@ static __init int uv_system_init_hubless
 	if (rc >= 0)
 		uv_setup_proc_files(1);
 
+	check_efi_reboot();
+
 	return rc;
 }
 
@@ -1704,12 +1715,7 @@ static void __init uv_system_init_hub(vo
 	/* Register Legacy VGA I/O redirection handler: */
 	pci_register_set_vga_state(uv_set_vga_state);
 
-	/*
-	 * For a kdump kernel the reset must be BOOT_ACPI, not BOOT_EFI, as
-	 * EFI is not enabled in the kdump kernel:
-	 */
-	if (is_kdump_kernel())
-		reboot_type = BOOT_ACPI;
+	check_efi_reboot();
 }
 
 /*

-- 
