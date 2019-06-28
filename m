Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B09C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA64E208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hy72Cf3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfF1CuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 22:50:00 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42708 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfF1CuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 22:50:00 -0400
Received: by mail-pg1-f195.google.com with SMTP id k13so1893048pgq.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 19:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ntiJ5C/OBL6UdCz4Q7ktczZqFeLJZaqGoBR+VZeaVcQ=;
        b=hy72Cf3q1oJ7rFjw+u0OTSaQNnxUaiSNepNt+DvajIwO5FZgf1H5nma5H/nNKqU05/
         rFIH8E61qyP2qWOWDRONVJtLPbXXei+mScXn2kC9zYL/IA3Lumiw7u3yf9x0WEtqTbhG
         CZjJw2dCkgWhxrZBhv/+vYrIuYSoTFeP60qN27F0QvZAs7aFE74nEpSjjbSxuWgCXEa8
         O4zaJAge4tk1FYgD4JVVKcNFn+WzFceVq0L365itBFLjU8J9EyrAY2f+wt2JFhIlI2UF
         mjlnvLII0cx6Ds+cYsJGlgPIPGGApcc/u4vEy/crPJR915gSSstqTrAAImol1chwQZyf
         G9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ntiJ5C/OBL6UdCz4Q7ktczZqFeLJZaqGoBR+VZeaVcQ=;
        b=i4aVcOcUvtyc5n6dVxysIZMmcb4Zwqicj4EiPs2sDaP1st/A2pJPSs35u2CHjhbkS9
         siKyjjVtCZknadOqgTtuiUdD/PRt9f+ifDlTCCLSe7qcfxiqsQIvDLqvc9Rgw2FpSz7P
         El44Ttw7JuMyntG4/HlRsqzMZBtmajFM8xLXAvKyOtra+zHGRRzVtPrWRafTKL8wgmEq
         gpz9oX3OHObMyBt5tuipd9NEdAYTfY3QWynsTvSKDWLP7oE+E5D02kaPspU4iuvjgQ5U
         7ztVDUv/YRCvrhdMAydVte0/Ij1PGS6erOxrBaTzTCXO7mKFNpvSLrFopQu7Gx+GjQJt
         mHzg==
X-Gm-Message-State: APjAAAUvfU78PDnzX3fDyuy4c54HU2urRs38ZP/EjQISOPlqRAx3dnSo
        91OJk9+d8+wE0lC0Axhad1g=
X-Google-Smtp-Source: APXvYqyfn2rh8ilKv0L32NiNdkcC+i8x5BeMbUQYHSIRKS7tjyeJfoqsLpWyRcsX7ElJnZS6K2irOA==
X-Received: by 2002:a17:90a:1b48:: with SMTP id q66mr9678386pjq.83.1561690199548;
        Thu, 27 Jun 2019 19:49:59 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id b135sm454729pfb.44.2019.06.27.19.49.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 19:49:59 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Murray McAllister <murray.mcallister@insomniasec.com>,
        Kimberly Brown <kimbrownkd@gmail.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Anirudh Rayabharam <anirudh.rayabharam@gmail.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Nishka Dasgupta <nishka.dasgupta@yahoo.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        Emanuel Bennici <benniciemanuel78@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 20/27] staging: rtl8723bs: remove unneeded memset
Date:   Fri, 28 Jun 2019 10:49:49 +0800
Message-Id: <20190628024952.15866-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_zmalloc already zeroes the memory,
so memset is unneeded.

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

