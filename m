Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2752EC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE001218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZKd+WO/i";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KVIwYya8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbfDYIPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:15:17 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:2609 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfDYIPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:15:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556180114; x=1587716114;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=dOKap9F1DRFrL8zrxjS+cuuGuDXC52fgyE/HodkUXFw=;
  b=ZKd+WO/i6nF9NjA6LwGHJJ0WK/9WJnhc5jBY6eAlpx99+rQ5x3tQ0PIe
   aHJ8HaBR+owqv0/YgKzkMPNHNiv4tkv2Uydd3H0Zddycj6AURFfJBW8R9
   TumLkmpP/bI7zOemHhs/rBxDB1ztYCqhKTz2sbNBsDktITOM/zbXmnRfY
   1h/tO8huL5Fed7xRkXtG2XrQxVg8geUWeOmufy/kD06TqpVECk1E2s5Si
   Z4PqJPzv9QOtK6VGiifY5A0hnaTnBUX1BIXZi3SookZR+Cjjy1QRru6cH
   iHZ7BA8iKpGQQKNBT8NsHfKH2fmMnBQvlc9LBnvFr5Q7Beevuep8Ewzju
   A==;
X-IronPort-AV: E=Sophos;i="5.60,393,1549900800"; 
   d="scan'208";a="107997684"
Received: from mail-bn3nam01lp2059.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.59])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2019 16:15:13 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOKap9F1DRFrL8zrxjS+cuuGuDXC52fgyE/HodkUXFw=;
 b=KVIwYya8XG4fIm5iucX/YtM5phfAFgkDKMZCJiFcABujoP0SaLCZNztakimOJePu5E0s2yXUj+zr7xx3W1BqY3LnJyg1P0UxAMPpwpiDJ0IUzcKcdHDRokNrm6ql3nPw+yePH7SY8Z+XxmvXYR+1WlEG1oo8DH7XTybYR11SbMA=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6095.namprd04.prod.outlook.com (20.178.245.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Thu, 25 Apr 2019 08:15:10 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2%5]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 08:15:10 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v5 0/3] Allow accessing CSR using CSR number
Thread-Topic: [PATCH v5 0/3] Allow accessing CSR using CSR number
Thread-Index: AQHU+z7/ZVaw1StUQE6eVlEZlMfgEw==
Date:   Thu, 25 Apr 2019 08:15:10 +0000
Message-ID: <20190425081445.929-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR0101CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::33) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [129.253.179.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ac8542d-2931-469c-8554-08d6c956224a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MN2PR04MB6095;
x-ms-traffictypediagnostic: MN2PR04MB6095:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MN2PR04MB6095F45EC23A1A20DBF613B18D3D0@MN2PR04MB6095.namprd04.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(39860400002)(376002)(136003)(199004)(189003)(26005)(81156014)(54906003)(386003)(14444005)(7736002)(97736004)(2616005)(6506007)(256004)(110136005)(478600001)(68736007)(6436002)(6486002)(316002)(71200400001)(71190400001)(14454004)(25786009)(2171002)(476003)(102836004)(72206003)(8676002)(4326008)(486006)(81166006)(2906002)(50226002)(44832011)(36756003)(99286004)(186003)(3846002)(52116002)(73956011)(64756008)(1076003)(66556008)(66446008)(5660300002)(8936002)(66476007)(66946007)(6512007)(6116002)(86362001)(66066001)(53936002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6095;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: umPCnCKMmGEXEAgPR203yckInORXnaSSNEJesmLZ0p7r0lWRUXXggJnCIQFflpT+7qifiEtMLnB0pzx9badhNNwJIUzHdM9iPtG9XeEeu53PMGbES2GS1BKKJMkgmabmkeAUcAnkgISRYMRWq6M4K7lgzBdmuw1wAmRi3k9q+PPvb1YD5oKI6J1EThM/Fbues8wULp6O5cKBDrBF+ujgIUoRSvQN90SULAw0GKDqmoiOPBvAdsQpF8oh3qqTI566PznvEAKK9E/a2nf7eTAhmANnnrZ5PT57HxWl9ojmPOeCPP2T54AoBOwp/i98Vo9bA2wxsPirAwIhYYyOLV6KHCh5txe8n4c0IF+0HnprRc7oJ7oLkluxArCl4J0ZiDMBUm98NkqGVRAlJo6UeUtHQgQIEffHyscr3Wv+h4B1NpE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac8542d-2931-469c-8554-08d6c956224a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 08:15:10.2585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6095
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
IGluIHJpc2N2X2Nzcl9udW1iZXJfdjUgYnJhbmNoIG9mDQpodHRwcy8vZ2l0aHViLmNvbS9hdnBh
dGVsL2xpbnV4LmdpdA0KDQpDaGFuZ2VzIHNpbmNlIHY0Og0KIC0gRXhwcmVzcyBTQ0FVU0VfSVJR
X0ZMQUcgaW4tdGVybXMgb2YgX19yaXNjdl94bGVuDQoNCkNoYW5nZXMgc2luY2UgdjM6DQogLSBL
ZWVwIG9sZCBJTlRFUlJVUFRfeHl6IGRlZmluZXMgaW4ga2VybmVsL2lycS5jIGZvciBQQVRDSDIN
Cg0KQ2hhbmdlcyBzaW5jZSB2MjoNCiAtIERyb3BwZWQgUEFUQ0gxIHdoaWNoIGFkZGVkIGFzbS9l
bmNvZGluZy5oDQogLSBBZGRlZCBuZXcgUEFUQ0gxIHdoaWNoIGJlYXV0aWZpZXMgYXNtL2Nzci5o
IGJ5IHVzaW5nIHRhYnMgdG8NCiAgIGFsaWduIG1hY3JvIHZhbHVlcw0KDQpDaGFuZ2VzIHNpbmNl
IHYxOg0KIC0gU3F1YXNoIFBBVENIMiBpbnRvIGNwYXRjaDMNCiAtIEFkZGVkIG5ldyBQQVRDSDIg
dG8gYWRkIGludGVycnVwdCByZWxhdGVkIFNDQVVTRSBkZWZpbmVzDQogICBpbiBhc20vZW5jb2Rp
bmcuaA0KDQpBbnVwIFBhdGVsICgzKToNCiAgUklTQy1WOiBVc2UgdGFicyB0byBhbGlnbiBtYWNy
byB2YWx1ZXMgaW4gYXNtL2Nzci5oDQogIFJJU0MtVjogQWRkIGludGVycnVwdCByZWxhdGVkIFND
QVVTRSBkZWZpbmVzIGluIGFzbS9jc3IuaA0KICBSSVNDLVY6IEFjY2VzcyBDU1JzIHVzaW5nIENT
UiBudW1iZXJzDQoNCiBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2Nzci5oICAgICAgICAgfCAxMjMg
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tDQogYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9pcnFm
bGFncy5oICAgIHwgIDEwICstLQ0KIGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vbW11X2NvbnRleHQu
aCB8ICAgNyArLQ0KIGFyY2gvcmlzY3Yva2VybmVsL2VudHJ5LlMgICAgICAgICAgICB8ICAyMiAr
Ky0tLQ0KIGFyY2gvcmlzY3Yva2VybmVsL2hlYWQuUyAgICAgICAgICAgICB8ICAxMiArLS0NCiBh
cmNoL3Jpc2N2L2tlcm5lbC9pcnEuYyAgICAgICAgICAgICAgfCAgIDggKy0NCiBhcmNoL3Jpc2N2
L2tlcm5lbC9wZXJmX2V2ZW50LmMgICAgICAgfCAgIDQgKy0NCiBhcmNoL3Jpc2N2L2tlcm5lbC9z
bXAuYyAgICAgICAgICAgICAgfCAgIDIgKy0NCiBhcmNoL3Jpc2N2L2tlcm5lbC90cmFwcy5jICAg
ICAgICAgICAgfCAgIDYgKy0NCiBhcmNoL3Jpc2N2L21tL2ZhdWx0LmMgICAgICAgICAgICAgICAg
fCAgIDYgKy0NCiAxMCBmaWxlcyBjaGFuZ2VkLCAxMTEgaW5zZXJ0aW9ucygrKSwgODkgZGVsZXRp
b25zKC0pDQoNCi0tDQoyLjE3LjENCg==
