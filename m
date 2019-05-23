Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A09DC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 14:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7760020879
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 14:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730826AbfEWOkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 10:40:23 -0400
Received: from gateway31.websitewelcome.com ([192.185.144.97]:27860 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730708AbfEWOkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 10:40:23 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 90A2AB7CF
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 09:40:21 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id TotJhqeLv4FKpTotJhD2oV; Thu, 23 May 2019 09:40:21 -0500
X-Authority-Reason: nr=8
Received: from [189.250.47.159] (port=33326 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hTotI-001W32-J6; Thu, 23 May 2019 09:40:20 -0500
Date:   Thu, 23 May 2019 09:40:19 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] usbip: usbip_host_common: Use struct_size() in realloc()
Message-ID: <20190523144019.GA28932@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.47.159
X-Source-L: No
X-Exim-ID: 1hTotI-001W32-J6
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.47.159]:33326
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct foo {
    int stuff;
    struct boo entry[];
};

size = sizeof(struct foo) + count * sizeof(struct boo);
instance = realloc(instance, size);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

size = struct_size(instance, entry, count);

or

instance = realloc(instance, struct_size(instance, entry, count));

Notice that, in this case, variable size is not necessary,
hence it is removed.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---

Notice that checkpatch reports the following warning:

WARNING: line over 80 characters
#57: FILE: tools/usb/usbip/libsrc/usbip_host_common.c:90:
+	edev = realloc(edev, struct_size(edev, uinf, edev->udev.bNumInterfaces));

The line above is 81-character long. So, I think we should be fine
with that, instead of split it into two lines like:

edev = realloc(edev,
	       struct_size(edev, uinf, edev->udev.bNumInterfaces));

Thanks
--
Gustavo

 tools/usb/usbip/libsrc/usbip_host_common.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/usb/usbip/libsrc/usbip_host_common.c b/tools/usb/usbip/libsrc/usbip_host_common.c
index 2813aa821c82..1645d02a52af 100644
--- a/tools/usb/usbip/libsrc/usbip_host_common.c
+++ b/tools/usb/usbip/libsrc/usbip_host_common.c
@@ -67,7 +67,6 @@ struct usbip_exported_device *usbip_exported_device_new(
 {
 	struct usbip_exported_device *edev = NULL;
 	struct usbip_exported_device *edev_old;
-	size_t size;
 	int i;
 
 	edev = calloc(1, sizeof(struct usbip_exported_device));
@@ -87,11 +86,8 @@ struct usbip_exported_device *usbip_exported_device_new(
 		goto err;
 
 	/* reallocate buffer to include usb interface data */
-	size = sizeof(struct usbip_exported_device) +
-		edev->udev.bNumInterfaces * sizeof(struct usbip_usb_interface);
-
 	edev_old = edev;
-	edev = realloc(edev, size);
+	edev = realloc(edev, struct_size(edev, uinf, edev->udev.bNumInterfaces));
 	if (!edev) {
 		edev = edev_old;
 		dbg("realloc failed");
-- 
2.21.0

