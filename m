Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F666C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB2F21741
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cvhXE5fB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfDJCey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 22:34:54 -0400
Received: from mail-eopbgr80073.outbound.protection.outlook.com ([40.107.8.73]:29415
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726513AbfDJCey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 22:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pn3aMyXCY2iCymVAodVoCEGx0dwmc+0pw+y05bsRFwY=;
 b=cvhXE5fBiCZXoOuvZ05qdHH4QUq35QfV4TtENmqMiEVxaJ8GproBip8gAnzFoqAel0VQnhv+VJ+lEW+K2sxZDa1Z9y3ohUMNt96jz6QZsKm1Bearo/YvUTate3Z1bDN4Msc8sSQqXpGcKzt+qxA4a0WlK2Tl8R4xws1eTG3i1hc=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.159) by
 VI1PR04MB4285.eurprd04.prod.outlook.com (52.134.31.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Wed, 10 Apr 2019 02:34:50 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::940a:dc67:926:e5df]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::940a:dc67:926:e5df%5]) with mapi id 15.20.1771.016; Wed, 10 Apr 2019
 02:34:50 +0000
From:   Peng Ma <peng.ma@nxp.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Andy Tang <andy.tang@nxp.com>,
        Jianchao Wang <jianchao.wang@nxp.com>
Subject: RE: [EXT] Re: [v7 3/3] ahci: qoriq: add lx2160 platforms support
Thread-Topic: [EXT] Re: [v7 3/3] ahci: qoriq: add lx2160 platforms support
Thread-Index: AQHU2HbclXKnAjThkU+5mzIwr26m+6YyLTYQgABfEACAAQGBYIAAfzGAgADNudA=
Date:   Wed, 10 Apr 2019 02:34:50 +0000
Message-ID: <VI1PR04MB4431A5834D22040384C6B8D7ED2E0@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20190312015019.30628-1-peng.ma@nxp.com>
 <20190312015019.30628-3-peng.ma@nxp.com>
 <VI1PR04MB44310DDDF2D981F0BC0D7381ED2C0@VI1PR04MB4431.eurprd04.prod.outlook.com>
 <5bbd312c-6443-ea23-2b3e-97fd46a98a38@kernel.dk>
 <VI1PR04MB4431213C02A7DC614AB4E693ED2D0@VI1PR04MB4431.eurprd04.prod.outlook.com>
 <40cd2a5a-040c-9785-ee17-c5407a3872a7@kernel.dk>
In-Reply-To: <40cd2a5a-040c-9785-ee17-c5407a3872a7@kernel.dk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e971a9b6-c811-441a-8128-08d6bd5d1b44
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4285;
x-ms-traffictypediagnostic: VI1PR04MB4285:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB4285630E7B165A4593FBCBD5ED2E0@VI1PR04MB4285.eurprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(346002)(39860400002)(136003)(199004)(189003)(13464003)(7696005)(9686003)(256004)(2501003)(6116002)(186003)(33656002)(76176011)(71200400001)(102836004)(53936002)(7736002)(478600001)(71190400001)(25786009)(68736007)(3846002)(55016002)(446003)(44832011)(45080400002)(6436002)(66066001)(6506007)(74316002)(6306002)(11346002)(97736004)(476003)(486006)(6246003)(26005)(305945005)(5024004)(8676002)(14444005)(5660300002)(106356001)(229853002)(81166006)(81156014)(2906002)(93886005)(4326008)(105586002)(86362001)(52536014)(6636002)(54906003)(110136005)(316002)(99286004)(8936002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4285;H:VI1PR04MB4431.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FYFXODyuDzfGfOA3/8PCTgrvbeQf96Ncx2mon33sdMNQGzDPb1VRGp3b2B3W9ZR/pvAmfCmQ8RUXEYoYcr4gjZpFpw70URkyQ5PKGLWn1QpOFKKa2E+tV8cgKbLBtJoXVdOhgnYNYlvui/VLkTOrAbN2TsdceNto25Ou8nCQa80NyRsmesSnlfhW+kc8E8UMeGg25Es1nDr7Gq8QRyEdjXDM7SdC720B1GCGcRQw05InZD0uVsUWuMiZaogTWgJK63bF7tSOat5jnUIrpCTbr+aDoGT8s/wSUVUuPbxv9OcWL9hQXpZoNtpo/3UfHD4AtGVKXvH+7BNUwxg2rnpb2Rm/Ru/5BJnorjoW2fmFrpJn+XG5SPIVmzPaNBwaSHaNBSLejvemNAC0QXDq7LuckNrvRjiBcuRfTYzf4C/SXYU=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e971a9b6-c811-441a-8128-08d6bd5d1b44
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 02:34:50.5085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4285
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQXhib2UsDQoNClRoYW5rcyB2ZXJ5IG11Y2guDQoNCkJlc3QgUmVnYXJkcywNClBlbmcNCg0K
Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogSmVucyBBeGJvZSA8YXhib2VAa2Vy
bmVsLmRrPg0KPlNlbnQ6IDIwMTnE6jTUwjnI1SAyMjoxNw0KPlRvOiBQZW5nIE1hIDxwZW5nLm1h
QG54cC5jb20+OyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+bWFyay5ydXRsYW5kQGFybS5jb207IHNo
YXduZ3VvQGtlcm5lbC5vcmc7IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPg0KPkNjOiBsaW51
eC1pZGVAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj5saW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc7IEFuZHkgVGFuZw0KPjxhbmR5LnRhbmdAbnhwLmNvbT47IEppYW5jaGFvIFdhbmcgPGpp
YW5jaGFvLndhbmdAbnhwLmNvbT4NCj5TdWJqZWN0OiBSZTogW0VYVF0gUmU6IFt2NyAzLzNdIGFo
Y2k6IHFvcmlxOiBhZGQgbHgyMTYwIHBsYXRmb3JtcyBzdXBwb3J0DQo+DQo+V0FSTklORzogVGhp
cyBlbWFpbCB3YXMgY3JlYXRlZCBvdXRzaWRlIG9mIE5YUC4gRE8gTk9UIENMSUNLIGxpbmtzIG9y
DQo+YXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0
aGUgY29udGVudCBpcyBzYWZlLg0KPg0KPg0KPg0KPk9uIDQvOS8xOSAxMjo0NCBBTSwgUGVuZyBN
YSB3cm90ZToNCj4+IEhpIEF4Ym9lLA0KPj4NCj4+IFBhdGNoIGxpbms6DQo+Pg0KPj4NCj5odHRw
czovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUy
RiUyRnBhdGNod28NCj5yay5vemxhYnMub3JnJTJGcGF0Y2glMkYxMDU1MDI4JTJGJmFtcDtkYXRh
PTAyJTdDMDElN0NwZW5nLm1hJTQwDQo+bnhwLmNvbSU3Q2U3NmJlNTM5YzI0YTQ3MzNjZjNmMDhk
NmJjZjYxOGRlJTdDNjg2ZWExZDNiYzJiNGM2ZmE5Mg0KPmNkOTljNWMzMDE2MzUlN0MwJTdDMSU3
QzYzNjkwNDE2MjUwNTUwMTUwMCZhbXA7c2RhdGE9QW03UUVKMlkNCj5zcWtOTFhVdElNWFUlMkZz
NU10NFFoellZYTFGamJoV2FBWGl3JTNEJmFtcDtyZXNlcnZlZD0wDQo+Pg0KPj4NCj5odHRwczov
L2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUy
RnBhdGNod28NCj5yay5vemxhYnMub3JnJTJGcGF0Y2glMkYxMDU0MTg5JTJGJmFtcDtkYXRhPTAy
JTdDMDElN0NwZW5nLm1hJTQwDQo+bnhwLmNvbSU3Q2U3NmJlNTM5YzI0YTQ3MzNjZjNmMDhkNmJj
ZjYxOGRlJTdDNjg2ZWExZDNiYzJiNGM2ZmE5Mg0KPmNkOTljNWMzMDE2MzUlN0MwJTdDMSU3QzYz
NjkwNDE2MjUwNTUwMTUwMCZhbXA7c2RhdGE9aWtwTkM0TSUNCj4yQkRxMyUyRlBZc1hMSGJQRGNE
dTJLZmdJUlhzJTJCakREWFd0cDJqayUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPg0KPkFwcGxpZWQsIHRo
YW5rcy4NCj4NCj4tLQ0KPkplbnMgQXhib2UNCg0K
