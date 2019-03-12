Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FCAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76AE0214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411545;
	bh=ec7jfeluU/jK+pw+XRR3kb8zFG/O4fpLZIOw5r6BiEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lsKTc8pq3DrnSsoD+JOcIcYRgRKTeOJtSsoYaM3pLk8ajMgiUYDsLXGWw156b7tlG
	 hnylZ2c+Lj9QqMQ09sxPVbQepcv0+T2YwNMduwuhAXWz22pL3Z/ss5TYFaZeebBIlq
	 bPUQTvpbibfbCJGK/JdfIyfH9AaSzyGUKJ7BoV2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbfCLRZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:25:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729756AbfCLRRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:48 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7EC121741;
        Tue, 12 Mar 2019 17:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411067;
        bh=ec7jfeluU/jK+pw+XRR3kb8zFG/O4fpLZIOw5r6BiEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1sGd/5m7JEfVxhoqjh/YEBiymK0jj46hwK5wdYrIHHA7YWSodp8tAW4XotGjHLMRV
         TOX4boSm0m0EEs3MFqXKIPal/wLiwIdgRYBfjSNKFtRCFBahGRcPX6NK2H23jOqQVV
         Zu0OejJI3uLg44VcP5DhF6m/S/abKDhfOcMkqW5M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Kairui Song <kasong@redhat.com>, Borislav Petkov <bp@suse.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, bhe@redhat.com,
        David Howells <dhowells@redhat.com>, erik.schmauss@intel.com,
        fanc.fnst@cn.fujitsu.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, kexec@lists.infradead.org,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        Philipp Rudo <prudo@linux.vnet.ibm.com>,
        rafael.j.wysocki@intel.com, robert.moore@intel.com,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Yannik Sembritzki <yannik@sembritzki.me>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 58/96] x86/kexec: Dont setup EFI info if EFI runtime is not enabled
Date:   Tue, 12 Mar 2019 10:10:16 -0700
Message-Id: <20190312171038.895781665@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
References: <20190312171034.530434962@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 2aa958c99c7fd3162b089a1a56a34a0cdb778de1 ]

Kexec-ing a kernel with "efi=noruntime" on the first kernel's command
line causes the following null pointer dereference:

  BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
  #PF error: [normal kernel read fault]
  Call Trace:
   efi_runtime_map_copy+0x28/0x30
   bzImage64_load+0x688/0x872
   arch_kexec_kernel_image_load+0x6d/0x70
   kimage_file_alloc_init+0x13e/0x220
   __x64_sys_kexec_file_load+0x144/0x290
   do_syscall_64+0x55/0x1a0
   entry_SYSCALL_64_after_hwframe+0x44/0xa9

Just skip the EFI info setup if EFI runtime services are not enabled.

 [ bp: Massage commit message. ]

Suggested-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Kairui Song <kasong@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Dave Young <dyoung@redhat.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: bhe@redhat.com
Cc: David Howells <dhowells@redhat.com>
Cc: erik.schmauss@intel.com
Cc: fanc.fnst@cn.fujitsu.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: kexec@lists.infradead.org
Cc: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org
Cc: Philipp Rudo <prudo@linux.vnet.ibm.com>
Cc: rafael.j.wysocki@intel.com
Cc: robert.moore@intel.com
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Cc: Yannik Sembritzki <yannik@sembritzki.me>
Link: https://lkml.kernel.org/r/20190118111310.29589-2-kasong@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/kexec-bzimage64.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 490f9be3fda2..167ecc270ca5 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -167,6 +167,9 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
 	struct efi_info *current_ei = &boot_params.efi_info;
 	struct efi_info *ei = &params->efi_info;
 
+	if (!efi_enabled(EFI_RUNTIME_SERVICES))
+		return 0;
+
 	if (!current_ei->efi_memmap_size)
 		return 0;
 
-- 
2.19.1



