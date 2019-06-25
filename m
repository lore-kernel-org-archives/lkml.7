Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2A7C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6A020659
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="tK3riVJh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbfFYHtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:49:49 -0400
Received: from mail-eopbgr40137.outbound.protection.outlook.com ([40.107.4.137]:61105
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726421AbfFYHtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHR/0vJ9DW+Tr9a7Xxa0r8CDIijW+9BsGtKkpiiJgpg=;
 b=tK3riVJh1c3Zx0M489pyCqsP9RipMHN3bipulWvW3T/hOZQRNZhx9CQvBWAABk2VW5RcC97e9/NC77j7GgShbaRwQL9KFMDeNeoQn4j5tHn6PiOuNsUJNJTN3jrQ8FJF4o4IKhk1hQNDB34eH8zkgCKFyDbX5xLY2Sr2RStf3/4=
Received: from AM6PR05MB6535.eurprd05.prod.outlook.com (20.179.18.16) by
 AM6PR05MB4150.eurprd05.prod.outlook.com (52.135.161.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 07:49:45 +0000
Received: from AM6PR05MB6535.eurprd05.prod.outlook.com
 ([fe80::2c23:fdba:9ce4:7397]) by AM6PR05MB6535.eurprd05.prod.outlook.com
 ([fe80::2c23:fdba:9ce4:7397%7]) with mapi id 15.20.2008.007; Tue, 25 Jun 2019
 07:49:45 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v2 0/6] VAG power control improvement for sgtl5000 codec
Thread-Topic: [PATCH v2 0/6] VAG power control improvement for sgtl5000 codec
Thread-Index: AQHVKyqOVMQ54KRKhUyEgktDhHywAw==
Date:   Tue, 25 Jun 2019 07:49:45 +0000
Message-ID: <20190625074937.2621-1-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR10CA0001.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::11) To AM6PR05MB6535.eurprd05.prod.outlook.com
 (2603:10a6:20b:71::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [194.105.145.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b592082c-aae5-4036-ce2f-08d6f941b02d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR05MB4150;
x-ms-traffictypediagnostic: AM6PR05MB4150:
x-microsoft-antispam-prvs: <AM6PR05MB4150189D5D3FE0DDF2B392B9F9E30@AM6PR05MB4150.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39850400004)(136003)(346002)(376002)(189003)(199004)(6436002)(86362001)(8936002)(6116002)(3846002)(186003)(6486002)(81166006)(81156014)(102836004)(6506007)(386003)(26005)(486006)(2616005)(478600001)(44832011)(8676002)(476003)(305945005)(71190400001)(7736002)(6512007)(54906003)(2906002)(316002)(4326008)(68736007)(71200400001)(66066001)(53936002)(25786009)(50226002)(66946007)(36756003)(73956011)(64756008)(66446008)(14454004)(66556008)(1076003)(66476007)(6916009)(5660300002)(52116002)(99286004)(256004)(14444005)(1411001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR05MB4150;H:AM6PR05MB6535.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fG8wenrS1ASyMNXxEaqmp8aKTpY/yCbzzUJgAzIk9krWv9LeoAqesacu9ToypRAl1oXS9gsgPCw/pKqorqbeqcHEM6sJoDWymN2u5VlXTpCxtA0OnRaHOTb8GfTeydB+yWLULbNSIn03s2zi68n5bqy9pnpykz6dqI70CYcxeAANNkcimVU/JdKaSC2AbpB9FRemqiIJ9AiGESWFJlKdWx/eNiVKvf2PxVQZlGXM7RPYMKMcFGhCfK2aJW5Mjx7C0nE3KSIjt1uHGtpB4ho0zfIO6FdQol1FNttvrMd5NnW19BLu5t+XbGGzjAPKSfz36TwZGrGWPv2PCU30FAeRKDi8zbUlQIcroFvI0C4q6EQAWnUtvO3V3bTN9TsnrtfrZPJGTOYkzc0YO31d6sVpkD/IytdCkfHX/HxORdgO+KM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b592082c-aae5-4036-ce2f-08d6f941b02d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 07:49:45.4509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oleksandr.suvorov@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpWQUcgcG93ZXIgY29udHJvbCBpcyBpbXByb3ZlZCB0byBmaXQgdGhlIG1hbnVhbC4gVGhpcyBm
aXhlcyBhcw0KbWluaW11bSBvbmUgYnVnOiBpZiBjdXN0b21lciBtdXhlcyBIZWFkcGhvbmUgdG8g
TGluZS1JbiByaWdodCBhZnRlciBib290DQp3L28gcGxheWluZyBhbnkgc291bmQsIHRoZSBWQUcg
cG93ZXIgcmVtYWlucyBvZmYgdGhhdCBsZWFkcyB0byBwb29yDQpzb3VuZCBxdWFsaXR5IGZyb20g
bGluZS1pbi4NCg0KSS5lLiBhZnRlciBib290Og0KLSBDb25uZWN0IHNvdW5kIHNvdXJjZSB0byBM
aW5lLUluIGphY2s7DQotIENvbm5lY3QgaGVhZHBob25lIHRvIEhQIGphY2s7DQotIFJ1biBmb2xs
b3dpbmcgY29tbWFuZHM6DQokIGFtaXhlciBzZXQgJ0hlYWRwaG9uZScgODAlDQokIGFtaXhlciBz
ZXQgJ0hlYWRwaG9uZSBNdXgnIExJTkVfSU4NCg0KQWxzbyB0aGlzIHNlcmllcyBpbmNsdWRlcyBm
aXhlcyBvZiBub24taW1wb3J0YW50IGJ1Z3MgaW4gc2d0bDUwMDAgY29kZWMNCmRyaXZlci4NCg0K
Rml4IHBhdGNoIGZvcm1hdHRpbmcgaW4gcGF0Y2hzZXQgdjIuDQoNCg0KT2xla3NhbmRyIFN1dm9y
b3YgKDYpOg0KICBBU29DOiBzZ3RsNTAwMDogRml4IGRlZmluaXRpb24gb2YgVkFHIFJhbXAgQ29u
dHJvbA0KICBBU29DOiBzZ3RsNTAwMDogYWRkIEFEQyBtdXRlIGNvbnRyb2wNCiAgQVNvQzogc2d0
bDUwMDA6IEZpeCBvZiB1bm11dGUgb3V0cHV0cyBvbiBwcm9iZQ0KICBBU29DOiBzZ3RsNTAwMDog
Rml4IGNoYXJnZSBwdW1wIHNvdXJjZSBhc3NpZ25tZW50DQogIEFTb0M6IERlZmluZSBhIHNldCBv
ZiBEQVBNIHByZS9wb3N0LXVwIGV2ZW50cw0KICBBU29DOiBzZ3RsNTAwMDogSW1wcm92ZSBWQUcg
cG93ZXIgYW5kIG11dGUgY29udHJvbA0KDQogaW5jbHVkZS9zb3VuZC9zb2MtZGFwbS5oICAgIHwg
ICAyICsNCiBzb3VuZC9zb2MvY29kZWNzL3NndGw1MDAwLmMgfCAyNTAgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrLS0tLS0tDQogc291bmQvc29jL2NvZGVjcy9zZ3RsNTAwMC5oIHwgICAy
ICstDQogMyBmaWxlcyBjaGFuZ2VkLCAyMTIgaW5zZXJ0aW9ucygrKSwgNDIgZGVsZXRpb25zKC0p
DQoNCi0tIA0KMi4yMC4xDQoNCg==
