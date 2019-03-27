Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B90C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8361206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714393;
	bh=5AyJgHfpn1Z9lzjKd638j5q9HxUdRuqTInU71GTx38o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cZJ6F3WDDEl9u2TF+muUfB+cXtxN02Otwdc7psWabEUSyGeHwapokUS0zx3f5fkYz
	 xoyETdeKFolmhT/PqaepaLrxCuDah8BpkakS2sTOq8JdcTEv+/2QAyCTKDt0S6nG0B
	 uwme/+DpL3/+6V3MHtQFlnaq1nGLelnlssXSCgRk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388212AbfC0SHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:07:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:49332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388195AbfC0SHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:07:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB09B2063F;
        Wed, 27 Mar 2019 18:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710048;
        bh=5AyJgHfpn1Z9lzjKd638j5q9HxUdRuqTInU71GTx38o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ELCdGPD9JyhtDVUlE8BwBOEUHxT16b2XgrD9kANl6aI9EsR7OG+L+2eg7eE8oadvl
         BIgjKtB/UP35V0igH71KWSDdRalkQ/EZF0juhdbn3ETrDOwuKoiYwlvbc/bFdsFq/p
         KprmJZm2e+dpkkEc0cysjvQRwBhTAFNWZlrZZe4A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kairui Song <kasong@redhat.com>, Borislav Petkov <bp@suse.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Dave Young <dyoung@redhat.com>,
        David Howells <dhowells@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        kexec@lists.infradead.org, Philipp Rudo <prudo@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Yannik Sembritzki <yannik@sembritzki.me>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 173/262] x86/kexec: Fill in acpi_rsdp_addr from the first kernel
Date:   Wed, 27 Mar 2019 14:00:28 -0400
Message-Id: <20190327180158.10245-173-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kairui Song <kasong@redhat.com>

[ Upstream commit ccec81e4251f5a5421e02874e394338a897056ca ]

When efi=noruntime or efi=oldmap is used on the kernel command line, EFI
services won't be available in the second kernel, therefore the second
kernel will not be able to get the ACPI RSDP address from firmware by
calling EFI services and so it won't boot.

Commit

  e6e094e053af ("x86/acpi, x86/boot: Take RSDP address from boot params if available")

added an acpi_rsdp_addr field to boot_params which stores the RSDP
address for other kernel users.

Recently, after

  3a63f70bf4c3 ("x86/boot: Early parse RSDP and save it in boot_params")

the acpi_rsdp_addr will always be filled with a valid RSDP address.

So fill in that value into the second kernel's boot_params thus ensuring
that the second kernel receives the RSDP value from the first kernel.

 [ bp: massage commit message. ]

Signed-off-by: Kairui Song <kasong@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: kexec@lists.infradead.org
Cc: Philipp Rudo <prudo@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Cc: Yannik Sembritzki <yannik@sembritzki.me>
Link: https://lkml.kernel.org/r/20190204173852.4863-1-kasong@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/kexec-bzimage64.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 53917a3ebf94..1f3b77367948 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -218,6 +218,9 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
 	params->screen_info.ext_mem_k = 0;
 	params->alt_mem_k = 0;
 
+	/* Always fill in RSDP: it is either 0 or a valid value */
+	params->acpi_rsdp_addr = boot_params.acpi_rsdp_addr;
+
 	/* Default APM info */
 	memset(&params->apm_bios_info, 0, sizeof(params->apm_bios_info));
 
@@ -256,7 +259,6 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
 	setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
 			efi_setup_data_offset);
 #endif
-
 	/* Setup EDD info */
 	memcpy(params->eddbuf, boot_params.eddbuf,
 				EDDMAXNR * sizeof(struct edd_info));
-- 
2.19.1

