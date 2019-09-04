Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D54C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60F722CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731536AbfIDP43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:56:29 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:47132 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1731408AbfIDP42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:56:28 -0400
Received: (qmail 5016 invoked by uid 2102); 4 Sep 2019 11:56:27 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Sep 2019 11:56:27 -0400
Date:   Wed, 4 Sep 2019 11:56:27 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Greg KH <greg@kroah.com>
cc:     Thinh.Nguyen@synopsys.com, <andreyknvl@google.com>,
        <dianders@chromium.org>, <jflat@chromium.org>,
        <kai.heng.feng@canonical.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>, <malat@debian.org>,
        <mathias.nyman@linux.intel.com>, <nsaenzjulienne@suse.de>,
        <syzkaller-bugs@googlegroups.com>
Subject: [PATCH] USB: usbcore: Fix slab-out-of-bounds bug during device reset
In-Reply-To: <000000000000318cba0591a4f143@google.com>
Message-ID: <Pine.LNX.4.44L0.1909041154260.1722-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The syzbot fuzzer provoked a slab-out-of-bounds error in the USB core:

BUG: KASAN: slab-out-of-bounds in memcmp+0xa6/0xb0 lib/string.c:904
Read of size 1 at addr ffff8881d175bed6 by task kworker/0:3/2746

CPU: 0 PID: 2746 Comm: kworker/0:3 Not tainted 5.3.0-rc5+ #28
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  print_address_description+0x6a/0x32c mm/kasan/report.c:351
  __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:482
  kasan_report+0xe/0x12 mm/kasan/common.c:612
  memcmp+0xa6/0xb0 lib/string.c:904
  memcmp include/linux/string.h:400 [inline]
  descriptors_changed drivers/usb/core/hub.c:5579 [inline]
  usb_reset_and_verify_device+0x564/0x1300 drivers/usb/core/hub.c:5729
  usb_reset_device+0x4c1/0x920 drivers/usb/core/hub.c:5898
  rt2x00usb_probe+0x53/0x7af
drivers/net/wireless/ralink/rt2x00/rt2x00usb.c:806

The error occurs when the descriptors_changed() routine (called during
a device reset) attempts to compare the old and new BOS and capability
descriptors.  The length it uses for the comparison is the
wTotalLength value stored in BOS descriptor, but this value is not
necessarily the same as the length actually allocated for the
descriptors.  If it is larger the routine will call memcmp() with a
length that is too big, thus reading beyond the end of the allocated
region and leading to this fault.

The kernel reads the BOS descriptor twice: first to get the total
length of all the capability descriptors, and second to read it along
with all those other descriptors.  A malicious (or very faulty) device
may send different values for the BOS descriptor fields each time.
The memory area will be allocated using the wTotalLength value read
the first time, but stored within it will be the value read the second
time.

To prevent this possibility from causing any errors, this patch
modifies the BOS descriptor after it has been read the second time:
It sets the wTotalLength field to the actual length of the descriptors
that were read in and validated.  Then the memcpy() call, or any other
code using these descriptors, will be able to rely on wTotalLength
being valid.

Reported-and-tested-by: syzbot+35f4d916c623118d576e@syzkaller.appspotmail.com
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
CC: <stable@vger.kernel.org>

---


[as1912]


 drivers/usb/core/config.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

Index: usb-devel/drivers/usb/core/config.c
===================================================================
--- usb-devel.orig/drivers/usb/core/config.c
+++ usb-devel/drivers/usb/core/config.c
@@ -921,7 +921,7 @@ int usb_get_bos_descriptor(struct usb_de
 	struct usb_bos_descriptor *bos;
 	struct usb_dev_cap_header *cap;
 	struct usb_ssp_cap_descriptor *ssp_cap;
-	unsigned char *buffer;
+	unsigned char *buffer, *buffer0;
 	int length, total_len, num, i, ssac;
 	__u8 cap_type;
 	int ret;
@@ -966,10 +966,12 @@ int usb_get_bos_descriptor(struct usb_de
 			ret = -ENOMSG;
 		goto err;
 	}
+
+	buffer0 = buffer;
 	total_len -= length;
+	buffer += length;
 
 	for (i = 0; i < num; i++) {
-		buffer += length;
 		cap = (struct usb_dev_cap_header *)buffer;
 
 		if (total_len < sizeof(*cap) || total_len < cap->bLength) {
@@ -983,8 +985,6 @@ int usb_get_bos_descriptor(struct usb_de
 			break;
 		}
 
-		total_len -= length;
-
 		if (cap->bDescriptorType != USB_DT_DEVICE_CAPABILITY) {
 			dev_warn(ddev, "descriptor type invalid, skip\n");
 			continue;
@@ -1019,7 +1019,11 @@ int usb_get_bos_descriptor(struct usb_de
 		default:
 			break;
 		}
+
+		total_len -= length;
+		buffer += length;
 	}
+	dev->bos->desc->wTotalLength = cpu_to_le16(buffer - buffer0);
 
 	return 0;
 

