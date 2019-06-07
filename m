Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30068C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33CD2133D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHxLExnQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbfFGOHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 10:07:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33617 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbfFGOHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:07:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id x15so1286868pfq.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 07:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w68ouI0UY8djBNDhDsJy+gGnHUNrSjiyh8Ahtch+loE=;
        b=sHxLExnQRiiKepaTyp4J5/evrteT8xPFZk5OAWQUOLcVtiksseWOVDZ2jimQxpFJCQ
         88XYGZndQ3WcnikN3kiv/3wpVazb+glKAm4Z0BryexF9P8Q2y0LGa3HpN6cqewVEnFvA
         uoxS6tSmyQ6XiWLcwE1uU9OTYzFQhWE9m3tHgNqDFO0m4hopSWfjeSHMxiexL9GuOVhm
         TpXrpI965V2yt3k+K/Icm7WhwI/u40esCYJzPnb+vYqj2FDOcdileW/Hs75M5yY+7Pit
         OHjmBu3QBJP+t3daLVVXror4I7pDoy+tZw87OTbsurgd/NYuQB6wMjtoZvZxsQLz7/vt
         X0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w68ouI0UY8djBNDhDsJy+gGnHUNrSjiyh8Ahtch+loE=;
        b=RBsSQlp1Q5MgRFvIr+ibS+EGBJcbeJ/VUfAkDqsdZ8Si3IVLVpU37Cvk3xyJSIgu7f
         kZuHTl3gYYIDPgSuuiZTBD4E9fPDvoIU+OMAFBBjaWrlenmfzuTbisUGz0skKMcDZE8U
         kNfC1AfjhZmIKSk2jMPqAe/GZgIG0GDBY7cHjHUzshPSLKc0dBYSAYptVZ57iZzSLYiu
         TxFELeYZfYQnYnccwwyToxJAXqHZsQaWX0d9BaT0m61Zlmde8uYxO/P7jimrOQ3wykzd
         DLtzFNfS4JsrdQBSxug5iDjMj13SLkF3IaYEFlvNWAmpCZlqifzF5xV2L0OU2Fv7mnT/
         tT0w==
X-Gm-Message-State: APjAAAV1cgl6mcieFsh2P+IaWpzayNJDIS/PMj7P0CvwcOQQfrKlPUYZ
        nylTJqZo5pAwi2tcYGZirT4=
X-Google-Smtp-Source: APXvYqyjaZ9v04OcHSwvjnhQp44PZBimRAIR9Jc6Q2E7NeuunokrETeS25wWWXDGnmFwoictBjx++w==
X-Received: by 2002:a65:5302:: with SMTP id m2mr2771049pgq.369.1559916433683;
        Fri, 07 Jun 2019 07:07:13 -0700 (PDT)
Received: from localhost.localdomain ([110.227.95.145])
        by smtp.gmail.com with ESMTPSA id j7sm7071983pjb.26.2019.06.07.07.07.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 07:07:12 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, straube.linux@gmail.com,
        larry.finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        colin.king@canonical.com, valdis.kletnieks@vt.edu,
        tiny.windzz@gmail.com
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH 1/2] staging: rtl8712: r8712_setdatarate_cmd(): Change
Date:   Fri,  7 Jun 2019 19:36:57 +0530
Message-Id: <20190607140658.11932-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the return values of function r8712_setdatarate_cmd from _SUCCESS
and _FAIL to 0 and -ENOMEM respectively.
Change the return type of the function from u8 to int to reflect this.
Change the call site of the function to check for 0 instead of _SUCCESS.
(Checking that the return value != 0 is not necessary; the return value
itself can simply be passed into the conditional.)

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_cmd.c         | 8 ++++----
 drivers/staging/rtl8712/rtl871x_cmd.h         | 2 +-
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_cmd.c b/drivers/staging/rtl8712/rtl871x_cmd.c
index 05a78ac24987..e478c031f95f 100644
--- a/drivers/staging/rtl8712/rtl871x_cmd.c
+++ b/drivers/staging/rtl8712/rtl871x_cmd.c
@@ -242,7 +242,7 @@ u8 r8712_sitesurvey_cmd(struct _adapter *padapter,
 	return _SUCCESS;
 }
 
-u8 r8712_setdatarate_cmd(struct _adapter *padapter, u8 *rateset)
+int r8712_setdatarate_cmd(struct _adapter *padapter, u8 *rateset)
 {
 	struct cmd_obj		*ph2c;
 	struct setdatarate_parm	*pbsetdataratepara;
@@ -250,18 +250,18 @@ u8 r8712_setdatarate_cmd(struct _adapter *padapter, u8 *rateset)
 
 	ph2c = kmalloc(sizeof(*ph2c), GFP_ATOMIC);
 	if (!ph2c)
-		return _FAIL;
+		return -ENOMEM;
 	pbsetdataratepara = kmalloc(sizeof(*pbsetdataratepara), GFP_ATOMIC);
 	if (!pbsetdataratepara) {
 		kfree(ph2c);
-		return _FAIL;
+		return -ENOMEM;
 	}
 	init_h2fwcmd_w_parm_no_rsp(ph2c, pbsetdataratepara,
 				   GEN_CMD_CODE(_SetDataRate));
 	pbsetdataratepara->mac_id = 5;
 	memcpy(pbsetdataratepara->datarates, rateset, NumRates);
 	r8712_enqueue_cmd(pcmdpriv, ph2c);
-	return _SUCCESS;
+	return 0;
 }
 
 u8 r8712_set_chplan_cmd(struct _adapter *padapter, int chplan)
diff --git a/drivers/staging/rtl8712/rtl871x_cmd.h b/drivers/staging/rtl8712/rtl871x_cmd.h
index 262984c58efb..800216cca2f6 100644
--- a/drivers/staging/rtl8712/rtl871x_cmd.h
+++ b/drivers/staging/rtl8712/rtl871x_cmd.h
@@ -719,7 +719,7 @@ u8 r8712_joinbss_cmd(struct _adapter *padapter,
 u8 r8712_disassoc_cmd(struct _adapter *padapter);
 u8 r8712_setopmode_cmd(struct _adapter *padapter,
 		 enum NDIS_802_11_NETWORK_INFRASTRUCTURE networktype);
-u8 r8712_setdatarate_cmd(struct _adapter *padapter, u8 *rateset);
+int r8712_setdatarate_cmd(struct _adapter *padapter, u8 *rateset);
 u8 r8712_set_chplan_cmd(struct _adapter  *padapter, int chplan);
 u8 r8712_setbasicrate_cmd(struct _adapter *padapter, u8 *rateset);
 u8 r8712_getrfreg_cmd(struct _adapter *padapter, u8 offset, u8 *pval);
diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
index b424b8436fcf..761e2ba68a42 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
@@ -1367,7 +1367,7 @@ static int r8711_wx_set_rate(struct net_device *dev,
 			datarates[i] = 0xff;
 		}
 	}
-	if (r8712_setdatarate_cmd(padapter, datarates) != _SUCCESS)
+	if (r8712_setdatarate_cmd(padapter, datarates))
 		ret = -ENOMEM;
 	return ret;
 }
-- 
2.19.1

