Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07167C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D206720700
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570118602;
	bh=5OwVZHXWuvHqX+dLeHJvdMc7LTL+ap8gQNGEwG9O8mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uiJYkuwN4fCsPkL2nMhytg18ZUOU9rb+S2S7/3cAxyTomTrHwmZpMC04dVjIwe1OW
	 i8VT/jdd3Dlh6RHUeGS4TvivXyq7z5UBfbC3liygcimEz5ocOtmkufogqrrRf909KW
	 1LrQVN7lKiApLqJPsiBw9RCYJivaAgrVXofVXPtM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732163AbfJCQDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:03:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732231AbfJCQDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:03:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBB2D21D81;
        Thu,  3 Oct 2019 16:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118593;
        bh=5OwVZHXWuvHqX+dLeHJvdMc7LTL+ap8gQNGEwG9O8mk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z8DCjXno1xPaWPIYXQNjXIQ4tYTsICaKw03I6SGQ3v68JQECwXbaD0hDgM+k2fHNX
         kk9ZTwoLUrtls6dnWZDpjajEmpmeXuHjMFqZuaEWHmTHXH7L3hQHMLdxSitDUxweqm
         uRcn1FXhTS3mzgEOgKmzPhWL7Wwvs02g5wjYmDDA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        syzbot+2d4fc2a0c45ad8da7e99@syzkaller.appspotmail.com
Subject: [PATCH 4.9 066/129] media: radio/si470x: kill urb on error
Date:   Thu,  3 Oct 2019 17:53:09 +0200
Message-Id: <20191003154348.619330381@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154318.081116689@linuxfoundation.org>
References: <20191003154318.081116689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

[ Upstream commit 0d616f2a3fdbf1304db44d451d9f07008556923b ]

In the probe() function radio->int_in_urb was not killed if an
error occurred in the probe sequence. It was also missing in
the disconnect.

This caused this syzbot issue:

https://syzkaller.appspot.com/bug?extid=2d4fc2a0c45ad8da7e99

Reported-and-tested-by: syzbot+2d4fc2a0c45ad8da7e99@syzkaller.appspotmail.com

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/radio/si470x/radio-si470x-usb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/radio/si470x/radio-si470x-usb.c b/drivers/media/radio/si470x/radio-si470x-usb.c
index 4b132c29f2900..1d045a8c29e21 100644
--- a/drivers/media/radio/si470x/radio-si470x-usb.c
+++ b/drivers/media/radio/si470x/radio-si470x-usb.c
@@ -742,7 +742,7 @@ static int si470x_usb_driver_probe(struct usb_interface *intf,
 	/* start radio */
 	retval = si470x_start_usb(radio);
 	if (retval < 0)
-		goto err_all;
+		goto err_buf;
 
 	/* set initial frequency */
 	si470x_set_freq(radio, 87.5 * FREQ_MUL); /* available in all regions */
@@ -757,6 +757,8 @@ static int si470x_usb_driver_probe(struct usb_interface *intf,
 
 	return 0;
 err_all:
+	usb_kill_urb(radio->int_in_urb);
+err_buf:
 	kfree(radio->buffer);
 err_ctrl:
 	v4l2_ctrl_handler_free(&radio->hdl);
@@ -830,6 +832,7 @@ static void si470x_usb_driver_disconnect(struct usb_interface *intf)
 	mutex_lock(&radio->lock);
 	v4l2_device_disconnect(&radio->v4l2_dev);
 	video_unregister_device(&radio->videodev);
+	usb_kill_urb(radio->int_in_urb);
 	usb_set_intfdata(intf, NULL);
 	mutex_unlock(&radio->lock);
 	v4l2_device_put(&radio->v4l2_dev);
-- 
2.20.1



