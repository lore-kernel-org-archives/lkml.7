Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E6FC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B8220811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="lcE6qFSc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfDWLXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:23:51 -0400
Received: from mail-eopbgr60073.outbound.protection.outlook.com ([40.107.6.73]:44613
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726421AbfDWLXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8bp2Vg2B2IQcij5eh7KSQ3+gkwHSkHQ0w4tfIP5Erw=;
 b=lcE6qFScjkCK9NKYavcHBNQ4RTHn2hQgBZeRMdnG5dRN2HE9TewT/xeC3exUHpVpWavTcqx5tPq4zVmh7HfrtTQb4umeZI/Pjd6HKuEkozv/mXpu+Qef0VAIrRcAvpmfEg5wHHMl6eB8ylg/492IN550wPgYlylu5DjtKXI6+Nk=
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com (20.178.13.96) by
 VI1PR08MB4190.eurprd08.prod.outlook.com (20.178.204.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Tue, 23 Apr 2019 11:23:34 +0000
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::11b9:f687:dc3e:68cc]) by VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::11b9:f687:dc3e:68cc%3]) with mapi id 15.20.1813.017; Tue, 23 Apr 2019
 11:23:34 +0000
From:   Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Carlos O'Donell <carlos@redhat.com>
CC:     nd <nd@arm.com>, Florian Weimer <fweimer@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: Re: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup and
 thread creation (v9)
Thread-Topic: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup and
 thread creation (v9)
Thread-Index: AQHU+TS5PBgMBowmREaS0OgGQ5SzCKZJm4sA
Date:   Tue, 23 Apr 2019 11:23:34 +0000
Message-ID: <532096e3-9943-fa20-daff-92bad34a11fc@arm.com>
References: <20190422175623.6134-1-mathieu.desnoyers@efficios.com>
 <20190422175623.6134-2-mathieu.desnoyers@efficios.com>
In-Reply-To: <20190422175623.6134-2-mathieu.desnoyers@efficios.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-originating-ip: [217.140.106.51]
x-clientproxiedby: LO2P123CA0014.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::26) To VI1PR08MB4223.eurprd08.prod.outlook.com
 (2603:10a6:803:b5::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75a98c9b-cd07-41d9-d6fc-08d6c7de1f15
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB4190;
x-ms-traffictypediagnostic: VI1PR08MB4190:
x-ms-exchange-purlcount: 1
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR08MB419019404047AB2529E14239ED230@VI1PR08MB4190.eurprd08.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(39860400002)(136003)(199004)(189003)(8936002)(31686004)(81156014)(72206003)(81166006)(68736007)(8676002)(6512007)(6306002)(25786009)(71200400001)(7736002)(305945005)(478600001)(71190400001)(6436002)(97736004)(6486002)(53936002)(6246003)(4326008)(14454004)(14444005)(486006)(66066001)(2616005)(476003)(65806001)(65956001)(110136005)(58126008)(446003)(11346002)(76176011)(316002)(44832011)(386003)(52116002)(64126003)(186003)(102836004)(53546011)(26005)(6506007)(36756003)(31696002)(99286004)(66556008)(66446008)(64756008)(54906003)(7416002)(5660300002)(66476007)(66946007)(73956011)(65826007)(256004)(2906002)(86362001)(3846002)(6116002)(229853002)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4190;H:VI1PR08MB4223.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9dBfK0CucRuKEzBiV/H/jkvs7bFm3xvdvZBBiRda2z12ki8XA5r23ctbUT2ZfziGOO0MJ8OFCrNlzCpOXERoFj5/bjov1XLUyu+/spdXT0qutvbog8qlsY6GrZTG/s/qhWDVZjg6cOLdRf2rzdSXT2JND2mIcnnbNSZBqy+DGMSr/+2u3doQU+WFgkkooY4adX6PH1gQufyuQNQH88FU2oZd3m20AW7DX2MoHhmdXQx/kUBO6JJ4shMy5a7C6Xu6BD+ArfTfKVFZi2YVHMWJd8Px7Nvfhoeq4R0bR2aid2oz2ZarwBqTkAEWRusLFtqbkHIiQShAOdL/vPAl0fRr/qi/RcMKLmEnWgKVaFB2RcJqMKUW1lPO4FeUOJW3L/ckT+8Qo8lvfB2TMKXfVAIYOGkIo9TKzymuxn1IBK81ATI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47FA7D70368628449F248B19713611EB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a98c9b-cd07-41d9-d6fc-08d6c7de1f15
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 11:23:34.2219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjIvMDQvMjAxOSAxODo1NiwgTWF0aGlldSBEZXNub3llcnMgd3JvdGU6DQo+IGRpZmYgLS1n
aXQgYS9zeXNkZXBzL3VuaXgvc3lzdi9saW51eC9hYXJjaDY0L2JpdHMvcnNlcS5oIGIvc3lzZGVw
cy91bml4L3N5c3YvbGludXgvYWFyY2g2NC9iaXRzL3JzZXEuaA0KPiBuZXcgZmlsZSBtb2RlIDEw
MDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwLi5lNTM4NjY4NjEyDQo+IC0tLSAvZGV2L251bGwNCj4g
KysrIGIvc3lzZGVwcy91bml4L3N5c3YvbGludXgvYWFyY2g2NC9iaXRzL3JzZXEuaA0KPiBAQCAt
MCwwICsxLDQ0IEBADQo+ICsvKiBSZXN0YXJ0YWJsZSBTZXF1ZW5jZXMgTGludXggYWFyY2g2NCBh
cmNoaXRlY3R1cmUgaGVhZGVyLg0KPiArDQo+ICsgICBDb3B5cmlnaHQgKEMpIDIwMTkgRnJlZSBT
b2Z0d2FyZSBGb3VuZGF0aW9uLCBJbmMuDQo+ICsNCj4gKyAgIFRoZSBHTlUgQyBMaWJyYXJ5IGlz
IGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vcg0KPiArICAgbW9k
aWZ5IGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIExlc3NlciBHZW5lcmFsIFB1YmxpYw0K
PiArICAgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlv
bjsgZWl0aGVyDQo+ICsgICB2ZXJzaW9uIDIuMSBvZiB0aGUgTGljZW5zZSwgb3IgKGF0IHlvdXIg
b3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4NCj4gKw0KPiArICAgVGhlIEdOVSBDIExpYnJhcnkg
aXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwNCj4gKyAg
IGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJh
bnR5IG9mDQo+ICsgICBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFS
IFBVUlBPU0UuICBTZWUgdGhlIEdOVQ0KPiArICAgTGVzc2VyIEdlbmVyYWwgUHVibGljIExpY2Vu
c2UgZm9yIG1vcmUgZGV0YWlscy4NCj4gKw0KPiArICAgWW91IHNob3VsZCBoYXZlIHJlY2VpdmVk
IGEgY29weSBvZiB0aGUgR05VIExlc3NlciBHZW5lcmFsIFB1YmxpYw0KPiArICAgTGljZW5zZSBh
bG9uZyB3aXRoIHRoZSBHTlUgQyBMaWJyYXJ5OyBpZiBub3QsIHNlZQ0KPiArICAgPGh0dHA6Ly93
d3cuZ251Lm9yZy9saWNlbnNlcy8+LiAgKi8NCj4gKw0KPiArI2lmbmRlZiBfU1lTX1JTRVFfSA0K
PiArIyBlcnJvciAiTmV2ZXIgdXNlIDxiaXRzL3JzZXEuaD4gZGlyZWN0bHk7IGluY2x1ZGUgPHN5
cy9yc2VxLmg+IGluc3RlYWQuIg0KPiArI2VuZGlmDQo+ICsNCj4gKy8qIFJTRVFfU0lHIGlzIGEg
c2lnbmF0dXJlIHJlcXVpcmVkIGJlZm9yZSBlYWNoIGFib3J0IGhhbmRsZXIgY29kZS4NCj4gKw0K
PiArICAgSXQgaXMgYSAzMi1iaXQgdmFsdWUgdGhhdCBtYXBzIHRvIGFjdHVhbCBhcmNoaXRlY3R1
cmUgY29kZSBjb21waWxlZA0KPiArICAgaW50byBhcHBsaWNhdGlvbnMgYW5kIGxpYnJhcmllcy4g
SXQgbmVlZHMgdG8gYmUgZGVmaW5lZCBmb3IgZWFjaA0KPiArICAgYXJjaGl0ZWN0dXJlLiBXaGVu
IGNob29zaW5nIHRoaXMgdmFsdWUsIGl0IG5lZWRzIHRvIGJlIHRha2VuIGludG8NCj4gKyAgIGFj
Y291bnQgdGhhdCBnZW5lcmF0aW5nIGludmFsaWQgaW5zdHJ1Y3Rpb25zIG1heSBoYXZlIGlsbCBl
ZmZlY3RzIG9uDQo+ICsgICB0b29scyBsaWtlIG9iamR1bXAsIGFuZCBtYXkgYWxzbyBoYXZlIGlt
cGFjdCBvbiB0aGUgQ1BVIHNwZWN1bGF0aXZlDQo+ICsgICBleGVjdXRpb24gZWZmaWNpZW5jeSBp
biBzb21lIGNhc2VzLg0KPiArDQo+ICsgICBhYXJjaDY0IC1tYmlnLWVuZGlhbiBnZW5lcmF0ZXMg
bWl4ZWQgZW5kaWFubmVzcyBjb2RlIHZzIGRhdGE6DQo+ICsgICBsaXR0bGUtZW5kaWFuIGNvZGUg
YW5kIGJpZy1lbmRpYW4gZGF0YS4gRW5zdXJlIHRoZSBSU0VRX1NJRyBzaWduYXR1cmUNCj4gKyAg
IG1hdGNoZXMgY29kZSBlbmRpYW5uZXNzLiAgKi8NCj4gKw0KPiArI2RlZmluZSBSU0VRX1NJR19D
T0RFCTB4ZDQyOGJjMDAJLyogQlJLICMweDQ1RTAuICAqLw0KPiArDQo+ICsjaWZkZWYgX19BQVJD
SDY0RUJfXw0KPiArI2RlZmluZSBSU0VRX1NJR19EQVRBCTB4MDBiYzI4ZDQJLyogQlJLICMweDQ1
RTAuICAqLw0KPiArI2Vsc2UNCj4gKyNkZWZpbmUgUlNFUV9TSUdfREFUQQlSU0VRX1NJR19DT0RF
DQo+ICsjZW5kaWYNCj4gKw0KPiArI2RlZmluZSBSU0VRX1NJRwlSU0VRX1NJR19EQVRBDQo+IGRp
ZmYgLS1naXQgYS9zeXNkZXBzL3VuaXgvc3lzdi9saW51eC9hYXJjaDY0L2xpYmMuYWJpbGlzdCBi
L3N5c2RlcHMvdW5peC9zeXN2L2xpbnV4L2FhcmNoNjQvbGliYy5hYmlsaXN0DQo+IGluZGV4IDlj
MzMwZjMyNWUuLjMzMWYzOWU0MWEgMTAwNjQ0DQo+IC0tLSBhL3N5c2RlcHMvdW5peC9zeXN2L2xp
bnV4L2FhcmNoNjQvbGliYy5hYmlsaXN0DQo+ICsrKyBiL3N5c2RlcHMvdW5peC9zeXN2L2xpbnV4
L2FhcmNoNjQvbGliYy5hYmlsaXN0DQo+IEBAIC0yMTQxLDMgKzIxNDEsNSBAQCBHTElCQ18yLjI4
IHRocmRfeWllbGQgRg0KPiAgR0xJQkNfMi4yOSBnZXRjcHUgRg0KPiAgR0xJQkNfMi4yOSBwb3Np
eF9zcGF3bl9maWxlX2FjdGlvbnNfYWRkY2hkaXJfbnAgRg0KPiAgR0xJQkNfMi4yOSBwb3NpeF9z
cGF3bl9maWxlX2FjdGlvbnNfYWRkZmNoZGlyX25wIEYNCj4gK0dMSUJDXzIuMzAgX19yc2VxX2Fi
aSBUIDB4MjANCj4gK0dMSUJDXzIuMzAgX19yc2VxX2hhbmRsZWQgRCAweDQNCg0KdGhlIGFhcmNo
NjQgY2hhbmdlcyBhcmUgb2suDQo=
