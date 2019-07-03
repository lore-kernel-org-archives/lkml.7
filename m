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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02750C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A95218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kx0wPTrc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfGCQaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:30:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46856 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbfGCQaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:30:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id i8so1489047pgm.13;
        Wed, 03 Jul 2019 09:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8vT0mfR2GNkvHjYV2pbjuzPVgpp8xs4SB4sEHl7CaRA=;
        b=kx0wPTrc2qiUrFAwu6YY/fKpxkiToJb1a/2rR7xQfhMyqlFaWjbSkL13ddzzplS8wW
         GBtnCA7hkWepaISJyY9C4B4GJg8u4OyGVKdujPApHefuEvA2NcQf/FzKUU5+xrLHM8HV
         /asOjh6Yb4xEs9WSmwbIlRCNINZBbr6ZHhNiyXyBBz4YYNTUU66wzO/6tR0svQaV2y7G
         F57hajGr20qQ08Sg8iA3m6VyBKVEuT30a8JSRc5daO+NJACqoJ+XdBWx8R8izv6ne3Yt
         +TtpCtjAAOc4w7UDoRPGEvsf6h4aKq3KapatQQso0bAHEScEeCrn7tfKD0uRcR1gMgju
         vojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8vT0mfR2GNkvHjYV2pbjuzPVgpp8xs4SB4sEHl7CaRA=;
        b=mCWHxOma8V/ft6LVWn+XPSFXbQdrp7OjBsY9mvfw34hP4Y0RjnYQ0ns43xOhdOGCvg
         p/HFwfRnGqM6B9vJzvEWrc7wsPx6GiXCUwmuNJ1rZfvZNeUZnPiKNj6Ejrt+RL32j6YK
         4YZ8PtNQSmDOO5aGgwi8AJW41JPrLN41N/d+YMr7SGgaPUwvl/yQB7A/7gy/0nQ4YI3Q
         YjN5k0i1WjGWa9TG4PCpoRwcQxrv9KIb2xY+1/L9xaZteIgd49drha8dbCAF0wy7lsaV
         m8392Pl88j7tLxDIaov+GLvk8sE0GB3CB30AWRyyk7qz0IpcJd152MZjfS6qnqhh/3wd
         Fl/g==
X-Gm-Message-State: APjAAAU8HbW6Uzaa+lX7n54Q7Fk0XetEIsoFg91XXjEeivxCM8+RkU15
        8/DRLgTDvSXFLj12Vehx9OlIrCxqx58=
X-Google-Smtp-Source: APXvYqy6BBvTdtggt8jXdmOjKJ8B8YhhvOoeEBKfNyaUg9ypAf7Tzzc0uk4R9Vyp2hJ8kR5m2PH+5A==
X-Received: by 2002:a17:90a:80c4:: with SMTP id k4mr13962343pjw.74.1562171408715;
        Wed, 03 Jul 2019 09:30:08 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id 65sm3612931pgf.30.2019.07.03.09.30.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 09:30:08 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v2 21/35] platform/x86/thinkpad: Use kmemdup rather than duplicating its implementation
Date:   Thu,  4 Jul 2019 00:30:00 +0800
Message-Id: <20190703163000.315-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v2:
  - Fix a typo in commit message (memset -> memcpy)

 drivers/platform/x86/thinkpad_acpi.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

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

