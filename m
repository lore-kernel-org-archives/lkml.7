Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F34CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAB020B7C
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210489;
	bh=NmV6U+ZW2iYHDa8chiDrZg4AJ8VaQfyPNlEP5oIhy58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m0JspWiPHzdcUsyS8dFD39wVkxroeGJUpFaMxZ+GvcyISOAX7oAVZa9Wt1pCs9ykH
	 g1v9vZOHEnlTk36GDPlTkb8snqy3CPe+5YljfDxdan4FZRzrjzjyYeZ1Aa/5NoC6ym
	 5+ZcFX/gWyb7zFmLmjENSv9iPA/UuDXsAlzqpg7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbfJ0VII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:08:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729313AbfJ0VID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:08:03 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7364B2064A;
        Sun, 27 Oct 2019 21:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210483;
        bh=NmV6U+ZW2iYHDa8chiDrZg4AJ8VaQfyPNlEP5oIhy58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WzL8BQiGIzGDb6HCDkyboQ9/zRVRhesRLZVryPWjaLUhBhFRKJCE1VrrnC3y6nIkZ
         bB91Grj5T52tj6LHeZ4Q6cy04p8mLQjsX99F3fmGMxtaybcHnEE1KK0hC3D/h8Maw8
         HzAbt7UOYRuKd9hrCL3c3y/lv+Spv3j23is9SP5s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.14 030/119] USB: legousbtower: fix memleak on disconnect
Date:   Sun, 27 Oct 2019 22:00:07 +0100
Message-Id: <20191027203309.490183100@linuxfoundation.org>
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

commit b6c03e5f7b463efcafd1ce141bd5a8fc4e583ae2 upstream.

If disconnect() races with release() after a process has been
interrupted, release() could end up returning early and the driver would
fail to free its driver data.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20191010125835.27031-3-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/misc/legousbtower.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/usb/misc/legousbtower.c
+++ b/drivers/usb/misc/legousbtower.c
@@ -423,10 +423,7 @@ static int tower_release (struct inode *
 		goto exit;
 	}
 
-	if (mutex_lock_interruptible(&dev->lock)) {
-	        retval = -ERESTARTSYS;
-		goto exit;
-	}
+	mutex_lock(&dev->lock);
 
 	if (dev->open_count != 1) {
 		dev_dbg(&dev->udev->dev, "%s: device not opened exactly once\n",


