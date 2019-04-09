Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABE2C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2169120883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfDIOjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:39:49 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5704 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726035AbfDIOjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:39:48 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 21B605E8C71BA959E5EA;
        Tue,  9 Apr 2019 22:39:46 +0800 (CST)
Received: from suse12-sp2.huawei.com (10.67.189.94) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.408.0; Tue, 9 Apr 2019 22:39:36 +0800
From:   zhuyan <zhuyan34@huawei.com>
To:     <gregkh@linuxfoundation.org>, <anton@enomsg.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhuyan34@huawei.com>
Subject: [PATCH] usb:host: fix divide-by-zero in function fhci_queue_urb
Date:   Tue, 9 Apr 2019 22:37:12 +0800
Message-ID: <1554820632-13782-1-git-send-email-zhuyan34@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.94]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function fhci_queue_urb, the divisor of expression
(urb->transfer_buffer_length % usb_maxpacket(urb->dev, urb->pipe,
usb_pipeout(urb->pipe))) may be zero. When it is zero, unexpected results
may occur, so it is necessary to ensure that the divisor is not zero.

Signed-off-by: zhuyan <zhuyan34@huawei.com>
---
 drivers/usb/host/fhci-sched.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/fhci-sched.c b/drivers/usb/host/fhci-sched.c
index 3d12cdd..27ed63c 100644
--- a/drivers/usb/host/fhci-sched.c
+++ b/drivers/usb/host/fhci-sched.c
@@ -704,6 +704,7 @@ void fhci_queue_urb(struct fhci_hcd *fhci, struct urb *urb)
 	struct td *td;
 	u8 *data;
 	u16 cnt = 0;
+	u16 max_pkt_size = 0;
 
 	if (ed == NULL) {
 		ed = fhci_get_empty_ed(fhci);
@@ -765,11 +766,13 @@ void fhci_queue_urb(struct fhci_hcd *fhci, struct urb *urb)
 
 	switch (ed->mode) {
 	case FHCI_TF_BULK:
+		max_pkt_size = usb_maxpacket(urb->dev, urb->pipe,
+					usb_pipeout(urb->pipe));
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
-- 
1.8.5.6

