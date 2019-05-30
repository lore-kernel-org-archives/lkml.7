Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82C2C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 20:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97BB22618F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 20:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oE25Ep7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfE3Uzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 16:55:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42562 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3Uzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 16:55:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id r22so4698891pfh.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 13:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uteyPwppfLddUxR1+sE7iM1BJAEP/f3DTyxZGmrJeF4=;
        b=oE25Ep7xqDsbPY+5NCN6qcKjPrmaBJqGm9Jwu3KOxRqgsQCVFS2RVHHigWj6oXIESq
         8CnmtxtPXVuMgPRquWSEReIZBceayYrSvV8/zgAg8sOmsRlYaRAcFa3XSm06Zmg2M5Ct
         vV280Wy72vDO69MCNEXTBo/yAdVXk4wFvGxz04NTAHZvsZQZchjurT3X9GKRardssZ18
         E5QYw86gnqzTmLgCiGkWmXAqP9M8fIfEK/h0Dtx/e0NngadhuIORwxHBfCCQh0/ycFyc
         FrgiMLA4MqqqyQDA02aJOXfzUI+KelN845m/rXxHFIIXBbiIp8vDwDfkUVW463oxY7zE
         KR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uteyPwppfLddUxR1+sE7iM1BJAEP/f3DTyxZGmrJeF4=;
        b=Tr5dyrVMTyxtvAVBVKIez+CfALXAGVqIBsd81z8tNH/OPj6TNZH9r+Dum0EjxzxUgM
         turAgo6l1Kq2O+qKgn0iwnXmW81+jmbP+3bZFM0mJrb7BvJ9wXCBy+i854rXy/9LSPjh
         IBGPo+Iqj/qQNTuQDPJskx5Nk6VnqToCKZjrxKwFFupOuwZJJC6BvvCiXyl6ZKlvAQHz
         AEo1/V7PX8z7oJ09xqd6f1rVlMuiGbTvo2d/PbDKBn95CD43+BT2PQWDiZweHjNsqP7X
         6MB1jFz2m/8RJZbfALDXT9BC6B8QKo673Urrv7fDS1MlsyiAps+LqGu3lTCc6xyuCQzM
         V+Yw==
X-Gm-Message-State: APjAAAWdkPN7JtwYYSXJISaDGv3H2gQ1Gk6LWXG/n3452UevRzkJBabw
        KvuVkaz+ASi2yFiYCgcbzro=
X-Google-Smtp-Source: APXvYqyNlAlC5Pbp/Qy5331BHKkGNGIynoOtauF7yLjK9abrJ+4vwYu9rlTnuQuugdWffvBv7AxbwQ==
X-Received: by 2002:a17:90a:2268:: with SMTP id c95mr5319802pje.8.1559249746772;
        Thu, 30 May 2019 13:55:46 -0700 (PDT)
Received: from localhost.localdomain ([47.15.209.13])
        by smtp.gmail.com with ESMTPSA id k3sm3426676pgo.81.2019.05.30.13.55.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 13:55:46 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     larry.finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, himadri18.07@gmail.com,
        dan.carpenter@oracle.com, colin.king@canonical.com,
        straube.linux@gmail.com, yangx92@hotmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] staging: rtl8712: Replace function r8712_init_mlme_priv
Date:   Fri, 31 May 2019 02:25:31 +0530
Message-Id: <20190530205531.30016-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete r8712_init_mlme_priv as it does nothing except call
_init_mlme_priv, and rename _init_mlme_priv to
r8712_init_mlme_priv.
Change the type of the new r8712_init_mlme_priv (formerly _init_mlme_priv)
to (non-static) int, from static sint.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_mlme.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
index 7c7267d0fc9e..57d8e7dceef7 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -29,7 +29,7 @@
 
 static void update_ht_cap(struct _adapter *padapter, u8 *pie, uint ie_len);
 
-static sint _init_mlme_priv(struct _adapter *padapter)
+int r8712_init_mlme_priv(struct _adapter *padapter)
 {
 	sint	i;
 	u8	*pbuf;
@@ -205,11 +205,6 @@ u8 *r8712_get_capability_from_ie(u8 *ie)
 	return ie + 8 + 2;
 }
 
-int r8712_init_mlme_priv(struct _adapter *padapter)
-{
-	return _init_mlme_priv(padapter);
-}
-
 void r8712_free_mlme_priv(struct mlme_priv *pmlmepriv)
 {
 	kfree(pmlmepriv->free_bss_buf);
-- 
2.19.1

