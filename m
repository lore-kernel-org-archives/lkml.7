Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AF2C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F225920673
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jEjSChMc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfFFIUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 04:20:08 -0400
Received: from mail-eopbgr140071.outbound.protection.outlook.com ([40.107.14.71]:8935
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726223AbfFFIUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 04:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkHBqrFdV8Qrtl9bItUJfQizYLpUCSv1Ca/kuonfWlg=;
 b=jEjSChMcyetVMfTQ4PyKmG/eOAqkOAfxUD5c4ep6xk8YQIm+MdfQJmA0YLwdREZO9JNP+m+Or4pLYBfhsGonoOVABXPtJYuLTv/tw8RzRNxtYSM2lZTyqlS+WTabKORpEoo/9q2nJl09o/aFRegVpFyrvaVyBuQVuUZuzl+TY/I=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.44.16) by
 AM5PR0402MB2772.eurprd04.prod.outlook.com (10.175.41.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Thu, 6 Jun 2019 08:20:03 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::a1bf:17d:a52:3824]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::a1bf:17d:a52:3824%4]) with mapi id 15.20.1965.011; Thu, 6 Jun 2019
 08:20:03 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>, Yang Li <pku.leo@gmail.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RESEND][PATCH v3 1/2] usb: dwc3: Add avoiding vbus glitch happen
 during xhci reset
Thread-Topic: [RESEND][PATCH v3 1/2] usb: dwc3: Add avoiding vbus glitch
 happen during xhci reset
Thread-Index: AQHVHBLourGMUHjS80KOCHUiDl6by6aOSEAAgAAASeA=
Date:   Thu, 6 Jun 2019 08:20:03 +0000
Message-ID: <AM5PR0402MB2865979E26017BC5937DBBA5F1170@AM5PR0402MB2865.eurprd04.prod.outlook.com>
References: <20190606025418.26313-1-ran.wang_1@nxp.com>
 <78eb1558-b8d4-0632-ad0c-4144c711d2da@cogentembedded.com>
In-Reply-To: <78eb1558-b8d4-0632-ad0c-4144c711d2da@cogentembedded.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72c8ddcc-0975-4add-2a0c-08d6ea57c67e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM5PR0402MB2772;
x-ms-traffictypediagnostic: AM5PR0402MB2772:
x-microsoft-antispam-prvs: <AM5PR0402MB27729871382C8442A4A1FB19F1170@AM5PR0402MB2772.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(376002)(366004)(396003)(189003)(199004)(6506007)(4744005)(55016002)(446003)(14454004)(305945005)(7736002)(110136005)(66946007)(6116002)(53936002)(86362001)(5660300002)(11346002)(52536014)(66476007)(4326008)(33656002)(2906002)(476003)(486006)(68736007)(3846002)(25786009)(316002)(81166006)(6246003)(478600001)(74316002)(8936002)(81156014)(8676002)(186003)(64756008)(66446008)(71200400001)(76116006)(71190400001)(54906003)(73956011)(26005)(66556008)(256004)(9686003)(76176011)(102836004)(53546011)(7696005)(229853002)(6436002)(99286004)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2772;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LEM/qZliSZCPG0w3tR7/sQH646/2PskYVCV6YuejVzhz3dNbyjAuKRA4EoAUFPjGr2Ch7DcjkRix/855koD8U6kWAwusztLAbbOE44rPMY1df/ZKwRFm0ZYlvvORc0LGkyyQfrlvCZRGD6m7Ng+Bzefa1yw9hhh1R2BYlQi7Z0zTS+RCPT6L6OHY169QNe9KW2+rbMpxMhEtDs3uAgX7fABdxYe1smmMffyLqvHLwOdnjQq8CaZ0ZwHO/KGaz+JyB+C3+Vtw9aPSDRQDre3M3OsTZoBJ1+3yjHq2Rm/CIjtRfH59WE3yegffSFchufuffGca1uS/nFigozjrjYoZqhf5A2EfvAwAVh3r9BLO+vO5Cl/kZa6VTmj1Qt85id0i9WY1JhzVlGOLp4gimBcUwqZAETKQGmIutDCgMnhKxGo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c8ddcc-0975-4add-2a0c-08d6ea57c67e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 08:20:03.1934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ran.wang_1@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2772
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2VyZ2VpLA0KDQpPbiBUaHVyc2RheSwgSnVuZSAwNiwgMjAxOSAxNjoxNyBTZXJnZWkgU2h0
eWx5b3Ygd3JvdGU6DQo+IA0KPiBIZWxsbyENCj4gDQo+IE9uIDA2LjA2LjIwMTkgNTo1NCwgUmFu
IFdhbmcgd3JvdGU6DQo+IA0KPiA+IFdoZW4gRFdDMyBpcyBzZXQgdG8gaG9zdCBtb2RlIGJ5IHBy
b2dyYW1taW5nIHJlZ2lzdGVyIERXQzNfR0NUTCwgVkJVUw0KPiA+IChvciBpdHMgY29udHJvbCBz
aWduYWwpIHdpbGwgdHVybiBvbiBpbW1lZGlhdGVseSBvbiByZWxhdGVkIFJvb3QgSHViDQo+ID4g
cG9ydHMuIFRoZW4gdGhlIFZCVVMgd2lsbCBiZSBkZS1hc3NlcnRlZCBmb3IgYSBsaXR0bGUgd2hp
bGUgZHVyaW5nDQo+ID4geGhjaSByZXNldCAoY29uZHVjdGVkIGJ5IHhoY2kgZHJpdmVyKSBmb3Ig
YSBsaXR0bGUgd2hpbGUgYW5kIGJhY2sgdG8gbm9ybWFsLg0KPiA+DQo+ID4gVGhpcyBWQlVTIGds
aXRjaCBtaWdodCBjYXVzZSBzb21lIFVTQiBkZXZpY2VzIGVtdXJhdGlvbiBmYWlsIGlmIGtlcm5l
bA0KPiANCj4gICAgIEVudW1lcmF0aW9uLiA6LSkNCg0KVGhhbmtzLCB3aWxsIGNvcnJlY3QgaXQg
aW4gbmV4dCB2ZXJzaW9uDQogDQpSZWdhcmRzLA0KUmFuDQoNCj4gPiBib290IHdpdGggdGhlbSBj
b25uZWN0ZWQuIE9uZSBTVyB3b3JrYXJvdW5kIHdoaWNoIGNhbiBmaXggdGhpcyBpcyB0bw0KPiA+
IHByb2dyYW0gYWxsIFBPUlRTQ1tQUF0gdG8gMCB0byB0dXJuIG9mZiBWQlVTIGltbWVkaWF0ZWx5
IGFmdGVyIHNldHRpbmcNCj4gPiBob3N0IG1vZGUgaW4gRFdDMyBkcml2ZXIocGVyIHNpZ25hbCBt
ZWFzdXJlbWVudCByZXN1bHQsIGl0IHdpbGwgYmUgdG9vDQo+ID4gbGF0ZSB0byBkbyBpdCBpbiB4
aGNpLXBsYXQuYyBvciB4aGNpLmMpLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmFuIFdhbmcg
PHJhbi53YW5nXzFAbnhwLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhA
a2VybmVsLm9yZz4NCj4gWy4uLl0NCj4gDQo+IE1CUiwgU2VyZ2VpDQo=
