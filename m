Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8EAC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7ADE217BC
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888870;
	bh=7I0lFTe+1NEhYKeuw5K4FxjfDiPjGAU8oZZn+LzRD6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LQznPz8OYLq+GeZ4nKNzCOujBW1gcpgSkDZTbMNdTnCk6bNelc7ioXLcZjwHCr7+3
	 UTFjDzMe4jxw4XzIXm5hQkW/tahHJfnnkUqFC4N2TqIzRX4lh51yIWkmPFU1hlWHML
	 Q80ifDwBu/4+obrNrZRaoOoZZaln9o7UiWJxf0Ec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732652AbfK0VHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:07:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:33978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732644AbfK0VHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:07:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59E8020637;
        Wed, 27 Nov 2019 21:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888863;
        bh=7I0lFTe+1NEhYKeuw5K4FxjfDiPjGAU8oZZn+LzRD6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A+/KiL1Kusauhpfm/2RyxsLHYLpIfsrUPLIXiQUpj2GR6Bcv1hvJ7KQf0q3NYzpFf
         Lf2ryCK8frwLhODjWVBlnqWzn658EDfpL1hGJ3FUOdS1gpeXYGZi1qfzybCLI7Jaz6
         w7yOlLQEo8f0tqBgzA6H88ihggcG+JQnUoBM1skE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.19 299/306] USB: serial: mos7720: fix remote wakeup
Date:   Wed, 27 Nov 2019 21:32:29 +0100
Message-Id: <20191127203136.572198965@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit ea422312a462696093b5db59d294439796cba4ad upstream.

The driver was setting the device remote-wakeup feature during probe in
violation of the USB specification (which says it should only be set
just prior to suspending the device). This could potentially waste
power during suspend as well as lead to spurious wakeups.

Note that USB core would clear the remote-wakeup feature at first
resume.

Fixes: 0f64478cbc7a ("USB: add USB serial mos7720 driver")
Cc: stable <stable@vger.kernel.org>     # 2.6.19
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/mos7720.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/drivers/usb/serial/mos7720.c
+++ b/drivers/usb/serial/mos7720.c
@@ -1894,10 +1894,6 @@ static int mos7720_startup(struct usb_se
 	product = le16_to_cpu(serial->dev->descriptor.idProduct);
 	dev = serial->dev;
 
-	/* setting configuration feature to one */
-	usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
-			(__u8)0x03, 0x00, 0x01, 0x00, NULL, 0x00, 5000);
-
 	if (product == MOSCHIP_DEVICE_ID_7715) {
 		struct urb *urb = serial->port[0]->interrupt_in_urb;
 


