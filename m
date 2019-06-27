Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D940C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279D72086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="lJt6ePZx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfF0MAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 08:00:52 -0400
Received: from mail-eopbgr130121.outbound.protection.outlook.com ([40.107.13.121]:32686
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726370AbfF0MAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 08:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZJ3sdBUpQGM6x7cByIU/T64prVFX7sbj130RPguZ7c=;
 b=lJt6ePZxkzM8RqOMrT2iCXJ2vbkxszX+zjj/jABhY0cPIqGplTE2NrnjSv00oQuMunvZGClyjLq2u4WXs2qrhkJjSB35jRUEVNM7q58tGOFxxcmNQpPlCsA5uWv/U6Ycevz3Y9ku0AjN/wj2cTG5AbSeFw0pViaPQLrP0yb7TK8=
Received: from VI1PR07MB5744.eurprd07.prod.outlook.com (20.177.202.24) by
 VI1PR07MB4141.eurprd07.prod.outlook.com (52.134.25.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.12; Thu, 27 Jun 2019 12:00:48 +0000
Received: from VI1PR07MB5744.eurprd07.prod.outlook.com
 ([fe80::fcde:79c2:8330:b9db]) by VI1PR07MB5744.eurprd07.prod.outlook.com
 ([fe80::fcde:79c2:8330:b9db%6]) with mapi id 15.20.2032.012; Thu, 27 Jun 2019
 12:00:48 +0000
From:   "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jason Vas Dias <jason.vas.dias@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v3 1/2] x86/vdso: Move mult and shift into struct vgtod_ts
Thread-Topic: [PATCH v3 1/2] x86/vdso: Move mult and shift into struct
 vgtod_ts
Thread-Index: AQHVG6zLWVr+SmJGqUG78zQ8oYIU5w==
Date:   Thu, 27 Jun 2019 12:00:48 +0000
Message-ID: <01ab4388-f259-e801-8c8a-f39b5abcfb52@nokia.com>
References: <20190605144116.28553-1-alexander.sverdlin@nokia.com>
 <20190605144116.28553-2-alexander.sverdlin@nokia.com>
 <alpine.DEB.2.21.1906231008170.32342@nanos.tec.linutronix.de>
 <df6b6311-ac67-857f-5a81-aee4eabd9f47@nokia.com>
 <alpine.DEB.2.21.1906241135450.32342@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1906241135450.32342@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [131.228.32.166]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
x-clientproxiedby: HE1PR0102CA0055.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::32) To VI1PR07MB5744.eurprd07.prod.outlook.com
 (2603:10a6:803:98::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2eb75544-0d10-468a-863b-08d6faf7179f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR07MB4141;
x-ms-traffictypediagnostic: VI1PR07MB4141:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR07MB41417B125E79FBB131FBA1BE88FD0@VI1PR07MB4141.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(396003)(366004)(346002)(376002)(199004)(189003)(6116002)(316002)(256004)(58126008)(3846002)(54906003)(68736007)(31686004)(2616005)(446003)(11346002)(53546011)(486006)(52116002)(102836004)(99286004)(476003)(76176011)(26005)(6916009)(386003)(186003)(6506007)(36756003)(65826007)(25786009)(86362001)(4326008)(5660300002)(6436002)(53936002)(6246003)(7736002)(81166006)(64126003)(6512007)(2906002)(6306002)(81156014)(66946007)(66556008)(66476007)(73956011)(66446008)(65806001)(65956001)(66066001)(64756008)(71200400001)(71190400001)(31696002)(966005)(229853002)(305945005)(14454004)(8676002)(8936002)(478600001)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB4141;H:VI1PR07MB5744.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qEb0eYsGBxMFtGzAckQe+41gC6QWZQ04nfoUp5KDMNAwHZeCSp3yKgwE3VW1uxVxMLXAM+/APNTOlZ816qWXH7VyTe2473PVAyNDoOofO0w5IJqt8w64gKYCcBNTKSO+UN/xLx3n/2Zc4TPwbfLoN/uZw4xed68Qdqo5XbedfOtjdVyPeRh7s6RK6RtjjQwD3jPWB/R62wkDh1X/629wCYkUL3fIcX0CvsI9tYGxRgL7Egt4u6xgIQ15cHkvSwtsl2hcD0La6Rx1esBIj6ix2yMpqIQ8MMjRVeVZSE9PRvEycNkq6dJYM82MK0iZgwo5VN7X9mNf0NG5oOaavlHctNtMUEXw+TCd+P/ONdC2kLILk3k16fewGiNycCThgM3hI7xE4qFle7Fr072ZoQBi9JN2USiLiC4eNcvkMLbwxA0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B54CC324438C6A47B1FE70C108801092@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb75544-0d10-468a-863b-08d6faf7179f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 12:00:48.2249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alexander.sverdlin@nokia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB4141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gVGhvbWFzIQ0KDQpPbiAyNC8wNi8yMDE5IDExOjQwLCBUaG9tYXMgR2xlaXhuZXIgd3Jv
dGU6DQo+Pj4gVGhlIGFsdGVybmF0aXZlIHNvbHV0aW9uIGZvciB0aGlzIGlzIHdoYXQgVmluY2Vu
em8gaGFzIGluIGhpcyB1bmlmaWVkIFZEU08NCj4+PiBwYXRjaCBzZXJpZXM6DQo+Pj4NCj4+PiAg
IGh0dHBzOi8vbGttbC5rZXJuZWwub3JnL3IvMjAxOTA2MjEwOTUyNTIuMzIzMDctMS12aW5jZW56
by5mcmFzY2lub0Bhcm0uY29tDQo+Pj4NCj4+PiBJdCBsZWF2ZXMgdGhlIGRhdGEgc3RydWN0IHVu
bW9kaWZpZWQgYW5kIGhhcyBhIHNlcGFyYXRlIGFycmF5IGZvciB0aGUgcmF3DQo+Pj4gY2xvY2su
IFRoYXQgZG9lcyBub3QgaGF2ZSB0aGUgc2lkZSBlZmZlY3RzIGF0IGFsbC4NCj4+Pg0KPj4+IEkn
bSBpbiB0aGUgcHJvY2VzcyBvZiBtZXJnaW5nIHRoYXQgc2VyaWVzIGFuZCBJIGFjdHVhbGx5IGFk
YXB0ZWQgeW91cg0KPj4+IHNjaGVtZSB0byB0aGUgbmV3IHVuaWZpZWQgaW5mcmFzdHJ1Y3R1cmUg
d2hlcmUgaXQgaGFzIGV4YWN0bHkgdGhlIHNhbWUNCj4+PiBlZmZlY3RzIGFzIHdpdGggeW91ciBv
cmlnaW5hbCBwYXRjaGVzIGFnYWluc3QgdGhlIHg4NiB2ZXJzaW9uLg0KPj4gcGxlYXNlIGxldCBt
ZSBrbm93IGlmIEkgbmVlZCB0byByZXdvcmsgWzIvMl0gYmFzZWQgb24gc29tZSBub3QteWV0LXB1
Ymxpc2hlZA0KPj4gYnJhbmNoIG9mIHlvdXJzLg0KPiBJJ3ZlIHB1c2hlZCBpdCBvdXQgbm93IHRv
DQo+IA0KPiAgICAgIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC90aXAvdGlwLmdpdCB0aW1lcnMvdmRzbw0KPiANCj4gVGhlIGdlbmVyaWMgVkRTTyBsaWJyYXJ5
IGhhcyB0aGUgc3VwcG9ydCBmb3IgUkFXIGFscmVhZHkgd2l0aCB0aGF0IHNlcGFyYXRlDQo+IGFy
cmF5LiBUZXN0aW5nIHdvdWxkIGJlIHdlbGNvbWVkIQ0KDQpUaGFua3MgZm9yIHlvdXIgYW5kIFZp
bmNlbnpvJ3MgZWZmb3J0cyENCkkndmUgYXBwbGllZCB0aGUgc2VyaWVzIG9udG8gNS4yLjAtcmM2
IGFuZCBkaWQgYSBxdWljayB0ZXN0IG9uIGEgYmFyZSB4ODZfNjQgYW5kDQpmb3IgbWUgaXQgbG9v
a3MgZ29vZDoNCg0KTnVtYmVyIG9mIGNsb2NrX2dldHRpbWUoKSBjYWxscyBpbiAxMCBzZWNvbmRz
Og0KDQoJCUJlZm9yZQkJQWZ0ZXIJCURpZmYNCk1PTk9UT05JQwkxNTI0MDQzMDAJMjAwODI1OTUw
CSszMiUNCk1PTk9UT05JQ19SQVcJMzg4MDQ3ODgJMTk4NzY1MDUzCSs0MTIlDQpSRUFMVElNRQkx
NTE2NzI2MTkJMjAxMzcxNDY4CSszMyUNCg0KDQotLSANCkJlc3QgcmVnYXJkcywNCkFsZXhhbmRl
ciBTdmVyZGxpbi4NCg==
