Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE40EC17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9244E206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfKLK1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 05:27:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33195 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbfKLK1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 05:27:10 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUTO5-0007n8-BI; Tue, 12 Nov 2019 11:27:05 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 09DC41C0084;
        Tue, 12 Nov 2019 11:27:05 +0100 (CET)
Date:   Tue, 12 Nov 2019 10:27:04 -0000
From:   "tip-bot2 for Dominik Brodowski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi/random: use arch-independent efi_call_proto()
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157355442467.29376.10156023853962410450.tip-bot2@tip-bot2>
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

Commit-ID:     41e8a7c249bf50f2f719c2ff21ab92be70651f06
Gitweb:        https://git.kernel.org/tip/41e8a7c249bf50f2f719c2ff21ab92be70651f06
Author:        Dominik Brodowski <linux@dominikbrodowski.net>
AuthorDate:    Wed, 06 Nov 2019 08:06:12 +01:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Thu, 07 Nov 2019 10:18:45 +01:00

efi/random: use arch-independent efi_call_proto()

To handle all arch-specific peculiarities when calling an EFI protocol
function, a wrapper efi_call_proto() exists on all relevant architectures.
On arm/arm64, this is merely a plain function call. On x86, a special EFI
entry stub needs to be used, however, as the calling convention differs.
To make the efi/random stub arch-independent, use efi_call_proto()
instead of the existing non-portable calls to the EFI get_rng protocol
function. This also requires the addition of some typedefs.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/random.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
index b4b1d1d..53f1466 100644
--- a/drivers/firmware/efi/libstub/random.c
+++ b/drivers/firmware/efi/libstub/random.c
@@ -9,6 +9,18 @@
 
 #include "efistub.h"
 
+typedef struct efi_rng_protocol efi_rng_protocol_t;
+
+typedef struct {
+	u32 get_info;
+	u32 get_rng;
+} efi_rng_protocol_32_t;
+
+typedef struct {
+	u64 get_info;
+	u64 get_rng;
+} efi_rng_protocol_64_t;
+
 struct efi_rng_protocol {
 	efi_status_t (*get_info)(struct efi_rng_protocol *,
 				 unsigned long *, efi_guid_t *);
@@ -28,7 +40,7 @@ efi_status_t efi_get_random_bytes(efi_system_table_t *sys_table_arg,
 	if (status != EFI_SUCCESS)
 		return status;
 
-	return rng->get_rng(rng, NULL, size, out);
+	return efi_call_proto(efi_rng_protocol, get_rng, rng, NULL, size, out);
 }
 
 /*
@@ -161,15 +173,16 @@ efi_status_t efi_random_get_seed(efi_system_table_t *sys_table_arg)
 	if (status != EFI_SUCCESS)
 		return status;
 
-	status = rng->get_rng(rng, &rng_algo_raw, EFI_RANDOM_SEED_SIZE,
-			      seed->bits);
+	status = efi_call_proto(efi_rng_protocol, get_rng, rng, &rng_algo_raw,
+				 EFI_RANDOM_SEED_SIZE, seed->bits);
+
 	if (status == EFI_UNSUPPORTED)
 		/*
 		 * Use whatever algorithm we have available if the raw algorithm
 		 * is not implemented.
 		 */
-		status = rng->get_rng(rng, NULL, EFI_RANDOM_SEED_SIZE,
-				      seed->bits);
+		status = efi_call_proto(efi_rng_protocol, get_rng, rng, NULL,
+					 EFI_RANDOM_SEED_SIZE, seed->bits);
 
 	if (status != EFI_SUCCESS)
 		goto err_freepool;
