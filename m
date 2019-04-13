Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04FCC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 15:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A366208E3
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 15:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fymIwSvg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="D6UFD9g2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfDMPir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 11:38:47 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:6958 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfDMPiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 11:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555170011; x=1586706011;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=HBm7XEFzUIrSj1v9wAXJb/pP46PgFBLG/K9fLZGR2nw=;
  b=fymIwSvg2AZoVIKdfat0Ul84dOMLeGVZ52Ic4T1jOcnCKcgv31AFgvb8
   DMhlmXlSwFEbxGgp9trD4glzM7HAyPxTNABS9ZgyJ1g+LvR1pSDRcyTe7
   l6fzuGcaJg9nhqFLl1BRygDjkp5e1qOjbeGPBD75fjiVfo9ahgEqrO4/0
   GpnehdVoqmrr+dNyY6YvibVTCv8NEDkjzKkBbpEREvP3fAbrXrEJJZEZY
   m+fX/DDXKWptXMupmQNMFh2kjW6K2MZ27hU3PWF50TFS57RvpgvDSg0hA
   Gx4WoCLYyBY2L7aPshTXQKqoHl04vXdJArjThsqz3LKFQZYTI94qgd18U
   A==;
X-IronPort-AV: E=Sophos;i="5.60,345,1549900800"; 
   d="scan'208";a="204828647"
Received: from mail-bl2nam02lp2055.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.55])
  by ob1.hgst.iphmx.com with ESMTP; 13 Apr 2019 23:39:52 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBm7XEFzUIrSj1v9wAXJb/pP46PgFBLG/K9fLZGR2nw=;
 b=D6UFD9g2snHFcbKwiqRVDzsr74hZ5tcUlQCXbfa+vnGr2B99MwkoWK/NKV3WBADvA8Sz7wDucZA2lw7cbAINL7E5aHysez1YCsuiZBKUIoyMWc8VkqBByeEFTgt3Qn8lZxbNk+biBzNNfxuBXHDTselDr1yLjBh1hVbc5IJMXFg=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5501.namprd04.prod.outlook.com (20.178.245.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Sat, 13 Apr 2019 15:38:31 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2%5]) with mapi id 15.20.1792.018; Sat, 13 Apr 2019
 15:38:31 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v2 0/3] Allow accessing CSR using CSR number
Thread-Topic: [PATCH v2 0/3] Allow accessing CSR using CSR number
Thread-Index: AQHU8g7y5A6nUeaLGUqX2vf0HW87WQ==
Date:   Sat, 13 Apr 2019 15:38:31 +0000
Message-ID: <20190413153807.116227-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PN1PR0101CA0032.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::18) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [106.51.17.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b731c6e2-0f2e-40fa-f018-08d6c02614b5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MN2PR04MB5501;
x-ms-traffictypediagnostic: MN2PR04MB5501:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MN2PR04MB550153423BD035A1909105AB8D290@MN2PR04MB5501.namprd04.prod.outlook.com>
x-forefront-prvs: 00064751B6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39860400002)(376002)(396003)(136003)(346002)(366004)(199004)(189003)(2906002)(71190400001)(71200400001)(97736004)(50226002)(1076003)(186003)(68736007)(102836004)(8936002)(6486002)(86362001)(110136005)(54906003)(316002)(9456002)(78486014)(55236004)(4326008)(81166006)(81156014)(6506007)(386003)(5660300002)(26005)(8676002)(36756003)(105586002)(44832011)(106356001)(14444005)(256004)(3846002)(14454004)(478600001)(72206003)(6116002)(52116002)(6512007)(25786009)(99286004)(53936002)(486006)(2171002)(66066001)(7736002)(6436002)(476003)(305945005)(2616005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5501;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uvkf4/VlHTSZbRg/WxppSavsQfhFL9Ygh+sa1ms89B1TtQS26KR+LRp4NVPZH4wG/e4jcAFk8YKB701CkFkuCjjsDzNdA1JDQ9/xt/wV8S3VPWbvBpnE6AStkkUkPTAvoAlX3ylIz5JV90WHWKc38QESjtVhEez3fB0wokebkHjDQSKGvAZGKPvxTqXhHtiwnqcy9JFC8l6UD4XK2wobubTl0RZMpQtMlJ4kGZHNUwAvpXVvQEbOCHS7ybY+lg/IY6/EsYaV5Xo7t5DURcLi0YAsu/VECwYxnJ8VqxbSXewFGHUTcF33aIdCjW3dX01A+DSthNLKoz1KcRYKMzb145SprdUGdke8EAoYfQ8ZhYgSrwV3LY+1UL0SjXqyjKy/QpViF+aKutt5EWrebGX2kUXq0mk8VX5Siif1iTrgwlU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b731c6e2-0f2e-40fa-f018-08d6c02614b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2019 15:38:31.2625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5501
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
IGluIHJpc2N2X2Nzcl9udW1iZXJfdjIgYnJhbmNoIG9mDQpodHRwcy8vZ2l0aHViLmNvbS9hdnBh
dGVsL2xpbnV4LmdpdA0KDQpDaGFuZ2VzIHNpbmNlIHYxOg0KIC0gU3F1YXNoIFBBVENIMiBpbnRv
IGNwYXRjaDMNCiAtIEFkZGVkIG5ldyBQQVRDSDIgdG8gYWRkIGludGVycnVwdCByZWxhdGVkIFND
QVVTRSBkZWZpbmVzDQogICBpbiBhc20vZW5jb2RpbmcuaA0KDQpBbnVwIFBhdGVsICgzKToNCiAg
UklTQy1WOiBBZGQgc2VwYXJhdGUgYXNtL2VuY29kaW5nLmggZm9yIHNwZWMgcmVsYXRlZCBkZWZp
bmVzDQogIFJJU0MtVjogQWRkIGludGVycnVwdCByZWxhdGVkIFNDQVVTRSBkZWZpbmVzIGluIGFz
bS9lbmNvZGluZy5oDQogIFJJU0MtVjogQWNjZXNzIENTUnMgdXNpbmcgQ1NSIG51bWJlcnMNCg0K
IGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vY3NyLmggICAgICAgICB8IDY3ICsrKy0tLS0tLS0tLS0t
LS0tLS0tDQogYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9lbmNvZGluZy5oICAgIHwgOTUgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KIGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vaXJxZmxhZ3Mu
aCAgICB8IDEwICstLQ0KIGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vbW11X2NvbnRleHQuaCB8ICA3
ICstDQogYXJjaC9yaXNjdi9rZXJuZWwvZW50cnkuUyAgICAgICAgICAgIHwgMjIgKysrLS0tLQ0K
IGFyY2gvcmlzY3Yva2VybmVsL2hlYWQuUyAgICAgICAgICAgICB8IDEyICsrLS0NCiBhcmNoL3Jp
c2N2L2tlcm5lbC9pcnEuYyAgICAgICAgICAgICAgfCAgOSArLS0NCiBhcmNoL3Jpc2N2L2tlcm5l
bC9wZXJmX2V2ZW50LmMgICAgICAgfCAgNCArLQ0KIGFyY2gvcmlzY3Yva2VybmVsL3NtcC5jICAg
ICAgICAgICAgICB8ICAyICstDQogYXJjaC9yaXNjdi9rZXJuZWwvdHJhcHMuYyAgICAgICAgICAg
IHwgIDYgKy0NCiBhcmNoL3Jpc2N2L21tL2ZhdWx0LmMgICAgICAgICAgICAgICAgfCAgNiArLQ0K
IDExIGZpbGVzIGNoYW5nZWQsIDEzOSBpbnNlcnRpb25zKCspLCAxMDEgZGVsZXRpb25zKC0pDQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vZW5jb2RpbmcuaA0KDQot
LQ0KMi4xNy4xDQo=
