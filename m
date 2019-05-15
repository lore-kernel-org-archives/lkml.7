Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652EBC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DEEA21473
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557917941;
	bh=UaSRcyMnz8YwZQ5JXfK4M9gajoohZJeJ7Jei2hd85AU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i7NX0d1UduPCNWJAAvYst6fDw64lgmkh8MlmQG0ZMTD+uIDE5mkz8ft9pQFNW33cn
	 B7Mbo2mTrwih3H2Faafm9uaWbhhFNLOvBiHIxlvYkobpMD9AUB7pYaVi8GxTpz/Qsu
	 Tj4v4xAgktrB0Rl85ZKbhv3ARituMzUVwTEc/ebM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfEOK7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 06:59:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:55334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727014AbfEOK65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 06:58:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77B70216F4;
        Wed, 15 May 2019 10:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557917936;
        bh=UaSRcyMnz8YwZQ5JXfK4M9gajoohZJeJ7Jei2hd85AU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K/BhjFlWYx8E+0zGXTqEt2c0fm/qsv9lBG0g0pBkV2J8Eltz/4ZVEJQuIQHI9bFKc
         tGCPCWfwUABhnPTMxKrHckm/Gfh8fspJh44BftMyQn0jpOKR73kIZbRZYhZzM+4jri
         UmgBeHqfX1DosahUoMMgwHXf592U+KeIcRNu/1W4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        syzbot+2eb9121678bdb36e6d57@syzkaller.appspotmail.com
Subject: [PATCH 3.18 32/86] USB: yurex: Fix protection fault after device removal
Date:   Wed, 15 May 2019 12:55:09 +0200
Message-Id: <20190515090649.318699162@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090642.339346723@linuxfoundation.org>
References: <20190515090642.339346723@linuxfoundation.org>
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
@@ -332,6 +332,7 @@ static void yurex_disconnect(struct usb_
 	usb_deregister_dev(interface, &yurex_class);
 
 	/* prevent more I/O from starting */
+	usb_poison_urb(dev->urb);
 	mutex_lock(&dev->io_mutex);
 	dev->interface = NULL;
 	mutex_unlock(&dev->io_mutex);


