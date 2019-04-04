Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7C3C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B7D20449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369971;
	bh=ReyITiF0yYBsidp7+YxQ4WT/NeAtQpMoh7R3bEEe9O0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Drf81MZ2jTFHL2oSRGxxjLcEVQsZfX1AchK1i8+OgFC8b4bMjExE0SGXRqdAd1/35
	 XnAsWAnoYl8W15RAkxKOc4vSW/kP7l22SzgC5CdI35F+myFnt4+E9E1nO0LsKHwC4d
	 DZkyoobaisn7Nr0i4IYOMAsAuIY5EiBPG90hHxOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733091AbfDDJNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:13:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387537AbfDDJNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:13:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7429D2075E;
        Thu,  4 Apr 2019 09:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369199;
        bh=ReyITiF0yYBsidp7+YxQ4WT/NeAtQpMoh7R3bEEe9O0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HnI2x1y+JIR/fCavkRAo19vykBSb60glDNsK/NPfxWq4tf9fybclT5JFiCb3NlNJz
         bKy4KXEVmRtuxJkW4cj1ch2F1dehfCxHTh38eIUvrl13Yc+DiPcv8ey5NEVZVSBqOt
         xxCMVTP6iCB986NOFRmKAk98HG6Bj53RszDgjhFI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 126/246] efi: Fix build error due to enum collision between efi.h and ima.h
Date:   Thu,  4 Apr 2019 10:47:06 +0200
Message-Id: <20190404084623.569776787@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 5c418dc789a3898717ebf2caa5716ba91a7150b2 ]

The following commit:

  a893ea15d764 ("tpm: move tpm_chip definition to include/linux/tpm.h")

introduced a build error when both IMA and EFI are enabled:

    In file included from ../security/integrity/ima/ima_fs.c:30:
    ../security/integrity/ima/ima.h:176:7: error: redeclaration of enumerator "NONE"

What happens is that both headers (ima.h and efi.h) defines the same
'NONE' constant, and it broke when they started getting included from
the same file:

Rework to prefix the EFI enum with 'EFI_*'.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20190215165551.12220-2-ard.biesheuvel@linaro.org
[ Cleaned up the changelog a bit. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/platform/efi/quirks.c          |  4 +--
 drivers/firmware/efi/runtime-wrappers.c | 48 ++++++++++++-------------
 include/linux/efi.h                     | 26 +++++++-------
 3 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 17456a1d3f04..6c571ae86947 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -717,7 +717,7 @@ void efi_recover_from_page_fault(unsigned long phys_addr)
 	 * "efi_mm" cannot be used to check if the page fault had occurred
 	 * in the firmware context because efi=old_map doesn't use efi_pgd.
 	 */
-	if (efi_rts_work.efi_rts_id == NONE)
+	if (efi_rts_work.efi_rts_id == EFI_NONE)
 		return;
 
 	/*
@@ -742,7 +742,7 @@ void efi_recover_from_page_fault(unsigned long phys_addr)
 	 * because this case occurs *very* rarely and hence could be improved
 	 * on a need by basis.
 	 */
-	if (efi_rts_work.efi_rts_id == RESET_SYSTEM) {
+	if (efi_rts_work.efi_rts_id == EFI_RESET_SYSTEM) {
 		pr_info("efi_reset_system() buggy! Reboot through BIOS\n");
 		machine_real_restart(MRR_BIOS);
 		return;
diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index e2abfdb5cee6..698745c249e8 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -85,7 +85,7 @@ struct efi_runtime_work efi_rts_work;
 		pr_err("Failed to queue work to efi_rts_wq.\n");	\
 									\
 exit:									\
-	efi_rts_work.efi_rts_id = NONE;					\
+	efi_rts_work.efi_rts_id = EFI_NONE;				\
 	efi_rts_work.status;						\
 })
 
@@ -175,50 +175,50 @@ static void efi_call_rts(struct work_struct *work)
 	arg5 = efi_rts_work.arg5;
 
 	switch (efi_rts_work.efi_rts_id) {
-	case GET_TIME:
+	case EFI_GET_TIME:
 		status = efi_call_virt(get_time, (efi_time_t *)arg1,
 				       (efi_time_cap_t *)arg2);
 		break;
-	case SET_TIME:
+	case EFI_SET_TIME:
 		status = efi_call_virt(set_time, (efi_time_t *)arg1);
 		break;
-	case GET_WAKEUP_TIME:
+	case EFI_GET_WAKEUP_TIME:
 		status = efi_call_virt(get_wakeup_time, (efi_bool_t *)arg1,
 				       (efi_bool_t *)arg2, (efi_time_t *)arg3);
 		break;
-	case SET_WAKEUP_TIME:
+	case EFI_SET_WAKEUP_TIME:
 		status = efi_call_virt(set_wakeup_time, *(efi_bool_t *)arg1,
 				       (efi_time_t *)arg2);
 		break;
-	case GET_VARIABLE:
+	case EFI_GET_VARIABLE:
 		status = efi_call_virt(get_variable, (efi_char16_t *)arg1,
 				       (efi_guid_t *)arg2, (u32 *)arg3,
 				       (unsigned long *)arg4, (void *)arg5);
 		break;
-	case GET_NEXT_VARIABLE:
+	case EFI_GET_NEXT_VARIABLE:
 		status = efi_call_virt(get_next_variable, (unsigned long *)arg1,
 				       (efi_char16_t *)arg2,
 				       (efi_guid_t *)arg3);
 		break;
-	case SET_VARIABLE:
+	case EFI_SET_VARIABLE:
 		status = efi_call_virt(set_variable, (efi_char16_t *)arg1,
 				       (efi_guid_t *)arg2, *(u32 *)arg3,
 				       *(unsigned long *)arg4, (void *)arg5);
 		break;
-	case QUERY_VARIABLE_INFO:
+	case EFI_QUERY_VARIABLE_INFO:
 		status = efi_call_virt(query_variable_info, *(u32 *)arg1,
 				       (u64 *)arg2, (u64 *)arg3, (u64 *)arg4);
 		break;
-	case GET_NEXT_HIGH_MONO_COUNT:
+	case EFI_GET_NEXT_HIGH_MONO_COUNT:
 		status = efi_call_virt(get_next_high_mono_count, (u32 *)arg1);
 		break;
-	case UPDATE_CAPSULE:
+	case EFI_UPDATE_CAPSULE:
 		status = efi_call_virt(update_capsule,
 				       (efi_capsule_header_t **)arg1,
 				       *(unsigned long *)arg2,
 				       *(unsigned long *)arg3);
 		break;
-	case QUERY_CAPSULE_CAPS:
+	case EFI_QUERY_CAPSULE_CAPS:
 		status = efi_call_virt(query_capsule_caps,
 				       (efi_capsule_header_t **)arg1,
 				       *(unsigned long *)arg2, (u64 *)arg3,
@@ -242,7 +242,7 @@ static efi_status_t virt_efi_get_time(efi_time_t *tm, efi_time_cap_t *tc)
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(GET_TIME, tm, tc, NULL, NULL, NULL);
+	status = efi_queue_work(EFI_GET_TIME, tm, tc, NULL, NULL, NULL);
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -253,7 +253,7 @@ static efi_status_t virt_efi_set_time(efi_time_t *tm)
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(SET_TIME, tm, NULL, NULL, NULL, NULL);
+	status = efi_queue_work(EFI_SET_TIME, tm, NULL, NULL, NULL, NULL);
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -266,7 +266,7 @@ static efi_status_t virt_efi_get_wakeup_time(efi_bool_t *enabled,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(GET_WAKEUP_TIME, enabled, pending, tm, NULL,
+	status = efi_queue_work(EFI_GET_WAKEUP_TIME, enabled, pending, tm, NULL,
 				NULL);
 	up(&efi_runtime_lock);
 	return status;
@@ -278,7 +278,7 @@ static efi_status_t virt_efi_set_wakeup_time(efi_bool_t enabled, efi_time_t *tm)
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(SET_WAKEUP_TIME, &enabled, tm, NULL, NULL,
+	status = efi_queue_work(EFI_SET_WAKEUP_TIME, &enabled, tm, NULL, NULL,
 				NULL);
 	up(&efi_runtime_lock);
 	return status;
@@ -294,7 +294,7 @@ static efi_status_t virt_efi_get_variable(efi_char16_t *name,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(GET_VARIABLE, name, vendor, attr, data_size,
+	status = efi_queue_work(EFI_GET_VARIABLE, name, vendor, attr, data_size,
 				data);
 	up(&efi_runtime_lock);
 	return status;
@@ -308,7 +308,7 @@ static efi_status_t virt_efi_get_next_variable(unsigned long *name_size,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(GET_NEXT_VARIABLE, name_size, name, vendor,
+	status = efi_queue_work(EFI_GET_NEXT_VARIABLE, name_size, name, vendor,
 				NULL, NULL);
 	up(&efi_runtime_lock);
 	return status;
@@ -324,7 +324,7 @@ static efi_status_t virt_efi_set_variable(efi_char16_t *name,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(SET_VARIABLE, name, vendor, &attr, &data_size,
+	status = efi_queue_work(EFI_SET_VARIABLE, name, vendor, &attr, &data_size,
 				data);
 	up(&efi_runtime_lock);
 	return status;
@@ -359,7 +359,7 @@ static efi_status_t virt_efi_query_variable_info(u32 attr,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(QUERY_VARIABLE_INFO, &attr, storage_space,
+	status = efi_queue_work(EFI_QUERY_VARIABLE_INFO, &attr, storage_space,
 				remaining_space, max_variable_size, NULL);
 	up(&efi_runtime_lock);
 	return status;
@@ -391,7 +391,7 @@ static efi_status_t virt_efi_get_next_high_mono_count(u32 *count)
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(GET_NEXT_HIGH_MONO_COUNT, count, NULL, NULL,
+	status = efi_queue_work(EFI_GET_NEXT_HIGH_MONO_COUNT, count, NULL, NULL,
 				NULL, NULL);
 	up(&efi_runtime_lock);
 	return status;
@@ -407,7 +407,7 @@ static void virt_efi_reset_system(int reset_type,
 			"could not get exclusive access to the firmware\n");
 		return;
 	}
-	efi_rts_work.efi_rts_id = RESET_SYSTEM;
+	efi_rts_work.efi_rts_id = EFI_RESET_SYSTEM;
 	__efi_call_virt(reset_system, reset_type, status, data_size, data);
 	up(&efi_runtime_lock);
 }
@@ -423,7 +423,7 @@ static efi_status_t virt_efi_update_capsule(efi_capsule_header_t **capsules,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(UPDATE_CAPSULE, capsules, &count, &sg_list,
+	status = efi_queue_work(EFI_UPDATE_CAPSULE, capsules, &count, &sg_list,
 				NULL, NULL);
 	up(&efi_runtime_lock);
 	return status;
@@ -441,7 +441,7 @@ static efi_status_t virt_efi_query_capsule_caps(efi_capsule_header_t **capsules,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(QUERY_CAPSULE_CAPS, capsules, &count,
+	status = efi_queue_work(EFI_QUERY_CAPSULE_CAPS, capsules, &count,
 				max_size, reset_type, NULL);
 	up(&efi_runtime_lock);
 	return status;
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 28604a8d0aa9..a86485ac7c87 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1699,19 +1699,19 @@ extern int efi_tpm_eventlog_init(void);
  * fault happened while executing an efi runtime service.
  */
 enum efi_rts_ids {
-	NONE,
-	GET_TIME,
-	SET_TIME,
-	GET_WAKEUP_TIME,
-	SET_WAKEUP_TIME,
-	GET_VARIABLE,
-	GET_NEXT_VARIABLE,
-	SET_VARIABLE,
-	QUERY_VARIABLE_INFO,
-	GET_NEXT_HIGH_MONO_COUNT,
-	RESET_SYSTEM,
-	UPDATE_CAPSULE,
-	QUERY_CAPSULE_CAPS,
+	EFI_NONE,
+	EFI_GET_TIME,
+	EFI_SET_TIME,
+	EFI_GET_WAKEUP_TIME,
+	EFI_SET_WAKEUP_TIME,
+	EFI_GET_VARIABLE,
+	EFI_GET_NEXT_VARIABLE,
+	EFI_SET_VARIABLE,
+	EFI_QUERY_VARIABLE_INFO,
+	EFI_GET_NEXT_HIGH_MONO_COUNT,
+	EFI_RESET_SYSTEM,
+	EFI_UPDATE_CAPSULE,
+	EFI_QUERY_CAPSULE_CAPS,
 };
 
 /*
-- 
2.19.1



