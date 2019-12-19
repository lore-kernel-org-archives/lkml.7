Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F130C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163FC2467E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="V6gy3dUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfLSUND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 15:13:03 -0500
Received: from mail-eopbgr80098.outbound.protection.outlook.com ([40.107.8.98]:7552
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726869AbfLSUNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 15:13:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzPdqcN+aG+PLKpA5pKVHlA+BlIDhc0GsulAUfSWbnDn9c0kuJ0NEx+4Yna/p3/GbPmmLTqFbJhggUan3rqkbdxGZWf9fIaVsv2YVyj+85Y/seAd1Eagh9M3ARKipH/3g7LMMR7HSKnowrHvntN9JDtCc6Sk4kykMwCJYKF9DhCvm/Yhr9ActJ7H2CiLXnqd/ATjFup+ZMJIgITWbx5IgQ0Cti7JsjTUYri945m4qr4yBKnw0/761fhVrKXErytHPn1uiT20e5K30LLRq57dEVnaqdyhNtCHgu7mbIcZnGsdrSTlbR3iaCHq9e7M/IOleSaG0QuSs15ozoo1iv2vXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVyIoMjd6e9+oW+szt9yNpXjjFWiswjKCahbbuAZO9Q=;
 b=UXDTm3iOqx+6nRgatCt9qdqJv+EWUC9KVD/KbCjLtxNqSXSvpEZIqqv8K3OsbCGPhZprhXMdfj96EG+QOjRmqynqEmcXx+v0ZF39qcLYWM18Hv2OgAz7/MfTKRzqa1lIpf73T3rdweA3TfhuvrULXJ2iwiVKPKS9LAgsiUn2yEAA8cBkcyV4WrGmCI34TTiR+84KqWD84AWCWUUFv6819EwJ45qTRK9lrFRxIiKeyXYMFT6keIfGW/MfDHf5QJyNoyggKHoByAl0DhlRnUH4KPL/2c5DcUd7FPsPcKFLM4v5ytAfVIdDdmUAwlt+fztrdrg7geXw2RSDu4eMKR57+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVyIoMjd6e9+oW+szt9yNpXjjFWiswjKCahbbuAZO9Q=;
 b=V6gy3dUaELCLdfJKZFjkDxwCF9FHOimJDEOUSJBi2ANaPZGpjPKs+n4hj78OKjK8+y3dFeL/cDz+DPvfPBb0QinS9avowPhXUikr8lIThEeScfW+qnG93Pi+b6lYz9SHLAkSqhzmleYdYGEKX6Eru9OEYdbf5NIok748pk30/IU=
Received: from VI1PR08MB3472.eurprd08.prod.outlook.com (20.177.60.27) by
 VI1PR08MB3343.eurprd08.prod.outlook.com (52.133.15.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Thu, 19 Dec 2019 20:12:16 +0000
Received: from VI1PR08MB3472.eurprd08.prod.outlook.com
 ([fe80::a99c:2efb:3a9d:7ba3]) by VI1PR08MB3472.eurprd08.prod.outlook.com
 ([fe80::a99c:2efb:3a9d:7ba3%7]) with mapi id 15.20.2559.012; Thu, 19 Dec 2019
 20:12:16 +0000
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "bsegall@google.com" <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>
Subject: [PATCH v3] sched: Micro optimization in pick_next_task() and in
 check_preempt_curr()
Thread-Topic: [PATCH v3] sched: Micro optimization in pick_next_task() and in
 check_preempt_curr()
Thread-Index: AQHVtqibqlxtYhK/6UuTZfgyTrKXFw==
Date:   Thu, 19 Dec 2019 20:12:15 +0000
Message-ID: <47a00e0e-69c0-2a2f-6ae1-1a8ec9b01ede@virtuozzo.com>
References: <20191219113517.65617a7b@gandalf.local.home>
In-Reply-To: <20191219113517.65617a7b@gandalf.local.home>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0350.eurprd05.prod.outlook.com
 (2603:10a6:7:92::45) To VI1PR08MB3472.eurprd08.prod.outlook.com
 (2603:10a6:803:80::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [176.14.212.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63724e70-f5a2-4d04-bbaa-08d784bfbdf9
x-ms-traffictypediagnostic: VI1PR08MB3343:
x-microsoft-antispam-prvs: <VI1PR08MB33435E4213D80105FA5C24F5CD520@VI1PR08MB3343.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39840400004)(376002)(136003)(396003)(199004)(189003)(86362001)(4326008)(2616005)(52116002)(6506007)(81156014)(8676002)(31696002)(8936002)(54906003)(5660300002)(71200400001)(81166006)(316002)(110136005)(478600001)(6486002)(186003)(26005)(6512007)(31686004)(2906002)(36756003)(66946007)(66556008)(64756008)(66446008)(66476007)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB3343;H:VI1PR08MB3472.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZF/8Bvv194TBVW+dhGKjU3RNqyNd1XmcXdylEZaupgPmNTlk2fS/8UasOFOrDzZIUxM3gwjp0TEDxOcbLavCf2wwM+Eq2/cQEOnrTQV4fMeYocDgY4urzHr8WVVrBmizBCuosT7gUS6QL4lXPj7Q/RcRJFOKg/1alyybIVZo6J7d9+BnQYBdYa9tY0jFTno+yIPnaf3dDlj2dd6P+X8bpwNy1+qohGvI+giZlX1i0A1C3wXWnNprSA1VDhfpJEcMUoG9cbBeBbZzOfMNgge44z7+gaSpBzeIOLsQms/PumX8KR7wu7mlEE2J+oMtVxGo0lLj5DHkx9vHFxLnhINfUkf40mfXgGZixrEi6gC2kP0pI/bC20NTbzwrHLlwrAGCMtnu1Nn8F4Ql5seN7u3SmCybOidU2RuwBtMMbJ5U+stM5wIYEZV+CY+AUf6ZIso17D1H61rlD41nREb6WuMx8MYLGX3bsW1RACH9C9LlTHk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1D028DDF0B4064595B78514E3E235C5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63724e70-f5a2-4d04-bbaa-08d784bfbdf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 20:12:16.0672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wYML0eHmbgTBU2jD+X1IMNyAYqtN3rJ3EgoGfPJQcQ2Wqq2KJfyClc/7Q5BfozgXMC5ZM7OdiAJShPtJE7UvuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3343
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpbnRyb2R1Y2VzIGFuIG9wdGltaXphdGlvbiBiYXNlZCBvbiB4eHhfc2NoZWRfY2xhc3Mg
YWRkcmVzc2VzDQppbiB0d28gaG90IHNjaGVkdWxlciBmdW5jdGlvbnM6IHBpY2tfbmV4dF90YXNr
KCkgYW5kIGNoZWNrX3ByZWVtcHRfY3VycigpLg0KDQpJdCBpcyBwb3NzaWJsZSB0byBjb21wYXJl
IHBvaW50ZXJzIHRvIHNjaGVkIGNsYXNzZXMgdG8gY2hlY2ssIHdoaWNoDQpvZiB0aGVtIGhhcyBh
IGhpZ2hlciBwcmlvcml0eSwgaW5zdGVhZCBvZiBjdXJyZW50IGl0ZXJhdGlvbnMgdXNpbmcNCmZv
cl9lYWNoX2NsYXNzKCkuDQoNCk9uZSBtb3JlIHJlc3VsdCBvZiB0aGUgcGF0Y2ggaXMgdGhhdCBz
aXplIG9mIG9iamVjdCBmaWxlIGJlY29tZXMgYSBsaXR0bGUNCmxlc3MgKGV4Y2x1ZGluZyBhZGRl
ZCBCVUdfT04oKSwgd2hpY2ggZ29lcyBpbiBfX2luaXQgc2VjdGlvbik6DQoNCiRzaXplIGtlcm5l
bC9zY2hlZC9jb3JlLm8NCiAgICAgICAgIHRleHQgICAgIGRhdGEgICAgICBic3MJICAgIGRlYwkg
ICAgaGV4CWZpbGVuYW1lDQpiZWZvcmU6ICA2NjQ0NiAgICAxODk1NwkgICAgNjc2CSAgODYwNzkJ
ICAxNTAzZglrZXJuZWwvc2NoZWQvY29yZS5vDQphZnRlcjogICA2NjM5OCAgICAxODk1NwkgICAg
Njc2CSAgODYwMzEJICAxNTAwZglrZXJuZWwvc2NoZWQvY29yZS5vDQoNClNpZ25lZC1vZmYtYnk6
IEtpcmlsbCBUa2hhaSA8a3RraGFpQHZpcnR1b3p6by5jb20+DQotLS0NCiBrZXJuZWwvc2NoZWQv
Y29yZS5jIHwgICAyNCArKysrKysrKystLS0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwg
OSBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2tlcm5lbC9z
Y2hlZC9jb3JlLmMgYi9rZXJuZWwvc2NoZWQvY29yZS5jDQppbmRleCAxNTUwOGMyMDJiZjUuLmJl
ZmRkNzE1OGIyNyAxMDA2NDQNCi0tLSBhL2tlcm5lbC9zY2hlZC9jb3JlLmMNCisrKyBiL2tlcm5l
bC9zY2hlZC9jb3JlLmMNCkBAIC0xNDE2LDIwICsxNDE2LDEwIEBAIHN0YXRpYyBpbmxpbmUgdm9p
ZCBjaGVja19jbGFzc19jaGFuZ2VkKHN0cnVjdCBycSAqcnEsIHN0cnVjdCB0YXNrX3N0cnVjdCAq
cCwNCiANCiB2b2lkIGNoZWNrX3ByZWVtcHRfY3VycihzdHJ1Y3QgcnEgKnJxLCBzdHJ1Y3QgdGFz
a19zdHJ1Y3QgKnAsIGludCBmbGFncykNCiB7DQotCWNvbnN0IHN0cnVjdCBzY2hlZF9jbGFzcyAq
Y2xhc3M7DQotDQotCWlmIChwLT5zY2hlZF9jbGFzcyA9PSBycS0+Y3Vyci0+c2NoZWRfY2xhc3Mp
IHsNCisJaWYgKHAtPnNjaGVkX2NsYXNzID09IHJxLT5jdXJyLT5zY2hlZF9jbGFzcykNCiAJCXJx
LT5jdXJyLT5zY2hlZF9jbGFzcy0+Y2hlY2tfcHJlZW1wdF9jdXJyKHJxLCBwLCBmbGFncyk7DQot
CX0gZWxzZSB7DQotCQlmb3JfZWFjaF9jbGFzcyhjbGFzcykgew0KLQkJCWlmIChjbGFzcyA9PSBy
cS0+Y3Vyci0+c2NoZWRfY2xhc3MpDQotCQkJCWJyZWFrOw0KLQkJCWlmIChjbGFzcyA9PSBwLT5z
Y2hlZF9jbGFzcykgew0KLQkJCQlyZXNjaGVkX2N1cnIocnEpOw0KLQkJCQlicmVhazsNCi0JCQl9
DQotCQl9DQotCX0NCisJZWxzZSBpZiAocC0+c2NoZWRfY2xhc3MgPiBycS0+Y3Vyci0+c2NoZWRf
Y2xhc3MpDQorCQlyZXNjaGVkX2N1cnIocnEpOw0KIA0KIAkvKg0KIAkgKiBBIHF1ZXVlIGV2ZW50
IGhhcyBvY2N1cnJlZCwgYW5kIHdlJ3JlIGdvaW5nIHRvIHNjaGVkdWxlLiAgSW4NCkBAIC0zOTE0
LDggKzM5MDQsNyBAQCBwaWNrX25leHRfdGFzayhzdHJ1Y3QgcnEgKnJxLCBzdHJ1Y3QgdGFza19z
dHJ1Y3QgKnByZXYsIHN0cnVjdCBycV9mbGFncyAqcmYpDQogCSAqIGhpZ2hlciBzY2hlZHVsaW5n
IGNsYXNzLCBiZWNhdXNlIG90aGVyd2lzZSB0aG9zZSBsb29zZSB0aGUNCiAJICogb3Bwb3J0dW5p
dHkgdG8gcHVsbCBpbiBtb3JlIHdvcmsgZnJvbSBvdGhlciBDUFVzLg0KIAkgKi8NCi0JaWYgKGxp
a2VseSgocHJldi0+c2NoZWRfY2xhc3MgPT0gJmlkbGVfc2NoZWRfY2xhc3MgfHwNCi0JCSAgICBw
cmV2LT5zY2hlZF9jbGFzcyA9PSAmZmFpcl9zY2hlZF9jbGFzcykgJiYNCisJaWYgKGxpa2VseShw
cmV2LT5zY2hlZF9jbGFzcyA8PSAmZmFpcl9zY2hlZF9jbGFzcyAmJg0KIAkJICAgcnEtPm5yX3J1
bm5pbmcgPT0gcnEtPmNmcy5oX25yX3J1bm5pbmcpKSB7DQogDQogCQlwID0gcGlja19uZXh0X3Rh
c2tfZmFpcihycSwgcHJldiwgcmYpOw0KQEAgLTY1NjksNiArNjU1OCwxMSBAQCB2b2lkIF9faW5p
dCBzY2hlZF9pbml0KHZvaWQpDQogCXVuc2lnbmVkIGxvbmcgcHRyID0gMDsNCiAJaW50IGk7DQog
DQorCUJVR19PTigmaWRsZV9zY2hlZF9jbGFzcyA+ICZmYWlyX3NjaGVkX2NsYXNzIHx8DQorCQkm
ZmFpcl9zY2hlZF9jbGFzcyA+ICZydF9zY2hlZF9jbGFzcyB8fA0KKwkJJnJ0X3NjaGVkX2NsYXNz
ID4gJmRsX3NjaGVkX2NsYXNzIHx8DQorCQkmZGxfc2NoZWRfY2xhc3MgPiAmc3RvcF9zY2hlZF9j
bGFzcyk7DQorDQogCXdhaXRfYml0X2luaXQoKTsNCiANCiAjaWZkZWYgQ09ORklHX0ZBSVJfR1JP
VVBfU0NIRUQNCg0K
