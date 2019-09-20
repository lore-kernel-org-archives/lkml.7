Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176E1C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB7B206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391112AbfITObZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:31:25 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36800 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388365AbfITOZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:25:14 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1iBJqR-0004y2-Hm; Fri, 20 Sep 2019 15:25:11 +0100
Received: from ben by deadeye with local (Exim 4.92.1)
        (envelope-from <ben@decadent.org.uk>)
        id 1iBJqF-0007uH-4Y; Fri, 20 Sep 2019 15:24:59 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Oliver Neukum" <oneukum@suse.com>,
        "Johan Hovold" <johan@kernel.org>
Date:   Fri, 20 Sep 2019 15:23:35 +0100
Message-ID: <lsq.1568989415.692470111@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 071/132] USB: serial: use variable for status
In-Reply-To: <lsq.1568989414.954567518@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.74-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

commit 3161da970d38cd6ed2ba8cadec93874d1d06e11e upstream.

This patch turns status in a variable read once from the URB.
The long term plan is to deliver status to the callback.
In addition it makes the code a bit more elegant.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/serial/generic.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

--- a/drivers/usb/serial/generic.c
+++ b/drivers/usb/serial/generic.c
@@ -350,6 +350,7 @@ void usb_serial_generic_read_bulk_callba
 	struct usb_serial_port *port = urb->context;
 	unsigned char *data = urb->transfer_buffer;
 	unsigned long flags;
+	int status = urb->status;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(port->read_urbs); ++i) {
@@ -360,22 +361,22 @@ void usb_serial_generic_read_bulk_callba
 
 	dev_dbg(&port->dev, "%s - urb %d, len %d\n", __func__, i,
 							urb->actual_length);
-	switch (urb->status) {
+	switch (status) {
 	case 0:
 		break;
 	case -ENOENT:
 	case -ECONNRESET:
 	case -ESHUTDOWN:
 		dev_dbg(&port->dev, "%s - urb stopped: %d\n",
-							__func__, urb->status);
+							__func__, status);
 		return;
 	case -EPIPE:
 		dev_err(&port->dev, "%s - urb stopped: %d\n",
-							__func__, urb->status);
+							__func__, status);
 		return;
 	default:
 		dev_dbg(&port->dev, "%s - nonzero urb status: %d\n",
-							__func__, urb->status);
+							__func__, status);
 		goto resubmit;
 	}
 
@@ -399,6 +400,7 @@ void usb_serial_generic_write_bulk_callb
 {
 	unsigned long flags;
 	struct usb_serial_port *port = urb->context;
+	int status = urb->status;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(port->write_urbs); ++i) {
@@ -410,22 +412,22 @@ void usb_serial_generic_write_bulk_callb
 	set_bit(i, &port->write_urbs_free);
 	spin_unlock_irqrestore(&port->lock, flags);
 
-	switch (urb->status) {
+	switch (status) {
 	case 0:
 		break;
 	case -ENOENT:
 	case -ECONNRESET:
 	case -ESHUTDOWN:
 		dev_dbg(&port->dev, "%s - urb stopped: %d\n",
-							__func__, urb->status);
+							__func__, status);
 		return;
 	case -EPIPE:
 		dev_err_console(port, "%s - urb stopped: %d\n",
-							__func__, urb->status);
+							__func__, status);
 		return;
 	default:
 		dev_err_console(port, "%s - nonzero urb status: %d\n",
-							__func__, urb->status);
+							__func__, status);
 		goto resubmit;
 	}
 

