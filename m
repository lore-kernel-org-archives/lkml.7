Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28BAC48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85EE7205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uPdAlVeE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfF0RmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:42:07 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36319 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfF0RmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:42:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id r7so1594428pfl.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 10:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gOS8Fn0ZCLcglF4xKeQZbhL/pfJXLmBVW/p/GaFW4vw=;
        b=uPdAlVeEkWRPvyXaQHMcoUf1KiMZ8y3IchjzB4LpXvjA3PWopLM23mdCfvh8e6aT8f
         moz685kVPURyD0QfGpQ15iLkhiJVnB6FTnopZaE9GQw1qfcX28961BFzoad6LmgcjMAK
         iNPi65WQF2y1Dt8++ZIA3pavZhIs+52lbBKhOO6mnWezHhch/UrA36rmJJf3w2Sox7iG
         FH5c/7rND1ZKv138gH03CluA5COl027kU9NwXSFzNau196IytFwuou1PeTSQWgB9vt90
         jOupeT3ZMB/on6U8wr/LakCfP8gqj0haMByxgc/rBKy5VLN0WBXim3kJMGDgXFqRzcmL
         f1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gOS8Fn0ZCLcglF4xKeQZbhL/pfJXLmBVW/p/GaFW4vw=;
        b=TIqxEfTBmBhQKf6ayC4ZiNXj4NzkSEvqyT1T/QtLk6GVVYDdA+5z0Moys9XgXOUFgq
         SUUUpaXGfWgwdSJmPPJp3oOUsB5Bk06B4Qaz/ZGIx74ROV0JfE+7VnDmjEnrlXryNbU8
         spX+8BBjC/uRniq6SiUErZJBi1v8bJRLw9b1Q9spJkW+Axhpbv/BBsSpQFLHK0Ve0ZZz
         slKfnyEjdF5EMA7g5J7YYFiZA2nOLt4u5Bjmvkgyn7ibWRCha0lfv6knLnHO6MraK8AF
         j66ACRYljpFg6YzjE2KgwW7476kyBti9dvtOffJ8MPDJoCJk6qiYMHmj4HajfEaYl2Gq
         Uj/A==
X-Gm-Message-State: APjAAAVBz9av0FBby6fKrL4qThTJIoxgubGAnwcyM4WDRD/clBc6Izwd
        zO32TGRaxr46hXs94HZyWeM=
X-Google-Smtp-Source: APXvYqxLjZc8YA2i5iuLsRCgktSmgA1fvawM8bInlAxJ54TjKSt49nAe7X0Ysj4Sjh/WVGT73i+7dg==
X-Received: by 2002:a65:6241:: with SMTP id q1mr4853914pgv.24.1561657326093;
        Thu, 27 Jun 2019 10:42:06 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id cx22sm6124798pjb.25.2019.06.27.10.42.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:42:05 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Nishka Dasgupta <nishka.dasgupta@yahoo.com>,
        Murray McAllister <murray.mcallister@insomniasec.com>,
        Kimberly Brown <kimbrownkd@gmail.com>,
        Anirudh Rayabharam <anirudh.rayabharam@gmail.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Emanuel Bennici <benniciemanuel78@gmail.com>,
        Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 49/87] rtl8723bs: core: remove memset after rtw_zmalloc
Date:   Fri, 28 Jun 2019 01:41:56 +0800
Message-Id: <20190627174158.4560-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_zmalloc already zeros the memory.
memset is unneeded.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c   | 2 --
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index bc0230672457..dc1da5626ce1 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -1504,8 +1504,6 @@ static int rtw_ap_set_key(
 		goto exit;
 	}
 
-	memset(psetkeyparm, 0, sizeof(struct setkey_parm));
-
 	psetkeyparm->keyid = (u8)keyid;
 	if (is_wep_enc(alg))
 		padapter->securitypriv.key_mask |= BIT(psetkeyparm->keyid);
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 5f78f1eaa7aa..3586da79af5a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2229,7 +2229,6 @@ sint rtw_set_auth(struct adapter *adapter, struct security_priv *psecuritypriv)
 		goto exit;
 	}
 
-	memset(psetauthparm, 0, sizeof(struct setauth_parm));
 	psetauthparm->mode = (unsigned char)psecuritypriv->dot11AuthAlgrthm;
 
 	pcmd->cmdcode = _SetAuth_CMD_;
@@ -2262,7 +2261,6 @@ sint rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, s
 		res = _FAIL;
 		goto exit;
 	}
-	memset(psetkeyparm, 0, sizeof(struct setkey_parm));
 
 	if (psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) {
 		psetkeyparm->algorithm = (unsigned char)psecuritypriv->dot118021XGrpPrivacy;
-- 
2.11.0

