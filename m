Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB467C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBE9217D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfICTdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 15:33:24 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:33680 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726177AbfICTdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 15:33:24 -0400
Received: (qmail 7621 invoked by uid 2102); 3 Sep 2019 15:33:23 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Sep 2019 15:33:23 -0400
Date:   Tue, 3 Sep 2019 15:33:23 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     syzbot <syzbot+35f4d916c623118d576e@syzkaller.appspotmail.com>
cc:     Thinh.Nguyen@synopsys.com, <andreyknvl@google.com>,
        <dianders@chromium.org>, <gregkh@linuxfoundation.org>,
        <jflat@chromium.org>, <kai.heng.feng@canonical.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <malat@debian.org>, <mathias.nyman@linux.intel.com>,
        <nsaenzjulienne@suse.de>, <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: slab-out-of-bounds Read in usb_reset_and_verify_device
In-Reply-To: <0000000000009290140591aaf9e7@google.com>
Message-ID: <Pine.LNX.4.44L0.1909031531040.1859-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2019, syzbot wrote:

> Hello,
> 
> syzbot has tested the proposed patch but the reproducer still triggered  
> crash:
> KASAN: slab-out-of-bounds Read in usb_reset_and_verify_device
> 
> usb 4-1: Old BOS 00000000ffd70172  Len 0xa8
> usb 4-1: New BOS 00000000b6d58371  Len 0xa8
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in memcmp+0xa6/0xb0 lib/string.c:904
> Read of size 1 at addr ffff8881cd95d876 by task kworker/0:4/2841

Argh -- I forgot about printk's kernel-address mangling.  Let's try 
again.

Alan Stern

#syz test: https://github.com/google/kasan.git eea39f24

Index: usb-devel/drivers/usb/core/hub.c
===================================================================
--- usb-devel.orig/drivers/usb/core/hub.c
+++ usb-devel/drivers/usb/core/hub.c
@@ -5721,6 +5721,13 @@ static int usb_reset_and_verify_device(s
 	if (ret < 0)
 		goto re_enumerate;
 
+	if (bos)
+		dev_info(&udev->dev, "Old BOS %px  Len 0x%x\n",
+			bos, le16_to_cpu(bos->desc->wTotalLength));
+	if (udev->bos)
+		dev_info(&udev->dev, "New BOS %px  Len 0x%x\n",
+			udev->bos, le16_to_cpu(udev->bos->desc->wTotalLength));
+
 	/* Device might have changed firmware (DFU or similar) */
 	if (descriptors_changed(udev, &descriptor, bos)) {
 		dev_info(&udev->dev, "device firmware changed\n");


