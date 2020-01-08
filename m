Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AFFC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CFB720848
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="J8DMYG2F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgAHIGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 03:06:46 -0500
Received: from mail-eopbgr70057.outbound.protection.outlook.com ([40.107.7.57]:63143
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726492AbgAHIGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 03:06:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g70Go7EUvhE5Nrr1ECCN3WrgMK1MiUYrggszMz5PaNSnIEqp+e4n8U2CZhFxLqSAJHtVh99OaI1liI5Ijq9QaTjtpNLtxmpWZKag/n8twssdomvmVpSQuwDx3knK+xhqKxFICnA/JR1h4HQ/MaJ+/TLuUETdb9JSKipIqYrj+9JiccWeupLVB5nQmkICIZBVmiud/8PtlOCI+VqnmPV6i3oHHnKYC5+B7ChXoo75/fJSzK2UdWMN9rsVhjm5h548cuFleqeGc/ozLn8ZPFuBmFJ3hAfffOaXVvjUS6j2ASCehIAPD6wbx2KZtASEJ+Cmq4h/52BmjgUxrceTbO3LGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CO1JY97odh1SEKMNWMfN5oAB2HaTljlKNmW8/jUfzzU=;
 b=ZEJ47Vr70XlpaXNL6sBz6LdF+pxYAMzf8UTQHZ4hqRSISyMPZMHeo3Hd4903h9lg7V5LxjOkCmTRkFK9tO52uV5X0pAZPjByqTb0sYDziUcSZGq4xijl5YuTdYxutiwzLZsD4mHEC9cQmWnbs3Fg8K/BThQYgi2GfvX9TKhMTk72RcVOjOf2hMqI40inK/l/u1Y6I+Vt+FEE3hzkyesucMKF2y9jjkNt0i8H9wIv2M8IwpQ1Ek8GnyTUP0s0KEzJJqjAhORNx35dS3za3aJ18tdCQUfP3h5iE2qE0zfjc+pGtyDGQ3/eO/87M9SEvntuucxeVtrU0iyNB1AzXiCGyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CO1JY97odh1SEKMNWMfN5oAB2HaTljlKNmW8/jUfzzU=;
 b=J8DMYG2FebFuF0uE3AtvyqCa+5BoG+ZQra7ICh+6APhLhTv/Zieah4lD7t9ke1Pf0P39l670IXjLKDI+P2RjfGg8gn/YvdUEP4CUocfANFC3g6r7ttmyc4kqnAjllndtFWsCqtmqVzxP8fZcMLqQAaufcLpklAeGzpcaKdduKoE=
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com (52.134.16.147) by
 VI1PR0402MB3790.eurprd04.prod.outlook.com (52.134.18.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Wed, 8 Jan 2020 08:06:39 +0000
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::8881:e155:f058:c0d1]) by VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::8881:e155:f058:c0d1%4]) with mapi id 15.20.2602.015; Wed, 8 Jan 2020
 08:06:39 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>, Jun Li <jun.li@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "aford173@gmail.com" <aford173@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mm: Memory node should be in board DT
Thread-Topic: [PATCH 1/2] arm64: dts: imx8mm: Memory node should be in board
 DT
Thread-Index: AQHVxfVdXcchcCRfCEWB2x7J7LO1cKfgaS8A
Date:   Wed, 8 Jan 2020 08:06:39 +0000
Message-ID: <64c1429303c9dfc6331e1476cbf4564ddb9137c4.camel@nxp.com>
References: <1578468329-9983-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1578468329-9983-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ef06812c-4b49-4d74-e3b6-08d79411b096
x-ms-traffictypediagnostic: VI1PR0402MB3790:|VI1PR0402MB3790:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB379007201FABF4E699EDFF86F93E0@VI1PR0402MB3790.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(199004)(189003)(76116006)(71200400001)(26005)(66476007)(478600001)(2906002)(6506007)(7416002)(6512007)(66446008)(316002)(91956017)(66556008)(44832011)(2616005)(64756008)(66946007)(86362001)(110136005)(4326008)(36756003)(6486002)(8936002)(5660300002)(8676002)(186003)(81166006)(81156014)(99106002)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3790;H:VI1PR0402MB3839.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mSkKITBy5x+XT0wg5ZOtxtoYDb5i5C83JV1J4GTIYsyxteiOjibm4el1gyYI4G/yLajkdqweMheOPztB69spo/29CUym9EUcc+oOz1LQZM0k6jDloWjETEI3nmPeytRLGaSMkT1SSGSKUDrA+rYAxDGPCpSHzC2IQT3aiA65NhxtOAJZ9N5ynwhZjDW30WBmfG65IX43ZHgzUAygmadNj4pML3ioyFY1MuPPHj6WJwx+TDAC7Q9IetTvduyuIuX2ck2Gjl/lFazZwBkfXAKgx+KtkvdGt/HRnQ5MeWewydYBRw1olFj12h8IEfzgVq0qjlm9CAllQ4CIBVzrFnufqSKaiQCe7IEZKhw1VqK+r2H9I1pmugIOOqdP+KO78OnBM4yYJuNytyQpqmFh7BExtCVspov9XgvPGrUf1JRVhZmmHmHyeIrLSNxG8RkSV/2Duyse+srxV2GdayBA88578vKX+DB5CbbnLYaHrqiLKoXdBIoBENCOitoWq6dsRLwSuzAGh5ohba9PXrPxS6fFRC5L+AIvRw9lKG66WCJDDuJR/VlukxYQuNXG4JVjEYAP
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF375F58A9822D44AF24114DFB27A9E6@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef06812c-4b49-4d74-e3b6-08d79411b096
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 08:06:39.3128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E8ANtxzf/7beePSGTwBnXzqlhbb4o6CA4Vq6a2Ok5oNy6xUsVIP3+W4uonWRpr/Tt0G+jHxpGuP7mx3hSYmcpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3790
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTAxLTA4IGF0IDE1OjI1ICswODAwLCBBbnNvbiBIdWFuZyB3cm90ZToNCj4g
TWVtb3J5IGFkZHJlc3Mvc2l6ZSBkZXBlbmRzIG9uIGJvYXJkIGRlc2lnbiwgc28gbWVtb3J5IG5v
ZGUgc2hvdWxkDQo+IGJlIGluIGJvYXJkIERULg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5zb24g
SHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQoNClJldmlld2VkLWJ5OiBEYW5pZWwgQmFsdXRh
IDxkYW5pZWwuYmFsdXRhQG54cC5jb20+DQoNCkNhcmUgdG8gYWRkIGEgY292ZXIgbGV0dGVyIGZv
ciB5b3VyIG5leHQgcGF0Y2ggc2VyaWVzPyA6KS4NCg0KSnVzdCB1c2UgLS1jb3Zlci1sZXR0ZXIg
YXJndW1lbnQgZm9yIGdpdCBmb3JtYXQtcGF0Y2guDQoNClRodXMsIHdlIGNhbiBrZWVwIHJldmlz
aW9uIGhpc3RvcnkgY2VudHJhbGl6ZWQgYW5kIGNhbiBqdXN0IG9uZQ0KUmV2aWV3ZWQtYnkvVGVz
dGVkLWJ5IHRhZyA6KS4NCg0KPiAtLS0NCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2lteDhtbS1ldmsuZHRzIHwgNSArKysrKw0KPiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OG1tLmR0c2kgICAgfCA1IC0tLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0
aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tZXZrLmR0cw0KPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2lteDhtbS1ldmsuZHRzDQo+IGluZGV4IGNmMDQ0ZGQuLjllNTQ3NDcgMTAwNjQ0
DQo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1ldmsuZHRzDQo+
ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1ldmsuZHRzDQo+IEBA
IC0xNiw2ICsxNiwxMSBAQA0KPiAgCQlzdGRvdXQtcGF0aCA9ICZ1YXJ0MjsNCj4gIAl9Ow0KPiAg
DQo+ICsJbWVtb3J5QDQwMDAwMDAwIHsNCj4gKwkJZGV2aWNlX3R5cGUgPSAibWVtb3J5IjsNCj4g
KwkJcmVnID0gPDB4MCAweDQwMDAwMDAwIDAgMHg4MDAwMDAwMD47DQo+ICsJfTsNCj4gKw0KPiAg
CWxlZHMgew0KPiAgCQljb21wYXRpYmxlID0gImdwaW8tbGVkcyI7DQo+ICAJCXBpbmN0cmwtbmFt
ZXMgPSAiZGVmYXVsdCI7DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9pbXg4bW0uZHRzaQ0KPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDht
bS5kdHNpDQo+IGluZGV4IGEzZDE3OWIuLjFlNWUxMTUgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpDQo+IEBAIC0xNDAsMTEgKzE0MCw2IEBADQo+ICAJ
CX07DQo+ICAJfTsNCj4gIA0KPiAtCW1lbW9yeUA0MDAwMDAwMCB7DQo+IC0JCWRldmljZV90eXBl
ID0gIm1lbW9yeSI7DQo+IC0JCXJlZyA9IDwweDAgMHg0MDAwMDAwMCAwIDB4ODAwMDAwMDA+Ow0K
PiAtCX07DQo+IC0NCj4gIAlvc2NfMzJrOiBjbG9jay1vc2MtMzJrIHsNCj4gIAkJY29tcGF0aWJs
ZSA9ICJmaXhlZC1jbG9jayI7DQo+ICAJCSNjbG9jay1jZWxscyA9IDwwPjsNCg==
