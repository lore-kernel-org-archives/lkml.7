Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A8EC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D43207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DlAxG61N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfKOKGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 05:06:06 -0500
Received: from mail-eopbgr60045.outbound.protection.outlook.com ([40.107.6.45]:41890
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727779AbfKOKGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 05:06:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxF3aBvOFurZX5A9CUFnMKfP3vFG/pzyIVn5bSbLpu4+Gg1CeRWo3fWUBnyTPZ7qw6B6W4gpdUDPfTe3Y6F6x6RAm61cYsQuF2njKWUKFcaWEpK6rgFM9uy+V52zIxGrR0VNDStOe2paPHFYL5U6YG1kLi5hxD3yWtFdkYxdwPWAVtTzo+zDDdIq+5XjSrOg7UnjkcDJV67vuA+SGg1FR0nTwGKtICHrj3WX8umtowf4vbjfBWTeskMh0152YoAdnbAXv3l60FQHjcol8xzhB7tRYUt/6+FO3anlAPaCZ2InyGzOUwFEZtRPgD+gR5rquThIYzOaYOg3JLC/kEQuAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DUWw55HPCzJbQTWNnWTErK9+A8nVzABpTDVPj1+M/A=;
 b=kcWwitpti7u0f1lHXC7q4TWuryDXf0KJPYbCCEaN2ZnVXPEmOc33+h3/dLoazrZ9QY+x2Se6HgwMp/70PqNuCHZPtfDgLhsQ/zHcO2OLD//p/YfyPSi5d5HQv9XredOXz3nhxv93wArvN1ueAjeF5EAjOIbOozpZFqx9g+M5GYyZP46sh8SDhKqRTeDkySnxU4uzc2XKKZ/MJWhZx1TU19EOFL8Uzv0V6qV2pnXad1yp3fjSnU6zs8VlPnPxldp0k7XFEX5iCEHm0qGWQJ/OBBziu153wq79PydcwI/RKC3GRMHcK6D2elvgHMHtp8sLRExwaJk9TTiTYvTjQQOlSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DUWw55HPCzJbQTWNnWTErK9+A8nVzABpTDVPj1+M/A=;
 b=DlAxG61N3RkKJUKeKddIQfeCC25uAUJQcDw9PKJkDwPUUp1c9FXAiSCUt1PbtzKgO0OgMn8a26Vsu7sBQLBBIABfpRigdHp/2uKKGLoJAApyspXdmyoW57HQ/8XSqyxMGWjrkcIMO3t5JXQIrUR3d+0CyD007SKoHkkudpMe3aI=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4898.eurprd04.prod.outlook.com (20.177.41.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Fri, 15 Nov 2019 10:05:57 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2451.024; Fri, 15 Nov 2019
 10:05:57 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>
CC:     "allison@lohutok.net" <allison@lohutok.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ralf.ramsauer@oth-regensburg.de" <ralf.ramsauer@oth-regensburg.de>,
        Alice Guo <alice.guo@nxp.com>, dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] arm64: export __hyp_stub_vectors
Thread-Topic: [PATCH 2/2] arm64: export __hyp_stub_vectors
Thread-Index: AQHVm5lZpVu/s7W1Uk+l10ntkFA81qeL/0YAgAABgpA=
Date:   Fri, 15 Nov 2019 10:05:57 +0000
Message-ID: <AM0PR04MB4481A23F90A6C9BAF37BDC7B88700@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1573810972-2159-1-git-send-email-peng.fan@nxp.com>
 <1573810972-2159-2-git-send-email-peng.fan@nxp.com>
 <3aeabfb9-0680-08f6-49bc-38930c7a23df@siemens.com>
In-Reply-To: <3aeabfb9-0680-08f6-49bc-38930c7a23df@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 947f1580-c37f-4e31-0463-08d769b3690e
x-ms-traffictypediagnostic: AM0PR04MB4898:|AM0PR04MB4898:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB489876E502B4EDC9ADFBC51F88700@AM0PR04MB4898.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(189003)(199004)(33656002)(2201001)(2501003)(14444005)(6506007)(11346002)(66476007)(6116002)(86362001)(478600001)(81166006)(81156014)(66556008)(9686003)(8676002)(4326008)(52536014)(6246003)(6436002)(66066001)(14454004)(99286004)(186003)(55016002)(66446008)(66946007)(64756008)(26005)(53546011)(446003)(76176011)(256004)(76116006)(5660300002)(486006)(102836004)(71200400001)(71190400001)(476003)(2906002)(44832011)(3846002)(54906003)(229853002)(7736002)(8936002)(316002)(305945005)(25786009)(74316002)(7696005)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4898;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZIlmPoQhVFVgr2SOGDoCVBUAXIwr0m4ueumBMVSlMlVM90wg+d2vDe3CnjHUa5/VaR7SrIcrvKulD/nsXu65TMp9CXvjCCTSOLcS57DOBvtzMzjstzFuiP8A63N6Q+i6gu4GAXZ5ddJeCLsaB46VbjYCu/75nKtaUtPVI1epfJYIJgyExEj+6QCqtXh1SJtNflIshY0+y4pQGxRBMiM6DTtKx/FkFbEDALfqnnOLjxBjrv2ANN4YVnv6GCwyKbm1h+eXcEnXTg83XJgUgz9za4aI2l/qOtebV6NrFDSP5+JQ7MpdNGCOWOXbKeOQyvyHid3FhtsuKqds/CwRMDcQgUGiK6kZIs0+Ly1B9cl87cZQk6Uh2i5ygGeJSvcSNZNcV8+GoXOv54vUSzEOsyZJ+MCByswCQ5hDLK2f5zooGvTUGP70b46x5ErgW3aUZ2qY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 947f1580-c37f-4e31-0463-08d769b3690e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 10:05:57.7324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +W+oFJ4B2F9ea44d3piIbPTyCucs6hOEaP39RB3bBTxBRppYmVZNIb/eSXPyQPSFE95kcgleVugLyKP/pVS4Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4898
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gYXJtNjQ6IGV4cG9ydCBfX2h5cF9zdHViX3ZlY3Rv
cnMNCj4gDQo+IE9uIDE1LjExLjE5IDEwOjQ1LCBQZW5nIEZhbiB3cm90ZToNCj4gPiBGcm9tOiBQ
ZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPg0KPiA+IEV4dGVybmFsIGh5cGVydmlzb3Jz
LCBsaWtlIEphaWxob3VzZSwgbmVlZCB0aGlzIGFkZHJlc3Mgd2hlbiB0aGV5IGFyZQ0KPiA+IGRl
YWN0aXZhdGVkLCBpbiBvcmRlciB0byByZXN0b3JlIG9yaWdpbmFsIHN0YXRlLg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4gLS0tDQo+ID4g
ICBhcmNoL2FybTY0L2luY2x1ZGUvYXNtL3ZpcnQuaCB8IDIgKysNCj4gPiAgIGFyY2gvYXJtNjQv
a2VybmVsL2h5cC1zdHViLlMgIHwgMSArDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vdmly
dC5oDQo+ID4gYi9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL3ZpcnQuaCBpbmRleCAwOTU4ZWQ2MTkx
YWEuLmIxYjQ4MzUzZTNiMw0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvaW5jbHVk
ZS9hc20vdmlydC5oDQo+ID4gKysrIGIvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS92aXJ0LmgNCj4g
PiBAQCAtNjIsNiArNjIsOCBAQA0KPiA+ICAgICovDQo+ID4gICBleHRlcm4gdTMyIF9fYm9vdF9j
cHVfbW9kZVsyXTsNCj4gPg0KPiA+ICtleHRlcm4gY2hhciBfX2h5cF9zdHViX3ZlY3RvcnNbXTsN
Cj4gPiArDQo+ID4gICB2b2lkIF9faHlwX3NldF92ZWN0b3JzKHBoeXNfYWRkcl90IHBoeXNfdmVj
dG9yX2Jhc2UpOw0KPiA+ICAgdm9pZCBfX2h5cF9yZXNldF92ZWN0b3JzKHZvaWQpOw0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQva2VybmVsL2h5cC1zdHViLlMNCj4gPiBiL2FyY2gv
YXJtNjQva2VybmVsL2h5cC1zdHViLlMgaW5kZXggZjE3YWY5YTM5NTYyLi4yMmI3MjhmYjE0YmQN
Cj4gMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm02NC9rZXJuZWwvaHlwLXN0dWIuUw0KPiA+ICsr
KyBiL2FyY2gvYXJtNjQva2VybmVsL2h5cC1zdHViLlMNCj4gPiBAQCAtMzgsNiArMzgsNyBAQCBF
TlRSWShfX2h5cF9zdHViX3ZlY3RvcnMpDQo+ID4gICAJdmVudHJ5CWVsMV9maXFfaW52YWxpZAkJ
CS8vIEZJUSAzMi1iaXQgRUwxDQo+ID4gICAJdmVudHJ5CWVsMV9lcnJvcl9pbnZhbGlkCQkvLyBF
cnJvciAzMi1iaXQgRUwxDQo+ID4gICBFTkRQUk9DKF9faHlwX3N0dWJfdmVjdG9ycykNCj4gPiAr
RVhQT1JUX1NZTUJPTChfX2h5cF9zdHViX3ZlY3RvcnMpOw0KPiA+DQo+ID4gICAJLmFsaWduIDEx
DQo+ID4NCj4gPg0KPiANCj4gV2hpbGUgSSB3b3VsZCBub3QgZGlzbGlrZSB0byBoYXZlIHBhdGNo
LWZyZWUgYWNjZXNzIGluIEphaWxob3VzZSwgSSdtIG5vdCBzdXJlIGlmDQo+IGFuIG91dC1vZi10
cmVlIHVzZSBjYXNlIGp1c3RpZmllcyB0aGlzIGFuIGV4cG9ydC4NCj4gDQo+IEFsc28sIHRoaXMg
bGFja3MgdGhlIGFybSBlcXVpdmFsZW50IHRvIGJlIGNvbXBsZXRlLg0KDQphcm0gYW5kIGFybTY0
IGhhcyBkaWZmZXJlbnQgbWFpbnRhaW5lcnMuIElmIHRoaXMgYXJtNjQgaXMgYWNjZXB0YWJsZSwg
SSdsbCBjcmVhdGUNCmFybSBwYXRjaCBhbmQgc2VuZCBvdXQuDQoNClRoYW5rcywNClBlbmcuDQoN
Cj4gDQo+IEphbg0KPiANCj4gLS0NCj4gU2llbWVucyBBRywgQ29ycG9yYXRlIFRlY2hub2xvZ3ks
IENUIFJEQSBJT1QgU0VTLURFIENvcnBvcmF0ZQ0KPiBDb21wZXRlbmNlIENlbnRlciBFbWJlZGRl
ZCBMaW51eA0K
