Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE58C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 00:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E87D21019
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 00:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfCYAnn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 20:43:43 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:37167 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729132AbfCYAnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 20:43:42 -0400
X-Greylist: delayed 881 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Mar 2019 20:43:41 EDT
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x2P0SN30023340
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 25 Mar 2019 09:28:23 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x2P0SNUw018972;
        Mon, 25 Mar 2019 09:28:23 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x2P0SKHA015712;
        Mon, 25 Mar 2019 09:28:23 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.139] [10.38.151.139]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-3615830; Mon, 25 Mar 2019 09:27:42 +0900
Received: from BPXM12GP.gisp.nec.co.jp ([10.38.151.204]) by
 BPXC11GP.gisp.nec.co.jp ([10.38.151.139]) with mapi id 14.03.0319.002; Mon,
 25 Mar 2019 09:27:41 +0900
From:   Junichi Nomura <j-nomura@ce.jp.nec.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "bp@suse.de" <bp@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH] x86/boot: Use EFI setup data if provided
Thread-Topic: [PATCH] x86/boot: Use EFI setup data if provided
Thread-Index: AQHU4J7q4uHsPFz2IEST45iCmNXrz6YXLkgAgAO8tgA=
Date:   Mon, 25 Mar 2019 00:27:41 +0000
Message-ID: <20190325002740.GA6637@jeru.linux.bs1.fc.nec.co.jp>
References: <20190322110342.GA16202@jeru.linux.bs1.fc.nec.co.jp>
 <20190322152328.GD12472@zn.tnic>
In-Reply-To: <20190322152328.GD12472@zn.tnic>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.85]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <A42CEB7B089EDC4AACF327A66B35C369@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 04:23:28PM +0100, Borislav Petkov wrote:
> On Fri, Mar 22, 2019 at 11:03:43AM +0000, Junichi Nomura wrote:
> > Commit 3a63f70bf4c3a ("x86/boot: Early parse RSDP and save it in
> > boot_params") broke kexec boot on EFI systems.  efi_get_rsdp_addr()
> > in the early parsing code tries to search RSDP from EFI table but
> > whose address is virtual.
> > 
> > Since kexec(1) provides physical address of config_table via boot_params,
> > efi_get_rsdp_addr() should look for setup_data in the same way as
> > efi_systab_init() in arch/x86/platform/efi/efi.c does.
> 
> If the kexec kernel should continue to use efi_systab_init() then you
> should make efi_get_rsdp_addr() exit early in the kexec-ed kernel.

I'm not sure which way kexec devel is going. Added kexec list.
Here is the version that exits early in efi_get_rsdp_addr().

[PATCH] x86/boot: Don't try to search RSDP from EFI when kexec-booted

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
index 0ef4ad5..1cefc43 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -44,6 +44,24 @@ static acpi_physical_address get_acpi_rsdp(void)
 	return addr;
 }
 
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
+
 /* Search EFI system tables for RSDP. */
 static acpi_physical_address efi_get_rsdp_addr(void)
 {
@@ -57,6 +75,10 @@ static acpi_physical_address efi_get_rsdp_addr(void)
 	int size, i;
 	char *sig;
 
+	/* If the system is kexec-booted, poking EFI systab may not work. */
+	if (is_kexec_booted())
+		return 0;
+
 	ei = &boot_params->efi_info;
 	sig = (char *)&ei->efi_loader_signature;
 
