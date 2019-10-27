Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D65ECA9EBD
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F5C20B7C
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210510;
	bh=DNogohxJudpJgaAhRb6Da2/JiIzdCiOlJWxWHOT7MTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1rCsY7gz5VRVrdySgnXqCQdh1I+Nxmlir9b3t5qMJKfsH6Ci9KOhGQorebNZlU3cB
	 5wn4BJ24/9rskiP1o6cVMDGrqCCcuu0Wr9U7C7cAGXvRSfwz1gXiJb9AfkUFMwLeJK
	 hmmqC/rXcgrXy51js21Bt1ywM5PKuUI5swBAuYx4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfJ0VI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:08:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbfJ0VIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:08:20 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41851208C0;
        Sun, 27 Oct 2019 21:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210500;
        bh=DNogohxJudpJgaAhRb6Da2/JiIzdCiOlJWxWHOT7MTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R35Ohnzic04XRpd8Rk/ruEP9lcIXjA0A4tzYjYgAFo9J3VaoBP26sI5R6MXIViuj7
         0tvhQZ6FL+2VmoVZWPjY+rpbdmY08xGbMR9txpweGLJqdcj6NQwldwiA47lBEPehAQ
         9K8qzM5DVNbeJK0od0WR0SUgsxuQ7TqKFbHTbTDo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+cd24df4d075c319ebfc5@syzkaller.appspotmail.com,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.14 035/119] USB: usblp: fix use-after-free on disconnect
Date:   Sun, 27 Oct 2019 22:00:12 +0100
Message-Id: <20191027203311.413211029@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203259.948006506@linuxfoundation.org>
References: <20191027203259.948006506@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 7a759197974894213621aa65f0571b51904733d6 upstream.

A recent commit addressing a runtime PM use-count regression, introduced
a use-after-free by not making sure we held a reference to the struct
usb_interface for the lifetime of the driver data.

Fixes: 9a31535859bf ("USB: usblp: fix runtime PM after driver unbind")
Cc: stable <stable@vger.kernel.org>
Reported-by: syzbot+cd24df4d075c319ebfc5@syzkaller.appspotmail.com
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20191015175522.18490-1-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/class/usblp.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/usb/class/usblp.c
+++ b/drivers/usb/class/usblp.c
@@ -458,6 +458,7 @@ static void usblp_cleanup(struct usblp *
 	kfree(usblp->readbuf);
 	kfree(usblp->device_id_string);
 	kfree(usblp->statusbuf);
+	usb_put_intf(usblp->intf);
 	kfree(usblp);
 }
 
@@ -1120,7 +1121,7 @@ static int usblp_probe(struct usb_interf
 	init_waitqueue_head(&usblp->wwait);
 	init_usb_anchor(&usblp->urbs);
 	usblp->ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
-	usblp->intf = intf;
+	usblp->intf = usb_get_intf(intf);
 
 	/* Malloc device ID string buffer to the largest expected length,
 	 * since we can re-query it on an ioctl and a dynamic string
@@ -1209,6 +1210,7 @@ abort:
 	kfree(usblp->readbuf);
 	kfree(usblp->statusbuf);
 	kfree(usblp->device_id_string);
+	usb_put_intf(usblp->intf);
 	kfree(usblp);
 abort_ret:
 	return retval;


