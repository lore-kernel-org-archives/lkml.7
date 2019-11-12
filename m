Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC236C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4DC206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfKLK1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 05:27:16 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33201 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbfKLK1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 05:27:14 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUTO4-0007n4-Gd; Tue, 12 Nov 2019 11:27:04 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 28E811C0084;
        Tue, 12 Nov 2019 11:27:04 +0100 (CET)
Date:   Tue, 12 Nov 2019 10:27:03 -0000
From:   "tip-bot2 for Xinwei Kong" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi: libstub/tpm: enable tpm eventlog function for
 ARM platforms
Cc:     Zou Cao <zoucao@linux.alibaba.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157355442380.29376.1364588538431617460.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     d99c1ba6a73b9e93e2884b7893fe19e3c082ba03
Gitweb:        https://git.kernel.org/tip/d99c1ba6a73b9e93e2884b7893fe19e3c082ba03
Author:        Xinwei Kong <kong.kongxinwei@hisilicon.com>
AuthorDate:    Thu, 07 Nov 2019 16:24:21 +08:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Thu, 07 Nov 2019 10:18:45 +01:00

efi: libstub/tpm: enable tpm eventlog function for ARM platforms

Wire up the existing code for ARM that loads the TPM event log into
OS accessible buffers while running the EFI stub so that the kernel
proper can access it at runtime.

Tested-by: Zou Cao <zoucao@linux.alibaba.com>
Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/arm-stub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index c382a48..817237c 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -189,6 +189,8 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table,
 		goto fail_free_cmdline;
 	}
 
+	efi_retrieve_tpm2_eventlog(sys_table);
+
 	/* Ask the firmware to clear memory on unclean shutdown */
 	efi_enable_reset_attack_mitigation(sys_table);
 
