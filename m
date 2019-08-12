Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302B9C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 01:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F5D206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 01:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lyklmQfx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfHLBzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 21:55:40 -0400
Received: from mail-eopbgr150070.outbound.protection.outlook.com ([40.107.15.70]:31713
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726296AbfHLBzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 21:55:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDZ3qHInw7k8ZzPNBuItmJC3KorO8XAv8+iOHv7dcHOzASlEisX0IvJHE4NoEV6AiHW5iWkq0iaDxqoJBo00hLz/oE2fg/oMGab8XvcUNtmH8OO3Iy5AJ34ecc8P0WTU0IBU1nFuzgpl+MJEIAwwT/Mjc8ObaCDpxqJqEi2azQHy8h2l6fE/aiOpEYjrvZcF3YYM31JU8hEnnFwsFZ96HONu5zktxtgEGh5tMkt1Utm9ozpbetI2ig9NurQQVbrgmMW+3v63JqqTmObVvF1k/pdjleFaW85ap+4z4du1/bEBTXS6jEv10Bdtz/4TP8H7BXLGCkgLl0yBiXh059UdGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsUdGK8rnasLcuWkkQe0cbiFpQhK3QJw4AwM/CppBoE=;
 b=MlUoDnjo40Ul2WmCNXmsHTtl5fG9STd91RxJCQpKX0CqwVpNh8CMP30jNnunB5ESIYiPRmVXgkv0hwU3uwRo4jb/ommxYMUld2CrEz7l18BGGitJkLOYGmvGyTUEr+rM8N+rad32yG9Tn9TtNgbl+7gIl+BgCPmz8hYruUVBh9cyu53QQlWgnBEXsftbBtjej5U5+sj4nCv11Ubq0x4wVXmcpekBxdDldzjBLX080mVJ0quLl7Tt7uqtY03kVk3UnSQrDYdbJKnGS0eRV345gdO9P5Wrk1oBYoq4Bayd9CfoBvRBiUEsjNUfKYWXrq/tm7no5wXroNvkeKG17AURKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsUdGK8rnasLcuWkkQe0cbiFpQhK3QJw4AwM/CppBoE=;
 b=lyklmQfx5pUUj251ATMy7mQbLOl086QNNgHzbWdnWs4WPKDaSMs/dzyEPOjvm9pnH0ZsJqCaqwahLFzmiDTus9awuMLte1Hnem+0l68zynPDm81GSMo3IC4LaU/Rx08fOITa3q6D2JiCawZPIx+pU10KJMOe7PzpJQcM8pl0lpU=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB4525.eurprd04.prod.outlook.com (20.177.54.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Mon, 12 Aug 2019 01:55:35 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::81ec:c8ec:54d9:5dc5]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::81ec:c8ec:54d9:5dc5%2]) with mapi id 15.20.2136.026; Mon, 12 Aug 2019
 01:55:35 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v9 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Topic: [PATCH v9 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Index: AQHVMyCHrosRTgN4B0yGGWLWy7uno6bAUmQAgAtATICAJB6EgIAFX+iAgAHnPhA=
Date:   Mon, 12 Aug 2019 01:55:35 +0000
Message-ID: <VI1PR04MB53279117788B7D7CC3080B398BD30@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <1562324238-16655-1-git-send-email-pawell@cadence.com>
 <1562324238-16655-6-git-send-email-pawell@cadence.com>
 <877e8tm25r.fsf@linux.intel.com>
 <BYAPR07MB4709152CB29B6B027ABEB688DDCF0@BYAPR07MB4709.namprd07.prod.outlook.com>
 <8736idnu0q.fsf@gmail.com>
 <BYAPR07MB4709B0A4FADFB76183D651DCDDD10@BYAPR07MB4709.namprd07.prod.outlook.com>
In-Reply-To: <BYAPR07MB4709B0A4FADFB76183D651DCDDD10@BYAPR07MB4709.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77293175-2c19-4e26-f5ff-08d71ec82aa4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB4525;
x-ms-traffictypediagnostic: VI1PR04MB4525:
x-microsoft-antispam-prvs: <VI1PR04MB4525EF1655F5CC33E3361C588BD30@VI1PR04MB4525.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(51444003)(189003)(199004)(7696005)(66946007)(4326008)(14454004)(81156014)(44832011)(6246003)(7416002)(478600001)(6506007)(102836004)(9686003)(66446008)(55016002)(76116006)(86362001)(99286004)(229853002)(476003)(486006)(53936002)(2501003)(6436002)(256004)(11346002)(14444005)(25786009)(446003)(81166006)(8936002)(66476007)(66556008)(64756008)(76176011)(110136005)(186003)(5660300002)(26005)(6116002)(316002)(3846002)(52536014)(66066001)(8676002)(54906003)(305945005)(74316002)(2906002)(71200400001)(71190400001)(7736002)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4525;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bfZrFyN21pbhLcia0H66HJ2gpzuLsVUaiGxoq2IAqtyyOHNEDzIg+xnQvJTL+PCzqN5fBH1PLBoKcDTv/57WiDzFgbm64POrekeNAwqweuk2TxsT4nHilE5hNOX6WEyZUXGBDs4UxS6CZxYR/8nslY6sgVp98PS5v44kNCJIY9wjcN0ZJG/wLFfi/ieiXeXztowTAjtqh/gGltApBG5pY6tszIP06xNYWDAR631STovP8JD3No71kFBq++kgS5c0A1FrdO/zabZE3Te/jUyQLS3UsGZ1ZIbeqyH8QWxbZ8LcCK5N9yyQiPj/dx8itI9aM4I5empt49pSEwb4z6NkF4HADOo7moLbc4vVZKDLCFJcYDBbMdic6CrvOdrBQl0NS0c6KLRKYFo61QFYN8XDDoPbgClZ1GWn5+ZnEsb6Vg8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77293175-2c19-4e26-f5ff-08d71ec82aa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 01:55:35.2481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peter.chen@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4525
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 =20
>=20
> Yes, driver frees not used buffers here.
> I think that it's the safest place for this purpose.
>=20
> >
> >>>> +				dma_free_coherent(priv_dev->sysdev, buf-
> >size,
> >>>> +						  buf->buf,
> >>>> +						  buf->dma);
> >>>> +				spin_lock_irqsave(&priv_dev->lock, flags);
> >>>> +
> >>>> +				kfree(buf);
> >>>
> >>>why do you even need this "garbage collector"?
> >>
> >> I need to free not used memory. The once allocated buffer will be
> >> associated with request, but if request.length will be increased in
> >> usb_request then driver will must allocate the  bigger buffer. As I
> >> remember I couldn't call dma_free_coherent in interrupt context so I
> >> had to move it to thread handled. This flag was used to avoid going th=
rough
> whole  aligned_buf_list  every time.
> >> In most cases this part will never called int this place
> >
> >Did you try, btw, setting the quirk flag which tells gadget drivers to
> >always allocate buffers aligned to MaxPacketSize? Wouldn't that be enoug=
h?
>=20
> If found only  quirk_ep_out_aligned_size flag, but it align only buffer s=
ize.
>=20
> DMA used by this controller must have buffer address aligned to 8.
> I think that on most architecture kmalloc should guarantee such aligned.
> The problem was detected on NXP testing board.
> On my board all buffer address are alignment at least to 8.
>=20
=20
This un-aligned request buffer address for 8 occurs for Ethernet Gadget (eg=
, NCM),
it allocates socket buffer with NET_IP_ALIGN, so the last byte of buffer ad=
dress
is always 2. Although this can be workaround by setting quirk_avoids_skb_re=
serve,
but we are not sure if all gadget request buffers can be 8 or Max Packet Si=
ze aligned.

Peter
