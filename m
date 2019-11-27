Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8730FC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A908217AB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887533;
	bh=5dB7ozyKoi/M5ntKoqDhWKGmzdvlVlMFbQ5HSRIXi3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GVWjjBco7KRncTVB5dNoexi8OLjLmPjqQLEXIljtPQuoroTst55zU6eYvM9xw+e0/
	 oY0SBAr9V5/uZ3OfLFPHhKmtkPjtnt3+XXmiWGfH9A+auLGlv5BY7AkA7S/ZTGshAx
	 T9jfj5uMmX7nYe7eZbSNK7xJM0g0TEfAslcoZpEI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbfK0Upc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:45:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:56232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbfK0Up0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:45:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7277421780;
        Wed, 27 Nov 2019 20:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887525;
        bh=5dB7ozyKoi/M5ntKoqDhWKGmzdvlVlMFbQ5HSRIXi3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1jGGohZTm0ihTgZBvPTxshAZdv7MXo+YkI3wxczRd87g/9G0ZlyUo6Ye4aVMmzBF9
         uVvGMhDcNBKHLoW/Ep5wHPwGFS411EN7XCgLaZh6o1/Dn8dVtwEvcewsqRgYjWw35G
         6OWCm9cdRg7R105QnT0kzZn4DgQxnTf9TL6sJmY0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.9 144/151] USB: serial: mos7720: fix remote wakeup
Date:   Wed, 27 Nov 2019 21:32:07 +0100
Message-Id: <20191127203047.278732440@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203000.773542911@linuxfoundation.org>
References: <20191127203000.773542911@linuxfoundation.org>
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
@@ -1941,10 +1941,6 @@ static int mos7720_startup(struct usb_se
 		}
 	}
 
-	/* setting configuration feature to one */
-	usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
-			(__u8)0x03, 0x00, 0x01, 0x00, NULL, 0x00, 5000);
-
 #ifdef CONFIG_USB_SERIAL_MOS7715_PARPORT
 	if (product == MOSCHIP_DEVICE_ID_7715) {
 		ret_val = mos7715_parport_init(serial);


