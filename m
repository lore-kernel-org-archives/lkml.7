Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C79FECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC1E2173B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BArA0duk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfJGMrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:47:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33688 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbfJGMrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:47:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id b9so15174324wrs.0;
        Mon, 07 Oct 2019 05:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3+0xNKANMoqD2LM7Jb0KxrBIYqLeJsaQlJrD1LYqzho=;
        b=BArA0dukyOOQG0I91sTg+fEwZnhirpCntvT3S6t7//3e8XVIJPzesiuad/8zoZ9Myb
         BEvJFtw6zOUSdgz5WMyYito5s9Az/NqjCIRTp+dicUAyEKaJk2uxnD+sAcaN8L65nd0P
         iF6GD/vKVquAZcBNyStWpWjkhxEWykw0/WJCW2hoO+uUEWVvPbmhHvtby0pA9SJmNtjj
         81xsfkn2lnxP73Vjd2ZqVXmuHugrrpnHsEwjmgRdFLDXawGhcin1bN/hpEdfOjCBkJyt
         DOkuekKS8VGEKl4z/e+V51A/r99OBNtBOJctwPp2lFx4jU31ffrFUc59tD5UCR9MWQbo
         KZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3+0xNKANMoqD2LM7Jb0KxrBIYqLeJsaQlJrD1LYqzho=;
        b=RfkK66wgNfRgRLtLchOu5i1LVTMvo3DsTGVm/i4E6ZhCLkICgK1Uo4d6JXVDGRQjxl
         8nZE0zRcr3w3WPKVKKs4xtYGTElzbeeD8raP7aYTZHRuTbe9sStKRRQ43SPylNwCafvk
         VuSfRlGdyRoBE1GGTSFtQpLh0uQjn7Ho/sThYQE84O9ftBHUiSG2s5AO6V27kgkWLDF/
         czDjHV7iCGs3TRAmZGKt99f+kjYnkiHxESxghMIPo57tKh7y2Xo3VRRVXjhKqLtpAU2a
         R5LIfp6hyxxWbTZteqJLvWD16VFtJXfBpv1khBiR21tGJDwpwDlHwOyVAH5CRT4mRGwP
         kFsQ==
X-Gm-Message-State: APjAAAWJdAzU1xOXRsy/MbrO5rxX1hzrlasX6IO1j3hyMp7RitWLHuZw
        SOnGgUDoZXJtiOw4yeTmUtoyH2Zf2Ec=
X-Google-Smtp-Source: APXvYqwN3wNI0EhseuwoKQOqFG95vCPzBQL45WawolPwUaIlN31vWOdiUKmK1TZFmZ9zOpePr8lPFg==
X-Received: by 2002:adf:f7c3:: with SMTP id a3mr9788540wrq.275.1570452456841;
        Mon, 07 Oct 2019 05:47:36 -0700 (PDT)
Received: from localhost ([194.105.145.90])
        by smtp.gmail.com with ESMTPSA id b15sm18454390wmb.28.2019.10.07.05.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Oct 2019 05:47:36 -0700 (PDT)
From:   Igor Opaniuk <igor.opaniuk@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Li Jun <jun.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 2/3] usb: chipidea: set mode for usb phy driver
Date:   Mon,  7 Oct 2019 15:46:06 +0300
Message-Id: <20191007124607.20618-2-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191007124607.20618-1-igor.opaniuk@gmail.com>
References: <20191007124607.20618-1-igor.opaniuk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Opaniuk <igor.opaniuk@toradex.com>

After enters one specific role, notify usb phy driver.

Signed-off-by: Li Jun <jun.li@nxp.com>
Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>
---

 drivers/usb/chipidea/ci.h | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
index 6911aef500e9..a11d23910b12 100644
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
+					USB_MODE_HOST);
+		else
+			usb_phy_set_mode(ci->usb_phy,
+					USB_MODE_DEVICE);
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
+		usb_phy_set_mode(ci->usb_phy, USB_MODE_NONE);
 }
 
 static inline enum usb_role ci_role_to_usb_role(struct ci_hdrc *ci)
-- 
2.17.1

