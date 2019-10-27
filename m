Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7636FCA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44B91214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210869;
	bh=bkkkZHK4THWOGTJvtCcawwtzMIv/jQ2OkJlaPrOfbjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wVWCahSivLsVYJrxucNvpSjzjB5kA0ES4PPogbkF5Mksc4rLA2rewuLUctXzK8S8c
	 G3vUMO2COk+XR6wq7JttXH+l25nKfukEigxrevNXFpxQtaF584w/H9wewQIpcY/rHp
	 4ixWJLig6+agVoeLq+75d3CKRPLHmH4dTwGPi9d8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbfJ0VO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:14:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728939AbfJ0VOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:14:24 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47EC2208C0;
        Sun, 27 Oct 2019 21:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210863;
        bh=bkkkZHK4THWOGTJvtCcawwtzMIv/jQ2OkJlaPrOfbjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zf0hKTin+yXTQfJ5XlFapRNwuriTG9QCvSP8GgWFcWQQqtIRXOsguh8vvqEcSIS+4
         6RatT+a4IZKOHE8xM4eVd0hukDgv8dixHVKg4Mj4bNedmB7AehIYAdxYH6iaGtrck8
         DBi+m8lapUTMssfxkkqNgmzC718whwu00dWPiV7g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+cd24df4d075c319ebfc5@syzkaller.appspotmail.com,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.19 44/93] USB: usblp: fix use-after-free on disconnect
Date:   Sun, 27 Oct 2019 22:00:56 +0100
Message-Id: <20191027203258.970837275@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203251.029297948@linuxfoundation.org>
References: <20191027203251.029297948@linuxfoundation.org>
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
@@ -445,6 +445,7 @@ static void usblp_cleanup(struct usblp *
 	kfree(usblp->readbuf);
 	kfree(usblp->device_id_string);
 	kfree(usblp->statusbuf);
+	usb_put_intf(usblp->intf);
 	kfree(usblp);
 }
 
@@ -1107,7 +1108,7 @@ static int usblp_probe(struct usb_interf
 	init_waitqueue_head(&usblp->wwait);
 	init_usb_anchor(&usblp->urbs);
 	usblp->ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
-	usblp->intf = intf;
+	usblp->intf = usb_get_intf(intf);
 
 	/* Malloc device ID string buffer to the largest expected length,
 	 * since we can re-query it on an ioctl and a dynamic string
@@ -1196,6 +1197,7 @@ abort:
 	kfree(usblp->readbuf);
 	kfree(usblp->statusbuf);
 	kfree(usblp->device_id_string);
+	usb_put_intf(usblp->intf);
 	kfree(usblp);
 abort_ret:
 	return retval;


