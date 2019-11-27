Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EAFC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F07C21741
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574889514;
	bh=IZD60WKOoIIwQZ0XlG9VB+VgoMwu1UzQuNA7TjHizyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f/iD0zbZ1UduvBe5c7lldCaVHPxaRAF/B6Zt6DP7368GHgx1XE0JVnHbcCMB16/Ry
	 zjC0eT5sWUqeX2AKBdV4ggjLTqN0UF9ngkG873sSRGbp+U351wKzyrxiipACSHs8DX
	 ixN1l1sqieTuTYOj3dAYCdVPsg5ggWVHR/bh89FY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733181AbfK0VSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:18:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:39862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728335AbfK0VLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:11:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63D952086A;
        Wed, 27 Nov 2019 21:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574889083;
        bh=IZD60WKOoIIwQZ0XlG9VB+VgoMwu1UzQuNA7TjHizyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pvMIPncckvPJeTcBds/zi81bKDNKVqgWoFrdsDYN9T6bq0km4GgnPJTY7K1ItboaQ
         xuriVPxZn3o4Vb77Pqo1uQ9ZF2z0T8LX7dotnj4zjvM0/P+YYFfo1Z3g1O5xQjExug
         unLv46ZIYiDBFPO754/GVKy/icFLowhldzDVTUbQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+d93dff37e6a89431c158@syzkaller.appspotmail.com,
        Oliver Neukum <oneukum@suse.com>, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 5.3 76/95] media: b2c2-flexcop-usb: add sanity checking
Date:   Wed, 27 Nov 2019 21:32:33 +0100
Message-Id: <20191127202943.105318630@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202845.651587549@linuxfoundation.org>
References: <20191127202845.651587549@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

commit 1b976fc6d684e3282914cdbe7a8d68fdce19095c upstream.

The driver needs an isochronous endpoint to be present. It will
oops in its absence. Add checking for it.

Reported-by: syzbot+d93dff37e6a89431c158@syzkaller.appspotmail.com
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/b2c2/flexcop-usb.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/media/usb/b2c2/flexcop-usb.c
+++ b/drivers/media/usb/b2c2/flexcop-usb.c
@@ -538,6 +538,9 @@ static int flexcop_usb_probe(struct usb_
 	struct flexcop_device *fc = NULL;
 	int ret;
 
+	if (intf->cur_altsetting->desc.bNumEndpoints < 1)
+		return -ENODEV;
+
 	if ((fc = flexcop_device_kmalloc(sizeof(struct flexcop_usb))) == NULL) {
 		err("out of memory\n");
 		return -ENOMEM;


