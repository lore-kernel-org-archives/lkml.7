Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BIGNUM_EMAILS,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C79C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F4AB204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573499399;
	bh=2ygbkTHE3K7gbiAlBub3WN3pgJ4Tnybqo6Luz2tlZyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eMFk2Ba7fc2sGY4JFAWndVye7QsgAkuEymRuM9k4GljBq/2L0H9j31lkUrTqs/kZq
	 5W6dsv36UYm+uEkRvKKUZEn1MzMYDdOb8Cyu+Y9j7ByhcOBLrjpaaE4/cYp4dmCZrL
	 g7jyJrryrGfOBnLAPeaviDsa57Wl/CzvOzoVZ9QI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbfKKTJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 14:09:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:50520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728110AbfKKSdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:33:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D166F20856;
        Mon, 11 Nov 2019 18:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497190;
        bh=2ygbkTHE3K7gbiAlBub3WN3pgJ4Tnybqo6Luz2tlZyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ItFAqGgA28+5HGUVOGSmikMLzJL4qjDh+ZOVbSr4xp65I/t6nky7ueNBNljem1IMN
         xCBCXUKe3XAh81JEoVHaWJ7cxPnR7jXh4md0y9Jz78DDLToaFnv7rwSN9TrU/mpTDY
         hvVk5pAxBOINlPICdmq0EgU6b0U3S9w/AkCK5jfg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 4.9 33/65] usbip: stub_rx: fix static checker warning on unnecessary checks
Date:   Mon, 11 Nov 2019 19:28:33 +0100
Message-Id: <20191111181346.810201193@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181331.917659011@linuxfoundation.org>
References: <20191111181331.917659011@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuah Khan <shuahkh@osg.samsung.com>

commit 10c90120930628e8b959bf58d4a0aaef3ae5d945 upstream.

Fix the following static checker warnings:

The patch c6688ef9f297: "usbip: fix stub_rx: harden CMD_SUBMIT path
to handle malicious input" from Dec 7, 2017, leads to the following
static checker warning:

    drivers/usb/usbip/stub_rx.c:346 get_pipe()
    warn: impossible condition
'(pdu->u.cmd_submit.transfer_buffer_length > ((~0 >> 1))) =>
(s32min-s32max > s32max)'
    drivers/usb/usbip/stub_rx.c:486 stub_recv_cmd_submit()
    warn: always true condition
'(pdu->u.cmd_submit.transfer_buffer_length <= ((~0 >> 1))) =>
(s32min-s32max <= s32max)'

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/usbip/stub_rx.c |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

--- a/drivers/usb/usbip/stub_rx.c
+++ b/drivers/usb/usbip/stub_rx.c
@@ -353,14 +353,6 @@ static int get_pipe(struct stub_device *
 
 	epd = &ep->desc;
 
-	/* validate transfer_buffer_length */
-	if (pdu->u.cmd_submit.transfer_buffer_length > INT_MAX) {
-		dev_err(&sdev->udev->dev,
-			"CMD_SUBMIT: -EMSGSIZE transfer_buffer_length %d\n",
-			pdu->u.cmd_submit.transfer_buffer_length);
-		return -1;
-	}
-
 	if (usb_endpoint_xfer_control(epd)) {
 		if (dir == USBIP_DIR_OUT)
 			return usb_sndctrlpipe(udev, epnum);
@@ -487,8 +479,7 @@ static void stub_recv_cmd_submit(struct
 	}
 
 	/* allocate urb transfer buffer, if needed */
-	if (pdu->u.cmd_submit.transfer_buffer_length > 0 &&
-	    pdu->u.cmd_submit.transfer_buffer_length <= INT_MAX) {
+	if (pdu->u.cmd_submit.transfer_buffer_length > 0) {
 		priv->urb->transfer_buffer =
 			kzalloc(pdu->u.cmd_submit.transfer_buffer_length,
 				GFP_KERNEL);


