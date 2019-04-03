Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E96C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10AE22075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="bOBJTpXC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfDCPRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:17:18 -0400
Received: from mail-eopbgr20111.outbound.protection.outlook.com ([40.107.2.111]:5689
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726337AbfDCPRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqU8smN8veO49S+1ZalgTQkyDd/46CtmrrOeA2si5qw=;
 b=bOBJTpXChbUtGUVO7wX0dWT7UGDCtWho9g6soBG2A5iOKqGHw8gPjFFr/Za9DD9lU7mRW3RMge8QFE0tzCpoPLc/aX3VcIZtpCALRAmfTnza2ed7sm5bdmPTE552tmYRaZQYFSKKIXI4iE6EbaS7ZmSUcUC0RXDfjYSPRphUIIk=
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com (20.178.12.74) by
 VI1PR02MB4272.eurprd02.prod.outlook.com (20.177.60.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Wed, 3 Apr 2019 15:17:12 +0000
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::2891:d814:7bff:fbc7]) by VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::2891:d814:7bff:fbc7%3]) with mapi id 15.20.1750.017; Wed, 3 Apr 2019
 15:17:12 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
CC:     "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 04/12] i2c: mux: populate the new *_atomic callbacks
Thread-Topic: [PATCH 04/12] i2c: mux: populate the new *_atomic callbacks
Thread-Index: AQHU6hpx9uU01/0QE0ajFU8hn/RTxKYqjGKA
Date:   Wed, 3 Apr 2019 15:17:12 +0000
Message-ID: <59d32414-3859-d614-dc41-cc0a1bc63301@axentia.se>
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
 <20190403124019.8947-5-wsa+renesas@sang-engineering.com>
In-Reply-To: <20190403124019.8947-5-wsa+renesas@sang-engineering.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1PR05CA0386.eurprd05.prod.outlook.com
 (2603:10a6:7:94::45) To VI1PR02MB4542.eurprd02.prod.outlook.com
 (2603:10a6:803:b1::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9653c948-c311-4ff0-6189-08d6b8477287
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600139)(711020)(4605104)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7193020);SRVR:VI1PR02MB4272;
x-ms-traffictypediagnostic: VI1PR02MB4272:
x-microsoft-antispam-prvs: <VI1PR02MB4272B4DC3D983598BDC09410BC570@VI1PR02MB4272.eurprd02.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39830400003)(136003)(346002)(366004)(189003)(199004)(186003)(110136005)(256004)(53936002)(11346002)(53546011)(99286004)(386003)(71200400001)(64126003)(31696002)(52116002)(305945005)(102836004)(6512007)(26005)(3846002)(66066001)(316002)(65806001)(65826007)(14454004)(58126008)(6486002)(106356001)(4326008)(7416002)(14444005)(74482002)(65956001)(31686004)(508600001)(8936002)(229853002)(36756003)(5660300002)(2616005)(6246003)(71190400001)(2906002)(81166006)(68736007)(54906003)(6436002)(76176011)(476003)(105586002)(25786009)(8676002)(6506007)(2501003)(446003)(7736002)(486006)(6116002)(97736004)(86362001)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB4272;H:VI1PR02MB4542.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QUDTVi86YEjYXHWSOw1RKMtHI8HgEhTq1yvsfEo5ZqKog2WdAwWn9yccOoh8iHoPyKVtcufoLvrAhoay4eZsXkOiBJS0khwtHQdnwSLavTdACElCb7AHHvMLJQW8edwWKtNGY9k5OI1uxbzIRZHyGXwRwTFM3oHSdPNkEkZB+tqAqyRX/Y0Enc0dnSmfMk4LUPmN4l8LxiReSYW8tyvL2+eeLTc/YgxBlLPA9bG69wXuWZ9FLyD5YOvvkvSr1AGVXJrk5lFcnVZACw3zU+Q4b+qvuDjdav6FOD41VSEAEI5Y3s2voI/XStiDYYV9rkOOvjfazGSGvfzsWmW3dd04OH/uy3QSaMErbh1y52T5+ozAbotwDRVQDbUMNQY6ixDqrdG2wc4XiOlbBSJWxFV9lu6CGUrHxXbLehmCSyPH88U=
Content-Type: text/plain; charset="utf-8"
Content-ID: <59CEFE5B4A4970489A9BEEEE3545A485@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 9653c948-c311-4ff0-6189-08d6b8477287
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 15:17:12.6610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4272
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wNC0wMyAxNDo0MCwgV29sZnJhbSBTYW5nIHdyb3RlOg0KPiBJZiB0aGUgcGFyZW50
IGFkYXB0ZXIgaGFzIGF0b21pY194ZmVyIGNhbGxiYWNrcywgcG9wdWxhdGUgdGhlbSBmb3IgdGhl
DQo+IG11eCBhZGFwdGVyIGFzIHdlbGwuIFdlIGNhbiB1c2UgdGhlIHNhbWUgdHJhbnNsYXRpb24g
ZnVuY3Rpb24gYXMgZm9yIHRoZQ0KPiBub24tYXRvbWljIHhmZXIgY2FsbGJhY2suDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBXb2xmcmFtIFNhbmcgPHdzYStyZW5lc2FzQHNhbmctZW5naW5lZXJpbmcu
Y29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaTJjL2kyYy1tdXguYyB8IDYgKysrKysrDQo+ICAxIGZp
bGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
MmMvaTJjLW11eC5jIGIvZHJpdmVycy9pMmMvaTJjLW11eC5jDQo+IGluZGV4IGYzMzA2OTBiNDEy
NS4uNjAzMjUyZmExMjg0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2kyYy9pMmMtbXV4LmMNCj4g
KysrIGIvZHJpdmVycy9pMmMvaTJjLW11eC5jDQo+IEBAIC0zMTAsMTIgKzMxMCwxOCBAQCBpbnQg
aTJjX211eF9hZGRfYWRhcHRlcihzdHJ1Y3QgaTJjX211eF9jb3JlICptdXhjLA0KPiAgCQllbHNl
DQo+ICAJCQlwcml2LT5hbGdvLm1hc3Rlcl94ZmVyID0gX19pMmNfbXV4X21hc3Rlcl94ZmVyOw0K
PiAgCX0NCj4gKwlpZiAocGFyZW50LT5hbGdvLT5tYXN0ZXJfeGZlcl9hdG9taWMpDQo+ICsJCXBy
aXYtPmFsZ28ubWFzdGVyX3hmZXJfYXRvbWljID0gcHJpdi0+YWxnby5tYXN0ZXJfeGZlcjsNCj4g
Kw0KPiAgCWlmIChwYXJlbnQtPmFsZ28tPnNtYnVzX3hmZXIpIHsNCj4gIAkJaWYgKG11eGMtPm11
eF9sb2NrZWQpDQo+ICAJCQlwcml2LT5hbGdvLnNtYnVzX3hmZXIgPSBpMmNfbXV4X3NtYnVzX3hm
ZXI7DQo+ICAJCWVsc2UNCj4gIAkJCXByaXYtPmFsZ28uc21idXNfeGZlciA9IF9faTJjX211eF9z
bWJ1c194ZmVyOw0KPiAgCX0NCj4gKwlpZiAocGFyZW50LT5hbGdvLT5zbWJ1c194ZmVyX2F0b21p
YykNCj4gKwkJcHJpdi0+YWxnby5zbWJ1c194ZmVyX2F0b21pYyA9IHByaXYtPmFsZ28uc21idXNf
eGZlcjsNCj4gKw0KPiAgCXByaXYtPmFsZ28uZnVuY3Rpb25hbGl0eSA9IGkyY19tdXhfZnVuY3Rp
b25hbGl0eTsNCj4gIA0KPiAgCS8qIE5vdyBmaWxsIG91dCBuZXcgYWRhcHRlciBzdHJ1Y3R1cmUg
Ki8NCj4gDQoNCkhtbW0sIHdoYXQgaGFwcGVucyBpZiBhIGRyaXZlciBpbXBsZW1lbnRzIC5tYXN0
ZXJfeGZlciBhbmQgcmVsaWVzIG9uDQplbXVsYXRpb24gZm9yIFNNQnVzLCBhbmQgdGhlbiBzb21l
b25lIGltcGxlbWVudHMgLnNtYnVzX3hmZXJfYXRvbWljDQp0byBoYW5kbGUgc29tZSBjb3JuZXIg
Y2FzZSBhdCBwb3dlci1kb3duPw0KDQpUaGVuIHNvbWVvbmUgaGlkZXMgdGhlIHBvd2VyLWRvd24g
ZGV2aWNlIGJlaGluZCBhIG11eC4gVGhhdCB3b3VsZCBlbmQNCndpdGggeGZlcnMgZGVzdGluZWQg
Zm9yIC5zbWJ1c194ZmVyX2F0b21pYyBiZWluZyBlbXVsYXRlZCBieSB0aGUNCm5vbi1hdG9taWMg
Lm1hc3Rlcl94ZmVyLCBubz8NCg0KTWF5YmUgdG9vIHdlaXJkIHRvIGNhcmUgYWJvdXQ/DQoNCkkg
Z3Vlc3MgdGhlIHF1ZXN0aW9uIGlzIGlmIGl0IGlzIGFsbG93ZWQgdG8gaGF2ZSAubWFzdGVyX3hm
ZXJfYXRvbWljDQpidXQgbm90IC5tYXN0ZXJfeGZlciAoYW5kIHNpbWlsYXJseSBmb3IgLnNtYnVz
X3hmZXJ7LF9hdG9taWN9KT8gTWF5YmUNCnRoYXQgZGVjaXNpb24gc2hvdWxkIGJlIG1hZGUgZXhw
bGljaXQ/IEFuZCBwZXJoYXBzIGVuZm9yY2VkPw0KDQpJIGRvbid0IGNhcmUgZGVlcGx5IGFib3V0
IHRoZSBhYm92ZSB0aG91Z2gsIHNvIGZlZWwgZnJlZSB0byBkbw0Kc29tZXRoaW5nIGFib3V0IGl0
LCBvcg0KDQpSZXZpZXdlZC1ieTogUGV0ZXIgUm9zaW4gPHBlZGFAYXhlbnRpYS5zZT4NCg0KQ2hl
ZXJzLA0KUGV0ZXINCg==
