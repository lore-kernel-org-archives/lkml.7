Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C5FC28CC6
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 02:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4CA20684
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 02:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsA3nuu4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfFFCzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 22:55:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46789 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfFFCyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 22:54:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id y11so517854pfm.13;
        Wed, 05 Jun 2019 19:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ysY+52fXMYI7MZwAXhhPIwcn7G+33VLkTlff+m5jejA=;
        b=KsA3nuu4Ro2foXc43IhBKNFQ7rh67P0KGHzmxz7m9f/oV3mj7ycORtzRX3NxCkXvMa
         cnH+kU33bbdJFQH1sRpyEbZFsN0xgho3dosKvHh9GqSu6XIxONAE7jCDR23WL7AFI+Mn
         XnxgM38THM+qU08dKGHSUHiEen1LWyv5I4Yb3GXNCo5KWYtBdhPJg0VeIKQMM/JNrK0J
         Tb6+rGF3jOhz/QZW348OfG9Rnld9PwO3DLPXFahWKNHLI5Ep+vlvCTnhd36pn46uTDEH
         twZWqIupF7avQ+L4KQvOP4g53S8WEdJgvEn0VtCKfnmMfPNw+6uQhsI3W+tbBOWOmqFv
         FQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ysY+52fXMYI7MZwAXhhPIwcn7G+33VLkTlff+m5jejA=;
        b=Cx5pc33xI6zdX67rdaLVsy0VaR0P4GuUMVpuKR4SdKux3TRAXbH+NVnrvMt2wTMQmd
         UWTxzeKi2joAw/NvKvbqsaANmV5pZWrPkXKfoITAtJWHHv3F8Wv7nZ2nA5yHc8haJyLP
         SUYA/E26AwJTnIbzoFtCmwd7kCNhQvHxrKg3fFb9QpB1jpBkowDz0N+g2YsJ7ueeaZXN
         afwzvFMjhkn9d4xlf55yBr6GUFGV3v3Oo5kOmFK9T1STB4rSTW7IzkWmQ1dN9rSkYciT
         Widz5qaH5n/3ZXopGQr5kDZRkmHfSeiIEh2km4eRPFNwKv7r7VFHCmSCwSaIxFpAm2FC
         kerQ==
X-Gm-Message-State: APjAAAWBty0d6EtN6kQyl59mq/FnlB9qzsSYvU9yFB5sEo7H4KOqGP/U
        y/MzJULayu+ISb/cfP8he7E=
X-Google-Smtp-Source: APXvYqzYYI/fIy/eRjqqtSlAUlZEkTA+bhjkS7lyv59ClWfmPjdn/8fEQuzHeoXxTJrVhY+fNJWrRg==
X-Received: by 2002:a17:90a:a616:: with SMTP id c22mr48684484pjq.46.1559789689688;
        Wed, 05 Jun 2019 19:54:49 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id 10sm290548pfh.179.2019.06.05.19.54.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 19:54:48 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V1 5/6] USB: serial: f81232: Use devm_kzalloc
Date:   Thu,  6 Jun 2019 10:54:15 +0800
Message-Id: <1559789656-15847-6-git-send-email-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559789656-15847-1-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1559789656-15847-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_kzalloc() to replace kzalloc().

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/usb/serial/f81232.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 7d1ec8f9d168..708d85c7d822 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -1198,7 +1198,7 @@ static int f81232_port_probe(struct usb_serial_port *port)
 	struct f81232_private *priv;
 	int status = 0;
 
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(&port->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
@@ -1234,16 +1234,6 @@ static int f81232_port_probe(struct usb_serial_port *port)
 	return status;
 }
 
-static int f81232_port_remove(struct usb_serial_port *port)
-{
-	struct f81232_private *priv;
-
-	priv = usb_get_serial_port_data(port);
-	kfree(priv);
-
-	return 0;
-}
-
 static int f81232_suspend(struct usb_serial *serial, pm_message_t message)
 {
 	struct usb_serial_port *port = serial->port[0];
@@ -1301,7 +1291,6 @@ static struct usb_serial_driver f81232_device = {
 	.process_read_urb =	f81232_read_urb_proxy,
 	.read_int_callback =	f81232_read_int_callback,
 	.port_probe =		f81232_port_probe,
-	.port_remove =		f81232_port_remove,
 	.suspend =		f81232_suspend,
 	.resume =		f81232_resume,
 };
-- 
2.7.4

