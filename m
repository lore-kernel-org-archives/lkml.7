Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2E1C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 06:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01BCC20881
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 06:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GD3sGZm3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfD1Ga7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 02:30:59 -0400
Received: from mail-eopbgr10065.outbound.protection.outlook.com ([40.107.1.65]:2789
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726133AbfD1Ga6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 02:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+XiZpZKuxdJ+J0p9GIjOP+zU9RiR1u5EvFoFpPUnAY=;
 b=GD3sGZm3Digv1mjnFuGWthJam17zQzS9jFVSDnL0vWxPlDBnea/Ywitw+T72a8U4tKBW1WFxnK29ZtVwrfNMA2CR+FHnei2BtQOCY5cCDJyUEiM/eNbSdEQgh1hyfdtcPJfaKVhUb46yn37nYstv08K6RIOK4VR9yvfEX56Wrb0=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3898.eurprd04.prod.outlook.com (52.134.65.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Sun, 28 Apr 2019 06:30:11 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1835.016; Sun, 28 Apr 2019
 06:30:11 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Mukesh Ojha <mojha@codeaurora.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] input: imx6ul_tsc: use devm_platform_ioremap_resource()
 to simplify code
Thread-Topic: [PATCH] input: imx6ul_tsc: use devm_platform_ioremap_resource()
 to simplify code
Thread-Index: AQHU6EqK7YCFSFAUiEmCAJSqda9wGaYm8dcAgCpVLOA=
Date:   Sun, 28 Apr 2019 06:30:11 +0000
Message-ID: <DB3PR0402MB3916D9B009F5187D52A8A7D3F5380@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1554095712-15413-1-git-send-email-Anson.Huang@nxp.com>
 <d3b8cf17-36bb-d79d-7d60-76ae2416075d@codeaurora.org>
In-Reply-To: <d3b8cf17-36bb-d79d-7d60-76ae2416075d@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66cf7c47-e8e2-4339-8bc2-08d6cba2f775
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3898;
x-ms-traffictypediagnostic: DB3PR0402MB3898:
x-microsoft-antispam-prvs: <DB3PR0402MB38982A5F16B9A55EFE413586F5380@DB3PR0402MB3898.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 0021920B5A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(346002)(136003)(376002)(189003)(13464003)(199004)(71190400001)(102836004)(6246003)(256004)(110136005)(2201001)(97736004)(2906002)(64756008)(66476007)(66556008)(476003)(5660300002)(71200400001)(478600001)(11346002)(86362001)(446003)(73956011)(76116006)(66066001)(66446008)(66946007)(186003)(7696005)(6436002)(26005)(76176011)(33656002)(55016002)(486006)(7736002)(14454004)(52536014)(8936002)(68736007)(74316002)(99286004)(305945005)(44832011)(6116002)(81156014)(229853002)(3846002)(8676002)(53546011)(53936002)(4326008)(81166006)(2501003)(9686003)(316002)(25786009)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3898;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: K33xFCdCJREOUNEmM/mljdmLlYpMi5xv63VJZvVDrUN6KT771CoBhBcy91JmWx4vXHDv6Zg+CMy/ac4JgqAECSxFq6UG+yyn58h1XD0dJHLeA/Mu6VaXdCyDAk5El2JVutX9vyR6aG9ntjJqqWj+HKSuYhpijn0qc5/oPWpmChymRBnr2rq6ui6uXxZohEhZ6i61ijlmm+MpXi85l3JZNA3Bhc2S6WtogUzxRv97hDL3ujfmW09XPonc3L3YMmYRFtrRffHfX4kpWGZ5IPlcfW67zAp+yer8TgnFRMrxCrSWFKrIXdyiJvNHE3nu6PJaZFUmnJWuhS9TPxsQhgGFu3ujkHeRnIc9oDbuC/sb8chvJS8R5UnikHwC/z2TbBgDDIVPD348HkY7c0HiLmnL+XuabqjfI3QvpZ1Z4iBrcZU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66cf7c47-e8e2-4339-8bc2-08d6cba2f775
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2019 06:30:11.4739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3898
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGluZy4uLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE11a2VzaCBP
amhhIFttYWlsdG86bW9qaGFAY29kZWF1cm9yYS5vcmddDQo+IFNlbnQ6IE1vbmRheSwgQXByaWwg
MSwgMjAxOSA0OjAyIFBNDQo+IFRvOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT47
IGRtaXRyeS50b3Jva2hvdkBnbWFpbC5jb207DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1
ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsNCj4gZmVzdGV2YW1AZ21h
aWwuY29tOyBsaW51eC1pbnB1dEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS0NCj4ga2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6
IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hd
IGlucHV0OiBpbXg2dWxfdHNjOiB1c2UNCj4gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNl
KCkgdG8gc2ltcGxpZnkgY29kZQ0KPiANCj4gDQo+IE9uIDQvMS8yMDE5IDEwOjQ5IEFNLCBBbnNv
biBIdWFuZyB3cm90ZToNCj4gPiBVc2UgdGhlIG5ldyBoZWxwZXIgZGV2bV9wbGF0Zm9ybV9pb3Jl
bWFwX3Jlc291cmNlKCkgd2hpY2ggd3JhcHMgdGhlDQo+ID4gcGxhdGZvcm1fZ2V0X3Jlc291cmNl
KCkgYW5kIGRldm1faW9yZW1hcF9yZXNvdXJjZSgpIHRvZ2V0aGVyLCB0bw0KPiA+IHNpbXBsaWZ5
IHRoZSBjb2RlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1
YW5nQG54cC5jb20+DQo+IA0KPiANCj4gUmV2aWV3ZWQtYnk6IE11a2VzaCBPamhhIDxtb2poYUBj
b2RlYXVyb3JhLm9yZz4NCj4gDQo+IENoZWVycywNCj4gLU11a2VzaA0KPiANCj4gPiAtLS0NCj4g
PiAgIGRyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vaW14NnVsX3RzYy5jIHwgOCArKy0tLS0tLQ0K
PiA+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lucHV0L3RvdWNoc2NyZWVuL2lteDZ1bF90c2Mu
Yw0KPiA+IGIvZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9pbXg2dWxfdHNjLmMNCj4gPiBpbmRl
eCBjMTBmYzU5Li5lMDRlZWNkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaW5wdXQvdG91Y2hz
Y3JlZW4vaW14NnVsX3RzYy5jDQo+ID4gKysrIGIvZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9p
bXg2dWxfdHNjLmMNCj4gPiBAQCAtMzY0LDggKzM2NCw2IEBAIHN0YXRpYyBpbnQgaW14NnVsX3Rz
Y19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiA+ICAgCXN0cnVjdCBk
ZXZpY2Vfbm9kZSAqbnAgPSBwZGV2LT5kZXYub2Zfbm9kZTsNCj4gPiAgIAlzdHJ1Y3QgaW14NnVs
X3RzYyAqdHNjOw0KPiA+ICAgCXN0cnVjdCBpbnB1dF9kZXYgKmlucHV0X2RldjsNCj4gPiAtCXN0
cnVjdCByZXNvdXJjZSAqdHNjX21lbTsNCj4gPiAtCXN0cnVjdCByZXNvdXJjZSAqYWRjX21lbTsN
Cj4gPiAgIAlpbnQgZXJyOw0KPiA+ICAgCWludCB0c2NfaXJxOw0KPiA+ICAgCWludCBhZGNfaXJx
Ow0KPiA+IEBAIC00MDMsMTYgKzQwMSwxNCBAQCBzdGF0aWMgaW50IGlteDZ1bF90c2NfcHJvYmUo
c3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgIAkJcmV0dXJuIGVycjsNCj4g
PiAgIAl9DQo+ID4NCj4gPiAtCXRzY19tZW0gPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwg
SU9SRVNPVVJDRV9NRU0sIDApOw0KPiA+IC0JdHNjLT50c2NfcmVncyA9IGRldm1faW9yZW1hcF9y
ZXNvdXJjZSgmcGRldi0+ZGV2LCB0c2NfbWVtKTsNCj4gPiArCXRzYy0+dHNjX3JlZ3MgPSBkZXZt
X3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UocGRldiwgMCk7DQo+ID4gICAJaWYgKElTX0VSUih0
c2MtPnRzY19yZWdzKSkgew0KPiA+ICAgCQllcnIgPSBQVFJfRVJSKHRzYy0+dHNjX3JlZ3MpOw0K
PiA+ICAgCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJmYWlsZWQgdG8gcmVtYXAgdHNjIG1lbW9yeTog
JWRcbiIsDQo+IGVycik7DQo+ID4gICAJCXJldHVybiBlcnI7DQo+ID4gICAJfQ0KPiA+DQo+ID4g
LQlhZGNfbWVtID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAx
KTsNCj4gPiAtCXRzYy0+YWRjX3JlZ3MgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoJnBkZXYtPmRl
diwgYWRjX21lbSk7DQo+ID4gKwl0c2MtPmFkY19yZWdzID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFw
X3Jlc291cmNlKHBkZXYsIDEpOw0KPiA+ICAgCWlmIChJU19FUlIodHNjLT5hZGNfcmVncykpIHsN
Cj4gPiAgIAkJZXJyID0gUFRSX0VSUih0c2MtPmFkY19yZWdzKTsNCj4gPiAgIAkJZGV2X2Vycigm
cGRldi0+ZGV2LCAiZmFpbGVkIHRvIHJlbWFwIGFkYyBtZW1vcnk6ICVkXG4iLA0KPiBlcnIpOw0K
