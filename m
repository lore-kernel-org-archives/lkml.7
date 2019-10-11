Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EE9ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2FD2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=silabs.onmicrosoft.com header.i=@silabs.onmicrosoft.com header.b="Uwrbi0WV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfJKKQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 06:16:44 -0400
Received: from mail-eopbgr810083.outbound.protection.outlook.com ([40.107.81.83]:63401
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726290AbfJKKQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 06:16:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anztnl3rnkNRGDdic70s/XGjihC+8PtOkLk1RPTcZDvau26degoAh3UA0gBSgHbBer/kIFwjGin3K0O/p9x8hkcQMvwG0/QnQsDu+8BwMxB7+aGpR3DE00Uw3nfAVh+M5idBAgg/NioGwlFQ4XDZm9LjZB3zn6EtdvZL63xlhvR1eqp2ywtpuRJqMZbw3z1R9klCxwErTgQ2bLYmJrQqC+Y8kUkqZkjMspj5n5rqcEUlu4W6+LgvfOyG0Vq11dv6q6zLEo9NEDoU+RQ0S6HZBweh/BT9+J396vcZlX1j1XJ4vPtjE2WDwQJghB6HkQtx4wPJpaGWs3g5HQfO2g9M6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIj/RXBXkZTNRO9ClN8XsXFx6L1aDGq6ZRxkxVw8pGU=;
 b=KKgS2iHn+aOEApS09mFHBkDLWGMmxhnkfu2xCa/KK1uxJHs8GrsAGACFSz965xUhE1XqknebwZ/oRLivDxkrvvITZYdTmL6Stp7Zogz6OzsuDMEvKuhy/2v5uSJoQcODnGIN1jc0ypmbztwmge69CtJO7QQbqBQASByKNCmvcONbsYwPGTa5ViLkFLSuI/ZrkkWF9+yVT5rpxksTCWiysma6Wy/lWkBBXxoAwXW8k9GVShh/7DSHBHYXMYABwJ0znnRRHj+Ar7vWTjl7Ql39PwjFt71jvadx8WN6jVx9qLiOyzHUM+/Hhk/f0ZRbmzKbmyJx2iMPD8zRVwUafrBIKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIj/RXBXkZTNRO9ClN8XsXFx6L1aDGq6ZRxkxVw8pGU=;
 b=Uwrbi0WVaemnf7UsYNj4wMS+aQszdwDmO7V7DIUv9K6zcH8TdAw1I8zqR2cfQ4MDaZ8swhgHKNCbpJHogTtun2Mg/FXC2SsrzRIDXfnfRiZkJexCvpC1H0bzPv/xJERLK632lOPcivCOLRc49QrUIcQvJynmT6yjdLSlFii6Q1M=
Received: from MN2PR11MB4063.namprd11.prod.outlook.com (10.255.180.22) by
 MN2PR11MB4254.namprd11.prod.outlook.com (52.135.38.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.19; Fri, 11 Oct 2019 10:16:41 +0000
Received: from MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ac8c:fc55:d1e2:465f]) by MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ac8c:fc55:d1e2:465f%5]) with mapi id 15.20.2347.016; Fri, 11 Oct 2019
 10:16:41 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jerome Pouiller <Jerome.Pouiller@silabs.com>,
        kbuild test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] staging: wfx: fix error handling in wfx_tx_get_raw_link_id()
Thread-Topic: [PATCH] staging: wfx: fix error handling in
 wfx_tx_get_raw_link_id()
Thread-Index: AQHVgBz5waprr4JXYUG6rexbqe8VzQ==
Date:   Fri, 11 Oct 2019 10:16:41 +0000
Message-ID: <20191011101639.31025-1-Jerome.Pouiller@silabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jerome.Pouiller@silabs.com; 
x-originating-ip: [37.71.187.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b854839-6f18-46ef-8fef-08d74e341c3e
x-ms-traffictypediagnostic: MN2PR11MB4254:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB425477ECB746331D4959491B93970@MN2PR11MB4254.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(396003)(39850400004)(346002)(189003)(199004)(6506007)(2351001)(478600001)(26005)(36756003)(2501003)(8936002)(6486002)(102836004)(6116002)(3846002)(186003)(66946007)(71190400001)(91956017)(71200400001)(76116006)(256004)(14444005)(64756008)(66476007)(66556008)(66446008)(25786009)(486006)(6916009)(2906002)(316002)(2616005)(476003)(54906003)(81156014)(6512007)(6436002)(5640700003)(4326008)(305945005)(5660300002)(14454004)(66574012)(1076003)(86362001)(66066001)(81166006)(1730700003)(8676002)(99286004)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4254;H:MN2PR11MB4063.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: silabs.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kA4LrXAQM3oRjD0qQhqbDnXnIgsncrWxRIMfyWV8NFgkQ6C4PaiVOAXWY4da7TfAChR8OF4uZZZfMHXq2Kle80MxxZ8KaiCOg7xHd2UKIO//G4TO2rNYnNUqhrAzLNG8ZvQm3uLflq6fy2q6c8nULdzkidXp0s7VuSX35q4V2b84wni6Um3EgORwhw43Y0aHiSQ7O1kld3TTKZe9c4BqDnlbNlEN4gCEHTf+GkMgZooETOFZgtms2QqnzEhPFXINsUTZSAwczPWUhWN2h+Re0H1b8SyuS2z5GidikBkGDyzv3kRLl9foNfh2o2+WGOgXTJLISQCV0r3wBqxDveobBW7WF8s6E4118v8vfuIxhnkt0SyRzdWc1aGtkdxIQ9h9Lu1Jx9aGHPOOQZ7seqyfMYvVOqH+e5u3XTolP/IGUMo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <37F68EC6BC93464FAE9D6C93B1DAD811@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b854839-6f18-46ef-8fef-08d74e341c3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 10:16:41.2973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yh169//87TvxtDrrQFoSE21MyHN3FRlVEOID2gP6LzMGnai6TZLlPhgUSuH0ivaTyQ8gv5Z1ljTVKu84jKVTsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4254
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPg0KDQpT
aW5jZSB3ZnhfdHhfZ2V0X3Jhd19saW5rX2lkKCkgcmV0dXJuIGFuIHVuc2lnbmVkLCBpdCBtYWtl
cyBubyBzZW5zZSB0bw0KcmV0dXJuIGEgbmVnYXRpdmUgdmFsdWUuICIxNSIgaXMgYSBiZXR0ZXIg
dmFsdWUgc2luY2UgaXQgaXMgdXNlZCBieQ0KZmlybXdhcmUgZm9yIHN0YXRpb25zIHRoYXQgaGF2
ZSBub3QgeWV0IGFzc29jaWF0ZWQgbGluay1pZHMuDQoNCk5vdGUgdGhhdCB0aGlzIHNob3VsZCBu
ZXZlciBoYXBwZW5zIHNpbmNlIGRyaXZlciBzZXQgbWF4X2FwX2Fzc29jX3N0YQ0KdG8gMTQuDQoN
CkZpeGVzOiA5YmNhNDVmM2Q2OTIgKCJzdGFnaW5nOiB3Zng6IGFsbG93IHRvIHNlbmQgODAyLjEx
IGZyYW1lcyIpDQpSZXBvcnRlZC1ieToga2J1aWxkIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+
DQpSZXBvcnRlZC1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBvcmFjbGUuY29tPg0K
U2lnbmVkLW9mZi1ieTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMu
Y29tPg0KLS0tDQogZHJpdmVycy9zdGFnaW5nL3dmeC9kYXRhX3R4LmMgfCAzICsrLQ0KIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvc3RhZ2luZy93ZngvZGF0YV90eC5jIGIvZHJpdmVycy9zdGFnaW5nL3dmeC9kYXRh
X3R4LmMNCmluZGV4IDZlNGRkNGFjNTU0NC4uOGVkMzhjYWMxOWY2IDEwMDY0NA0KLS0tIGEvZHJp
dmVycy9zdGFnaW5nL3dmeC9kYXRhX3R4LmMNCisrKyBiL2RyaXZlcnMvc3RhZ2luZy93ZngvZGF0
YV90eC5jDQpAQCAtMTcsNiArMTcsNyBAQA0KICNpbmNsdWRlICJoaWZfdHhfbWliLmgiDQogDQog
I2RlZmluZSBXRlhfSU5WQUxJRF9SQVRFX0lEICgweEZGKQ0KKyNkZWZpbmUgV0ZYX0xJTktfSURf
Tk9fQVNTT0MgICAxNQ0KICNkZWZpbmUgV0ZYX0xJTktfSURfR0NfVElNRU9VVCAoKHVuc2lnbmVk
IGxvbmcpKDEwICogSFopKQ0KIA0KIHN0YXRpYyBpbnQgd2Z4X2dldF9od19yYXRlKHN0cnVjdCB3
ZnhfZGV2ICp3ZGV2LCBjb25zdCBzdHJ1Y3QgaWVlZTgwMjExX3R4X3JhdGUgKnJhdGUpDQpAQCAt
NDgwLDcgKzQ4MSw3IEBAIHN0YXRpYyB1aW50OF90IHdmeF90eF9nZXRfcmF3X2xpbmtfaWQoc3Ry
dWN0IHdmeF92aWYgKnd2aWYsIHN0cnVjdCBpZWVlODAyMTFfc3RhDQogCQlyZXQgPSB3ZnhfYWxs
b2NfbGlua19pZCh3dmlmLCBkYSk7DQogCWlmICghcmV0KSB7DQogCQlkZXZfZXJyKHd2aWYtPndk
ZXYtPmRldiwgIm5vIG1vcmUgbGluay1pZCBhdmFpbGFibGVcbiIpOw0KLQkJcmV0dXJuIC1FTk9F
TlQ7DQorCQlyZXR1cm4gV0ZYX0xJTktfSURfTk9fQVNTT0M7DQogCX0NCiAJcmV0dXJuIHJldDsN
CiB9DQotLSANCjIuMjAuMQ0K
