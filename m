Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CECC282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 11:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA03C20862
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 11:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gqFR2hJe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfEYL0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 07:26:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42847 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfEYL0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 07:26:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id l2so12364781wrb.9
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 04:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eqkbz42r/JkXQTE9JdHM5dm2nu1g0Kj971dkCS8AvjE=;
        b=gqFR2hJeFw3u2HpUwckkEXBS3nmH3rAd5ohGNgyItfKUneMiagkz0GCf+6di8LXz1k
         n/Mq3Vy9WDy8tApfAEICrVbZM1TOi/M692RmO0NyXNl5lFy2ZffOXXUQvKFKJzuQIdCK
         LmWAgBVdc8aRM8ACeRHdIRClURjrj3Y55+7Bw4EXv1xTU3fc5Fa5otRHRPEOn0Cr0VZm
         PV2hDTJuwE+n6eW9XcKNciAfa6kac2I9V5LR2/dgVAVqLK+3l11y0lKz/BSNoxTHIg84
         z6Jz43oR45LWnNrbbn/pbaL6BSC6tp8Mpii3mTTgMXWvCMKOTA7YidujFD7vdA599zW2
         yWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eqkbz42r/JkXQTE9JdHM5dm2nu1g0Kj971dkCS8AvjE=;
        b=lFXorwsOuK8xlFf/55iK8wrQA++Sa1har4CtsgxglPVisNQXWl3vEIKsUxjprVdK8T
         pRBvViuJajyXAgV2pst6jFbpjw3fG9xDS4QAS/ljVEm7wAoM+y/6G/FIbvi0yhGjPZvD
         hIgFqZaSQs8V3IT6ZoDtKWgI6fw2bBexqisvsesrebj75TUZVPScXN9YtsQmx3isIabZ
         44Gs4eRTnZkd8w7GdQFbcKuW41DYp5fRNXYV9kBFIRGKlFHmFOh0MnMHvACfQmzz++fL
         3nLnhbnWLbdqqrmlQ2MxO+S3xmxS0dNL8lgdfL5iC6x75Hg3sk8kLOHpWBNkqkux+hfc
         ZLEw==
X-Gm-Message-State: APjAAAXICKEEeZ9tnMYzSvMSDL1JA1ES7v6oS4sGO59iqpDdLu3DxgBd
        UR6u+8yM2/2YZDT1vPvJAVDD+xUIdjpZNQ==
X-Google-Smtp-Source: APXvYqxij2cl8Xak5nxfQjV4vpcP7YSzfaEmiCLsngtqKa9nIR+Zof+eXjOIOX2fxJR36Lo1BdM1fw==
X-Received: by 2002:adf:bc94:: with SMTP id g20mr14398118wrh.206.1558783564787;
        Sat, 25 May 2019 04:26:04 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:3ccc:7074:9336:6a6e])
        by smtp.gmail.com with ESMTPSA id y16sm4942010wru.28.2019.05.25.04.26.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 04:26:04 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Gen Zhang <blackgod016574@gmail.com>,
        Rob Bradford <robert.bradford@intel.com>
Subject: [PATCH 1/2] efi/x86: Add missing error handling to old_memmap 1:1 mapping code
Date:   Sat, 25 May 2019 13:25:58 +0200
Message-Id: <20190525112559.7917-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190525112559.7917-1-ard.biesheuvel@linaro.org>
References: <20190525112559.7917-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gen Zhang <blackgod016574@gmail.com>

The old_memmap flow in efi_call_phys_prolog() performs numerous memory
allocations, and either does not check for failure at all, or it does
but fails to propagate it back to the caller, which may end up calling
into the firmware with an incomplete 1:1 mapping.

So let's fix this by returning NULL from efi_call_phys_prolog() on
memory allocation failures only, and by handling this condition in the
caller. Also, clean up any half baked sets of page tables that we may
have created before returning with a NULL return value.

Note that any failure at this level will trigger a panic() two levels
up, so none of this makes a huge difference, but it is a nice cleanup
nonetheless.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
[ardb: update commit log, add efi_call_phys_epilog() call on error path]
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/platform/efi/efi.c    | 2 ++
 arch/x86/platform/efi/efi_64.c | 9 ++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index e1cb01a22fa8..a7189a3b4d70 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -85,6 +85,8 @@ static efi_status_t __init phys_efi_set_virtual_address_map(
 	pgd_t *save_pgd;
 
 	save_pgd = efi_call_phys_prolog();
+	if (!save_pgd)
+		return EFI_ABORTED;
 
 	/* Disable interrupts around EFI calls: */
 	local_irq_save(flags);
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index cf0347f61b21..08ce8177c3af 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -84,13 +84,15 @@ pgd_t * __init efi_call_phys_prolog(void)
 
 	if (!efi_enabled(EFI_OLD_MEMMAP)) {
 		efi_switch_mm(&efi_mm);
-		return NULL;
+		return efi_mm.pgd;
 	}
 
 	early_code_mapping_set_exec(1);
 
 	n_pgds = DIV_ROUND_UP((max_pfn << PAGE_SHIFT), PGDIR_SIZE);
 	save_pgd = kmalloc_array(n_pgds, sizeof(*save_pgd), GFP_KERNEL);
+	if (!save_pgd)
+		return NULL;
 
 	/*
 	 * Build 1:1 identity mapping for efi=old_map usage. Note that
@@ -138,10 +140,11 @@ pgd_t * __init efi_call_phys_prolog(void)
 		pgd_offset_k(pgd * PGDIR_SIZE)->pgd &= ~_PAGE_NX;
 	}
 
-out:
 	__flush_tlb_all();
-
 	return save_pgd;
+out:
+	efi_call_phys_epilog(save_pgd);
+	return NULL;
 }
 
 void __init efi_call_phys_epilog(pgd_t *save_pgd)
-- 
2.20.1

