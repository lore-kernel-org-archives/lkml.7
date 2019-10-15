Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10706ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 03:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE4520873
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 03:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ilJ0188w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfJOD2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 23:28:03 -0400
Received: from mail-eopbgr20047.outbound.protection.outlook.com ([40.107.2.47]:25855
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727195AbfJOD2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 23:28:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDzcosZNapSVr3tCe0xlhyVBQrqceRKEDMWnNxoy4F0eBkH+4RtdLOorY374fv8c6tcFiU9gSYMAHMvmXBgqu20zFm6dJTOHO7inYhUxQ7jo/PFWhpOnqFE9qUglDo3hbQkCoZ1GFJqM2dE7H8Tk4OVNsXfrrVUhbVIGYX84kB+BJYtopHEra6chg/7RATvz8tENH+YBP8kRD1LTdMdvud2VA+z+8GCx+azuSQZV5SPkniVBqPgl01FTEfMqlpZdMdW7+JwHyvIoY7j1NeecmHB3Vroz5ibKjinuU0qQie3bTxV2V370QxXzXkx/LujYvzqXDfKMSZLHf6/wRvlK1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smDtZU4HdeLnrFfdaNbMnRorcUo/HC/cobBxVkqc1EM=;
 b=NZNKzNLIU9MCHnIpvzcJ7cVBM2eKeVKZjszlOA0MzNlZ80lW6Vx/BmTY0N7HjgZ9ujKcz6FS2Z5jps5m2HoEzYEde1ltSoBBwDMblnCCMVLofqBfuTKiCuEdXxG2qssDJSfS4Vad0uqhxpLj4PA5lST3YPc+S3qya69KYZIsGN97ueDHNOeYmRZ4rlKagtBEartU+Jcuf1NZKY2VjpDbgn3vDycvvNz1XKiU24MNhibOFtxpP5ZDzafXYNNy/t+U//6/x8ULUhSyKvBJvHN9BR3wg0c7lghPV8t5TKAee7Wg/gqGDAfcdbpy6jzqD2OOFjSjoU+LGzBLWZ/t1RtLLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smDtZU4HdeLnrFfdaNbMnRorcUo/HC/cobBxVkqc1EM=;
 b=ilJ0188wN7oqx89gZcquS6NMRiWZ0i4AGrWfK/VSjDS+OtZn371JukS48nS68QKvHPjMqFzmF4NqqR/ezRtTxombpgZyYL7p77sSvouhN4CGpdIVZL8oiE7YAYnttJaqwzhPGmBqzPqLlu0NKOKNbzq08EjXVDAT3cJwOOPzQ0I=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3737.eurprd04.prod.outlook.com (52.134.66.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Tue, 15 Oct 2019 03:27:59 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d469:ad51:2bec:19f0]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d469:ad51:2bec:19f0%6]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 03:27:59 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Fancy Fang <chen.fang@nxp.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v3] clk: imx7ulp: do not export out IMX7ULP_CLK_MIPI_PLL
 clock
Thread-Topic: [PATCH v3] clk: imx7ulp: do not export out IMX7ULP_CLK_MIPI_PLL
 clock
Thread-Index: AQHVgwcPc0jqN29IB0OYPLGVX+dhGKdbCpHQ
Date:   Tue, 15 Oct 2019 03:27:59 +0000
Message-ID: <DB3PR0402MB3916869C2A91293F0600CF34F5930@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20191015031501.2703-1-chen.fang@nxp.com>
In-Reply-To: <20191015031501.2703-1-chen.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 136dc6d9-9768-43bf-6dff-08d7511fad85
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DB3PR0402MB3737:|DB3PR0402MB3737:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3737294FBF6560E23D72F9C2F5930@DB3PR0402MB3737.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01917B1794
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(54534003)(189003)(199004)(478600001)(446003)(11346002)(6506007)(66476007)(66946007)(64756008)(66446008)(66556008)(14454004)(256004)(76116006)(52536014)(71190400001)(71200400001)(26005)(44832011)(66066001)(2501003)(476003)(486006)(2906002)(102836004)(25786009)(186003)(5660300002)(316002)(6436002)(33656002)(4326008)(81166006)(86362001)(2201001)(9686003)(305945005)(3846002)(55016002)(229853002)(6246003)(54906003)(74316002)(8676002)(110136005)(8936002)(7736002)(7696005)(76176011)(99286004)(6116002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3737;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tQ36Ne34rn8hFpJpuuAdEAGcUArGGTC5DTB1ILp0UZ65repDOE+k5R4zxZCEpzhSWnYgFTyku3ZGW750XVMi7SYGgX30e4jDo/pcL/8JUpUH5z0J4W84BOH2rPRU0WMCZWspsL282OWBj6qKJYIivVfhPpyqvv8Vi597FVcfzpZWWJ7BA5pzRPPvvk/xkYWpesSO71wtni8G17L0ZNHVhGRr2M91E/UbuM9cQAuKkmWUXwoFz5oz0GQyOcvtlU9eA/UJu7MbVIRh6Hg1xGDksp2K10rVIhc/drd2p6S9Fw3QNvnCnvhhmyrSiybzkQVtZIxE5lqkpH71wicqNpHXHebUvh/0snGccVIRs9OKRQ/qNwXWpgqcX/F868uzIh+9vq3Y+OR1hEgm1ZhrH+6onF2j5tthQX/j6BeC+/F70Ew=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 136dc6d9-9768-43bf-6dff-08d7511fad85
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2019 03:27:59.2263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 46tGle2DCdO+yPRKf9aW/x12LllNNMAOnwClcLr3q7U4hkQDJmnaYkBr6fn15a1+aAWxojEIAG7//OMyOrNptw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3737
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEZhbmN5DQoNCj4gU3ViamVjdDogW1BBVENIIHYzXSBjbGs6IGlteDd1bHA6IGRvIG5vdCBl
eHBvcnQgb3V0IElNWDdVTFBfQ0xLX01JUElfUExMDQo+IGNsb2NrDQo+IA0KPiBUaGUgbWlwaSBw
bGwgY2xvY2sgY29tZXMgZnJvbSB0aGUgTUlQSSBQSFkgUExMIG91dHB1dCwgc28gaXQgc2hvdWxk
IG5vdCBiZSBhDQo+IGZpeGVkIGNsb2NrLg0KPiANCj4gTUlQSSBQSFkgUExMIGlzIGluIHRoZSBN
SVBJIERTSSBzcGFjZSwgYW5kIGl0IGlzIHVzZWQgYXMgdGhlIGJpdCBjbG9jayBmb3INCj4gdHJh
bnNmZXJyaW5nIHRoZSBwaXhlbCBkYXRhIG91dCBhbmQgaXRzIG91dHB1dCBjbG9jayBpcyBjb25m
aWd1cmVkIGFjY29yZGluZyB0bw0KPiB0aGUgZGlzcGxheSBtb2RlLg0KPiANCj4gU28gaXQgc2hv
dWxkIGJlIHVzZWQgb25seSBmb3IgTUlQSSBEU0kgYW5kIG5vdCBiZSBleHBvcnRlZCBvdXQgZm9y
IG90aGVyDQo+IHVzYWdlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEZhbmN5IEZhbmcgPGNoZW4u
ZmFuZ0BueHAuY29tPg0KPiAtLS0NCj4gQ2hhbmdlTG9nIHYyLT52MzoNCj4gICogS2VlcCAnSU1Y
N1VMUF9DTEtfTUlQSV9QTEwnIG1hY3JvIGRlZmluaXRpb24uDQo+IA0KPiBDaGFuZ2VMb2cgdjEt
PnYyOg0KPiAgKiBLZWVwIG90aGVyIGNsb2NrIGluZGV4ZXMgdW5jaGFuZ2VkIGFzIFNoYXduIHN1
Z2dlc3RlZC4NCj4gDQo+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2sv
aW14N3VscC1jbG9jay50eHQgfCAxIC0NCj4gIGRyaXZlcnMvY2xrL2lteC9jbGstaW14N3VscC5j
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDMgKy0tDQo+ICAyIGZpbGVzIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9pbXg3dWxwLWNsb2NrLnR4dA0KPiBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9pbXg3dWxwLWNsb2NrLnR4
dA0KPiBpbmRleCBhNGY4Y2Q0NzhmOTIuLjkzZDg5YWRiN2FmZSAxMDA2NDQNCj4gLS0tIGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL2lteDd1bHAtY2xvY2sudHh0DQo+
ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9pbXg3dWxwLWNs
b2NrLnR4dA0KPiBAQCAtODIsNyArODIsNiBAQCBwY2MyOiBwY2MyQDQwM2YwMDAwIHsNCj4gIAkJ
IDwmc2NnMSBJTVg3VUxQX0NMS19BUExMX1BGRDA+LA0KPiAgCQkgPCZzY2cxIElNWDdVTFBfQ0xL
X1VQTEw+LA0KPiAgCQkgPCZzY2cxIElNWDdVTFBfQ0xLX1NPU0NfQlVTX0NMSz4sDQo+IC0JCSA8
JnNjZzEgSU1YN1VMUF9DTEtfTUlQSV9QTEw+LA0KPiAgCQkgPCZzY2cxIElNWDdVTFBfQ0xLX0ZJ
UkNfQlVTX0NMSz4sDQo+ICAJCSA8JnNjZzEgSU1YN1VMUF9DTEtfUk9TQz4sDQo+ICAJCSA8JnNj
ZzEgSU1YN1VMUF9DTEtfU1BMTF9CVVNfQ0xLPjsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xr
L2lteC9jbGstaW14N3VscC5jIGIvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg3dWxwLmMNCj4gaW5k
ZXggMjAyMmQ5YmVhZDkxLi40NTliMTIwYjcxZDUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xr
L2lteC9jbGstaW14N3VscC5jDQo+ICsrKyBiL2RyaXZlcnMvY2xrL2lteC9jbGstaW14N3VscC5j
DQo+IEBAIC0yOCw3ICsyOCw3IEBAIHN0YXRpYyBjb25zdCBjaGFyICogY29uc3Qgc2NzX3NlbHNb
XQkJPQ0KPiB7ICJkdW1teSIsICJzb3NjIiwgInNpcmMiLCAiZmlyYyIsICJkdW1tDQo+ICBzdGF0
aWMgY29uc3QgY2hhciAqIGNvbnN0IGRkcl9zZWxzW10JCT0geyAiYXBsbF9wZmRfc2VsIiwgInVw
bGwiLCB9Ow0KPiAgc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBuaWNfc2Vsc1tdCQk9IHsgImZp
cmMiLCAiZGRyX2NsayIsIH07DQo+ICBzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IHBlcmlwaF9w
bGF0X3NlbHNbXQk9IHsgImR1bW15IiwgIm5pYzFfYnVzX2NsayIsDQo+ICJuaWMxX2NsayIsICJk
ZHJfY2xrIiwgImFwbGxfcGZkMiIsICJhcGxsX3BmZDEiLCAiYXBsbF9wZmQwIiwgInVwbGwiLCB9
Ow0KPiAtc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBwZXJpcGhfYnVzX3NlbHNbXQk9IHsgImR1
bW15IiwgInNvc2NfYnVzX2NsayIsDQo+ICJtcGxsIiwgImZpcmNfYnVzX2NsayIsICJyb3NjIiwg
Im5pYzFfYnVzX2NsayIsICJuaWMxX2NsayIsICJzcGxsX2J1c19jbGsiLCB9Ow0KPiArc3RhdGlj
IGNvbnN0IGNoYXIgKiBjb25zdCBwZXJpcGhfYnVzX3NlbHNbXQk9IHsgImR1bW15IiwgInNvc2Nf
YnVzX2NsayIsDQo+ICJkdW1teSIsICJmaXJjX2J1c19jbGsiLCAicm9zYyIsICJuaWMxX2J1c19j
bGsiLCAibmljMV9jbGsiLCAic3BsbF9idXNfY2xrIiwgfTsNCg0KVGhlIHJlZmVyZW5jZSBtYW51
YWwgZG9lcyBoYXZlIG1wbGwgYXMgY2xvY2sgb3B0aW9uLCBzbyBkbyB5b3UgbWVhbiBpdCB3aWxs
IE5PVCBiZSBzdXBwb3J0ZWQNCmFueW1vcmUsIGlzIG1wbGwgdXNlZCBpbnNpZGUgTUlQSSBQSFk/
DQoNCkFuc29uDQoNCj4gIHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgYXJtX3NlbHNbXQkJPSB7
ICJkaXZjb3JlIiwgImR1bW15IiwNCj4gImR1bW15IiwgImhzcnVuX2RpdmNvcmUiLCB9Ow0KPiAN
Cj4gIC8qIHVzZWQgYnkgc29zYy9zaXJjL2ZpcmMvZGRyL3NwbGwvYXBsbCBkaXZpZGVycyAqLyBA
QCAtNzUsNyArNzUsNiBAQCBzdGF0aWMNCj4gdm9pZCBfX2luaXQgaW14N3VscF9jbGtfc2NnMV9p
bml0KHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnApDQo+ICAJY2xrc1tJTVg3VUxQX0NMS19TT1NDXQkJ
PQ0KPiBpbXhfb2J0YWluX2ZpeGVkX2Nsa19odyhucCwgInNvc2MiKTsNCj4gIAljbGtzW0lNWDdV
TFBfQ0xLX1NJUkNdCQk9DQo+IGlteF9vYnRhaW5fZml4ZWRfY2xrX2h3KG5wLCAic2lyYyIpOw0K
PiAgCWNsa3NbSU1YN1VMUF9DTEtfRklSQ10JCT0NCj4gaW14X29idGFpbl9maXhlZF9jbGtfaHco
bnAsICJmaXJjIik7DQo+IC0JY2xrc1tJTVg3VUxQX0NMS19NSVBJX1BMTF0JPSBpbXhfb2J0YWlu
X2ZpeGVkX2Nsa19odyhucCwNCj4gIm1wbGwiKTsNCj4gIAljbGtzW0lNWDdVTFBfQ0xLX1VQTExd
CQk9DQo+IGlteF9vYnRhaW5fZml4ZWRfY2xrX2h3KG5wLCAidXBsbCIpOw0KPiANCj4gIAkvKiBT
Q0cxICovDQo+IC0tDQo+IDIuMTcuMQ0KDQo=
