Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBF2C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C14120665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="OWcQ6e2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731718AbfGWPUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 11:20:25 -0400
Received: from mail-eopbgr00084.outbound.protection.outlook.com ([40.107.0.84]:54544
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727796AbfGWPUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:20:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YE0UrhRCcQ69H8kz1COGppnDNeOVZDQGl18hCyJmm4d86UOmkDUc9v5Blz5Y/PbvnFgyMBNIW8MbJL7viDwspzXo+nD30jOaD+LqAwaA7cVy1tHDZyQe+E5Dcc6YpJ/Tu/U9YckhmmAfCwY1Y06bLFEl0mApmpxyeH1H33NkIW0DdLR67Q1pJtHnCAJk3jVJBMCxSlNT0PbCsr80RynE5P5BSp9WGKqjh4CQuNedgQNU62GTbVXwEMFvs9l6z2+jKueOz29bOeBl19s3fK4n7eW1k4VGgat8k0M7/nvYlUS3s1fttKVZMY0IJd+tPs5m7CoDdt33dTktk1EWl5Jvyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPviDnRAQ973raaeolsT7+uFVDpsPC0hTJQPUczGLqU=;
 b=Yvkk1omAF0WNOVOCEvHqnaZrkHnRiGTEP2UoyyMvv++9bPnAL3nJR8W/g8bMVW6U11QbpIwpsyJA8K33hsoRza8sKoOj0a04ESF+Q5OfdCEYOU77Eegfl3s6D689pDOPg+QIeZlQpxBIV5g4xQ+CmHzuMmbetV5rCURTzNdQfyRHvuj+u31QDldOZEsp6jwdZI+04fw0QJZ4qUTI94ruPDle9uxRwOTCBql5cke7Yzu6lQ4UdlqdhqI+xorn6pcVV4hCZTZFuPFXifUCSCRNJCTJ+/+oEZz9c2vmXS5NDIQPmwjRjrxwZ1u5X8yPOW+7ulE+Ztmj+aN8djCLjK9PJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPviDnRAQ973raaeolsT7+uFVDpsPC0hTJQPUczGLqU=;
 b=OWcQ6e2uI8yv+1uFx1cr5qwE90+haWIWI5wNWpGIG4goVxOPGwWIQqAcT4aT+CynJ7XeCuRQTsqazKvQ1i/DRA18W1ttaypA+7CpndyfUvMX5ZWvW3rfWCMVISaC9r8cFT+yFUM/kGs9JKB+AWb4CRSCpWCbAEPFDl0cV6H57iY=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.14; Tue, 23 Jul 2019 15:20:21 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880%4]) with mapi id 15.20.2094.013; Tue, 23 Jul 2019
 15:20:21 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
CC:     Christoph Hellwig <hch@lst.de>,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: hmm_range_fault related fixes and legacy API removal v2
Thread-Topic: hmm_range_fault related fixes and legacy API removal v2
Thread-Index: AQHVQHIRntNvIPdbDk2nPEKsWJGfiKbXZhsAgADtQoA=
Date:   Tue, 23 Jul 2019 15:20:20 +0000
Message-ID: <20190723152015.GN15331@mellanox.com>
References: <20190722094426.18563-1-hch@lst.de>
 <7e1f33d4-4d3b-7927-38d1-b98b22ed4d78@nvidia.com>
In-Reply-To: <7e1f33d4-4d3b-7927-38d1-b98b22ed4d78@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR0101CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::19) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f299e090-a9f3-4ae0-2ca0-08d70f8146c6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB3279;
x-ms-traffictypediagnostic: VI1PR05MB3279:
x-microsoft-antispam-prvs: <VI1PR05MB32793CD95F6CE20AAA82389CCFC70@VI1PR05MB3279.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0107098B6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(189003)(199004)(8936002)(5660300002)(11346002)(81166006)(476003)(316002)(66066001)(33656002)(478600001)(305945005)(76176011)(53546011)(54906003)(68736007)(36756003)(8676002)(7736002)(81156014)(99286004)(102836004)(2616005)(86362001)(6506007)(25786009)(386003)(26005)(186003)(446003)(6436002)(52116002)(6486002)(229853002)(6116002)(3846002)(486006)(66574012)(1076003)(6512007)(2906002)(256004)(66446008)(53936002)(6246003)(71200400001)(14444005)(14454004)(4326008)(64756008)(66556008)(66476007)(66946007)(6916009)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3279;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Tr8Gd2kZ5XwYTJbc3iAGJ9E573Sqq4pqjdObcnzeAsedVLiAC61w7FboCCR3XQSS1yJzIgsrIzLDEyB0AIxgOfP7nhBdjP7G+QnOvMhMlBXuCZ9CFkZv3GBipwxIxNONEDqpB823fD+/AzZXAdNjf2Su9WXkWuXZzfQ0KXA2vV7hL7LlUEw23irni4bVHJvveO15+5cEx/sk5YbEX3Kfw8W5E1Ff1rZHhj6EjVD3KjUfkPjLxTzyZgCucuVtHGw0nJvJHVFReA+OVhmCFfMwx7tIltg0UHOGlBL+LjhhpUO1JXtjxyKyEckGgnizobCWgIq9SZBJMUh9yPFrdUhDH5VHe3aNTP0uvNYQ5F4Yg/q1j5HPspfm3hZF7z9di3MEMtfy3tmNfJRob3athBpvr4a4I1yjoeBfg2nuekCLdEo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D009F8CD1C365A4CBB6461E07B6FA753@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f299e090-a9f3-4ae0-2ca0-08d70f8146c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2019 15:20:20.9804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3279
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBKdWwgMjIsIDIwMTkgYXQgMDY6MTE6MDRQTSAtMDcwMCwgUmFscGggQ2FtcGJlbGwg
d3JvdGU6DQo+IA0KPiBPbiA3LzIyLzE5IDI6NDQgQU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3Rl
Og0KPiA+IEhpIErDqXLDtG1lLCBCZW4gYW5kIEphc29uLA0KPiA+IA0KPiA+IGJlbG93IGlzIGEg
c2VyaWVzIGFnYWluc3QgdGhlIGhtbSB0cmVlIHdoaWNoIGZpeGVzIHVwIHRoZSBtbWFwX3NlbQ0K
PiA+IGxvY2tpbmcgaW4gbm91dmVhdSBhbmQgd2hpbGUgYXQgaXQgYWxzbyByZW1vdmVzIGxlZnRv
dmVyIGxlZ2FjeSBITU0gQVBJcw0KPiA+IG9ubHkgdXNlZCBieSBub3V2ZWF1Lg0KPiA+IA0KPiA+
IFRoZSBmaXJzdCA0IHBhdGNoZXMgYXJlIGEgYnVnIGZpeCBmb3Igbm91dmVhdSwgd2hpY2ggSSBz
dXNwZWN0IHNob3VsZA0KPiA+IGdvIGludG8gdGhpcyBtZXJnZSB3aW5kb3cgZXZlbiBpZiB0aGUg
Y29kZSBpcyBtYXJrZWQgYXMgc3RhZ2luZywganVzdA0KPiA+IHRvIGF2b2lkIHBlb3BsZSBjb3B5
aW5nIHRoZSBicmVha2FnZS4NCj4gPiANCj4gPiBDaGFuZ2VzIHNpbmNlIHYxOg0KPiA+ICAgLSBk
b24ndCByZXR1cm4gdGhlIHZhbGlkIHN0YXRlIGZyb20gaG1tX3JhbmdlX3VucmVnaXN0ZXINCj4g
PiAgIC0gYWRkaXRpb25hbCBub3V2ZWF1IGNsZWFudXBzDQo+ID4gDQo+IA0KPiBJIHJhbiBzb21l
IE9wZW5DTCB0ZXN0cyBmcm9tIEplcm9tZSB3aXRoIG5vdXZlYXUgYW5kIHRoaXMgc2VyaWVzLA0K
PiA1LjMuMC1yYzEsIGFuZCBteSB0d28gSE1NIGZpeGVzOg0KPiAoIm1tL2htbTogZml4IFpPTkVf
REVWSUNFIGFub24gcGFnZSBtYXBwaW5nIHJldXNlIikNCj4gKCJtbS9obW06IEZpeCBiYWQgc3Vi
cGFnZSBwb2ludGVyIGluIHRyeV90b191bm1hcF9vbmUiKQ0KPiANCj4gWW91IGNhbiBhZGQgZm9y
IHRoZSBzZXJpZXM6DQo+IFRlc3RlZC1ieTogUmFscGggQ2FtcGJlbGwgPHJjYW1wYmVsbEBudmlk
aWEuY29tPg0KDQpUaGFua3MsIHdvdWxkIHlvdSBhbHNvIHJlYmFzZSBhbmQgcmVzZW5kIHRoZSBw
YXRjaCBkZWxldGluZyANCnN0cnVjdCBobW1fdXBkYXRlID8NCg0KSmFzb24NCg==
