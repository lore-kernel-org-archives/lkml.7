Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71F2ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEAC0208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u8Ng/a9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfJJN5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 09:57:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56145 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfJJN5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:57:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id a6so7052543wma.5;
        Thu, 10 Oct 2019 06:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yJGdOYILL8kJ5SPdZdHmvJP7tXBLkUNJvrUzb6ANFWI=;
        b=u8Ng/a9dlF4zJDy3XWXa92ikk0qVSsuwM0N7MmOzC2RZes/uwN3t3j+e3pvzC1mdPm
         u7B31QUxyUx15DTYeTmifwIZGa7I0tVDGnQMOrXyLSFTsPnyPVlhbwwUofUcFrJ+tcuP
         Ns28G+4nKopaVXFz3SrgXEUMjFW7kqg0h5yrfCKtTNmOLEdTn6GJoO4cyJ+8n7cXZDlh
         /DKe29n9JbSZNqGH3KdQfZ/2JlEWU1LlcU020avuf1wwZuCl6jChuV54xZU0vrkkCt9f
         a8VN80sHKOB6UyWkeH0BLaOAIwv6p92f3qJs7Y9mWw8VB6X+pCLdvmVKSEd5aUetXx8f
         naEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yJGdOYILL8kJ5SPdZdHmvJP7tXBLkUNJvrUzb6ANFWI=;
        b=FFREntuLHKIcnr6smYaooAaSuErRUrMVaE/cCnmqyS18bXdeJiTsdd4icDRzZ7KKvm
         p7Y2nzK1oJxboVpLGgUcME970bivM5Vy5g0YSXJ7YkBP7Z+zNpF2pteoDG2ds31dvNaI
         3lAK5ZD2i2CEj54e6CcyMBBr4+oPx4IIITsvWkvbJQcuLjwpNhMB2reMRenXL3h2t7pY
         aSQ9FfyziYMBWUIwmnogsTfb5Nf0ZwETOAItAb/28NqiZdQFuEbWLiA7EEk13sA6mfGg
         Qs1ILs+6KErhg06p0U83nqDTCizbnDRuP7aeleQrg8Whi6vZRG1ls4kzuJpFhaFLBigB
         pCPw==
X-Gm-Message-State: APjAAAWGcGU+CDZKdwBnW1wzxFJ2e8LwRhObW+XxRDvu7fx+7TMS7UWk
        47+IbMniDGQ0szvk8eVb7PNWcnpXZqI=
X-Google-Smtp-Source: APXvYqzWaTnlpPi1sGhj49r0BCSr6EDWlbwIRn50sa+BrEd8ZxLNZ6u8GuB1eTDow9DwyhrrLzUPQQ==
X-Received: by 2002:a1c:1bc5:: with SMTP id b188mr8104321wmb.88.1570715829333;
        Thu, 10 Oct 2019 06:57:09 -0700 (PDT)
Received: from localhost ([194.105.145.90])
        by smtp.gmail.com with ESMTPSA id h125sm9024318wmf.31.2019.10.10.06.57.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Oct 2019 06:57:08 -0700 (PDT)
From:   Igor Opaniuk <igor.opaniuk@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Li Jun <jun.li@nxp.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] usb: chipidea: set mode for usb phy driver
Date:   Thu, 10 Oct 2019 16:56:55 +0300
Message-Id: <20191010135656.3264-2-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191010135656.3264-1-igor.opaniuk@gmail.com>
References: <20191010135656.3264-1-igor.opaniuk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Jun <jun.li@nxp.com>

After enters one specific role, notify usb phy driver.

Signed-off-by: Li Jun <jun.li@nxp.com>
Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>
---

v2:
- restored original commit author
- fixed build for multi_v7

 drivers/usb/chipidea/ci.h | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
index 6911aef500e9..cf9cc9402826 100644
--- a/drivers/usb/chipidea/ci.h
+++ b/drivers/usb/chipidea/ci.h
@@ -275,9 +275,21 @@ static inline int ci_role_start(struct ci_hdrc *ci, enum ci_role role)
 		return -ENXIO;
 
 	ret = ci->roles[role]->start(ci);
-	if (!ret)
-		ci->role = role;
-	return ret;
+	if (ret)
+		return ret;
+
+	ci->role = role;
+
+	if (ci->usb_phy) {
+		if (role == CI_ROLE_HOST)
+			usb_phy_set_mode(ci->usb_phy,
+					USB_CURRENT_MODE_HOST);
+		else
+			usb_phy_set_mode(ci->usb_phy,
+					USB_CURRENT_MODE_DEVICE);
+	}
+
+	return 0;
 }
 
 static inline void ci_role_stop(struct ci_hdrc *ci)
@@ -290,6 +302,9 @@ static inline void ci_role_stop(struct ci_hdrc *ci)
 	ci->role = CI_ROLE_END;
 
 	ci->roles[role]->stop(ci);
+
+	if (ci->usb_phy)
+		usb_phy_set_mode(ci->usb_phy, USB_CURRENT_MODE_NONE);
 }
 
 static inline enum usb_role ci_role_to_usb_role(struct ci_hdrc *ci)
-- 
2.17.1

