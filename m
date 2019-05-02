Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57167C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 184752089E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rXk1avO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfEBIG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 04:06:56 -0400
Received: from mail-eopbgr140073.outbound.protection.outlook.com ([40.107.14.73]:42560
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726403AbfEBIGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 04:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fU9hgqhH3jkqXN9AOga6Ufjv3CVZVmbn2cVdURBdquw=;
 b=rXk1avO+VZXLoeb2vbcGejio+q+ZQ8QEnl9W0I8h+CclEw873GgEfWWo0F0AmDVkZRYogt93OVMMPuhNrJj/n3OSmJ7MHS4m0BfeBEhr7MQVNzVvrY/ZhK/zir7o196GugTqeV6bTzhbiWji0fCc/XgJi9xrbFn/wWyF14RHNa8=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4563.eurprd04.prod.outlook.com (52.135.144.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.15; Thu, 2 May 2019 08:06:43 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8%7]) with mapi id 15.20.1856.008; Thu, 2 May 2019
 08:06:43 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v2 04/18] clk: imx: clk-busy: Switch to clk_hw based API
Thread-Topic: [PATCH v2 04/18] clk: imx: clk-busy: Switch to clk_hw based API
Thread-Index: AQHVAL36vz1DOlgX/0W3T3j2TCSTMQ==
Date:   Thu, 2 May 2019 08:06:43 +0000
Message-ID: <1556784376-7191-5-git-send-email-abel.vesa@nxp.com>
References: <1556784376-7191-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1556784376-7191-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0501CA0041.eurprd05.prod.outlook.com
 (2603:10a6:800:60::27) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5548ec4a-3a8a-4770-89d1-08d6ced51d0d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4563;
x-ms-traffictypediagnostic: AM0PR04MB4563:
x-microsoft-antispam-prvs: <AM0PR04MB4563433852185E036B0736E2F6340@AM0PR04MB4563.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(346002)(366004)(199004)(189003)(53936002)(66476007)(66556008)(64756008)(66946007)(73956011)(66446008)(66066001)(6116002)(36756003)(3846002)(305945005)(86362001)(6486002)(81156014)(6512007)(81166006)(25786009)(8676002)(4326008)(71200400001)(71190400001)(99286004)(8936002)(14454004)(76176011)(50226002)(11346002)(446003)(2616005)(68736007)(478600001)(386003)(2906002)(6506007)(52116002)(316002)(44832011)(54906003)(110136005)(26005)(7736002)(5660300002)(256004)(102836004)(186003)(14444005)(486006)(476003)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4563;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SDrdYh/PzO2xSg4tQwEIjfjmLlC4i/HCBEufwiMWhoDZVG9y0jeuM7A9QWURM5uCDv5rPPpPSM733NKzHo3Y/kR+/a1a0QCv88rDxK6rK5IKv0w0gZhNrsFAyI4gVlppTlUiguNxbowP5y+B1RqrXsSDezBhzVUycpZDlipSh5ncMkcF+K13lni3aWnNCvTO4CXOvdOlvAtnFynKeLredBbPKwokxHziMpHBpBW7BRey7tV5jASngRgeeZZcuBSEubODhlC3eFQ3H/c0AmDhw8vaI7cRSInOhXbs2axG3X83jEtlWaNatD/8/fKqHjrEGL0nZBuCTKrD6HQJE6Dwdy3tUVKHq6XsnGE35+4m13lmcH0epkw/mviVSbnbc0x1eiL0MH4+uEaNTRtW5Ta6GQ+4DkKe5wyPAAZTzyOKtWQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5548ec4a-3a8a-4770-89d1-08d6ced51d0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 08:06:43.6032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4563
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U3dpdGNoIGFsbCB0aGUgY2xrX2J1c3kgY2xvY2sgcmVnaXN0ZXJpbmcgZnVuY3Rpb25zIHRvIGNs
a19odyBiYXNlZCBBUEkuDQpLZWVwIGFyb3VuZCBzb21lIGNsayBiYXNlZCB3cmFwcGVycyB0byBi
ZSB1c2VkIGJ5IG9sZGVyIGlteCBwbGF0Zm9ybXMuDQpUaGlzIGFsbG93cyB1cyB0byBtb3ZlIGNs
b3NlciB0byBhIGNsZWFyIHNwbGl0IG9mIGNvbnN1bWVyIGFuZCBwcm92aWRlcg0KY2xrIEFQSXMu
DQoNClNpZ25lZC1vZmYtYnk6IEFiZWwgVmVzYSA8YWJlbC52ZXNhQG54cC5jb20+DQotLS0NCiBk
cml2ZXJzL2Nsay9pbXgvY2xrLWJ1c3kuYyB8IDMwICsrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLQ0KIGRyaXZlcnMvY2xrL2lteC9jbGsuaCAgICAgIHwgMTEgKysrKysrKysrLS0NCiAyIGZp
bGVzIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9jbGsvaW14L2Nsay1idXN5LmMgYi9kcml2ZXJzL2Nsay9pbXgvY2xrLWJ1
c3kuYw0KaW5kZXggZTY5NTYyMi4uNTFmNzU1MDAgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2Nsay9p
bXgvY2xrLWJ1c3kuYw0KKysrIGIvZHJpdmVycy9jbGsvaW14L2Nsay1idXN5LmMNCkBAIC03OCwx
MyArNzgsMTQgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBjbGtfb3BzIGNsa19idXN5X2RpdmlkZXJf
b3BzID0gew0KIAkuc2V0X3JhdGUgPSBjbGtfYnVzeV9kaXZpZGVyX3NldF9yYXRlLA0KIH07DQog
DQotc3RydWN0IGNsayAqaW14X2Nsa19idXN5X2RpdmlkZXIoY29uc3QgY2hhciAqbmFtZSwgY29u
c3QgY2hhciAqcGFyZW50X25hbWUsDQorc3RydWN0IGNsa19odyAqaW14X2Nsa19od19idXN5X2Rp
dmlkZXIoY29uc3QgY2hhciAqbmFtZSwgY29uc3QgY2hhciAqcGFyZW50X25hbWUsDQogCQkJCSB2
b2lkIF9faW9tZW0gKnJlZywgdTggc2hpZnQsIHU4IHdpZHRoLA0KIAkJCQkgdm9pZCBfX2lvbWVt
ICpidXN5X3JlZywgdTggYnVzeV9zaGlmdCkNCiB7DQogCXN0cnVjdCBjbGtfYnVzeV9kaXZpZGVy
ICpidXN5Ow0KLQlzdHJ1Y3QgY2xrICpjbGs7DQorCXN0cnVjdCBjbGtfaHcgKmh3Ow0KIAlzdHJ1
Y3QgY2xrX2luaXRfZGF0YSBpbml0Ow0KKwlpbnQgcmV0Ow0KIA0KIAlidXN5ID0ga3phbGxvYyhz
aXplb2YoKmJ1c3kpLCBHRlBfS0VSTkVMKTsNCiAJaWYgKCFidXN5KQ0KQEAgLTEwNywxMSArMTA4
LDE1IEBAIHN0cnVjdCBjbGsgKmlteF9jbGtfYnVzeV9kaXZpZGVyKGNvbnN0IGNoYXIgKm5hbWUs
IGNvbnN0IGNoYXIgKnBhcmVudF9uYW1lLA0KIA0KIAlidXN5LT5kaXYuaHcuaW5pdCA9ICZpbml0
Ow0KIA0KLQljbGsgPSBjbGtfcmVnaXN0ZXIoTlVMTCwgJmJ1c3ktPmRpdi5odyk7DQotCWlmIChJ
U19FUlIoY2xrKSkNCisJaHcgPSAmYnVzeS0+ZGl2Lmh3Ow0KKw0KKwlyZXQgPSBjbGtfaHdfcmVn
aXN0ZXIoTlVMTCwgaHcpOw0KKwlpZiAocmV0KSB7DQogCQlrZnJlZShidXN5KTsNCisJCXJldHVy
biBFUlJfUFRSKHJldCk7DQorCX0NCiANCi0JcmV0dXJuIGNsazsNCisJcmV0dXJuIGh3Ow0KIH0N
CiANCiBzdHJ1Y3QgY2xrX2J1c3lfbXV4IHsNCkBAIC0xNTIsMTMgKzE1NywxNCBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IGNsa19vcHMgY2xrX2J1c3lfbXV4X29wcyA9IHsNCiAJLnNldF9wYXJlbnQg
PSBjbGtfYnVzeV9tdXhfc2V0X3BhcmVudCwNCiB9Ow0KIA0KLXN0cnVjdCBjbGsgKmlteF9jbGtf
YnVzeV9tdXgoY29uc3QgY2hhciAqbmFtZSwgdm9pZCBfX2lvbWVtICpyZWcsIHU4IHNoaWZ0LA0K
K3N0cnVjdCBjbGtfaHcgKmlteF9jbGtfaHdfYnVzeV9tdXgoY29uc3QgY2hhciAqbmFtZSwgdm9p
ZCBfX2lvbWVtICpyZWcsIHU4IHNoaWZ0LA0KIAkJCSAgICAgdTggd2lkdGgsIHZvaWQgX19pb21l
bSAqYnVzeV9yZWcsIHU4IGJ1c3lfc2hpZnQsDQogCQkJICAgICBjb25zdCBjaGFyICogY29uc3Qg
KnBhcmVudF9uYW1lcywgaW50IG51bV9wYXJlbnRzKQ0KIHsNCiAJc3RydWN0IGNsa19idXN5X211
eCAqYnVzeTsNCi0Jc3RydWN0IGNsayAqY2xrOw0KKwlzdHJ1Y3QgY2xrX2h3ICpodzsNCiAJc3Ry
dWN0IGNsa19pbml0X2RhdGEgaW5pdDsNCisJaW50IHJldDsNCiANCiAJYnVzeSA9IGt6YWxsb2Mo
c2l6ZW9mKCpidXN5KSwgR0ZQX0tFUk5FTCk7DQogCWlmICghYnVzeSkNCkBAIC0xODEsOSArMTg3
LDEzIEBAIHN0cnVjdCBjbGsgKmlteF9jbGtfYnVzeV9tdXgoY29uc3QgY2hhciAqbmFtZSwgdm9p
ZCBfX2lvbWVtICpyZWcsIHU4IHNoaWZ0LA0KIA0KIAlidXN5LT5tdXguaHcuaW5pdCA9ICZpbml0
Ow0KIA0KLQljbGsgPSBjbGtfcmVnaXN0ZXIoTlVMTCwgJmJ1c3ktPm11eC5odyk7DQotCWlmIChJ
U19FUlIoY2xrKSkNCisJaHcgPSAmYnVzeS0+bXV4Lmh3Ow0KKw0KKwlyZXQgPSBjbGtfaHdfcmVn
aXN0ZXIoTlVMTCwgaHcpOw0KKwlpZiAocmV0KSB7DQogCQlrZnJlZShidXN5KTsNCisJCXJldHVy
biBFUlJfUFRSKHJldCk7DQorCX0NCiANCi0JcmV0dXJuIGNsazsNCisJcmV0dXJuIGh3Ow0KIH0N
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9pbXgvY2xrLmggYi9kcml2ZXJzL2Nsay9pbXgvY2xr
LmgNCmluZGV4IGY3NmZhMjIuLmVhZDY2OGUxIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jbGsvaW14
L2Nsay5oDQorKysgYi9kcml2ZXJzL2Nsay9pbXgvY2xrLmgNCkBAIC0xMCw2ICsxMCw3IEBAIGV4
dGVybiBzcGlubG9ja190IGlteF9jY21fbG9jazsNCiB2b2lkIGlteF9jaGVja19jbG9ja3Moc3Ry
dWN0IGNsayAqY2xrc1tdLCB1bnNpZ25lZCBpbnQgY291bnQpOw0KIHZvaWQgaW14X2NoZWNrX2Ns
a19od3Moc3RydWN0IGNsa19odyAqY2xrc1tdLCB1bnNpZ25lZCBpbnQgY291bnQpOw0KIHZvaWQg
aW14X3JlZ2lzdGVyX3VhcnRfY2xvY2tzKHN0cnVjdCBjbGsgKiogY29uc3QgY2xrc1tdKTsNCit2
b2lkIGlteF9yZWdpc3Rlcl91YXJ0X2Nsb2Nrc19od3Moc3RydWN0IGNsa19odyAqKiBjb25zdCBo
d3NbXSk7DQogDQogZXh0ZXJuIHZvaWQgaW14X2NzY21yMV9maXh1cCh1MzIgKnZhbCk7DQogDQpA
QCAtNDgsNiArNDksMTIgQEAgc3RydWN0IGlteF9wbGwxNHh4X2NsayB7DQogCWludCBmbGFnczsN
CiB9Ow0KIA0KKyNkZWZpbmUgaW14X2Nsa19idXN5X2RpdmlkZXIobmFtZSwgcGFyZW50X25hbWUs
IHJlZywgc2hpZnQsIHdpZHRoLCBidXN5X3JlZywgYnVzeV9zaGlmdCkgXA0KKwlpbXhfY2xrX2h3
X2J1c3lfZGl2aWRlcihuYW1lLCBwYXJlbnRfbmFtZSwgcmVnLCBzaGlmdCwgd2lkdGgsIGJ1c3lf
cmVnLCBidXN5X3NoaWZ0KS0+Y2xrDQorDQorI2RlZmluZSBpbXhfY2xrX2J1c3lfbXV4KG5hbWUs
IHJlZywgc2hpZnQsIHdpZHRoLCBidXN5X3JlZywgYnVzeV9zaGlmdCwgcGFyZW50X25hbWVzLCBu
dW1fcGFyZW50cykgXA0KKwlpbXhfY2xrX2h3X2J1c3lfbXV4KG5hbWUsIHJlZywgc2hpZnQsIHdp
ZHRoLCBidXN5X3JlZywgYnVzeV9zaGlmdCwgcGFyZW50X25hbWVzLCBudW1fcGFyZW50cyktPmNs
aw0KKw0KIHN0cnVjdCBjbGsgKmlteF9jbGtfcGxsMTR4eChjb25zdCBjaGFyICpuYW1lLCBjb25z
dCBjaGFyICpwYXJlbnRfbmFtZSwNCiAJCSB2b2lkIF9faW9tZW0gKmJhc2UsIGNvbnN0IHN0cnVj
dCBpbXhfcGxsMTR4eF9jbGsgKnBsbF9jbGspOw0KIA0KQEAgLTExMCwxMSArMTE3LDExIEBAIHN0
cnVjdCBjbGsgKmlteF9jbGtfcGZkKGNvbnN0IGNoYXIgKm5hbWUsIGNvbnN0IGNoYXIgKnBhcmVu
dF9uYW1lLA0KIHN0cnVjdCBjbGtfaHcgKmlteF9jbGtfcGZkdjIoY29uc3QgY2hhciAqbmFtZSwg
Y29uc3QgY2hhciAqcGFyZW50X25hbWUsDQogCQkJICAgICB2b2lkIF9faW9tZW0gKnJlZywgdTgg
aWR4KTsNCiANCi1zdHJ1Y3QgY2xrICppbXhfY2xrX2J1c3lfZGl2aWRlcihjb25zdCBjaGFyICpu
YW1lLCBjb25zdCBjaGFyICpwYXJlbnRfbmFtZSwNCitzdHJ1Y3QgY2xrX2h3ICppbXhfY2xrX2h3
X2J1c3lfZGl2aWRlcihjb25zdCBjaGFyICpuYW1lLCBjb25zdCBjaGFyICpwYXJlbnRfbmFtZSwN
CiAJCQkJIHZvaWQgX19pb21lbSAqcmVnLCB1OCBzaGlmdCwgdTggd2lkdGgsDQogCQkJCSB2b2lk
IF9faW9tZW0gKmJ1c3lfcmVnLCB1OCBidXN5X3NoaWZ0KTsNCiANCi1zdHJ1Y3QgY2xrICppbXhf
Y2xrX2J1c3lfbXV4KGNvbnN0IGNoYXIgKm5hbWUsIHZvaWQgX19pb21lbSAqcmVnLCB1OCBzaGlm
dCwNCitzdHJ1Y3QgY2xrX2h3ICppbXhfY2xrX2h3X2J1c3lfbXV4KGNvbnN0IGNoYXIgKm5hbWUs
IHZvaWQgX19pb21lbSAqcmVnLCB1OCBzaGlmdCwNCiAJCQkgICAgIHU4IHdpZHRoLCB2b2lkIF9f
aW9tZW0gKmJ1c3lfcmVnLCB1OCBidXN5X3NoaWZ0LA0KIAkJCSAgICAgY29uc3QgY2hhciAqIGNv
bnN0ICpwYXJlbnRfbmFtZXMsIGludCBudW1fcGFyZW50cyk7DQogDQotLSANCjIuNy40DQoNCg==
