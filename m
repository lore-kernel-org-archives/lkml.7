Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F7BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D57218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ibsDylxQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732169AbfB1JLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 04:11:42 -0500
Received: from mail-eopbgr40101.outbound.protection.outlook.com ([40.107.4.101]:34456
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732032AbfB1JLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 04:11:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8iKke3KNufx1kqFVnH5PwYr1KuRqGCNb810R/PwDDhs=;
 b=ibsDylxQnuuYmbWhGlhtugQGq02A0MxbS7MdF6r82fnkOrXVdJ2Thh/utqZTuObAKCyAm/1fT5oxHGdfy6z5jyo+iVvs/yxEup4ZgRXhMngi95W4RqSAHrQxpEFCYGIR+oNl2BUyJbAWXF1iYP81y4I4/CkKfTOJoCHUMpsIvBg=
Received: from AM6PR08MB3733.eurprd08.prod.outlook.com (20.178.88.82) by
 AM6PR08MB5192.eurprd08.prod.outlook.com (10.255.121.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Thu, 28 Feb 2019 09:11:37 +0000
Received: from AM6PR08MB3733.eurprd08.prod.outlook.com
 ([fe80::34d4:a213:bfd3:8c52]) by AM6PR08MB3733.eurprd08.prod.outlook.com
 ([fe80::34d4:a213:bfd3:8c52%2]) with mapi id 15.20.1643.022; Thu, 28 Feb 2019
 09:11:37 +0000
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Ingo Molnar <mingo@redhat.com>, Al Viro <viro@ZenIV.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: Fix event filters and triggers to handle
 negative numbers
Thread-Topic: [PATCH] tracing: Fix event filters and triggers to handle
 negative numbers
Thread-Index: AQHUOsusUEySyEIyIU6EJDlMMMKxLKTOEtmAgSgCxIA=
Date:   Thu, 28 Feb 2019 09:11:37 +0000
Message-ID: <f0929165-bc75-c13a-7a20-43262ef8a496@virtuozzo.com>
References: <20180823102534.7642-1-ptikhomirov@virtuozzo.com>
 <20180823204849.3b4aede3@vmware.local.home>
In-Reply-To: <20180823204849.3b4aede3@vmware.local.home>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR1001CA0007.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::17) To AM6PR08MB3733.eurprd08.prod.outlook.com
 (2603:10a6:20b:82::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ptikhomirov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45c57fb9-1683-4c18-b285-08d69d5cbe21
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB5192;
x-ms-traffictypediagnostic: AM6PR08MB5192:
x-microsoft-exchange-diagnostics: 1;AM6PR08MB5192;20:/h9VfDn5vOdA9xYQMu7zB4MYmgh/j5HuXchMMuk5b94+ebMI3H07wUGeJu5Q/CMiT4ny5kTNKdW8pLHWpSWqaHA/l1WSwYYNqa96Mo2J9ed6+4AGtVKzRvtKCGjr7tG2OOjoXwXJzlLGxSrstktym/z6B20gwEmhcUhfxpTLWlg=
x-microsoft-antispam-prvs: <AM6PR08MB51921B246DE335EE5DF7C76EB7750@AM6PR08MB5192.eurprd08.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(136003)(366004)(396003)(346002)(376002)(51914003)(189003)(199004)(11346002)(386003)(2906002)(53936002)(446003)(14454004)(68736007)(6512007)(97736004)(6486002)(99286004)(186003)(14444005)(31686004)(76176011)(102836004)(53546011)(486006)(52116002)(8676002)(2616005)(256004)(81156014)(81166006)(6436002)(8936002)(105586002)(36756003)(476003)(106356001)(6506007)(66066001)(316002)(305945005)(478600001)(26005)(54906003)(4326008)(31696002)(7736002)(6246003)(86362001)(229853002)(25786009)(5660300002)(6116002)(3846002)(6916009)(71190400001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB5192;H:AM6PR08MB3733.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iSam/4WerJy9hGpphcFkQecoQlp4vJ3IpFkHfSupoGWxOj5ATBdiChS12UWE6ODWfnSDua8R4pfZT3tboWzTynKXb4FyCvpfCmhFhFXIP+SMplS82JWEUUoVKiJvmW5xV0KuqiFw8ltn2D3HT0SrZiIsAyf4W80OB91R73nHbyZnKbeT1YuTBl84MDDVb+Xxr/6ys01/yzx6Ce2VL3eRqOD/Sp+C4y/As/MN1Icp3DMC1K6jwV3ReGAWibeFKaEkLYp7+4DXERpZSNaScXIN1nYeITlSXzTszyuFUbhdfYQKkqVVhIEEo8mgnroLmVlGfKea2vLJP8qxFiq7W+65majnrgvWCwl077MtP5ikgjwRI+iMuDHwI1yQpw9sLulyKrbrYKtTYBZNY73AncutTjMP1kLePEXnEimZGdIDJxI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FFB77C3F721B1D4C977B0255F6B819FE@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c57fb9-1683-4c18-b285-08d69d5cbe21
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 09:11:36.8653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cGluZywgbG9va3MgbGlrZSB0aGUgcGF0Y2ggd2FzIGxvc3QNCg0KT24gOC8yNC8xOCAzOjQ4IEFN
LCBTdGV2ZW4gUm9zdGVkdCB3cm90ZToNCj4gT24gVGh1LCAyMyBBdWcgMjAxOCAxMzoyNTozNCAr
MDMwMA0KPiBQYXZlbCBUaWtob21pcm92IDxwdGlraG9taXJvdkB2aXJ0dW96em8uY29tPiB3cm90
ZToNCj4gDQo+PiBUaGVuIHRyYWNpbmcgc3lzY2FsbCBleGl0IGV2ZW50IGl0IGlzIGV4dHJlbWVs
eSB1c2VmdWwgdG8gZmlsdGVyIGV4aXQNCj4+IGNvZGVzIGVxdWFsIHRvIHNvbWUgbmVnYXRpdmUg
dmFsdWUsIHRvIHJlYWN0IG9ubHkgdG8gcmVxdWlyZWQgZXJyb3JzLg0KPj4gQnV0IG5lZ2F0aXZl
IG51bWJlcnMgZG9lcyBub3Qgd29yazoNCj4+DQo+PiBbcm9vdEBzbm9yY2ggc3lzX2V4aXRfcmVh
ZF0jIGVjaG8gInJldCA9PSAtMSIgPiBmaWx0ZXINCj4+IGJhc2g6IGVjaG86IHdyaXRlIGVycm9y
OiBJbnZhbGlkIGFyZ3VtZW50DQo+PiBbcm9vdEBzbm9yY2ggc3lzX2V4aXRfcmVhZF0jIGNhdCBm
aWx0ZXINCj4+IHJldCA9PSAtMQ0KPj4gICAgICAgICAgXg0KPj4gcGFyc2VfZXJyb3I6IEludmFs
aWQgdmFsdWUgKGRpZCB5b3UgZm9yZ2V0IHF1b3Rlcyk/DQo+IA0KPiBUaGFua3MgZm9yIHRoZSBw
YXRjaC4gSSdsbCBhcHBseSBpdCBhbmQgdGhlbiBzdGFydCB0ZXN0aW5nIGl0IQ0KPiANCj4gLS0g
U3RldmUNCj4gDQo+Pg0KPj4gU2ltaWxhciB0aGluZyBoYXBwZW5zIHdoZW4gc2V0dGluZyB0cmln
Z2Vycy4NCj4+DQo+PiBUaGVzZSBpcyBhIHJlZ3Jlc3Npb24gaW4gdjQuMTcgaW50cm9kdWNlZCBi
eSB0aGUgY29tbWl0IG1lbnRpb25lZCBiZWxvdywNCj4+IHRlc3Rpbmcgd2l0aG91dCB0aGVzZSBj
b21taXQgc2hvd3Mgbm8gcHJvYmxlbSB3aXRoIG5lZ2F0aXZlIG51bWJlcnMuDQo+Pg0KPj4gRml4
ZXM6IDgwNzY1NTk3YmM1OCAoInRyYWNpbmc6IFJld3JpdGUgZmlsdGVyIGxvZ2ljIHRvIGJlIHNp
bXBsZXIgYW5kIGZhc3RlciIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBQYXZlbCBUaWtob21pcm92IDxw
dGlraG9taXJvdkB2aXJ0dW96em8uY29tPg0KPj4gLS0tDQo+PiAgIGtlcm5lbC90cmFjZS90cmFj
ZV9ldmVudHNfZmlsdGVyLmMgfCA1ICsrKystDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEva2VybmVsL3RyYWNl
L3RyYWNlX2V2ZW50c19maWx0ZXIuYyBiL2tlcm5lbC90cmFjZS90cmFjZV9ldmVudHNfZmlsdGVy
LmMNCj4+IGluZGV4IDg0YTY1MTczYjFlOS4uMmJhNDQ5MjkyNTYxIDEwMDY0NA0KPj4gLS0tIGEv
a2VybmVsL3RyYWNlL3RyYWNlX2V2ZW50c19maWx0ZXIuYw0KPj4gKysrIGIva2VybmVsL3RyYWNl
L3RyYWNlX2V2ZW50c19maWx0ZXIuYw0KPj4gQEAgLTEyOTksNyArMTI5OSw3IEBAIHN0YXRpYyBp
bnQgcGFyc2VfcHJlZChjb25zdCBjaGFyICpzdHIsIHZvaWQgKmRhdGEsDQo+PiAgIAkJLyogZ28g
cGFzdCB0aGUgbGFzdCBxdW90ZSAqLw0KPj4gICAJCWkrKzsNCj4+ICAgDQo+PiAtCX0gZWxzZSBp
ZiAoaXNkaWdpdChzdHJbaV0pKSB7DQo+PiArCX0gZWxzZSBpZiAoaXNkaWdpdChzdHJbaV0pIHx8
IHN0cltpXSA9PSAnLScpIHsNCj4+ICAgDQo+PiAgIAkJLyogTWFrZSBzdXJlIHRoZSBmaWVsZCBp
cyBub3QgYSBzdHJpbmcgKi8NCj4+ICAgCQlpZiAoaXNfc3RyaW5nX2ZpZWxkKGZpZWxkKSkgew0K
Pj4gQEAgLTEzMTIsNiArMTMxMiw5IEBAIHN0YXRpYyBpbnQgcGFyc2VfcHJlZChjb25zdCBjaGFy
ICpzdHIsIHZvaWQgKmRhdGEsDQo+PiAgIAkJCWdvdG8gZXJyX2ZyZWU7DQo+PiAgIAkJfQ0KPj4g
ICANCj4+ICsJCWlmIChzdHJbaV0gPT0gJy0nKQ0KPj4gKwkJCWkrKzsNCj4+ICsNCj4+ICAgCQkv
KiBXZSBhbGxvdyAweERFQURCRUVGICovDQo+PiAgIAkJd2hpbGUgKGlzYWxudW0oc3RyW2ldKSkN
Cj4+ICAgCQkJaSsrOw0KPiANCg0KLS0gDQpCZXN0IHJlZ2FyZHMsIFRpa2hvbWlyb3YgUGF2ZWwN
ClNvZnR3YXJlIERldmVsb3BlciwgVmlydHVvenpvLg0K
