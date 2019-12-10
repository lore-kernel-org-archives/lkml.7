Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494D1C00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB562073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576017064;
	bh=7yAdFeAARDJpG2jDWe2tPjifPkOJrct+bsnHlvoz40g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w3MJ72XfSD4dGRV+0kgTXq164zw8ETAhlfkYb3XyXUvDPcL1YBeKEB7W6OgPaKCGk
	 gZUdMHHcef2i8W+Cz+R4GUEBLrhxDBXiMAt7SamWgW++YdxOt17A+mqafBXLEWYa7r
	 dpaxt7fgJX2oS6z/v+8rpLV/kapFb5M6BNLa7KpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfLJWbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:31:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:50830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727678AbfLJWbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:31:00 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5363C214D8;
        Tue, 10 Dec 2019 22:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576017060;
        bh=7yAdFeAARDJpG2jDWe2tPjifPkOJrct+bsnHlvoz40g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=viuzsW/iGblDgmwxpeQe76BKm49iCSOMbTg49yZ+//O8FpbGCVoGY7baoDIlaTN2t
         fQO2yFi8X2eb4CyIU7fM1UGNn8FJvCSXMTtJ9r/3K3FbBB838N+eTV8zuD3siO/5j+
         c4fWdEAhNkDUmaMTBl5Il5WrJR0Go+0eqLAsj2iw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 20/91] media: flexcop-usb: fix NULL-ptr deref in flexcop_usb_transfer_init()
Date:   Tue, 10 Dec 2019 17:29:24 -0500
Message-Id: <20191210223035.14270-20-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210223035.14270-1-sashal@kernel.org>
References: <20191210223035.14270-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yingliang <yangyingliang@huawei.com>

[ Upstream commit 649cd16c438f51d4cd777e71ca1f47f6e0c5e65d ]

If usb_set_interface() failed, iface->cur_altsetting will
not be assigned and it will be used in flexcop_usb_transfer_init()
It may lead a NULL pointer dereference.

Check usb_set_interface() return value in flexcop_usb_init()
and return failed to avoid using this NULL pointer.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/b2c2/flexcop-usb.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/b2c2/flexcop-usb.c b/drivers/media/usb/b2c2/flexcop-usb.c
index 1fc3c8d7dd9b8..2594d6a7393fa 100644
--- a/drivers/media/usb/b2c2/flexcop-usb.c
+++ b/drivers/media/usb/b2c2/flexcop-usb.c
@@ -504,7 +504,13 @@ static int flexcop_usb_transfer_init(struct flexcop_usb *fc_usb)
 static int flexcop_usb_init(struct flexcop_usb *fc_usb)
 {
 	/* use the alternate setting with the larges buffer */
-	usb_set_interface(fc_usb->udev,0,1);
+	int ret = usb_set_interface(fc_usb->udev, 0, 1);
+
+	if (ret) {
+		err("set interface failed.");
+		return ret;
+	}
+
 	switch (fc_usb->udev->speed) {
 	case USB_SPEED_LOW:
 		err("cannot handle USB speed because it is too slow.");
-- 
2.20.1

