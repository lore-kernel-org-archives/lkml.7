Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0746C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6C2E2805E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="EvNMtevT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbfFCNLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:11:49 -0400
Received: from mail-eopbgr80103.outbound.protection.outlook.com ([40.107.8.103]:35398
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726516AbfFCNLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=me4Q3yCxnaEDwABzPrqvBgZkv4GpBOMsZ6E/px0JVvA=;
 b=EvNMtevTLyveqBaeIqVMe+MMvWtV6DmNsqsi6Bt2De+Kgi3TcaycKIWSuGVkrUEF9Id0/P2L5eBUYq+FJY+T6MQ1vnKzqUV9TB+3dMbQ3jfMvB6OH0noNsg+YzZUdExgTfQ7CWXrzOMSZ73h2PCl6O1BIzBuKXtlwyLF4b6o5P4=
Received: from VI1PR07MB3165.eurprd07.prod.outlook.com (10.175.243.15) by
 VI1PR07MB4143.eurprd07.prod.outlook.com (52.134.26.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Mon, 3 Jun 2019 13:11:45 +0000
Received: from VI1PR07MB3165.eurprd07.prod.outlook.com
 ([fe80::1403:5377:c11d:a41a]) by VI1PR07MB3165.eurprd07.prod.outlook.com
 ([fe80::1403:5377:c11d:a41a%7]) with mapi id 15.20.1965.011; Mon, 3 Jun 2019
 13:11:45 +0000
From:   "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
To:     "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hwmon: pmbus: protect read-modify-write with lock
Thread-Topic: [PATCH] hwmon: pmbus: protect read-modify-write with lock
Thread-Index: AQHVGg3k2XulVXbiDkOq27wOexnTBw==
Date:   Mon, 3 Jun 2019 13:11:45 +0000
Message-ID: <5ecab585-7e74-ea9f-8d33-93ab024e1a14@nokia.com>
References: <20190530064509.GA13789@localhost.localdomain>
In-Reply-To: <20190530064509.GA13789@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [131.228.32.166]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-clientproxiedby: HE1PR0102CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::18) To VI1PR07MB3165.eurprd07.prod.outlook.com
 (2603:10a6:802:21::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b7fbd54-94de-4f94-a5b4-08d6e8250727
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR07MB4143;
x-ms-traffictypediagnostic: VI1PR07MB4143:
x-microsoft-antispam-prvs: <VI1PR07MB41432681F33B862D570781B888140@VI1PR07MB4143.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(346002)(396003)(39860400002)(189003)(199004)(31686004)(76176011)(71190400001)(71200400001)(65826007)(25786009)(64126003)(486006)(26005)(446003)(11346002)(476003)(2616005)(52116002)(186003)(102836004)(99286004)(386003)(6506007)(53546011)(14444005)(256004)(4326008)(8676002)(31696002)(508600001)(6246003)(6512007)(7736002)(54906003)(316002)(81156014)(81166006)(66446008)(64756008)(66556008)(66476007)(66946007)(58126008)(73956011)(86362001)(5660300002)(110136005)(2906002)(53936002)(305945005)(229853002)(36756003)(8936002)(3846002)(6486002)(66066001)(6116002)(6436002)(65806001)(14454004)(65956001)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB4143;H:VI1PR07MB3165.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: V6qSizpizBOibPu2/FgKD41wPtxgWjQDQiLGlSSXAjMTlAxvi2vKAypn5zki6T8hSAhC0W6KR534+tCL4Dsc7+Vi5mUC1QH7BjhTcBPei+/raGdFG+UHuuiV9UkmV5HaE+eFvtqVTSicbUgbmYOJDnqAuKp699oQUZ/9LvPg/GN7QRPlYO+2iI3z4/AhXEcCLCn5nhPqHDstzXwzXSs3THWWIW6TlA4rpJgktyUNRiL0Nv7YmH6yRITe6iycCEsTcweTmrZik4HajEQh131j/SRHJtOZHdqT3SrxKbjO+6B8H6SS7q84GHMT+Ya/6Zl+fS5jGrzAHHQzHSTiIjafAw6WfvqdzkYM8RWQ71TcCIJNSavy+ROhcnShP8Vtr67bQGjEnwajMStiVOHfPm0euiuq0LjfXDlRKncpTPiMHqQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6F218BE1CECF048AF31EE8BB5E643BD@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7fbd54-94de-4f94-a5b4-08d6e8250727
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 13:11:45.3525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alexander.sverdlin@nokia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB4143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkhDQoNCk9uIDMwLzA1LzIwMTkgMDg6NDUsIEFkYW1za2ksIEtyenlzenRvZiAoTm9raWEgLSBQ
TC9Xcm9jbGF3KSB3cm90ZToNCj4gVGhlIG9wZXJhdGlvbiBkb25lIGluIHRoZSBwbWJ1c191cGRh
dGVfZmFuKCkgZnVuY3Rpb24gaXMgYQ0KPiByZWFkLW1vZGlmeS13cml0ZSBvcGVyYXRpb24gYnV0
IGl0IGxhY2tzIGFueSBraW5kIG9mIGxvY2sgcHJvdGVjdGlvbg0KPiB3aGljaCBtYXkgY2F1c2Ug
cHJvYmxlbXMgaWYgcnVuIG1vcmUgdGhhbiBvbmNlIHNpbXVsdGFuZW91c2x5LiBUaGlzDQo+IHBh
dGNoIHVzZXMgYW4gZXhpc3RpbmcgdXBkYXRlX2xvY2sgbXV0ZXggdG8gZml4IHRoaXMgcHJvYmxl
bS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtyenlzenRvZiBBZGFtc2tpIDxrcnp5c3p0b2YuYWRh
bXNraUBub2tpYS5jb20+DQo+IC0tLQ0KPiANCj4gSSdtIHJlc2VuZGluZyB0aGlzIHBhdGNoIHRv
IHByb3BlciByZWNpcGllbnRzIHRoaXMgdGltZS4gU29ycnkgaWYgdGhlDQo+IHByZXZpb3VzIHN1
Ym1pc3Npb24gY29uZnVzZWQgYW55Ym9keS4NCj4gDQo+ICBkcml2ZXJzL2h3bW9uL3BtYnVzL3Bt
YnVzX2NvcmUuYyB8IDExICsrKysrKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHdtb24v
cG1idXMvcG1idXNfY29yZS5jIGIvZHJpdmVycy9od21vbi9wbWJ1cy9wbWJ1c19jb3JlLmMNCj4g
aW5kZXggZWY3ZWU5MGVlNzg1Li45NGFkYmVkZTc5MTIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
aHdtb24vcG1idXMvcG1idXNfY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvaHdtb24vcG1idXMvcG1i
dXNfY29yZS5jDQo+IEBAIC0yNjgsNiArMjY4LDcgQEAgaW50IHBtYnVzX3VwZGF0ZV9mYW4oc3Ry
dWN0IGkyY19jbGllbnQgKmNsaWVudCwgaW50IHBhZ2UsIGludCBpZCwNCj4gIAlpbnQgcnY7DQo+
ICAJdTggdG87DQo+ICANCj4gKwltdXRleF9sb2NrKCZkYXRhLT51cGRhdGVfbG9jayk7DQo+ICAJ
ZnJvbSA9IHBtYnVzX3JlYWRfYnl0ZV9kYXRhKGNsaWVudCwgcGFnZSwNCj4gIAkJCQkgICAgcG1i
dXNfZmFuX2NvbmZpZ19yZWdpc3RlcnNbaWRdKTsNCj4gIAlpZiAoZnJvbSA8IDApDQo+IEBAIC0y
NzgsMTEgKzI3OSwxNSBAQCBpbnQgcG1idXNfdXBkYXRlX2ZhbihzdHJ1Y3QgaTJjX2NsaWVudCAq
Y2xpZW50LCBpbnQgcGFnZSwgaW50IGlkLA0KPiAgCQlydiA9IHBtYnVzX3dyaXRlX2J5dGVfZGF0
YShjbGllbnQsIHBhZ2UsDQo+ICAJCQkJCSAgIHBtYnVzX2Zhbl9jb25maWdfcmVnaXN0ZXJzW2lk
XSwgdG8pOw0KPiAgCQlpZiAocnYgPCAwKQ0KPiAtCQkJcmV0dXJuIHJ2Ow0KPiArCQkJZ290byBv
dXQ7DQo+ICAJfQ0KPiAgDQo+IC0JcmV0dXJuIF9wbWJ1c193cml0ZV93b3JkX2RhdGEoY2xpZW50
LCBwYWdlLA0KPiAtCQkJCSAgICAgIHBtYnVzX2Zhbl9jb21tYW5kX3JlZ2lzdGVyc1tpZF0sIGNv
bW1hbmQpOw0KPiArCXJ2ID0gX3BtYnVzX3dyaXRlX3dvcmRfZGF0YShjbGllbnQsIHBhZ2UsDQo+
ICsJCQkJICAgIHBtYnVzX2Zhbl9jb21tYW5kX3JlZ2lzdGVyc1tpZF0sIGNvbW1hbmQpOw0KPiAr
DQo+ICtvdXQ6DQo+ICsJbXV0ZXhfbG9jaygmZGF0YS0+dXBkYXRlX2xvY2spOw0KDQpUaGlzIGhh
cyB0byBiZSBtdXRleF91bmxvY2soKS4uLg0KDQo+ICsJcmV0dXJuIHJ2Ow0KPiAgfQ0KPiAgRVhQ
T1JUX1NZTUJPTF9HUEwocG1idXNfdXBkYXRlX2Zhbik7DQoNCi0tIA0KQmVzdCByZWdhcmRzLA0K
QWxleGFuZGVyIFN2ZXJkbGluLg0K
