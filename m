Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B5CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C1F2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbfCYJ1o convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:27:44 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:43733 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729597AbfCYJ1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 05:27:43 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x2P9RDhr010368
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 25 Mar 2019 18:27:13 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x2P9RD8L028674;
        Mon, 25 Mar 2019 18:27:13 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x2P9Kp05011082;
        Mon, 25 Mar 2019 18:27:13 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.137] [10.38.151.137]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-3644059; Mon, 25 Mar 2019 18:25:21 +0900
Received: from BPXM12GP.gisp.nec.co.jp ([10.38.151.204]) by
 BPXC09GP.gisp.nec.co.jp ([10.38.151.137]) with mapi id 14.03.0319.002; Mon,
 25 Mar 2019 18:25:20 +0900
From:   Junichi Nomura <j-nomura@ce.jp.nec.com>
To:     Boris Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>,
        "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "bp@suse.de" <bp@suse.de>, "bhe@redhat.com" <bhe@redhat.com>,
        "kasong@redhat.com" <kasong@redhat.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] x86/boot: Don't try to search RSDP from EFI when
 kexec-booted
Thread-Topic: [PATCH v2] x86/boot: Don't try to search RSDP from EFI when
 kexec-booted
Thread-Index: AQHU4uyqlYVKmwOEnUKgAFe/+FdHOA==
Date:   Mon, 25 Mar 2019 09:25:20 +0000
Message-ID: <20190325092519.GA22914@jeru.linux.bs1.fc.nec.co.jp>
References: <20190322110342.GA16202@jeru.linux.bs1.fc.nec.co.jp>
 <20190322152328.GD12472@zn.tnic>
 <20190325002740.GA6637@jeru.linux.bs1.fc.nec.co.jp>
 <20190325060128.GB9385@dhcp-128-65.nay.redhat.com>
 <20190325061929.GC9385@dhcp-128-65.nay.redhat.com>
 <bcb5bd29-a3b8-e42d-8da7-a8501f695c21@ce.jp.nec.com>
 <20190325065921.GA11096@dhcp-128-65.nay.redhat.com>
 <20190325082720.GA20771@jeru.linux.bs1.fc.nec.co.jp>
 <51D9A7D1-49BF-4679-B102-0FC5AC300C9F@alien8.de>
In-Reply-To: <51D9A7D1-49BF-4679-B102-0FC5AC300C9F@alien8.de>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.85]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <A6A918F1AEE3B84E958508EAF8C4455F@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/19 5:54 PM, Boris Petkov wrote:
> I'm going to repeat that again until you get it:
> 
> If the kexec kernel should continue to use efi_systab_init() then you
> should make efi_get_rsdp_addr() exit early in the kexec-ed kernel.

Do you think this one is ok? Either works for me.

[PATCH v2] x86/boot: Don't try to search RSDP from EFI when kexec-booted

Commit 3a63f70bf4c3a ("x86/boot: Early parse RSDP and save it in
boot_params") broke kexec boot on EFI systems.  efi_get_rsdp_addr()
in the early parsing code tries to search RSDP from EFI table but
whose address is virtual.

Normally kexec(1) provides physical address of config_table via boot_params
and EFI code uses that during initialization.
For the early boot code, we just exit efi_get_rsdp_addr() early if the kernel
is booted by kexec.

Fixes: 3a63f70bf4c3a ("x86/boot: Early parse RSDP and save it in boot_params")
Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: Borislav Petkov <bp@suse.de>

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -44,6 +44,26 @@ static acpi_physical_address get_acpi_rsdp(void)
 	return addr;
 }
 
+#ifdef CONFIG_EFI
+static bool is_kexec_booted(void)
+{
+	struct setup_data *data;
+
+	/*
+	 * kexec-tools provides EFI setup data so that kexec-ed kernel
+	 * can find proper tables.
+	 */
+	data = (struct setup_data *) boot_params->hdr.setup_data;
+	while (data) {
+		if (data->type == SETUP_EFI)
+			return true;
+		data = (struct setup_data *) data->next;
+	}
+
+	return false;
+}
+#endif
+
 /* Search EFI system tables for RSDP. */
 static acpi_physical_address efi_get_rsdp_addr(void)
 {
@@ -57,6 +77,10 @@ static acpi_physical_address efi_get_rsdp_addr(void)
 	int size, i;
 	char *sig;
 
+	/* If the system is kexec-booted, poking EFI systab may not work. */
+	if (is_kexec_booted())
+		return 0;
+
 	ei = &boot_params->efi_info;
 	sig = (char *)&ei->efi_loader_signature;
 
