Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7BAC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D57520674
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497036;
	bh=SqRmjZhn94quOQXuKvLtH6KunMbWuCA4q/EJ86b0H+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bqKpjq6q9FG4tdK7nqnWGaC6SG5B1CMTQKsnkXl0d4hOWnEpDPy7CAK7AiG3QPkJd
	 OSHRPwStl3Gqtsj2Wd+MuoPR1uuowz2LrLahTuB/y+/pf+w+9/zP8PYihxMyKdN/h2
	 un4Agyz/3Qtca86rZKorqzPS6Ppaw0X78l0235H4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfKKSaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:30:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:46862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727325AbfKKSad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:30:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3522214E0;
        Mon, 11 Nov 2019 18:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497032;
        bh=SqRmjZhn94quOQXuKvLtH6KunMbWuCA4q/EJ86b0H+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WvMJPIXLF/nKqXpzDP3leQPrMdrmImaayDFsmH+2RPot/UyScJke0kXZmyzmwhI7x
         cPvkX5hQZih0yvif2pIeXze9Spy2t/LUMXoVrI76Wc9qzM4WTOVCcCsPdf4sw6w+63
         CxVz2JFZSfhkxzKJdowkj+IQDDRn8ZBpdFGbAXeo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+863724e7128e14b26732@syzkaller.appspotmail.com,
        Johan Hovold <johan@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.4 22/43] can: peak_usb: fix slab info leak
Date:   Mon, 11 Nov 2019 19:28:36 +0100
Message-Id: <20191111181312.978024075@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181246.772983347@linuxfoundation.org>
References: <20191111181246.772983347@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit f7a1337f0d29b98733c8824e165fca3371d7d4fd upstream.

Fix a small slab info leak due to a failure to clear the command buffer
at allocation.

The first 16 bytes of the command buffer are always sent to the device
in pcan_usb_send_cmd() even though only the first two may have been
initialised in case no argument payload is provided (e.g. when waiting
for a response).

Fixes: bb4785551f64 ("can: usb: PEAK-System Technik USB adapters driver core")
Cc: stable <stable@vger.kernel.org>     # 3.4
Reported-by: syzbot+863724e7128e14b26732@syzkaller.appspotmail.com
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -776,7 +776,7 @@ static int peak_usb_create_dev(const str
 	dev = netdev_priv(netdev);
 
 	/* allocate a buffer large enough to send commands */
-	dev->cmd_buf = kmalloc(PCAN_USB_MAX_CMD_LEN, GFP_KERNEL);
+	dev->cmd_buf = kzalloc(PCAN_USB_MAX_CMD_LEN, GFP_KERNEL);
 	if (!dev->cmd_buf) {
 		err = -ENOMEM;
 		goto lbl_free_candev;


