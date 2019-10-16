Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF652FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87EDD21A4C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571262800;
	bh=uP8YV1birrED3aJFs260DKq+h57zQGkpcTu8RaIQVXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CaAOcrM1Fhim7uxpguT+2lHlYV0YDIM1YMqBrhnJdsFebGXz75HVEH8pIA4H5ftS/
	 pSo9DSrfryslXquecftAke5ure8w9p8OOmNmLy2Q5To36NKUiw+WgxckzXRwmXVifC
	 y3lM5aJ5NziTPBdkLHx5DVUBLGSwHS3NAryecUPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437509AbfJPVxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:53:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437399AbfJPVxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:53:14 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A63E821D7E;
        Wed, 16 Oct 2019 21:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262793;
        bh=uP8YV1birrED3aJFs260DKq+h57zQGkpcTu8RaIQVXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c2YaEaXbAn0T3+xPt0JBmL5942grNqmPcTQ7p04hIcn9JcTlNxUozelAmtKKKJYHA
         ENcT3h79KIqNBBtU7HZUKR7MfcwHyB2hIKE5bVlyuW7/v+IOnjERGQQEW5kLSf599L
         XYnKEp9lADD2UvIAwhBQf7lDVmc7tjH7v7z278sI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.4 33/79] USB: usb-skeleton: fix NULL-deref on disconnect
Date:   Wed, 16 Oct 2019 14:50:08 -0700
Message-Id: <20191016214757.765918513@linuxfoundation.org>
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

From: Johan Hovold <johan@kernel.org>

commit bed5ef230943863b9abf5eae226a20fad9a8ff71 upstream.

The driver was using its struct usb_interface pointer as an inverted
disconnected flag and was setting it to NULL before making sure all
completion handlers had run. This could lead to NULL-pointer
dereferences in the dev_err() statements in the completion handlers
which relies on said pointer.

Fix this by using a dedicated disconnected flag.

Note that this is also addresses a NULL-pointer dereference at release()
and a struct usb_interface reference leak introduced by a recent runtime
PM fix, which depends on and should have been submitted together with
this patch.

Fixes: 4212cd74ca6f ("USB: usb-skeleton.c: remove err() usage")
Fixes: 5c290a5e42c3 ("USB: usb-skeleton: fix runtime PM after driver unbind")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20191009170944.30057-2-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/usb-skeleton.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/usb/usb-skeleton.c
+++ b/drivers/usb/usb-skeleton.c
@@ -63,6 +63,7 @@ struct usb_skel {
 	spinlock_t		err_lock;		/* lock for errors */
 	struct kref		kref;
 	struct mutex		io_mutex;		/* synchronize I/O with disconnect */
+	unsigned long		disconnected:1;
 	wait_queue_head_t	bulk_in_wait;		/* to wait for an ongoing read */
 };
 #define to_skel_dev(d) container_of(d, struct usb_skel, kref)
@@ -239,7 +240,7 @@ static ssize_t skel_read(struct file *fi
 	if (rv < 0)
 		return rv;
 
-	if (!dev->interface) {		/* disconnect() was called */
+	if (dev->disconnected) {		/* disconnect() was called */
 		rv = -ENODEV;
 		goto exit;
 	}
@@ -420,7 +421,7 @@ static ssize_t skel_write(struct file *f
 
 	/* this lock makes sure we don't submit URBs to gone devices */
 	mutex_lock(&dev->io_mutex);
-	if (!dev->interface) {		/* disconnect() was called */
+	if (dev->disconnected) {		/* disconnect() was called */
 		mutex_unlock(&dev->io_mutex);
 		retval = -ENODEV;
 		goto error;
@@ -588,7 +589,7 @@ static void skel_disconnect(struct usb_i
 
 	/* prevent more I/O from starting */
 	mutex_lock(&dev->io_mutex);
-	dev->interface = NULL;
+	dev->disconnected = 1;
 	mutex_unlock(&dev->io_mutex);
 
 	usb_kill_anchored_urbs(&dev->submitted);


