Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1621C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 20:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B99562082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 20:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=p1hq.onmicrosoft.com header.i=@p1hq.onmicrosoft.com header.b="R2hG9rL5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfEFU6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 16:58:33 -0400
Received: from mail-eopbgr80075.outbound.protection.outlook.com ([40.107.8.75]:34805
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726363AbfEFU6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 16:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=p1hq.onmicrosoft.com;
 s=selector1-phaseone-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IRyLohPtFzcZDKVR3ivuyKULe5rrILs+UtovUaTDzQ=;
 b=R2hG9rL5TLqnjKBmFD7aXMlPLEEpp1Rlj9Rw1JZi0FmCtING5IiWs7EjtkKb0Ru+hnh36Zv1LyuouPfGWmOeUqxehWn80jyLHYEpZJTyGKL6P8OAXq8TT92VCjD27w3eF9N/1XTkV3dLs+WUlyM0x/A6WC1VW07Z94sEHjMdDIM=
Received: from DB8PR01MB6027.eurprd01.prod.exchangelabs.com (10.255.18.203) by
 DB8PR01MB5930.eurprd01.prod.exchangelabs.com (10.255.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Mon, 6 May 2019 20:58:28 +0000
Received: from DB8PR01MB6027.eurprd01.prod.exchangelabs.com
 ([fe80::b938:19d5:d32c:61ff]) by DB8PR01MB6027.eurprd01.prod.exchangelabs.com
 ([fe80::b938:19d5:d32c:61ff%3]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 20:58:28 +0000
From:   "Claus H. Stovgaard" <cst@phaseone.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>
Subject: Re: [PATCH 3/3] usb: dwc3: gadget: Add support for disabling U1 and
 U2 entries
Thread-Topic: [PATCH 3/3] usb: dwc3: gadget: Add support for disabling U1 and
 U2 entries
Thread-Index: AQHVBE5z5fF2b2KOL0m3xowevYRPmg==
Date:   Mon, 6 May 2019 20:58:27 +0000
Message-ID: <1557176302.18203.20.camel@phaseone.com>
References: <1556792423-4833-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
         <1556792423-4833-4-git-send-email-anurag.kumar.vulisha@xilinx.com>
         <30102591E157244384E984126FC3CB4F639E7BA8@us01wembx1.internal.synopsys.com>
In-Reply-To: <30102591E157244384E984126FC3CB4F639E7BA8@us01wembx1.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2.110.44.75]
x-mailer: Evolution 3.24.6 
x-clientproxiedby: HE1PR0202CA0031.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::17) To DB8PR01MB6027.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:eb::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=cst@phaseone.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5a19076-147c-4fe7-12ff-08d6d2659555
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:DB8PR01MB5930;
x-ms-traffictypediagnostic: DB8PR01MB5930:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB8PR01MB5930FF2522CB83D1E8F9DFF9DA300@DB8PR01MB5930.eurprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(39850400004)(136003)(376002)(189003)(199004)(6512007)(305945005)(966005)(478600001)(229853002)(81166006)(7736002)(52116002)(6306002)(99286004)(6246003)(5660300002)(68736007)(486006)(66946007)(66066001)(66476007)(25786009)(4326008)(53936002)(66556008)(64756008)(73956011)(256004)(66446008)(55236004)(386003)(6506007)(102836004)(103116003)(71190400001)(26005)(76176011)(50226002)(71200400001)(8676002)(6436002)(8936002)(81156014)(6486002)(110136005)(54906003)(316002)(14454004)(476003)(2616005)(86362001)(36756003)(446003)(11346002)(6116002)(186003)(3846002)(2906002)(7416002)(99106002)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR01MB5930;H:DB8PR01MB6027.eurprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: phaseone.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: w7BAYoKNHD2eAhqTpcxqP/+DPVA9ptrVVgU7BPe/KgleNTILr+1OXRl1NYVNnyei/JzaICBQaURQHT8KnbK0vMfhtoSTkCDDuCdTxptEdcixw48CITklemG+PDyNYczIoMrgGuq12146H+O6MDVw73GwEEPTaI0QQp5ySs82NcaPjgTaniSwPduSqRBE8PC97cwGa4xb+19hv/TfmHDKj5Np6LQOeHcIH3vFiskJJXOfspqwkZBOCQepYDxQw2AVio8ACh9ylzkBkwtdDOUJtpu8Qy6ATSnnQ8ZVGaMo8SMOuaOszHqBO3sfNIXOlzUgpywAWcZ27swZZ0JSPlFfIPkLU7V2RXm1vi+jwA06QFidIkHv4/nTDxVSiVr2v9CpP0xr4u0N+usjrSSM7XD4/54EV7fVFoeAFkwZ4LB9sSk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FEAA0156C49356438C41068A5B7ACC39@eurprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phaseone.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a19076-147c-4fe7-12ff-08d6d2659555
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 20:58:28.4242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cbe5b4c6-877a-4fe4-be65-3be424dd0574
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR01MB5930
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVGhpbmggYW5kIEFudXJhZw0KDQpPbiBtYW4sIDIwMTktMDUtMDYgYXQgMTk6MjEgKzAwMDAs
IFRoaW5oIE5ndXllbiB3cm90ZToNCg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2Mz
L2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4gaW5kZXggYTFiMTI2Zi4uNGYw
OTEyYyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4gQEAgLTEyODUsNiArMTI4NSwxMCBAQCBzdGF0
aWMgdm9pZCBkd2MzX2dldF9wcm9wZXJ0aWVzKHN0cnVjdCBkd2MzDQo+ID4gKmR3YykNCj4gPiAg
CQkJCSJzbnBzLGRpc191Ml9zdXNwaHlfcXVpcmsiKTsNCj4gPiAgCWR3Yy0+ZGlzX2VuYmxzbHBt
X3F1aXJrID0gZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9vbChkZXYsDQo+ID4gIAkJCQkic25wcyxk
aXNfZW5ibHNscG1fcXVpcmsiKTsNCj4gPiArCWR3Yy0+ZGlzX3UxX2VudHJ5X3F1aXJrID0gZGV2
aWNlX3Byb3BlcnR5X3JlYWRfYm9vbChkZXYsDQo+ID4gKwkJCQkic25wcyxkaXNfdTFfZW50cnlf
cXVpcmsiKTsNCj4gPiArCWR3Yy0+ZGlzX3UyX2VudHJ5X3F1aXJrID0gZGV2aWNlX3Byb3BlcnR5
X3JlYWRfYm9vbChkZXYsDQo+ID4gKwkJCQkic25wcyxkaXNfdTJfZW50cnlfcXVpcmsiKTsNCj4g
DQo+IFBsZWFzZSB1c2UgIi0iIHJhdGhlciB0aGFuICJfIiBpbiB0aGUgcHJvcGVydHkgbmFtZXMu
DQoNCkkgaGF2ZSB0aG91Z2h0IGFib3V0IHRoaXMgZmVhdHVyZSBvdmVyIHRoZSB3ZWVrZW5kLCBh
bmQgdGhpbmsgdGhlDQpuYW1pbmcgc2hvdWxkIGJlIGNoYW5nZWQgdG8gc29tZXRoaW5nIGxpa2Ug
InNucHMsYm9zLXUxLWV4aXQtbGF0LWluLXVzIiANCmFuZCBuYW1lZCB0aGUgc2FtZSBpbiB0aGUg
Y29kZS4gQW5kIHRoZW4gYmUgdGhlIHZhbHVlIHVzZWQgYnkgdGhlDQpnZXRfY29uZmlnX3BhcmFt
cy4gRS5nLiB0aGUgZGV2aWNlLXRyZWUgaXMgdXNlZCB0byBzZXQgdGhlIHZhbHVlcw0KZGlyZWN0
bHkgdXNlZCBmb3IgYlV4ZGV2RXhpdExhdCBpbnN0ZWFkIG9mIG5hbWVkIHNvbWV0aGluZyBub3Qg
cmVsYXRlZA0KdG8gZXhpdCBsYXRlbmN5Lg0KDQpXaXRoIHRoaXMgdGhlIG5hbWUgYW5kIGZ1bmN0
aW9uIGlzIGEgMSB0byAxIG1hdGNoLCBhbmQgeW91IGNhbiBhbW9uZw0Kb3RoZXJzIHNldCBpdCB0
byAwIGZvciBvcHRhaW5pbmcgd2hhdCBBbnVyYWcgd2FudHMuDQoNClJlZ2FyZGluZyB0aGUgZGlz
YWJsaW5nIG9mIFUxIC8gVTIuIEkgc2VuZCB0aGlzIHRvIEFudXJhZw0KaHR0cHM6Ly9tYXJjLmlu
Zm8vP2w9bGludXgtdXNiJm09MTU1NjgzMjk5MzExOTU0Jnc9Mg0KSGVyZSBpIGNyZWF0ZWQgYSBj
b25maWdmcyBpbnRlcmZhY2Ugd2l0aCB0aGUgbmFtZXMgImxwbV9VMV9kaXNhYmxlIiBhbmQNCiJs
cG1fVTJfZGlzYWJsZSIgZm9yIGNvbnRyb2xsaW5nIHRoZSBEVENMIG9mIGR3YzMsIGFuZCByZWpl
Y3QNClNFVF9GRUFUVVJFKFUxL1UyKQ0KDQpXaWxsIHNlbmQgdGhpcyBpbiBzZXBlcmF0ZSBwYXRj
aCB0b21vcnJvdywgaW4gdGhlIGhvcGUgdGhhdCBBbnVyYWdzDQpmZWF0dXJlIGNhbiBiZWNvbWUg
YSB3YXkgZm9yIGNvbnRyb2xsaW5nIGV4aXQgbGF0ZW5jeSwgYW5kIG15IHBhdGNoDQpiZWNvbWUg
YSB3YXkgZm9yIGRpc2FibGluZyBVMS9VMg0KDQpCUg0KQ2xhdXMNCg==
