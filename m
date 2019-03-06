Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3F5C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61DFA20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbfCFLrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 06:47:35 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:35306 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729835AbfCFLrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 06:47:03 -0500
X-UUID: 71c216cf50d843e7a0eb9098144104dd-20190306
X-UUID: 71c216cf50d843e7a0eb9098144104dd-20190306
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 948106902; Wed, 06 Mar 2019 19:46:59 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 6 Mar 2019 19:46:58 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 6 Mar 2019 19:46:57 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 11/11] usb: mtu3: add a function to switch mailbox state to string
Date:   Wed, 6 Mar 2019 19:46:23 +0800
Message-ID: <1551872783-13707-12-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1551872783-13707-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1551872783-13707-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By introducing mailbox_state_string(), allow to make debug
log more readable

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_dr.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_dr.c b/drivers/usb/mtu3/mtu3_dr.c
index 82913120622b..5fcb71af875a 100644
--- a/drivers/usb/mtu3/mtu3_dr.c
+++ b/drivers/usb/mtu3/mtu3_dr.c
@@ -21,6 +21,22 @@ enum mtu3_vbus_id_state {
 	MTU3_VBUS_VALID,
 };
 
+static char *mailbox_state_string(enum mtu3_vbus_id_state state)
+{
+	switch (state) {
+	case MTU3_ID_FLOAT:
+		return "ID_FLOAT";
+	case MTU3_ID_GROUND:
+		return "ID_GROUND";
+	case MTU3_VBUS_OFF:
+		return "VBUS_OFF";
+	case MTU3_VBUS_VALID:
+		return "VBUS_VALID";
+	default:
+		return "UNKNOWN";
+	}
+}
+
 static void toggle_opstate(struct ssusb_mtk *ssusb)
 {
 	if (!ssusb->otg_switch.is_u3_drd) {
@@ -140,8 +156,8 @@ static void ssusb_set_mailbox(struct otg_switch_mtk *otg_sx,
 		container_of(otg_sx, struct ssusb_mtk, otg_switch);
 	struct mtu3 *mtu = ssusb->u3d;
 
-	dev_dbg(ssusb->dev, "mailbox state(%d)\n", status);
-	mtu3_dbg_trace(ssusb->dev, "mailbox %d", status);
+	dev_dbg(ssusb->dev, "mailbox %s\n", mailbox_state_string(status));
+	mtu3_dbg_trace(ssusb->dev, "mailbox %s", mailbox_state_string(status));
 
 	switch (status) {
 	case MTU3_ID_GROUND:
-- 
2.20.1

