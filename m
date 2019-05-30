Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F78CC28CC1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F07244A0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559185947;
	bh=QcfP4SGmVsiYl+5myMku98rDbfG5/bHXY/ahLelCOmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cJ1Qvc4fIxEmcy42xhcD0aBS02Vj7Lp2eZVsvfH/MlVmexN6+4/K1yG9FrkB+TMz0
	 H5gwqG0VQiliwuDicm8mYEVVv3268k03nOiVwpUY/FWrBgJlKqAYBlmYGHTm38X9gz
	 x+Oi7oX/Dkysagpra7/YDEp1Gcndh9mgMJAZqscg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbfE3DM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:12:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728271AbfE3DKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:10:54 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8804E244C4;
        Thu, 30 May 2019 03:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185853;
        bh=QcfP4SGmVsiYl+5myMku98rDbfG5/bHXY/ahLelCOmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V/9Yv4cNRanHcBRPI7gpJPpkaZ2nwd+FvuO21TJVqxsdIahq1LDkAQtwUp03MXuqX
         caN18Uc1K8opvmoZfBPu9EGpSp7M6GQFkrxX+hXhCUHSM6I33EPjjzFAuJdEMbp5cD
         tQnBIGcHUYuVdEhS8QfL3sO2aAoNUMY4eqOodDLw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Kento Kobayashi <Kento.A.Kobayashi@sony.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jacky Cao <Jacky.Cao@sony.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 179/405] USB: core: Dont unbind interfaces following device reset failure
Date:   Wed, 29 May 2019 20:02:57 -0700
Message-Id: <20190530030550.151064739@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 381419fa720060ba48b7bbc483be787d5b1dca6f ]

The SCSI core does not like to have devices or hosts unregistered
while error recovery is in progress.  Trying to do so can lead to
self-deadlock: Part of the removal code tries to obtain a lock already
held by the error handler.

This can cause problems for the usb-storage and uas drivers, because
their error handler routines perform a USB reset, and if the reset
fails then the USB core automatically goes on to unbind all drivers
from the device's interfaces -- all while still in the context of the
SCSI error handler.

As it turns out, practically all the scenarios leading to a USB reset
failure end up causing a device disconnect (the main error pathway in
usb_reset_and_verify_device(), at the end of the routine, calls
hub_port_logical_disconnect() before returning).  As a result, the
hub_wq thread will soon become aware of the problem and will unbind
all the device's drivers in its own context, not in the
error-handler's context.

This means that usb_reset_device() does not need to call
usb_unbind_and_rebind_marked_interfaces() in cases where
usb_reset_and_verify_device() has returned an error, because hub_wq
will take care of everything anyway.

This particular problem was observed in somewhat artificial
circumstances, by using usbfs to tell a hub to power-down a port
connected to a USB-3 mass storage device using the UAS protocol.  With
the port turned off, the currently executing command timed out and the
error handler started running.  The USB reset naturally failed,
because the hub port was off, and the error handler deadlocked as
described above.  Not carrying out the call to
usb_unbind_and_rebind_marked_interfaces() fixes this issue.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reported-by: Kento Kobayashi <Kento.A.Kobayashi@sony.com>
Tested-by: Kento Kobayashi <Kento.A.Kobayashi@sony.com>
CC: Bart Van Assche <bvanassche@acm.org>
CC: Martin K. Petersen <martin.petersen@oracle.com>
CC: Jacky Cao <Jacky.Cao@sony.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/core/hub.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 8d4631c81b9f0..310eef451db82 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -5902,7 +5902,10 @@ int usb_reset_device(struct usb_device *udev)
 					cintf->needs_binding = 1;
 			}
 		}
-		usb_unbind_and_rebind_marked_interfaces(udev);
+
+		/* If the reset failed, hub_wq will unbind drivers later */
+		if (ret == 0)
+			usb_unbind_and_rebind_marked_interfaces(udev);
 	}
 
 	usb_autosuspend_device(udev);
-- 
2.20.1



