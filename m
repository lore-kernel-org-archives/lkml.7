Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF4FC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968202064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfDOM6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:58:44 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:57412 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727129AbfDOM6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:58:43 -0400
X-UUID: e128850553214cce919d27f2e4c30f19-20190415
X-UUID: e128850553214cce919d27f2e4c30f19-20190415
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 72573011; Mon, 15 Apr 2019 20:58:38 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 15 Apr 2019 20:58:37 +0800
Received: from mtkslt302.mediatek.inc (10.21.14.115) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 15 Apr 2019 20:58:37 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, CK HU <ck.hu@mediatek.com>
CC:     Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <ginny.chen@mediatek.com>, <kendrick.hsu@mediatek.com>,
        Frederic Chen <Frederic.Chen@mediatek.com>
Subject: [PATCH v4 03/12] dt-binding: gce: add binding for gce event property
Date:   Mon, 15 Apr 2019 20:58:24 +0800
Message-ID: <20190415125833.38704-4-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190415125833.38704-1-bibby.hsieh@mediatek.com>
References: <20190415125833.38704-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Client hardware would send event to GCE hardware,
so #event-cells, mediatek,gce-event-names, mediatek,gce-events.
present the event.

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
---
 .../devicetree/bindings/mailbox/mtk-gce.txt     | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
index 1f7f8f2a3f49..2f175d6b296d 100644
--- a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
+++ b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
@@ -21,12 +21,21 @@ Required properties:
 	priority: Priority of GCE thread.
 	atomic_exec: GCE processing continuous packets of commands in atomic
 		way.
+- #event-cells: Should be 1.
+	<&phandle event_number>
+	phandle: Label name of a gce node.
+	event_number: the event number defined in 'dt-bindings/gce/mt8173-gce.h'
+		      or 'dt-binding/gce/mt8183-gce.h'.
 
 Required properties for a client device:
 - mboxes: Client use mailbox to communicate with GCE, it should have this
   property and list of phandle, mailbox specifiers.
 - mediatek,gce-subsys: u32, specify the sub-system id which is corresponding
   to the register address.
+Optional propertier for a client device:
+- mediatek,gce-event-names: the event name can be defined by user.
+- mediatek,gce-events: u32, the event number defined in
+  'dt-bindings/gce/mt8173-gce.h' or 'dt-binding/gce/mt8183-gce.h'.
 
 Some vaules of properties are defined in 'dt-bindings/gce/mt8173-gce.h'
 or 'dt-binding/gce/mt8183-gce.h'. Such as sub-system ids, thread priority, event ids.
@@ -40,6 +49,7 @@ Example:
 		clocks = <&infracfg CLK_INFRA_GCE>;
 		clock-names = "gce";
 		#mbox-cells = <3>;
+		#event-cells = <1>;
 	};
 
 Example for a client device:
@@ -49,8 +59,9 @@ Example for a client device:
 		mboxes = <&gce 0 CMDQ_THR_PRIO_LOWEST 1>,
 			 <&gce 1 CMDQ_THR_PRIO_LOWEST 1>;
 		mediatek,gce-subsys = <SUBSYS_1400XXXX>;
-		mutex-event-eof = <CMDQ_EVENT_MUTEX0_STREAM_EOF
-				CMDQ_EVENT_MUTEX1_STREAM_EOF>;
-
+		mediatek,gce-event-names = "rdma0_sof",
+					   "rsz0_sof";
+		mediatek,gce-events = <&gce CMDQ_EVENT_MDP_RDMA0_SOF>,
+				      <&gce CMDQ_EVENT_MDP_RSZ0_SOF>;
 		...
 	};
-- 
2.18.0

