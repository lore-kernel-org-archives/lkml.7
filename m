Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA491C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E6A208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139767;
	bh=qKYpOJ0FU1LYIrVbA6K5gOPpID+IWTpTqLz/zF/oqDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BsZpMPq9nQz8HnWVxojxHkq9XfHeV79iGsME6U0fDb/HcQ1s0BEdT/Fa52lwgQpAD
	 /lTHfF5FD9+1LyEys3xvjpL6dzIBG2tgep3P1SRRRFDsoIAmUjRWX0GVAquqe6frUg
	 xo1m6Kxmb7q4SOm/FmiQe6QzjCHEjVcWnqKICchk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732943AbfDAR30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:29:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:35726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732927AbfDAR3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:29:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07EDD218FF;
        Mon,  1 Apr 2019 17:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139762;
        bh=qKYpOJ0FU1LYIrVbA6K5gOPpID+IWTpTqLz/zF/oqDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F0p+S3CvgmyRzSIkizgmofkddKLOjhDO5KjfuMksU1TidjKH7f/qg4Sc2TSVN/GKD
         RXSSQ+T7yN0CV8kSon144fvCOD/9Xmi1AIbGZlI/DIJW6i8vbMzOsq7wXqmVoh4cg3
         iw8ul4PsEOBzEVma2twpISdK6OUZXoYYrrb2GZQg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mans Rullgard <mans@mansr.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.9 41/56] USB: serial: option: set driver_info for SIM5218 and compatibles
Date:   Mon,  1 Apr 2019 19:02:57 +0200
Message-Id: <20190401170106.159066861@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170103.398401360@linuxfoundation.org>
References: <20190401170103.398401360@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mans Rullgard <mans@mansr.com>

commit f8df5c2c3e2df5ffaf9fb5503da93d477a8c7db4 upstream.

The SIMCom SIM5218 and compatible devices have 5 USB interfaces, only 4
of which are serial ports.  The fifth is a network interface supported
by the qmi-wwan driver.  Furthermore, the serial ports do not support
modem control signals.  Add driver_info flags to reflect this.

Signed-off-by: Mans Rullgard <mans@mansr.com>
Fixes: ec0cd94d881c ("usb: option: add SIMCom SIM5218")
Cc: stable <stable@vger.kernel.org>	# 3.2
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/option.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1066,7 +1066,8 @@ static const struct usb_device_id option
 	  .driver_info = RSVD(3) },
 	{ USB_DEVICE(QUALCOMM_VENDOR_ID, 0x6613)}, /* Onda H600/ZTE MF330 */
 	{ USB_DEVICE(QUALCOMM_VENDOR_ID, 0x0023)}, /* ONYX 3G device */
-	{ USB_DEVICE(QUALCOMM_VENDOR_ID, 0x9000)}, /* SIMCom SIM5218 */
+	{ USB_DEVICE(QUALCOMM_VENDOR_ID, 0x9000), /* SIMCom SIM5218 */
+	  .driver_info = NCTRL(0) | NCTRL(1) | NCTRL(2) | NCTRL(3) | RSVD(4) },
 	/* Quectel products using Qualcomm vendor ID */
 	{ USB_DEVICE(QUALCOMM_VENDOR_ID, QUECTEL_PRODUCT_UC15)},
 	{ USB_DEVICE(QUALCOMM_VENDOR_ID, QUECTEL_PRODUCT_UC20),


