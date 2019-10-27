Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3F9CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F55B205F4
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572212245;
	bh=jaFWRWvDjERps60GVLlTLwEplN6HE8jKwC+u84gwQCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jecj2A8xs45z4r6mrQBppBn2QzLxsNVckpxejINnR8a63Lle3P88W9j/YjzYokAiS
	 dLAKa9ogAGnh1kWXUSrugapSsia/LjaivhjtdzLCoLn8UW7LNCYESS7Oyhkt/q410W
	 +aY1DXM2YgZXbCB9tgHM/CaJq+umpOAHzHmocFpw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbfJ0VhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:37:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728826AbfJ0VF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:05:27 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C256208C0;
        Sun, 27 Oct 2019 21:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210326;
        bh=jaFWRWvDjERps60GVLlTLwEplN6HE8jKwC+u84gwQCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S5Q5hBXDSPdrK9yZGmDqNVuHZdlzLUIeLh3Ggp1HXWqtH0FHipObs4B43N2f08FXp
         2+4LuvGRShhNlWrklpXUUZDf3c6w8XhchvyXnBtCSyCutGqQCiaCi3iAv2wuiXt2Mm
         ZEsgov/8DNIE5TwMTLRoEMU8x5Dnlq+Qn58kLt5o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.9 26/49] USB: serial: ti_usb_3410_5052: fix port-close races
Date:   Sun, 27 Oct 2019 22:01:04 +0100
Message-Id: <20191027203139.262412564@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203119.468466356@linuxfoundation.org>
References: <20191027203119.468466356@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 6f1d1dc8d540a9aa6e39b9cb86d3a67bbc1c8d8d upstream.

Fix races between closing a port and opening or closing another port on
the same device which could lead to a failure to start or stop the
shared interrupt URB. The latter could potentially cause a
use-after-free or worse in the completion handler on driver unbind.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/ti_usb_3410_5052.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

--- a/drivers/usb/serial/ti_usb_3410_5052.c
+++ b/drivers/usb/serial/ti_usb_3410_5052.c
@@ -778,7 +778,6 @@ static void ti_close(struct usb_serial_p
 	struct ti_port *tport;
 	int port_number;
 	int status;
-	int do_unlock;
 	unsigned long flags;
 
 	tdev = usb_get_serial_data(port->serial);
@@ -802,16 +801,13 @@ static void ti_close(struct usb_serial_p
 			"%s - cannot send close port command, %d\n"
 							, __func__, status);
 
-	/* if mutex_lock is interrupted, continue anyway */
-	do_unlock = !mutex_lock_interruptible(&tdev->td_open_close_lock);
+	mutex_lock(&tdev->td_open_close_lock);
 	--tport->tp_tdev->td_open_port_count;
-	if (tport->tp_tdev->td_open_port_count <= 0) {
+	if (tport->tp_tdev->td_open_port_count == 0) {
 		/* last port is closed, shut down interrupt urb */
 		usb_kill_urb(port->serial->port[0]->interrupt_in_urb);
-		tport->tp_tdev->td_open_port_count = 0;
 	}
-	if (do_unlock)
-		mutex_unlock(&tdev->td_open_close_lock);
+	mutex_unlock(&tdev->td_open_close_lock);
 }
 
 


