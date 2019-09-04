Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9332AC3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D192339D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620088;
	bh=p/hUi43heFZyq1IFSlvJbF5pYdo6P6EBTGtmt+1Dk6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=04ko3/86iS9ZhYCXbOe+u/Fu0xdQu5ko+7ZEAN0tN5yo4Fl2LRNMZV4tzOGKvjWWz
	 yjPr/llhe3GWC5N/JPYNd3OKwfunCu/7gQTeBdpu8sK3m65Tp7dlufe4vxTdso+DD7
	 Y1tJnrpNDjVPVp1edNCwaMFB55lzm2rGWt92rCr8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388601AbfIDSB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:01:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388577AbfIDSBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:01:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D15D221883;
        Wed,  4 Sep 2019 18:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620084;
        bh=p/hUi43heFZyq1IFSlvJbF5pYdo6P6EBTGtmt+1Dk6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bx0qCsHV/d15eJNb3LQcJkZpTT6RO8d5IUDSNb9E1x33VceXB9cHJ+aiQ9Ub1tju4
         7s6NJ8FvmPyoWGUUZad+VXXZ0aYnJxue3HInfFZGduSBSrigxpDJy3r6RaZm2eY+d2
         OSRtP7Q4Y3V9OKchRG+zbHCoxzRSWYa2m4Xj/b6c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+d232cca6ec42c2edb3fc@syzkaller.appspotmail.com,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 4.9 66/83] USB: cdc-wdm: fix race between write and disconnect due to flag abuse
Date:   Wed,  4 Sep 2019 19:53:58 +0200
Message-Id: <20190904175309.436755181@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175303.488266791@linuxfoundation.org>
References: <20190904175303.488266791@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

commit 1426bd2c9f7e3126e2678e7469dca9fd9fc6dd3e upstream.

In case of a disconnect an ongoing flush() has to be made fail.
Nevertheless we cannot be sure that any pending URB has already
finished, so although they will never succeed, they still must
not be touched.
The clean solution for this is to check for WDM_IN_USE
and WDM_DISCONNECTED in flush(). There is no point in ever
clearing WDM_IN_USE, as no further writes make sense.

The issue is as old as the driver.

Fixes: afba937e540c9 ("USB: CDC WDM driver")
Reported-by: syzbot+d232cca6ec42c2edb3fc@syzkaller.appspotmail.com
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20190827103436.21143-1-oneukum@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/class/cdc-wdm.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -597,10 +597,20 @@ static int wdm_flush(struct file *file,
 {
 	struct wdm_device *desc = file->private_data;
 
-	wait_event(desc->wait, !test_bit(WDM_IN_USE, &desc->flags));
+	wait_event(desc->wait,
+			/*
+			 * needs both flags. We cannot do with one
+			 * because resetting it would cause a race
+			 * with write() yet we need to signal
+			 * a disconnect
+			 */
+			!test_bit(WDM_IN_USE, &desc->flags) ||
+			test_bit(WDM_DISCONNECTING, &desc->flags));
 
 	/* cannot dereference desc->intf if WDM_DISCONNECTING */
-	if (desc->werr < 0 && !test_bit(WDM_DISCONNECTING, &desc->flags))
+	if (test_bit(WDM_DISCONNECTING, &desc->flags))
+		return -ENODEV;
+	if (desc->werr < 0)
 		dev_err(&desc->intf->dev, "Error in flush path: %d\n",
 			desc->werr);
 
@@ -968,8 +978,6 @@ static void wdm_disconnect(struct usb_in
 	spin_lock_irqsave(&desc->iuspin, flags);
 	set_bit(WDM_DISCONNECTING, &desc->flags);
 	set_bit(WDM_READ, &desc->flags);
-	/* to terminate pending flushes */
-	clear_bit(WDM_IN_USE, &desc->flags);
 	spin_unlock_irqrestore(&desc->iuspin, flags);
 	wake_up_all(&desc->wait);
 	mutex_lock(&desc->rlock);


