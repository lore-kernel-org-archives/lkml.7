Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A30BC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0565320675
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732927AbfDQRFk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:05:40 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2540 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729512AbfDQRFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:05:40 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 701047CBC33A7EF35219;
        Thu, 18 Apr 2019 01:05:34 +0800 (CST)
Received: from dggeme760-chm.china.huawei.com (10.3.19.106) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 18 Apr 2019 01:05:34 +0800
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 dggeme760-chm.china.huawei.com (10.3.19.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 18 Apr 2019 01:05:33 +0800
Received: from dggeme762-chm.china.huawei.com ([10.8.68.53]) by
 dggeme762-chm.china.huawei.com ([10.8.68.53]) with mapi id 15.01.1591.008;
 Thu, 18 Apr 2019 01:05:33 +0800
From:   "zhuyan (M)" <zhuyan34@huawei.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        "anton@enomsg.org" <anton@enomsg.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] usb:host: fix divide-by-zero in function fhci_queue_urb
Thread-Topic: [PATCH v2] usb:host: fix divide-by-zero in function
 fhci_queue_urb
Thread-Index: AdT1Pydeg6Rr/q0XRBeXbW3Dz7nOAw==
Date:   Wed, 17 Apr 2019 17:05:33 +0000
Message-ID: <63401dc56ae64aa3a428c4bb8a84034e@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.40.99.186]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019, Alan Stern wrote:

> On Wed, 17 Apr 2019, zhuyan (M) wrote:
> 
> > On Tue, 16 Apr 2019 11:07:56 -0400, Alan Stern wrote:
> > 
> > > On Tue, 16 Apr 2019, zhuyan (M) wrote:
> > > > On Tue, 16 Apr 2019 at 11:45:45 +0200, Greg KH wrote:
> > > > > On Tue, Apr 09, 2019 at 10:37:12PM +0800, zhuyan wrote:
> > > > > > In function fhci_queue_urb, the divisor of expression 
> > > > > > (urb->transfer_buffer_length % usb_maxpacket(urb->dev, 
> > > > > > urb->pipe,
> > > > > > usb_pipeout(urb->pipe))) may be zero.
> > > > > 
> > > > > How can you hit that?
> > > > > 
> > > > > > When it is zero, unexpected results may occur, so it is 
> > > > > > necessary to ensure that the divisor is not zero.
> > > > > > 
> > > > > > Signed-off-by: zhuyan <zhuyan34@huawei.com>
> > > > > 
> > > > > I need a "Full" name here, not just a single name.  Whatever you use to sign documents is good.
> > > > > 
> > > > > thanks,
> > > > > 
> > > > > greg k-h
> > > > 
> > > > In function usb_maxpacket, when ep is NULL, its return value is 0.  
> > > 
> > > fhci_queue_urb() shouldn't use urb->pipe to compute the maxpacket 
> > > size anyway.  It should use usb_endpoint_maxp(&urb->ep->desc).
> > 
> > Currently, fhci_queue_urb(), call usb_maxpacket() multiple times to 
> > calculate  the maxpacket size. The usb_maxpacket() will call 
> > usb_endpoint_maxp() to compute the maxpacket size.
> 
> I know that.  What fhci_queue_urb() is doing is wrong.  You should change it: 
> Make it call usb_endpoint_maxp directly instead of calling usb_maxpacket.
> 

From 1996456d0cc17b5ff7746a598ff355b25d13db3e Mon Sep 17 00:00:00 2001
From: zhuyan <zhuyan34@huawei.com>
Date: Thu, 18 Apr 2019 00:53:03 +0800
Subject: [PATCH] usb: host: fix divide-by-zero in function fhci_queue_urb

fhci_queue_urb() shouldn't use urb->pipe to compute the maxpacket
size anyway.It should use usb_endpoint_maxp(&urb->ep->desc).

In function fhci_queue_urb, the divisor of expression
(urb->transfer_buffer_length % usb_maxpacket(urb->dev, urb->pipe,
usb_pipeout(urb->pipe))) may be zero. When it is zero, unexpected results
may occur, so it is necessary to ensure that the divisor is not zero.

Signed-off-by: zhuyan <zhuyan34@huawei.com>
---
 drivers/usb/host/fhci-sched.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/fhci-sched.c b/drivers/usb/host/fhci-sched.c
index 3d12cdd..7dcfe22 100644
--- a/drivers/usb/host/fhci-sched.c
+++ b/drivers/usb/host/fhci-sched.c
@@ -704,6 +704,7 @@ void fhci_queue_urb(struct fhci_hcd *fhci, struct urb *urb)
 	struct td *td;
 	u8 *data;
 	u16 cnt = 0;
+	u16 max_pkt_size = 0;
 
 	if (ed == NULL) {
 		ed = fhci_get_empty_ed(fhci);
@@ -727,8 +728,7 @@ void fhci_queue_urb(struct fhci_hcd *fhci, struct urb *urb)
 		}
 		ed->speed = (urb->dev->speed == USB_SPEED_LOW) ?
 			FHCI_LOW_SPEED : FHCI_FULL_SPEED;
-		ed->max_pkt_size = usb_maxpacket(urb->dev,
-			urb->pipe, usb_pipeout(urb->pipe));
+		ed->max_pkt_size = usb_endpoint_maxp(&urb->ep->desc);
 		urb->ep->hcpriv = ed;
 		fhci_dbg(fhci, "new ep speed=%d max_pkt_size=%d\n",
 			 ed->speed, ed->max_pkt_size);
@@ -765,11 +765,12 @@ void fhci_queue_urb(struct fhci_hcd *fhci, struct urb *urb)
 
 	switch (ed->mode) {
 	case FHCI_TF_BULK:
+		max_pkt_size = usb_endpoint_maxp(&urb->ep->desc);
 		if (urb->transfer_flags & URB_ZERO_PACKET &&
 				urb->transfer_buffer_length > 0 &&
+				(max_pkt_size != 0) &&
 				((urb->transfer_buffer_length %
-				usb_maxpacket(urb->dev, urb->pipe,
-				usb_pipeout(urb->pipe))) == 0))
+				max_pkt_size) == 0))
 			urb_state = US_BULK0;
 		while (data_len > 4096) {
 			td = fhci_td_fill(fhci, urb, urb_priv, ed, cnt,
@@ -807,8 +808,8 @@ void fhci_queue_urb(struct fhci_hcd *fhci, struct urb *urb)
 		break;
 	case FHCI_TF_CTRL:
 		ed->dev_addr = usb_pipedevice(urb->pipe);
-		ed->max_pkt_size = usb_maxpacket(urb->dev, urb->pipe,
-			usb_pipeout(urb->pipe));
+		ed->max_pkt_size = usb_endpoint_maxp(&urb->ep->desc);
+
 		/* setup stage */
 		td = fhci_td_fill(fhci, urb, urb_priv, ed, cnt++, FHCI_TA_SETUP,
 			USB_TD_TOGGLE_DATA0, urb->setup_packet, 8, 0, 0, true);
-- 
1.8.5.6

