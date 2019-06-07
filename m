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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874ECC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5681720B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeyCzVWA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbfFGOHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 10:07:19 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33595 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbfFGOHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:07:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id g21so895631plq.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 07:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dN/Vg8VmpZ2MdQzZ8FBtvf2tGAMIAAsE9edwuUKNnNU=;
        b=MeyCzVWAzQPRCgD7BC4afNMiWnt++zxzpcmIpt6Ip91tKpHwQNdoSWQxlSGrkICLBg
         rzJYZ14EmLn7AqgaxECwqZkfuOiQt5J7Q2dGBbfcqdSQhlC4KoBc7frlMwSDclWpcHRb
         DDzCRDPL2IKuOf8P7NTSCDwgUnJLYIM21+0/jNElfAEunPgb5JJzSNYEMNCT6hlmC4es
         BxCfaYVHIfCRQ4+nwcjJUc30Ue2VaufhxDP6WrxyY5ctIZLXkZ/OYinQ/XBnCRK2LByK
         zuu3nTN6QToQLqOhrNSEIEbduivFc/+WHu/bhoREMwX9/93AxxKiZm/SP5gIjJLSmVBP
         SVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dN/Vg8VmpZ2MdQzZ8FBtvf2tGAMIAAsE9edwuUKNnNU=;
        b=X/A8nffQCCUF7DYHLg3X3KYl/ZtQNR2T4wRJKkSylRueP8jZgcF0EN6yU81tZaSdsi
         WIR9WOsQyXzJVATfoFZPpP4SYvvRnQ8PS+aDVSYjAD0Ec4l5eLBAXDnI3kZ7E0R64qX0
         VblJd7SomPzpAxTiCrpujIfPZ3mwQWbVHLwDsxWOLS9brWBSkLvGzIg/MMtiQs0Xlho9
         Nax7P4Mc5rnEFlBdZH9bBetjaQntTmN21dYLL8Xds8hNnFpJX0Y5JVKfZ+pAJuMlbEF4
         nu7+HrAXdx2n7VhrHUTu0ArWeVv645oUR0w86r3+AErVgTw01YJHZRJI5HZ4/0chSM0A
         Kd4A==
X-Gm-Message-State: APjAAAVg0Av5oJBdpSaTTmHNc4bLx9utZym5CG9Wbc5YoIT7RynyaQSy
        t3t1W3OivMOmKNntJddLZQE=
X-Google-Smtp-Source: APXvYqz18+sGwBta6VjMgL4HrcHyt8lJDGDyybdXd+t/BjpPHb2jsU5i0Tu9X4Bc9dCRZGcfvJY85Q==
X-Received: by 2002:a17:902:e490:: with SMTP id cj16mr54799243plb.136.1559916437964;
        Fri, 07 Jun 2019 07:07:17 -0700 (PDT)
Received: from localhost.localdomain ([110.227.95.145])
        by smtp.gmail.com with ESMTPSA id j7sm7071983pjb.26.2019.06.07.07.07.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 07:07:17 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, straube.linux@gmail.com,
        larry.finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        colin.king@canonical.com, valdis.kletnieks@vt.edu,
        tiny.windzz@gmail.com
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH 2/2] staging: rtl8712: r8712_createbss_cmd(): Change
Date:   Fri,  7 Jun 2019 19:36:58 +0530
Message-Id: <20190607140658.11932-2-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190607140658.11932-1-nishkadg.linux@gmail.com>
References: <20190607140658.11932-1-nishkadg.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change return values of r8712_createbss_cmd from _SUCCESS and _FAIL to 0
and -ENOMEM respectively.
Change return type of the function from unsigned to int to reflect this.
Change call site to check for 0 instead of _SUCCESS.
(Instead of !=0, simply passing the function output to the conditional
will do.)

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_cmd.c       | 6 +++---
 drivers/staging/rtl8712/rtl871x_cmd.h       | 2 +-
 drivers/staging/rtl8712/rtl871x_ioctl_set.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_cmd.c b/drivers/staging/rtl8712/rtl871x_cmd.c
index e478c031f95f..94ff875d9025 100644
--- a/drivers/staging/rtl8712/rtl871x_cmd.c
+++ b/drivers/staging/rtl8712/rtl871x_cmd.c
@@ -409,7 +409,7 @@ void r8712_readtssi_cmdrsp_callback(struct _adapter *padapter,
 	padapter->mppriv.workparam.bcompleted = true;
 }
 
-u8 r8712_createbss_cmd(struct _adapter *padapter)
+int r8712_createbss_cmd(struct _adapter *padapter)
 {
 	struct cmd_obj *pcmd;
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
@@ -419,7 +419,7 @@ u8 r8712_createbss_cmd(struct _adapter *padapter)
 	padapter->ledpriv.LedControlHandler(padapter, LED_CTL_START_TO_LINK);
 	pcmd = kmalloc(sizeof(*pcmd), GFP_ATOMIC);
 	if (!pcmd)
-		return _FAIL;
+		return -ENOMEM;
 	INIT_LIST_HEAD(&pcmd->list);
 	pcmd->cmdcode = _CreateBss_CMD_;
 	pcmd->parmbuf = (unsigned char *)pdev_network;
@@ -431,7 +431,7 @@ u8 r8712_createbss_cmd(struct _adapter *padapter)
 	pdev_network->IELength = pdev_network->IELength;
 	pdev_network->Ssid.SsidLength =	pdev_network->Ssid.SsidLength;
 	r8712_enqueue_cmd(pcmdpriv, pcmd);
-	return _SUCCESS;
+	return 0;
 }
 
 u8 r8712_joinbss_cmd(struct _adapter  *padapter, struct wlan_network *pnetwork)
diff --git a/drivers/staging/rtl8712/rtl871x_cmd.h b/drivers/staging/rtl8712/rtl871x_cmd.h
index 800216cca2f6..6ea1bafd8acc 100644
--- a/drivers/staging/rtl8712/rtl871x_cmd.h
+++ b/drivers/staging/rtl8712/rtl871x_cmd.h
@@ -712,7 +712,7 @@ u8 r8712_setMacAddr_cmd(struct _adapter *padapter, u8 *mac_addr);
 u8 r8712_setassocsta_cmd(struct _adapter *padapter, u8 *mac_addr);
 u8 r8712_sitesurvey_cmd(struct _adapter *padapter,
 			struct ndis_802_11_ssid *pssid);
-u8 r8712_createbss_cmd(struct _adapter *padapter);
+int r8712_createbss_cmd(struct _adapter *padapter);
 u8 r8712_setstakey_cmd(struct _adapter *padapter, u8 *psta, u8 unicast_key);
 u8 r8712_joinbss_cmd(struct _adapter *padapter,
 		     struct wlan_network *pnetwork);
diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_set.c b/drivers/staging/rtl8712/rtl871x_ioctl_set.c
index 2622d5e3bff9..d0274c65d17e 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_set.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_set.c
@@ -84,7 +84,7 @@ static u8 do_join(struct _adapter *padapter)
 			       sizeof(struct ndis_802_11_ssid));
 			r8712_update_registrypriv_dev_network(padapter);
 			r8712_generate_random_ibss(pibss);
-			if (r8712_createbss_cmd(padapter) != _SUCCESS)
+			if (r8712_createbss_cmd(padapter))
 				return false;
 			pmlmepriv->to_join = false;
 		} else {
-- 
2.19.1

