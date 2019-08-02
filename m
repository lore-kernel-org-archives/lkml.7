Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9C3C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23CA20665
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564739902;
	bh=pPXSjgHXNceoflCHZKInP4qX+6HEOlFDAA7prE++wEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MzJ8liDE5ZNNAztBDiUX8YAuFWDBRFlQNhrgmnnQsmmQR44mAaL/9kb2k2GBbu5Sy
	 +o1DrLvzp15IWkpGnoIK7FDojBlOxRMpKpNpZQI/m41WaVvK7YcaX54bnWrMTzu45C
	 6RVzUZRHT+mpJjLRzYlvfThnFLZkD22fr+l/8eig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407014AbfHBJ57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:57:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407002AbfHBJ54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:57:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19C512086A;
        Fri,  2 Aug 2019 09:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564739875;
        bh=pPXSjgHXNceoflCHZKInP4qX+6HEOlFDAA7prE++wEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HZZCkQ7Y85lJMihjgObnZA3bUN2QlmvLOLe+ztTk/+L8UFPGO2nc7uTsfo957Hx0J
         +6CnL7Zxigs/mWp+9ZDwKJdHo2NmqQtGf/+kV5+JmTNWxOeLqs/4vTFtPQO4qYzDBA
         blFgSsz4HEg0uABnYjpqoSEvxZdAs76mNv+Gttls=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+357d86bcb4cca1a2f572@syzkaller.appspotmail.com,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 5.2 05/20] media: au0828: fix null dereference in error path
Date:   Fri,  2 Aug 2019 11:39:59 +0200
Message-Id: <20190802092058.667994555@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092055.131876977@linuxfoundation.org>
References: <20190802092055.131876977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Young <sean@mess.org>

commit 6d0d1ff9ff21fbb06b867c13a1d41ce8ddcd8230 upstream.

au0828_usb_disconnect() gets the au0828_dev struct via usb_get_intfdata,
so it needs to set up for the error paths.

Reported-by: syzbot+357d86bcb4cca1a2f572@syzkaller.appspotmail.com
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/au0828/au0828-core.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/media/usb/au0828/au0828-core.c
+++ b/drivers/media/usb/au0828/au0828-core.c
@@ -719,6 +719,12 @@ static int au0828_usb_probe(struct usb_i
 	/* Setup */
 	au0828_card_setup(dev);
 
+	/*
+	 * Store the pointer to the au0828_dev so it can be accessed in
+	 * au0828_usb_disconnect
+	 */
+	usb_set_intfdata(interface, dev);
+
 	/* Analog TV */
 	retval = au0828_analog_register(dev, interface);
 	if (retval) {
@@ -737,12 +743,6 @@ static int au0828_usb_probe(struct usb_i
 	/* Remote controller */
 	au0828_rc_register(dev);
 
-	/*
-	 * Store the pointer to the au0828_dev so it can be accessed in
-	 * au0828_usb_disconnect
-	 */
-	usb_set_intfdata(interface, dev);
-
 	pr_info("Registered device AU0828 [%s]\n",
 		dev->board.name == NULL ? "Unset" : dev->board.name);
 


