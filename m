Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0CDC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE29721479
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557153246;
	bh=9UwnwSLSRzGF+aoCsEt4MidaK9aiEQCsI0f/H/t9rQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TcGyyFLYyca+qTwLQIOlCwu3ifk/FlYDFuEL35QkGeo89FrQAeh7rNDa1TsiCreZR
	 kkY2NSApaDGbUxansLStnBhjoWQN1ia0kra404/TXojHBhiOTGZ/CynZJ4hSKXYeeW
	 Cz+yy4geGjFZ0Y1SbPqgl4xVZihFr8B6qES8Ds98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfEFOeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:34:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbfEFOd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:33:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99B39204EC;
        Mon,  6 May 2019 14:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153238;
        bh=9UwnwSLSRzGF+aoCsEt4MidaK9aiEQCsI0f/H/t9rQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nW5ksmu2PXH8RacVVnh2vOMwh1hf1HpKEubxtW4DCgpCoW1ngaZ/huCAXkWOCxJvH
         yxQSVZWtukFKfNKvTckzv23zt6aueSE8tg+2czVsdKPBZlUTy0JyAWn4MzI9hlEK/6
         /NWqPYU+pg8TnjAQB6DW+bNKcIZ09j/K5MpGA0M8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        syzbot+2eb9121678bdb36e6d57@syzkaller.appspotmail.com
Subject: [PATCH 5.0 014/122] USB: yurex: Fix protection fault after device removal
Date:   Mon,  6 May 2019 16:31:12 +0200
Message-Id: <20190506143056.014215892@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143054.670334917@linuxfoundation.org>
References: <20190506143054.670334917@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

commit ef61eb43ada6c1d6b94668f0f514e4c268093ff3 upstream.

The syzkaller USB fuzzer found a general-protection-fault bug in the
yurex driver.  The fault occurs when a device has been unplugged; the
driver's interrupt-URB handler logs an error message referring to the
device by name, after the device has been unregistered and its name
deallocated.

This problem is caused by the fact that the interrupt URB isn't
cancelled until the driver's private data structure is released, which
can happen long after the device is gone.  The cure is to make sure
that the interrupt URB is killed before yurex_disconnect() returns;
this is exactly the sort of thing that usb_poison_urb() was meant for.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reported-and-tested-by: syzbot+2eb9121678bdb36e6d57@syzkaller.appspotmail.com
CC: <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/misc/yurex.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/misc/yurex.c
+++ b/drivers/usb/misc/yurex.c
@@ -314,6 +314,7 @@ static void yurex_disconnect(struct usb_
 	usb_deregister_dev(interface, &yurex_class);
 
 	/* prevent more I/O from starting */
+	usb_poison_urb(dev->urb);
 	mutex_lock(&dev->io_mutex);
 	dev->interface = NULL;
 	mutex_unlock(&dev->io_mutex);


