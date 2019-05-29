Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D53C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078B12183F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhllIkwG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfE2NZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:25:11 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34031 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfE2NZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:25:10 -0400
Received: by mail-pf1-f195.google.com with SMTP id n19so1650574pfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 06:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fc0bMmRDevQdvcZymPuPXJYIf7p7D4ZnMyLrt05NU1Q=;
        b=EhllIkwG6rXdSQe7QvJaCmmP69I4HJ5aCk+e6JLCT/uIwhqVWUQkV9ZlxJm+73DdqE
         FnZTc4ERk39gUsFBOAeUbbVuhUgDPOv2U4LtAlAxrhQx0u5Le0eRXyzZplN2HbAnbb7r
         KKyLv3svObFPiC+GWfqHDzmUSkBdY7FKjzABle/GARb4dLmRutCU/8nJD7y/QYtjNyor
         hw4YcIc1LBVBmZlXP2L2JxXsWc5cWp6CJBskKUjIoUOUvRWCNDwUx9NyY1C931W9LEel
         BcyZ0KwoQVlI6A7+goNb7viWimvwQNFLAKSe0aCuJ10YJvBf3Hz8yQi3wDXhPD/480Ch
         C89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fc0bMmRDevQdvcZymPuPXJYIf7p7D4ZnMyLrt05NU1Q=;
        b=Horf/S+Dwdru744xpVgUq44aM6OEpI3LpgPZlgCbpkxfKQTA8uEk2G3WhMkdx7OWCl
         QX9vk1+N+iiijUq8BbCgfOVx8tYZlWBOfXsg+cRyI6gtcNavlIyUBpTp1Crd1tFSi9gC
         t6VkZjc963WAfr/vMukt8oCPaqLMsJV4ptLYeziYcapOcFn4aulTdjEVvRdulhUNR/kw
         1t+HUVuo4Dtx3sPtN7veYl7dtK23/u49n3kfCVDf4xEFOayf1UDGXd+9oyipwf6GeN0B
         b1mqjXHJxh06E0TEKnlFPJeMLP0FrrKahQwDcxNIHqmpOo8iXq8PxS+FgMTYpXCTfnHO
         +YBQ==
X-Gm-Message-State: APjAAAVdcIO00QZphmdFBq5cDtkZCAFjmM1FBpHCuwQTmgGuTjvc+zzl
        +gD/qOmHxMiqVV0cJLVEGmE=
X-Google-Smtp-Source: APXvYqz0h58Zk+4/mpryWNDyPJFYqURdAmcglB7phMR6hBDG9LWeOuIsrajsDXn56dZUX8G8uLPPDA==
X-Received: by 2002:a65:530d:: with SMTP id m13mr44176772pgq.68.1559136310405;
        Wed, 29 May 2019 06:25:10 -0700 (PDT)
Received: from localhost.localdomain ([122.163.67.155])
        by smtp.gmail.com with ESMTPSA id k14sm33057573pga.5.2019.05.29.06.25.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 06:25:09 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     larry.finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, himadri.18.07@gmail.com,
        valdis.kletnieks@vt.edu, colin.king@canonical.com,
        straube.linux@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] staging: rtl8712: Remove return variable of different type
Date:   Wed, 29 May 2019 18:54:57 +0530
Message-Id: <20190529132457.6607-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The local return variable ret may be replaced directly by its value,
especially since its type (uint) is not the same as the function's
return type (int).
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
index a7230c0c7b23..b424b8436fcf 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
@@ -1577,7 +1577,7 @@ static int r8711_wx_get_enc(struct net_device *dev,
 				struct iw_request_info *info,
 				union iwreq_data *wrqu, char *keybuf)
 {
-	uint key, ret = 0;
+	uint key;
 	struct _adapter *padapter = netdev_priv(dev);
 	struct iw_point *erq = &(wrqu->encoding);
 	struct	mlme_priv	*pmlmepriv = &(padapter->mlmepriv);
@@ -1633,7 +1633,7 @@ static int r8711_wx_get_enc(struct net_device *dev,
 		erq->flags |= IW_ENCODE_DISABLED;
 		break;
 	}
-	return ret;
+	return 0;
 }
 
 static int r8711_wx_get_power(struct net_device *dev,
-- 
2.19.1

