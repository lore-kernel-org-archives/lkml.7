Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21875C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 06:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68DC2190F
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 06:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIuk7Q+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfIAG7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 02:59:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44272 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfIAG7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 02:59:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so5630822pgl.11
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2019 23:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ksunGhRAcBahaT7W6iFOAG/wY/nv2ICL8Nw4My/hTvE=;
        b=MIuk7Q+K0WGao5uA3+VT0F2UNG7iwCxqBSE3s47K4thfifDSTYwyUFGzXF/qoFpSBX
         z3brLVeOyzjpV8s2XT1vH+xfHi3Xk5b/bNVvYDbcL7im++/PERMrJLdfY1eTyGKvxoGa
         9eRAO748Aku/xxXieY04PW/9NSWhsVTk9dDiAesdTlqJ97ky109hWip/JU5/RI0xjc+k
         ccUjrK3gp8td295bQnEGbwoPJf29paBnNDB+dBu3QGBDo80SiWzr2U4V9dc9I5oA5oR4
         xCDChSYDqOBLbqsFNp1Db3FmpOlaJltxDG1YJPiAUxt+YmtWBB9VUPKMar0qExkrvx7D
         HfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ksunGhRAcBahaT7W6iFOAG/wY/nv2ICL8Nw4My/hTvE=;
        b=qrX/SzyuLXN3IIHuhXCEtRIY8+3is1o2blpj4BtFGEQP16lgCsORoXeAEvYRzFi5IL
         hTgIhpbH1TmadwJZn4caFaiTBomOmEd03UZO2JqgpCuVez/W7bMTe1e9q14lXC4YL+Pw
         mDsO6cadnEC/8ic+BpOMkUxJ0BYfP17KRcuyHll6jGvQUPxtuaBQDLxdS3+njAX/AMvI
         GeEUpFXyaa7tTbsxzXjDTgCBDcMvw1wYdUKj8XySxpeO/mnnHS6dte6QfjZFkkt1tSNl
         sHa/PxysY1V5xm4jjQvvLjfYalWie9bpH9pdzYS6QwKwVHfJcV9gnn0ggWM+0SwvXrSc
         ue4Q==
X-Gm-Message-State: APjAAAXVE4i4xzRh3FCOgGhWkgL4iaZkx+o72rJk5yV7Q4gpIluxbQmm
        9DdodWnZivUtWVZWbxk8R/I=
X-Google-Smtp-Source: APXvYqyw3yfPJHl7dWO6wj8ONfTdvPpAfPr2Wvs2WIpDI5auHtERzSlOOZc8ng3grq9X4d+6S+qU9g==
X-Received: by 2002:aa7:809a:: with SMTP id v26mr28118651pff.82.1567321184092;
        Sat, 31 Aug 2019 23:59:44 -0700 (PDT)
Received: from localhost.localdomain (ip-103-85-38-221.syd.xi.com.au. [103.85.38.221])
        by smtp.gmail.com with ESMTPSA id i6sm3326055pfq.20.2019.08.31.23.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 23:59:43 -0700 (PDT)
From:   Adam Zerella <adam.zerella@gmail.com>
Cc:     Adam Zerella <adam.zerella@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/xen/efi: Fix EFI variable 'name' type conversion
Date:   Sun,  1 Sep 2019 16:58:28 +1000
Message-Id: <20190901065828.7762-1-adam.zerella@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This resolves a type conversion from 'char *' to 'unsigned short'.
and static usage warning as hinted by Sparse.

Signed-off-by: Adam Zerella <adam.zerella@gmail.com>
---
 arch/x86/xen/efi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/xen/efi.c b/arch/x86/xen/efi.c
index 0d3365cb64de..1d4eff6c6f06 100644
--- a/arch/x86/xen/efi.c
+++ b/arch/x86/xen/efi.c
@@ -118,8 +118,8 @@ static enum efi_secureboot_mode xen_efi_get_secureboot(void)
 	unsigned long size;
 
 	size = sizeof(secboot);
-	status = efi.get_variable(L"SecureBoot", &efi_variable_guid,
-				  NULL, &size, &secboot);
+	status = efi.get_variable((efi_char16_t *)L"SecureBoot",
+				  &efi_variable_guid, NULL, &size, &secboot);
 
 	if (status == EFI_NOT_FOUND)
 		return efi_secureboot_mode_disabled;
@@ -128,8 +128,8 @@ static enum efi_secureboot_mode xen_efi_get_secureboot(void)
 		goto out_efi_err;
 
 	size = sizeof(setupmode);
-	status = efi.get_variable(L"SetupMode", &efi_variable_guid,
-				  NULL, &size, &setupmode);
+	status = efi.get_variable((efi_char16_t *)L"SetupMode",
+				  &efi_variable_guid, NULL, &size, &setupmode);
 
 	if (status != EFI_SUCCESS)
 		goto out_efi_err;
@@ -139,8 +139,8 @@ static enum efi_secureboot_mode xen_efi_get_secureboot(void)
 
 	/* See if a user has put the shim into insecure mode. */
 	size = sizeof(moksbstate);
-	status = efi.get_variable(L"MokSBStateRT", &shim_guid,
-				  NULL, &size, &moksbstate);
+	status = efi.get_variable((efi_char16_t *)L"MokSBStateRT",
+				  &shim_guid, NULL, &size, &moksbstate);
 
 	/* If it fails, we don't care why. Default to secure. */
 	if (status != EFI_SUCCESS)
@@ -158,7 +158,7 @@ static enum efi_secureboot_mode xen_efi_get_secureboot(void)
 	return efi_secureboot_mode_unknown;
 }
 
-void __init xen_efi_init(struct boot_params *boot_params)
+static void __init xen_efi_init(struct boot_params *boot_params)
 {
 	efi_system_table_t *efi_systab_xen;
 
-- 
2.21.0

