Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BF2C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 06:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EDF420859
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 06:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gSxqH5Wn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfDVGOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 02:14:12 -0400
Received: from mail-eopbgr720060.outbound.protection.outlook.com ([40.107.72.60]:41520
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725914AbfDVGOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 02:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPWh08xBs3gR8q1bg3iKfSiiRsmxZYe/ytiK/H2IejM=;
 b=gSxqH5Wnqhkubj3PrV55a12TXiMo8yrITmjyL02PYDQEuiI0jRGesGjpwCeI5ZmBk14XrCPiDxDrIk4FccfOs21h4q+L2affIIrGsrO0zTiOg1zpxk0CVZBFp/aRdTcHVrRSQg8Cot1PAJgGoLvIhiYfiGcD8cGfiF/bs5GCBzU=
Received: from MN2PR12MB2878.namprd12.prod.outlook.com (20.179.80.143) by
 MN2PR12MB3069.namprd12.prod.outlook.com (20.178.241.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Mon, 22 Apr 2019 06:14:07 +0000
Received: from MN2PR12MB2878.namprd12.prod.outlook.com
 ([fe80::c5a0:395e:b9c6:4e5a]) by MN2PR12MB2878.namprd12.prod.outlook.com
 ([fe80::c5a0:395e:b9c6:4e5a%6]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 06:14:07 +0000
From:   "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
CC:     "Agrawal, Akshu" <Akshu.Agrawal@amd.com>,
        "djkurtz@chromium.org" <djkurtz@chromium.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Adam.Thomson.Opensource@diasemi.com" 
        <Adam.Thomson.Opensource@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: DA7219: Fix failure in hw_params by not letting
 set_rate error out
Thread-Topic: [PATCH] ASoC: DA7219: Fix failure in hw_params by not letting
 set_rate error out
Thread-Index: AQHU+NKXxx2OJXUZeEu60aoSrd+M3A==
Date:   Mon, 22 Apr 2019 06:14:07 +0000
Message-ID: <20190422061334.4243-1-akshu.agrawal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0150.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::20) To MN2PR12MB2878.namprd12.prod.outlook.com
 (2603:10b6:208:aa::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c500031-3daf-4f6b-3c93-08d6c6e9b9e1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR12MB3069;
x-ms-traffictypediagnostic: MN2PR12MB3069:
x-microsoft-antispam-prvs: <MN2PR12MB306942D8729D67CFF249B12EF8220@MN2PR12MB3069.namprd12.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(68736007)(478600001)(6512007)(4326008)(2906002)(14454004)(109986005)(66446008)(73956011)(64756008)(36756003)(25786009)(6116002)(72206003)(102836004)(66946007)(52116002)(66556008)(66476007)(256004)(71200400001)(71190400001)(53936002)(6506007)(386003)(6486002)(86362001)(5660300002)(66066001)(316002)(186003)(81166006)(81156014)(8676002)(486006)(26005)(6436002)(99286004)(50226002)(7736002)(8936002)(54906003)(97736004)(3846002)(59246006)(1076003)(476003)(2616005)(1671002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3069;H:MN2PR12MB2878.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1KrobSzDhTHKZqSOvgg4RZ0PE4I4dXtGfBMh6WnuO3DPaDEywu5E96I1cLYWv6VAYkhA7bF8oIzS+/TV19VjoGD4S3CjzMsVj1LPoPYjmKQ/XWN6PiZ7fruhqn3NgQWfgBfsuIvzl7s/GtVTCWp/yyOqTaYZGYmuV40ql4jTm4FGh9WhKE7nYljQ5cIFbA4476l6Npj1HvfnTfj9jBDTYpsko0Z9wZh8DdmJ1QaLLixqJlF7l01K7e/1x7XcYgh1977ETekdSiB2w4aPtAFGraTUFogXoAKfgtRw4PCVLhLSOBX7pptJcXMBoazppw3x4HxxIqere149/GqEhSwYzcWDOn8insUrAIp4efviw6vU9Bsk381ofkLS6o3N6tdOyBCiaZu1Hwyy7V6L+/bV5/GaQds8AyaqmtJFnC2QF4c=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c500031-3daf-4f6b-3c93-08d6c6e9b9e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 06:14:07.3683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3069
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2UgbmVlZCB0byBzZXQgbWluaW11bSBiY2xrIDY0eCBvZiB3Y2xrIGFzIHRoaXMgaXMgaHcgY29u
c3RyYWludCBpbiBvbmUNCm9mIHRoZSBjb21wb25lbnQgdXNlZC4NClNpbmNlLCBjbGtfc2V0X3Jh
dGUgYW5kIGNsayBpcyBlbmFibGVkIGluIG1hY2hpbmUgZHJpdmVyIHRoZQ0KY2xrX3NldF9yYXRl
IGluIGh3X3BhcmFtcyBvZiBkYTcyMTkgZmFpbHMgYW5kIGVycm9ycyBvdXQgYW5kIHdoZW4gaXQN
CnRyaWVzIHRvIG92ZXJyaWRlIHRoZSB2YWx1ZS4NCg0KSW4gY2FzZXMgbGlrZSB0aGVzZSBub3Qg
b25seSBjbGtfc2V0X3JhdGUgb2YgZGE3MjE5IGNvZGVjIHNob3VsZCBmYWlsDQphbmQgbm90IG92
ZXJyaWRlIHRoZSB2YWx1ZSBidXQgYWxzbyBzaG91bGQgbm90IGVycm9yIG91dC4NCg0KU2lnbmVk
LW9mZi1ieTogQWtzaHUgQWdyYXdhbCA8YWtzaHUuYWdyYXdhbEBhbWQuY29tPg0KLS0tDQogc291
bmQvc29jL2NvZGVjcy9kYTcyMTkuYyB8IDggKy0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDcgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvY29k
ZWNzL2RhNzIxOS5jIGIvc291bmQvc29jL2NvZGVjcy9kYTcyMTkuYw0KaW5kZXggNWY1ZmEzNDE2
YWYzLi5hMDQxZGJmNDQyYWYgMTAwNjQ0DQotLS0gYS9zb3VuZC9zb2MvY29kZWNzL2RhNzIxOS5j
DQorKysgYi9zb3VuZC9zb2MvY29kZWNzL2RhNzIxOS5jDQpAQCAtMTYyMSwxMyArMTYyMSw3IEBA
IHN0YXRpYyBpbnQgZGE3MjE5X2h3X3BhcmFtcyhzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1
YnN0cmVhbSwNCiANCiAJCWlmIChiY2xrKSB7DQogCQkJYmNsa19yYXRlID0gZnJhbWVfc2l6ZSAq
IHNyOw0KLQkJCXJldCA9IGNsa19zZXRfcmF0ZShiY2xrLCBiY2xrX3JhdGUpOw0KLQkJCWlmIChy
ZXQpIHsNCi0JCQkJZGV2X2Vycihjb21wb25lbnQtPmRldiwNCi0JCQkJCSJGYWlsZWQgdG8gc2V0
IEJDTEsgcmF0ZSAlbHU6ICVkXG4iLA0KLQkJCQkJYmNsa19yYXRlLCByZXQpOw0KLQkJCQlyZXR1
cm4gcmV0Ow0KLQkJCX0NCisJCQljbGtfc2V0X3JhdGUoYmNsaywgYmNsa19yYXRlKTsNCiAJCX0g
ZWxzZSB7DQogCQkJcmV0ID0gZGE3MjE5X3NldF9iY2xrc19wZXJfd2Nsayhjb21wb25lbnQsIGZy
YW1lX3NpemUpOw0KIAkJCWlmIChyZXQpIHsNCi0tIA0KMi4xNy4xDQoNCg==
