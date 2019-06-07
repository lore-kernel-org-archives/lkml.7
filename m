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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8101C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF0D20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erQ6VR95"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfFGHOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 03:14:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39983 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfFGHOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 03:14:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id d30so672795pgm.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 00:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m1N60dkKX4zwd7lwIj/FjrRHBW5PAI5y0X7+s8TbdoI=;
        b=erQ6VR95p78CQOVGqGCFCLXBWO5wbWGX4sCqVNRoM9fhbiWAoKbLe8i2uqDyp6Wf5W
         Cn9JQlvqdVQGESR2dFUTCkvazUXSRC8F8RQVbgOsngjoqLIlTV0tlSf52HEVDLnoSwuD
         xhbO+Pbi7tTDjAbQxmIKfZWjZs5LfJ3AGsTNY+pDc1uBZyk0dJ8utPT5K9MkEo47+7G/
         iyTNNRmqAr77Q7FmHuNL8B7fujS7j9qCCU9JRwUMKzmNYaZAVxAkwOlQIaU72v5sz7oe
         nDd4T5Cp8E3XcHUiXEINRvULt7ytQCaSLpKusIKy6in52G9YYYZCNgreoyR6bwIdhqtN
         fznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m1N60dkKX4zwd7lwIj/FjrRHBW5PAI5y0X7+s8TbdoI=;
        b=m9kVUz1hW9h4KukT2MHHdRq41uf4pQ3Zk5qziVP3O1d4zmmQXC7VGZlntILoxxVwkL
         6aZJNcX9nKMydsj4lJvJMmOGnwuSf2AtUTXtOgPF6PNp8c6sH4CMvekywU3YgBrNsL2H
         wBy4KIgDIGUtfFkHFiU9bOICCjCqTJlgUDrJVaGo0/h+mzap8kwy4I1KRHdK0tk6A8jR
         TYzG2rta+VDgap15Zgr9RMwCpYCBlsekkWgo3OJKe8QAuxFd1j3zHMMujbag2R8m4MeM
         v78VQycM+1ItOtLsXhZTK28WTD4HNwKOraaygjqSffA+9F4G0LLpjnonJvotlm/FXON5
         juPw==
X-Gm-Message-State: APjAAAUFdb4+eiUl5iMMfvx6gQUlDl3ou5YtEdwaj0LX82xp2wlPRbZK
        R+LmNCD35QxImm06wK/Zrk0=
X-Google-Smtp-Source: APXvYqwEvmeB0sHfmYATkVtSMaWZwV8PvRKnzPbbwuWLbHlEJVfOBQ1Os7I7FDb6SJbdb4R06W9faw==
X-Received: by 2002:a63:4006:: with SMTP id n6mr1550975pga.424.1559891662985;
        Fri, 07 Jun 2019 00:14:22 -0700 (PDT)
Received: from localhost.localdomain ([110.227.95.145])
        by smtp.gmail.com with ESMTPSA id f11sm4295647pjg.1.2019.06.07.00.14.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 00:14:22 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] staging: rtl8723bs: hal: rtl8723b_cmd.c: Remove variables
Date:   Fri,  7 Jun 2019 12:44:05 +0530
Message-Id: <20190607071405.28310-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove variables that are declared and initialised but never used.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
index fe3891106a6d..e001d302b34c 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
@@ -674,10 +674,6 @@ static void ConstructProbeReq(struct adapter *padapter, u8 *pframe, u32 *pLength
 	u32 pktlen;
 	unsigned char *mac;
 	unsigned char bssrate[NumRates];
-	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	int bssrate_len = 0;
 	u8 bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
@@ -1288,8 +1284,6 @@ static void rtl8723b_set_FwAOACGlobalInfo_Cmd(struct adapter *padapter,  u8 grou
 static void rtl8723b_set_FwScanOffloadInfo_cmd(struct adapter *padapter, PRSVDPAGE_LOC rsvdpageloc, u8 enable)
 {
 	u8 u1H2CScanOffloadInfoParm[H2C_SCAN_OFFLOAD_CTRL_LEN] = {0};
-	u8 res = 0, count = 0;
-	struct pwrctrl_priv *pwrpriv = adapter_to_pwrctl(padapter);
 
 	DBG_871X("%s: loc_probe_packet:%d, loc_scan_info: %d loc_ssid_info:%d\n",
 		__func__, rsvdpageloc->LocProbePacket, rsvdpageloc->LocScanInfo, rsvdpageloc->LocSSIDInfo);
-- 
2.19.1

