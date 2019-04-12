Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8727AC10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 02:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BCA82083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 02:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAfIt2AT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfDLCip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 22:38:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34017 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfDLCio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 22:38:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id b3so4386345pfd.1;
        Thu, 11 Apr 2019 19:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CQGnbsTa28+WGFD7YKQq2M+/zSOCMfXAFFRYUWY4qaQ=;
        b=XAfIt2ATg2jjY/NK78ehja6q449PeKIJ6sWoNoC9PBCJcrRWE1xjDNYoz/K+B3YK6T
         5Psb6pfoxL3SIL/PClV4uyXHohYYpwbPEnIm72iEQOjGhXhkn+ds+8nit6PRHtx/aIld
         MAJTv4G05VxTi9GfrZoVM6hQGgEtnPmvO/5qSEvMcEqjHhJcjMBx3S+WV3N/8dL0X8EE
         rS2FkMt5l62t9C5bxxoTN92Y4nPsL6f7Q//aG4qTCwRd5y8rg3luaS9vHYBlICnl5R6U
         GzDUZj9aSwIOOqCGbAEmNWnhBBuTx9OpxAv9DkmhdhgS83qkRP5AuO/jQgGn4B1zvl6R
         z6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CQGnbsTa28+WGFD7YKQq2M+/zSOCMfXAFFRYUWY4qaQ=;
        b=HIF2Dk3S3keiuuvXYYsf4Hnhyjn5rs26Af0lQcv/sI6j7n10zcp9lGtogoqnptU/G2
         oysomkN8C7c1Woecs491CI5LegcJGkMJ7eiIuqzLoZu3EHLI+Hj8a5+HEirBpQJe/sa6
         +rNl0jQqacNXm4pIgKdUT3u9ETQaGhBrY2fBjxrGev/CuOM72ek87eyKq7j7joUPCJ+5
         opTfd3nJyxt7OZdQ1AH3Wflc65ZF25ZtAtaPMyH1gvbuLvAMTy5RrXxASu3CQHmkrKZp
         t08qrcbI9GFyMXjABVrEnUmM+3Rrp99U2ncNAtmJP0RiYR3YEWPOwOMUtO1LlFn7rLyN
         PaSg==
X-Gm-Message-State: APjAAAWrWsWI5CKyj1W1FgNWmMLst2EJRh5kbrUHREFHGHu8/I8Lkljq
        eQeGlQgY6iIH3xowVKpfmgxZYCVCt4akDw==
X-Google-Smtp-Source: APXvYqy+K+s05IAdvfu/GHxX4ml+HpffNaoSDZX3XR5KQljN8J5i+FdNqGMJD9AbyMbDQpj+eDYXKQ==
X-Received: by 2002:a63:494f:: with SMTP id y15mr51222380pgk.56.1555036723907;
        Thu, 11 Apr 2019 19:38:43 -0700 (PDT)
Received: from xy-data.openstacklocal (ecs-159-138-22-150.compute.hwclouds-dns.com. [159.138.22.150])
        by smtp.gmail.com with ESMTPSA id g4sm68627075pfm.115.2019.04.11.19.38.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Apr 2019 19:38:43 -0700 (PDT)
From:   Young Xiao <92siuyang@gmail.com>
To:     kbuild-all@01.org, linux-usb@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        greg@kroah.com, mchehab@kernel.org
Cc:     keescook@chromium.org, hans.verkuil@cisco.com,
        Young Xiao <YangX92@hotmail.com>
Subject: [PATCH] USB: s2255 & stkwebcam: fix oops with malicious USB descriptors
Date:   Fri, 12 Apr 2019 10:39:27 +0800
Message-Id: <1555036767-31170-1-git-send-email-92siuyang@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Young Xiao <YangX92@hotmail.com>

The driver expects at least one valid endpoint. If given
malicious descriptors that specify 0 for the number of endpoints,
it will crash in the probe function.  Ensure there is at least
one endpoint on the interface before using it.

This vulnerability is same as CVE-2016-2188.

Signed-off-by: Young Xiao <YangX92@hotmail.com>
---
 drivers/media/usb/s2255/s2255drv.c       | 7 +++++++
 drivers/media/usb/stkwebcam/stk-webcam.c | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/media/usb/s2255/s2255drv.c b/drivers/media/usb/s2255/s2255drv.c
index 5b3e54b..82dd661 100644
--- a/drivers/media/usb/s2255/s2255drv.c
+++ b/drivers/media/usb/s2255/s2255drv.c
@@ -2263,6 +2263,13 @@ static int s2255_probe(struct usb_interface *interface,
 	iface_desc = interface->cur_altsetting;
 	dev_dbg(&interface->dev, "num EP: %d\n",
 		iface_desc->desc.bNumEndpoints);
+
+	if (iface_desc->desc.bNumEndpoints < 1) {
+		dev_err(&interface->dev, "Invalid number of endpoints\n");
+		retval = -EINVAL;
+		goto errorEP;
+	}
+
 	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {
 		endpoint = &iface_desc->endpoint[i].desc;
 		if (!dev->read_endpoint && usb_endpoint_is_bulk_in(endpoint)) {
diff --git a/drivers/media/usb/stkwebcam/stk-webcam.c b/drivers/media/usb/stkwebcam/stk-webcam.c
index 8f54586..e427c3d 100644
--- a/drivers/media/usb/stkwebcam/stk-webcam.c
+++ b/drivers/media/usb/stkwebcam/stk-webcam.c
@@ -1350,6 +1350,12 @@ static int stk_camera_probe(struct usb_interface *interface,
 	 * for the current alternate setting */
 	iface_desc = interface->cur_altsetting;
 
+	if (iface_desc->desc.bNumEndpoints < 1) {
+		dev_err(&interface->dev, "Invalid number of endpoints\n");
+		err = -EINVAL;
+		goto error;
+	}
+
 	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {
 		endpoint = &iface_desc->endpoint[i].desc;
 
-- 
1.9.1

