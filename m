Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B416FECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8882C207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571264508;
	bh=SeK4Qck5lvlxIwSNfNvq3pnRgByOeW9EzFC+jDXDww0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0boYmrWXTj07MA+PcdKSxUZNPkN5HqTTmAggeKgfuHwSFFlFESNW2AH62OstQA30I
	 OhLAxseLyD8nFGW/zUFxfxl2YXsFtCi2PwqeRqARaBZs27nIl/7564RDK3cKCPaFrt
	 RSdOVNVx+AC0Sx1ntRGtvNdvs/mHWsHlWqThe4BM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392515AbfJPWVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:21:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394876AbfJPVx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:53:29 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 148D021A49;
        Wed, 16 Oct 2019 21:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262809;
        bh=SeK4Qck5lvlxIwSNfNvq3pnRgByOeW9EzFC+jDXDww0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XVCeCcQA9PHh33z64u3rBror5MBR8iqSa6XtVYoDT/h5C/fP91+LcHRwYvQpJbn90
         30oONWt92L1O/+ztCKkVrKKCKmuNPaCtzcD347qsKOFWwS6+ma1aax0UJNXFIrWyv8
         LbZqkCBID8RNn3kYq5rOvAnbTKlak0PgQTgPIzVY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.4 51/79] USB: serial: option: add Telit FN980 compositions
Date:   Wed, 16 Oct 2019 14:50:26 -0700
Message-Id: <20191016214815.030363646@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214729.758892904@linuxfoundation.org>
References: <20191016214729.758892904@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniele Palmas <dnlplm@gmail.com>

commit 5eb3f4b87a0e7e949c976f32f296176a06d1a93b upstream.

This patch adds the following Telit FN980 compositions:

0x1050: tty, adb, rmnet, tty, tty, tty, tty
0x1051: tty, adb, mbim, tty, tty, tty, tty
0x1052: rndis, tty, adb, tty, tty, tty, tty
0x1053: tty, adb, ecm, tty, tty, tty, tty

Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/option.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1149,6 +1149,14 @@ static const struct usb_device_id option
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) | RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, TELIT_PRODUCT_LE922_USBCFG5, 0xff),
 	  .driver_info = RSVD(0) | RSVD(1) | NCTRL(2) | RSVD(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1050, 0xff),	/* Telit FN980 (rmnet) */
+	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1051, 0xff),	/* Telit FN980 (MBIM) */
+	  .driver_info = NCTRL(0) | RSVD(1) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1052, 0xff),	/* Telit FN980 (RNDIS) */
+	  .driver_info = NCTRL(2) | RSVD(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1053, 0xff),	/* Telit FN980 (ECM) */
+	  .driver_info = NCTRL(0) | RSVD(1) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_ME910),
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(3) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_ME910_DUAL_MODEM),


