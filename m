Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13FFECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83EF120854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="DGre7ope"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394634AbfJPUCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 16:02:06 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37684 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436816AbfJPUAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 16:00:42 -0400
Received: by mail-qk1-f193.google.com with SMTP id u184so23999791qkd.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 13:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=T4oxSJQXJFiY001HVXtMhV4c1Nyh6Voq/S19Iap3z4U=;
        b=DGre7ope1z/85rJPZ4IFjlhOm3YBsexLNt4OvsWWWOLkWgwpsaJIM1pD6dhXAvTH/R
         SfQobt9L6NpsyIeGpWCeql3qSX/KVIo4W9kEozA8Zi9G5eq4JBzcOExg6eBteqdmzgky
         lEOeY0V8KSCmNj6cq5taZ9NDiiobXDnV2YEFB6EqqlLi2InV8v3IT4yFCcQS2m8MEIjb
         IvEEJWKzBIknz04aeOVYCxcWFTQEZF9ob2eKJ1FWdigupZeVnmgr/C4pTJMF3F34Cxmk
         7MbPPMmEg+vmDYF4We/tyX6V6e4RnPYMNs3H6NXSZ/cscrc6DqxNmz4UwntpX/VVatui
         dMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T4oxSJQXJFiY001HVXtMhV4c1Nyh6Voq/S19Iap3z4U=;
        b=mPep7Jt9TcgWO+WF7VL+nVb/nazA/vW6CMWaKusGaSrzpNHOiULG22Frdl9YlXHrKM
         E0rjdSsaGcsthOlp0c6axzB/nZYCvBhzSyYzAznjhMJm0cfVk7opqEovTtyTwRmcRIh4
         W6H1/yKHiHG3awbJEGz1Vdr/DMhgJs1sQTx5eFGBPjfxhHVDty+jOGDpS7GI/5ytMqLg
         WXdW0n5KvnqpaH968kVrEmgILWkNb6RxaD5C7Iqkr09KJT9myNSKoNxr1banzItqDoGp
         1D5Ut6wVCRLNzH/XVpWEtkvAe4Zh5Qv8FS2vhoOi3QAB7RXGfQE9yG1RmFeKgmYNffpl
         sh4w==
X-Gm-Message-State: APjAAAWOPkZ3kMrN9/lMrdU/YR/ltQN9okjeDK6i4XQU+YDIinG+zB/h
        Y2Is8fw/rbUEFHxgxIo860GMoQ==
X-Google-Smtp-Source: APXvYqzmh9ZVCm734DDic0+RycCb/gxkGIXhQmNPGS2Audv6J5EXJ/l4r8dVf285F5TVgxAglBRtkQ==
X-Received: by 2002:a37:8183:: with SMTP id c125mr29289075qkd.279.1571256041916;
        Wed, 16 Oct 2019 13:00:41 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id c204sm13342030qkb.90.2019.10.16.13.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:00:41 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com,
        tglx@linutronix.de
Subject: [PATCH v7 03/25] arm64: kexec: remove unnecessary debug prints
Date:   Wed, 16 Oct 2019 16:00:12 -0400
Message-Id: <20191016200034.1342308-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
References: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kexec_image_info() outputs all the necessary information about the
upcoming kexec. The extra debug printfs in machine_kexec() are not
needed.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/machine_kexec.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 0df8493624e0..8e9c924423b4 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -160,18 +160,6 @@ void machine_kexec(struct kimage *kimage)
 
 	kexec_image_info(kimage);
 
-	pr_debug("%s:%d: control_code_page:        %p\n", __func__, __LINE__,
-		kimage->control_code_page);
-	pr_debug("%s:%d: reboot_code_buffer_phys:  %pa\n", __func__, __LINE__,
-		&reboot_code_buffer_phys);
-	pr_debug("%s:%d: reboot_code_buffer:       %p\n", __func__, __LINE__,
-		reboot_code_buffer);
-	pr_debug("%s:%d: relocate_new_kernel:      %p\n", __func__, __LINE__,
-		arm64_relocate_new_kernel);
-	pr_debug("%s:%d: relocate_new_kernel_size: 0x%lx(%lu) bytes\n",
-		__func__, __LINE__, arm64_relocate_new_kernel_size,
-		arm64_relocate_new_kernel_size);
-
 	/*
 	 * Copy arm64_relocate_new_kernel to the reboot_code_buffer for use
 	 * after the kernel is shut down.
-- 
2.23.0

