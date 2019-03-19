Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558DFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 119E02077B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="gg3YK9DL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfCSQVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:21:52 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:49294 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfCSQVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:21:51 -0400
X-IronPort-AV: E=Sophos;i="5.58,498,1544511600"; 
   d="scan'208";a="28133085"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 19 Mar 2019 09:21:49 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 19 Mar 2019 09:21:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXxaO+O5GENeil6K7XwcHm7Qge8DOfaN0URLOHKUzHs=;
 b=gg3YK9DLaW70baJ5seBn2GNdkrIq/7xiYkSL5bYn4V4s9s6+thh/1Sk3WeCgzIaBQTd1a+9ZBDjh7/qDuw2R0E2SnwPNa6iLV3tDFydip5rp++DUw7GHluuF+7j0Q4zmoH23ueEi7LBi1u2QmMmpf7ECzMddlXfo7VBi7iODzHA=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB2013.namprd11.prod.outlook.com (10.169.234.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 19 Mar 2019 16:21:44 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6%9]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 16:21:44 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <harini.katakam@xilinx.com>, <Nicolas.Ferre@microchip.com>,
        <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <harinikatakamlinux@gmail.com>
Subject: Re: [RFC PATCH] net: macb: Add null check for PCLK and HCLK
Thread-Topic: [RFC PATCH] net: macb: Add null check for PCLK and HCLK
Thread-Index: AQHU3hg/sXJVEq+E5ESf0pCxAVdSmqYTI3aA
Date:   Tue, 19 Mar 2019 16:21:43 +0000
Message-ID: <74d29e0e-d55e-e983-add1-361f7c4af948@microchip.com>
References: <1552974845-1590-1-git-send-email-harini.katakam@xilinx.com>
In-Reply-To: <1552974845-1590-1-git-send-email-harini.katakam@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0701CA0058.eurprd07.prod.outlook.com
 (2603:10a6:800:5f::20) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190319182137394
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b8f0e12-f11d-4246-885a-08d6ac86f9cd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB2013;
x-ms-traffictypediagnostic: MWHPR11MB2013:
x-microsoft-antispam-prvs: <MWHPR11MB2013F89DBC34D3231779506287400@MWHPR11MB2013.namprd11.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(376002)(396003)(39860400002)(199004)(189003)(7736002)(76176011)(31686004)(6436002)(99286004)(6512007)(86362001)(186003)(53546011)(386003)(6506007)(6486002)(8936002)(105586002)(2616005)(31696002)(4326008)(476003)(68736007)(2906002)(478600001)(486006)(2501003)(316002)(6116002)(5660300002)(97736004)(446003)(53936002)(11346002)(52116002)(102836004)(229853002)(81156014)(66066001)(54906003)(8676002)(71190400001)(81166006)(6246003)(3846002)(305945005)(71200400001)(106356001)(36756003)(14454004)(256004)(25786009)(110136005)(72206003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB2013;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 20qzedGPwoi4IYRVSwzlYWZcwkEZV1TvGMpRdQx2AKap1b13GlwYw6cVGLA9bJh0wRscBheC8ctXgxWZSe2P3aHF0V7CZt1KAtPv2xMwZtymR42GM8UK1mfyFpYS50i8gMKXB3XdVKaYJXoHICkpY+cPsTSL9mA+3VRu3qAi19XFoK5ktVGuOtoKNSirhDpr+Q+23K8QhnHRac59hSlVFmjcf8n9AHYXoHSRySH/sQNJM0VZSAYADCHaEExcilF60nbo+QKOLLSvWYFnATr9SbQ17G5KkYRl2lJbml8lktwnojbFNltFynfZtb5R5xdNQQofF2XfNrbXyDWvyIQ6zTrzlXQxlMChn3g1kT6EyoOIUf42tEm+zx5VlDtCFovJJn8ux/GbrK28mlzbgPU3bQ8lClXYYXekCayflWDHULc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B090FF5AE14EEC4EBC6314E85CAB73B2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8f0e12-f11d-4246-885a-08d6ac86f9cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 16:21:43.9758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2013
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDE5LjAzLjIwMTkgMDc6NTQsIEhhcmluaSBLYXRha2FtIHdyb3RlOg0KPiBCb3RoIFBD
TEsgYW5kIEhDTEsgYXJlICJyZXF1aXJlZCIgY2xvY2tzIGFjY29yZGluZyB0byBtYWNiIGRldmlj
ZXRyZWUNCj4gZG9jdW1lbnRhdGlvbi4gVGhlcmUgaXMgYSBjaGFuY2UgdGhhdCBkZXZtX2Nsa19n
ZXQgZG9lc24ndCByZXR1cm4gYQ0KPiBuZWdhdGl2ZSBlcnJvciBidXQganVzdCBhIE5VTEwgY2xv
Y2sgc3RydWN0dXJlIGluc3RlYWQuIEluIHN1Y2ggYSBjYXNlDQo+IHRoZSBkcml2ZXIgcHJvY2Vl
ZHMgYXMgdXN1YWwgYW5kIHVzZXMgcGNsayB2YWx1ZSAwIHRvIGNhbGN1bGF0ZSBNREMNCj4gZGl2
aXNvciB3aGljaCBpcyBpbmNvcnJlY3QuIEhlbmNlIGZpeCB0aGUgc2FtZSBpbiBjbG9jayBpbml0
aWFsaXphdGlvbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhhcmluaSBLYXRha2FtIDxoYXJpbmku
a2F0YWthbUB4aWxpbnguY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2NhZGVu
Y2UvbWFjYl9tYWluLmMgfCA0ICsrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvY2FkZW5jZS9tYWNiX21haW4uYyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2NhZGVuY2UvbWFj
Yl9tYWluLmMNCj4gaW5kZXggYWQwOTlmZC4uZDEyZDgxNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvY2FkZW5jZS9tYWNiX21haW4uYw0KPiArKysgYi9kcml2ZXJzL25ldC9l
dGhlcm5ldC9jYWRlbmNlL21hY2JfbWFpbi5jDQo+IEBAIC0zMzcwLDEzICszMzcwLDEzIEBAIHN0
YXRpYyBpbnQgbWFjYl9jbGtfaW5pdChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LCBzdHJ1
Y3QgY2xrICoqcGNsaywNCj4gIAkJKmhjbGsgPSBkZXZtX2Nsa19nZXQoJnBkZXYtPmRldiwgImhj
bGsiKTsNCj4gIAl9DQo+ICANCj4gLQlpZiAoSVNfRVJSKCpwY2xrKSkgew0KPiArCWlmIChJU19F
UlIoKnBjbGspIHx8ICgqcGNsayA9PSBOVUxMKSkgew0KDQpZb3UgY2FuIHVzZSBJU19FUlJfT1Jf
TlVMTCgpIG1hY3JvLg0KDQo+ICAJCWVyciA9IFBUUl9FUlIoKnBjbGspOw0KPiAgCQlkZXZfZXJy
KCZwZGV2LT5kZXYsICJmYWlsZWQgdG8gZ2V0IG1hY2JfY2xrICgldSlcbiIsIGVycik7DQo+ICAJ
CXJldHVybiBlcnI7DQo+ICAJfQ0KPiAgDQo+IC0JaWYgKElTX0VSUigqaGNsaykpIHsNCj4gKwlp
ZiAoSVNfRVJSKCpoY2xrKSB8fCAoKmhjbGsgPT0gTlVMTCkpIHsNCg0KRGl0dG8NCg0KPiAgCQll
cnIgPSBQVFJfRVJSKCpoY2xrKTsNCj4gIAkJZGV2X2VycigmcGRldi0+ZGV2LCAiZmFpbGVkIHRv
IGdldCBoY2xrICgldSlcbiIsIGVycik7DQo+ICAJCXJldHVybiBlcnI7DQo+IA0K
