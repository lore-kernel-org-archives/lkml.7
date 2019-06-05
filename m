Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14558C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26F920872
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="FFPzZ+V1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbfFEOlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 10:41:47 -0400
Received: from mail-eopbgr140101.outbound.protection.outlook.com ([40.107.14.101]:24487
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728283AbfFEOlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 10:41:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5KmD+P4vEqVwKRS9x0iCBOGut9A2SxHAJWxBcFUPug=;
 b=FFPzZ+V1bnXSg/HIJrbS0b+04wXM+hd2CixOnC3z9fkksU7nrUyndE3FvJ3rNyeJe2Ctncucu6V88zLtRXj/LVcwVjakHVt54K1/IXZaPP6l5bzpq2u3TrniUwFbjl8vx9kMXGRWWD4LlcuH2ELcn27nKry2ehdeDNLR4P4FF8k=
Received: from VI1PR07MB3165.eurprd07.prod.outlook.com (10.175.243.15) by
 VI1PR07MB5006.eurprd07.prod.outlook.com (20.177.201.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Wed, 5 Jun 2019 14:41:41 +0000
Received: from VI1PR07MB3165.eurprd07.prod.outlook.com
 ([fe80::1403:5377:c11d:a41a]) by VI1PR07MB3165.eurprd07.prod.outlook.com
 ([fe80::1403:5377:c11d:a41a%7]) with mapi id 15.20.1965.011; Wed, 5 Jun 2019
 14:41:41 +0000
From:   "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
To:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Vas Dias <jason.vas.dias@gmail.com>
Subject: [PATCH v3 0/2] x86/vdso: CLOCK_MONOTONIC_RAW implementation
Thread-Topic: [PATCH v3 0/2] x86/vdso: CLOCK_MONOTONIC_RAW implementation
Thread-Index: AQHVG6zJXpStcOxGJ0Sjhi5ynZzqMQ==
Date:   Wed, 5 Jun 2019 14:41:41 +0000
Message-ID: <20190605144116.28553-1-alexander.sverdlin@nokia.com>
In-Reply-To: <CALCETrW6aE--Fo3qnK2zCAis5C-NraZtie4RBw59DVmzg5K_oA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [131.228.32.181]
x-mailer: git-send-email 2.21.0
x-clientproxiedby: HE1PR06CA0156.eurprd06.prod.outlook.com
 (2603:10a6:7:16::43) To VI1PR07MB3165.eurprd07.prod.outlook.com
 (2603:10a6:802:21::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 624be506-34f6-44a9-5abb-08d6e9c3ec40
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR07MB5006;
x-ms-traffictypediagnostic: VI1PR07MB5006:
x-microsoft-antispam-prvs: <VI1PR07MB5006DDDE865B125BF8C42F9F88160@VI1PR07MB5006.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:669;
x-forefront-prvs: 00594E8DBA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(136003)(39860400002)(366004)(376002)(189003)(199004)(54534003)(508600001)(476003)(11346002)(2616005)(14454004)(186003)(102836004)(486006)(316002)(256004)(99286004)(86362001)(53936002)(3846002)(36756003)(26005)(71190400001)(71200400001)(7736002)(386003)(4744005)(6116002)(2501003)(81156014)(68736007)(25786009)(81166006)(8676002)(4326008)(50226002)(110136005)(54906003)(66446008)(6512007)(2906002)(64756008)(52116002)(66946007)(66476007)(5660300002)(73956011)(66556008)(66066001)(1076003)(6436002)(6486002)(305945005)(8936002)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB5006;H:VI1PR07MB3165.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VphOE/ox0fRnT5qC+Q0/l3TtPWnkaJWD2tfko1ev7Pxhbj+P7c/i2nhhx7N7ecL2+F0w4/mMdbPb5NyJmOLLJKyVIrDusZe1mHrkNG3wGbTdZd6Hj2qCozOPykN0RxmaD+Eymtoc8juQaCZChCeP8iGeGWrGCEMjWkxPpIhbsTvov2DKU40N5L1Eg14O4r9KRtYigjspydmteYhFvQyZZJsNWMyz/64mxVqKFRPVDY1hFY08/Hpn4wKMM5PF7HQODiGa6bZVSRteMfWpOdHnCZS5aHdlDA2SomgHIv/jEhQqRF84fZeTIyDZQYxEiD5Gf7Xq90geIwHZUYWh1FSMW+8gM3zDitPnGJRrxcuw7l5u3SKHfvpOG8x/ySXu1Iji0ROtdWvoMV+CYz7Tx2AJi7OJEayXP7YMVaH4qKn3Yv8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 624be506-34f6-44a9-5abb-08d6e9c3ec40
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2019 14:41:41.4426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alexander.sverdlin@nokia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB5006
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Abm9raWEuY29tPg0K
DQpUcml2aWFsIHZEU08gaW1wbGVtZW50YXRpb24gc2F2ZXMgYSBzeXNjYWxsIGFuZCBicmluZ3Mg
NzAwJSBwZXJmb3JtYW5jZQ0KYm9vc3Qgb2YgY2xvY2tfZ2V0dGltZShDTE9DS19NT05PVE9OSUNf
UkFXLCAuLi4pIGNhbGwuDQoNCkNoYW5nZWxvZzoNCnYzOiBNb3ZlIG11bHQgYW5kIHNoaWZ0IGlu
dG8gc3RydWN0IHZndG9kX3RzDQp2MjogY29weSBkb19ocmVzKCkgaW50byBkb19tb25vdG9uaWNf
cmF3KCkNCg0KQWxleGFuZGVyIFN2ZXJkbGluICgyKToNCiAgeDg2L3Zkc286IE1vdmUgbXVsdCBh
bmQgc2hpZnQgaW50byBzdHJ1Y3Qgdmd0b2RfdHMNCiAgeDg2L3Zkc286IGltcGxlbWVudCBjbG9j
a19nZXR0aW1lKENMT0NLX01PTk9UT05JQ19SQVcsIC4uLikNCg0KIGFyY2gveDg2L2VudHJ5L3Zk
c28vdmNsb2NrX2dldHRpbWUuYyAgICB8ICA0ICsrLS0NCiBhcmNoL3g4Ni9lbnRyeS92c3lzY2Fs
bC92c3lzY2FsbF9ndG9kLmMgfCAxNCArKysrKysrKysrKystLQ0KIGFyY2gveDg2L2luY2x1ZGUv
YXNtL3ZndG9kLmggICAgICAgICAgICB8ICA3ICsrKystLS0NCiAzIGZpbGVzIGNoYW5nZWQsIDE4
IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi40LjYNCg0K
