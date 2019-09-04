Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E6CC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB8B23401
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UN2T3i6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbfIDG0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 02:26:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38792 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfIDG0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 02:26:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id h195so6015631pfe.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 23:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VZJV3w/FCUfuP0T0PfpcscKoD4P73WGKIRLJcAOuQv4=;
        b=UN2T3i6q2Oo4QcZEzGTMgnjh5drTUx7mIN2WnE8IeEolytGk3amVTYe82gLrwzm1ar
         yYeP7IHaH0f/UoWL1NIzYt+FpyWWH4sQGhV/ioX67nKmrF5O4yiak9GYYuplatS5f+Sk
         TL82kFrIa5DGWKdR2KUmNm5pYME0blTl38rCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VZJV3w/FCUfuP0T0PfpcscKoD4P73WGKIRLJcAOuQv4=;
        b=BWdu57OC9XCnhoExKmVu1bTYcDBbkfEMjuKos2yjpwr96ZpwDaCJXF0NsWTNa4nU/S
         Zs5EuyL8rl9ppphVgIOfOfMVjpS+WyeVVgeoVuzRaiG8JQZMrkckscwFCxHxc0WRWD5z
         FDHBhSLRr3uYKemz7fSlpoBke2OAxN+A8fC9Hu9eJq4ecLA5FvWmQfn4A0cW8MBIn5Ni
         sA5kkgYLpmVra7aCjWvvAd1YF88W8UlqZWVEyh1el629ic704QMDTtUW3Qq9wzN9stOw
         hNZW1tHL4BSin1KvZ11ZdnE3x5bmqd6vItZzDZEHdvsIMVRwEYt4wCkRiCX0PtX0a+LO
         aPIQ==
X-Gm-Message-State: APjAAAVTlzblqhAMNWSnU3balqGFU2tx52/207ZXZJ43NkWFaT0ip8YI
        k3WE9UvCPi0QAO2v4TVi5VWgXg==
X-Google-Smtp-Source: APXvYqxr0Hf5u3fF6ENhf/Jc+XaFmuJUzref9ZaZisK1ZDAyw32wuayxqQ39GENuxS0VTfPJ2O25RA==
X-Received: by 2002:aa7:8611:: with SMTP id p17mr44842668pfn.41.1567578384393;
        Tue, 03 Sep 2019 23:26:24 -0700 (PDT)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id s5sm21444719pfm.97.2019.09.03.23.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 23:26:23 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] platform/chrome: cros_ec_rpmsg: Fix race with host command when probe failed.
Date:   Wed,  4 Sep 2019 14:26:13 +0800
Message-Id: <20190904062613.86401-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the rpmsg_endpoint is created before probe is called, it's
possible that a host event is received during cros_ec_register, and
there would be some pending work in the host_event_work workqueue while
cros_ec_register is called.

If cros_ec_register fails, when the leftover work in host_event_work
run, the ec_dev from the drvdata of the rpdev could be already set to
NULL, causing kernel crash when trying to run cros_ec_get_next_event.

Fix this by creating the rpmsg_endpoint by ourself, and when
cros_ec_register fails (or on remove), destroy the endpoint first (to
make sure there's no more new calls to cros_ec_rpmsg_callback), and then
cancel all works in the host_event_work workqueue.

Fixes: 2de89fd98958 ("platform/chrome: cros_ec: Add EC host command support using rpmsg")
Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
 drivers/platform/chrome/cros_ec_rpmsg.c | 33 +++++++++++++++++++++----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_rpmsg.c b/drivers/platform/chrome/cros_ec_rpmsg.c
index 8b6bd775cc9a..0c3738c3244d 100644
--- a/drivers/platform/chrome/cros_ec_rpmsg.c
+++ b/drivers/platform/chrome/cros_ec_rpmsg.c
@@ -41,6 +41,7 @@ struct cros_ec_rpmsg {
 	struct rpmsg_device *rpdev;
 	struct completion xfer_ack;
 	struct work_struct host_event_work;
+	struct rpmsg_endpoint *ept;
 };
 
 /**
@@ -72,7 +73,6 @@ static int cros_ec_pkt_xfer_rpmsg(struct cros_ec_device *ec_dev,
 				  struct cros_ec_command *ec_msg)
 {
 	struct cros_ec_rpmsg *ec_rpmsg = ec_dev->priv;
-	struct rpmsg_device *rpdev = ec_rpmsg->rpdev;
 	struct ec_host_response *response;
 	unsigned long timeout;
 	int len;
@@ -85,7 +85,7 @@ static int cros_ec_pkt_xfer_rpmsg(struct cros_ec_device *ec_dev,
 	dev_dbg(ec_dev->dev, "prepared, len=%d\n", len);
 
 	reinit_completion(&ec_rpmsg->xfer_ack);
-	ret = rpmsg_send(rpdev->ept, ec_dev->dout, len);
+	ret = rpmsg_send(ec_rpmsg->ept, ec_dev->dout, len);
 	if (ret) {
 		dev_err(ec_dev->dev, "rpmsg send failed\n");
 		return ret;
@@ -196,11 +196,24 @@ static int cros_ec_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 	return 0;
 }
 
+static struct rpmsg_endpoint *
+cros_ec_rpmsg_create_ept(struct rpmsg_device *rpdev)
+{
+	struct rpmsg_channel_info chinfo = {};
+
+	strscpy(chinfo.name, rpdev->id.name, RPMSG_NAME_SIZE);
+	chinfo.src = rpdev->src;
+	chinfo.dst = RPMSG_ADDR_ANY;
+
+	return rpmsg_create_ept(rpdev, cros_ec_rpmsg_callback, NULL, chinfo);
+}
+
 static int cros_ec_rpmsg_probe(struct rpmsg_device *rpdev)
 {
 	struct device *dev = &rpdev->dev;
 	struct cros_ec_rpmsg *ec_rpmsg;
 	struct cros_ec_device *ec_dev;
+	int ret;
 
 	ec_dev = devm_kzalloc(dev, sizeof(*ec_dev), GFP_KERNEL);
 	if (!ec_dev)
@@ -225,7 +238,18 @@ static int cros_ec_rpmsg_probe(struct rpmsg_device *rpdev)
 	INIT_WORK(&ec_rpmsg->host_event_work,
 		  cros_ec_rpmsg_host_event_function);
 
-	return cros_ec_register(ec_dev);
+	ec_rpmsg->ept = cros_ec_rpmsg_create_ept(rpdev);
+	if (!ec_rpmsg->ept)
+		return -ENOMEM;
+
+	ret = cros_ec_register(ec_dev);
+	if (ret < 0) {
+		rpmsg_destroy_ept(ec_rpmsg->ept);
+		cancel_work_sync(&ec_rpmsg->host_event_work);
+		return ret;
+	}
+
+	return 0;
 }
 
 static void cros_ec_rpmsg_remove(struct rpmsg_device *rpdev)
@@ -234,7 +258,7 @@ static void cros_ec_rpmsg_remove(struct rpmsg_device *rpdev)
 	struct cros_ec_rpmsg *ec_rpmsg = ec_dev->priv;
 
 	cros_ec_unregister(ec_dev);
-
+	rpmsg_destroy_ept(ec_rpmsg->ept);
 	cancel_work_sync(&ec_rpmsg->host_event_work);
 }
 
@@ -271,7 +295,6 @@ static struct rpmsg_driver cros_ec_driver_rpmsg = {
 	},
 	.probe		= cros_ec_rpmsg_probe,
 	.remove		= cros_ec_rpmsg_remove,
-	.callback	= cros_ec_rpmsg_callback,
 };
 
 module_rpmsg_driver(cros_ec_driver_rpmsg);
-- 
2.23.0.187.g17f5b7556c-goog

