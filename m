Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D50C2D0BE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 00:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FD12464D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 00:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FDTctH2C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbfLEAKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 19:10:15 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33098 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbfLEAKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 19:10:15 -0500
Received: by mail-pl1-f196.google.com with SMTP id ay6so439089plb.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 16:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AI0Sbf2qfvdip7zDaIMGaj7cN/UAI4vRqAvCejejut0=;
        b=FDTctH2CeJShcdMHsHl2Oi7MHODy229XFf1dMS36U2X/QdXpsbAtsCUC75G8Tt4iZ/
         wFsIWH/tIi6YoU802WLaDkHZFr84ABsj1X/04mTK+cDldigsFFAdsf9RjxmBi1w9DMRf
         Y3eRIoUILPqZg0xNze2z+SLJZaY99XtfVjbec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AI0Sbf2qfvdip7zDaIMGaj7cN/UAI4vRqAvCejejut0=;
        b=kA99kUbVsLte0oG6qQ7kNtfUeispZEUaNTLSl37WD31ivW/TeGZ2CS7qROgXjoDPuM
         lO6jeWSReHyk367AIR3Uhah4fCfCPApwALq00oX4jEpKE3PU/KbckDGezgLicHaL1m26
         HjI/QceMSF+mna7Pw6I53TFymJLkBH2mNVg1U8nT9pFUGr/OEBrL7vwjcz8gB3rCmWP8
         GE6kfCUpHaaGsj0CWzLJPlIsSjFh6zZqNyMZoObRxUgNQ/iETr36jzNVZdff41HuCjW8
         foI+cqYRwxDfr+iAILQ7LD58tW/7bd/DKehYbrk9ZoWsjtvfFVwn9rEuzrA4Rs0OPhx7
         ED1Q==
X-Gm-Message-State: APjAAAXfoEcB4kvlAobAy1ZeyOOKpIl2lYitScuHm3CexA7OCUwUPQES
        /NzZ0vYrpNeDbBRdvcitUf8M5w==
X-Google-Smtp-Source: APXvYqyoUG5RvODwUDikHFr0GME5meRLVDUYTKsj6+bCgJ3vbygvGSX80K/1+YC5RDXowxCFuo8yEw==
X-Received: by 2002:a17:90a:a612:: with SMTP id c18mr6163516pjq.49.1575504614402;
        Wed, 04 Dec 2019 16:10:14 -0800 (PST)
Received: from thgarnie.kir.corp.google.com ([2620:0:1008:1100:d6ba:ac27:4f7b:28d7])
        by smtp.gmail.com with ESMTPSA id 73sm8422303pgc.13.2019.12.04.16.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 16:10:14 -0800 (PST)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, keescook@chromium.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org
Subject: [PATCH v10 03/11] x86: relocate_kernel - Adapt assembly for PIE support
Date:   Wed,  4 Dec 2019 16:09:40 -0800
Message-Id: <20191205000957.112719-4-thgarnie@chromium.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
In-Reply-To: <20191205000957.112719-1-thgarnie@chromium.org>
References: <20191205000957.112719-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the assembly code to use only absolute references of symbols for the
kernel to be PIE compatible.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/relocate_kernel_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index ef3ba99068d3..c294339df5ef 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -206,7 +206,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	movq	%rax, %cr3
 	lea	PAGE_SIZE(%r8), %rsp
 	call	swap_pages
-	movq	$virtual_mapped, %rax
+	movabsq	$virtual_mapped, %rax
 	pushq	%rax
 	ret
 SYM_CODE_END(identity_mapped)
-- 
2.24.0.393.g34dc348eaf-goog

