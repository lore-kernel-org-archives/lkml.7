Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59CEC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 10:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2FF20715
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 10:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBhghe/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfKPKdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 05:33:36 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40003 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfKPKdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 05:33:35 -0500
Received: by mail-wr1-f68.google.com with SMTP id q15so851756wrw.7
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2019 02:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fL8qsLGBM/IPR09zWS//pHasnl5f9Z89rLX6wisoxpA=;
        b=TBhghe/vbOYFS/uL4Dy5rLFlGWL5LiiXZGZHJXvCX/LyJpJWBY6QoUFwdlLtIhoQd6
         nyTiuxYNQ91iJtVGJH4pIEgTcLD/M8S1U4f84qw6j04M0MGFV+7tbm7m+Bgqx/DUypLu
         aqN0QKgITHOk9SoQmEiytOB8DfNLEh1W4R7woa6+wVguqDdK+EeaT6PO6SD6CeTy6RI/
         ygeNVbt+AHhuDiMOBhXRjSbQnViJWNfqdmKNUvO5g7TMHzXe+Z0hwSy5wFA5yFvoduuw
         t5Pf/PZ0XlqgWE5GPB0JMXKQLI1rO0IQPsmC65JGE4IY7Mt4IJmBY/UIC3JxkuOzlKQw
         Gc/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fL8qsLGBM/IPR09zWS//pHasnl5f9Z89rLX6wisoxpA=;
        b=j54x/+gqFGhlUaxVOlsmYxhHSxBPiqYQ1mOc2M/bUIMLHdg7wVAgGkqdBssnwlCto8
         K5Btk6bUrJrP1GLjFhf4j2WZ3R+C4WBETQHgoKB9LocFntu3SrfSVt1D7T4MtopA7b75
         8s0EMBR0Z2a9xmJEcD/Ne0KwjMbU1/WYp+umHKREEWXoOCtxHQhuYDAB7rlSKxfkccJL
         zDhL+ivsU2x+DqUYTEkh5RmD+H9LqjFHe9TGUeXoBgoMB4TcWfUM5Y+nDwZugFeK5ETw
         giLlGEETf9tSfUhCF8ieHGVC3mKdrGE77rCl9YiH/C54Mwr7QvpOFZHPTkg1YVjBYhm1
         o/PA==
X-Gm-Message-State: APjAAAWqx1n+TtyKsOezhfG7uw5suPrQYt87xdajooB9EIYko98rhSMR
        42fDXTdhY0siUgfUsB8mWnh828hbjsg=
X-Google-Smtp-Source: APXvYqwaHgQXVHhsknYTntlZp7XJSoEPrduFM2tzyZxSUQj9oq3ZtYk+KJ9586R11tsBbQ1lahxQuQ==
X-Received: by 2002:adf:f20d:: with SMTP id p13mr19164875wro.325.1573900413478;
        Sat, 16 Nov 2019 02:33:33 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id t14sm14680522wrw.87.2019.11.16.02.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2019 02:33:32 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 2/3] habanalabs: use defines for F/W files
Date:   Sat, 16 Nov 2019 12:33:28 +0200
Message-Id: <20191116103329.30171-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191116103329.30171-1-oded.gabbay@gmail.com>
References: <20191116103329.30171-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the code more concise and maintainable by using defines for the F/W
files.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 70bdaeffb6ce..c8d16aa4382c 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -72,6 +72,9 @@
  *
  */
 
+#define GOYA_UBOOT_FW_FILE	"habanalabs/goya/goya-u-boot.bin"
+#define GOYA_LINUX_FW_FILE	"habanalabs/goya/goya-fit.itb"
+
 #define GOYA_MMU_REGS_NUM		63
 
 #define GOYA_DMA_POOL_BLK_SIZE		0x100		/* 256 bytes */
@@ -2163,13 +2166,11 @@ static void goya_halt_engines(struct hl_device *hdev, bool hard_reset)
  */
 static int goya_push_uboot_to_device(struct hl_device *hdev)
 {
-	char fw_name[200];
 	void __iomem *dst;
 
-	snprintf(fw_name, sizeof(fw_name), "habanalabs/goya/goya-u-boot.bin");
 	dst = hdev->pcie_bar[SRAM_CFG_BAR_ID] + UBOOT_FW_OFFSET;
 
-	return hl_fw_push_fw_to_device(hdev, fw_name, dst);
+	return hl_fw_push_fw_to_device(hdev, GOYA_UBOOT_FW_FILE, dst);
 }
 
 /*
@@ -2182,13 +2183,11 @@ static int goya_push_uboot_to_device(struct hl_device *hdev)
  */
 static int goya_push_linux_to_device(struct hl_device *hdev)
 {
-	char fw_name[200];
 	void __iomem *dst;
 
-	snprintf(fw_name, sizeof(fw_name), "habanalabs/goya/goya-fit.itb");
 	dst = hdev->pcie_bar[DDR_BAR_ID] + LINUX_FW_OFFSET;
 
-	return hl_fw_push_fw_to_device(hdev, fw_name, dst);
+	return hl_fw_push_fw_to_device(hdev, GOYA_LINUX_FW_FILE, dst);
 }
 
 static int goya_pldm_init_cpu(struct hl_device *hdev)
-- 
2.17.1

