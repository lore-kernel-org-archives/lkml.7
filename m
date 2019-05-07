Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFE0C04A6B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 02:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85FB420C01
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 02:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfEGCXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 22:23:17 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:54091 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726236AbfEGCXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 22:23:17 -0400
X-UUID: 6ec617e61e9b462c84202b6b1ccd0d33-20190507
X-UUID: 6ec617e61e9b462c84202b6b1ccd0d33-20190507
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 609988709; Tue, 07 May 2019 10:23:05 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 7 May 2019 10:23:02 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 7 May 2019 10:23:00 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Yu Chen <chenyu56@huawei.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Min Guo <min.guo@mediatek.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: [v2 PATCH] dt-binding: usb: add usb-role-switch property
Date:   Tue, 7 May 2019 10:22:58 +0800
Message-ID: <38ff51264e971d5c58940c8435b9d8d274662d50.1557195204.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a property usb-role-switch to tell Dual-Role controller driver
that use USB Role Switch framework to handle the role switch between
host mode and device mode, it's useful when the driver has already
supported other ways, such as extcon framework etc.

Cc: Biju Das <biju.das@bp.renesas.com>
Cc: Yu Chen <chenyu56@huawei.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2:
    describe it in terms of h/w functionality suggested by Rob

v1:
    the property is discussed in:
    [v2,2/7] dt-bindings: usb: renesas_usb3: add usb-role-switch property
    https://patchwork.kernel.org/patch/10852497/

    Mediatek and Hisilicon also try to use it:
    [v4,3/6] dt-bindings: usb: mtu3: add properties about USB Role Switch
    https://patchwork.kernel.org/patch/10918385/
    [v4,6/6] usb: mtu3: register a USB Role Switch for dual role mode
    https://patchwork.kernel.org/patch/10918367/

    [v6,10/13] usb: dwc3: Registering a role switch in the DRD code
    https://patchwork.kernel.org/patch/10909981/
---
 Documentation/devicetree/bindings/usb/generic.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/generic.txt b/Documentation/devicetree/bindings/usb/generic.txt
index 0a74ab8dfdc2..f5a6ad053ecc 100644
--- a/Documentation/devicetree/bindings/usb/generic.txt
+++ b/Documentation/devicetree/bindings/usb/generic.txt
@@ -30,6 +30,11 @@ Optional properties:
 			optional for OTG device.
  - adp-disable: tells OTG controllers we want to disable OTG ADP, ADP is
 			optional for OTG device.
+ - usb-role-switch: tells Dual-Role USB controllers we want to handle the role
+			switch between host and device according to the state
+			detected by the USB connector, typically for Type-C,
+			Type-B(micro).
+			see connector/usb-connector.txt.
 
 This is an attribute to a USB controller such as:
 
-- 
2.21.0

