Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D95C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 554B52184D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LH4QNGEJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbfHZMBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 08:01:12 -0400
Received: from mail-eopbgr20080.outbound.protection.outlook.com ([40.107.2.80]:64640
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726462AbfHZMBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 08:01:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFzNiuSdnIkx9PEHqgug7GImtS+HIXVfrIPv8vUzgsdNnQU/c/nTwLzoLjTap7Rx0RWMmob7NSy03ZoqiKsI5iETd1CVyVwqijw4egf4w6vuRjD1neOoj7SC3VTpEJlBZ55J2BkXjcIVD88Zsi+O2oBoY4qulSNC0Nk1p9cwu2SxW5p9D6o0Ad6IU5LJt3jWxHcYyNoLjxX1gaAu7ESW5fENPyitIGqiMS5XdgaV5/XGcL0d9EuO/xiu4Py2vI/65Gpi1hvP6UnLVzA8YjLU7+UNXZwCLnCiVtOBlI9PJyoiIyc+kKuDjgAj6tfGYKO9vnFxTJ8OSvDmUwPfNbun/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPfL3lP7yr3agx+nXHsw3gbCJ5hPnRqSEzsdLBXxwB0=;
 b=HY5NgBOoO4qBC3Z3SRxAuXRjLpgzTI2u0bUqXs/upXe3FA/G0CfxoYdKDzaNVkqEsUNi+O3RBrKVUttCGY3vPNUUw9FBr0Y9IXbLmc/kSNtyx+mVuEcEWlSrJYHlsUZ68SXD8AuQArp4Y3oeaFW3368GnBLg4RYep2Iwgi/sBq2W/0qJUI2GTfjJf/FCg+kNyoloeMCXf53L+RS3NftHgAnQn8KjqPxV+jLZvH+nTTKpmg106h4mn5xq65T7Mltuqz2mWkZyaKhptB1N1Sm77yktEI2YqXuOGaMMzyLNpfNYY8DT38qdXIG3fcWqpH9/C/sLmp0Op9pHAGBJNxCWJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPfL3lP7yr3agx+nXHsw3gbCJ5hPnRqSEzsdLBXxwB0=;
 b=LH4QNGEJXWTeC4XhDkeSicuSYHgv3RGl3YHSPIQbKDwbGgj+i2ZVUlROkw9t2hw6yO07D7heYaVQWc9aIRt5SjlAilx/SJhrquxLf4FrQV3+9a5phlj9WE/PKG1mBshESL3utWvSRvG88TdzXbNrBYUHel2EjjGpeIkwv1sWjwU=
Received: from VI1PR04MB4094.eurprd04.prod.outlook.com (52.133.13.160) by
 VI1PR04MB5152.eurprd04.prod.outlook.com (20.177.50.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Mon, 26 Aug 2019 12:01:08 +0000
Received: from VI1PR04MB4094.eurprd04.prod.outlook.com
 ([fe80::c85e:7409:9270:3c3c]) by VI1PR04MB4094.eurprd04.prod.outlook.com
 ([fe80::c85e:7409:9270:3c3c%7]) with mapi id 15.20.2199.021; Mon, 26 Aug 2019
 12:01:07 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH -next] ASoC: SOF: imx8: Fix return value check in
 imx8_probe()
Thread-Topic: [PATCH -next] ASoC: SOF: imx8: Fix return value check in
 imx8_probe()
Thread-Index: AQHVXAVURdTE2TLQcUqNKaWgZ7E+X6cNU9eA
Date:   Mon, 26 Aug 2019 12:01:07 +0000
Message-ID: <01883a69834142f14cd3ac6c9cb97343ee432d67.camel@nxp.com>
References: <20190826120003.183279-1-weiyongjun1@huawei.com>
In-Reply-To: <20190826120003.183279-1-weiyongjun1@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2cd02f12-887c-4194-f962-08d72a1d1450
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5152;
x-ms-traffictypediagnostic: VI1PR04MB5152:
x-microsoft-antispam-prvs: <VI1PR04MB5152316D20A6B44864EA11C7F9A10@VI1PR04MB5152.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(199004)(189003)(256004)(44832011)(25786009)(86362001)(2201001)(71200400001)(71190400001)(2906002)(229853002)(6486002)(6512007)(2501003)(446003)(102836004)(6506007)(186003)(3846002)(486006)(7416002)(76176011)(36756003)(476003)(4326008)(316002)(478600001)(14454004)(99286004)(54906003)(110136005)(6116002)(6436002)(11346002)(26005)(8936002)(50226002)(2616005)(305945005)(118296001)(7736002)(81166006)(66946007)(91956017)(76116006)(64756008)(66476007)(66446008)(8676002)(81156014)(66556008)(53936002)(5660300002)(66066001)(6246003)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5152;H:VI1PR04MB4094.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wf+je2M7NTeT8R3AnnHAJ/F1EOFawqW97pNKsSDI5tPD/AtPRk4HENAB3sUXWxXw5XyfCvmVTjW5M/p54LzkKi6o3PzuMWYLpgiXKIsz74SefIicUmfSdimIyiiRC/GgFZHzQgtRdcMkdudH8JDjcEtbAnO4bKNx2b+cd6xRyGB7LsAsZGFURH3gP3SzemM6fHcDrq3TKTjSp7C860UCteTiLKxyHhmBmpQUywxUif9Gy8QJspHU7jZKHcEtOItTnvDH3Vfnjv3AT9dI26s68Zc7Ybr1FFR49T4yUWurCUnb4ll6QHymEa96PYMhS0c5MMzGHRlwEp7210hRig/VTwXcffQq2sCs3NkM7pICRgLD+g3TdtuDJJbKOBeiXJLISSyiUuBMXXWdcRfErnot2L2bxzVtl3u8dbedAJrfCYg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2F4893BB6C8E845AC840622770CE331@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd02f12-887c-4194-f962-08d72a1d1450
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 12:01:07.7474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N1yZ+MXDkqhOtrH3M+KccXE2k6YCOw/zj2sP0zsO8L65C05/t7Rf1SDEwzyFsAce2bVgJMMsoHcV06J2k08JGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTA4LTI2IGF0IDEyOjAwICswMDAwLCBXZWkgWW9uZ2p1biB3cm90ZToNCj4g
SW4gY2FzZSBvZiBlcnJvciwgdGhlIGZ1bmN0aW9uIGRldm1faW9yZW1hcF93YygpIHJldHVybnMg
TlVMTCBwb2ludGVyDQo+IG5vdCBFUlJfUFRSKCkuIFRoZSBJU19FUlIoKSB0ZXN0IGluIHRoZSBy
ZXR1cm4gdmFsdWUgY2hlY2sgc2hvdWxkIGJlDQo+IHJlcGxhY2VkIHdpdGggTlVMTCB0ZXN0Lg0K
PiANCj4gRml4ZXM6IDIwMmFjYzU2NWExZiAoIkFTb0M6IFNPRjogaW14OiBBZGQgaS5NWDggSFcg
c3VwcG9ydCIpDQo+IFNpZ25lZC1vZmYtYnk6IFdlaSBZb25nanVuIDx3ZWl5b25nanVuMUBodWF3
ZWkuY29tPg0KDQpHb29kIGNhdGNoLiBUaGFua3MhDQoNClJldmlld2VkLWJ5OiBEYW5pZWwgQmFs
dXRhIDxkYW5pZWwuYmFsdXRhQG54cC5jb20+DQoNCj4gLS0tDQo+ICBzb3VuZC9zb2Mvc29mL2lt
eC9pbXg4LmMgfCA0ICsrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL3NvZi9pbXgvaW14OC5j
IGIvc291bmQvc29jL3NvZi9pbXgvaW14OC5jDQo+IGluZGV4IGU1MDJmNTg0MjA3Zi4uMjYzZDRk
ZjM1ZmU4IDEwMDY0NA0KPiAtLS0gYS9zb3VuZC9zb2Mvc29mL2lteC9pbXg4LmMNCj4gKysrIGIv
c291bmQvc29jL3NvZi9pbXgvaW14OC5jDQo+IEBAIC0yOTYsMTAgKzI5NiwxMCBAQCBzdGF0aWMg
aW50IGlteDhfcHJvYmUoc3RydWN0IHNuZF9zb2ZfZGV2ICpzZGV2KQ0KPiAgCXNkZXYtPmJhcltT
T0ZfRldfQkxLX1RZUEVfU1JBTV0gPSBkZXZtX2lvcmVtYXBfd2Moc2Rldi0+ZGV2LA0KPiByZXMu
c3RhcnQsDQo+ICAJCQkJCQkJICByZXMuZW5kIC0NCj4gcmVzLnN0YXJ0ICsNCj4gIAkJCQkJCQkg
IDEpOw0KPiAtCWlmIChJU19FUlIoc2Rldi0+YmFyW1NPRl9GV19CTEtfVFlQRV9TUkFNXSkpIHsN
Cj4gKwlpZiAoIXNkZXYtPmJhcltTT0ZfRldfQkxLX1RZUEVfU1JBTV0pIHsNCj4gIAkJZGV2X2Vy
cihzZGV2LT5kZXYsICJmYWlsZWQgdG8gaW9yZW1hcCBtZW0gMHgleCBzaXplDQo+IDB4JXhcbiIs
DQo+ICAJCQliYXNlLCBzaXplKTsNCj4gLQkJcmV0ID0gUFRSX0VSUihzZGV2LT5iYXJbU09GX0ZX
X0JMS19UWVBFX1NSQU1dKTsNCj4gKwkJcmV0ID0gLUVOT01FTTsNCj4gIAkJZ290byBleGl0X3Bk
ZXZfdW5yZWdpc3RlcjsNCj4gIAl9DQo+ICAJc2Rldi0+bWFpbGJveF9iYXIgPSBTT0ZfRldfQkxL
X1RZUEVfU1JBTTsNCj4gDQo+IA0KPiANCg==
