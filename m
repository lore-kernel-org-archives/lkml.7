Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D29C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316802085A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="uT8pihfu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfF0MPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 08:15:23 -0400
Received: from mail-eopbgr70098.outbound.protection.outlook.com ([40.107.7.98]:58646
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726375AbfF0MPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 08:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8findodslxer7wy+E1rpIBYlqiX9tGnvhjqgz1WjvNc=;
 b=uT8pihfunjY65n3AmG2Zv5kq2l01H9viokHDaJSkv2Fw8+HkSn2Ak+pikuZHfnhVZrhQ1e/zZbvl57BSPEnS2xklnZfB7gM9JmIjCAG9aelADZGl400ApyuULiPoDMDqwechkCoVMm84wTgT9BVUjWgUGmkTkPTmrKLIaPYf/j4=
Received: from VI1PR07MB5744.eurprd07.prod.outlook.com (20.177.202.24) by
 VI1PR07MB4159.eurprd07.prod.outlook.com (20.176.6.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.13; Thu, 27 Jun 2019 12:15:17 +0000
Received: from VI1PR07MB5744.eurprd07.prod.outlook.com
 ([fe80::fcde:79c2:8330:b9db]) by VI1PR07MB5744.eurprd07.prod.outlook.com
 ([fe80::fcde:79c2:8330:b9db%6]) with mapi id 15.20.2032.012; Thu, 27 Jun 2019
 12:15:17 +0000
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
Thread-Index: AQHVG6zLWVr+SmJGqUG78zQ8oYIU56avinsAgAACGoA=
Date:   Thu, 27 Jun 2019 12:15:17 +0000
Message-ID: <0643ba97-1b1b-8e14-c2cc-dcdf9cfd8479@nokia.com>
References: <20190605144116.28553-1-alexander.sverdlin@nokia.com>
 <20190605144116.28553-2-alexander.sverdlin@nokia.com>
 <alpine.DEB.2.21.1906231008170.32342@nanos.tec.linutronix.de>
 <df6b6311-ac67-857f-5a81-aee4eabd9f47@nokia.com>
 <alpine.DEB.2.21.1906241135450.32342@nanos.tec.linutronix.de>
 <01ab4388-f259-e801-8c8a-f39b5abcfb52@nokia.com>
 <alpine.DEB.2.21.1906271405400.32342@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1906271405400.32342@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [131.228.32.166]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
x-clientproxiedby: HE1PR05CA0346.eurprd05.prod.outlook.com
 (2603:10a6:7:92::41) To VI1PR07MB5744.eurprd07.prod.outlook.com
 (2603:10a6:803:98::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b69e745e-3aff-4457-0732-08d6faf91d90
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR07MB4159;
x-ms-traffictypediagnostic: VI1PR07MB4159:
x-microsoft-antispam-prvs: <VI1PR07MB4159890533A3E247EE79EB7E88FD0@VI1PR07MB4159.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39860400002)(136003)(366004)(189003)(199004)(8936002)(476003)(65956001)(31696002)(14444005)(256004)(68736007)(14454004)(66066001)(4326008)(26005)(99286004)(31686004)(6506007)(186003)(65806001)(25786009)(386003)(8676002)(53546011)(81166006)(81156014)(102836004)(486006)(52116002)(76176011)(305945005)(11346002)(446003)(316002)(71190400001)(6916009)(6512007)(53936002)(54906003)(71200400001)(7736002)(6436002)(478600001)(6486002)(65826007)(86362001)(58126008)(66446008)(36756003)(5660300002)(64756008)(66946007)(64126003)(66556008)(73956011)(2906002)(3846002)(229853002)(6116002)(6246003)(2616005)(66476007)(473944003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB4159;H:VI1PR07MB5744.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KFWwdeLMqckJhPq3jHZvCs/9YZOgZAwfY8Tc1aCqTkX+yr4s/fOBhTkT8B6VgQFyRhtmfpCIi8NzX4bzhZs7FwaLG6FbDG6fxBkUv3Oo9rfDvqTX3jpuGAJM8aYlYZvIt1moysxhCu8jBRzSIB10Q5YSXW0AnITTO2qmhBwDI6wkC0pJcpyQ/gGTDBI1IuK7CR5j162kJh/yICCbnEXXwC251IRKv77Yo8lFr7ynhfUr/IUF/VT8HZ8Xhg9N2HqeKsqDCpbmx8tFFHcUhc986dc02C34szV1zgb15kb9eqgaoqwFqfz5Jbl02Zp78Ujkge606GkbCpACPn3p+eqWif6qSWPPdG1YS0DvXwgdi1JjKxMqI2c32NZpmWm9+M/xrSpeAY0tMhHgBkGoYIM9aEpRGEaXvV5oGQdza7laL1A=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1375D62CB14F6A438D1BD743DEE339EB@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b69e745e-3aff-4457-0732-08d6faf91d90
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 12:15:17.2900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alexander.sverdlin@nokia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB4159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkhDQoNCk9uIDI3LzA2LzIwMTkgMTQ6MDcsIFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4+Pj4+
IEknbSBpbiB0aGUgcHJvY2VzcyBvZiBtZXJnaW5nIHRoYXQgc2VyaWVzIGFuZCBJIGFjdHVhbGx5
IGFkYXB0ZWQgeW91cg0KPj4+Pj4gc2NoZW1lIHRvIHRoZSBuZXcgdW5pZmllZCBpbmZyYXN0cnVj
dHVyZSB3aGVyZSBpdCBoYXMgZXhhY3RseSB0aGUgc2FtZQ0KPj4+Pj4gZWZmZWN0cyBhcyB3aXRo
IHlvdXIgb3JpZ2luYWwgcGF0Y2hlcyBhZ2FpbnN0IHRoZSB4ODYgdmVyc2lvbi4NCj4+Pj4gcGxl
YXNlIGxldCBtZSBrbm93IGlmIEkgbmVlZCB0byByZXdvcmsgWzIvMl0gYmFzZWQgb24gc29tZSBu
b3QteWV0LXB1Ymxpc2hlZA0KPj4+PiBicmFuY2ggb2YgeW91cnMuDQo+Pj4gSSd2ZSBwdXNoZWQg
aXQgb3V0IG5vdyB0bw0KPj4+DQo+Pj4gICAgICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvdGlwL3RpcC5naXQgdGltZXJzL3Zkc28NCj4+Pg0KPj4+IFRoZSBn
ZW5lcmljIFZEU08gbGlicmFyeSBoYXMgdGhlIHN1cHBvcnQgZm9yIFJBVyBhbHJlYWR5IHdpdGgg
dGhhdCBzZXBhcmF0ZQ0KPj4+IGFycmF5LiBUZXN0aW5nIHdvdWxkIGJlIHdlbGNvbWVkIQ0KPj4N
Cj4+IFRoYW5rcyBmb3IgeW91ciBhbmQgVmluY2Vuem8ncyBlZmZvcnRzIQ0KPj4gSSd2ZSBhcHBs
aWVkIHRoZSBzZXJpZXMgb250byA1LjIuMC1yYzYgYW5kIGRpZCBhIHF1aWNrIHRlc3Qgb24gYSBi
YXJlIHg4Nl82NCBhbmQNCj4+IGZvciBtZSBpdCBsb29rcyBnb29kOg0KPiANCj4gRGlkIHlvdSB1
c2UgdGhlIGdpdCB0cmVlPyBJZiBub3QsIGl0IHdvdWxkIGJlIGludGVyZXN0aW5nIHRvIGhhdmUg
YSB0ZXN0DQo+IGFnYWluc3QgdGhhdCBhcyB3ZWxsIGJlY2F1c2UgdGhhdCdzIHRoZSBmaW5hbCB2
ZXJzaW9uLg0KDQpJJ3ZlIGFwcGxpZWQgdGhlIGZvbGxvd2luZyBsaXN0Og0KDQozMmUyOTM5NmYw
MGUgaHJ0aW1lcjogU3BsaXQgb3V0IGhydGltZXIgZGVmaW5lcyBpbnRvIHNlcGFyYXRlIGhlYWRl
cg0KMzYxZjhhZWU5YjA5IHZkc286IERlZmluZSBzdGFuZGFyZGl6ZWQgdmRzb19kYXRhcGFnZQ0K
MDBiMjY0NzRjMmYxIGxpYi92ZHNvOiBQcm92aWRlIGdlbmVyaWMgVkRTTyBpbXBsZW1lbnRhdGlv
bg0KNjI5ZmRmNzdhYzQ1IGxpYi92ZHNvOiBBZGQgY29tcGF0IHN1cHBvcnQNCjQ0ZjU3ZDc4OGU3
ZCB0aW1la2VlcGluZzogUHJvdmlkZSBhIGdlbmVyaWMgdXBkYXRlX3ZzeXNjYWxsKCkgaW1wbGVt
ZW50YXRpb24NCjI4YjFhODI0YTRmNCBhcm02NDogdmRzbzogU3Vic3RpdHV0ZSBnZXR0aW1lb2Zk
YXkoKSB3aXRoIEMgaW1wbGVtZW50YXRpb24NCjk4Y2QzYzNmODNmYiBhcm02NDogdmRzbzogQnVp
bGQgdkRTTyB3aXRoIC1mZml4ZWQteDE4DQo1M2M0ODllMWRmZWIgYXJtNjQ6IGNvbXBhdDogQWRk
IG1pc3Npbmcgc3lzY2FsbCBudW1iZXJzDQoyMDZjMGRmYTNjNTUgYXJtNjQ6IGNvbXBhdDogRXhw
b3NlIHNpZ25hbCByZWxhdGVkIHN0cnVjdHVyZXMNCmYxNGQ4MDI1ZDI2MyBhcm02NDogY29tcGF0
OiBHZW5lcmF0ZSBhc20gb2Zmc2V0cyBmb3Igc2lnbmFscw0KYTdmNzFhMmM4OTAzIGFybTY0OiBj
b21wYXQ6IEFkZCB2RFNPDQpjN2FhMmQ3MTAyMGQgYXJtNjQ6IHZkc286IFJlZmFjdG9yIHZEU08g
Y29kZQ0KN2MxZGVlZWIwMTMwIGFybTY0OiBjb21wYXQ6IFZEU08gc2V0dXAgZm9yIGNvbXBhdCBs
YXllcg0KMWUzZjE3ZjU1YWVjIGFybTY0OiBlbGY6IFZEU08gY29kZSBwYWdlIGRpc2NvdmVyeQ0K
ZjAxNzAzYjNkMmU2IGFybTY0OiBjb21wYXQ6IEdldCBzaWdyZXR1cm4gdHJhbXBvbGluZXMgZnJv
bSB2RFNPDQpiZmU4MDFlYmU4NGYgYXJtNjQ6IHZkc286IEVuYWJsZSB2RFNPIGNvbXBhdCBzdXBw
b3J0DQo3YWM4NzA3NDc5ODggeDg2L3Zkc286IFN3aXRjaCB0byBnZW5lcmljIHZEU08gaW1wbGVt
ZW50YXRpb24NCmY2NjUwMWRjNTNlNyB4ODYvdmRzbzogQWRkIGNsb2NrX2dldHJlcygpIGVudHJ5
IHBvaW50DQoyMmNhOTYyMjg4YzAgKHRpcC9XSVAudmRzbykgeDg2L3Zkc286IEFkZCBjbG9ja19n
ZXR0aW1lNjQoKSBlbnRyeSBwb2ludA0KZWNmOWRiM2QxZjFhIHg4Ni92ZHNvOiBHaXZlIHRoZSBb
cGhddmNsb2NrX3BhZ2UgZGVjbGFyYXRpb25zIHJlYWwgdHlwZXMNCmVkNzVlOGY2MGJiMSB2ZHNv
OiBSZW1vdmUgc3VwZXJmbHVvdXMgI2lmZGVmIF9fS0VSTkVMX18gaW4gdmRzby9kYXRhcGFnZS5o
DQo5NGZlZTRkNDM3NTIgYXJtNjQ6IHZkc286IFJlbW92ZSB1bm5lY2Vzc2FyeSBhc20tb2Zmc2V0
cy5jIGRlZmluaXRpb25zDQo2YTViNzhiMzJkMTAgYXJtNjQ6IGNvbXBhdDogTm8gbmVlZCBmb3Ig
cHJlLUFSTXY3IGJhcnJpZXJzIG9uIGFuIEFSTXY4IHN5c3RlbQ0KZTcwOTgwMzEyYTk0IE1BSU5U
QUlORVJTOiBBZGQgZW50cnkgZm9yIHRoZSBnZW5lcmljIFZEU08gbGlicmFyeQ0KOWQ5MGI5M2Jm
MzI1IGxpYi92ZHNvOiBNYWtlIGRlbHRhIGNhbGN1bGF0aW9uIHdvcmsgY29ycmVjdGx5DQoyN2Ux
MWE5ZmUyZTIgYXJtNjQ6IEZpeCBfX2FyY2hfZ2V0X2h3X2NvdW50ZXIoKSBpbXBsZW1lbnRhdGlv
bg0KNjI0MWM0ZGM2ZWM1IGFybTY0OiBjb21wYXQ6IEZpeCBfX2FyY2hfZ2V0X2h3X2NvdW50ZXIo
KSBpbXBsZW1lbnRhdGlvbg0KM2FjZjRiZTIzNTI4ICh0aXAvdGltZXJzL3Zkc28pIGFybTY0OiB2
ZHNvOiBGaXggY29tcGlsYXRpb24gd2l0aCBjbGFuZyBvbGRlciB0aGFuIDgNCg0KSWYgeW91IGV4
cGVjdCBhIGRpZmZlcmVuY2UsIEkgY2FuIHJlLXRlc3QgdXNpbmcgeW91ciB0cmVlIGFzLWlzLg0K
IA0KPj4gTnVtYmVyIG9mIGNsb2NrX2dldHRpbWUoKSBjYWxscyBpbiAxMCBzZWNvbmRzOg0KPj4N
Cj4+IAkJQmVmb3JlCQlBZnRlcgkJRGlmZg0KPj4gTU9OT1RPTklDCTE1MjQwNDMwMAkyMDA4MjU5
NTAJKzMyJQ0KPj4gTU9OT1RPTklDX1JBVwkzODgwNDc4OAkxOTg3NjUwNTMJKzQxMiUNCj4+IFJF
QUxUSU1FCTE1MTY3MjYxOQkyMDEzNzE0NjgJKzMzJQ0KPiANCj4gVGhlIGluY3JlYXNlIGZvciBt
b25vIGFuZCByZWFsdGltZSBpcyBpbXByZXNzaXZlLiBXaGljaCBDUFUgaXMgdGhhdD8NCg0KVGhp
cyB0aW1lIGl0IHdhcw0KDQpwcm9jZXNzb3IJOiAzDQp2ZW5kb3JfaWQJOiBBdXRoZW50aWNBTUQN
CmNwdSBmYW1pbHkJOiAyMQ0KbW9kZWwJCTogOTYNCm1vZGVsIG5hbWUJOiBBTUQgUFJPIEExMC04
NzAwQiBSNiwgMTAgQ29tcHV0ZSBDb3JlcyA0Qys2Rw0Kc3RlcHBpbmcJOiAxDQptaWNyb2NvZGUJ
OiAweDYwMDYxMWENCmNwdSBNSHoJCTogMjYyMi43NzUNCmNhY2hlIHNpemUJOiAxMDI0IEtCDQpw
aHlzaWNhbCBpZAk6IDANCnNpYmxpbmdzCTogNA0KY29yZSBpZAkJOiAzDQpjcHUgY29yZXMJOiAy
DQphcGljaWQJCTogMTkNCmluaXRpYWwgYXBpY2lkCTogMw0KZnB1CQk6IHllcw0KZnB1X2V4Y2Vw
dGlvbgk6IHllcw0KY3B1aWQgbGV2ZWwJOiAxMw0Kd3AJCTogeWVzDQpmbGFncwkJOiBmcHUgdm1l
IGRlIHBzZSB0c2MgbXNyIHBhZSBtY2UgY3g4IGFwaWMgc2VwIG10cnIgcGdlIG1jYSBjbW92IHBh
dCBwc2UzNiBjbGZsdXNoIG1teCBmeHNyIHNzZSBzc2UyIGh0IHN5c2NhbGwgbnggbW14ZXh0IGZ4
c3Jfb3B0IHBkcGUxZ2IgcmR0c2NwIGxtIGNvbnN0YW50X3RzYyByZXBfZ29vZCBhY2NfcG93ZXIg
bm9wbCBub25zdG9wX3RzYyBjcHVpZCBleHRkX2FwaWNpZCBhcGVyZm1wZXJmIHBuaSBwY2xtdWxx
ZHEgbW9uaXRvciBzc3NlMyBmbWEgY3gxNiBzc2U0XzEgc3NlNF8yIG1vdmJlIHBvcGNudCBhZXMg
eHNhdmUgYXZ4IGYxNmMgcmRyYW5kIGxhaGZfbG0gY21wX2xlZ2FjeSBzdm0gZXh0YXBpYyBjcjhf
bGVnYWN5IGFibSBzc2U0YSBtaXNhbGlnbnNzZSAzZG5vd3ByZWZldGNoIG9zdncgaWJzIHhvcCBz
a2luaXQgd2R0IGx3cCBmbWE0IHRjZSBub2RlaWRfbXNyIHRibSB0b3BvZXh0IHBlcmZjdHJfY29y
ZSBwZXJmY3RyX25iIGJwZXh0IHB0c2MgbXdhaXR4IGNwYiBod19wc3RhdGUgc3NiZCBpYnBiIHZt
bWNhbGwgZnNnc2Jhc2UgYm1pMSBhdngyIHNtZXAgYm1pMiB4c2F2ZW9wdCBhcmF0IG5wdCBsYnJ2
IHN2bV9sb2NrIG5yaXBfc2F2ZSB0c2Nfc2NhbGUgdm1jYl9jbGVhbiBmbHVzaGJ5YXNpZCBkZWNv
ZGVhc3Npc3RzIHBhdXNlZmlsdGVyIHBmdGhyZXNob2xkIGF2aWMgdmdpZiBvdmVyZmxvd19yZWNv
dg0KYnVncwkJOiBmeHNhdmVfbGVhayBzeXNyZXRfc3NfYXR0cnMgbnVsbF9zZWcgc3BlY3RyZV92
MSBzcGVjdHJlX3YyIHNwZWNfc3RvcmVfYnlwYXNzDQpib2dvbWlwcwk6IDM1OTQuMDANClRMQiBz
aXplCTogMTUzNiA0SyBwYWdlcw0KY2xmbHVzaCBzaXplCTogNjQNCmNhY2hlX2FsaWdubWVudAk6
IDY0DQphZGRyZXNzIHNpemVzCTogNDggYml0cyBwaHlzaWNhbCwgNDggYml0cyB2aXJ0dWFsDQpw
b3dlciBtYW5hZ2VtZW50OiB0cyB0dHAgdG0gMTAwbWh6c3RlcHMgaHdwc3RhdGUgY3BiIGVmZl9m
cmVxX3JvIGFjY19wb3dlciBbMTNdDQoNCihpdCdzIGRpZmZlcmVudCBmcm9tIHRoZSBvbmUgSSd2
ZSB1c2VkIGZvciBteSBwYXRjaGVzKQ0KDQotLSANCkJlc3QgcmVnYXJkcywNCkFsZXhhbmRlciBT
dmVyZGxpbi4NCg==
