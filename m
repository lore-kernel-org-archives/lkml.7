Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBBDC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F047E20856
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495547;
	bh=M9oSlkNrPBEj8KJA4XQkLxsl4QF+2z9r0fl09esqPzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aihsgUPpTkf1gtqvXxqjpYK0CuLeukdtXSmaH04pG43urOUSXFa6suJRcXmIwXL2b
	 GcphbJ48Hz92lfHOJA/FK1+sv1k6G+K7qfqoQlkVYoTNjGahFnzg4cK4rSaJTOlmVl
	 h3EY35/Ilx+4g0gCPkoLq4KOOQgSHEn/qOoOg0No=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404992AbfHVRjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:39:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404162AbfHVRYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:24:19 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7CAC23400;
        Thu, 22 Aug 2019 17:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494658;
        bh=M9oSlkNrPBEj8KJA4XQkLxsl4QF+2z9r0fl09esqPzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gB1N/F59pwFsiYnUCOPj4RNAxbRAG5vjS10w4+9etOGIJMQAYVejzP7wqp1Vee/8C
         ZNQ7G2QaLg7tR7y6518homfdCGV+b2vFGBt54YLkl6mOO91WpeypMrdjqBTYi1F2sv
         nHKBFyVep35J5/3zsg5ezEKTStVJ7ZAvnNqUTJGo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        syzbot+30cf45ebfe0b0c4847a1@syzkaller.appspotmail.com
Subject: [PATCH 4.9 083/103] USB: core: Fix races in character device registration and deregistraion
Date:   Thu, 22 Aug 2019 10:19:11 -0700
Message-Id: <20190822171732.351246670@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171728.445189830@linuxfoundation.org>
References: <20190822171728.445189830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

commit 303911cfc5b95d33687d9046133ff184cf5043ff upstream.

The syzbot fuzzer has found two (!) races in the USB character device
registration and deregistration routines.  This patch fixes the races.

The first race results from the fact that usb_deregister_dev() sets
usb_minors[intf->minor] to NULL before calling device_destroy() on the
class device.  This leaves a window during which another thread can
allocate the same minor number but will encounter a duplicate name
error when it tries to register its own class device.  A typical error
message in the system log would look like:

    sysfs: cannot create duplicate filename '/class/usbmisc/ldusb0'

The patch fixes this race by destroying the class device first.

The second race is in usb_register_dev().  When that routine runs, it
first allocates a minor number, then drops minor_rwsem, and then
creates the class device.  If the device creation fails, the minor
number is deallocated and the whole routine returns an error.  But
during the time while minor_rwsem was dropped, there is a window in
which the minor number is allocated and so another thread can
successfully open the device file.  Typically this results in
use-after-free errors or invalid accesses when the other thread closes
its open file reference, because the kernel then tries to release
resources that were already deallocated when usb_register_dev()
failed.  The patch fixes this race by keeping minor_rwsem locked
throughout the entire routine.

Reported-and-tested-by: syzbot+30cf45ebfe0b0c4847a1@syzkaller.appspotmail.com
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
CC: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/Pine.LNX.4.44L0.1908121607590.1659-100000@iolanthe.rowland.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/file.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/usb/core/file.c
+++ b/drivers/usb/core/file.c
@@ -191,9 +191,10 @@ int usb_register_dev(struct usb_interfac
 		intf->minor = minor;
 		break;
 	}
-	up_write(&minor_rwsem);
-	if (intf->minor < 0)
+	if (intf->minor < 0) {
+		up_write(&minor_rwsem);
 		return -EXFULL;
+	}
 
 	/* create a usb class device for this usb interface */
 	snprintf(name, sizeof(name), class_driver->name, minor - minor_base);
@@ -201,12 +202,11 @@ int usb_register_dev(struct usb_interfac
 				      MKDEV(USB_MAJOR, minor), class_driver,
 				      "%s", kbasename(name));
 	if (IS_ERR(intf->usb_dev)) {
-		down_write(&minor_rwsem);
 		usb_minors[minor] = NULL;
 		intf->minor = -1;
-		up_write(&minor_rwsem);
 		retval = PTR_ERR(intf->usb_dev);
 	}
+	up_write(&minor_rwsem);
 	return retval;
 }
 EXPORT_SYMBOL_GPL(usb_register_dev);
@@ -232,12 +232,12 @@ void usb_deregister_dev(struct usb_inter
 		return;
 
 	dev_dbg(&intf->dev, "removing %d minor\n", intf->minor);
+	device_destroy(usb_class->class, MKDEV(USB_MAJOR, intf->minor));
 
 	down_write(&minor_rwsem);
 	usb_minors[intf->minor] = NULL;
 	up_write(&minor_rwsem);
 
-	device_destroy(usb_class->class, MKDEV(USB_MAJOR, intf->minor));
 	intf->usb_dev = NULL;
 	intf->minor = -1;
 	destroy_usb_class();


