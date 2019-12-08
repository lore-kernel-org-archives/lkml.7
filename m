Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1BEC43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 13:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5477206E0
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 13:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfLHNzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 08:55:42 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60478 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726425AbfLHNyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 08:54:46 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1idx1H-0007iA-94; Sun, 08 Dec 2019 13:54:43 +0000
Received: from ben by deadeye with local (Exim 4.93-RC1)
        (envelope-from <ben@decadent.org.uk>)
        id 1idx1F-0002PZ-Ce; Sun, 08 Dec 2019 13:54:41 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Colin Ian King" <colin.king@canonical.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date:   Sun, 08 Dec 2019 13:53:47 +0000
Message-ID: <lsq.1575813165.560890381@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 63/72] USB: adutux: remove redundant variable minor
In-Reply-To: <lsq.1575813164.154362148@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.79-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

commit 8444efc4a052332d643ed5c8aebcca148c7de032 upstream.

Variable minor is being assigned but never read, hence it is redundant
and can be removed. Cleans up clang warning:

drivers/usb/misc/adutux.c:770:2: warning: Value stored to 'minor' is
never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16 so that commit 44efc269db79 "USB: adutux: fix
 use-after-free on disconnect" applies cleanly]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/misc/adutux.c | 2 --
 1 file changed, 2 deletions(-)

--- a/drivers/usb/misc/adutux.c
+++ b/drivers/usb/misc/adutux.c
@@ -796,13 +796,11 @@ error:
 static void adu_disconnect(struct usb_interface *interface)
 {
 	struct adu_device *dev;
-	int minor;
 
 	dev = usb_get_intfdata(interface);
 
 	mutex_lock(&dev->mtx);	/* not interruptible */
 	dev->udev = NULL;	/* poison */
-	minor = dev->minor;
 	usb_deregister_dev(interface, &adu_class);
 	mutex_unlock(&dev->mtx);
 

