Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752DBC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C5621841
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RlcvyqxH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbfDWNvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:51:12 -0400
Received: from mail-eopbgr20053.outbound.protection.outlook.com ([40.107.2.53]:30134
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727758AbfDWNvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDxScm3988Q5Xz4COHRAzEVgZOh7qs8DggdvCKAjv2w=;
 b=RlcvyqxHlcyK6VEJNwMrE/fPeq50bracLree3GvRTUFcQmVmtHICQH2uMWUMGB1mXHYsPSZ11EQHgZ14ubCVNTqAisA0szxySBEbG14H427i0Y76Q61HMGZP6puijm9SUCmVNbCYtoPDhZwkqgWKM2KWZXMZ+FGOFZ1ceD1dNG8=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB5901.eurprd04.prod.outlook.com (20.178.205.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Tue, 23 Apr 2019 13:51:05 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1813.017; Tue, 23 Apr 2019
 13:51:05 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "sean.nyekjaer@prevas.dk" <sean.nyekjaer@prevas.dk>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: [PATCH v1 06/15] spi: imx: fix ERR009165
Thread-Topic: [PATCH v1 06/15] spi: imx: fix ERR009165
Thread-Index: AQHU+duY3N9cIuyM1kayzyI4cQvfJA==
Date:   Tue, 23 Apr 2019 13:51:05 +0000
Message-ID: <1556027045-5269-7-git-send-email-yibin.gong@nxp.com>
References: <1556027045-5269-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1556027045-5269-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0044.apcprd04.prod.outlook.com
 (2603:1096:202:14::12) To VI1PR04MB4543.eurprd04.prod.outlook.com
 (2603:10a6:803:6d::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 152b1fb3-2674-400c-d5bb-08d6c7f2bb1e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5901;
x-ms-traffictypediagnostic: VI1PR04MB5901:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB5901A0D6713CD5D34B3004EF89230@VI1PR04MB5901.eurprd04.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(376002)(346002)(39860400002)(199004)(189003)(6506007)(102836004)(86362001)(97736004)(386003)(7416002)(36756003)(14444005)(2201001)(25786009)(4326008)(305945005)(26005)(256004)(73956011)(71190400001)(71200400001)(7736002)(64756008)(66556008)(66476007)(478600001)(66446008)(66946007)(11346002)(316002)(14454004)(446003)(81156014)(8676002)(68736007)(54906003)(81166006)(2501003)(966005)(8936002)(186003)(5660300002)(6436002)(110136005)(3846002)(6116002)(6486002)(53936002)(66066001)(6512007)(486006)(476003)(99286004)(76176011)(50226002)(2616005)(52116002)(2906002)(6306002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5901;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mqhjHg3Svb/iYa1sV+2nNADYiOKUfd6Ji3wepVnyb936VEXyOn6awtnK3fvEf5lkK/4P3Xi767w4eUq/gwbr0yl4hpU5uLeo0czzaRY/YfkLTH51hzmD9M6TfW7p3BdAJihPXH96YCqxblZTBT4X73WffTKL/4ZRXFv/SuQ9IkdduT0mUA4NMzjsIMeBRM++Y8PyQGeHEJv5MmZv0Xf87//aHlFLeRakPp/4c0TXirfSdLjGjvzCymTu1vi6z1uGpMV3qkdR8UM7d0mgdjS+c2EauqGSxsV8mnWQ9zIwQUSH9sTWZBEVmP3nLZi7Qr8Ke3KD4h1w4FMdViCfmxH94ijzxDSDkHqhSnUvjxnvlu5HB7UnPfyNxLsP9esKq+Epf+KRwG3VEVsqqkpfks30lvn2xMdOyd/BgA3oNrsw/6Y=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 152b1fb3-2674-400c-d5bb-08d6c7f2bb1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 13:51:05.8179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5901
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlIHRvIFhDSCAgbW9kZSBldmVuIGluIGRtYSBtb2RlLCBwbGVhc2UgcmVmZXIgdG8gdGhl
IGJlbG93DQplcnJhdGE6DQpodHRwczovL3d3dy5ueHAuY29tL2RvY3MvZW4vZXJyYXRhL0lNWDZE
UUNFLnBkZg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+
DQotLS0NCiBkcml2ZXJzL3NwaS9zcGktaW14LmMgfCAxMSArKysrKy0tLS0tLQ0KIDEgZmlsZSBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9k
cml2ZXJzL3NwaS9zcGktaW14LmMgYi9kcml2ZXJzL3NwaS9zcGktaW14LmMNCmluZGV4IDA5Yzlh
MWUuLmViNTZlYWMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3NwaS9zcGktaW14LmMNCisrKyBiL2Ry
aXZlcnMvc3BpL3NwaS1pbXguYw0KQEAgLTU4NSw4ICs1ODUsOSBAQCBzdGF0aWMgaW50IG14NTFf
ZWNzcGlfcHJlcGFyZV90cmFuc2ZlcihzdHJ1Y3Qgc3BpX2lteF9kYXRhICpzcGlfaW14LA0KIAlj
dHJsIHw9IG14NTFfZWNzcGlfY2xrZGl2KHNwaV9pbXgsIHQtPnNwZWVkX2h6LCAmY2xrKTsNCiAJ
c3BpX2lteC0+c3BpX2J1c19jbGsgPSBjbGs7DQogDQorCS8qIEVSUjAwOTE2NTogd29yayBpbiBY
SEMgbW9kZSBhcyBQSU8gKi8NCiAJaWYgKHNwaV9pbXgtPnVzZWRtYSkNCi0JCWN0cmwgfD0gTVg1
MV9FQ1NQSV9DVFJMX1NNQzsNCisJCWN0cmwgJj0gfk1YNTFfRUNTUElfQ1RSTF9TTUM7DQogDQog
CXdyaXRlbChjdHJsLCBzcGlfaW14LT5iYXNlICsgTVg1MV9FQ1NQSV9DVFJMKTsNCiANCkBAIC02
MTIsMTIgKzYxMywxNCBAQCBzdGF0aWMgaW50IG14NTFfZWNzcGlfcHJlcGFyZV90cmFuc2Zlcihz
dHJ1Y3Qgc3BpX2lteF9kYXRhICpzcGlfaW14LA0KIA0KIHN0YXRpYyB2b2lkIG14NTFfc2V0dXBf
d21sKHN0cnVjdCBzcGlfaW14X2RhdGEgKnNwaV9pbXgpDQogew0KKwl1MzIgdHhfd21sID0gMDsN
CisNCiAJLyoNCiAJICogQ29uZmlndXJlIHRoZSBETUEgcmVnaXN0ZXI6IHNldHVwIHRoZSB3YXRl
cm1hcmsNCiAJICogYW5kIGVuYWJsZSBETUEgcmVxdWVzdC4NCiAJICovDQogCXdyaXRlbChNWDUx
X0VDU1BJX0RNQV9SWF9XTUwoc3BpX2lteC0+d21sIC0gMSkgfA0KLQkJTVg1MV9FQ1NQSV9ETUFf
VFhfV01MKHNwaV9pbXgtPndtbCkgfA0KKwkJTVg1MV9FQ1NQSV9ETUFfVFhfV01MKHR4X3dtbCkg
fA0KIAkJTVg1MV9FQ1NQSV9ETUFfUlhUX1dNTChzcGlfaW14LT53bWwpIHwNCiAJCU1YNTFfRUNT
UElfRE1BX1RFREVOIHwgTVg1MV9FQ1NQSV9ETUFfUlhERU4gfA0KIAkJTVg1MV9FQ1NQSV9ETUFf
UlhUREVOLCBzcGlfaW14LT5iYXNlICsgTVg1MV9FQ1NQSV9ETUEpOw0KQEAgLTEyNjUsMTAgKzEy
NjgsNiBAQCBzdGF0aWMgaW50IHNwaV9pbXhfc2RtYV9pbml0KHN0cnVjdCBkZXZpY2UgKmRldiwg
c3RydWN0IHNwaV9pbXhfZGF0YSAqc3BpX2lteCwNCiB7DQogCWludCByZXQ7DQogDQotCS8qIHVz
ZSBwaW8gbW9kZSBmb3IgaS5teDZkbCBjaGlwIFRLVDIzODI4NSAqLw0KLQlpZiAob2ZfbWFjaGlu
ZV9pc19jb21wYXRpYmxlKCJmc2wsaW14NmRsIikpDQotCQlyZXR1cm4gMDsNCi0NCiAJc3BpX2lt
eC0+d21sID0gc3BpX2lteC0+ZGV2dHlwZV9kYXRhLT5maWZvX3NpemUgLyAyOw0KIA0KIAkvKiBQ
cmVwYXJlIGZvciBUWCBETUE6ICovDQotLSANCjIuNy40DQoNCg==
