Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A36C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1932021479
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeJvhHlD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfGBH7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:59:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35243 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfGBH7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:59:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id s27so7292879pgl.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 00:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0bTQJqSwGi9nlCbXiRpJgmp4Zz6lO++dVJIU4D0SCWk=;
        b=EeJvhHlDtmF0AiJkuyp02jQ6bBxeubzGKf5tVmYeW1K84gRYwOaH+htbpvw9Fv6pWf
         NRudNissL6eFtLps11SApKHFc+HOt2uVKKMUmKLW133WmAdal18hNNVgWqFOis6aZIg7
         VNl80lNlh3BJkXYgMncDoqhniWieMhZ62p3p8XDSRWQdezDBTeO840LBHfykqmwFQSKs
         u2Mqci4Up/HGyJVlb9h1ACGwRt/n20Jsp0frZM3kY7tfr+V4f+l1Qs8dh1QR0ENWvSW7
         XFe9chi0V5yX5Rk+rGlAoNAbbenKrN4wLfMFc652pNoMcFSFqp/MqzGJbw3jlWJciwmd
         BqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0bTQJqSwGi9nlCbXiRpJgmp4Zz6lO++dVJIU4D0SCWk=;
        b=qthYq/JAjXf88XkJSLp6zGrvqnoSKj0q6m6nX18CciNE6J9RJgqz1fs8azbrP4HZAv
         lu4hSTXDIAvm8nQSuYHE5d82RIxd6pF0ffea0F+hSjPlgit16A+49xYo0nEZaH5FGBnk
         B/RAGB4H4s7zWK8ZJQ3a4EjQcYyulL1/OPcmeus9cX0xhSl4msA2/7m4bOJud3Owg4WJ
         GIYYdV+PnmAqGYKjotdBDR11jVkNIOXuZ0RXeFkDyb0pIEXbxAayeEMxglwqTdk47zJc
         +EB6gOosLXhyDqMtvgVBRAf7sw51+IqOxobEKciCd9lWJ+gkNb9aKYIIUMX4KdWLIFvv
         1sZw==
X-Gm-Message-State: APjAAAWw6dkgMFfiC+bNAuxvbO92Ps4HUt49Zi7H+icS6vO9gMvkP7ch
        0muTFksuaK/IiIYK7ZMG4kAJ4CnTR+8=
X-Google-Smtp-Source: APXvYqwQfNBtwv8Uq33FKVinigDILmMpNsC/G+JuIcCRpc93izSnsF5FeqjbbuOTXPNfwPh+7SVmag==
X-Received: by 2002:a17:90a:24ac:: with SMTP id i41mr4031122pje.124.1562054362917;
        Tue, 02 Jul 2019 00:59:22 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id p1sm14855943pff.74.2019.07.02.00.59.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 00:59:22 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 20/27] staging: rtl8723bs: remove unneeded memset
Date:   Tue,  2 Jul 2019 15:59:16 +0800
Message-Id: <20190702075916.24446-1-huangfq.daxian@gmail.com>
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
Changes in v3:
  - Resend

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

