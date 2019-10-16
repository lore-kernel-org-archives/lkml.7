Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785CFECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BCDD207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571264469;
	bh=/65x1RXpW1BL+sNWRXmIXwJn2MK+GW4GX8yPWk69DX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r8w9ygdRVpsGImBP2oN9aDjCChvgxskLRC15w3xPLdcfpCwdzT8ygapyp45sNofKp
	 kqGgpdixqJ4IqxSAExy3x4ljT7X8XtEtHnIkanyzevA++ZqhWDV4Ad7GpGnL38qrDY
	 fTkoDhZvHQECmahOUrrGhg5qHolGrrXfOZDluBPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437689AbfJPWVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:21:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437564AbfJPVxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:53:40 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA21F218DE;
        Wed, 16 Oct 2019 21:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262819;
        bh=/65x1RXpW1BL+sNWRXmIXwJn2MK+GW4GX8yPWk69DX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jVob2SxtZrjBdJfJCAshH2e9pbWco2y4KHnZA4+PO9dohZyL8DCLKwCIObPAd6vBA
         iRvH+HTPuTAVMTxkzXTRN/lBgpccFs6Iv2N/fkuyBG7iLs2LTxHfgZPc3FIGEez41Y
         sLvHFA3GskNRq8/6cRzsbZRfBmGzFUsfkTi5N2gI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.4 62/79] USB: legousbtower: fix open after failed reset request
Date:   Wed, 16 Oct 2019 14:50:37 -0700
Message-Id: <20191016214824.430528358@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214729.758892904@linuxfoundation.org>
References: <20191016214729.758892904@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 0b074f6986751361ff442bc1127c1648567aa8d6 upstream.

The driver would return with a nonzero open count in case the reset
control request failed. This would prevent any further attempts to open
the char dev until the device was disconnected.

Fix this by incrementing the open count only on successful open.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Johan Hovold <johan@kernel.org>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20190919083039.30898-5-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/misc/legousbtower.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/misc/legousbtower.c
+++ b/drivers/usb/misc/legousbtower.c
@@ -354,7 +354,6 @@ static int tower_open (struct inode *ino
 		retval = -EBUSY;
 		goto unlock_exit;
 	}
-	dev->open_count = 1;
 
 	/* reset the tower */
 	result = usb_control_msg (dev->udev,
@@ -394,13 +393,14 @@ static int tower_open (struct inode *ino
 		dev_err(&dev->udev->dev,
 			"Couldn't submit interrupt_in_urb %d\n", retval);
 		dev->interrupt_in_running = 0;
-		dev->open_count = 0;
 		goto unlock_exit;
 	}
 
 	/* save device in the file's private structure */
 	file->private_data = dev;
 
+	dev->open_count = 1;
+
 unlock_exit:
 	mutex_unlock(&dev->lock);
 


