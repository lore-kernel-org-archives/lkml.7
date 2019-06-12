Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE9AC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 04:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C27206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 04:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOLlgZ0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730331AbfFLEv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 00:51:57 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36613 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730250AbfFLEvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 00:51:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id r7so2970482pfl.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 21:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DEmxJ1y8Xphky4GgaRipyHigYCjOMYrrza17sBJRETI=;
        b=oOLlgZ0Y0Lk6g9JoLLBk/gvdpBClWNSmOusuT5XuBfgqtiWdDyB5W3F9a0hG7SqApF
         KP44aQ4Yy7x57XCoQakK7decQs6Q4SYMhHrhwZHqBCJsHlnsL92CpRUoKLdjS+D6dISX
         rz0ywncEu+14EJJ6MwJdmQQgpQtCRpJ4nqOGzupzjQq2Dl5bsBvGy2nWzODD9/14nQoh
         82U4Z4o/1A0cCRc9wnSWHNh3EnjbJmhmQTPhkR2Gp4tMmHOfgX78+uRPJLx0987m6Bq7
         oYpy6q+2iC3lS2fuQluaqus04yhtZ1WBmR9LIdmW7ikTMQn6gQKOVJ843hi5xNYf9+Yr
         opOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DEmxJ1y8Xphky4GgaRipyHigYCjOMYrrza17sBJRETI=;
        b=H127+zN807B5wJugy1WiVzttBGCIZ/EN/U1cKav0XblamSk3pFxlsWkKojq4DV2DPv
         z86PImZ8BwPcrH2uNH8WDWaEYCrbVxe97NFU/0IxRmUQ8vnUuz/puedNt7kaspcWI0Fc
         XKjfr13IxrbUHX+yuGo7530T7YblyQGyrzzweRWZgL0C5qV/HkG0kUv+KqTYLhrbcdj6
         WOtGad28xcH6N4tysnYNn4wLyXvmWPe8z1r/ZQJ5tJkAgvk8hM+CID6HAnPLM1m3URF6
         8E5AXB1gcdX1IBO+HQAMLE6LzOsSrTo1StzBH4i2sbeJGgJUasknUqqqNpsgRkINNwtn
         qbew==
X-Gm-Message-State: APjAAAXiICAJw9kx1hb8J1jDBpMi+2BYQ34ekvgUJCB2IF9Hew2bLDcN
        15ih55+Y+GHdYBXZEqtrz8ZYCZOc
X-Google-Smtp-Source: APXvYqyLVc4Pfy9Eu0GhyYp4YNRgjEqdzDKongcKZpl6y60uPBvLpVjM67FFKM7vffVuszQngXQLvQ==
X-Received: by 2002:a63:4c1f:: with SMTP id z31mr24113150pga.334.1560315114625;
        Tue, 11 Jun 2019 21:51:54 -0700 (PDT)
Received: from localhost.localdomain ([117.192.27.213])
        by smtp.googlemail.com with ESMTPSA id t184sm1072719pgt.88.2019.06.11.21.51.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 21:51:54 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux.dkm@gmail.com, straube.linux@gmail.com
Subject: [PATCH 1/2] staging: rtl8712: Fixed CamelCase lockRxFF0Filter renamed to lock_rx_ff0_filter
Date:   Wed, 12 Jun 2019 10:21:30 +0530
Message-Id: <11e5138b4e80a3d5dea4684c7b5db7a59b99dd56.1560314282.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1560314282.git.linux.dkm@gmail.com>
References: <cover.1560314282.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In process of cleaning up struct _adapter in drv_types.h, lockRxFF0Filter
 is renamed to to lock_rx_ff0_filter to fix a checkpatch reported issue.

Signed-off-by: Deepak Mishra <linux.dkm@gmail.com>
---
 drivers/staging/rtl8712/drv_types.h  | 2 +-
 drivers/staging/rtl8712/usb_intf.c   | 2 +-
 drivers/staging/rtl8712/xmit_linux.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
index c36a5ef3ee5d..79d10b6fbfda 100644
--- a/drivers/staging/rtl8712/drv_types.h
+++ b/drivers/staging/rtl8712/drv_types.h
@@ -160,7 +160,7 @@ struct _adapter {
 	int pid; /*process id from UI*/
 	struct work_struct wkFilterRxFF0;
 	u8 blnEnableRxFF0Filter;
-	spinlock_t lockRxFF0Filter;
+	spinlock_t lock_rx_ff0_filter;
 	const struct firmware *fw;
 	struct usb_interface *pusb_intf;
 	struct mutex mutex_start;
diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
index 200a271c28e1..d0daae0b8299 100644
--- a/drivers/staging/rtl8712/usb_intf.c
+++ b/drivers/staging/rtl8712/usb_intf.c
@@ -571,7 +571,7 @@ static int r871xu_drv_init(struct usb_interface *pusb_intf,
 	/* step 6. Load the firmware asynchronously */
 	if (rtl871x_load_fw(padapter))
 		goto error;
-	spin_lock_init(&padapter->lockRxFF0Filter);
+	spin_lock_init(&padapter->lock_rx_ff0_filter);
 	mutex_init(&padapter->mutex_start);
 	return 0;
 error:
diff --git a/drivers/staging/rtl8712/xmit_linux.c b/drivers/staging/rtl8712/xmit_linux.c
index 223a4eba4bf4..d8307bcc63f5 100644
--- a/drivers/staging/rtl8712/xmit_linux.c
+++ b/drivers/staging/rtl8712/xmit_linux.c
@@ -102,9 +102,9 @@ void r8712_SetFilter(struct work_struct *work)
 	newvalue = oldvalue & 0xfe;
 	r8712_write8(adapter, 0x117, newvalue);
 
-	spin_lock_irqsave(&adapter->lockRxFF0Filter, irqL);
+	spin_lock_irqsave(&adapter->lock_rx_ff0_filter, irqL);
 	adapter->blnEnableRxFF0Filter = 1;
-	spin_unlock_irqrestore(&adapter->lockRxFF0Filter, irqL);
+	spin_unlock_irqrestore(&adapter->lock_rx_ff0_filter, irqL);
 	do {
 		msleep(100);
 	} while (adapter->blnEnableRxFF0Filter == 1);
-- 
2.19.1

