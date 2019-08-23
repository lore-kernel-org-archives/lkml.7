Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD8EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 19:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE4F520850
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 19:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="f02O1ATP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406123AbfHWTPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 15:15:32 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:31777 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388918AbfHWTPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 15:15:32 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 46FWKG2hrMz9w;
        Fri, 23 Aug 2019 21:13:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1566587634; bh=4N7WbSeiQ7Bn/AmuMiSbw7b2zfJLpYCfYnFzOgW76GY=;
        h=Date:From:Subject:To:Cc:From;
        b=f02O1ATPC0BoTrddjp3a+2SBrqoz2mKGAan5k49e5s4fM0f0rCM4881NWKVM4trp6
         gjuZ+x2Z9fJ9EIgUJ3AbYdm1gMIyM04CTwBJxccxShvv2SqTb941n73P+zLnvt2wAz
         /lsjX0p+om5r+uxkyIBxdaqzsCiQgBbLKWc9qdZJmz2q9T8uUFsnjFMsAzeA+SGCJ6
         tm8nidI0HD10sZeUTFiiVs0d3TN5YJoyj0gEZfxJ5OeM8EG4N6KxM66hxqJTejYDgx
         CJH+ljuE5+Oqy1wmKqocyLHSqvQZArEujEHGiCbdPhAQ2wNway0PunTuYeoYOCKZnb
         KLaL3C9E8qJ9Q==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.2 at mail
Date:   Fri, 23 Aug 2019 21:15:27 +0200
Message-Id: <5866b49b330a750b44003ebd9f532541dcb13f18.1566587656.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2] HID: fix error message in hid_open_report()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     linux-input@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On HID report descriptor parsing error the code displays bogus
pointer instead of error offset (subtracts start=NULL from end).
Make the message more useful by displaying correct error offset
and include total buffer size for reference.

This was carried over from ancient times - "Fixed" commit just
promoted the message from DEBUG to ERROR.

Cc: stable@vger.kernel.org
Fixes: 8c3d52fc393b ("HID: make parser more verbose about parsing errors by default")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

---
v2: fixed printf() warning spotted by Jiri Kosina <jikos@kernel.org>

 * against v5.2.9

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/hid/hid-core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 210b81a56e1a..3af76624e4aa 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1139,6 +1139,7 @@ int hid_open_report(struct hid_device *device)
 	__u8 *start;
 	__u8 *buf;
 	__u8 *end;
+	__u8 *next;
 	int ret;
 	static int (*dispatch_type[])(struct hid_parser *parser,
 				      struct hid_item *item) = {
@@ -1192,7 +1193,8 @@ int hid_open_report(struct hid_device *device)
 	device->collection_size = HID_DEFAULT_NUM_COLLECTIONS;
 
 	ret = -EINVAL;
-	while ((start = fetch_item(start, end, &item)) != NULL) {
+	while ((next = fetch_item(start, end, &item)) != NULL) {
+		start = next;
 
 		if (item.format != HID_ITEM_FORMAT_SHORT) {
 			hid_err(device, "unexpected long global item\n");
@@ -1230,7 +1232,8 @@ int hid_open_report(struct hid_device *device)
 		}
 	}
 
-	hid_err(device, "item fetching failed at offset %d\n", (int)(end - start));
+	hid_err(device, "item fetching failed at offset %u/%u\n",
+		size - (unsigned int)(end - start), size);
 err:
 	kfree(parser->collection_stack);
 alloc_err:
-- 
2.20.1

