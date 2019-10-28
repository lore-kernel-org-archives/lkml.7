Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FACCA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0A721850
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rpikaJfo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387910AbfJ1JTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 05:19:25 -0400
Received: from mail-eopbgr80077.outbound.protection.outlook.com ([40.107.8.77]:20670
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727664AbfJ1JTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 05:19:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pk3FAYAg5kGr5Gs8ZT4qSg3DD25ZO4mcaiFyiKOKOrEsr0yOSTJ1nXIo3Eznzvwel7Cqg5rMQ0j9NB0Z3opUGcrA0hQi9Dn17Pzg1XAtXUiLR3fChmBLjej6q543GbVW0s4J3M2Rsr5M09SGD9fKOoXDDweSVBaCDYsDHjT5m4+mqx9170EyBMAlMZarBq+TL3RiE/iFyZKE1G06w8SbEVmPm563oT+pMi6M+OytCgpVzdIBannq+P1YXj+GAgUic+wepiercQvdOwPWaSMngPRk0EeC99sw19VBwqOSothPcI3Kdk7h//767wgnucEJNJwVTPO2sCJn4mjnWcQv0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poljYZWImd/UoV9znr9CL8qrk3e49zRSwLQN4rNYNDU=;
 b=oOd1ZPnfJef7MyO3NbzHDfU2zmIn/Sqlg3iyvJn0Sddukczu9o5jfvmg44xwUyqYyjC/tuxG77cLJgjJX3tISGgOieXql91KjyrlKkS5vRCvvD1IpNoE6MvFckLLFhPBlArN+VvUs46Ytf+Sot9PakGzXpljlPzZGAGROpO4c5p2k0gg7g4LrJgcjUoKFQxnGE3AZmBb9MrmCu/APQf9TOI9HWHC6a73C7J73olrKx4oay1e7tY27K07MQBlXKN/FMgSOMz76LM8iNrntHJqVP1ynARHddBHVGyZA51Vdz6R/70PzssezcR3Ube9Q/guS13NK+xq+z+O3v6mAvIkwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poljYZWImd/UoV9znr9CL8qrk3e49zRSwLQN4rNYNDU=;
 b=rpikaJfoOVEFXoULzUnoF+g4dgk0FnSExpFwQ5qwewC65Ti9+gB0mWRvmanAra5hnTV2/retq+/3ZmQtsKgLnkx7q+FAHwZ6wkP2J2bB+g0OJZA5C/qE6qRNMC2wpOiHtuZhsg+tBzdkWIZ6XgoYnGuS+ooccpHysXMc3Mw/V6s=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3915.eurprd04.prod.outlook.com (52.134.71.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Mon, 28 Oct 2019 09:19:20 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d469:ad51:2bec:19f0]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d469:ad51:2bec:19f0%6]) with mapi id 15.20.2387.025; Mon, 28 Oct 2019
 09:19:20 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 0/9] Add SoC serial number support for i.MX6/7 SoCs
Thread-Topic: [PATCH 0/9] Add SoC serial number support for i.MX6/7 SoCs
Thread-Index: AQHVjT4KbRIaf/2970uItyw0KUGGP6dvxB8AgAAC0bA=
Date:   Mon, 28 Oct 2019 09:19:19 +0000
Message-ID: <DB3PR0402MB3916A92B8A20D4322423D995F5660@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1572232370-31580-1-git-send-email-Anson.Huang@nxp.com>
 <20191028090846.GA16985@dragon>
In-Reply-To: <20191028090846.GA16985@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9025ac87-b24d-44a6-c11c-08d75b87ea17
x-ms-traffictypediagnostic: DB3PR0402MB3915:|DB3PR0402MB3915:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB391523D74D7C7D48D827EF31F5660@DB3PR0402MB3915.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(199004)(189003)(40224003)(64756008)(25786009)(76116006)(54906003)(66476007)(5660300002)(66556008)(66446008)(6246003)(316002)(7736002)(305945005)(66066001)(14454004)(11346002)(55016002)(256004)(446003)(4326008)(44832011)(9686003)(476003)(478600001)(52536014)(66946007)(2906002)(33656002)(3846002)(6916009)(71190400001)(71200400001)(6116002)(8676002)(86362001)(76176011)(486006)(229853002)(186003)(7696005)(102836004)(74316002)(99286004)(26005)(81166006)(81156014)(8936002)(6436002)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3915;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4FdwISIpPAbrneGlM159q4trkQVn7RJIQ8qHD10HGH3FTfoKXtk5MAMori0hxazj6sSFi8iyPR0o2fTbvlZJCWiI4PYLxidfLOxfevZ7NZp7CWBPAoCRXHtXyQm/eKMO2RydXnBLyhDQZxLD6O+q8ezvtd1RYa87P+iA7rreReiJKlg0EfKW/zsj4TkCOGWgyVJYDu8DQm+HhuPaWwNeow7by6WXbJ0+cgB3FeuAUgQLc4AXkuXHd1I2HJScDQ7REGXlA0r1z4kLAYd/hzS+BSQzyBrjDDqYRg2mXnwyt+pV8eyO9m2ufEnSBQsN1R5nhJB7oE/tmvvzEBNtTtnZkRkEkwOSRDxc6fDlYcpXkMeFoshgRk6dv6pkZiefyFR9CFjcfB4wTtbg0J9vv4s3cDQCldPbbpLRKbZqc46iouGIxwosjOWFxDeTpJRmSL+X
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9025ac87-b24d-44a6-c11c-08d75b87ea17
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 09:19:20.0423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ynMNG+sEp8eCQEoxfq9wpKarPGMLZMKNnKXvGMxl349JeyvRqkDXpeEryqHq6i8kViITVRLDVn1yqxIUMqy9zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3915
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNoYXduDQoNCj4gT24gTW9uLCBPY3QgMjgsIDIwMTkgYXQgMTE6MTI6NDFBTSArMDgwMCwg
QW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gaS5NWDYvNyBTb0NzIGhhdmUgNjQtYml0IHVuaXF1ZSBJ
RCBzdG9yZWQgaW4gT0NPVFAgYmFuayAwLCB3b3JkIDEvMiwNCj4gPiByZWFkIHRoZW0gb3V0IGFz
IFNvQyBzZXJpYWwgbnVtYmVyIHdoaWNoIGNhbiBiZSB1c2VkIGZyb20gdXNlcnNwYWNlOg0KPiA+
DQo+ID4gcm9vdEBpbXg3ZHNhYnJlc2Q6fiMgY2F0IC9zeXMvZGV2aWNlcy9zb2MwL3NlcmlhbF9u
dW1iZXINCj4gPiAwMDAwMDI4RkY2MThCOTUzDQo+ID4NCj4gPiBBZGQgc3VwcG9ydCBmb3IgaS5N
WDZRLzZETC82U0wvNlNYLzZTTEwvNlVMLzZVTEwvNlVMWi83RCwgYXMgdGhleQ0KPiBoYXZlDQo+
ID4gc2FtZSB1bmlxdWUgSUQgbGF5b3V0IGluIE9DT1RQLg0KPiA+DQo+ID4gQW5zb24gSHVhbmcg
KDkpOg0KPiA+ICAgQVJNOiBpbXg6IEFkZCBzZXJpYWwgbnVtYmVyIHN1cHBvcnQgZm9yIGkuTVg2
UQ0KPiA+ICAgQVJNOiBpbXg6IEFkZCBzZXJpYWwgbnVtYmVyIHN1cHBvcnQgZm9yIGkuTVg2REwN
Cj4gPiAgIEFSTTogaW14OiBBZGQgc2VyaWFsIG51bWJlciBzdXBwb3J0IGZvciBpLk1YNlNMTA0K
PiA+ICAgQVJNOiBpbXg6IEFkZCBzZXJpYWwgbnVtYmVyIHN1cHBvcnQgZm9yIGkuTVg2VUxMDQo+
ID4gICBBUk06IGlteDogQWRkIHNlcmlhbCBudW1iZXIgc3VwcG9ydCBmb3IgaS5NWDZVTA0KPiA+
ICAgQVJNOiBpbXg6IEFkZCBzZXJpYWwgbnVtYmVyIHN1cHBvcnQgZm9yIGkuTVg2VUxaDQo+ID4g
ICBBUk06IGlteDogQWRkIHNlcmlhbCBudW1iZXIgc3VwcG9ydCBmb3IgaS5NWDZTTA0KPiA+ICAg
QVJNOiBpbXg6IEFkZCBzZXJpYWwgbnVtYmVyIHN1cHBvcnQgZm9yIGkuTVg2U1gNCj4gPiAgIEFS
TTogaW14OiBBZGQgc2VyaWFsIG51bWJlciBzdXBwb3J0IGZvciBpLk1YN0QNCj4gDQo+IEZvciB0
aGlzIHBhcnRpY3VsYXIgY2FzZSwgSSB0aGluayBvbmUgc2luZ2xlIHBhdGNoIGlzIGV2ZW4gYmV0
dGVyIHRoYW4gYSBzZXJpZXMuDQo+IFNvIHBsZWFzZSBzcXVhc2ggdGhlbS4NCg0KRG9uZSBpbiBW
Mi4NCg0KVGhhbmtzLA0KQW5zb24NCg0KDQo=
