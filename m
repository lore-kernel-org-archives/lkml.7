Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C784C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F9221019
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552050036;
	bh=zM1cNWDTW6HD1JLPgzWiCG0TWfRGwwm+oeZTBpn+wig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y+plxrSJ4AiHVv0APIcWZIx8eVD2oF/Cgancq7e1RXIjEPrnbNVE42zqBciT7znkI
	 xRtdsTGojwKFgCVjSVYpYntdrn6wq6dcRPr3ftEyzacDRqTDW+4ua1ipWWUlP1P/V6
	 7MOQtFsY7Y6QUlH2LBEse/MZq4TOvcA+KiOa73N4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbfCHNAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:00:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:37622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbfCHNAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:00:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA85720449;
        Fri,  8 Mar 2019 13:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552050033;
        bh=zM1cNWDTW6HD1JLPgzWiCG0TWfRGwwm+oeZTBpn+wig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E/IaFZmbxat6qmiRItyfQriUzYPUqB5A7yekHXU8IpZyB3sQuHbVs76yirBNL/1MQ
         R7l+mhkf3pmk/9OyQDF+X7YIWlm8nwrKCltIbeLK+xh48SwcyMSNRrgImtHhM2nLId
         Rmi8m0pEeMyP2QhAEEoCRKBjXxv+pbsHgZj0eJEc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Karoly Pados <pados@pados.hu>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.19 62/68] USB: serial: cp210x: fix GPIO in autosuspend
Date:   Fri,  8 Mar 2019 13:50:32 +0100
Message-Id: <20190308124913.629685254@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124910.696595153@linuxfoundation.org>
References: <20190308124910.696595153@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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


