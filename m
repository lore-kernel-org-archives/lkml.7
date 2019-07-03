Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5802DC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2A7218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J23ACrWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfGCNTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:19:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45512 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfGCNTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 09:19:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id o13so1231932pgp.12;
        Wed, 03 Jul 2019 06:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Cs/Y84YOYpwUFwCANMN2rSejLTzy8FhytWYeNxufTp4=;
        b=J23ACrWnvxU6RVchPSS8D1IZ0X5EqqEdAtBCpEeFfjySsLy8eOUlRZ2Ib9e8kfkIAI
         4hPrjfBkURFnS5xXyguQjHab8UJz08M4GICEikAnf8C4HVhtflZwe+iEAyI916Bp7xCp
         Uyy5HafGi/CMbBf9/hMeX3Wy+ypJ1SCuiTTeif5nIVFJwtWVChnzkWEnZ8yQej/u+X+5
         ipQNmubxRyJqPisyZUi1W+eCBYR6JJ6Oq8KLh9//MfIv4z0kBsghzzqTmDDzelzGL9Oq
         5KpxxynGrsvqaoUdcbJboG1FgfvryROvJOftCwi1G1O+305fAL5pQGfGiWiMrrLzWdat
         YNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Cs/Y84YOYpwUFwCANMN2rSejLTzy8FhytWYeNxufTp4=;
        b=T6lx0jxDtQlSXc/hVUaoltl2TACKgB/FbjKlNtOJIhjcVzC5vVd/aMK6g5DLyQktz7
         r7QIhUMuOO8qRI5OGoAJKX84Eg6qHDqfse//Oj447bUFyC+yen28PQoHkFO72wY263ib
         bRd19Fy54n9peaFbYjCb+acuKqx0WCkgz9qM73IWmGOMm5jHo7C9H9DLtIuDEHyfLlvf
         afwnZnUmpDTTC4rxHGBM9egqlzd1WlXgnuDRQgN8NGBxdF3uDf1B/Wjk7cC9RKLuywc3
         o93Z392bAHddvotwVGRgAGPeipotcteY6FFs2VtcP0F1zh1C+N2o5kDPyQji1TMWrIJa
         H3VQ==
X-Gm-Message-State: APjAAAVI38/R3t7K3/6/W62ndV2kZcU+02n6OnmtuKwD3dUq0P5bRWuT
        8sw/PlqzfxenSHxbImZTlQA=
X-Google-Smtp-Source: APXvYqzPzysZ56Q6AcFY7zWWlRoN9Qnz+WihOdMtsntXZEjXPv/4u6YfQKqJ2lTQ4mZOBwJWEXmxiw==
X-Received: by 2002:a63:b346:: with SMTP id x6mr20061918pgt.218.1562159957588;
        Wed, 03 Jul 2019 06:19:17 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id 135sm2534772pfb.137.2019.07.03.06.19.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 06:19:17 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        ibm-acpi-devel@lists.sourceforge.net,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 19/30] platform/x86: Use kmemdup rather than duplicating its implementation
Date:   Wed,  3 Jul 2019 21:19:08 +0800
Message-Id: <20190703131908.26138-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memset, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memset.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/platform/x86/asus-wmi.c      |  3 +--
 drivers/platform/x86/thinkpad_acpi.c | 17 +++++++----------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 9b18a184e0aa..472b317ad814 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -260,12 +260,11 @@ static int asus_wmi_evaluate_method_agfn(const struct acpi_buffer args)
 	 * Copy to dma capable address otherwise memory corruption occurs as
 	 * bios has to be able to access it.
 	 */
-	input.pointer = kzalloc(args.length, GFP_DMA | GFP_KERNEL);
+	input.pointer = kmemdup(args.pointer, args.length, GFP_DMA | GFP_KERNEL);
 	input.length = args.length;
 	if (!input.pointer)
 		return -ENOMEM;
 	phys_addr = virt_to_phys(input.pointer);
-	memcpy(input.pointer, args.pointer, args.length);
 
 	status = asus_wmi_evaluate_method(ASUS_WMI_METHODID_AGFN,
 					phys_addr, 0, &retval);
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 7bde4640ef34..d379bdf98a0f 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -3647,22 +3647,19 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		goto err_exit;
 
 	/* Set up key map */
-	hotkey_keycode_map = kmalloc(TPACPI_HOTKEY_MAP_SIZE,
-					GFP_KERNEL);
-	if (!hotkey_keycode_map) {
-		pr_err("failed to allocate memory for key map\n");
-		res = -ENOMEM;
-		goto err_exit;
-	}
-
 	keymap_id = tpacpi_check_quirks(tpacpi_keymap_qtable,
 					ARRAY_SIZE(tpacpi_keymap_qtable));
 	BUG_ON(keymap_id >= ARRAY_SIZE(tpacpi_keymaps));
 	dbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_HKEY,
 		   "using keymap number %lu\n", keymap_id);
 
-	memcpy(hotkey_keycode_map, &tpacpi_keymaps[keymap_id],
-		TPACPI_HOTKEY_MAP_SIZE);
+	hotkey_keycode_map = kmemdup(&tpacpi_keymaps[keymap_id],
+			TPACPI_HOTKEY_MAP_SIZE,	GFP_KERNEL);
+	if (!hotkey_keycode_map) {
+		pr_err("failed to allocate memory for key map\n");
+		res = -ENOMEM;
+		goto err_exit;
+	}
 
 	input_set_capability(tpacpi_inputdev, EV_MSC, MSC_SCAN);
 	tpacpi_inputdev->keycodesize = TPACPI_HOTKEY_MAP_TYPESIZE;
-- 
2.11.0

