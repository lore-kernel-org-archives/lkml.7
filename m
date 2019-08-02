Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2211BC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A6D2067D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564740303;
	bh=4WRnDc6ccVf1F9VSDNYejaU+jEuRvyZ28WXLUbFz+a0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U9Glh+OacwFY3SJiCBYu92YNS7Geukssh2Y04WCVhd1g48rfkWpAaWMRk9v9ALYQh
	 rhxMMETd/U7ZO7onuUOTzvycb5Kp0ghtIoFCZigz7ptP5pe4FET8dpe35s1/ogkxeV
	 aaxWaP0QtGruwrQi95QGn6J6sNWAbEzGtVZv3830=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391703AbfHBJk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:40:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391065AbfHBJk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:40:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A37E206A2;
        Fri,  2 Aug 2019 09:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564738825;
        bh=4WRnDc6ccVf1F9VSDNYejaU+jEuRvyZ28WXLUbFz+a0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nYocTJui8b2iJLu7NEo9kDnayXU3MRzlAOekXaJEovfdeRHq3VrgpGZHK+lAyvUKM
         /9dgqH6okNSTI8piDxdRUlxRbCO1xGrNkbpzQCbf0In1LdscWrlsNxKL9jIxosgubA
         RWhMsBjUjNJUPrrS0kzMuiidaahJStmrpzGE7nqs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        syzbot+26ec41e9f788b3eba396@syzkaller.appspotmail.com,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 010/223] media: dvb: usb: fix use after free in dvb_usb_device_exit
Date:   Fri,  2 Aug 2019 11:33:55 +0200
Message-Id: <20190802092239.554840027@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092238.692035242@linuxfoundation.org>
References: <20190802092238.692035242@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 84308569e7dc..b3413404f91a 100644
--- a/drivers/media/usb/dvb-usb/dvb-usb-init.c
+++ b/drivers/media/usb/dvb-usb/dvb-usb-init.c
@@ -287,12 +287,15 @@ EXPORT_SYMBOL(dvb_usb_device_init);
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



