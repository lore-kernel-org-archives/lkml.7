Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA3AC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 08:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7872E21897
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 08:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UX008spD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbfH3IIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 04:08:02 -0400
Received: from mail-eopbgr80044.outbound.protection.outlook.com ([40.107.8.44]:24896
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726978AbfH3IIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 04:08:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+iwBA7DTDveOsjBTnEzXDZHZH8txQr+7/dTW4XmRdUpiqzg/jhUPW5LG8mEP4KYAjl06syky+qYpF8PwTsGHH5nk8HZmU+VHFEfq045BfCMbtEAqbYBK/ssfkzZveykbRLkTs4RKiQCndzusIDyKYTrJDhOtoG07HvCgRHD4chdUbKsd2KhwM1sQx/H9bR7HZg12/dizWUGyi5BGQEMJmapcgSSLOAIdUGkaNv+dpxiUyru6U715t2Y9U/ylb1mmfytaajFZagreh6yfS6SfiOD1d044zuGN23M1sQ3qZ89Uf6jNQL9JP92CyJIIIIHY7fEa1dpnRkGQ2uRzDhAWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIwXLysodLL3RNmu1O1KFSIu6PDF1pKJ1mg/GZ4oDDY=;
 b=YdZhosR/LNzb57jL0ySxH6XuSZ+TQ+z7VOtJlLsIsrBkSj3L1QUDq6AdQNt4bvp5x5Zoe2/PC4XZ4T3DaQ1mcUIJHQy9QV8gyPsTVvHP2eZXFfVedyVFuXrrw+9E4u7VDFzvPsUddzdcnmbRJOV+Vn35HL7CG/0YahHt47ajH/HG2wEqX0PAjwcEdgBLglPe8naRUa1s0hxWL+0QDFnxKgA6cJrcHS1Nh95vJZ4kMW/ByS7QY6Otbd3/+18JSrj5NhKk2UKJxqdI7cCZRaWejbOUtJC881cUmp5aAN+n5qHJDw8sfEMgifm4GOiyVS/IKAkH3W434qtC975azPOVAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIwXLysodLL3RNmu1O1KFSIu6PDF1pKJ1mg/GZ4oDDY=;
 b=UX008spDYcPFSbZ6nHHSXeMhgBBG5xkV3lB6GKUyQBETPBVv83VKOo+EVjlvMPqC1kXQrG3gvUFuGv7QCDnUF6Hc3C6ewWQkDlI/rOe0Usvx2p6W6JOJrcyR9MlXtjN3Z2AVQqM3zHGyRKzWdJtBkhpqdvdQbLRFhPoxbi/YrkM=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5585.eurprd04.prod.outlook.com (20.178.203.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.18; Fri, 30 Aug 2019 08:07:56 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4%4]) with mapi id 15.20.2178.023; Fri, 30 Aug 2019
 08:07:55 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v5 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
Thread-Topic: [PATCH v5 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
Thread-Index: AQHVXU0YJPArUxY1ok6XlIUgkri4VacTNWSAgAAFe+CAABGfAIAAAKjwgAAICwCAAAHRcA==
Date:   Fri, 30 Aug 2019 08:07:55 +0000
Message-ID: <AM0PR04MB448133D1F4C887A82C679CEB88BD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1567004515-3567-1-git-send-email-peng.fan@nxp.com>
 <1567004515-3567-2-git-send-email-peng.fan@nxp.com>
 <CABb+yY2tRjazjaogpM7irqgTD+PdwsfqCxk5hP-_czrET3V5xQ@mail.gmail.com>
 <AM0PR04MB4481785CABB44A8C71CFB8D788BD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CABb+yY2TREpO7+TFcGgsgQrkmMWwFAgtuJ4GnLPPQ+GEBuh07w@mail.gmail.com>
 <AM0PR04MB448161C632722DF10989008088BD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CABb+yY2SrMF8e1iLyLqb-rJyBx4ajA0hZ6D=LFtuMNtXYjgccA@mail.gmail.com>
In-Reply-To: <CABb+yY2SrMF8e1iLyLqb-rJyBx4ajA0hZ6D=LFtuMNtXYjgccA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 649f8b80-c565-4a99-4593-08d72d212a17
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5585;
x-ms-traffictypediagnostic: AM0PR04MB5585:|AM0PR04MB5585:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5585612F629D492464F593DE88BD0@AM0PR04MB5585.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0145758B1D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(199004)(189003)(9686003)(55016002)(99286004)(53936002)(66946007)(6436002)(53546011)(6506007)(25786009)(54906003)(52536014)(5660300002)(64756008)(66446008)(76116006)(66556008)(66476007)(11346002)(66066001)(486006)(476003)(6246003)(44832011)(7696005)(256004)(478600001)(71190400001)(71200400001)(76176011)(2906002)(6116002)(86362001)(446003)(15650500001)(33656002)(3846002)(8936002)(316002)(4326008)(1411001)(186003)(8676002)(14454004)(229853002)(81156014)(102836004)(26005)(81166006)(7736002)(305945005)(74316002)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5585;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +XxdmS0lEmVdwsGjqy58QpJBq9ZrPe2tWU/L0jKwoRCPQKNiXnPpLovgKINGwHPHmql8RCpcPNkPg+IxFhyqvnL0s47DZcaHF6lyFfUofy3FrdffdGSomm3o6zAgKWGHQYxVr9FTMxgnY3aMGGlKlDPKKXIj2v7GWnxikyLEmCJB/lFC0qrtBTBndYIEfhwwU9Cop22Zto0sNtbcOTZexDQtzKqcC9kfx5StwrhuL6jAePb+4t/pN8Bh/3eqzLNYUk3adJ2daF/nSCOe4QmaTf5jyPu9fUll7zeiVjm9efeldiE5igjXVqz7/UiPtELSEQ6vOdZx8iPG/GHP3pLfzJtwyIPRvYEe+TvzEG18Cfa9JiPTkYlgteN9PJu7zho/pC+PF/XMVClxEQxc4xe4iaR2kHNPzxJkvDrcBf22kZY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 649f8b80-c565-4a99-4593-08d72d212a17
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2019 08:07:55.8544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2CuvJf6wW5bFVz0omVGva47sxdXLKSASOBmWxLdnZYMA/G7YGBr2QrDwXHBJAsep8WGX4iDVaOsbgXEGEBclXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5585
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDEvMl0gZHQtYmluZGluZ3M6IG1haWxib3g6IGFkZCBi
aW5kaW5nIGRvYyBmb3IgdGhlIEFSTQ0KPiBTTUMvSFZDIG1haWxib3gNCj4gDQo+IE9uIEZyaSwg
QXVnIDMwLCAyMDE5IGF0IDI6MzcgQU0gUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+IHdyb3Rl
Og0KPiA+DQo+ID4gSGkgSmFzc2ksDQo+ID4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUg
MS8yXSBkdC1iaW5kaW5nczogbWFpbGJveDogYWRkIGJpbmRpbmcgZG9jDQo+ID4gPiBmb3IgdGhl
IEFSTSBTTUMvSFZDIG1haWxib3gNCj4gPiA+DQo+ID4gPiBPbiBGcmksIEF1ZyAzMCwgMjAxOSBh
dCAxOjI4IEFNIFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPiB3cm90ZToNCj4gPiA+DQo+ID4g
PiA+ID4gPiArZXhhbXBsZXM6DQo+ID4gPiA+ID4gPiArICAtIHwNCj4gPiA+ID4gPiA+ICsgICAg
c3JhbUA5MTAwMDAgew0KPiA+ID4gPiA+ID4gKyAgICAgIGNvbXBhdGlibGUgPSAibW1pby1zcmFt
IjsNCj4gPiA+ID4gPiA+ICsgICAgICByZWcgPSA8MHgwIDB4OTNmMDAwIDB4MCAweDEwMDA+Ow0K
PiA+ID4gPiA+ID4gKyAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ID4gPiA+ID4gKyAg
ICAgICNzaXplLWNlbGxzID0gPDE+Ow0KPiA+ID4gPiA+ID4gKyAgICAgIHJhbmdlcyA9IDwwIDB4
MCAweDkzZjAwMCAweDEwMDA+Ow0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gKyAgICAgIGNw
dV9zY3BfbHByaTogc2NwLXNobWVtQDAgew0KPiA+ID4gPiA+ID4gKyAgICAgICAgY29tcGF0aWJs
ZSA9ICJhcm0sc2NtaS1zaG1lbSI7DQo+ID4gPiA+ID4gPiArICAgICAgICByZWcgPSA8MHgwIDB4
MjAwPjsNCj4gPiA+ID4gPiA+ICsgICAgICB9Ow0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4g
KyAgICAgIGNwdV9zY3BfaHByaTogc2NwLXNobWVtQDIwMCB7DQo+ID4gPiA+ID4gPiArICAgICAg
ICBjb21wYXRpYmxlID0gImFybSxzY21pLXNobWVtIjsNCj4gPiA+ID4gPiA+ICsgICAgICAgIHJl
ZyA9IDwweDIwMCAweDIwMD47DQo+ID4gPiA+ID4gPiArICAgICAgfTsNCj4gPiA+ID4gPiA+ICsg
ICAgfTsNCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICsgICAgZmlybXdhcmUgew0KPiA+ID4g
PiA+ID4gKyAgICAgIHNtY19tYm94OiBtYWlsYm94IHsNCj4gPiA+ID4gPiA+ICsgICAgICAgICNt
Ym94LWNlbGxzID0gPDE+Ow0KPiA+ID4gPiA+ID4gKyAgICAgICAgY29tcGF0aWJsZSA9ICJhcm0s
c21jLW1ib3giOw0KPiA+ID4gPiA+ID4gKyAgICAgICAgbWV0aG9kID0gInNtYyI7DQo+ID4gPiA+
ID4gPiArICAgICAgICBhcm0sbnVtLWNoYW5zID0gPDB4Mj47DQo+ID4gPiA+ID4gPiArICAgICAg
ICB0cmFuc3BvcnRzID0gIm1lbSI7DQo+ID4gPiA+ID4gPiArICAgICAgICAvKiBPcHRpb25hbCAq
Lw0KPiA+ID4gPiA+ID4gKyAgICAgICAgYXJtLGZ1bmMtaWRzID0gPDB4YzIwMDAwZmU+LCA8MHhj
MjAwMDBmZj47DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+IFNNQy9IVkMgaXMgc3luY2hyb25vdXNs
eShibG9jaykgcnVubmluZyBpbiAic2VjdXJlIG1vZGUiLCBpLmUsDQo+ID4gPiA+ID4gdGhlcmUg
Y2FuIG9ubHkgYmUgb25lIGluc3RhbmNlIHJ1bm5pbmcgcGxhdGZvcm0gd2lkZS4gUmlnaHQ/DQo+
ID4gPiA+DQo+ID4gPiA+IEkgdGhpbmsgdGhlcmUgY291bGQgYmUgY2hhbm5lbCBmb3IgVEVFLCBh
bmQgY2hhbm5lbCBmb3IgTGludXguDQo+ID4gPiA+IEZvciB2aXJ0dWFsaXphdGlvbiBjYXNlLCB0
aGVyZSBjb3VsZCBiZSBkZWRpY2F0ZWQgY2hhbm5lbCBmb3IgZWFjaCBWTS4NCj4gPiA+ID4NCj4g
PiA+IEkgYW0gdGFsa2luZyBmcm9tIExpbnV4IHBvdi4gRnVuY3Rpb25zIDB4ZmUgYW5kIDB4ZmYg
YWJvdmUsIGNhbid0DQo+ID4gPiBib3RoIGJlIGFjdGl2ZSBhdCB0aGUgc2FtZSB0aW1lLCByaWdo
dD8NCj4gPg0KPiA+IElmIEkgZ2V0IHlvdXIgcG9pbnQgY29ycmVjdGx5LA0KPiA+IE9uIFVQLCBi
b3RoIGNvdWxkIG5vdCBiZSBhY3RpdmUuIE9uIFNNUCwgdHgvcnggY291bGQgYmUgYm90aCBhY3Rp
dmUsDQo+ID4gYW55d2F5IHRoaXMgZGVwZW5kcyBvbiBzZWN1cmUgZmlybXdhcmUgYW5kIExpbnV4
IGZpcm13YXJlIGRlc2lnbi4NCj4gPg0KPiA+IERvIHlvdSBoYXZlIGFueSBzdWdnZXN0aW9ucyBh
Ym91dCBhcm0sZnVuYy1pZHMgaGVyZT8NCj4gPg0KPiBJIHdhcyB0aGlua2luZyBpZiB0aGlzIGlz
IGp1c3QgYW4gaW5zdHJ1Y3Rpb24sIHdoeSBjYW4ndCBlYWNoIGNoYW5uZWwgYmUNCj4gcmVwcmVz
ZW50ZWQgYXMgYSBjb250cm9sbGVyLCBpLmUsIGhhdmUgZXhhY3RseSBvbmUgZnVuYy1pZCBwZXIg
Y29udHJvbGxlciBub2RlLg0KPiBEZWZpbmUgYXMgbWFueSBjb250cm9sbGVycyBhcyB5b3UgbmVl
ZCBjaGFubmVscyA/DQoNCkkgYW0gb2ssIHRoaXMgY291bGQgbWFrZSBkcml2ZXIgY29kZSBzaW1w
bGVyLiBTb21ldGhpbmcgYXMgYmVsb3c/DQoNCiAgICBzbWNfdHhfbWJveDogdHhfbWJveCB7DQog
ICAgICAjbWJveC1jZWxscyA9IDwwPjsNCiAgICAgIGNvbXBhdGlibGUgPSAiYXJtLHNtYy1tYm94
IjsNCiAgICAgIG1ldGhvZCA9ICJzbWMiOw0KICAgICAgdHJhbnNwb3J0cyA9ICJtZW0iOw0KICAg
ICAgYXJtLGZ1bmMtaWQgPSA8MHhjMjAwMDBmZT47DQogICAgfTsNCg0KICAgIHNtY19yeF9tYm94
OiByeF9tYm94IHsNCiAgICAgICNtYm94LWNlbGxzID0gPDA+Ow0KICAgICAgY29tcGF0aWJsZSA9
ICJhcm0sc21jLW1ib3giOw0KICAgICAgbWV0aG9kID0gInNtYyI7DQogICAgICB0cmFuc3BvcnRz
ID0gIm1lbSI7DQogICAgICBhcm0sZnVuYy1pZCA9IDwweGMyMDAwMGZmPjsNCiAgICB9Ow0KDQog
ICAgZmlybXdhcmUgew0KICAgICAgc2NtaSB7DQogICAgICAgIGNvbXBhdGlibGUgPSAiYXJtLHNj
bWkiOw0KICAgICAgICBtYm94ZXMgPSA8JnNtY190eF9tYm94PiwgPCZzbWNfcnhfbWJveCAxPjsN
CiAgICAgICAgbWJveC1uYW1lcyA9ICJ0eCIsICJyeCI7DQogICAgICAgIHNobWVtID0gPCZjcHVf
c2NwX2xwcmk+LCA8JmNwdV9zY3BfaHByaT47DQogICAgICB9Ow0KICAgIH07DQoNClRoYW5rcywN
ClBlbmcuDQoNCj4gDQo+IC1qDQo=
