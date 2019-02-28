Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532D9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08AA12184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="ZoMoD6AF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731666AbfB1Ikl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:40:41 -0500
Received: from mail-eopbgr30068.outbound.protection.outlook.com ([40.107.3.68]:32112
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727714AbfB1Ikl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:40:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rv4PzrQxD4/QS4TNAhkMXC4q67VM4knzaAf10qjsTX0=;
 b=ZoMoD6AFscnEybc/hDXLuh3POnAaRhTOTR2QwX3q0fQwseKxKnRxXH6HDC8m0a6vs/cDsDAWXvYY1JeO0wyzWUpptyiR/LkxtlEvp1kFRjhv5BIyZyWSshEqPrTnhKDriKFvqwcbDtZPOn+L4d365M3D+Ma5gMyr8rLJxnP8XUc=
Received: from HE1PR05MB3257.eurprd05.prod.outlook.com (10.170.243.19) by
 HE1PR05MB3354.eurprd05.prod.outlook.com (10.170.243.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Thu, 28 Feb 2019 08:40:35 +0000
Received: from HE1PR05MB3257.eurprd05.prod.outlook.com
 ([fe80::550a:a35e:2062:792a]) by HE1PR05MB3257.eurprd05.prod.outlook.com
 ([fe80::550a:a35e:2062:792a%7]) with mapi id 15.20.1643.022; Thu, 28 Feb 2019
 08:40:35 +0000
From:   Tariq Toukan <tariqt@mellanox.com>
To:     Robert Eshleman <bobbyeshleman@gmail.com>
CC:     Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] net/mlx4: use kzalloc instead of kmalloc
Thread-Topic: [PATCH 1/8] net/mlx4: use kzalloc instead of kmalloc
Thread-Index: AQHUzmMbUgrdV9kWXUGqPZgGsrBPfaX05cEA
Date:   Thu, 28 Feb 2019 08:40:35 +0000
Message-ID: <b691702d-e7d8-226a-f225-75f2e0a810a9@mellanox.com>
References: <cover.1551246708.git.bobbyeshleman@gmail.com>
 <b350ebb5410291e80e12244ccb41b4b4bae31e0c.1551246708.git.bobbyeshleman@gmail.com>
In-Reply-To: <b350ebb5410291e80e12244ccb41b4b4bae31e0c.1551246708.git.bobbyeshleman@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR01CA0068.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::45) To HE1PR05MB3257.eurprd05.prod.outlook.com
 (2603:10a6:7:35::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tariqt@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ea472aa-f765-4773-bf8d-08d69d586828
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR05MB3354;
x-ms-traffictypediagnostic: HE1PR05MB3354:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtIRTFQUjA1TUIzMzU0OzIzOm8zSTVaV2hYOGVFNVJIZU1hNUZXM3pyUmxN?=
 =?utf-8?B?M29nKzlRTjVyRDZSYks2WFdNZU5lSHNjb1B1ZWxDM2M0YWZFYVJVU082dVAr?=
 =?utf-8?B?T05RYXBPUjU5MnJPNFFCTUVWVE5rM3hlaStHdlVlYUQ5MWFhMEJFakMybUtV?=
 =?utf-8?B?UHF5SVlXT3JxUGh0b1dOd3g4WEZ2Wm5ZcVVWUzRYeTQ1U2tlYUZFZWI5MENJ?=
 =?utf-8?B?bkVOMkhBeU1hUXkvNEs4WjhROXREVnFyeC9BT3ZzY0ZINlhtNkF0T2JsNGtV?=
 =?utf-8?B?UVVpc1lYVHJOUUYzSERPa0NPWGJqL2ZEcFNGZEVjNXY1T1k5aEhKY0JjL3g5?=
 =?utf-8?B?d1kvZVgyRUdQNXB2aTFCd01NSzNsQjFMSUl1a3lVUVQrMFRNWHFTYzVnNmpX?=
 =?utf-8?B?OHpkTnFqZElvY2JuTzRIaUdoZlNBR1hDdzFScWxFd3RwV3hVYnNzUG96Vk1K?=
 =?utf-8?B?UmwreVduU1h5T2N3Z0pPa09iTzkzVkd5TjZNd1FRYXJ1aStaRG5RWXlwcU9H?=
 =?utf-8?B?YVlIcXhxeWdzRnNjajZEYzFFcXFEY1BtcEhwRTNNWXhwNUsxNlA3Z2dZSkNz?=
 =?utf-8?B?R3NZdVVRWTRBcEEvUStQZ09yTXdodzZzV0U2REc0Z1l0ZGJ5ODVsa3p0R1BW?=
 =?utf-8?B?Q2wybXhzZW9KaWNWOTAvWWtHVUZpVUphKzdYTisreEdld0RhRFNhUmRpNUhk?=
 =?utf-8?B?cHEwbDByeGVYZzdseklzcXZVZnJTSjZkQW02SWtLQnFsQkV5RGl0NWxWR2Rq?=
 =?utf-8?B?YytIV2hBZUxGK1F6TnVCK0xwa2V1aGtUTlFRbHNDUGgyeW1PbGJZYTZESXFr?=
 =?utf-8?B?dFpsSjcwZitJeXYyaFdqSjdQRjNSdTZiYncxSEFqQVUwWkRMM1dBdVJUNm5P?=
 =?utf-8?B?djVDNWFkTy9QMFFMOEloOURGR2tUQTBtK2JOUUxXeVVKRmU0UERUWEhabGpw?=
 =?utf-8?B?REVzVnJnYW50TWlwVi9OSHVZTWIrSE9RTGU1bHJJenI5Sm9lMTlaSVZxUWpI?=
 =?utf-8?B?b1B4K3RUcGdwK0xWVmZla2hTM1Q1N0sxWDhWR3VkVUR6MzNvbWJDZWYyUHMr?=
 =?utf-8?B?Y0txQzVENytQTittZjFyY3pEcElBeGpreWlwZnpxL2FZdm9EbmxwT2JCd3I0?=
 =?utf-8?B?allGSy9Gd2cwWVNWQ29SYThSenRVbmNGU2MzQUdmVFNTeEJ6WU9sVlczSnNM?=
 =?utf-8?B?V0kydDg2MXhycVhhNWplNGtBZDRBMmdYU0Q1b0NjOExSTmNWaW5JRnpjTHRT?=
 =?utf-8?B?c3ZqNW1FWktxNW5hM3BFd2hGaE1McFVqZkFkSkdXTHltaGJtVUF2ZWFaK29n?=
 =?utf-8?B?b3BKL2ptL2Q5d2VFWnJFdzl0cDJkdDFrTGpMWkh2ZWYxUXQ5bVUydTh1K0ZJ?=
 =?utf-8?B?d0RiNGwwWE9CRXFVVzg4WCtBM0Z1S3lKanA4c3dyVG02Wm41dVpxbmxHdkts?=
 =?utf-8?B?OGFkRTY0MzNoZ21LQXZLQU9YOVU1SGhDaXFHWnRKUjZsSmZrVzlPaGtNaHN5?=
 =?utf-8?B?NncvU0haSHhwcEIxUnVqY2tXU1ZpaWlJSEVZK0Zud3B3VUd2YmtkQUxRcXZh?=
 =?utf-8?B?WkN6ZHRWZWRLdEFLWXJQcloyVldyaFZST2VXK1NhcnZFcmdGN3BFU1pVTEdH?=
 =?utf-8?B?cmxsRERzeHFKdS9SbTBGbUpwcHdjcGtGSS9jclNKakFwTHdvLzdpUitRbUMz?=
 =?utf-8?B?b3RmNkxETjZ4eDdzMHVQMldURzNtVzR3WEdFQjEzbENiNTAvODdJVFVZY0xX?=
 =?utf-8?B?SkF6OXU3ZkNWQXRtRVBlUT09?=
x-microsoft-antispam-prvs: <HE1PR05MB3354FBDA24B8B679E6060E4AAE750@HE1PR05MB3354.eurprd05.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(396003)(366004)(346002)(199004)(189003)(8936002)(26005)(71200400001)(71190400001)(2906002)(102836004)(54906003)(386003)(478600001)(5660300002)(6506007)(99286004)(6512007)(53936002)(66066001)(76176011)(53546011)(68736007)(86362001)(6436002)(1411001)(52116002)(31696002)(97736004)(316002)(81166006)(36756003)(2616005)(11346002)(305945005)(486006)(7736002)(81156014)(476003)(186003)(229853002)(8676002)(6116002)(446003)(6486002)(3846002)(25786009)(6916009)(256004)(6246003)(106356001)(4326008)(14454004)(31686004)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB3354;H:HE1PR05MB3257.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fjgyHUw4t+DGmGy8WT3XslBD2sBCdIOwADZsWJady8ZWeL+835b29qHBVOG2krFOLXkx5nPWI2NdxamPxv0D4tW+0f4bTX+VKUmV0wHqR/d0WZGPgGJApj3InbuN3CihxCKZ3nTRtFiRAHzX/Q0SqZC+x9iAqnIf5GmcTNrX5UZ20jf/sb2gBETeYzQoE1zxfD7tfBrV2AyTw1i5SF/Xq34SM2LUIYKBFEcaeji2CMhyatG+/fi0SyYkqRBx3cAQTM1i9Gb6CEQ1y11pj/lqrQU9F8JmPwaGrVoB9+y8OJO87P+0GF2n428TR1bc1t1ARBGyxenqYkjQy4Yg0BN6ea7BTI2LkuoUbx+OENgSh6lgLGn3vUKRrKdXZ5zEPTT/w5gwFCplynpnov+q8apGgXfwBFifBqOkSWjFwKb2Ibc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <459F25E69B8C3D4BB6E8DB80B977D26D@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea472aa-f765-4773-bf8d-08d69d586828
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 08:40:34.1902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB3354
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIvMjcvMjAxOSA4OjA5IEFNLCBSb2JlcnQgRXNobGVtYW4gd3JvdGU6DQo+IFRoaXMg
cGF0Y2ggcmVwbGFjZXMgYSBrbWFsbG9jL21lbXNldCgsMCkgY2FsbCB3aXRoIGEgY2FsbCB0byBr
emFsbG9jLg0KPiBJdCBhbHNvIHJlbW92ZXMgYSBtZW1zZXQoLDApIGNhbGwgdGhhdCBhbHdheXMg
Zm9sbG93cyBhICp6YWxsb2MgY2FsbC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJvYmVydCBFc2hs
ZW1hbiA8Ym9iYnllc2hsZW1hbkBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvbmV0L2V0
aGVybmV0L21lbGxhbm94L21seDQvY21kLmMgICB8IDEgLQ0KPiAgIGRyaXZlcnMvbmV0L2V0aGVy
bmV0L21lbGxhbm94L21seDQvZW5fcnguYyB8IDMgKy0tDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg0L2NtZC5jIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQv
bWVsbGFub3gvbWx4NC9jbWQuYw0KPiBpbmRleCBlNjViYzNjOTU2MzAuLjdiZmE2ZTg1MGU1ZiAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NC9jbWQuYw0K
PiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg0L2NtZC5jDQo+IEBAIC0z
MzA3LDcgKzMzMDcsNiBAQCBpbnQgbWx4NF9nZXRfY291bnRlcl9zdGF0cyhzdHJ1Y3QgbWx4NF9k
ZXYgKmRldiwgaW50IGNvdW50ZXJfaW5kZXgsDQo+ICAgCWlmIChJU19FUlIobWFpbGJveCkpDQo+
ICAgCQlyZXR1cm4gUFRSX0VSUihtYWlsYm94KTsNCj4gICANCj4gLQltZW1zZXQobWFpbGJveC0+
YnVmLCAwLCBzaXplb2Yoc3RydWN0IG1seDRfY291bnRlcikpOw0KPiAgIAlpZl9zdGF0X2luX21v
ZCA9IGNvdW50ZXJfaW5kZXg7DQo+ICAgCWlmIChyZXNldCkNCj4gICAJCWlmX3N0YXRfaW5fbW9k
IHw9IE1MWDRfUVVFUllfSUZfU1RBVF9SRVNFVDsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L2V0aGVybmV0L21lbGxhbm94L21seDQvZW5fcnguYyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21l
bGxhbm94L21seDQvZW5fcnguYw0KPiBpbmRleCA5YTA4ODFjYjdmNTEuLmY1NTgwNWQyMDZlZiAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NC9lbl9yeC5j
DQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDQvZW5fcnguYw0KPiBA
QCAtMTA0NCw3ICsxMDQ0LDcgQEAgc3RhdGljIGludCBtbHg0X2VuX2NvbmZpZ19yc3NfcXAoc3Ry
dWN0IG1seDRfZW5fcHJpdiAqcHJpdiwgaW50IHFwbiwNCj4gICAJc3RydWN0IG1seDRfcXBfY29u
dGV4dCAqY29udGV4dDsNCj4gICAJaW50IGVyciA9IDA7DQo+ICAgDQo+IC0JY29udGV4dCA9IGtt
YWxsb2Moc2l6ZW9mKCpjb250ZXh0KSwgR0ZQX0tFUk5FTCk7DQo+ICsJY29udGV4dCA9IGt6YWxs
b2Moc2l6ZW9mKCpjb250ZXh0KSwgR0ZQX0tFUk5FTCk7DQo+ICAgCWlmICghY29udGV4dCkNCj4g
ICAJCXJldHVybiAtRU5PTUVNOw0KPiAgIA0KPiBAQCAtMTA1NSw3ICsxMDU1LDYgQEAgc3RhdGlj
IGludCBtbHg0X2VuX2NvbmZpZ19yc3NfcXAoc3RydWN0IG1seDRfZW5fcHJpdiAqcHJpdiwgaW50
IHFwbiwNCj4gICAJfQ0KPiAgIAlxcC0+ZXZlbnQgPSBtbHg0X2VuX3NxcF9ldmVudDsNCj4gICAN
Cj4gLQltZW1zZXQoY29udGV4dCwgMCwgc2l6ZW9mKCpjb250ZXh0KSk7DQo+ICAgCW1seDRfZW5f
ZmlsbF9xcF9jb250ZXh0KHByaXYsIHJpbmctPmFjdHVhbF9zaXplLCByaW5nLT5zdHJpZGUsIDAs
IDAsDQo+ICAgCQkJCXFwbiwgcmluZy0+Y3FuLCAtMSwgY29udGV4dCk7DQo+ICAgCWNvbnRleHQt
PmRiX3JlY19hZGRyID0gY3B1X3RvX2JlNjQocmluZy0+d3FyZXMuZGIuZG1hKTsNCj4gDQoNCkhp
LA0KDQpUaGFua3MgZm9yIHlvdXIgcGF0Y2guDQpJdCBsb29rcyBnb29kLCBidXQgbWlzc2VzIG9u
ZSBzaW1pbGFyIHBvaW50IHlvdSBtaWdodCB3YW50IHRvIGNvdmVyOg0KDQppbiBkcml2ZXJzL25l
dC9ldGhlcm5ldC9tZWxsYW5veC9tbHg0L3BvcnQuYzoxNzgwIDoNCm1lbXNldChjb250ZXh0LCAw
LCBzaXplb2YoKmNvbnRleHQpKTsNCg0KVGFyaXENCg==
