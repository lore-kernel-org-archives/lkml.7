Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04A6C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDAF0206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hBwOt1KY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfDBV4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:56:12 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:50843 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfDBV4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 17:56:10 -0400
Received: by mail-vk1-f201.google.com with SMTP id k78so7058038vkk.17
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 14:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xAnLkZL1jyDU4wUU0qf3ZAhpM4BKPDzENsbu9cKQ3gk=;
        b=hBwOt1KY/S2uIniM4uFql4vhJq1+I+SV0JwBPnd6cpnh5u70Q0egl+Pda6RtRrk4G9
         XryZ14ijBJwA90CttJ9xqQr6MT9kqr4AEkbbh+8ZUJd2jF63Lv8fYLSIRyjaO1hFTaHe
         qypGhs4EgIN1eTJKz/p/VN/BhNNnmpZk50RIDbb5H0nB+IHXMnULLix0LEuMkhkpJUzh
         GoA0tqd6LYz52L1efoenVNY0J/7oyv2FpYrLzz9oQrdAnINEU8S4uowwVAoMDh/9tTLk
         R5oWdSWJ83ZoR9Jz9MSFKG5Lo3ikcvUfQTS1yQlu1lsTwFAQWs764Z/15Hp1WYjPxPhr
         RpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xAnLkZL1jyDU4wUU0qf3ZAhpM4BKPDzENsbu9cKQ3gk=;
        b=tNnvugmFS/UjJ/bKTbop9kP1mizWahjlimwbR8Z/TCxylBQ4AZh+dkKPdj4Kn9aZNl
         6iG2rpvFktrMwdJDlNqxVtxViRBpCOxaOJkWimCzUcK63G95mBJGYBR4usRdanI+akEg
         IJKgPPRt6CwIxt1fOjxM52ARXuNJmWBSAKaJ7AdxxYlgV532lVbQ1eUPvP3Ekx6uk/uK
         Ty2Afb6fd6gJ0UJP/4K+btfC7taLOA5g1Nw6qcobVqzYiJEwmD6n4zvJakhUoIIKciMT
         HGVA4jZRV8Nj8Ap3T9oQIrqkE+T0Q2N43byGDy6ta+Cu5BPBZHXrDyBAfl8FonMdkfIZ
         cD9w==
X-Gm-Message-State: APjAAAUt5+bYTgn0cscy8CeTxhdPIEKqxN+1gxI2mjM2xpQulu9yzRg2
        EmgkPKSm8vLJUixHbix4+1aR8yjdwq+7ZhIn6mEm5g==
X-Google-Smtp-Source: APXvYqwrNJFsd5Ezw4ZaFEPU/r7zZ4SKNLVE1WTRINE8K7foX3ow2e4EGMGfbGf0SXKgkqqpmznTS0V0FljbkM8yyeWxKA==
X-Received: by 2002:a67:e295:: with SMTP id g21mr8830432vsf.24.1554242168324;
 Tue, 02 Apr 2019 14:56:08 -0700 (PDT)
Date:   Tue,  2 Apr 2019 14:55:56 -0700
In-Reply-To: <20190402215556.257406-1-matthewgarrett@google.com>
Message-Id: <20190402215556.257406-3-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190402215556.257406-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 2/2] tpm: Fix builds on platforms that lack early_memremap()
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        roberto.sassu@huawei.com, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tweek@google.com,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On EFI systems, __calc_tpm2_event_size() needs to be able to map tables
at early boot time in order to extract information from them.
Unfortunately this interacts badly with other architectures that don't
provide the early_memremap() interface but which may still have other
mechanisms for obtaining crypto-agile logs. Abstract this away so we
can avoid the need for two implementations while still avoiding breakage
on architectures that don't require remapping of the table.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 drivers/firmware/efi/tpm.c   |  3 +++
 include/linux/tpm_eventlog.h | 32 ++++++++++++++++++++------------
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index f2a13cbb8688..fe48150f06d1 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -4,6 +4,9 @@
  *     Thiebaud Weksteen <tweek@google.com>
  */
 
+#define TPM_MEMREMAP(start, size) early_memremap(start, size)
+#define TPM_MEMUNMAP(start, size) early_memunmap(start, size)
+
 #include <linux/efi.h>
 #include <linux/init.h>
 #include <linux/memblock.h>
diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index d889e12047d9..0ca27bc053af 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -128,6 +128,14 @@ struct tcg_algorithm_info {
 	struct tcg_algorithm_size digest_sizes[];
 };
 
+#ifndef TPM_MEMREMAP
+#define TPM_MEMREMAP(start, size) NULL
+#endif
+
+#ifndef TPM_MEMUNMAP
+#define TPM_MEMUNMAP(start, size) do{} while(0)
+#endif
+
 /**
  * __calc_tpm2_event_size - calculate the size of a TPM2 event log entry
  * @event:        Pointer to the event whose size should be calculated
@@ -171,8 +179,8 @@ static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 	/* Map the event header */
 	if (do_mapping) {
 		mapping_size = marker - marker_start;
-		mapping = early_memremap((unsigned long)marker_start,
-					 mapping_size);
+		mapping = TPM_MEMREMAP((unsigned long)marker_start,
+				       mapping_size);
 		if (!mapping) {
 			size = 0;
 			goto out;
@@ -192,10 +200,10 @@ static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 
 		/* Map the digest's algorithm identifier */
 		if (do_mapping) {
-			early_memunmap(mapping, mapping_size);
+			TPM_MEMUNMAP(mapping, mapping_size);
 			mapping_size = marker - marker_start + halg_size;
-			mapping = early_memremap((unsigned long)marker_start,
-						 mapping_size);
+			mapping = TPM_MEMREMAP((unsigned long)marker_start,
+					       mapping_size);
 			if (!mapping) {
 				size = 0;
 				goto out;
@@ -212,10 +220,10 @@ static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 
 				/* Map the digest content itself */
 				if (do_mapping) {
-					early_memunmap(mapping, mapping_size);
+					TPM_MEMUNMAP(mapping, mapping_size);
 					mapping_size = marker - marker_start;
-					mapping = early_memremap((unsigned long)marker_start,
-						      mapping_size);
+					mapping = TPM_MEMREMAP((unsigned long)marker_start,
+							       mapping_size);
 					if (!mapping) {
 						size = 0;
 						goto out;
@@ -238,10 +246,10 @@ static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 	 * we don't need to map it
 	 */
 	if (do_mapping) {
-		early_memunmap(marker_start, mapping_size);
+		TPM_MEMUNMAP(marker_start, mapping_size);
 		mapping_size += sizeof(event_field->event_size);
-		mapping = early_memremap((unsigned long)marker_start,
-					 mapping_size);
+		mapping = TPM_MEMREMAP((unsigned long)marker_start,
+				       mapping_size);
 		if (!mapping) {
 			size = 0;
 			goto out;
@@ -256,7 +264,7 @@ static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 		size = 0;
 out:
 	if (do_mapping)
-		early_memunmap(mapping, mapping_size);
+		TPM_MEMUNMAP(mapping, mapping_size);
 	return size;
 }
 
-- 
2.21.0.392.gf8f6787159e-goog

