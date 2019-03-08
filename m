Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6A7C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB30320684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049598;
	bh=l4kl51fW0wqPbESlv5YFx+pKqucRF7wvQAArae5jMCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=azBg4Y26iX0QkE1Q7IaHj671sdAAZjo6Vr3FXmFopuyBN+jawmh54s+yQSnQSQNgk
	 Y88sw3oRSVGHF6jCYf899+8pH5d/FXSc1/4oiByLzGsPtxtWF9br3DzNnfDWd61qUI
	 knQdOpNAW8MHRWK7yv5C/k+QI+gxPemp0cZ01Ix4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfCHMxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:53:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:56938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbfCHMxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:53:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 022E620684;
        Fri,  8 Mar 2019 12:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049593;
        bh=l4kl51fW0wqPbESlv5YFx+pKqucRF7wvQAArae5jMCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1+q7vdM4u1ikvJqCaR60YGx18B4Kq/5w8cZiEPa9F/eseTnxXtJHa2DZPWMShevS1
         UkhMZLUkKkib/a5XChe6tuqzWvO8AlnCRTwfstOXe/w6p8B8Kk2evNr43HF2+o20P9
         rAS4ZQ+qCN2dADLPcEbJg6oFoc+yRklWvQ85QUDY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Karoly Pados <pados@pados.hu>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.0 40/46] USB: serial: cp210x: fix GPIO in autosuspend
Date:   Fri,  8 Mar 2019 13:50:13 +0100
Message-Id: <20190308124904.831852796@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124902.257040783@linuxfoundation.org>
References: <20190308124902.257040783@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Karoly Pados <pados@pados.hu>

commit 7b0b644b9aa2de5032db0f468fddca091d0b7b90 upstream.

Current GPIO code in cp210x fails to take USB autosuspend into account,
making it practically impossible to use GPIOs with autosuspend enabled
without user configuration. Fix this like for ftdi_sio in a previous patch.
Tested on a CP2102N.

Signed-off-by: Karoly Pados <pados@pados.hu>
Fixes: cf5276ce7867 ("USB: serial: cp210x: Adding GPIO support for CP2105")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/cp210x.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -1354,8 +1354,13 @@ static int cp210x_gpio_get(struct gpio_c
 	if (priv->partnum == CP210X_PARTNUM_CP2105)
 		req_type = REQTYPE_INTERFACE_TO_HOST;
 
+	result = usb_autopm_get_interface(serial->interface);
+	if (result)
+		return result;
+
 	result = cp210x_read_vendor_block(serial, req_type,
 					  CP210X_READ_LATCH, &buf, sizeof(buf));
+	usb_autopm_put_interface(serial->interface);
 	if (result < 0)
 		return result;
 
@@ -1376,6 +1381,10 @@ static void cp210x_gpio_set(struct gpio_
 
 	buf.mask = BIT(gpio);
 
+	result = usb_autopm_get_interface(serial->interface);
+	if (result)
+		goto out;
+
 	if (priv->partnum == CP210X_PARTNUM_CP2105) {
 		result = cp210x_write_vendor_block(serial,
 						   REQTYPE_HOST_TO_INTERFACE,
@@ -1393,6 +1402,8 @@ static void cp210x_gpio_set(struct gpio_
 					 NULL, 0, USB_CTRL_SET_TIMEOUT);
 	}
 
+	usb_autopm_put_interface(serial->interface);
+out:
 	if (result < 0) {
 		dev_err(&serial->interface->dev, "failed to set GPIO value: %d\n",
 				result);


