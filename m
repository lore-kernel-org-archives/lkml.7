Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF25C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 06:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81CB62082F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 06:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kcbKRt5R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfEEGTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 02:19:03 -0400
Received: from mail-eopbgr80080.outbound.protection.outlook.com ([40.107.8.80]:46711
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726846AbfEEGTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 02:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jy5klBXohqkhr/d8PTb5lbUr957CztOnm8TydtplmXc=;
 b=kcbKRt5RikDnzoVSNepczO3ZbnRKy1U4oNMfnbANAVLH5xJG1YuaIlwFYByJOOqne6bosHzYngMSxkLK+67XonT2YhIhAhxRl/rn6W6y6tZCK0nXU054BkjDeMyLyJEx4hLRCDkFSErD7JXfpvPkgowpOjxCFlxg2Rwjc9epOoc=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3947.eurprd04.prod.outlook.com (52.134.67.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Sun, 5 May 2019 06:18:48 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1856.012; Sun, 5 May 2019
 06:18:48 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "pp@emlix.com" <pp@emlix.com>,
        "tiny.windzz@gmail.com" <tiny.windzz@gmail.com>,
        "colin.didier@devialet.com" <colin.didier@devialet.com>,
        "robh@kernel.org" <robh@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "hofrat@osadl.org" <hofrat@osadl.org>,
        "michael@amarulasolutions.com" <michael@amarulasolutions.com>,
        "stefan@agner.ch" <stefan@agner.ch>, Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 1/2] clk: imx: Add common API for masking MMDC handshake
Thread-Topic: [PATCH 1/2] clk: imx: Add common API for masking MMDC handshake
Thread-Index: AQHVAwpmnCdleDO3TECDUWrDtJQRdA==
Date:   Sun, 5 May 2019 06:18:48 +0000
Message-ID: <1557036830-13567-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0001.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::13) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b243de87-7dfc-4576-7ca2-08d6d12188a5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3947;
x-ms-traffictypediagnostic: DB3PR0402MB3947:
x-microsoft-antispam-prvs: <DB3PR0402MB3947FFDEC7F5DE52B1008792F5370@DB3PR0402MB3947.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 00286C0CA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(366004)(39860400002)(199004)(189003)(486006)(36756003)(7736002)(186003)(7416002)(52116002)(110136005)(2616005)(476003)(14444005)(99286004)(256004)(50226002)(86362001)(81166006)(5660300002)(8676002)(81156014)(2906002)(71200400001)(71190400001)(102836004)(26005)(305945005)(8936002)(6506007)(386003)(73956011)(66946007)(66476007)(66556008)(64756008)(66446008)(2201001)(6436002)(316002)(3846002)(53936002)(478600001)(6116002)(6512007)(25786009)(14454004)(68736007)(6486002)(4326008)(2501003)(66066001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3947;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cfz+p+Rnr7SZz1pkphfJTmI7JU1YeEXV6iSEP3G9WSOG2QwD0nJ8Y/+OkkcFmpFLxLFQom2cEeOw+usPoz75gbN9vgeUkaU7abyiRa+AhVogbNHF6C1GLyZW/h3OVUrHCzv5mOsXHof5kU8FOUEvtGKbQ7JjJYqcB1oXWIfcJyu9xObbGuk0ppfEEcVEHGrg7Xhz5jQt3Ncc3p2SDWuiC6JoVe59B478y1bi5DEf6a5zmdieoewfSovZot7RomT1GoDJ4hJr/RMKhsGtAKgYB77wKaOiMJnPYTgjs8AInPO7bicayu6hIlQyuIfPKxcPCOB9vBu2hbCk2SzZ1zdIpcnmZD332Y67M/H6kHuipOZn5qRh5rUKXSoKjtjq8gIAH2KhdhJTaTm0GujUgtiHCfXSNEYN8AewG5IRab+j370=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b243de87-7dfc-4576-7ca2-08d6d12188a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2019 06:18:48.1530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3947
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWxsIGkuTVg2IFNvQ3MgbmVlZCB0byBtYXNrIHVudXNlZCBNTURDIGNoYW5uZWwncyBoYW5kc2hh
a2UNCmZvciBsb3cgcG93ZXIgbW9kZXMsIHRoaXMgcGF0Y2ggcHJvdmlkZXMgY29tbW9uIEFQSSBm
b3IgbWFza2luZw0KdGhlIE1NREMgY2hhbm5lbCBwYXNzZWQgZnJvbSBjYWxsZXIuDQoNClNpZ25l
ZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KLS0tDQogZHJpdmVy
cy9jbGsvaW14L2Nsay5jIHwgMTQgKysrKysrKysrKysrKysNCiBkcml2ZXJzL2Nsay9pbXgvY2xr
LmggfCAgMSArDQogMiBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2Nsay9pbXgvY2xrLmMgYi9kcml2ZXJzL2Nsay9pbXgvY2xrLmMNCmluZGV4
IDFlZmVkODYuLjZmOWJjZWUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2Nsay9pbXgvY2xrLmMNCisr
KyBiL2RyaXZlcnMvY2xrL2lteC9jbGsuYw0KQEAgLTYsOCArNiwyMiBAQA0KICNpbmNsdWRlIDxs
aW51eC9zcGlubG9jay5oPg0KICNpbmNsdWRlICJjbGsuaCINCiANCisjZGVmaW5lIENDTV9DQ0RS
CQkJMHg0DQorI2RlZmluZSBDQ0RSX01NRENfQ0gwX01BU0sJCUJJVCgxNykNCisjZGVmaW5lIEND
RFJfTU1EQ19DSDFfTUFTSwkJQklUKDE2KQ0KKw0KIERFRklORV9TUElOTE9DSyhpbXhfY2NtX2xv
Y2spOw0KIA0KK3ZvaWQgX19pbml0IGlteF9tbWRjX21hc2tfaGFuZHNoYWtlKHZvaWQgX19pb21l
bSAqY2NtX2Jhc2UsDQorCQkJCSAgICB1bnNpZ25lZCBpbnQgY2huKQ0KK3sNCisJdW5zaWduZWQg
aW50IHJlZzsNCisNCisJcmVnID0gcmVhZGxfcmVsYXhlZChjY21fYmFzZSArIENDTV9DQ0RSKTsN
CisJcmVnIHw9IGNobiA9PSAwID8gQ0NEUl9NTURDX0NIMF9NQVNLIDogQ0NEUl9NTURDX0NIMV9N
QVNLOw0KKwl3cml0ZWxfcmVsYXhlZChyZWcsIGNjbV9iYXNlICsgQ0NNX0NDRFIpOw0KK30NCisN
CiB2b2lkIF9faW5pdCBpbXhfY2hlY2tfY2xvY2tzKHN0cnVjdCBjbGsgKmNsa3NbXSwgdW5zaWdu
ZWQgaW50IGNvdW50KQ0KIHsNCiAJdW5zaWduZWQgaTsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Ns
ay9pbXgvY2xrLmggYi9kcml2ZXJzL2Nsay9pbXgvY2xrLmgNCmluZGV4IDg2MzlhOGYuLjZkY2Rj
OTEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2Nsay9pbXgvY2xrLmgNCisrKyBiL2RyaXZlcnMvY2xr
L2lteC9jbGsuaA0KQEAgLTEwLDYgKzEwLDcgQEAgZXh0ZXJuIHNwaW5sb2NrX3QgaW14X2NjbV9s
b2NrOw0KIHZvaWQgaW14X2NoZWNrX2Nsb2NrcyhzdHJ1Y3QgY2xrICpjbGtzW10sIHVuc2lnbmVk
IGludCBjb3VudCk7DQogdm9pZCBpbXhfY2hlY2tfY2xrX2h3cyhzdHJ1Y3QgY2xrX2h3ICpjbGtz
W10sIHVuc2lnbmVkIGludCBjb3VudCk7DQogdm9pZCBpbXhfcmVnaXN0ZXJfdWFydF9jbG9ja3Mo
c3RydWN0IGNsayAqKiBjb25zdCBjbGtzW10pOw0KK3ZvaWQgaW14X21tZGNfbWFza19oYW5kc2hh
a2Uodm9pZCBfX2lvbWVtICpjY21fYmFzZSwgdW5zaWduZWQgaW50IGNobik7DQogDQogZXh0ZXJu
IHZvaWQgaW14X2NzY21yMV9maXh1cCh1MzIgKnZhbCk7DQogDQotLSANCjIuNy40DQoNCg==
