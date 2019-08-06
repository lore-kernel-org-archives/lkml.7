Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708CDC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 23:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34809208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 23:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pOeEa8YD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfHFXpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 19:45:47 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42206 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfHFXpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 19:45:46 -0400
Received: by mail-qk1-f194.google.com with SMTP id 201so64351998qkm.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 16:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=KwjfUXmkMLwgZFzBGBkcCMuagBT54f1cClmLSvTViy4=;
        b=pOeEa8YD7yD0xUZQ1hrLvbZ09z6x76B+kHNbrFpS14L3PoUF6eMTrzSo0L7N2EIAt1
         ex4NpR3hXOmJhcT4cxvbLBYubBz0QOqaiI3OyIKZq8dyxju2lSRis4VgNYNPtTBkaFwm
         cFTBRJbSoLIa9GhGn+AWNMhudYyppdiEMQQEKXvsJVPpctFB0PjMREVDwheEtgOvQ/9P
         ZETPPi0k25KcwTQOp3EDKsh/MOvamkmpCMYcirnWCweiXcrNCDYHdgV53HHTddtOtXPz
         PmdcyWTGfptCWZ7EGELgLreKebAi6GR/v+2nCUEKme0VBgIObTNz9LwFysJf/sKc94zJ
         bTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=KwjfUXmkMLwgZFzBGBkcCMuagBT54f1cClmLSvTViy4=;
        b=BHuzys5BeEUVrte+d1g98WmvbrOigxoZUMH0TPIgHGqUjkT98u2F42hqWyQz5SWWON
         yUvkKJxJW6eliu74vkIsTGsEwlSH6LC584Fy5OD70L6auB1YXpBdJCDzT7XpZaB1P/Po
         ka60gFKFFSG1N5+YrD8ATAh5YWTOj6DkOobUNq22yc151ijf/odSrOfEbO/5BvHqoYwl
         AOyYXDigUVYSbXTqJfwovbtYXwx4ZU/YP0tTBulz4NSMTP4cOKxji1iOmipkr9VeueMT
         sAJ+3PYrRoXeyEYIlWgR9Aydkx3PUqBKORYrZs0AjHff7uRHK73W7/8A9IGIYzamSsaT
         NEdg==
X-Gm-Message-State: APjAAAXZOWvnTc/gq+5i+ZOsMhIgNU59qGtqn3D+ngsb7I2VKSqp0RDU
        +BZCQQQHAxYAykRyGAxiiE8=
X-Google-Smtp-Source: APXvYqx8Umtbcef0JHFuEG9mSgOJNaXWzjh9roUKT7NrNsVVRAQZJktaCKmTGvpjkbPE1SEBDt93AQ==
X-Received: by 2002:a37:d95:: with SMTP id 143mr5666435qkn.132.1565135145544;
        Tue, 06 Aug 2019 16:45:45 -0700 (PDT)
Received: from cazarin-lenovo.ic.unicamp.br (wifi-177-220-85-250.wifi.ic.unicamp.br. [177.220.85.250])
        by smtp.gmail.com with ESMTPSA id k25sm47873987qta.78.2019.08.06.16.45.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 16:45:44 -0700 (PDT)
From:   Jose Carlos Cazarin Filho <joseespiriki@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Subject: [PATCH] staging: rtl8723bs: fix brace position in enum declaration
Date:   Tue,  6 Aug 2019 20:45:39 -0300
Message-Id: <20190806234539.7513-1-joseespiriki@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix two checkpath errors of type:
"open brace '{' following enum go on the same line"

Signed-off-by: Jose Carlos Cazarin Filho <joseespiriki@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_mlme.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme.h b/drivers/staging/rtl8723bs/include/rtw_mlme.h
index d3c07d1c3..2223e1f13 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme.h
@@ -81,15 +81,13 @@ enum dot11AuthAlgrthmNum {
 };
 
 /*  Scan type including active and passive scan. */
-typedef enum _RT_SCAN_TYPE
-{
+typedef enum _RT_SCAN_TYPE {
 	SCAN_PASSIVE,
 	SCAN_ACTIVE,
 	SCAN_MIX,
 }RT_SCAN_TYPE, *PRT_SCAN_TYPE;
 
-enum  _BAND
-{
+enum  _BAND {
 	GHZ24_50 = 0,
 	GHZ_50,
 	GHZ_24,
-- 
2.17.1

