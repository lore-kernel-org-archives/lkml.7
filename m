Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB1FC2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 19:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191AD2080D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 19:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e2RremBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfLZTDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 14:03:52 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52247 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfLZTDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 14:03:51 -0500
Received: by mail-pj1-f66.google.com with SMTP id a6so3673504pjh.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 11:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1HRbjKd35Cia/8/yahM6SicmhvXLmAHSLQ8uWqh3y0o=;
        b=e2RremBeMKCiUD8Ab9pU1/MKomvHp+ebvMQWmzfptDJWx4eI50IQeThvO39NYD814S
         BNoljz3ka2GKLAeJSzDKRA2CgS7VZhV50ZhGguLdwkBz29NrEXF6UyvSlepm+6vePXJX
         tadTiNWQvjIaonCRoZvbPyG/Za1hPk1Cbd2os=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1HRbjKd35Cia/8/yahM6SicmhvXLmAHSLQ8uWqh3y0o=;
        b=CMvBXyfnECPrJUW8P3WA6R9dLfL6jvmuMtl2IOar6gRKzpGWdMZRu2fYxbW8kc2SJB
         /vxmzOZltOW4z7guV7+im8kxatyNtxDXILYRPZmuOTq1JeMgptnxhiJlqWIW5GlwQvWB
         1+QaN7XEiylSqalj+oegh4NB7dR+zk4vRF4CyeANBAmzxYRi8Fb5XWwKnj2+a/HSxWeD
         uAV+7CDXU92VD6caD21YxtCxDX3MwZJ2eqERVv08ATL9odWzkzGsuBpnz4ztnFexOiq4
         Em7e1UW6aEy2Q7FVChsps6CWrU7sL4IBTUrMMjx0rwr2cs+Dz7CEteqwvFkyXyhsumRS
         haiA==
X-Gm-Message-State: APjAAAWXqKZaEIoGGHG9Yrhyrf5t2yewu89+AK9mDSF22Eq6JWxHnBCH
        gMLF3Y8uoQZHCWDKmlssRMbKZQ==
X-Google-Smtp-Source: APXvYqwYGnjPFR2GvHC6Qk+yKrQNoFoEGJkU//8wbjkissUZma8D2N2gagVB/Ehj+gbwKOwYeD3z+g==
X-Received: by 2002:a17:902:6b8a:: with SMTP id p10mr33127202plk.47.1577387031318;
        Thu, 26 Dec 2019 11:03:51 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id q64sm12086336pjb.1.2019.12.26.11.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 11:03:50 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btbcm: Add missing static inline in header
Date:   Thu, 26 Dec 2019 11:03:40 -0800
Message-Id: <20191226190340.116205-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a double definition error when CONFIG_BT_BCM is not set.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

 drivers/bluetooth/btbcm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btbcm.h b/drivers/bluetooth/btbcm.h
index 3c7dd0765837..014ef847a486 100644
--- a/drivers/bluetooth/btbcm.h
+++ b/drivers/bluetooth/btbcm.h
@@ -78,13 +78,13 @@ static inline int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 	return -EOPNOTSUPP;
 }
 
-int btbcm_read_pcm_int_params(struct hci_dev *hdev,
+static inline int btbcm_read_pcm_int_params(struct hci_dev *hdev,
 			      struct bcm_set_pcm_int_params *params)
 {
 	return -EOPNOTSUPP;
 }
 
-int btbcm_write_pcm_int_params(struct hci_dev *hdev,
+static inline int btbcm_write_pcm_int_params(struct hci_dev *hdev,
 			       const struct bcm_set_pcm_int_params *params)
 {
 	return -EOPNOTSUPP;
-- 
2.24.1.735.g03f4e72817-goog

