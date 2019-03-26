Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A41C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF0720856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="Y3IGxeEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbfCZKYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:24:09 -0400
Received: from mail-eopbgr20129.outbound.protection.outlook.com ([40.107.2.129]:26310
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726248AbfCZKYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsTa5/ihxttjimyR1Ua7h86NVrA5ktgZD/ALf5hzRok=;
 b=Y3IGxeEv4zJDVSV9eGuC1TNFDk7f3Cco8EhXrs58PdLQxNVYy2koPldxo/rlnVCgXcUkswI55u7onMk+1dsOBpdeEiiit5nN1pmj9415vzS+FFrPJYVXP6AWTSdCV3h8of4uy/OesaeTemVx30efM2ZW8mr7gLeopWdiCsBLWxs=
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com (20.178.12.74) by
 VI1PR02MB4941.eurprd02.prod.outlook.com (20.177.200.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Tue, 26 Mar 2019 10:24:04 +0000
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::38db:37eb:b43e:e4c1]) by VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::38db:37eb:b43e:e4c1%6]) with mapi id 15.20.1730.019; Tue, 26 Mar 2019
 10:24:04 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Steven Price <steven.price@arm.com>,
        "laurentiu.tudor@nxp.com" <laurentiu.tudor@nxp.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "ying.zhang22455@nxp.com" <ying.zhang22455@nxp.com>
CC:     "upstream-release@linux.nxdi.nxp.com" 
        <upstream-release@linux.nxdi.nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RESEND] i2c: imx: defer probing on dma channel request
Thread-Topic: [RESEND] i2c: imx: defer probing on dma channel request
Thread-Index: AQHU4x+wsZsfatYnC02EM31vhKiOhaYclZ+AgAEgLQA=
Date:   Tue, 26 Mar 2019 10:24:03 +0000
Message-ID: <dcba97d5-639f-2f41-70ff-0ee9de9031d5@axentia.se>
References: <20190325153016.12626-1-laurentiu.tudor@nxp.com>
 <873b5aeb-e20a-de6b-515e-bc8fcc263452@arm.com>
In-Reply-To: <873b5aeb-e20a-de6b-515e-bc8fcc263452@arm.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1PR0402CA0003.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::13) To VI1PR02MB4542.eurprd02.prod.outlook.com
 (2603:10a6:803:b1::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fec94b71-8768-4701-654c-08d6b1d52b85
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB4941;
x-ms-traffictypediagnostic: VI1PR02MB4941:
x-microsoft-antispam-prvs: <VI1PR02MB494187DEB3199B06C0527BF7BC5F0@VI1PR02MB4941.eurprd02.prod.outlook.com>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39830400003)(346002)(396003)(376002)(189003)(199004)(2906002)(186003)(26005)(97736004)(68736007)(102836004)(2501003)(305945005)(5660300002)(81156014)(6506007)(7416002)(8936002)(386003)(229853002)(6486002)(76176011)(4326008)(99286004)(71190400001)(74482002)(86362001)(6436002)(52116002)(81166006)(14454004)(71200400001)(8676002)(6246003)(65806001)(316002)(65826007)(66066001)(106356001)(6116002)(58126008)(105586002)(3846002)(54906003)(2201001)(53936002)(36756003)(65956001)(508600001)(2616005)(6512007)(110136005)(14444005)(31696002)(31686004)(25786009)(53546011)(7736002)(11346002)(256004)(486006)(446003)(476003)(64126003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB4941;H:VI1PR02MB4542.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BnY3+UenmJI0KAdn2F27Z9ApE2RWTOXOXSCZvNjbjza9HzW9u6+zQUbUnP6reUIX7Ny3O7+AFq12iFd5lNVwG4ShUOoaoaCI8XgVaK/NzUHDh04jqvNGzEbaMEICD3/JhobIWIHYO4nu3zsnQCXKEz4dLPml3EDpZzDCObZStyAzaSb0B8G9enJOqibk6UY6Fq5quzKLNGOI68BOD6b4B6AWAd+KfzxGr1JGbr6k3bWwlnT0MbeORmaTXrRsrYxOazQIRbe8PyT5al+pQQocn+smWB3zsHQLYX8Hl5QdXYQ4ONCgJfc4P+dt3GrOZBfoGrOFM3X6Zby5zvASAKaP19GaLyT8p8GgJIscx/3DSbZdUDwa+eMMmvuO4ZlMm0VBsWcSQpMzBS1W9mbRs0Gt7yBIVtqHMfCgsMWgrVKY+sw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CDFA7677229FB2449D8D943498F321F6@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: fec94b71-8768-4701-654c-08d6b1d52b85
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 10:24:03.8948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4941
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wMy0yNSAxODoxMiwgU3RldmVuIFByaWNlIHdyb3RlOg0KPiBPbiAyNS8wMy8yMDE5
IDE1OjMwLCBsYXVyZW50aXUudHVkb3JAbnhwLmNvbSB3cm90ZToNCj4+IEZyb206IExhdXJlbnRp
dSBUdWRvciA8bGF1cmVudGl1LnR1ZG9yQG54cC5jb20+DQo+Pg0KPj4gSWYgdGhlIGRtYSBjb250
cm9sbGVyIGlzIG5vdCB5ZXQgcHJvYmVkLCBkZWZlciBpMmMgcHJvYmUuDQo+PiBUaGUgZXJyb3Ig
cGF0aCBpbiBwcm9iZSB3YXMgc2xpZ2h0bHkgbW9kaWZpZWQgKG5vIGZ1bmN0aW9uYWwgY2hhbmdl
KQ0KDQoqc25pcCoNCg0KPj4gQEAgLTExNjEsMTkgKzExNjIsMjUgQEAgc3RhdGljIGludCBpMmNf
aW14X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+PiAgCXBtX3J1bnRpbWVf
bWFya19sYXN0X2J1c3koJnBkZXYtPmRldik7DQo+PiAgCXBtX3J1bnRpbWVfcHV0X2F1dG9zdXNw
ZW5kKCZwZGV2LT5kZXYpOw0KPj4gIA0KPj4gKwkvKiBJbml0IERNQSBjb25maWcgaWYgc3VwcG9y
dGVkICovDQo+PiArCXJldCA9IGkyY19pbXhfZG1hX3JlcXVlc3QoaTJjX2lteCwgcGh5X2FkZHIp
Ow0KPj4gKwlpZiAocmV0KSB7DQo+PiArCQlpZiAocmV0ICE9IC1FUFJPQkVfREVGRVIpDQo+PiAr
CQkJZGV2X2luZm8oJnBkZXYtPmRldiwgImNhbid0IHVzZSBETUEsIHVzaW5nIFBJTyBpbnN0ZWFk
LlxuIik7DQo+PiArCQllbHNlDQo+PiArCQkJZ290byBkZWxfYWRhcHRlcjsNCj4+ICsJfQ0KPj4g
Kw0KPiANCj4gVGhpcyBjYW4gYmUgc2ltcGxpZmllZCBieSByZXZlcnNpbmcgdGhlIGNvbmRpdGlv
bjoNCj4gDQo+IAlpZiAocmV0KSB7DQo+IAkJaWYgKHJldCA9PSAtRVBST0JFX0RFRkVSKQ0KPiAJ
CQlnb3RvIGRlbF9hZGFwdGVyOw0KPiAJCWRldl9pbmZvKCk7DQo+IAl9DQo+IA0KPiBvciBldmVu
Og0KPiANCj4gCWlmIChyZXQgPT0gLUVQUk9CRV9ERUZFUikNCj4gCQlnb3RvIGRlbF9hZGFwdGVy
Ow0KPiAJZWxzZSBpZiAocmV0KQ0KPiAJCWRldl9pbmZvKCk7DQo+IA0KDQpXaGlsZSB3ZSdyZSBs
b29raW5nIGZvciBzdHVmZiB0byB0YWtlIG91dCwgemFwIHRoZSAiZWxzZSIuLi4NCg0KCWlmIChy
ZXQgPT0gLUVQUk9CRV9ERUZFUikNCgkJZ290byBkZWxfYWRhcHRlcjsNCglpZiAocmV0KQ0KCQlk
ZXZfaW5mbyguLi4pOw0KDQpDaGVlcnMsDQpQZXRlcg0K
