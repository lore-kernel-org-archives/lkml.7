Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EB9C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3FBD214D9
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569179063;
	bh=cEno2wrjPI9YrH8bPe4reOWiOUsn/oHZHDpE5clJ76o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qIYRb66tUFkhx7/+uHQ9oDzAAHX9ASCCrqZcvirQZ+jL4AMFLu6AvXJCZFp0t9zHS
	 OOEF5MmeWqM0jOVNQ/53DEkWnCWRX1CV+H9qJAh2FztVB5qbN36yB4nrBBJmlMsFy2
	 Nz57xOSKJJSod0v4mN/0zSy5rwog12035Tt79fIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbfIVTEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:04:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:37532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395326AbfIVTBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 15:01:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F15022070C;
        Sun, 22 Sep 2019 19:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178881;
        bh=cEno2wrjPI9YrH8bPe4reOWiOUsn/oHZHDpE5clJ76o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rHgTM6z5YQEd2uMAtuhRAVwO0w9rNdITAh02kx0plL/Dz+01FhUkkgxC5mHJMy/Qs
         xSBbYzJx5oHpBJkquPuf6E25taRO7Eve8FIUSGrsp+HHxn6n0WVr40VbtqU547tSje
         XZGJ0vzw4FvHmM6SVwEVm6onyVtJPPkTuwVBwkII=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Oliver Neukum <oneukum@suse.com>,
        syzbot+01a77b82edaa374068e1@syzkaller.appspotmail.com,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 13/44] media: iguanair: add sanity checks
Date:   Sun, 22 Sep 2019 15:00:31 -0400
Message-Id: <20190922190103.4906-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922190103.4906-1-sashal@kernel.org>
References: <20190922190103.4906-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

[ Upstream commit ab1cbdf159beba7395a13ab70bc71180929ca064 ]

The driver needs to check the endpoint types, too, as opposed
to the number of endpoints. This also requires moving the check earlier.

Reported-by: syzbot+01a77b82edaa374068e1@syzkaller.appspotmail.com
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/iguanair.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/media/rc/iguanair.c b/drivers/media/rc/iguanair.c
index ee60e17fba05d..cda4ce612dcf5 100644
--- a/drivers/media/rc/iguanair.c
+++ b/drivers/media/rc/iguanair.c
@@ -430,6 +430,10 @@ static int iguanair_probe(struct usb_interface *intf,
 	int ret, pipein, pipeout;
 	struct usb_host_interface *idesc;
 
+	idesc = intf->altsetting;
+	if (idesc->desc.bNumEndpoints < 2)
+		return -ENODEV;
+
 	ir = kzalloc(sizeof(*ir), GFP_KERNEL);
 	rc = rc_allocate_device();
 	if (!ir || !rc) {
@@ -444,18 +448,13 @@ static int iguanair_probe(struct usb_interface *intf,
 	ir->urb_in = usb_alloc_urb(0, GFP_KERNEL);
 	ir->urb_out = usb_alloc_urb(0, GFP_KERNEL);
 
-	if (!ir->buf_in || !ir->packet || !ir->urb_in || !ir->urb_out) {
+	if (!ir->buf_in || !ir->packet || !ir->urb_in || !ir->urb_out ||
+	    !usb_endpoint_is_int_in(&idesc->endpoint[0].desc) ||
+	    !usb_endpoint_is_int_out(&idesc->endpoint[1].desc)) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	idesc = intf->altsetting;
-
-	if (idesc->desc.bNumEndpoints < 2) {
-		ret = -ENODEV;
-		goto out;
-	}
-
 	ir->rc = rc;
 	ir->dev = &intf->dev;
 	ir->udev = udev;
-- 
2.20.1

