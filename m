Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD63C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C695220663
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TooRd1i0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbfDPGsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 02:48:30 -0400
Received: from mail-eopbgr150042.outbound.protection.outlook.com ([40.107.15.42]:1284
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726962AbfDPGsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 02:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sr3fvpncAA647+/FO6d7nKvMs58rv7BI+QhZUWr/UXg=;
 b=TooRd1i07XBMLspkhEyNOu9MCdKE8hHbT2BYpBTqksbE3A/Ppij0psZvGhuktTpuLTw9xHyIQYRVviZh4uJ8LH/ocGH0BdO0pQsEQkcikBH8RLYY6ztKbTbmgbbq9ewOZPaD1vxsSwJWmEtLEV0MiGdiwc4/NMvDZ1ZP73QVtOs=
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com (52.135.138.16) by
 DB7PR04MB4505.eurprd04.prod.outlook.com (52.135.138.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.18; Tue, 16 Apr 2019 06:48:24 +0000
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::9c1e:27f0:1ee9:fdb3]) by DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::9c1e:27f0:1ee9:fdb3%7]) with mapi id 15.20.1792.020; Tue, 16 Apr 2019
 06:48:24 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "riteshh@codeaurora.org" <riteshh@codeaurora.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Marie Cheng <haibo.cheng@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [RFC] mmc: cqhci: clear pending interrupt and halt
Thread-Topic: [RFC] mmc: cqhci: clear pending interrupt and halt
Thread-Index: AQHU9CBjLDnv25kfE0KIwpUzeNUQ4A==
Date:   Tue, 16 Apr 2019 06:48:24 +0000
Message-ID: <20190416070128.12039-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK2PR02CA0183.apcprd02.prod.outlook.com
 (2603:1096:201:21::19) To DB7PR04MB4490.eurprd04.prod.outlook.com
 (2603:10a6:5:35::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3c4fdac-f87d-43d9-d40d-08d6c23785aa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB7PR04MB4505;
x-ms-traffictypediagnostic: DB7PR04MB4505:
x-microsoft-antispam-prvs: <DB7PR04MB45054FDF1A6A66A8703ECE7E88240@DB7PR04MB4505.eurprd04.prod.outlook.com>
x-forefront-prvs: 000947967F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(346002)(366004)(376002)(189003)(199004)(186003)(68736007)(7736002)(2501003)(305945005)(6512007)(8936002)(36756003)(6636002)(99286004)(86362001)(478600001)(6436002)(6486002)(2616005)(53936002)(5660300002)(71190400001)(71200400001)(97736004)(26005)(2201001)(106356001)(105586002)(256004)(14444005)(6116002)(25786009)(81166006)(81156014)(50226002)(14454004)(2906002)(486006)(102836004)(52116002)(54906003)(386003)(476003)(44832011)(1076003)(6506007)(316002)(3846002)(4326008)(110136005)(8676002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4505;H:DB7PR04MB4490.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AoBJn2cuwtgMSvIpnkAQ7p9uJJdVFniK3zikGrQaLNZnusQ66218GAN9UCcjJcgqkTOWnuUlvi/U6+TqlZwNbKuNoiTX/GruPn2pRIMikNoQ4ewE1TXTskrbQJ1R2KJTa14iwXvxlFVKiTx8BJQK41v5BYcUj1bapG9TzpjYiblcTvUjMjJ0HYfhi20mhZ3MLJ6XmGOAINIu2vqt3oZjJM3cvkQ4qhwGgF603rbxpkiUZyz4RDzdf/J3ZOgzkvwbbFLthemtJTTwhEOj0usen9aWzZklftHP8cRQ+YVY/z49rUlry7hfGYZw00lESDyO2fedy/E96ivqC573Os+tLuaRbhUa/zef8gr0miec/WEl/6e8RzzI526cd1BaMGxxS+InoL3CYgJA14gR15y8jzsjnGhCnz4zntqi5Eo1SCU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c4fdac-f87d-43d9-d40d-08d6c23785aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2019 06:48:24.4671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4505
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gaS5NWDhNTSwgd2UgYXJlIHJ1bm5pbmcgRHVhbCBMaW51eCBPUywgd2l0aCAxc3QgTGludXgg
dXNpbmcgU0QgQ2FyZA0KYXMgcm9vdGZzIHN0b3JhZ2UsIDJuZCBMaW51eCB1c2luZyBlTU1DIGFz
IHJvb3RmcyBzdG9yYWdlLiBXZSBsZXQgdGhlDQp0aGUgMXN0IGxpbnV4IGNvbmZpZ3VyZSBwb3dl
ci9jbG9jayBmb3IgdGhlIDJuZCBMaW51eC4NCg0KV2hlbiB0aGUgMm5kIExpbnV4IGlzIGJvb3Rp
bmcgaW50byByb290ZnMgc3RhZ2UsIHdlIGxldCB0aGUgMXN0IExpbnV4DQp0byBkZXN0cm95IHRo
ZSAybmQgbGludXgsIHRoZW4gcmVzdGFydCB0aGUgMXN0IGxpbnV4LCB3ZSBtZXQgU0RIQ0kgZHVt
cA0KYXMgZm9sbG93aW5nLCBhZnRlciB3ZSBjbGVhciB0aGUgcGVuZGluZyBpbnRlcnJ1cHQgYW5k
IGhhbHQgQ1FDVEwsIGlzc3VlDQpnb25lLg0KDQpbIDEuMzM0NTk0XSBtbWMyOiBHb3QgY29tbWFu
ZCBpbnRlcnJ1cHQgMHgwMDAwMDAwMSBldmVuIHRob3VnaCBubyBjb21tYW5kIG9wZXJhdGlvbiB3
YXMgaW4gcHJvZ3Jlc3MuDQpbIDEuMzM0NTk1XSBtbWMyOiBzZGhjaTogPT09PT09PT09PT09IFNE
SENJIFJFR0lTVEVSIERVTVAgPT09PT09PT09PT0NClsgMS4zMzQ1OTldIG1tYzI6IHNkaGNpOiBT
eXMgYWRkcjogMHhhMDVkY2MwMCB8IFZlcnNpb246IDB4MDAwMDAwMDINClsgMS4zNDA4MTldIGxp
YjgwMjExOiBjb21tb24gcm91dGluZXMgZm9yIElFRUU4MDIuMTEgZHJpdmVycw0KWyAxLjM0NTUz
OF0gbW1jMjogc2RoY2k6IEJsayBzaXplOiAweDAwMDAwMjAwIHwgQmxrIGNudDogMHgwMDAwMDAw
MA0KWyAxLjM0NTU0MV0gbW1jMjogc2RoY2k6IEFyZ3VtZW50OiAweDAwMDE4MDAwIHwgVHJuIG1v
ZGU6IDB4MDAwMDAwMzMNClsgMS4zNDU1NDNdIG1tYzI6IHNkaGNpOiBQcmVzZW50OiAweDAxZjg4
MDA4IHwgSG9zdCBjdGw6IDB4MDAwMDAwMzENClsgMS4zNDU1NDddIG1tYzI6IHNkaGNpOiBQb3dl
cjogMHgwMDAwMDAwMiB8IEJsayBnYXA6IDB4MDAwMDAwODANClsgMS4zNTc5MDNdIG1tYzI6IHNk
aGNpOiBXYWtlLXVwOiAweDAwMDAwMDA4IHwgQ2xvY2s6IDB4MDAwMDAwM2YNClsgMS4zNTc5MDVd
IG1tYzI6IHNkaGNpOiBUaW1lb3V0OiAweDAwMDAwMDhmIHwgSW50IHN0YXQ6IDB4MDAwMDAwMDAN
ClsgMS4zNTc5MDhdIG1tYzI6IHNkaGNpOiBJbnQgZW5hYjogMHgxMDdmMTAwYiB8IFNpZyBlbmFi
OiAweDEwN2YxMDBiDQpbIDEuMzU3OTExXSBtbWMyOiBzZGhjaTogQUMxMiBlcnI6IDB4MDAwMDAw
MDAgfCBTbG90IGludDogMHgwMDAwMDUwMg0KWyAxLjM3MDI2OF0gbW1jMjogc2RoY2k6IENhcHM6
IDB4MDdlYjAwMDAgfCBDYXBzXzE6IDB4MDAwMGI0MDANClsgMS4zNzAyNzBdIG1tYzI6IHNkaGNp
OiBDbWQ6IDB4MDAwMDBkMWEgfCBNYXggY3VycjogMHgwMGZmZmZmZg0KWyAxLjM3MDI3M10gbW1j
Mjogc2RoY2k6IFJlc3BbMF06IDB4MDAwMDBiMDAgfCBSZXNwWzFdOiAweGZmZmZmZmZmDQpbIDEu
MzcwMjc2XSBtbWMyOiBzZGhjaTogUmVzcFsyXTogMHgzMjhmNTkwMyB8IFJlc3BbM106IDB4MDBk
MDBmMDANClsgMS4zODIxMzJdIG1tYzI6IHNkaGNpOiBIb3N0IGN0bDI6IDB4MDAwMDAwMDANClsg
MS4zODIxMzVdIG1tYzI6IHNkaGNpOiBBRE1BIEVycjogMHgwMDAwMDAwMCB8IEFETUEgUHRyOiAw
eGEyMDQwMjA4DQoNClsgMi4wNjA5MzJdIG1tYzI6IFVuZXhwZWN0ZWQgaW50ZXJydXB0IDB4MDAw
MDQwMDAuDQpbIDIuMDY1NTM4XSBtbWMyOiBzZGhjaTogPT09PT09PT09PT09IFNESENJIFJFR0lT
VEVSIERVTVAgPT09PT09PT09PT0NClsgMi4wNzE3MjBdIG1tYzI6IHNkaGNpOiBTeXMgYWRkcjog
MHgwMDAwMDAwMCB8IFZlcnNpb246IDB4MDAwMDAwMDINClsgMi4wNzc5MDJdIG1tYzI6IHNkaGNp
OiBCbGsgc2l6ZTogMHgwMDAwMDIwMCB8IEJsayBjbnQ6IDB4MDAwMDAwMDENClsgMi4wODQwODNd
IG1tYzI6IHNkaGNpOiBBcmd1bWVudDogMHgwMDAwMDAwMCB8IFRybiBtb2RlOiAweDAwMDAwMDAw
DQpbIDIuMDkwMjY0XSBtbWMyOiBzZGhjaTogUHJlc2VudDogMHgwMWY4ODAwOSB8IEhvc3QgY3Rs
OiAweDAwMDAwMDExDQpbIDIuMDk2NDQ2XSBtbWMyOiBzZGhjaTogUG93ZXI6IDB4MDAwMDAwMDIg
fCBCbGsgZ2FwOiAweDAwMDAwMDgwDQpbIDIuMTAyNjI3XSBtbWMyOiBzZGhjaTogV2FrZS11cDog
MHgwMDAwMDAwOCB8IENsb2NrOiAweDAwMDAxMGZmDQpbIDIuMTA4ODA5XSBtbWMyOiBzZGhjaTog
VGltZW91dDogMHgwMDAwMDA4ZiB8IEludCBzdGF0OiAweDAwMDA0MDAwDQpbIDIuMTE0OTkwXSBt
bWMyOiBzZGhjaTogSW50IGVuYWI6IDB4MDA3ZjEwMDMgfCBTaWcgZW5hYjogMHgwMDdmMTAwMw0K
WyAyLjEyMTE3MV0gbW1jMjogc2RoY2k6IEFDMTIgZXJyOiAweDAwMDAwMDAwIHwgU2xvdCBpbnQ6
IDB4MDAwMDA1MDINClsgMi4xMjczNTNdIG1tYzI6IHNkaGNpOiBDYXBzOiAweDA3ZWIwMDAwIHwg
Q2Fwc18xOiAweDAwMDBiNDAwDQpbIDIuMTMzNTM0XSBtbWMyOiBzZGhjaTogQ21kOiAweDAwMDAz
NzFhIHwgTWF4IGN1cnI6IDB4MDBmZmZmZmYNClsgMi4xMzk3MTVdIG1tYzI6IHNkaGNpOiBSZXNw
WzBdOiAweDAwMDAwOTAwIHwgUmVzcFsxXTogMHhmZmZmZmZmZg0KWyAyLjE0NTg5Nl0gbW1jMjog
c2RoY2k6IFJlc3BbMl06IDB4MzI4ZjU5MDMgfCBSZXNwWzNdOiAweDAwZDAwZjAwDQpbIDIuMTUy
MDc3XSBtbWMyOiBzZGhjaTogSG9zdCBjdGwyOiAweDAwMDAwMDAwDQpbIDIuMTU2MzQyXSBtbWMy
OiBzZGhjaTogQURNQSBFcnI6IDB4MDAwMDAwMDAgfCBBRE1BIFB0cjogMHgwMDAwMDAwMA0KDQpT
aWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCi0tLQ0KIGRyaXZlcnMv
bW1jL2hvc3QvY3FoY2kuYyB8IDUgKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25z
KCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L2NxaGNpLmMgYi9kcml2ZXJzL21t
Yy9ob3N0L2NxaGNpLmMNCmluZGV4IGQ1OWNiMGE1MTk2NC4uNGY0MTk2MGFjN2FkIDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9tbWMvaG9zdC9jcWhjaS5jDQorKysgYi9kcml2ZXJzL21tYy9ob3N0L2Nx
aGNpLmMNCkBAIC0xMTE2LDYgKzExMTYsNyBAQCBpbnQgY3FoY2lfaW5pdChzdHJ1Y3QgY3FoY2lf
aG9zdCAqY3FfaG9zdCwgc3RydWN0IG1tY19ob3N0ICptbWMsDQogCSAgICAgIGJvb2wgZG1hNjQp
DQogew0KIAlpbnQgZXJyOw0KKwl1MzIgc3RhdHVzOw0KIA0KIAljcV9ob3N0LT5kbWE2NCA9IGRt
YTY0Ow0KIAljcV9ob3N0LT5tbWMgPSBtbWM7DQpAQCAtMTEzOSw2ICsxMTQwLDEwIEBAIGludCBj
cWhjaV9pbml0KHN0cnVjdCBjcWhjaV9ob3N0ICpjcV9ob3N0LCBzdHJ1Y3QgbW1jX2hvc3QgKm1t
YywNCiANCiAJc3Bpbl9sb2NrX2luaXQoJmNxX2hvc3QtPmxvY2spOw0KIA0KKwlzdGF0dXMgPSBj
cWhjaV9yZWFkbChjcV9ob3N0LCBDUUhDSV9JUyk7DQorCWNxaGNpX3dyaXRlbChjcV9ob3N0LCBz
dGF0dXMsIENRSENJX0lTKTsNCisJY3FoY2lfd3JpdGVsKGNxX2hvc3QsIENRSENJX0hBTFQsIENR
SENJX0NUTCk7DQorDQogCWluaXRfY29tcGxldGlvbigmY3FfaG9zdC0+aGFsdF9jb21wKTsNCiAJ
aW5pdF93YWl0cXVldWVfaGVhZCgmY3FfaG9zdC0+d2FpdF9xdWV1ZSk7DQogDQotLSANCjIuMTYu
NA0KDQo=
