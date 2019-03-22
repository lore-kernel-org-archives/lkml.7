Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38D0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C0A21939
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbfCVLFE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:05:04 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:55693 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727713AbfCVLFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:05:03 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x2MB4qbT014077
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 20:04:52 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x2MB4qOq010186;
        Fri, 22 Mar 2019 20:04:52 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x2MB4q1O024236;
        Fri, 22 Mar 2019 20:04:52 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.137] [10.38.151.137]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-3596641; Fri, 22 Mar 2019 20:03:44 +0900
Received: from BPXM12GP.gisp.nec.co.jp ([10.38.151.204]) by
 BPXC09GP.gisp.nec.co.jp ([10.38.151.137]) with mapi id 14.03.0319.002; Fri,
 22 Mar 2019 20:03:44 +0900
From:   Junichi Nomura <j-nomura@ce.jp.nec.com>
To:     "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "bp@suse.de" <bp@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: [PATCH] x86/boot: Use EFI setup data if provided
Thread-Topic: [PATCH] x86/boot: Use EFI setup data if provided
Thread-Index: AQHU4J7q4uHsPFz2IEST45iCmNXrzw==
Date:   Fri, 22 Mar 2019 11:03:43 +0000
Message-ID: <20190322110342.GA16202@jeru.linux.bs1.fc.nec.co.jp>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.85]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <B1D242EE98E3D3409B9259A09CF3A252@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3a63f70bf4c3a ("x86/boot: Early parse RSDP and save it in
boot_params") broke kexec boot on EFI systems.  efi_get_rsdp_addr()
in the early parsing code tries to search RSDP from EFI table but
whose address is virtual.

Since kexec(1) provides physical address of config_table via boot_params,
efi_get_rsdp_addr() should look for setup_data in the same way as
efi_systab_init() in arch/x86/platform/efi/efi.c does.

Fixes: 3a63f70bf4c3a ("x86/boot: Early parse RSDP and save it in boot_params")
Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: Borislav Petkov <bp@suse.de>

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 0ef4ad5..9f3b1b9 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -44,6 +44,22 @@ static acpi_physical_address get_acpi_rsdp(void)
 	return addr;
 }
 
+static unsigned long efi_get_setup_data_addr(void)
+{
+	struct setup_data *data;
+	u64 pa_data;
+
+	pa_data = boot_params->hdr.setup_data;
+	while (pa_data) {
+		data = (struct setup_data *) pa_data;
+		if (data->type == SETUP_EFI)
+			return pa_data + sizeof(struct setup_data);
+		pa_data = data->next;
+	}
+
+	return 0;
+}
+
 /* Search EFI system tables for RSDP. */
 static acpi_physical_address efi_get_rsdp_addr(void)
 {
@@ -53,10 +69,12 @@ static acpi_physical_address efi_get_rsdp_addr(void)
 	unsigned long systab, systab_tables, config_tables;
 	unsigned int nr_tables;
 	struct efi_info *ei;
+	struct efi_setup_data *esd;
 	bool efi_64;
 	int size, i;
 	char *sig;
 
+	esd = (struct efi_setup_data *) efi_get_setup_data_addr();
 	ei = &boot_params->efi_info;
 	sig = (char *)&ei->efi_loader_signature;
 
@@ -86,13 +104,13 @@ static acpi_physical_address efi_get_rsdp_addr(void)
 	if (efi_64) {
 		efi_system_table_64_t *stbl = (efi_system_table_64_t *)systab;
 
-		config_tables	= stbl->tables;
+		config_tables	= esd ? esd->tables : stbl->tables;
 		nr_tables	= stbl->nr_tables;
 		size		= sizeof(efi_config_table_64_t);
 	} else {
 		efi_system_table_32_t *stbl = (efi_system_table_32_t *)systab;
 
-		config_tables	= stbl->tables;
+		config_tables	= esd ? esd->tables : stbl->tables;
 		nr_tables	= stbl->nr_tables;
 		size		= sizeof(efi_config_table_32_t);
 	}
