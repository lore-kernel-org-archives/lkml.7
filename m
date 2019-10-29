Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D4FCA9EC0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 01:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85EE321835
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 01:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9UJ2Gr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbfJ2Bna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 21:43:30 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35738 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfJ2Bn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 21:43:29 -0400
Received: by mail-qk1-f195.google.com with SMTP id h6so2469142qkf.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 18:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=78tFr7cgzVjX/van0x9yBO5Wr/o0WnCCYGwnJqISdN8=;
        b=E9UJ2Gr4dAMsVE4Uj9oGkgJlNsIlG4Fd1Ka9+umyYTt8i969SnI/XCtXXYjIcaRBk+
         R0ogtOrBejll1uuflDIsQSiLK67IJTXcFZj/97otQG9C6rtSfOVqjeSTxqO9tfy8cByy
         1ciucLwzSYewakC90sLx+zdPCE4Kg1sYAlwgLHhWYYBt/e2i7HwtW/K5iba/n1StSJOO
         iPajZfkl1TeyMdFo3yqZxR8O7Hl3rPExpsZq0Nki8cAHBslPVrWIBpWJSED/amgIQneF
         4Sdpwv0LCx0NZ6vfVwXhlSVSCT3dYMncRYKRHn7Vyr2n561pfhmjEB83VTRHjFbPVaMI
         GIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=78tFr7cgzVjX/van0x9yBO5Wr/o0WnCCYGwnJqISdN8=;
        b=HXjwxVGxPkbH9rnrnvn0xb/aWac2lHvUql5NtBkWPjqCs9rhIkiehD7mOOLRTVn298
         +iffCg63q00QgtFt5HNVoJmKq9eQyw8Ye8BEg+u1/iPpJfRhgLbTGnFd2PT3kdrLgmgZ
         DWEANwDhrbH+/omZPgEYGkqjX0fjeNxX/yONqaL1p7S5eJioG8rQgKHVaSM7gLjHhcba
         miwitCAm7QC08d46TWYijZzYur/Zh2TZSdsFj+QbLlLnGfebffMCC+gXnrjaGuawt7nA
         ebaWgTNa8zTRTZx/2uWHTeSfkzVdUQlDy4cd5yA8+0Q5UVczTv5eBOB1KKhBWiBYTW8J
         E/1Q==
X-Gm-Message-State: APjAAAV9aiQYUmyPTKQ9CcZ0PgtZlvU+Eol0spHePKjlpvin+q/Xwst8
        w3wKDQPEIqEoKmEsyx02IM3cpEveS7fVDw==
X-Google-Smtp-Source: APXvYqzx6Yq4Ks1SUcfzc9LqCgg9WLmhr74ZOWzBkbYX0QZdXnNb24pqBC7z10v3ccM+pydY7HbLwg==
X-Received: by 2002:a05:620a:208a:: with SMTP id e10mr19362814qka.189.1572313407870;
        Mon, 28 Oct 2019 18:43:27 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:483:ade:87ad:69fb:5b32:cf88])
        by smtp.gmail.com with ESMTPSA id 197sm6698394qkh.80.2019.10.28.18.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 18:43:27 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        kim.jamie.bradley@gmail.com, nishkadg.linux@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH 1/5] staging: rts5208: Eliminate the use of Camel Case in file ms.c
Date:   Mon, 28 Oct 2019 22:43:12 -0300
Message-Id: <20191029014316.6452-2-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191029014316.6452-1-gabrielabittencourt00@gmail.com>
References: <20191029014316.6452-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleans up checks of "Avoid CamelCase" in file ms.c

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---
 drivers/staging/rts5208/ms.c | 86 ++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/staging/rts5208/ms.c b/drivers/staging/rts5208/ms.c
index e853fa9cc950..5c7c13dfefa0 100644
--- a/drivers/staging/rts5208/ms.c
+++ b/drivers/staging/rts5208/ms.c
@@ -590,7 +590,7 @@ static int ms_identify_media_type(struct rtsx_chip *chip, int switch_8bit_bus)
 	int retval, i;
 	u8 val;
 
-	retval = ms_set_rw_reg_addr(chip, Pro_StatusReg, 6, SystemParm, 1);
+	retval = ms_set_rw_reg_addr(chip, pro_status_reg, 6, system_parm, 1);
 	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
 
@@ -840,7 +840,7 @@ static int msxc_change_power(struct rtsx_chip *chip, u8 mode)
 
 	ms_cleanup_work(chip);
 
-	retval = ms_set_rw_reg_addr(chip, 0, 0, Pro_DataCount1, 6);
+	retval = ms_set_rw_reg_addr(chip, 0, 0, pro_data_count1, 6);
 	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
 
@@ -885,7 +885,7 @@ static int ms_read_attribute_info(struct rtsx_chip *chip)
 	int found_sys_info = 0, found_model_name = 0;
 #endif
 
-	retval = ms_set_rw_reg_addr(chip, Pro_IntReg, 2, Pro_SystemParm, 7);
+	retval = ms_set_rw_reg_addr(chip, pro_int_REG, 2, pro_system_parm, 7);
 	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
 
@@ -1232,7 +1232,7 @@ static int ms_read_status_reg(struct rtsx_chip *chip)
 	int retval;
 	u8 val[2];
 
-	retval = ms_set_rw_reg_addr(chip, StatusReg0, 2, 0, 0);
+	retval = ms_set_rw_reg_addr(chip, status_reg0, 2, 0, 0);
 	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
 
@@ -1255,8 +1255,8 @@ static int ms_read_extra_data(struct rtsx_chip *chip,
 	int retval, i;
 	u8 val, data[10];
 
-	retval = ms_set_rw_reg_addr(chip, OverwriteFlag, MS_EXTRA_SIZE,
-				    SystemParm, 6);
+	retval = ms_set_rw_reg_addr(chip, overwrite_flag, MS_EXTRA_SIZE,
+				    system_parm, 6);
 	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
 
@@ -1307,8 +1307,8 @@ static int ms_read_extra_data(struct rtsx_chip *chip,
 			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
 
-			retval = ms_set_rw_reg_addr(chip, OverwriteFlag,
-						    MS_EXTRA_SIZE, SystemParm,
+			retval = ms_set_rw_reg_addr(chip, overwrite_flag,
+						    MS_EXTRA_SIZE, system_parm,
 						    6);
 			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
@@ -1339,8 +1339,8 @@ static int ms_write_extra_data(struct rtsx_chip *chip, u16 block_addr,
 	if (!buf || (buf_len < MS_EXTRA_SIZE))
 		return STATUS_FAIL;
 
-	retval = ms_set_rw_reg_addr(chip, OverwriteFlag, MS_EXTRA_SIZE,
-				    SystemParm, 6 + MS_EXTRA_SIZE);
+	retval = ms_set_rw_reg_addr(chip, overwrite_flag, MS_EXTRA_SIZE,
+				    system_parm, 6 + MS_EXTRA_SIZE);
 	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
 
@@ -1392,8 +1392,8 @@ static int ms_read_page(struct rtsx_chip *chip, u16 block_addr, u8 page_num)
 	int retval;
 	u8 val, data[6];
 
-	retval = ms_set_rw_reg_addr(chip, OverwriteFlag, MS_EXTRA_SIZE,
-				    SystemParm, 6);
+	retval = ms_set_rw_reg_addr(chip, overwrite_flag, MS_EXTRA_SIZE,
+				    system_parm, 6);
 	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
 
@@ -1465,8 +1465,8 @@ static int ms_set_bad_block(struct rtsx_chip *chip, u16 phy_blk)
 	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
 
-	retval = ms_set_rw_reg_addr(chip, OverwriteFlag, MS_EXTRA_SIZE,
-				    SystemParm, 7);
+	retval = ms_set_rw_reg_addr(chip, overwrite_flag, MS_EXTRA_SIZE,
+				    system_parm, 7);
 	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
 
@@ -1519,8 +1519,8 @@ static int ms_erase_block(struct rtsx_chip *chip, u16 phy_blk)
 	int retval, i = 0;
 	u8 val, data[6];
 
-	retval = ms_set_rw_reg_addr(chip, OverwriteFlag, MS_EXTRA_SIZE,
-				    SystemParm, 6);
+	retval = ms_set_rw_reg_addr(chip, overwrite_flag, MS_EXTRA_SIZE,
+				    system_parm, 6);
 	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
 
@@ -1579,7 +1579,7 @@ static void ms_set_page_status(u16 log_blk, u8 type, u8 *extra, int extra_len)
 
 	memset(extra, 0xFF, MS_EXTRA_SIZE);
 
-	if (type == setPS_NG) {
+	if (type == set_PS_NG) {
 		/* set page status as 1:NG,and block status keep 1:OK */
 		extra[0] = 0xB8;
 	} else {
@@ -1670,8 +1670,8 @@ static int ms_copy_page(struct rtsx_chip *chip, u16 old_blk, u16 new_blk,
 		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
 
-		retval = ms_set_rw_reg_addr(chip, OverwriteFlag,
-					    MS_EXTRA_SIZE, SystemParm, 6);
+		retval = ms_set_rw_reg_addr(chip, overwrite_flag,
+					    MS_EXTRA_SIZE, system_parm, 6);
 		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
 
@@ -1725,7 +1725,7 @@ static int ms_copy_page(struct rtsx_chip *chip, u16 old_blk, u16 new_blk,
 					return STATUS_FAIL;
 
 				if (uncorrect_flag) {
-					ms_set_page_status(log_blk, setPS_NG,
+					ms_set_page_status(log_blk, set_PS_NG,
 							   extra,
 							   MS_EXTRA_SIZE);
 					if (i == 0)
@@ -1738,8 +1738,8 @@ static int ms_copy_page(struct rtsx_chip *chip, u16 old_blk, u16 new_blk,
 						i, extra[0]);
 					MS_SET_BAD_BLOCK_FLG(ms_card);
 
-					ms_set_page_status(log_blk, setPS_Error,
-							   extra,
+					ms_set_page_status(log_blk,
+							   set_PS_error, extra,
 							   MS_EXTRA_SIZE);
 					ms_write_extra_data(chip, new_blk, i,
 							    extra,
@@ -1767,8 +1767,8 @@ static int ms_copy_page(struct rtsx_chip *chip, u16 old_blk, u16 new_blk,
 			}
 		}
 
-		retval = ms_set_rw_reg_addr(chip, OverwriteFlag, MS_EXTRA_SIZE,
-					    SystemParm, (6 + MS_EXTRA_SIZE));
+		retval = ms_set_rw_reg_addr(chip, overwrite_flag, MS_EXTRA_SIZE,
+					    system_parm, (6 + MS_EXTRA_SIZE));
 
 		ms_set_err_code(chip, MS_NO_ERROR);
 
@@ -1822,8 +1822,8 @@ static int ms_copy_page(struct rtsx_chip *chip, u16 old_blk, u16 new_blk,
 		}
 
 		if (i == 0) {
-			retval = ms_set_rw_reg_addr(chip, OverwriteFlag,
-						    MS_EXTRA_SIZE, SystemParm,
+			retval = ms_set_rw_reg_addr(chip, overwrite_flag,
+						    MS_EXTRA_SIZE, system_parm,
 						    7);
 			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
@@ -1980,8 +1980,8 @@ static int reset_ms(struct rtsx_chip *chip)
 	for (reg_addr = BLOCK_SIZE_0; reg_addr <= PAGE_SIZE_1; reg_addr++)
 		rtsx_add_cmd(chip, READ_REG_CMD, reg_addr, 0, 0);
 
-	rtsx_add_cmd(chip, READ_REG_CMD, MS_Device_Type, 0, 0);
-	rtsx_add_cmd(chip, READ_REG_CMD, MS_4bit_Support, 0, 0);
+	rtsx_add_cmd(chip, READ_REG_CMD, MS_device_type, 0, 0);
+	rtsx_add_cmd(chip, READ_REG_CMD, MS_4bit_support, 0, 0);
 
 	retval = rtsx_send_cmd(chip, MS_CARD, 100);
 	if (retval < 0)
@@ -2057,7 +2057,7 @@ static int reset_ms(struct rtsx_chip *chip)
 
 	/* Switch I/F Mode */
 	if (ptr[15]) {
-		retval = ms_set_rw_reg_addr(chip, 0, 0, SystemParm, 1);
+		retval = ms_set_rw_reg_addr(chip, 0, 0, system_parm, 1);
 		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
 
@@ -2887,7 +2887,7 @@ int mspro_format(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
 
-	retval = ms_set_rw_reg_addr(chip, 0x00, 0x00, Pro_TPCParm, 0x01);
+	retval = ms_set_rw_reg_addr(chip, 0x00, 0x00, pro_TPC_parm, 0x01);
 	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
 
@@ -2970,8 +2970,8 @@ static int ms_read_multiple_pages(struct rtsx_chip *chip, u16 phy_blk,
 		}
 	}
 
-	retval = ms_set_rw_reg_addr(chip, OverwriteFlag, MS_EXTRA_SIZE,
-				    SystemParm, 6);
+	retval = ms_set_rw_reg_addr(chip, overwrite_flag, MS_EXTRA_SIZE,
+				    system_parm, 6);
 	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
 
@@ -3026,7 +3026,7 @@ static int ms_read_multiple_pages(struct rtsx_chip *chip, u16 phy_blk,
 					if (!(chip->card_wp & MS_CARD)) {
 						reset_ms(chip);
 						ms_set_page_status
-							(log_blk, setPS_NG,
+							(log_blk, set_PS_NG,
 							 extra,
 							 MS_EXTRA_SIZE);
 						ms_write_extra_data
@@ -3131,8 +3131,8 @@ static int ms_write_multiple_pages(struct rtsx_chip *chip, u16 old_blk,
 	u8 *ptr;
 
 	if (!start_page) {
-		retval = ms_set_rw_reg_addr(chip, OverwriteFlag, MS_EXTRA_SIZE,
-					    SystemParm, 7);
+		retval = ms_set_rw_reg_addr(chip, overwrite_flag, MS_EXTRA_SIZE,
+					    system_parm, 7);
 		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
 
@@ -3165,8 +3165,8 @@ static int ms_write_multiple_pages(struct rtsx_chip *chip, u16 old_blk,
 			return STATUS_FAIL;
 	}
 
-	retval = ms_set_rw_reg_addr(chip, OverwriteFlag, MS_EXTRA_SIZE,
-				    SystemParm, (6 + MS_EXTRA_SIZE));
+	retval = ms_set_rw_reg_addr(chip, overwrite_flag, MS_EXTRA_SIZE,
+				    system_parm, (6 + MS_EXTRA_SIZE));
 	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
 
@@ -3773,9 +3773,9 @@ static int mg_set_tpc_para_sub(struct rtsx_chip *chip, int type,
 	u8 buf[6];
 
 	if (type == 0)
-		retval = ms_set_rw_reg_addr(chip, 0, 0, Pro_TPCParm, 1);
+		retval = ms_set_rw_reg_addr(chip, 0, 0, pro_TPC_parm, 1);
 	else
-		retval = ms_set_rw_reg_addr(chip, 0, 0, Pro_DataCount1, 6);
+		retval = ms_set_rw_reg_addr(chip, 0, 0, pro_data_count1, 6);
 
 	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
@@ -4154,7 +4154,7 @@ int mg_set_ICV(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		} else {
 			set_sense_type(chip, lun, SENSE_TYPE_MG_WRITE_ERR);
 		}
-		goto SetICVFinish;
+		goto set_ICV_finish;
 	}
 
 #ifdef MG_SET_ICV_SLOW
@@ -4195,7 +4195,7 @@ int mg_set_ICV(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 					       SENSE_TYPE_MG_WRITE_ERR);
 			}
 			retval = STATUS_FAIL;
-			goto SetICVFinish;
+			goto set_ICV_finish;
 		}
 	}
 #else
@@ -4214,11 +4214,11 @@ int mg_set_ICV(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		} else {
 			set_sense_type(chip, lun, SENSE_TYPE_MG_WRITE_ERR);
 		}
-		goto SetICVFinish;
+		goto set_ICV_finish;
 	}
 #endif
 
-SetICVFinish:
+set_ICV_finish:
 	kfree(buf);
 	return retval;
 }
-- 
2.20.1

