Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C129C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE6A20675
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UukdD1Yl";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OMiEtW+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfDOJhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:37:15 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:26128 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfDOJhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 05:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555321035; x=1586857035;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=uVc0rYrF6bkwZJkr0j51meyFXSxPSJ7x7pN5wFNzDPE=;
  b=UukdD1Ylu3QrOK2YTToHVNQ20oyXXhVpYYdJUmRXwYahSvtlCJF+y0Ok
   oOQwqPW3U0BSzBg9Esq29CsOBdHuIwmz6LDWbDFLzHjhS/jT661PxXJ26
   GqIblscjMKaSy+TeW7kFf/VOqO4WvJz3/t5qp3mEo5ZFeUo5m+U6xrgJK
   irB1kh/JYhF7E6LBPh/M9YStrYKUkPqsj3Ch+R8Qm5s0WJd9dgItXdjGf
   bPmqoLKBJ9t79+LdRpQTRN3PFu1Cl4b3A6+TXQK3NYaBP33HWggq4QFdz
   LlDcm283AVF0zu66x19VIEQER9YDLb9s9gKC9gjZr8kLMMwT4SYLi6eQM
   w==;
X-IronPort-AV: E=Sophos;i="5.60,353,1549900800"; 
   d="scan'208";a="107725747"
Received: from mail-bl2nam02lp2059.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.59])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2019 17:37:14 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVc0rYrF6bkwZJkr0j51meyFXSxPSJ7x7pN5wFNzDPE=;
 b=OMiEtW+XtgA74+26qyDhwbeKDthKfS+ar8BT0HvkOTJg18FDWGd6b/oTt2DqeqByCVg9ul6CBw5hjanncqTX5+YZm1asgMeSSqV0h+4i4OIkXIwVDGH/Q8mgpFUzVmUO6Ddzf29GGoAuOmxWdehfGFHaiJhEzf1Rsi2U7Cz0CGU=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5677.namprd04.prod.outlook.com (20.179.20.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Mon, 15 Apr 2019 09:37:12 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2%5]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 09:37:12 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v3 0/3] Allow accessing CSR using CSR number
Thread-Topic: [PATCH v3 0/3] Allow accessing CSR using CSR number
Thread-Index: AQHU827N/wQBBtLuc024oFhZoiTi3Q==
Date:   Mon, 15 Apr 2019 09:37:12 +0000
Message-ID: <20190415093648.7525-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:a03:40::35) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [129.253.179.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c7a71c6-0587-4e54-8a7d-08d6c185efd9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR04MB5677;
x-ms-traffictypediagnostic: MN2PR04MB5677:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MN2PR04MB567722ECF82BD29AE9B8FCED8D2B0@MN2PR04MB5677.namprd04.prod.outlook.com>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(346002)(376002)(39860400002)(199004)(189003)(4326008)(71200400001)(53936002)(71190400001)(26005)(476003)(86362001)(50226002)(186003)(5660300002)(54906003)(3846002)(6116002)(102836004)(97736004)(6512007)(2616005)(6486002)(316002)(105586002)(110136005)(36756003)(486006)(6436002)(2171002)(6506007)(386003)(478600001)(44832011)(8936002)(8676002)(68736007)(72206003)(81166006)(2906002)(7736002)(14444005)(256004)(99286004)(14454004)(25786009)(1076003)(52116002)(66066001)(305945005)(81156014)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5677;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7tlLPd2jDmQdBLW/ULXvdWWe+Ag3/3LNHJ0Ick07wFsTFld7ZnRwITx/Eq6AUpegK1YQlyqu6BcJOmlnNfTSvUWEBUbDyYGmf2vS3HTVI9VWSXiA1V7oOvWIrYj4MjU3GkwnxsRw369Z01NhrnROURXLyCaHRAiq4bBhc+kXzFs3duCz/bfYsAQBrpDpm5bMbp7DZNLBbbuhvQpCwVC2nhKGW9vduSPkQX6AdkD/4CUqAxuMcTz8DgPGijdf/9diWg1LIZbdBUfdat+2v8G6rMm2MGM7hExF2b7vK23gGU4vBYquX2KT1s3JiO6fYKPv41uW4HBn7X0zJ8KS6JGNxHDG7CmRkSE3XCx9OAZNHokOEkX4zfxcDXNo2dpeTzhWrlGK2aUeiFNTFvQ7dvCwhz5/wZAagQdEwCR0hzcHevs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7a71c6-0587-4e54-8a7d-08d6c185efd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 09:37:12.3620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5677
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBzZXJpZXMgYWRkcyBzdXBwb3J0IHRvIGFjY2VzcyBDU1IgdXNpbmcgYm90aCBD
U1IgbmFtZSBhbmQNCkNTUiBudW1iZXJzLg0KDQpBbHNvLCB3ZSBzaG91bGQgcHJlZmVyIGFjY2Vz
c2luZyBDU1JzIHVzaW5nIHRoZWlyIENTUiBudW1iZXJzIGJlY2F1c2U6DQoxLiBJdCBjb21waWxl
cyBmaW5lIHdpdGggb2xkZXIgdG9vbGNoYWlucy4NCjIuIFdlIGNhbiB1c2UgbGF0ZXN0IENTUiBu
YW1lcyBpbiAjZGVmaW5lIG1hY3JvIG5hbWVzIG9mIENTUiBudW1iZXJzDQogICBhcy1wZXIgUklT
Qy1WIHNwZWMuIChlLmcuIHNwdGJyID0+IENTUl9TQVRQLCBzYmFkYWRkciA9PiBDU1JfU1RWQUws
IGV0Yy4pDQozLiBXZSBjYW4gYWNjZXNzIG5ld2x5IGFkZGVkIENTUnMgZXZlbiBpZiB0b29sY2hh
aW4gZG9lcyBub3QgcmVjb2duaXplDQogICBuZXdseSBhZGRlcyBDU1JzIGJ5IG5hbWUuIChlLmcu
IEJTU1RBVFVTLCBCU0lFLCBTU0lQLCBldGMuKQ0KDQpUaGUgcGF0Y2hzZXQgY2FuIGJlIGZvdW5k
IGluIHJpc2N2X2Nzcl9udW1iZXJfdjMgYnJhbmNoIG9mDQpodHRwcy8vZ2l0aHViLmNvbS9hdnBh
dGVsL2xpbnV4LmdpdA0KDQpDaGFuZ2VzIHNpbmNlIHYyOg0KIC0gRHJvcHBlZCBQQVRDSDEgd2hp
Y2ggYWRkZWQgYXNtL2VuY29kaW5nLmgNCiAtIEFkZGVkIG5ldyBQQVRDSDEgd2hpY2ggYmVhdXRp
ZmllcyBhc20vY3NyLmggYnkgdXNpbmcgdGFicyB0bw0KICAgYWxpZ24gbWFjcm8gdmFsdWVzDQoN
CkNoYW5nZXMgc2luY2UgdjE6DQogLSBTcXVhc2ggUEFUQ0gyIGludG8gY3BhdGNoMw0KIC0gQWRk
ZWQgbmV3IFBBVENIMiB0byBhZGQgaW50ZXJydXB0IHJlbGF0ZWQgU0NBVVNFIGRlZmluZXMNCiAg
IGluIGFzbS9lbmNvZGluZy5oDQoNCkFudXAgUGF0ZWwgKDMpOg0KICBSSVNDLVY6IFVzZSB0YWJz
IHRvIGFsaWduIG1hY3JvIHZhbHVlcyBpbiBhc20vY3NyLmgNCiAgUklTQy1WOiBBZGQgaW50ZXJy
dXB0IHJlbGF0ZWQgU0NBVVNFIGRlZmluZXMgaW4gYXNtL2Nzci5oDQogIFJJU0MtVjogQWNjZXNz
IENTUnMgdXNpbmcgQ1NSIG51bWJlcnMNCg0KIGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vY3NyLmgg
ICAgICAgICB8IDEyNyArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0NCiBhcmNoL3Jpc2N2L2lu
Y2x1ZGUvYXNtL2lycWZsYWdzLmggICAgfCAgMTAgKy0tDQogYXJjaC9yaXNjdi9pbmNsdWRlL2Fz
bS9tbXVfY29udGV4dC5oIHwgICA3ICstDQogYXJjaC9yaXNjdi9rZXJuZWwvZW50cnkuUyAgICAg
ICAgICAgIHwgIDIyICsrLS0tDQogYXJjaC9yaXNjdi9rZXJuZWwvaGVhZC5TICAgICAgICAgICAg
IHwgIDEyICstLQ0KIGFyY2gvcmlzY3Yva2VybmVsL2lycS5jICAgICAgICAgICAgICB8ICAyMyAr
LS0tLQ0KIGFyY2gvcmlzY3Yva2VybmVsL3BlcmZfZXZlbnQuYyAgICAgICB8ICAgNCArLQ0KIGFy
Y2gvcmlzY3Yva2VybmVsL3NtcC5jICAgICAgICAgICAgICB8ICAgMiArLQ0KIGFyY2gvcmlzY3Yv
a2VybmVsL3RyYXBzLmMgICAgICAgICAgICB8ICAgNiArLQ0KIGFyY2gvcmlzY3YvbW0vZmF1bHQu
YyAgICAgICAgICAgICAgICB8ICAgNiArLQ0KIDEwIGZpbGVzIGNoYW5nZWQsIDExNSBpbnNlcnRp
b25zKCspLCAxMDQgZGVsZXRpb25zKC0pDQoNCi0tDQoyLjE3LjENCg==
