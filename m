Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C94C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7E422CE3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbfHUQTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 12:19:46 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:53716 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727464AbfHUQTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 12:19:46 -0400
Received: (qmail 5546 invoked by uid 2102); 21 Aug 2019 12:19:45 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Aug 2019 12:19:45 -0400
Date:   Wed, 21 Aug 2019 12:19:45 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     syzbot <syzbot+ded1794a717e3b235226@syzkaller.appspotmail.com>
cc:     andreyknvl@google.com, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: use-after-free Read in hidraw_ioctl
In-Reply-To: <00000000000027b5750590a087dc@google.com>
Message-ID: <Pine.LNX.4.44L0.1908211218550.1816-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: https://github.com/google/kasan.git e96407b4

Index: usb-devel/drivers/hid/hidraw.c
===================================================================
--- usb-devel.orig/drivers/hid/hidraw.c
+++ usb-devel/drivers/hid/hidraw.c
@@ -370,7 +370,7 @@ static long hidraw_ioctl(struct file *fi
 
 	mutex_lock(&minors_lock);
 	dev = hidraw_table[minor];
-	if (!dev) {
+	if (!dev || !dev->exist) {
 		ret = -ENODEV;
 		goto out;
 	}

