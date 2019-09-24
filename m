Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE82C432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 14:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38DFC214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 14:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441363AbfIXO24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 10:28:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55166 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393649AbfIXO24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 10:28:56 -0400
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <connor.kuehl@canonical.com>)
        id 1iCloD-00021m-Jj
        for linux-kernel@vger.kernel.org; Tue, 24 Sep 2019 14:28:53 +0000
Received: by mail-pf1-f200.google.com with SMTP id p2so1617194pff.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 07:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5YkNuEOOhfnHxAM0RhiQZB+Aq9qlq6ccg1LuS0lMLf0=;
        b=XBYRLmvXZlDklRgF4Gq1WOO8AcLW37DvW47mnpe1VncyTHD9kqbEtgW1esf4+L4Xd+
         TMEupPIH+99P4+Mh5IsEM0z4kIbLq+EU2NLekQTlGoQWeCi0dwfoufoJ+vIKC3ecLLK8
         QWNSev9pxq+pmuWSZaRpgIEWnMNTyhR/pf6x0lS6YsTrk93Bo+8SJsoDocC+7INPTcLi
         hCx/LT6hUn6z2DcPz9eOKKSuijO9z0p6ZwYfetxKQGxGtdpResuff8937QDc3QDQ1soa
         SQgwahkjoDACxuRLf/b/eKw3z1lJ0n/5BXcyhF4/wkkbQGk0FfZM6AiiNuLIZ7VsZEki
         QRpA==
X-Gm-Message-State: APjAAAWCTFxdO0Dy9qjlYEyqGRBooKnyDa8vmw7Qs+Mh9vHh70fsrUE/
        EOl9WCAz+lL/hRQQZjvG1/1i6p2NXg65d+H8LiL5VkLaEHHk8Ees31WcUvqaUk01HKHEfDTogIR
        Zh2wutU9LsnggOtG1ikTKOmCgYxISzXNi9CFlG0wHUA==
X-Received: by 2002:a62:f244:: with SMTP id y4mr3837263pfl.2.1569335331988;
        Tue, 24 Sep 2019 07:28:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzzLi9oMclWpMESAA1tm9M09vstATTbyIZMUv+NYjlAT8Bd3t7W6yLfNh3/LXVbQ5DOkTnItw==
X-Received: by 2002:a62:f244:: with SMTP id y4mr3837240pfl.2.1569335331782;
        Tue, 24 Sep 2019 07:28:51 -0700 (PDT)
Received: from localhost.localdomain (c-71-63-131-226.hsd1.or.comcast.net. [71.63.131.226])
        by smtp.gmail.com with ESMTPSA id 74sm1848668pfy.78.2019.09.24.07.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 07:28:51 -0700 (PDT)
From:   Connor Kuehl <connor.kuehl@canonical.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, devel@driverdev.osuosl.org,
        dan.carpenter@oracle.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2] staging: rtl8188eu: remove dead code/vestigial do..while loop
Date:   Tue, 24 Sep 2019 07:28:19 -0700
Message-Id: <20190924142819.5243-1-connor.kuehl@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The local variable 'bcmd_down' is always set to true almost immediately
before the do-while's condition is checked. As a result, !bcmd_down
evaluates to false which short circuits the logical AND operator meaning
that the second operand is never reached and is therefore dead code.

Furthermore, the do..while loop may be removed since it will always only
execute once because 'bcmd_down' is always set to true, so the
!bcmd_down evaluates to false and the loop exits immediately after the
first pass.

Fix this by removing the loop and its condition variables 'bcmd_down'
and 'retry_cnts'

While we're in there, also fix some checkpatch.pl suggestions regarding
spaces around arithmetic operators like '+'

Addresses-Coverity: ("Logically dead code")

Signed-off-by: Connor Kuehl <connor.kuehl@canonical.com>
---
v1 -> v2:
 - remove the loop and its condition variable bcmd_down
 - address some non-invasive checkpatch.pl suggestions as a result of
   deleting the loop

 drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c | 55 +++++++++-----------
 1 file changed, 24 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c b/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
index 47352f210c0b..7646167a0b36 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
@@ -47,8 +47,6 @@ static u8 _is_fw_read_cmd_down(struct adapter *adapt, u8 msgbox_num)
 ******************************************/
 static s32 FillH2CCmd_88E(struct adapter *adapt, u8 ElementID, u32 CmdLen, u8 *pCmdBuffer)
 {
-	u8 bcmd_down = false;
-	s32 retry_cnts = 100;
 	u8 h2c_box_num;
 	u32 msgbox_addr;
 	u32 msgbox_ex_addr;
@@ -71,39 +69,34 @@ static s32 FillH2CCmd_88E(struct adapter *adapt, u8 ElementID, u32 CmdLen, u8 *p
 		goto exit;
 
 	/* pay attention to if  race condition happened in  H2C cmd setting. */
-	do {
-		h2c_box_num = adapt->HalData->LastHMEBoxNum;
-
-		if (!_is_fw_read_cmd_down(adapt, h2c_box_num)) {
-			DBG_88E(" fw read cmd failed...\n");
-			goto exit;
-		}
-
-		*(u8 *)(&h2c_cmd) = ElementID;
-
-		if (CmdLen <= 3) {
-			memcpy((u8 *)(&h2c_cmd)+1, pCmdBuffer, CmdLen);
-		} else {
-			memcpy((u8 *)(&h2c_cmd)+1, pCmdBuffer, 3);
-			ext_cmd_len = CmdLen-3;
-			memcpy((u8 *)(&h2c_cmd_ex), pCmdBuffer+3, ext_cmd_len);
+	h2c_box_num = adapt->HalData->LastHMEBoxNum;
 
-			/* Write Ext command */
-			msgbox_ex_addr = REG_HMEBOX_EXT_0 + (h2c_box_num * RTL88E_EX_MESSAGE_BOX_SIZE);
-			for (cmd_idx = 0; cmd_idx < ext_cmd_len; cmd_idx++)
-				usb_write8(adapt, msgbox_ex_addr+cmd_idx, *((u8 *)(&h2c_cmd_ex)+cmd_idx));
-		}
-		/*  Write command */
-		msgbox_addr = REG_HMEBOX_0 + (h2c_box_num * RTL88E_MESSAGE_BOX_SIZE);
-		for (cmd_idx = 0; cmd_idx < RTL88E_MESSAGE_BOX_SIZE; cmd_idx++)
-			usb_write8(adapt, msgbox_addr+cmd_idx, *((u8 *)(&h2c_cmd)+cmd_idx));
+	if (!_is_fw_read_cmd_down(adapt, h2c_box_num)) {
+		DBG_88E(" fw read cmd failed...\n");
+		goto exit;
+	}
 
-		bcmd_down = true;
+	*(u8 *)(&h2c_cmd) = ElementID;
 
-		adapt->HalData->LastHMEBoxNum =
-			(h2c_box_num+1) % RTL88E_MAX_H2C_BOX_NUMS;
+	if (CmdLen <= 3) {
+		memcpy((u8 *)(&h2c_cmd) + 1, pCmdBuffer, CmdLen);
+	} else {
+		memcpy((u8 *)(&h2c_cmd) + 1, pCmdBuffer, 3);
+		ext_cmd_len = CmdLen - 3;
+		memcpy((u8 *)(&h2c_cmd_ex), pCmdBuffer + 3, ext_cmd_len);
+
+		/* Write Ext command */
+		msgbox_ex_addr = REG_HMEBOX_EXT_0 + (h2c_box_num * RTL88E_EX_MESSAGE_BOX_SIZE);
+		for (cmd_idx = 0; cmd_idx < ext_cmd_len; cmd_idx++)
+			usb_write8(adapt, msgbox_ex_addr + cmd_idx, *((u8 *)(&h2c_cmd_ex) + cmd_idx));
+	}
+	/*  Write command */
+	msgbox_addr = REG_HMEBOX_0 + (h2c_box_num * RTL88E_MESSAGE_BOX_SIZE);
+	for (cmd_idx = 0; cmd_idx < RTL88E_MESSAGE_BOX_SIZE; cmd_idx++)
+		usb_write8(adapt, msgbox_addr + cmd_idx, *((u8 *)(&h2c_cmd) + cmd_idx));
 
-	} while ((!bcmd_down) && (retry_cnts--));
+	adapt->HalData->LastHMEBoxNum =
+		(h2c_box_num + 1) % RTL88E_MAX_H2C_BOX_NUMS;
 
 	ret = _SUCCESS;
 
-- 
2.17.1

