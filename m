Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C867C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76FD2089E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iYcnVm1+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfDZIFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:05:47 -0400
Received: from mail-eopbgr10086.outbound.protection.outlook.com ([40.107.1.86]:9345
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726349AbfDZIFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 04:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDxScm3988Q5Xz4COHRAzEVgZOh7qs8DggdvCKAjv2w=;
 b=iYcnVm1+kdZq5dOct6EaNNFwBbGd2JBhp01rCYnIx1paT5Y9bvO3v46TyfwkrJipyqneeLTVgHok6xcmH/9d6pKoDJCwzDN9+1n/GVOqQ+ahjQ7WEFttlu2pU3I9w0VrfxYrIz9Kz4EsRc/kJC7QCp4ND/q59ns2VNr11k97O6E=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB4830.eurprd04.prod.outlook.com (20.177.49.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Fri, 26 Apr 2019 08:05:40 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 08:05:40 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: [PATCH v2 06/15] spi: imx: fix ERR009165
Thread-Topic: [PATCH v2 06/15] spi: imx: fix ERR009165
Thread-Index: AQHU/AbWhmFw/8q/U0K0862nrKFDRQ==
Date:   Fri, 26 Apr 2019 08:05:40 +0000
Message-ID: <1556265512-9130-7-git-send-email-yibin.gong@nxp.com>
References: <1556265512-9130-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1556265512-9130-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::36) To VI1PR04MB4543.eurprd04.prod.outlook.com
 (2603:10a6:803:6d::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a89fbb38-8aa2-4e67-5c45-08d6ca1df8e4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4830;
x-ms-traffictypediagnostic: VI1PR04MB4830:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB4830415A208D389E5995BE70893E0@VI1PR04MB4830.eurprd04.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(366004)(396003)(376002)(189003)(199004)(36756003)(54906003)(81156014)(50226002)(8676002)(81166006)(8936002)(386003)(26005)(97736004)(2501003)(6506007)(4326008)(316002)(86362001)(3846002)(110136005)(6116002)(14444005)(11346002)(966005)(6436002)(446003)(256004)(66066001)(2906002)(99286004)(52116002)(476003)(5660300002)(186003)(71190400001)(2616005)(25786009)(14454004)(7416002)(53936002)(71200400001)(486006)(305945005)(64756008)(66556008)(6512007)(73956011)(6306002)(66446008)(478600001)(66476007)(2201001)(102836004)(68736007)(66946007)(76176011)(6486002)(7736002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4830;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BteiJtzn7m3ZdSaHpuHFQAq4UDw6BksYH7ytUzDrzTadJ1ZNSCzc+RwR6d8OPlgzU7Pd8JAiYbvTDnfEORCfgJLghXxpD4D2d70GNEsmP+VzgeRx7tETPYzB70cRCsQ5kqCt7nPH8rs5Nl7mWdNnRLj9nhRAVESxkZGmcWcYsO75aYJ2r+3Vd1WvlCBSW5IsD7l6PMgWA3lwiMDrnY1wufd1zO+EaqGnS1OVaIkAepqm+q2kEixUGs2hB75IR5gMSubc2oH6JudFST1yd6Wont8aOBGqAYbaE95NswMBPTvbveY67h/bPqRycOn9AhSKPXl+St6mI/iRUrfCnPCjhjx2uU6N8/iXgF/7mG0He4NQ7C3HmgGEo4DY/HaqfjZlUENHGTP6fQbX9h2bXTazQQTM0h0TpIs+nhlaF2BSEbw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a89fbb38-8aa2-4e67-5c45-08d6ca1df8e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 08:05:40.1924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4830
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
