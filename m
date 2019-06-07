Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5F5C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1599F21479
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559922493;
	bh=4F552kNBN2ZbTyA9sXoc9rQGnJafrCmEpxl5/AF5lc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=up6FoPX3aOqyrxcEaLDeonV2Lp8/jD5Pv+fFqOgHVbx0aGI8d3Iz1YP+OpnY936Qr
	 1EXy/NUsylAyGGwzhFyDaGnSdERgBO9b7YPEI9+cCOxo4Ck0R3oXQyTKcUxDZlnNbp
	 Os6IOeRl9uFEIf8wULLW+thCXsHEmqTBLfAFNh3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731734AbfFGPsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:48:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731718AbfFGPsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:48:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4E4420657;
        Fri,  7 Jun 2019 15:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559922486;
        bh=4F552kNBN2ZbTyA9sXoc9rQGnJafrCmEpxl5/AF5lc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nZ7ATjirm+g+4Sl/KseqFVTO4N/o2OqDu5dUGXARkmQV7VriNn2rEyc1oHXUVNtv9
         kFTmbaLoPDAoOTBhpqeCi+gysHIgF77qFgWjVXKQiRSzreEeOAMKNdPIKzvL6ZkOo1
         /mhmMcw815AwqVyFZ29QrCRh96xLXY4DkIJC9zVk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        syzbot+71f1e64501a309fcc012@syzkaller.appspotmail.com
Subject: [PATCH 5.1 09/85] USB: Fix slab-out-of-bounds write in usb_get_bos_descriptor
Date:   Fri,  7 Jun 2019 17:38:54 +0200
Message-Id: <20190607153850.268456638@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607153849.101321647@linuxfoundation.org>
References: <20190607153849.101321647@linuxfoundation.org>
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
@@ -932,8 +932,8 @@ int usb_get_bos_descriptor(struct usb_de
 
 	/* Get BOS descriptor */
 	ret = usb_get_descriptor(dev, USB_DT_BOS, 0, bos, USB_DT_BOS_SIZE);
-	if (ret < USB_DT_BOS_SIZE) {
-		dev_err(ddev, "unable to get BOS descriptor\n");
+	if (ret < USB_DT_BOS_SIZE || bos->bLength < USB_DT_BOS_SIZE) {
+		dev_err(ddev, "unable to get BOS descriptor or descriptor too short\n");
 		if (ret >= 0)
 			ret = -ENOMSG;
 		kfree(bos);


