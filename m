Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA24FC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 06:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A27220851
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 06:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMW6xTQP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731893AbfEXGAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 02:00:42 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40960 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfEXGAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 02:00:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id q17so4638627pfq.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 23:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xmWkuG4jWMx5HwzGG7LjcSnzIV8NJErFDTw3zvRqZ+Q=;
        b=TMW6xTQPH1cXrYsBYFEjWou6SN/ARTFeyk422n9y3fNeJ0z/KrnBminyYJZPG0ek7W
         rULFKnulO1Z9iOXL70jVyvU0lqUd2QB/d0QmHXFUITHgRebc0WT6GycFAhnQf2P/ghJV
         YVGxR8+jUDr0FCr8k1Bc3uNQ6eiF027M5hyVabzbk3w0TqEklvRojaCtV/HMs+BgyZ0E
         n8UNj0mxMHncQRiTbaS6D89sICK+ydDtOhpuvKw68wS6JgyWOvgYAX2CPt3uk2C/CakB
         r6c2IPStvwR2mJahhgGWpBhIFQmKuHxLlgSBd/9AX5z4cJbw0Txx42Fws8RD7L4F0qPS
         yiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xmWkuG4jWMx5HwzGG7LjcSnzIV8NJErFDTw3zvRqZ+Q=;
        b=KMM9dP3QbPpKW4jFcFN4zQ6v77YBEIOs/oLiPSTadhjctD0S2uKuzoi29ikc7oj7Og
         CprzhqAa1aoiemMCXaWzwPjQDaFzv5m1bKhcrD+IJT6L1HuRAbDbB+UnwHD9T3k0nxD/
         QFtopOSFpKEX4cCBGz474zKGrn051eSwjIHv73yrq+prnaZ/VjPeseV659iRzQvky9nz
         ZX5wHKlliEoxQjas6IicldixhSOY8nw7ZeKkT7i0/diDqmCMQ4Phly1Qe4TJcW5P1kzi
         C63VOdBF0r8wuv0B3Aq/05ZE3LtbFEdWvjs769eEfvRyxkYk68z7FIKfq4HEGsAl06u4
         q7oA==
X-Gm-Message-State: APjAAAXSZEyDOnO0nKPCH04wt8qIEiSwnnRGqWUlAxtuhxRLEwNx2ACP
        emqOFlvEMofXiMFWPwh0ni8=
X-Google-Smtp-Source: APXvYqxXNJ9laQAdHSk2ZdCQdd0iJh/nHXwrpS5GNtFqzMpDXRXdg65pICUW9gDYf2NWfnu5Q2j5cg==
X-Received: by 2002:a63:3d0b:: with SMTP id k11mr103413349pga.349.1558677640953;
        Thu, 23 May 2019 23:00:40 -0700 (PDT)
Received: from localhost.localdomain ([110.225.17.212])
        by smtp.gmail.com with ESMTPSA id 5sm1267426pfh.109.2019.05.23.23.00.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 23:00:40 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     gregkh@linuxfoundation.org, colin.king@canonical.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH 1/2] staging: gdm724x: Remove initialisation
Date:   Fri, 24 May 2019 11:30:25 +0530
Message-Id: <20190524060026.3763-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial value of return variable ret, -1, is never used and hence
can be removed.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/gdm724x/gdm_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gdm724x/gdm_usb.c b/drivers/staging/gdm724x/gdm_usb.c
index dc4da66c3695..d023f83f9097 100644
--- a/drivers/staging/gdm724x/gdm_usb.c
+++ b/drivers/staging/gdm724x/gdm_usb.c
@@ -60,7 +60,7 @@ static int request_mac_address(struct lte_udev *udev)
 	struct hci_packet *hci = (struct hci_packet *)buf;
 	struct usb_device *usbdev = udev->usbdev;
 	int actual;
-	int ret = -1;
+	int ret;
 
 	hci->cmd_evt = gdm_cpu_to_dev16(udev->gdm_ed, LTE_GET_INFORMATION);
 	hci->len = gdm_cpu_to_dev16(udev->gdm_ed, 1);
-- 
2.19.1

