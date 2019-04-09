Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E0CC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F8920883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TJ4QXgoF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfDIHE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 03:04:57 -0400
Received: from mail-eopbgr80074.outbound.protection.outlook.com ([40.107.8.74]:37398
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725781AbfDIHE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 03:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wY72fsFKTu+kZsYRvTD+Mg8+jOFtIGOl4wTfz6Bypvw=;
 b=TJ4QXgoFubZlUAlA7Q+NO5TOFGFfuu6IAcpPuHQyf956pD07Zia0DGaU+vM7WrN7AZeKQdFwVux0Wv/UYeImCItk46ziM5HMy5HtEFiV7BGqSnI9p4xHgeI1HuAzcBb5Yhptf0ZHMDESz1f06k5AW+ds4N8fDRM/k6tSiX3pfmM=
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com (10.175.23.144) by
 VI1PR0402MB2784.eurprd04.prod.outlook.com (10.172.255.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Tue, 9 Apr 2019 07:04:53 +0000
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::b8b3:8509:a056:360e]) by VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::b8b3:8509:a056:360e%2]) with mapi id 15.20.1792.009; Tue, 9 Apr 2019
 07:04:53 +0000
From:   Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 2/5] can: flexcan: add CAN FD mode support
Thread-Topic: [PATCH V2 2/5] can: flexcan: add CAN FD mode support
Thread-Index: AQHU7jLtjTghFqR720GjUH/3qPjtqaYzFYcAgABPh5A=
Date:   Tue, 9 Apr 2019 07:04:53 +0000
Message-ID: <VI1PR0402MB286355821F5C81122A7C86E2DF2D0@VI1PR0402MB2863.eurprd04.prod.outlook.com>
References: <20190319051512.14950-3-qiangqing.zhang@nxp.com>
 <385f7948-d12b-1fc2-2ed2-23d1e76034a0@nxp.com>
 <DB7PR04MB46181D2AC261EAB6DEECEFCCE62D0@DB7PR04MB4618.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB46181D2AC261EAB6DEECEFCCE62D0@DB7PR04MB4618.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stefan-gabriel.mirea@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25e393c0-2030-4978-edb3-08d6bcb9aa70
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB2784;
x-ms-traffictypediagnostic: VI1PR0402MB2784:
x-microsoft-antispam-prvs: <VI1PR0402MB2784E21F46E24397BF2BD1C8DF2D0@VI1PR0402MB2784.eurprd04.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(136003)(366004)(189003)(199004)(8676002)(3846002)(25786009)(110136005)(486006)(6116002)(54906003)(105586002)(5660300002)(256004)(99286004)(106356001)(14444005)(52536014)(55016002)(8936002)(81156014)(81166006)(316002)(68736007)(2906002)(74316002)(7736002)(305945005)(7696005)(229853002)(9686003)(6436002)(102836004)(6506007)(76176011)(26005)(186003)(4326008)(33656002)(11346002)(476003)(14454004)(97736004)(446003)(53936002)(6246003)(478600001)(71190400001)(71200400001)(86362001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2784;H:VI1PR0402MB2863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JJSJWMg2CvyN+7OlZoL6gIXgnYaoY61l9tgpuEX8Sdzez+IzP8Q8SCmQ82uEdSEpbps/8CNFRJSkJik/tZje7cdbUO1m91k7CdwhxHkMOLU3Cukj61SRJon66jO6AHyHW5GnZwI5eAIhnC5kUEGZvqxNZnCZxOJFAOVjFWK95G5HHBEjxbMAmf/dFhMFbvAvXFBU7kyHwZHJQTJgOKZltTlg4JnQsxvrg7vxKiBhoQdlOwd/up8CkNYBPeuwEHA2Li7UKO4+Mkb0vR9IawvKaKe5hSmUD15ishZfBhxifq8M+81og32LnTBcsg2VnrhiR0xHZWIWGl8WfAgYgE0NKokc56AG9h671o2rMdYtcNpry6Qd3LW3fjxOQFNOU2SLITSJY1fvxYSgwmg5j7WVyMvfFPJbdprV+BOmu89vJx0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e393c0-2030-4978-edb3-08d6bcb9aa70
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 07:04:53.2902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2784
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Joakim Zhang
> Sent: Tuesday, April 9, 2019 5:07 AM
> Hi Stefan,
>=20
> Thanks for your validation! Could you add your test tag if you can=20
> successfully validated?

Sure, no problem. Please note that I needed to replace "flexcan_read" and "=
flexcan_write" with "priv->read" and "priv->write" respectively, in PATCH V=
2 4/5.

>  [Joakim Zhang] We added can fd support in 4.9 kernel which let=20
> mailbox_read call alloc_can(fd)_skb in the past. Now the driver=20
> allocate skb before mailbox_read in rx_offload and also read the overflow=
 frames.
>               I add the "is_canfd" since I don't want to change the=20
> rx_offload framework too much. @mkl@pengutronix.de, could you give=20
> some advice, which solution is better?

This is more of a functionality issue. For example, candump from canutils 4=
.0.6 never shows CAN FD frames, but should still be able to show the CAN 2.=
0 ones regardless of whether "fd on" was supplied. I suggest the following =
separation:

can_rx_offload_offload_one:
	struct sk_buff *skb =3D NULL;
	...
	bool drop =3D unlikely(skb_queue_len(&offload->skb_queue) >
			     offload->skb_queue_len_max);

	if (offload->mailbox_read(offload, drop, &skb, &timestamp, n) && !skb)
		offload->dev->stats.rx_dropped++;

	if (skb) {
		struct can_rx_offload_cb *cb =3D can_rx_offload_get_cb(skb);

		cb->timestamp =3D timestamp;
	}

	return skb;

flexcan_mailbox_read:
	...
	if (!drop) {
		if (reg_ctrl & FLEXCAN_MB_CNT_EDL)
			*skb =3D alloc_canfd_skb(offload->dev, &cf);
		else
			*skb =3D alloc_can_skb(offload->dev,
					     (struct can_frame **)&cf);
	}
	if (*skb) {
		/* use cf */
		...
	}
	/* mark as read */

Although not visible in the FlexCAN case, the socket buffers would be also =
freed from inside mailbox_read if errors were encountered after allocation.

Regards,
Stefan
