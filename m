Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75A6C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 08:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8377C206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 08:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K1vTvzsv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbfJHIHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 04:07:33 -0400
Received: from mail-eopbgr80055.outbound.protection.outlook.com ([40.107.8.55]:62213
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730292AbfJHIHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 04:07:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ym/HaqlVM2BnXwCB8FSKS3syje/dgJdesWktGKYWwlY65WmqvvgNmbcQSPVLqy8kXeQH1kvI9xSk+8RpPM8LV3vMoqHO0KvLLOnGSn5e3fy+g/2fBqj/a16f3Q0nY/XyRjy3ipZiBw83HtKIoJMWnca+hqjW/tl3eTb263LF4nvF67/KEB+bolmrUFPZqSyjytVlICGx2SMi1QQ1TY1A1l5f3tdiLDET/g/5PsfVqW7LULq1W0CPpQN/A2nByYpFzqZmf4hkwBFP5kN5yoxZQ9SDmvRaREamhhLAB3M19r1UdliSPnMMe9MDJR1BxzwSGQFQiKn7weXUncfg/OyZfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXZQ31c9DC3tg8dN6BdUFskEqiCozs0VLXpNa3E9xYE=;
 b=DVml2uOQ6LXtOJfzhX8CkLrFTVyjTOilWb+6hHgurBjDp7dnXaxaLjbZ62uZB/bdK/PTF2MRM3A5IwspmexSYyKxbHU8+2Pt6GCHSskPTMpU8g1D6AtOnFEH9A72wAij7VoUofDQWq24Zfc+77Fl8zt3NGXDImDjFGs1mYbCewpgqmaND/06iYINw0UZaOkX35DMt63rieZcX9vYCPSFIMoBqFctTyLfOq0pqotRKPlV4maWxpis6kVz90Jn9byZPCbutSbGJXR/PiGBIY/nNoow961jeg4LpAjxnQpw0y/9LcNGHUn+wlfMKIDD7XbtKe6cULKxCnyukN1D9aASSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXZQ31c9DC3tg8dN6BdUFskEqiCozs0VLXpNa3E9xYE=;
 b=K1vTvzsvwVKdb7u4DJJKnUlcNmGjKmVFcHoigRKhY8NvelQ2eQTrmeIZuwY3E1Ax+Re8qxHWNgHYO1bw+d2OxnsjGBvS0tDMjQRxkyHRviGuPb0shyGAFXChr9WX8ruem2vgTI9dADcreYKIcvZtmc5alerbhPDIPInsh5c1uAA=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB4237.eurprd04.prod.outlook.com (52.134.31.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.23; Tue, 8 Oct 2019 08:07:28 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::1da:26dc:6373:4ab0]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::1da:26dc:6373:4ab0%3]) with mapi id 15.20.2327.026; Tue, 8 Oct 2019
 08:07:28 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Roger Quadros <rogerq@ti.com>
CC:     "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "pawell@cadence.com" <pawell@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "kurahul@cadence.com" <kurahul@cadence.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] usb: cdns3: gadget: Fix full-speed mode
Thread-Topic: [PATCH 2/2] usb: cdns3: gadget: Fix full-speed mode
Thread-Index: AQHVfQkMB4bF5on90UOj6I8o0SgZgadQZLOA
Date:   Tue, 8 Oct 2019 08:07:28 +0000
Message-ID: <20191008080711.GH5670@b29397-desktop>
References: <20191007121601.25996-1-rogerq@ti.com>
 <20191007121601.25996-3-rogerq@ti.com>
In-Reply-To: <20191007121601.25996-3-rogerq@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e73785e-d3ce-4bf5-59dd-08d74bc68fca
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR04MB4237:
x-microsoft-antispam-prvs: <VI1PR04MB42373D0B3C319EE595FFE1AD8B9A0@VI1PR04MB4237.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(189003)(199004)(81166006)(8936002)(6916009)(81156014)(3846002)(8676002)(6116002)(4326008)(71200400001)(71190400001)(2906002)(6246003)(66066001)(256004)(14454004)(6436002)(33656002)(6486002)(25786009)(478600001)(229853002)(99286004)(476003)(11346002)(446003)(486006)(33716001)(44832011)(53546011)(6506007)(54906003)(102836004)(9686003)(6512007)(76176011)(1076003)(186003)(316002)(26005)(86362001)(91956017)(76116006)(305945005)(7736002)(66476007)(66556008)(64756008)(66446008)(4744005)(5660300002)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4237;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kbUppF/vgMspGtiUnAdvp8IdblPfZp39mbsDpZdTgF4s3jjGdxr2Sbxjk6qi/qTkxmYuFGMmMxZRiOb9pfm1tThFKiGOG3MO9LvVcUmEjXsAYpIxzeOJQDMEby4EVDYvxTxnFFpP20l8XvsMx0/m9nl31JeAi6LxEF099xCfXp+EW5Yaqkpyq1pvvUECPekx2d1LWzWz4T/ydI8LXMdCBN4di939yEPTLatVzLmJtD72KFjffjk4amSY2ExDbDI8EJICiS6jpr5RJZy4yGYK+hLZEBt5DS8PzHmOrEMTzIVHKxJ7vC/6qpeSMv3HPxU0O2ebo9kM6k4bShRo4JUKS2FpyYzSqnzUw9Mt6BVq43vZ4J200b14FoVLZKTrMPhYipIEM5aKxb5GSQybmEFVrMJYd6xh7Lj0wZY7XXK+Iao=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <194E755C6E66544F85F493EFE630CF77@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e73785e-d3ce-4bf5-59dd-08d74bc68fca
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 08:07:28.3176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oka27NxcaXeWInw6H3Whrj63DNrqxoNFOq7IaVAD0J4Jvzp8mdPLPhA9loizYuoe+PtxMPDeQBJmaj26Ed0Flg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4237
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-07 15:16:01, Roger Quadros wrote:
> We need to disable USB3 PHY for full-speed mode else
> gadget mode is broken.
>=20
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  drivers/usb/cdns3/gadget.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
> index 228cdc4ab886..157536753b8c 100644
> --- a/drivers/usb/cdns3/gadget.c
> +++ b/drivers/usb/cdns3/gadget.c
> @@ -2571,6 +2571,7 @@ static int cdns3_gadget_start(struct cdns3 *cdns)
>  	switch (max_speed) {
>  	case USB_SPEED_FULL:
>  		writel(USB_CONF_SFORCE_FS, &priv_dev->regs->usb_conf);
> +		writel(USB_CONF_USB3DIS, &priv_dev->regs->usb_conf);
>  		break;
>  	case USB_SPEED_HIGH:
>  		writel(USB_CONF_USB3DIS, &priv_dev->regs->usb_conf);

Reviewed-by: Peter Chen <peter.chen@nxp.com>

--=20

Thanks,
Peter Chen=
