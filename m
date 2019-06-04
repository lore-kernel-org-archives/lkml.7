Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8743C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD63B24708
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbzFG4Sn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfFDH3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 03:29:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37884 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfFDH3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:29:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id a23so12156904pff.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 00:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nrKtzgwsFX1PUmXu/7B43BStSve4zFN2R+Q+Z9Etw+w=;
        b=pbzFG4SnJoI7oaSquK9yetWqxxzHGXWMyGlWA7JSEn4z4q5sl8ca4oOXK4DZLmhAea
         kD/sVKZFs+ASGtjDjkycPRCYrHCeK+J8SHdSmnTDrkRcD1gGohJE/yWFxSsTpwUcxeSN
         fAPyJAn+v+f6pkGrjHIn9Xb2opkLrJUVO8yTe9vZT8rf3HeID6Zb3/1hk4KacMZ4Ay9J
         HdbEfbr+0woI5BlLc3MYnHtYgz/beI/al2XdXPw2D2nscRGoRWzyHo5ZLzTxHN+MC9Am
         +EWIbZ6iQ9Y1HZuYQSuc3yv86GW8siZfNuRNxPIlyoaBajBnVLCfPYnnIHcYw+AhBpPk
         x7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nrKtzgwsFX1PUmXu/7B43BStSve4zFN2R+Q+Z9Etw+w=;
        b=J9cvU3zCclMXXr/X0dNYbbf5lBc6WhItCgdIBhrgPhl6rcUN11bRyh48yIKOdJFtjN
         IYblhHTCZdsP24MLIJGbWo5CzdmOsx4We19a2ED55XK2KwtYjck9OA77pqlpJvqOQl7v
         wQj61QESnXsy7aY9Ocx6bO/vEBMeOnXnw4e8ROVY3mVy/S6s8achMHNoMRGlRHHO1BsG
         15lEOcd1pQ/FKulsvMo7TsRnMK7Ee40MFAF+MvgemtHx08zoEsqR6mjhn5r13VzJVIUz
         XuNaal243CF76GxEmBSd8iGxl3yV6WN+wt7W7OIIxxJ4T6IkeWM/+JR8Bl3jscbUg29L
         HQ2w==
X-Gm-Message-State: APjAAAWzhuyggu7T4FNC+SQ1t33Au908Pv+4ga4MAYQSsJ1CJiz7egWA
        stl17U/7vDwMNWLIoOwhZTiW11ID
X-Google-Smtp-Source: APXvYqwV0ORhfQ4UxlV9Ses3tVJ8a//PDsmTJdRs30qBLI6S8XvaeOaaTzk5pn1PmhozZrZNa2vTAA==
X-Received: by 2002:aa7:910e:: with SMTP id 14mr36434739pfh.153.1559633379878;
        Tue, 04 Jun 2019 00:29:39 -0700 (PDT)
Received: from localhost.localdomain ([110.227.95.145])
        by smtp.gmail.com with ESMTPSA id e124sm23053953pfa.135.2019.06.04.00.29.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 00:29:39 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     gregkh@linuxfoundation.org, larry.finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, straube.linux@gmail.com,
        himadri18.07@gmail.com, yangx92@hotmail.com,
        colin.king@canonical.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH v2] staging: rtl8712: Replace function r8712_free_network_queue
Date:   Tue,  4 Jun 2019 12:59:24 +0530
Message-Id: <20190604072924.10866-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove function r8712_free_network_queue, as it does nothing but call
_free_network queue; rename _free_network_queue to
r8712_free_network_queue to enable continued functionality; change the
type of r8712_free_network_queue (formerly _free_network_queue) from
static to non-static to match the type of the old
r8712_free_network_queue.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
Changes in v2:
- Amend commit message for accuracy.

 drivers/staging/rtl8712/rtl871x_mlme.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
index 57d8e7dceef7..f6ba3e865a30 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -151,7 +151,7 @@ static struct wlan_network *_r8712_find_network(struct  __queue *scanned_queue,
 	return pnetwork;
 }
 
-static void _free_network_queue(struct _adapter *padapter)
+void r8712_free_network_queue(struct _adapter *padapter)
 {
 	unsigned long irqL;
 	struct list_head *phead, *plist;
@@ -215,11 +215,6 @@ static struct	wlan_network *alloc_network(struct mlme_priv *pmlmepriv)
 	return _r8712_alloc_network(pmlmepriv);
 }
 
-void r8712_free_network_queue(struct _adapter *dev)
-{
-	_free_network_queue(dev);
-}
-
 /*
  * return the wlan_network with the matching addr
  * Shall be called under atomic context...
-- 
2.19.1

