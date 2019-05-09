Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BCBC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 13:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF42921479
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 13:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rdgXY4Sz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfEINa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 09:30:56 -0400
Received: from mail-eopbgr30079.outbound.protection.outlook.com ([40.107.3.79]:29892
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726546AbfEINa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 09:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ccu23z7PQIRtufCGns6Zu/49zQBpnRCNdHOKoRigAh4=;
 b=rdgXY4SzJPirIRq4Q74mpjWHMuka0YBYutvPBhlfyylW95j8SAkBTtSmdxmbzp2jCendxd9ssLh0HsAv049mnUmEnDHFoOAu5E/mxUodsPCsE7KlKBcb4Tx98zBts8vzhJitaCYruj79XxJnUxb8CP90cPM6pLrcLzCKagzly5c=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB4029.eurprd04.prod.outlook.com (10.171.182.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Thu, 9 May 2019 13:30:37 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::18d6:6f21:db62:4fe7]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::18d6:6f21:db62:4fe7%2]) with mapi id 15.20.1878.022; Thu, 9 May 2019
 13:30:36 +0000
From:   Viorel Suman <viorel.suman@nxp.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Colin Ian King <colin.king@canonical.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@gmail.com>
Subject: [PATCH 2/2] ASoC: ak4458: add return value for ak4458_probe
Thread-Topic: [PATCH 2/2] ASoC: ak4458: add return value for ak4458_probe
Thread-Index: AQHVBmtiJYBm+RLPD0mXhUzjcOIfqg==
Date:   Thu, 9 May 2019 13:30:36 +0000
Message-ID: <1557408607-25115-3-git-send-email-viorel.suman@nxp.com>
References: <1557408607-25115-1-git-send-email-viorel.suman@nxp.com>
In-Reply-To: <1557408607-25115-1-git-send-email-viorel.suman@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0102.eurprd04.prod.outlook.com
 (2603:10a6:803:64::37) To VI1PR04MB4704.eurprd04.prod.outlook.com
 (2603:10a6:803:52::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e9f2f0d-a57c-4f72-2dca-08d6d4828539
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4029;
x-ms-traffictypediagnostic: VI1PR04MB4029:
x-microsoft-antispam-prvs: <VI1PR04MB40290E5697A374790139072A92330@VI1PR04MB4029.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-forefront-prvs: 003245E729
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(39860400002)(396003)(346002)(199004)(189003)(68736007)(36756003)(71200400001)(50226002)(66066001)(52116002)(2501003)(76176011)(5660300002)(8936002)(86362001)(6506007)(478600001)(71190400001)(81166006)(8676002)(386003)(81156014)(2906002)(53936002)(25786009)(4326008)(476003)(305945005)(256004)(6512007)(99286004)(7736002)(2201001)(66476007)(66556008)(64756008)(66446008)(26005)(66946007)(73956011)(110136005)(54906003)(44832011)(11346002)(446003)(486006)(14454004)(186003)(2616005)(316002)(14444005)(3846002)(6486002)(102836004)(6116002)(6436002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4029;H:VI1PR04MB4704.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fiMDnXA/6Rei85xSIWDK+pgKdQb2oiSxrmJenWeXT1gpN4ugu5kVbpXViYIHE5nyJ6d/oi2LB4wCHMOpt/RQRn0sf7OY6x6n2DOK02wLwHx/HhYE+WP6d5/k2b6u3XzlO6Tv3Qm3SP6d5PRzAmIWEsBvzGSO+0KoR1CKDF6mF6DC7/Nu6Gst7j6ZyxY2PgvcOY03g+9btqwacaEFqMGOB+3z8V2PGjnGiwHhPcrVHXBst7Uqg3UWr1l90bnvHyvQem9cq4iqp2GxkeDtA6A74yMctt6Rol2tASCL64LtlFZNt0ihFBx7KQYRkv9EHbCRXkbqtCUXuXfncbc+JAmHbSayXwp+6NambjYr6rJ2Wii7tG/crqCx9NIO/CyOVKIvE188ETUBVImT9HxE+NFMeKJLSrn6fzXFyGGIgyKCqnY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9f2f0d-a57c-4f72-2dca-08d6d4828539
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2019 13:30:36.7929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4029
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QUs0NDU4IGlzIHByb2JlZCBzdWNjZXNzZnVsbHkgZXZlbiBpZiBBSzQ0NTggaXMgbm90IHByZXNl
bnQgLSB0aGlzDQppcyBjYXVzZWQgYnkgcHJvYmUgZnVuY3Rpb24gcmV0dXJuaW5nIG5vIGVycm9y
IG9uIGkyYyBhY2Nlc3MgZmFpbHVyZS4NClJldHVybiBhbiBlcnJvciBvbiBwcm9iZSBpZiBpMmMg
YWNjZXNzIGhhcyBmYWlsZWQuDQoNClNpZ25lZC1vZmYtYnk6IFNoZW5naml1IFdhbmcgPHNoZW5n
aml1LndhbmdAbnhwLmNvbT4NClNpZ25lZC1vZmYtYnk6IFZpb3JlbCBTdW1hbiA8dmlvcmVsLnN1
bWFuQG54cC5jb20+DQotLS0NCiBzb3VuZC9zb2MvY29kZWNzL2FrNDQ1OC5jIHwgMTMgKysrKysr
Ky0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0p
DQoNCmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvY29kZWNzL2FrNDQ1OC5jIGIvc291bmQvc29jL2Nv
ZGVjcy9hazQ0NTguYw0KaW5kZXggNDc5NWUzMi4uZDE5Mjc3NDM1MyAxMDA2NDQNCi0tLSBhL3Nv
dW5kL3NvYy9jb2RlY3MvYWs0NDU4LmMNCisrKyBiL3NvdW5kL3NvYy9jb2RlY3MvYWs0NDU4LmMN
CkBAIC01MzcsOSArNTM3LDEwIEBAIHN0YXRpYyB2b2lkIGFrNDQ1OF9wb3dlcl9vbihzdHJ1Y3Qg
YWs0NDU4X3ByaXYgKmFrNDQ1OCkNCiAJfQ0KIH0NCiANCi1zdGF0aWMgdm9pZCBhazQ0NThfaW5p
dChzdHJ1Y3Qgc25kX3NvY19jb21wb25lbnQgKmNvbXBvbmVudCkNCitzdGF0aWMgaW50IGFrNDQ1
OF9pbml0KHN0cnVjdCBzbmRfc29jX2NvbXBvbmVudCAqY29tcG9uZW50KQ0KIHsNCiAJc3RydWN0
IGFrNDQ1OF9wcml2ICphazQ0NTggPSBzbmRfc29jX2NvbXBvbmVudF9nZXRfZHJ2ZGF0YShjb21w
b25lbnQpOw0KKwlpbnQgcmV0Ow0KIA0KIAkvKiBFeHRlcm5hbCBNdXRlIE9OICovDQogCWlmIChh
azQ0NTgtPm11dGVfZ3Bpb2QpDQpAQCAtNTQ3LDIxICs1NDgsMjEgQEAgc3RhdGljIHZvaWQgYWs0
NDU4X2luaXQoc3RydWN0IHNuZF9zb2NfY29tcG9uZW50ICpjb21wb25lbnQpDQogDQogCWFrNDQ1
OF9wb3dlcl9vbihhazQ0NTgpOw0KIA0KLQlzbmRfc29jX2NvbXBvbmVudF91cGRhdGVfYml0cyhj
b21wb25lbnQsIEFLNDQ1OF8wMF9DT05UUk9MMSwNCisJcmV0ID0gc25kX3NvY19jb21wb25lbnRf
dXBkYXRlX2JpdHMoY29tcG9uZW50LCBBSzQ0NThfMDBfQ09OVFJPTDEsDQogCQkJICAgIDB4ODAs
IDB4ODApOyAgIC8qIEFDS1MgYml0ID0gMTsgMTAwMDAwMDAgKi8NCisJaWYgKHJldCA8IDApDQor
CQlyZXR1cm4gcmV0Ow0KIA0KLQlhazQ0NThfcnN0bl9jb250cm9sKGNvbXBvbmVudCwgMSk7DQor
CXJldHVybiBhazQ0NThfcnN0bl9jb250cm9sKGNvbXBvbmVudCwgMSk7DQogfQ0KIA0KIHN0YXRp
YyBpbnQgYWs0NDU4X3Byb2JlKHN0cnVjdCBzbmRfc29jX2NvbXBvbmVudCAqY29tcG9uZW50KQ0K
IHsNCiAJc3RydWN0IGFrNDQ1OF9wcml2ICphazQ0NTggPSBzbmRfc29jX2NvbXBvbmVudF9nZXRf
ZHJ2ZGF0YShjb21wb25lbnQpOw0KIA0KLQlhazQ0NThfaW5pdChjb21wb25lbnQpOw0KLQ0KIAlh
azQ0NTgtPmZzID0gNDgwMDA7DQogDQotCXJldHVybiAwOw0KKwlyZXR1cm4gYWs0NDU4X2luaXQo
Y29tcG9uZW50KTsNCiB9DQogDQogc3RhdGljIHZvaWQgYWs0NDU4X3JlbW92ZShzdHJ1Y3Qgc25k
X3NvY19jb21wb25lbnQgKmNvbXBvbmVudCkNCi0tIA0KMi43LjQNCg0K
