Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085F6CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 13:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6CB214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 13:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCyAY8ks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfJ0NG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 09:06:29 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55724 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfJ0NG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 09:06:29 -0400
Received: by mail-wm1-f66.google.com with SMTP id g24so6675554wmh.5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 06:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E48jVCfAGOKBFgNTIr5FbZLg41IvwUd7cL0m7x4ZdGI=;
        b=UCyAY8kshvJ/xio2kzAtDjo1XBcDV6Ptj+pV2Qj5GO+Dt1q0l9sVd0TQfFwbhzJDXF
         5EyS/10um7GapAjwCbynnklu2gX0d8zETV10IJb9S0FItZZm8zjFu6RJb0NcRz/lDLf3
         HHInOXTNWOwAel0DdKeAzzC3uXO6qzM9hsxZWvIpEGf21/Ne5hxrRlJwZar3N5ankgnj
         UsuTAmZheuce6GSEPUYeShirjZtSiKBctUHaGjS2xPIfJZNYcuzI0bl4+BxMaQGjbj8e
         GNUM+iH7+Fs4Kx42iY3hr/DiiAKKTOfMIePSg0KXNiQ/Ar6GF7PZlKb9TgCLVFvqnOMz
         3SXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E48jVCfAGOKBFgNTIr5FbZLg41IvwUd7cL0m7x4ZdGI=;
        b=BoymUUV8tC8uX1fGQE38fRyfZMPA5oEUlUX1JkIfZpqcbaIfGAULbAywMaxczHly72
         8fmdxl7hYL8CnZLDGrzw5+emnuCcySFeFJ4VzQrTVQfb6pFv+j3NNryjmj9rwAWOQMQw
         GUwHH1FTcUDgr5s99eeTLfVGlCa+b/hkFEY6/C0VgEqCrkBfOeAPNq4eL7+yLtUgCVd4
         KwnrjlVW60Dek4mOGOlk2+j0mdK/zbwbIrk15f1ebl9Hpeh+eqefRoB6DJiCYz062KvI
         K1gXDdeJcYIBLYBDGoRLpThdygog6Q17Loe6pe/Xtp6h/k8FZ0fuFxs9xq4mWfqaD6se
         VMAw==
X-Gm-Message-State: APjAAAWEepMAWCSJa/micnIPkdxaEDy1Gz1fZgQulg8XQqUqrbCvafPN
        fmGVAjRwyDHGkYsKD8hV5u7hzgsS
X-Google-Smtp-Source: APXvYqzK3CGe68HpHPiGJCa/XaQHHGLYs3nQW1zlv+QMKy7bFZY43rXprGrWHoxwVdwMV9YeSPRagQ==
X-Received: by 2002:a7b:cc88:: with SMTP id p8mr6132704wma.80.1572181587759;
        Sun, 27 Oct 2019 06:06:27 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id 126sm8127371wma.48.2019.10.27.06.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 06:06:26 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH 1/4] staging: rtl8188eu: remove exit label from rtw_alloc_stainfo
Date:   Sun, 27 Oct 2019 14:06:01 +0100
Message-Id: <20191027130604.68379-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove exit label from rtw_alloc_stainfo and simply return NULL
instead of goto exit.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_sta_mgt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
index 776931b8bf72..65a824b4dfe0 100644
--- a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
@@ -181,7 +181,7 @@ struct sta_info *rtw_alloc_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 					struct sta_info, list);
 	if (!psta) {
 		spin_unlock_bh(&pfree_sta_queue->lock);
-		goto exit;
+		return NULL;
 	}
 
 	list_del_init(&psta->list);
@@ -194,8 +194,7 @@ struct sta_info *rtw_alloc_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 	if (index >= NUM_STA) {
 		RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_err_,
 			 ("ERROR => %s: index >= NUM_STA", __func__));
-		psta = NULL;
-		goto exit;
+		return NULL;
 	}
 	phash_list = &pstapriv->sta_hash[index];
 
@@ -246,7 +245,6 @@ struct sta_info *rtw_alloc_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 	/* init for the sequence number of received management frame */
 	psta->RxMgmtFrameSeqNum = 0xffff;
 
-exit:
 	return psta;
 }
 
-- 
2.23.0

