Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F64BC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4820020868
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563201971;
	bh=srTrjVb/NproGDBZrf7xjQbLlk9QFUoeK/lvEq8QG9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JYMQsoRkvVJOfj3HaXSues57+wgSjVobgDvzb6eIRsJNsf/GouXuVKsMLO4WWPeEz
	 iF/E2uj04m/LVrvl0+pTHcP4bfan+kcbTOCKJMcc9bbu9K4R24jyaZxk7xyTO+wtvY
	 dMKsoLBE0UsU3sVHVTTfisZFFkKXlN3EYNXTQZfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404806AbfGOOqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:46:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391958AbfGOOp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:45:59 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 067D72067C;
        Mon, 15 Jul 2019 14:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563201958;
        bh=srTrjVb/NproGDBZrf7xjQbLlk9QFUoeK/lvEq8QG9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=np2FQ6MigVgReInjJ5374MSIA+XbA5l0llDNcDgjaJG0VZxXVok8JC/iYkctimQYL
         fObFvoiHtwh7AzDUjkiA17n0HwTt+hwx0Bc52G7gHRPNHPH7W8rB5I41os7UiOc5J6
         V8baNULCLaezAgdrzrUkAswiSDkBq9XMI0nheW5w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Oliver Neukum <oneukum@suse.com>,
        syzbot+26ec41e9f788b3eba396@syzkaller.appspotmail.com,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 06/53] media: dvb: usb: fix use after free in dvb_usb_device_exit
Date:   Mon, 15 Jul 2019 10:44:48 -0400
Message-Id: <20190715144535.11636-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715144535.11636-1-sashal@kernel.org>
References: <20190715144535.11636-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

[ Upstream commit 6cf97230cd5f36b7665099083272595c55d72be7 ]

dvb_usb_device_exit() frees and uses the device name in that order.
Fix by storing the name in a buffer before freeing it.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Reported-by: syzbot+26ec41e9f788b3eba396@syzkaller.appspotmail.com
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/dvb-usb/dvb-usb-init.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/dvb-usb-init.c b/drivers/media/usb/dvb-usb/dvb-usb-init.c
index 1adf325012f7..97a89ef7e4c1 100644
--- a/drivers/media/usb/dvb-usb/dvb-usb-init.c
+++ b/drivers/media/usb/dvb-usb/dvb-usb-init.c
@@ -286,12 +286,15 @@ EXPORT_SYMBOL(dvb_usb_device_init);
 void dvb_usb_device_exit(struct usb_interface *intf)
 {
 	struct dvb_usb_device *d = usb_get_intfdata(intf);
-	const char *name = "generic DVB-USB module";
+	const char *default_name = "generic DVB-USB module";
+	char name[40];
 
 	usb_set_intfdata(intf, NULL);
 	if (d != NULL && d->desc != NULL) {
-		name = d->desc->name;
+		strscpy(name, d->desc->name, sizeof(name));
 		dvb_usb_exit(d);
+	} else {
+		strscpy(name, default_name, sizeof(name));
 	}
 	info("%s successfully deinitialized and disconnected.", name);
 
-- 
2.20.1

