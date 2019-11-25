Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE86C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E8620872
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0M56xig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbfKYOzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:55:03 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40471 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbfKYOzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 09:55:02 -0500
Received: by mail-pg1-f196.google.com with SMTP id e17so7307372pgd.7;
        Mon, 25 Nov 2019 06:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e4HNvCgeIsWWXZD/Eb73dwrTgcSGPA1KF9adoLiVXgQ=;
        b=C0M56xig08BjM6UDtEp0uBL4EXLqykm2frcZoJ7E7GS3AAgxjKqdK3W5pbb8z6eGFN
         xIWz0cmyQq2FsOL/krgiZSu5ZThNhgjLXzH7EFrfGopafUVit7HugddBcsQirgJ4Izrs
         wf3ztUomTXDA92t6pts8yDdxxKuoT70kll2x0tFtYPr5g70QQQCkIxd9LeNYxIJol4W3
         qufObs7ux04GuWcNfiy+H9lXQbFKd6427kSHUoa2BjnRnPkkD7sYyJsPWbI3pJ0I+hQl
         oJv4JQeLj1Hr5FCiOl5fU2b5rYsHFCtHHVgrnx61TF0kCcj1hwe4EgtL6jHdBoz83KjF
         0bTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e4HNvCgeIsWWXZD/Eb73dwrTgcSGPA1KF9adoLiVXgQ=;
        b=fsfmp+Gzb6ast0qU2vnUCPsxTRNbzE7OpzrdeUp18XwtnBQrsM/dToA688+2dwBwVb
         VELeJ2OHQfNusLJt2C2r8oa44jaxnYF0eNPdn92aWo0EI4vUP0er1Wtlbo6dJjwpnxU5
         /gOXB0HwKsHc6bR6sJPtBW7j6rLwAvtnjRvaOtxKAGv8Bp88fBMjT5eaIX2DipYJdjph
         bSba6SQRshvdt866DlET/KyfP9LSdCl1ZKonJ7hyYHeqS6RLQTnoBXxZLpSy74r0nFqt
         8rU38Lp5RtYvwh7DRbbgFCq/25MVII6vTg5sWyhDvZgD7hGvmyYGhTh5oQp95CSDyli6
         9z8A==
X-Gm-Message-State: APjAAAXQNl9rks2U98bQP42Plgp0zy3+NPQxOJl26/3rKLpgeWG43PEs
        wtiUYqkPU81mtZ/l5sPGRwE=
X-Google-Smtp-Source: APXvYqyTUDydmZxjqv1ZPCNVTCbzpy+iesgMrRGL2cKw74rn+PBdxs7oKou9Wp8GYPDIcUiiOEWR3A==
X-Received: by 2002:a62:5485:: with SMTP id i127mr27075376pfb.186.1574693701152;
        Mon, 25 Nov 2019 06:55:01 -0800 (PST)
Received: from debian.net.fpt ([2405:4800:58f7:550c:6dad:1b5f:afc6:7758])
        by smtp.gmail.com with ESMTPSA id j4sm8623602pgt.57.2019.11.25.06.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 06:55:00 -0800 (PST)
From:   Phong Tran <tranmanphong@gmail.com>
To:     davem@davemloft.net, gregkh@linuxfoundation.org, oneukum@suse.com
Cc:     alexios.zavras@intel.com, johan@kernel.org, allison@lohutok.net,
        tglx@linutronix.de, benquike@gmail.com, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Phong Tran <tranmanphong@gmail.com>
Subject: [PATCH 2/2] drivers: net: usbnet: Fix -Wcast-function-type
Date:   Mon, 25 Nov 2019 21:54:43 +0700
Message-Id: <20191125145443.29052-2-tranmanphong@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191125145443.29052-1-tranmanphong@gmail.com>
References: <20191125145443.29052-1-tranmanphong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

correct usage prototype of callback in tasklet_init().
Report by https://github.com/KSPP/linux/issues/20

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
---
 drivers/net/usb/usbnet.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index dde05e2fdc3e..d10a5e6d0917 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1573,6 +1573,12 @@ static void usbnet_bh (struct timer_list *t)
 	}
 }
 
+static void usbnet_bh_tasklet (unsigned long data)
+{
+	struct timer_list *t = (struct timer_list *)data;
+	usbnet_bh(t);
+}
+
 
 /*-------------------------------------------------------------------------
  *
@@ -1700,7 +1706,7 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 	skb_queue_head_init (&dev->txq);
 	skb_queue_head_init (&dev->done);
 	skb_queue_head_init(&dev->rxq_pause);
-	dev->bh.func = (void (*)(unsigned long))usbnet_bh;
+	dev->bh.func = usbnet_bh_tasklet;
 	dev->bh.data = (unsigned long)&dev->delay;
 	INIT_WORK (&dev->kevent, usbnet_deferred_kevent);
 	init_usb_anchor(&dev->deferred);
-- 
2.20.1

