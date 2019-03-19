Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABE4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 05:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA6020989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 05:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BEwEXmN3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfCSFR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 01:17:28 -0400
Received: from mail-eopbgr00043.outbound.protection.outlook.com ([40.107.0.43]:47940
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725931AbfCSFRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 01:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpYxOSfHb9KK7moInnDT+3uBVL5q9Ni+6e3Fq279hQs=;
 b=BEwEXmN3F6P22hs91r6B5ZLZTb7yBlTtvl1JuS2tJtXMm/S70O9Vn1UGJGB6mwH3Th1FAvWFJZHtBm7LSkYqOAZbq6tkf1Ln1T4ogX2ElRAXHnShOi/9kxLErZPl1VZwWVIwi0nVJtV6KM80oDpa6J5dqi6ZI8PHtutgMBnIBGY=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4796.eurprd04.prod.outlook.com (20.176.233.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 19 Mar 2019 05:17:19 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::39a4:c735:c8ef:afd5]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::39a4:c735:c8ef:afd5%4]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 05:17:19 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V2 1/5] can: rx-offload: add CANFD support based on offload
Thread-Topic: [PATCH V2 1/5] can: rx-offload: add CANFD support based on
 offload
Thread-Index: AQHU3hMG1dYp7d8ci0uBfqz2FO4VKQ==
Date:   Tue, 19 Mar 2019 05:17:19 +0000
Message-ID: <20190319051512.14950-2-qiangqing.zhang@nxp.com>
References: <20190319051512.14950-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20190319051512.14950-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR04CA0137.apcprd04.prod.outlook.com
 (2603:1096:3:16::21) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf88c2f6-ca11-4f4c-0565-08d6ac2a2899
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4796;
x-ms-traffictypediagnostic: DB7PR04MB4796:
x-microsoft-antispam-prvs: <DB7PR04MB47961249B6ECE52FB7DA55D6E6400@DB7PR04MB4796.eurprd04.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(366004)(346002)(39860400002)(189003)(199004)(54534003)(5660300002)(1076003)(76176011)(7736002)(52116002)(53936002)(478600001)(6512007)(14454004)(305945005)(4326008)(71190400001)(99286004)(6506007)(106356001)(102836004)(105586002)(26005)(2501003)(8936002)(97736004)(71200400001)(446003)(25786009)(11346002)(50226002)(86362001)(66066001)(81166006)(476003)(81156014)(186003)(486006)(6116002)(14444005)(256004)(68736007)(8676002)(386003)(6436002)(2616005)(3846002)(6486002)(110136005)(2906002)(54906003)(316002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4796;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: atniqBO+NQKQyCr0szmeRZ++mMQES5ZJJHdATqsm1gAVrdAglV0Ea5Gwno81kjGpWjKBKZe7ftOt9qVxlDSHJp7H/UqRNnjYC7TJ+3rqg0hhMBc6X2ZUTSBqEJAJpCZW7Oz2mzKgm+aTpnjAxaeDbfBxuDCWNQwInyT/+hCz3kMWlGX6oBb7JUwp7A1N8iMVOdAXqVS4ZMubc01SeoY+ZamfONo4qr+ROCH9oT6TMnQMx+PxHdRlr5oc5h24bm+Y+9VO2Cvdc78uvGMXzgRUOFOFAvfD46sv7XhDWshrDyYN7udWA1jBRhZj6AEZGyFMi5iFVVAYNXih+1xTvVAxRz3fD7aHv/9RZjJco4hNCfPj8VuOX/Q4k+EjJnlw/hWC0/3sqiOwfzk3kPqPItQx/Yix91b6AP2YSv8nbiMRUIk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf88c2f6-ca11-4f4c-0565-08d6ac2a2899
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 05:17:19.1876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4796
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

Using struct canfd_frame instead of can_frame to add support for CAN FD
mode in offload. FlexCAN controller will set the is_canfd variable when
it sets CAN FD mode.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>

ChangeLog:
----------
V1->V2:
	*None
---
 drivers/net/can/rx-offload.c   | 16 ++++++++++------
 include/linux/can/rx-offload.h |  4 +++-
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/rx-offload.c b/drivers/net/can/rx-offload.c
index 2ce4fa8698c7..131fe600deb3 100644
--- a/drivers/net/can/rx-offload.c
+++ b/drivers/net/can/rx-offload.c
@@ -55,11 +55,11 @@ static int can_rx_offload_napi_poll(struct napi_struct =
*napi, int quota)
=20
 	while ((work_done < quota) &&
 	       (skb =3D skb_dequeue(&offload->skb_queue))) {
-		struct can_frame *cf =3D (struct can_frame *)skb->data;
+		struct canfd_frame *cf =3D (struct canfd_frame *)skb->data;
=20
 		work_done++;
 		stats->rx_packets++;
-		stats->rx_bytes +=3D cf->can_dlc;
+		stats->rx_bytes +=3D cf->len;
 		netif_receive_skb(skb);
 	}
=20
@@ -122,16 +122,20 @@ static struct sk_buff *can_rx_offload_offload_one(str=
uct can_rx_offload *offload
 {
 	struct sk_buff *skb =3D NULL;
 	struct can_rx_offload_cb *cb;
-	struct can_frame *cf;
+	struct canfd_frame *cf;
 	int ret;
=20
 	/* If queue is full or skb not available, read to discard mailbox */
 	if (likely(skb_queue_len(&offload->skb_queue) <=3D
-		   offload->skb_queue_len_max))
-		skb =3D alloc_can_skb(offload->dev, &cf);
+		   offload->skb_queue_len_max)) {
+		if (offload->is_canfd)
+			skb =3D alloc_canfd_skb(offload->dev, &cf);
+		else
+			skb =3D alloc_can_skb(offload->dev, (struct can_frame **)&cf);
+	}
=20
 	if (!skb) {
-		struct can_frame cf_overflow;
+		struct canfd_frame cf_overflow;
 		u32 timestamp;
=20
 		ret =3D offload->mailbox_read(offload, &cf_overflow,
diff --git a/include/linux/can/rx-offload.h b/include/linux/can/rx-offload.=
h
index 8268811a697e..6448e7dfc170 100644
--- a/include/linux/can/rx-offload.h
+++ b/include/linux/can/rx-offload.h
@@ -23,7 +23,7 @@
 struct can_rx_offload {
 	struct net_device *dev;
=20
-	unsigned int (*mailbox_read)(struct can_rx_offload *offload, struct can_f=
rame *cf,
+	unsigned int (*mailbox_read)(struct can_rx_offload *offload, struct canfd=
_frame *cf,
 				     u32 *timestamp, unsigned int mb);
=20
 	struct sk_buff_head skb_queue;
@@ -35,6 +35,8 @@ struct can_rx_offload {
 	struct napi_struct napi;
=20
 	bool inc;
+
+	bool is_canfd;
 };
=20
 int can_rx_offload_add_timestamp(struct net_device *dev, struct can_rx_off=
load *offload);
--=20
2.17.1

