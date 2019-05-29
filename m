Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61FCC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 19:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F23B24105
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 19:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559159180;
	bh=5tFwDDtbnfAvg3Ud/TCBvvuyOzI9S67cXcgjH0QlSi0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=S2MjIjk0FueRc8BPWsanzBt7N+tf9tssjwsmjOobD7Zp/yczL2SMooRZTX+9Yixe3
	 uEyR0Gj/FkGKss/sh+jwbG3ImS2Ee1f7ZiY+W4lNZ9K1FLFcSA6KLt+MkqoR8usRD8
	 NU3bbFF8yal7UdlfqLsw40HgetZnmJi/4VlZaRKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfE2TqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 15:46:19 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:53972 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfE2TqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 15:46:19 -0400
Received: by mail-it1-f194.google.com with SMTP id m141so6016299ita.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 12:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+eutwUzWw7yIEf2kITpPbDuWCOhlPFyyl9kfwZe7DzQ=;
        b=ZmJ08OpkIGvwOSk6cIloQd1jQuyQO5dTJyhas0jAo6u5UQvuA1piCpkwgE0PgkUcuA
         F7REJwjQomNqtqabhTX7VnUCd2qibyaFMsabu3qFRI6I2T/nLH2y7dIrl3raAAwRpjtY
         wfn0UKWaSb32oiL5yNFF6Hwa/Hc6Z3MYMo8wM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+eutwUzWw7yIEf2kITpPbDuWCOhlPFyyl9kfwZe7DzQ=;
        b=sJm1mk7HLuPNygm4v6/0jnkHHE6X5VcoirgtVkF1+G/o6xvxlkdI15cDy/Onov8SJO
         YFlNEBJewLeeZfdOKp7nn2QBGSnA1PneNkfyi+h3/gU46g41fU86ZF9WkmvD3+kXXnqk
         lDKpkMgnIU5JHdLaPk9xaXSkVWvt7bpXbm9P9SzRagUa+nZMwtzHt8IGlVH8yffvsfMn
         1MOcxMHAegx+5vx+/eikd/+tVrok0t6u+6w4WMr1EfkWyHGWY3/l1kfgVBw9Rl1HVj9N
         LfO5WY/hBd+I5pgsyH/57gcsKxOQ1VrCJ1w5YujscS23i/kRY7KDvTY/07rER2PeR4mQ
         DDAQ==
X-Gm-Message-State: APjAAAVAWdyoIC134DmeSik3wK48FZs5xnxjA6Zzoeh7Zh69nCLMVUyD
        kQw4Q9qNVHvhTAl5Lfmw7tve1Q==
X-Google-Smtp-Source: APXvYqxuVn+L94+vSLieuWGz5DDC+w1DLNr916cnmtQdZ6Yl1TiU64n5TfLD78gFxuOE2b/Iwm52rw==
X-Received: by 2002:a24:468e:: with SMTP id j136mr8428959itb.116.1559159178125;
        Wed, 29 May 2019 12:46:18 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 62sm135387itx.8.2019.05.29.12.46.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 12:46:17 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usbip: usbip_host: fix stub_dev lock context imbalance regression
Date:   Wed, 29 May 2019 13:46:15 -0600
Message-Id: <20190529194615.18765-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse context imbalance regression introduced in
a patch that fixed sleeping function called from invalid context bug.

kbuild test robot reported on:

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git  usb-linus

Regressions in current branch:

drivers/usb/usbip/stub_dev.c:399:9: sparse: sparse: context imbalance in 'stub_probe' - different lock contexts for basic block
drivers/usb/usbip/stub_dev.c:418:13: sparse: sparse: context imbalance in 'stub_disconnect' - different lock contexts for basic block
drivers/usb/usbip/stub_dev.c:464:1-10: second lock on line 476

Error ids grouped by kconfigs:

recent_errors
├── i386-allmodconfig
│   └── drivers-usb-usbip-stub_dev.c:second-lock-on-line
├── x86_64-allmodconfig
│   ├── drivers-usb-usbip-stub_dev.c:sparse:sparse:context-imbalance-in-stub_disconnect-different-lock-contexts-for-basic-block
│   └── drivers-usb-usbip-stub_dev.c:sparse:sparse:context-imbalance-in-stub_probe-different-lock-contexts-for-basic-block
└── x86_64-allyesconfig
    └── drivers-usb-usbip-stub_dev.c:second-lock-on-line

This is a real problem in an error leg where spin_lock() is called on an
already held lock.

Fix the imbalance in stub_probe() and stub_disconnect().

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/usb/usbip/stub_dev.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/usbip/stub_dev.c b/drivers/usb/usbip/stub_dev.c
index d094c96643d2..7931e6cecc70 100644
--- a/drivers/usb/usbip/stub_dev.c
+++ b/drivers/usb/usbip/stub_dev.c
@@ -326,14 +326,17 @@ static int stub_probe(struct usb_device *udev)
 		 * See driver_probe_device() in driver/base/dd.c
 		 */
 		rc = -ENODEV;
-		goto sdev_free;
+		if (!busid_priv)
+			goto sdev_free;
+
+		goto call_put_busid_priv;
 	}
 
 	if (udev->descriptor.bDeviceClass == USB_CLASS_HUB) {
 		dev_dbg(&udev->dev, "%s is a usb hub device... skip!\n",
 			 udev_busid);
 		rc = -ENODEV;
-		goto sdev_free;
+		goto call_put_busid_priv;
 	}
 
 	if (!strcmp(udev->bus->bus_name, "vhci_hcd")) {
@@ -342,7 +345,7 @@ static int stub_probe(struct usb_device *udev)
 			udev_busid);
 
 		rc = -ENODEV;
-		goto sdev_free;
+		goto call_put_busid_priv;
 	}
 
 
@@ -361,6 +364,9 @@ static int stub_probe(struct usb_device *udev)
 	save_status = busid_priv->status;
 	busid_priv->status = STUB_BUSID_ALLOC;
 
+	/* release the busid_lock */
+	put_busid_priv(busid_priv);
+
 	/*
 	 * Claim this hub port.
 	 * It doesn't matter what value we pass as owner
@@ -373,9 +379,6 @@ static int stub_probe(struct usb_device *udev)
 		goto err_port;
 	}
 
-	/* release the busid_lock */
-	put_busid_priv(busid_priv);
-
 	rc = stub_add_files(&udev->dev);
 	if (rc) {
 		dev_err(&udev->dev, "stub_add_files for %s\n", udev_busid);
@@ -395,11 +398,17 @@ static int stub_probe(struct usb_device *udev)
 	spin_lock(&busid_priv->busid_lock);
 	busid_priv->sdev = NULL;
 	busid_priv->status = save_status;
-sdev_free:
-	stub_device_free(sdev);
+	spin_unlock(&busid_priv->busid_lock);
+	/* lock is released - go to free */
+	goto sdev_free;
+
+call_put_busid_priv:
 	/* release the busid_lock */
 	put_busid_priv(busid_priv);
 
+sdev_free:
+	stub_device_free(sdev);
+
 	return rc;
 }
 
@@ -435,7 +444,9 @@ static void stub_disconnect(struct usb_device *udev)
 	/* get stub_device */
 	if (!sdev) {
 		dev_err(&udev->dev, "could not get device");
-		goto call_put_busid_priv;
+		/* release busid_lock */
+		put_busid_priv(busid_priv);
+		return;
 	}
 
 	dev_set_drvdata(&udev->dev, NULL);
@@ -465,7 +476,7 @@ static void stub_disconnect(struct usb_device *udev)
 	if (!busid_priv->shutdown_busid)
 		busid_priv->shutdown_busid = 1;
 	/* release busid_lock */
-	put_busid_priv(busid_priv);
+	spin_unlock(&busid_priv->busid_lock);
 
 	/* shutdown the current connection */
 	shutdown_busid(busid_priv);
@@ -480,10 +491,9 @@ static void stub_disconnect(struct usb_device *udev)
 
 	if (busid_priv->status == STUB_BUSID_ALLOC)
 		busid_priv->status = STUB_BUSID_ADDED;
-
-call_put_busid_priv:
 	/* release busid_lock */
-	put_busid_priv(busid_priv);
+	spin_unlock(&busid_priv->busid_lock);
+	return;
 }
 
 #ifdef CONFIG_PM
-- 
2.17.1

