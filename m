Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095A0C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA72B207FF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570118957;
	bh=KxMX0AHppmq/QMFSl9xidCMoTWkoL9DltKhFR7xZW48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VpES+1wHuo1MklnYwXgj9gf7rx/UJbYQqSvH6z5Gs5mJ/pBs0SbZ+Vxrk++UnEgbT
	 N0SA2PH0iv3aUAMtDi6ZOFOEeZWO5OJ7Iml2CklCY89BeqhjkIymkfJGTv34LLq8LO
	 BY8G9EywDBwqN78zdR2I0rKhwHuZZlbeldELbzgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733114AbfJCQJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:09:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733059AbfJCQJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:09:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68C2821D81;
        Thu,  3 Oct 2019 16:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118953;
        bh=KxMX0AHppmq/QMFSl9xidCMoTWkoL9DltKhFR7xZW48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kU+Q6GvfTTyVNlpBkJmtbOTfaZCKqthdDeGPa0xv4X1ObSPpvDlAivhn42bIb4Rbv
         ovNKVD9GSvZ+SBPa7tdNI/AeYD+axIJYj1DejCw6oNMwZtHpgtqp7rA2vzw/0wKnBy
         Fh56ZJ8wV9hKPY+jAdOrUwsMJ07hvN7AxujtbDto=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+01a77b82edaa374068e1@syzkaller.appspotmail.com,
        Oliver Neukum <oneukum@suse.com>, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 070/185] media: iguanair: add sanity checks
Date:   Thu,  3 Oct 2019 17:52:28 +0200
Message-Id: <20191003154453.328188685@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154437.541662648@linuxfoundation.org>
References: <20191003154437.541662648@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 30e24da672268..3c2e248ceca87 100644
--- a/drivers/media/rc/iguanair.c
+++ b/drivers/media/rc/iguanair.c
@@ -427,6 +427,10 @@ static int iguanair_probe(struct usb_interface *intf,
 	int ret, pipein, pipeout;
 	struct usb_host_interface *idesc;
 
+	idesc = intf->altsetting;
+	if (idesc->desc.bNumEndpoints < 2)
+		return -ENODEV;
+
 	ir = kzalloc(sizeof(*ir), GFP_KERNEL);
 	rc = rc_allocate_device(RC_DRIVER_IR_RAW);
 	if (!ir || !rc) {
@@ -441,18 +445,13 @@ static int iguanair_probe(struct usb_interface *intf,
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



