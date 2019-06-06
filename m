Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DF2C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 05:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FCE720717
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 05:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9UBJC79"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfFFFZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 01:25:20 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45863 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfFFFZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 01:25:19 -0400
Received: by mail-ed1-f65.google.com with SMTP id f20so1413736edt.12;
        Wed, 05 Jun 2019 22:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=00NtuWrsyVE2KaeNTYmLsj1+sMztB1U/+E3rdIAWfoU=;
        b=S9UBJC79AUUuxGmaiRcKs1KBmR+FQxOYnPg1ybmLiy4r+DM7o4R1nsKuoT7DdZ6zQ0
         bUOVTmyssgFsIeLCANJVMu2GUu7RePlJen7eGEy6PJqipw5ZuQ6yocsSQf9fwHNl0dw1
         uKi2I31hFPCU8cGiscI1ujvm6miI+XM48dLmJ6f7JI+AXlxxfXQWFkwHdpbHZNDSgKn7
         G6iLulx8TS/7Zv1naUbOSgl9ioxjh0D8fHRFRv8tgJYUYNebPWH4Ej81GQvdgH1EshA9
         Bxv1D42tXchE7if5hzcHRbekyoyhAODClLMkHdrjP/q/JrgMw0cc5IwYS8blzSbscIQa
         wJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=00NtuWrsyVE2KaeNTYmLsj1+sMztB1U/+E3rdIAWfoU=;
        b=AogXqyqfyG8FgdHAHTYg+K63iDOIBxvXfjIaZxbgthxGcbsxeoOg4JIL8OKSK0e+1Y
         KUDsmCXFkdVpGB7YRBJrBSuy1cZo2I58FnvoshO/20nn24wY5nNyhRPfkZRHCvmOM3X6
         A6hBQC3kc6faXOS51jtBR8AlB0HsHiQxZGuQmunABMZ26iZpcDfdrUBj715L3fPkiGJU
         i8NggIArNffQ6lciAr09dPtvxj3fEGcREisAbFHIcSUzUtngaDjWVjqN4SMX/hMxU3w8
         Cnqz0rho8BBsZJJHdyL2H10XzP148eOOfj6ZzCVJtgAwsfKga75R9IScltkXjlJArtC/
         GwWA==
X-Gm-Message-State: APjAAAVDHN2veljkALl3LihcZeyBE5Uju/xBcSXIG/rpEOgCC3v9ax2a
        zMlA7bbIHDMI+qUusaXzCHAR/4VgA/yZag==
X-Google-Smtp-Source: APXvYqzvN1C5Um10JFTSp44SXvalblF76jxPtN7XH4o21Iaclk0+91EW571GWRnvnr1dC+WmzDziOw==
X-Received: by 2002:a50:cb0a:: with SMTP id g10mr16209469edi.273.1559798718078;
        Wed, 05 Jun 2019 22:25:18 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id s22sm186260edm.78.2019.06.05.22.25.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 05 Jun 2019 22:25:17 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] scsi: lpfc: Avoid unused function warnings
Date:   Wed,  5 Jun 2019 22:24:21 -0700
Message-Id: <20190606052421.103469-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.22.0.rc3
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building powerpc pseries_defconfig or powernv_defconfig:

drivers/scsi/lpfc/lpfc_nvmet.c:224:1: error: unused function
'lpfc_nvmet_get_ctx_for_xri' [-Werror,-Wunused-function]
drivers/scsi/lpfc/lpfc_nvmet.c:246:1: error: unused function
'lpfc_nvmet_get_ctx_for_oxid' [-Werror,-Wunused-function]

These functions are only compiled when CONFIG_NVME_TARGET_FC is enabled.
Use that same condition so there is no more warning. While the fixes
commit did not introduce these functions, it caused these warnings.

Fixes: 4064b27417a7 ("scsi: lpfc: Make some symbols static")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/scsi/lpfc/lpfc_nvmet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index e471bbcca838..f3d9a5545164 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -220,6 +220,7 @@ lpfc_nvmet_cmd_template(void)
 	/* Word 12, 13, 14, 15 - is zero */
 }
 
+#if (IS_ENABLED(CONFIG_NVME_TARGET_FC))
 static struct lpfc_nvmet_rcv_ctx *
 lpfc_nvmet_get_ctx_for_xri(struct lpfc_hba *phba, u16 xri)
 {
@@ -263,6 +264,7 @@ lpfc_nvmet_get_ctx_for_oxid(struct lpfc_hba *phba, u16 oxid, u32 sid)
 
 	return NULL;
 }
+#endif
 
 static void
 lpfc_nvmet_defer_release(struct lpfc_hba *phba, struct lpfc_nvmet_rcv_ctx *ctxp)
-- 
2.22.0.rc3

