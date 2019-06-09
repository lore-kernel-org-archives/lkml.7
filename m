Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06913C2BCA1
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D675520843
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560099871;
	bh=/fgqGPPbxUV4uA+bSTZ51Uj7oZtb3BNhtgzicKWlTnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NV2R+tJvAfg8P0KoB9xupKFSqWcJXZvAYKs/Qvs2WrFIACpUeoY+IRYMZ5WdTMB7h
	 Gw8g7grP6dhLtsQN6SuMwxlrreyqSk/If7f+zEb+0vMzyWiLxgHZ/bNDOsELi3HHQx
	 YaYrtGXwqrLBOFZZl7ocrkzgQ+5Vh3m8QFFL4cCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388596AbfFIREa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:04:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388620AbfFIRE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 13:04:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 429A820843;
        Sun,  9 Jun 2019 17:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099867;
        bh=/fgqGPPbxUV4uA+bSTZ51Uj7oZtb3BNhtgzicKWlTnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j2al5wakXM8lwfjp04YmlKwevsrqBBBCTjR9LCwSRRYcGgXVexEw5Hm8J/Dx/fI5A
         d+Z5cDLAhb0j0eIwFrH0JiHW/Wu3hKJ32hTIPve+/n/HAsM5/YaWn73Lh59uy4MIEk
         ZeNnISLE391NjVJHjPbWvc+dJXzNzPhuSh7EYP7A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        syzbot+71f1e64501a309fcc012@syzkaller.appspotmail.com
Subject: [PATCH 4.4 196/241] USB: Fix slab-out-of-bounds write in usb_get_bos_descriptor
Date:   Sun,  9 Jun 2019 18:42:18 +0200
Message-Id: <20190609164153.632077681@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

commit a03ff54460817c76105f81f3aa8ef655759ccc9a upstream.

The syzkaller USB fuzzer found a slab-out-of-bounds write bug in the
USB core, caused by a failure to check the actual size of a BOS
descriptor.  This patch adds a check to make sure the descriptor is at
least as large as it is supposed to be, so that the code doesn't
inadvertently access memory beyond the end of the allocated region
when assigning to dev->bos->desc->bNumDeviceCaps later on.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reported-and-tested-by: syzbot+71f1e64501a309fcc012@syzkaller.appspotmail.com
CC: <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/config.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -902,8 +902,8 @@ int usb_get_bos_descriptor(struct usb_de
 
 	/* Get BOS descriptor */
 	ret = usb_get_descriptor(dev, USB_DT_BOS, 0, bos, USB_DT_BOS_SIZE);
-	if (ret < USB_DT_BOS_SIZE) {
-		dev_err(ddev, "unable to get BOS descriptor\n");
+	if (ret < USB_DT_BOS_SIZE || bos->bLength < USB_DT_BOS_SIZE) {
+		dev_err(ddev, "unable to get BOS descriptor or descriptor too short\n");
 		if (ret >= 0)
 			ret = -ENOMSG;
 		kfree(bos);


