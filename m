Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F06C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709FA2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="GRuCjFxU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406890AbfFKTgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:36:47 -0400
Received: from mail-eopbgr710087.outbound.protection.outlook.com ([40.107.71.87]:35042
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404788AbfFKTgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:36:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FozgdvJxXU4fmDCdYVRN9mpCFP4jCuNp9TjDpIohvts=;
 b=GRuCjFxUHJA7LBbURl9T+dl3kJuT+c2LhpehqhRfsIHYOQnAv4WZrHtr0mJIzJ2/ZyTQz7Rm1US4rOgKZqkGyfXbm+vOOiO4PiO2ks2w4bw1Fl218fGu0P2BZkOHoTQiVaVijZVCnmrdf+vCN2wnZfePc+zXf/E7fE0E7DB2ayw=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4645.namprd05.prod.outlook.com (52.135.233.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.9; Tue, 11 Jun 2019 19:36:37 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::134:af66:bedb:ead9]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::134:af66:bedb:ead9%3]) with mapi id 15.20.1987.008; Tue, 11 Jun 2019
 19:36:37 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Julien Freche <jfreche@vmware.com>,
        Pv-drivers <Pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vmw_ballon: no need to check return value of
 debugfs_create functions
Thread-Topic: [PATCH] vmw_ballon: no need to check return value of
 debugfs_create functions
Thread-Index: AQHVIIdFvmS55Wdtiki3OTqlCZRF+KaW2OaA
Date:   Tue, 11 Jun 2019 19:36:36 +0000
Message-ID: <5A5203EB-A789-4C48-9C25-EF0C0CBCE5CD@vmware.com>
References: <20190611185528.GA4659@kroah.com>
In-Reply-To: <20190611185528.GA4659@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28035a5b-8687-45b0-d53b-08d6eea41e4f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB4645;
x-ms-traffictypediagnostic: BYAPR05MB4645:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <BYAPR05MB46450677E31CDEE31CFBC030D0ED0@BYAPR05MB4645.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 006546F32A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(376002)(396003)(39860400002)(199004)(189003)(66556008)(71200400001)(6436002)(102836004)(478600001)(25786009)(71190400001)(6512007)(66946007)(99286004)(256004)(53936002)(86362001)(83716004)(229853002)(2906002)(6506007)(53546011)(76176011)(6486002)(14454004)(186003)(6116002)(26005)(8936002)(3846002)(66476007)(4744005)(446003)(8676002)(81166006)(81156014)(66446008)(64756008)(5660300002)(4326008)(73956011)(66066001)(316002)(54906003)(76116006)(82746002)(2616005)(6246003)(7736002)(11346002)(68736007)(36756003)(476003)(6916009)(33656002)(486006)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4645;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: a1nSDsGZi5OFWS9JnVfgevHaaIT+gg7Om2Cjn58TcwY2rtR9rG38QNRoCJ+wrJonvTT1HLl2IE35SER4cBzUWHcaEUoWEtoe75BiLnemaA49iFt2w4BEnDEa0NcpSE2O/CFjAXOLF/wcFNIHUwrj4JG3KVAReKr7qkPk/BF4QP2UrEM3OFGSMdSpdfxsLpdJJQa6BX0oxkU0YdLtG0M1TZ+8bMbKTjhY9l0wf9E7kukoNe57NKG/vaUCIR10bEeENJeHJOUAyw/hoYD4SbO3TgVLq2FyhfaE3PRE+QsfH/I2pdb5aIntGI/rnhujideXAnNrupXCrk7NEw8o4ijl487jg3f03aCMZlqcHZAYlrwyX5Zd+V+HmWVwQR+bO/tjZ6bqjj/mmQbvnSZvTzFQ2HlMCbncceQ/9xUs5j1+YWo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <071E573035D3084A979D80ABBDB4A5A1@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28035a5b-8687-45b0-d53b-08d6eea41e4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2019 19:36:36.7950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4645
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGxlYXNlIGNoYW5nZSB0aGUgdGl0bGUgb2YgdGhlIHBhdGNoIHRvIOKAnHZtd19iYWxsb29u4oCd
IChpdCBpcyBjdXJyZW50bHkNCuKAnHZtd19iYWxsb27igJ0pLg0KDQo+IE9uIEp1biAxMSwgMjAx
OSwgYXQgMTE6NTUgQU0sIEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmc+IHdyb3RlOg0KPiANCj4gV2hlbiBjYWxsaW5nIGRlYnVnZnMgZnVuY3Rpb25zLCB0aGVy
ZSBpcyBubyBuZWVkIHRvIGV2ZXIgY2hlY2sgdGhlDQo+IHJldHVybiB2YWx1ZS4gIFRoZSBmdW5j
dGlvbiBjYW4gd29yayBvciBub3QsIGJ1dCB0aGUgY29kZSBsb2dpYyBzaG91bGQNCj4gbmV2ZXIg
ZG8gc29tZXRoaW5nIGRpZmZlcmVudCBiYXNlZCBvbiB0aGlzLg0KDQpJIHJlbWVtYmVyIEkgc2F3
IGEgZGlzY3Vzc2lvbiBhYm91dCBpdCwgYW5kIGRpZG7igJl0IGtub3cgdGhlIHJlc29sdXRpb24u
DQoNCklmIHRoYXQncyB0aGUgZGVjaXNpb24gKGFzc3VtaW5nIGRlYnVnZnMgaW5pdGlhbGl6YXRp
b24gYWx3YXlzIHN1Y2NlZWRzKSwNCmFuZCBhZnRlciBmaXhpbmcgdGhlIHRpdGxlIG9mIHRoZSBw
YXRjaDoNCg0KICBBY2tlZC1ieTogTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJlLmNvbT4NCg0KVGhh
bmtzIQ0KTmFkYXY=
