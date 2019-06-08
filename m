Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6605BC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 10:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8A1214D8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 10:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLQfxhr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfFHK5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 06:57:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45100 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfFHK5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 06:57:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id s11so2586784pfm.12
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 03:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W01kyQuiomJSdOGk6Hwr4295vjRVUbIxGvLBRS4IPUU=;
        b=fLQfxhr6ZDyMxy7sBwhxaLfkBFWwuJFzicVGWGgbZPADWWnoF4yxXWlyw8Y4Wjpse8
         iLfjwm//bDtn2HNYvs+ZfWEbPrLl9kA2PSopz1p/KGR0C8CbCcbeMkCCVdW9XfjraRuw
         XQr1SSJMFoLrID9ypRKzrm1mrJinDXEfsiOV7RTz7O8cAbtT4k+54S0mJHJ5yW8VDWd4
         bowjtrxea88cw3UESEjUBVJWCyPgAw6Jd5mPUVe9x/inhlABU533Xn9RXjlfOFBnWBEk
         XChuksrq1tcZt6Qyj4Up3u7hbc/rlQqWVsTLgF2uNq/XDjp/QDdjz3baBJot/RMuPfAK
         TNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W01kyQuiomJSdOGk6Hwr4295vjRVUbIxGvLBRS4IPUU=;
        b=qRZXvn7pB0cz/CyDSZNB8kL7W+1h9Tafd8rtVREZHcXP4Yn6iXIIvKCEXgZjDJjDHv
         qMnhhDgPo6hkQ5qLvovcDtXvTm4mkhF27Mm8nU2YEJ45KV8GWiYTcr1sICISqavl+UVj
         zsOTimCHFSfjjyJCYKbojIKt0u2XAUkYgCefbdck7nSua5JbBmgWfU6/wy/DVJfUpF4v
         /24d8uf1t7WNjOv7lxZohTzx4hx6aQi6MEuMdzUSYMIclRUOnwqFo52+AkHWwqZsl0zK
         1TZWjk64b9LIeaNMdKH9sERbYBMQiOZrb7oJFhjyDRQCGH45EMLZr4W2mTtZIuI1+gWJ
         H7CA==
X-Gm-Message-State: APjAAAVia+bjBDfst6XjXOg9SN3dOS4SnrpYXRWFiMjVO4QjnfbT9yNJ
        61Rk3ZCwO4C58uIzI3loiKje5VaX
X-Google-Smtp-Source: APXvYqw8C65KQE8brTmH3P1EzYun77Ph9FHC6UcrYzXiIhgstIvZ6dGvKEJUkzquq6zJbSmc9CvasA==
X-Received: by 2002:a62:648d:: with SMTP id y135mr54910129pfb.98.1559991472045;
        Sat, 08 Jun 2019 03:57:52 -0700 (PDT)
Received: from localhost.localdomain ([117.192.25.72])
        by smtp.googlemail.com with ESMTPSA id s24sm5021384pfh.133.2019.06.08.03.57.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 03:57:51 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux.dkm@gmail.com, straube.linux@gmail.com
Subject: [PATCH v4 6/6] staging: rtl8712: Renamed CamelCase lockRxFF0Filter to lock_rx_ff0_filter
Date:   Sat,  8 Jun 2019 16:27:01 +0530
Message-Id: <2122d23efa51d35a0f4e4682061170751e0bb10d.1559990697.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1559990697.git.linux.dkm@gmail.com>
References: <cover.1559990697.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames CamelCase variable lockRxFF0Filter to
lock_rx_ff0_filter in drv_types.h, usb_intf.c and xmit_linux.c

This was reported by checkpatch.pl

Signed-off-by: Deepak Mishra <linux.dkm@gmail.com>
---
 drivers/staging/rtl8712/drv_types.h  | 2 +-
 drivers/staging/rtl8712/usb_intf.c   | 2 +-
 drivers/staging/rtl8712/xmit_linux.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
index 7838c945d622..0c4325073c63 100644
--- a/drivers/staging/rtl8712/drv_types.h
+++ b/drivers/staging/rtl8712/drv_types.h
@@ -160,7 +160,7 @@ struct _adapter {
 	int pid; /*process id from UI*/
 	struct work_struct wk_filter_rx_ff0;
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
index e65a51c7f372..71100613aeb3 100644
--- a/drivers/staging/rtl8712/xmit_linux.c
+++ b/drivers/staging/rtl8712/xmit_linux.c
@@ -102,9 +102,9 @@ void r8712_SetFilter(struct work_struct *work)
 	newvalue = oldvalue & 0xfe;
 	r8712_write8(padapter, 0x117, newvalue);
 
-	spin_lock_irqsave(&padapter->lockRxFF0Filter, irqL);
+	spin_lock_irqsave(&padapter->lock_rx_ff0_filter, irqL);
 	padapter->blnEnableRxFF0Filter = 1;
-	spin_unlock_irqrestore(&padapter->lockRxFF0Filter, irqL);
+	spin_unlock_irqrestore(&padapter->lock_rx_ff0_filter, irqL);
 	do {
 		msleep(100);
 	} while (padapter->blnEnableRxFF0Filter == 1);
-- 
2.19.1

