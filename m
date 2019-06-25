Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2B7C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEEF320863
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="tByNCMOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbfFYHty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:49:54 -0400
Received: from mail-eopbgr40137.outbound.protection.outlook.com ([40.107.4.137]:61105
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726421AbfFYHtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tA6JBJb6oWxZQN8cj41AYPnn1HGbKv2UuwLOigCxT4o=;
 b=tByNCMORj3IF9EmbsjewuOMAK0+noyH8RLinZ/J2aVzTxlMze+AfnkE5SHabH9JZBomM5dQT8g5kRf2NoQBenjTtnunmx6w+PH4T8pqfp+Rm/xoKlYguS6pgFjnMvDHeraVKF7XnxKrxIZOtKZq2HUqTeoT0eOtPjfdNZJjyWho=
Received: from AM6PR05MB6535.eurprd05.prod.outlook.com (20.179.18.16) by
 AM6PR05MB4150.eurprd05.prod.outlook.com (52.135.161.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 07:49:50 +0000
Received: from AM6PR05MB6535.eurprd05.prod.outlook.com
 ([fe80::2c23:fdba:9ce4:7397]) by AM6PR05MB6535.eurprd05.prod.outlook.com
 ([fe80::2c23:fdba:9ce4:7397%7]) with mapi id 15.20.2008.007; Tue, 25 Jun 2019
 07:49:49 +0000
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
Subject: [PATCH v2 2/6] ASoC: sgtl5000: add ADC mute control
Thread-Topic: [PATCH v2 2/6] ASoC: sgtl5000: add ADC mute control
Thread-Index: AQHVKyqRcZ04ncDZBUW/bJGcuQuzmw==
Date:   Tue, 25 Jun 2019 07:49:49 +0000
Message-ID: <20190625074937.2621-3-oleksandr.suvorov@toradex.com>
References: <20190625074937.2621-1-oleksandr.suvorov@toradex.com>
In-Reply-To: <20190625074937.2621-1-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0402CA0035.eurprd04.prod.outlook.com
 (2603:10a6:208:15::48) To AM6PR05MB6535.eurprd05.prod.outlook.com
 (2603:10a6:20b:71::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [194.105.145.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e6064a5-867d-4716-0659-08d6f941b35a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR05MB4150;
x-ms-traffictypediagnostic: AM6PR05MB4150:
x-microsoft-antispam-prvs: <AM6PR05MB4150F79D7B316AAE8CA31400F9E30@AM6PR05MB4150.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:669;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39850400004)(136003)(346002)(376002)(189003)(199004)(6436002)(86362001)(8936002)(6116002)(3846002)(186003)(6486002)(81166006)(81156014)(446003)(102836004)(6506007)(386003)(26005)(486006)(2616005)(11346002)(478600001)(44832011)(8676002)(476003)(305945005)(71190400001)(7736002)(6512007)(54906003)(2906002)(316002)(4326008)(68736007)(71200400001)(66066001)(53936002)(25786009)(50226002)(66946007)(36756003)(73956011)(64756008)(66446008)(14454004)(66556008)(1076003)(66476007)(4744005)(6916009)(5660300002)(52116002)(76176011)(99286004)(256004)(1411001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR05MB4150;H:AM6PR05MB6535.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FgKBrGWsHlyXSjqSkXA2jhegJfKn/kQMLHPhSyaMQ9eXlnh0boGHHZQINXzmmIFJcrZBx6hf4H1b88GUc0MMP1AS00sxXz1oBnnDUYwQZy9CfHUqTK8gAfdOGeEkpg8glzN1AuyCbHXDy6eMAtCLQq0jMBRehn+nIsL66yO/qsasCxHxOZLlh2nP++AW1tt0ihpCYft7C+yZFzess0D+eF3UzWiQFGZEezlimCDjQ0jSHkpmvlN/zSNUFDkQm59FoCoTgntmfgIF0isTmleogsMWhwyHloAGQM+xRti3z4hVHyI1GpG+uLQvL77dSJXQi2vPhpu5DBm1wJkr/bN5Qh9QxfFIcDcSjSF5PgpDfmISmNFXTY0VF+FSMtJHE2GE/NVaL5FGXdgNqS+SQDIpajrTl8bV3hAiQs77ILt16Pg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6064a5-867d-4716-0659-08d6f941b35a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 07:49:49.9374
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

VGhpcyBjb250cm9sIG11dGUvdW5tdXRlIHRoZSBBREMgaW5wdXQgb2YgU0dUTDUwMDANCnVzaW5n
IGl0cyBDSElQX0FOQV9DVFJMIHJlZ2lzdGVyLg0KDQpTaWduZWQtb2ZmLWJ5OiBPbGVrc2FuZHIg
U3V2b3JvdiA8b2xla3NhbmRyLnN1dm9yb3ZAdG9yYWRleC5jb20+DQotLS0NCg0KIHNvdW5kL3Nv
Yy9jb2RlY3Mvc2d0bDUwMDAuYyB8IDEgKw0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KQ0KDQpkaWZmIC0tZ2l0IGEvc291bmQvc29jL2NvZGVjcy9zZ3RsNTAwMC5jIGIvc291bmQvc29j
L2NvZGVjcy9zZ3RsNTAwMC5jDQppbmRleCA1ZTQ5NTIzZWUwYjY3Li5iYjU4Yzk5N2M2OTE0IDEw
MDY0NA0KLS0tIGEvc291bmQvc29jL2NvZGVjcy9zZ3RsNTAwMC5jDQorKysgYi9zb3VuZC9zb2Mv
Y29kZWNzL3NndGw1MDAwLmMNCkBAIC01NTYsNiArNTU2LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBzbmRfa2NvbnRyb2xfbmV3IHNndGw1MDAwX3NuZF9jb250cm9sc1tdID0gew0KIAkJCVNHVEw1
MDAwX0NISVBfQU5BX0FEQ19DVFJMLA0KIAkJCTgsIDEsIDAsIGNhcHR1cmVfNmRiX2F0dGVudWF0
ZSksDQogCVNPQ19TSU5HTEUoIkNhcHR1cmUgWkMgU3dpdGNoIiwgU0dUTDUwMDBfQ0hJUF9BTkFf
Q1RSTCwgMSwgMSwgMCksDQorCVNPQ19TSU5HTEUoIkNhcHR1cmUgU3dpdGNoIiwgU0dUTDUwMDBf
Q0hJUF9BTkFfQ1RSTCwgMCwgMSwgMSksDQogDQogCVNPQ19ET1VCTEVfVExWKCJIZWFkcGhvbmUg
UGxheWJhY2sgVm9sdW1lIiwNCiAJCQlTR1RMNTAwMF9DSElQX0FOQV9IUF9DVFJMLA0KLS0gDQoy
LjIwLjENCg0K
