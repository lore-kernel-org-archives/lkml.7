Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3525C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E012341C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iiKChERG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfH3HiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 03:38:25 -0400
Received: from mail-eopbgr00069.outbound.protection.outlook.com ([40.107.0.69]:16544
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726716AbfH3HiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 03:38:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4Skz3cbz6ZUs+oux4OCw9gKXLOhG3DXFiRtjKo8p1JjpMs5IPqQv39CQuqJnT/lnJ3hCMiTlLSLmqqURbAtr+7v0L4eKUxCmvPthxINZPAKFD4jBaqo3Nq5DdAT3er6oMRzTOykltKslwQki/5HAkQCjAMo6n99x3xURF6dku40eAdbiesD2kqieHqAVseKAwpkbvopgOSItyY4BXV/EyBNReqaF7WzoqWi7znMQ01BV1rf53AFnBoJT6Cn38rGSqpCEGxXtIC5THCGnQjatPyF/Mb98G2YdqJVpFxELrznAxOwImDI6wNMI30szBzvTHV7jJ92DYLRifs94uGfag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xk8sTKRlMx17lDvxqSpvfzPJIaOM8MVPciDQWfmcOCM=;
 b=mH/FeQProrLcawlnM3kNY9UjoqrCHMV7+ACItCBLS6yA5Ubv8Z0umbn2/301yeFXZorqvaguvuQhi65NScKnYPmq8OHnrs373L38Bm1TG+Rcs8AwEyUk43gThQ6XAcLPRevMroU2lL7uXVmTWbRa2/ts5WF5ANSD/zKKWsuilaE6D76e0LPNYg02Qf+ShRiQ7Y/dB0OlqbXwlppIGVPZl0YoOi2h6kKCWhS6HobdX3UysrKxn6rC5m/A5ljQknYuklxPeHDn61RNtBkfG/LsQLmuK2ZUB0ZlHlUFiq0GT3/o33XDoao1XI2n04Uuf8fCjcB21/rf10qYIP071KHzpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xk8sTKRlMx17lDvxqSpvfzPJIaOM8MVPciDQWfmcOCM=;
 b=iiKChERG1CKN3FFEqzLMfSP7Z4CcwKV6mmnGBMMWiZejKrqthprNU97hO6pM2qJfZHYkAdvOnkE0IiHkLRmudvrG3B3mptXHPoxAbFtzvfo4bpLO9oq5kXWYcp6PuOfc0ghLxj11NIQ63OQQ0Z+3cuR2uR1dXBqBWl4edkO7IeU=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5284.eurprd04.prod.outlook.com (20.177.41.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Fri, 30 Aug 2019 07:37:42 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4%4]) with mapi id 15.20.2178.023; Fri, 30 Aug 2019
 07:37:42 +0000
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
Thread-Index: AQHVXU0YJPArUxY1ok6XlIUgkri4VacTNWSAgAAFe+CAABGfAIAAAKjw
Date:   Fri, 30 Aug 2019 07:37:41 +0000
Message-ID: <AM0PR04MB448161C632722DF10989008088BD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1567004515-3567-1-git-send-email-peng.fan@nxp.com>
 <1567004515-3567-2-git-send-email-peng.fan@nxp.com>
 <CABb+yY2tRjazjaogpM7irqgTD+PdwsfqCxk5hP-_czrET3V5xQ@mail.gmail.com>
 <AM0PR04MB4481785CABB44A8C71CFB8D788BD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CABb+yY2TREpO7+TFcGgsgQrkmMWwFAgtuJ4GnLPPQ+GEBuh07w@mail.gmail.com>
In-Reply-To: <CABb+yY2TREpO7+TFcGgsgQrkmMWwFAgtuJ4GnLPPQ+GEBuh07w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43a510cc-e525-4985-4d7c-08d72d1cf0e9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5284;
x-ms-traffictypediagnostic: AM0PR04MB5284:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5284627F824D0A209FCADD4388BD0@AM0PR04MB5284.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0145758B1D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(199004)(189003)(256004)(66066001)(66446008)(8936002)(54906003)(478600001)(9686003)(81166006)(316002)(6246003)(2906002)(15650500001)(76176011)(229853002)(66946007)(7696005)(86362001)(64756008)(71200400001)(71190400001)(76116006)(6436002)(44832011)(53546011)(446003)(11346002)(55016002)(7736002)(305945005)(74316002)(476003)(6916009)(66556008)(6116002)(5660300002)(66476007)(3846002)(53936002)(52536014)(81156014)(1411001)(186003)(8676002)(102836004)(99286004)(25786009)(4326008)(33656002)(486006)(26005)(14454004)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5284;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jUfGUkLgCRYDhTF1XR20fKqJ/IhjOFJmsYqX9Yie1RGT7YLfopWcJ9ha1KN5CUie+vXQWAwgnYjJe4WUi78I6dOAbZn+fgxeoLjCHHzQ88S+U8ue7fh1SdutkRrlMeU6BmIL5hEYDcs4YYluzfXYFIO+2gxKXr0dl5VaCn0ozgQ8NRlXRxJ5Dav723mxOIkb36/PZJiAUS1vCAnfE9OMQgAm5QFVsfzNQM39YmtDeRWcgORw046oWW+PxCA7CEekTsHQF5xMyI7L3s34GVtXykzN2vy2/sDbsY9JXMUfdedQZW7h1RHw+4h3WkffDzxWE9Er536Kx/ShzJpIXyqL38EpngHd81VJBKkuYzC+mO6HCr7MSOX43SrvbYF9SOxtlg/dOt6j7AKNF29eEbVUbHviDYQbhO7F6PMVc6DORcw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a510cc-e525-4985-4d7c-08d72d1cf0e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2019 07:37:41.9160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GUn3DUvfv4xDScEwcxK3tPnSgPhl2QcIhzwWITzWgq4uqUJjrBetUYpxICqpa7KVXHejVHBcprnAQw0wDg2AIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5284
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFzc2ksDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAxLzJdIGR0LWJpbmRpbmdzOiBt
YWlsYm94OiBhZGQgYmluZGluZyBkb2MgZm9yIHRoZSBBUk0NCj4gU01DL0hWQyBtYWlsYm94DQo+
IA0KPiBPbiBGcmksIEF1ZyAzMCwgMjAxOSBhdCAxOjI4IEFNIFBlbmcgRmFuIDxwZW5nLmZhbkBu
eHAuY29tPiB3cm90ZToNCj4gDQo+ID4gPiA+ICtleGFtcGxlczoNCj4gPiA+ID4gKyAgLSB8DQo+
ID4gPiA+ICsgICAgc3JhbUA5MTAwMDAgew0KPiA+ID4gPiArICAgICAgY29tcGF0aWJsZSA9ICJt
bWlvLXNyYW0iOw0KPiA+ID4gPiArICAgICAgcmVnID0gPDB4MCAweDkzZjAwMCAweDAgMHgxMDAw
PjsNCj4gPiA+ID4gKyAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ID4gPiArICAgICAg
I3NpemUtY2VsbHMgPSA8MT47DQo+ID4gPiA+ICsgICAgICByYW5nZXMgPSA8MCAweDAgMHg5M2Yw
MDAgMHgxMDAwPjsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgY3B1X3NjcF9scHJpOiBzY3At
c2htZW1AMCB7DQo+ID4gPiA+ICsgICAgICAgIGNvbXBhdGlibGUgPSAiYXJtLHNjbWktc2htZW0i
Ow0KPiA+ID4gPiArICAgICAgICByZWcgPSA8MHgwIDB4MjAwPjsNCj4gPiA+ID4gKyAgICAgIH07
DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgIGNwdV9zY3BfaHByaTogc2NwLXNobWVtQDIwMCB7
DQo+ID4gPiA+ICsgICAgICAgIGNvbXBhdGlibGUgPSAiYXJtLHNjbWktc2htZW0iOw0KPiA+ID4g
PiArICAgICAgICByZWcgPSA8MHgyMDAgMHgyMDA+Ow0KPiA+ID4gPiArICAgICAgfTsNCj4gPiA+
ID4gKyAgICB9Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgZmlybXdhcmUgew0KPiA+ID4gPiAr
ICAgICAgc21jX21ib3g6IG1haWxib3ggew0KPiA+ID4gPiArICAgICAgICAjbWJveC1jZWxscyA9
IDwxPjsNCj4gPiA+ID4gKyAgICAgICAgY29tcGF0aWJsZSA9ICJhcm0sc21jLW1ib3giOw0KPiA+
ID4gPiArICAgICAgICBtZXRob2QgPSAic21jIjsNCj4gPiA+ID4gKyAgICAgICAgYXJtLG51bS1j
aGFucyA9IDwweDI+Ow0KPiA+ID4gPiArICAgICAgICB0cmFuc3BvcnRzID0gIm1lbSI7DQo+ID4g
PiA+ICsgICAgICAgIC8qIE9wdGlvbmFsICovDQo+ID4gPiA+ICsgICAgICAgIGFybSxmdW5jLWlk
cyA9IDwweGMyMDAwMGZlPiwgPDB4YzIwMDAwZmY+Ow0KPiA+ID4gPg0KPiA+ID4gU01DL0hWQyBp
cyBzeW5jaHJvbm91c2x5KGJsb2NrKSBydW5uaW5nIGluICJzZWN1cmUgbW9kZSIsIGkuZSwgdGhl
cmUNCj4gPiA+IGNhbiBvbmx5IGJlIG9uZSBpbnN0YW5jZSBydW5uaW5nIHBsYXRmb3JtIHdpZGUu
IFJpZ2h0Pw0KPiA+DQo+ID4gSSB0aGluayB0aGVyZSBjb3VsZCBiZSBjaGFubmVsIGZvciBURUUs
IGFuZCBjaGFubmVsIGZvciBMaW51eC4NCj4gPiBGb3IgdmlydHVhbGl6YXRpb24gY2FzZSwgdGhl
cmUgY291bGQgYmUgZGVkaWNhdGVkIGNoYW5uZWwgZm9yIGVhY2ggVk0uDQo+ID4NCj4gSSBhbSB0
YWxraW5nIGZyb20gTGludXggcG92LiBGdW5jdGlvbnMgMHhmZSBhbmQgMHhmZiBhYm92ZSwgY2Fu
J3QgYm90aCBiZQ0KPiBhY3RpdmUgYXQgdGhlIHNhbWUgdGltZSwgcmlnaHQ/DQoNCklmIEkgZ2V0
IHlvdXIgcG9pbnQgY29ycmVjdGx5LA0KT24gVVAsIGJvdGggY291bGQgbm90IGJlIGFjdGl2ZS4g
T24gU01QLCB0eC9yeCBjb3VsZCBiZSBib3RoIGFjdGl2ZSwgYW55d2F5DQp0aGlzIGRlcGVuZHMg
b24gc2VjdXJlIGZpcm13YXJlIGFuZCBMaW51eCBmaXJtd2FyZSBkZXNpZ24uDQoNCkRvIHlvdSBo
YXZlIGFueSBzdWdnZXN0aW9ucyBhYm91dCBhcm0sZnVuYy1pZHMgaGVyZT8NCg0KVGhhbmtzLA0K
UGVuZy4NCg==
