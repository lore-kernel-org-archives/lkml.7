Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA3DC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4347F206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HglFa2D6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbfCFKA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:00:59 -0500
Received: from mail-eopbgr80077.outbound.protection.outlook.com ([40.107.8.77]:12512
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729791AbfCFKA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:00:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQ+2tC6AxaMqxzQcePJSsACdlk6ZPcs3B4lShio9FnI=;
 b=HglFa2D6UKSj0HrGn+P35pbmfjTgp9lhQO0jFfO+AFWnP3lMTt6rO7pPe+V9Npt4aq9Y/y+vODU7uQiEkH7XQ9hhnhJZu7ghwXh8KqNvKEsYl4xqBzo2QjCf1CDFOFh3vaIyxDRmc1ZrjmVDu2xGrqy2pp2LvGvgbwnIDgfvSwY=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB5404.eurprd04.prod.outlook.com (20.178.104.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Wed, 6 Mar 2019 10:00:54 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::2083:76ce:c2b6:6a39]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::2083:76ce:c2b6:6a39%4]) with mapi id 15.20.1686.018; Wed, 6 Mar 2019
 10:00:54 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH RESEND 1/5] can: rx-offload: add CANFD support based on
 offload
Thread-Topic: [PATCH RESEND 1/5] can: rx-offload: add CANFD support based on
 offload
Thread-Index: AQHU1AN8hwcnVcoayUmVLrX8wATScQ==
Date:   Wed, 6 Mar 2019 10:00:53 +0000
Message-ID: <20190306095833.20922-2-qiangqing.zhang@nxp.com>
References: <20190306095833.20922-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20190306095833.20922-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR02CA0106.apcprd02.prod.outlook.com
 (2603:1096:4:92::22) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b37bd0d3-ec6b-4f13-c2b4-08d6a21a9ed3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5404;
x-ms-traffictypediagnostic: DB7PR04MB5404:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB7PR04MB5404;23:YhMl2WLIm6V+IVjUWOYiFUiFCNBS43TgiauRtMl?=
 =?iso-8859-1?Q?igYFgECDMIoSlca6O3Ov39+TSPLpl0fRxiI0EGZNEw7hFj1kTFRzFtLM5d?=
 =?iso-8859-1?Q?NXM1u0k6PeNpb0oJmbgYidsxG8O/Ohm3uyGQFC2twRo5HOz5B/tm4cVa8q?=
 =?iso-8859-1?Q?flJO2jxpQTRGjcs6xyBAjPH/nYFkDn1uHfOv9l1FMG5GBju94Vs/SA8wOm?=
 =?iso-8859-1?Q?vIL5i7bQYd2GgTUlN9t6qpBAw+NWUMTabUTGLU85PsMBhh6GeG9oWWVFZ/?=
 =?iso-8859-1?Q?4Ar8sLe7fAFA5EmxYjXCDs7JjGVcgEU3BAlJ4E+rILrrzmCrQ48KpzeK1f?=
 =?iso-8859-1?Q?YgD4gkpjgSesMSjB6wICVlpABaBfInDSYKpMPNO+So6PjvFfV8ervKbD6V?=
 =?iso-8859-1?Q?NnkPiv4eX4B4uysnYVhgpM/osW/oRzSFqzQzKRV0AT+UR+nj6DuoLJBJsu?=
 =?iso-8859-1?Q?KM9fvG5bSK6pOeGA14YCs6B2jjEYXc4qcPAMQYlsGfSMUeIPux8SCFqFro?=
 =?iso-8859-1?Q?YImREPJqusb+0uI1rMkalerIqnWPZcpC06+IcWC7Lo5hrw+y6c5Vsii9wg?=
 =?iso-8859-1?Q?/sSJcqo/HD9g/0hiQxQDnOY7BO83R5JQcF153Fb518KdPGLy296383mr71?=
 =?iso-8859-1?Q?KFT4OC1z09OjBFRQHMC8RDu9iIlgoKCOzF9kaCc4IVxC9DfaTWo2pZDK32?=
 =?iso-8859-1?Q?Ys0RTGZktSukKH0JMtN82N04ruQLGKCWqNpu6bZzJiFD6P23g6hkE1Tq5y?=
 =?iso-8859-1?Q?/x1t4+qt45CPHJPsjiyuT8xD3h5COxfWO5YruJWmp+0Oij5ntBUDS3rbH6?=
 =?iso-8859-1?Q?Xl+oMMheCmtcMOmW/PhmeOTNs3O8g9mhe3rQdHFbtQmXk5I5iwoo6vhE02?=
 =?iso-8859-1?Q?0U3FEH1bjLqIomPL28PplWzi+CfGZ/ga3P+dyyVrsFDcuSlW+1rUHW0L2P?=
 =?iso-8859-1?Q?2ztFclE3nN7P4Rhw2KdmtC4PRsFIKIM0vQ5XEXMvugL3LoL3t+q3LvZXO7?=
 =?iso-8859-1?Q?VLsRWE+bWpf7lZ1u5U413q1kZbgPwWpvoZsxqjEDxcRTwH8qXLKzrndUVL?=
 =?iso-8859-1?Q?7MGUhD/acH3dBOu9DY97hBzHo6p/rr5hk0msX3JTBhYv6Li5WX2JLi4b+q?=
 =?iso-8859-1?Q?A/yqZo7Af2179lDBwJ6i0CrHO3SSRH99mbSMFRpQ5r/FOS+NkUpJ5PGh+M?=
 =?iso-8859-1?Q?RIKcAB0qz8q7zDi0EWykZ50wm06M36taKQxPkutTsx4bUX2vM9Z10A4hBc?=
 =?iso-8859-1?Q?qX6/V69Uv/KxURTd/ixE+xOneo+8xus9jzSbQW0VCIKLTmGs3CP9YACiuB?=
 =?iso-8859-1?Q?vo=3D?=
x-microsoft-antispam-prvs: <DB7PR04MB540496FE23F4257E8F5FD10AE6730@DB7PR04MB5404.eurprd04.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(366004)(396003)(199004)(189003)(54906003)(6436002)(99286004)(8936002)(26005)(305945005)(186003)(4326008)(36756003)(6506007)(102836004)(11346002)(105586002)(446003)(2616005)(486006)(256004)(14444005)(106356001)(386003)(2906002)(71190400001)(25786009)(2501003)(1076003)(71200400001)(476003)(52116002)(81156014)(97736004)(81166006)(6116002)(3846002)(14454004)(68736007)(5660300002)(8676002)(6512007)(110136005)(316002)(53936002)(76176011)(478600001)(50226002)(86362001)(66066001)(7736002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5404;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ibZTm7lQi/n2FZA7DiypmqIv8Wy0Rtppacq1epL1KVaDWrB3KGX2hfwLaYUJUjkU9VZ0WpvFIKcBSOe+fmKYDhmEFFTPnHDxslHCJYBQ3W0K+yVatDO/h3ikBMH4EzgM7cRVl4LtOkzD8DaKw62PxOPdxuJG4ThKiBNDd1oJP083lkbtJ9LGs4DbRE3ptXqQlGyMZFWswAQm+V3+v4c7oDCUZvLb5r4n4DbC9m3pOvzzeKL5d4FAEYJEELOUQ9troqSzJCbxLIZaoiqk2efqL1pFZChWJZyPOUHi4UnAZvKP6/77QFFCONJ1wGXNsWYg+aZP/TfLM9hOyZ7/ch/PVYUm33M4EQXfQ7LaMWgSjxgkwXPYQMrEWRscgX8hiGMTNPiYnE07yjkDCgIH7cfJioymIAb0pNWPJtD9q9/b534=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b37bd0d3-ec6b-4f13-c2b4-08d6a21a9ed3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 10:00:53.9573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5404
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

Using struct canfd_frame instead of can_frame to add support for CAN FD
mode in offload. FlexCAN controller will set the is_canfd variable when
it supports CAN FD mode.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
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

