Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5954DC04AA7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B0D42084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OvoGxK44";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DcmXYaLp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbfEOGaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 02:30:52 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:27377 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfEOGaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 02:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1557901852; x=1589437852;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=/3JFuvi5KaEHcItK79ajYJVZ0XA2wvkcfcSp8VyJNyY=;
  b=OvoGxK44FtGO6jrWxHm1MGhdv0gArFAf2Jcvb7RzW2wCbzoCrVSXbMbB
   cMLWEKVZ1xYRRM0P0SikRXsWPw7+miu/aHD+HdkvCdTOnkfDa1kZpIQuF
   sDPycOQv3UvfdBZB1iw9+gUf1AxVKogAt9jpMSymiFS2On7FnFdx/MIMQ
   gR/80m3ND0pTANUBkQq0iexA4dlAhaPjCSVAK5AvZ25V6r0b7k6KzmbsL
   BHdhpof7BP+LZa79cEzWOR/hzRb8fwVWJ2knrDSpjv5JSpA9fn+3z7AtB
   hkJ8tIILDQ9wbA5AXpuneu7kmLxYEC5Ow8AoJLwRwpLGHxLJI3IzV2NMW
   w==;
X-IronPort-AV: E=Sophos;i="5.60,471,1549900800"; 
   d="scan'208";a="108302799"
Received: from mail-co1nam04lp2056.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.56])
  by ob1.hgst.iphmx.com with ESMTP; 15 May 2019 14:30:42 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3JFuvi5KaEHcItK79ajYJVZ0XA2wvkcfcSp8VyJNyY=;
 b=DcmXYaLpYyy3FfNIcKHl5Oa/7/GEYbEhCgLPxr34hysFjw0obpxCOWHpSkf7TlPfKberlXbB9Xdk84KUoAtQO11isftpfR6u5us3ZCspUlaximzyJsU3oq3+hKxiXn9q01TUYDWLKO+38kkHbptONcqKklPbeTXWzOCVBqIeg5Y=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6128.namprd04.prod.outlook.com (20.178.248.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.24; Wed, 15 May 2019 06:30:40 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::5577:2af9:2b09:8171]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::5577:2af9:2b09:8171%3]) with mapi id 15.20.1878.024; Wed, 15 May 2019
 06:30:40 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH] RISC-V: defconfig: Enable NO_HZ_IDLE and HIGH_RES_TIMERS
Thread-Topic: [PATCH] RISC-V: defconfig: Enable NO_HZ_IDLE and HIGH_RES_TIMERS
Thread-Index: AQHVCue2HEus4pRvEEGYJRX3qv0JOw==
Date:   Wed, 15 May 2019 06:30:39 +0000
Message-ID: <20190515063004.3466-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::21) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [129.253.179.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e574d5c-3244-4b0a-f658-08d6d8fed923
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MN2PR04MB6128;
x-ms-traffictypediagnostic: MN2PR04MB6128:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MN2PR04MB612804594253EF0236B937668D090@MN2PR04MB6128.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(39860400002)(366004)(376002)(189003)(199004)(110136005)(5660300002)(54906003)(81156014)(66446008)(99286004)(2906002)(66066001)(14454004)(3846002)(478600001)(81166006)(6116002)(7736002)(72206003)(305945005)(316002)(73956011)(1076003)(25786009)(8676002)(66556008)(64756008)(66476007)(52116002)(66946007)(102836004)(26005)(2171002)(486006)(4326008)(44832011)(86362001)(6436002)(476003)(6506007)(386003)(71190400001)(2616005)(8936002)(71200400001)(186003)(36756003)(6512007)(256004)(68736007)(6486002)(50226002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6128;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xhPhkc+iTrI0ZPpt4n6FCLyiS23hNPUWSgvQ8zinIdkznZjYWtrjyYJrHPTMiClokvOrhBkC7tYva7nLqomqG7lhQjPQUJTCJllaoBw4EG6ThVl2deGItOmKOn99o6vr7k4lRvZuO+8TAe1iEbbteStn6U+B+Y8lxVHgoRQidc/qz/j0iDztNUpHzxXRwlAuMeh6km56aA+WlZHRXITCZbodKt7RNhMKLVjdoZXWv7mXNWsnurm+IWQZv73fh+rADN+YbIcXsPOj6nifn+TwwMhzhPrhG+WBiqOlm5bvaXFJehQpmGj/mfUNTi6P49GNJKzqhUCbTXKpIrPvgiwdOs1NXFWOtMUIc62sQ4q0b8AlnrNsJxeeauDfSQ6JmniP1fLB1W4+ezJdWBmXENensE581XJXIJ64uHozcBw4EBg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e574d5c-3244-4b0a-f658-08d6d8fed923
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 06:30:39.9592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBlbmFibGVzIE5PX0haX0lETEUgKGlkbGUgZHluYW1pYyB0aWNrcykgYW5kIEhJ
R0hfUkVTX1RJTUVSUw0KKGhydGltZXJzKSBpbiBSVjMyIGFuZCBSVjY0IGRlZmNvbmZpZ3MuDQoN
CkJvdGggb2YgdGhlIGFib3ZlIG9wdGlvbnMgYXJlIGVuYWJsZWQgYnkgZGVmYXVsdCBmb3IgYXJj
aGl0ZWN0dXJlcw0Kc3VjaCBhcyB4ODYsIEFSTSwgYW5kIEFSTTY0Lg0KDQpUaGUgaWRsZSBkeW5h
bWljIHRpY2tzIGhlbHBzIHVzZSBzYXZlIHBvd2VyIGJ5IHN0b3BwaW5nIHRpbWVyIHRpY2tzDQp3
aGVuIHRoZSBzeXN0ZW0gaXMgaWRsZSB3aGVyZWFzIGhydGltZXJzIGlzIGEgbXVjaCBpbXByb3Zl
ZCB0aW1lcg0Kc3Vic3lzdGVtIGNvbXBhcmVkIHRvIHRoZSBvbGQgInRpbWVyIHdoZWVsIiBiYXNl
ZCBzeXN0ZW0uDQoNClRoaXMgcGF0Y2ggaXMgdGVzdGVkIG9uIFNpRml2ZSBVbmxlYXNoZWQgYm9h
cmQgYW5kIFFFTVUgVmlydCBtYWNoaW5lLg0KDQpTaWduZWQtb2ZmLWJ5OiBBbnVwIFBhdGVsIDxh
bnVwLnBhdGVsQHdkYy5jb20+DQotLS0NCiBhcmNoL3Jpc2N2L2NvbmZpZ3MvZGVmY29uZmlnICAg
ICAgfCAyICsrDQogYXJjaC9yaXNjdi9jb25maWdzL3J2MzJfZGVmY29uZmlnIHwgMiArKw0KIDIg
ZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2
L2NvbmZpZ3MvZGVmY29uZmlnIGIvYXJjaC9yaXNjdi9jb25maWdzL2RlZmNvbmZpZw0KaW5kZXgg
MmZkMzQ2MWU1MGFiLi5mMjU0YzM1MmVjNTcgMTAwNjQ0DQotLS0gYS9hcmNoL3Jpc2N2L2NvbmZp
Z3MvZGVmY29uZmlnDQorKysgYi9hcmNoL3Jpc2N2L2NvbmZpZ3MvZGVmY29uZmlnDQpAQCAtMSw1
ICsxLDcgQEANCiBDT05GSUdfU1lTVklQQz15DQogQ09ORklHX1BPU0lYX01RVUVVRT15DQorQ09O
RklHX05PX0haX0lETEU9eQ0KK0NPTkZJR19ISUdIX1JFU19USU1FUlM9eQ0KIENPTkZJR19JS0NP
TkZJRz15DQogQ09ORklHX0lLQ09ORklHX1BST0M9eQ0KIENPTkZJR19DR1JPVVBTPXkNCmRpZmYg
LS1naXQgYS9hcmNoL3Jpc2N2L2NvbmZpZ3MvcnYzMl9kZWZjb25maWcgYi9hcmNoL3Jpc2N2L2Nv
bmZpZ3MvcnYzMl9kZWZjb25maWcNCmluZGV4IDFhOTExZWQ4ZTc3Mi4uZDU0NDllZjgwNWEzIDEw
MDY0NA0KLS0tIGEvYXJjaC9yaXNjdi9jb25maWdzL3J2MzJfZGVmY29uZmlnDQorKysgYi9hcmNo
L3Jpc2N2L2NvbmZpZ3MvcnYzMl9kZWZjb25maWcNCkBAIC0xLDUgKzEsNyBAQA0KIENPTkZJR19T
WVNWSVBDPXkNCiBDT05GSUdfUE9TSVhfTVFVRVVFPXkNCitDT05GSUdfTk9fSFpfSURMRT15DQor
Q09ORklHX0hJR0hfUkVTX1RJTUVSUz15DQogQ09ORklHX0lLQ09ORklHPXkNCiBDT05GSUdfSUtD
T05GSUdfUFJPQz15DQogQ09ORklHX0NHUk9VUFM9eQ0KLS0gDQoyLjE3LjENCg0K
