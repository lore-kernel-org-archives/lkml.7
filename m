Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4239FC35280
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 11:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 014D82086A
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 11:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="jrzPFx2d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbfI3LzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 07:55:08 -0400
Received: from mail-eopbgr130121.outbound.protection.outlook.com ([40.107.13.121]:24558
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728214AbfI3LzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 07:55:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XodAm7NZzmf8ZuqfzsiLiqmCD9Z+9rzUaBrB4jE4mw4qVP+u2Y3Rx1uV1e0oB59cwFoIX1MIRkKJChGjzJH8GpB6cJId9fp/bn6sfnTVpwE2i6q3uwhy4EYnnf4LtzkxcomwZcrd2Vvp6KAuq/nRv/1yp/zwfpolirWfEuu3L+Ndz4ZKbwsN8W2KxBO/46zwTVYTwH8YdRPFHFCFJv39a7mGs7KCN4caRdfAhuI615kY/KLWkO+t8Xyus45K5MTj62pFwSQpLFrXi7ZzcWoO2qYsYZzRczaFW0snYsAi6kq5PBoc3EhPHLvdMFAFfgCxQZQmD6r8Q4mfRYBcKWAwBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuExzIaLD/o03+1LAQJFF59quXrSyJAydCKlnu5twus=;
 b=GFJ3ED604UP5bcJ6+wWh+bwawUfalpHU/XmJ9r+QfAn4ceqzxAax21fpF5q/BfbJZiQVKPsxGuFoMkYvGR2OoTxh1mM46WAYBaBLZdePiw4jDOTSNqE7XbgV5cHCwFVESJLiWNlimrTkZWwZ+EzXBxx8goUwxpzbfqiacHRg32T7mfwWiQOuzckydF3pdUv4rEj5Rc+GRsY9PF3IR4V6lGPk4kdpi4wfMVcl/sfgDLRXIXX/LFjQwSzPb05whItwzSZhnKMOZHdPzD1/W0BxjDI5QMdehgg1C+GTMUCNl/wIpuuOQ3EEwt08uSQvmxn734KkIG32pruaOvyKHBYFiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuExzIaLD/o03+1LAQJFF59quXrSyJAydCKlnu5twus=;
 b=jrzPFx2d9TlTxg1f8NhC0fk9EepnS7715tHVY1rHSOMorshq/iROQfWfVi7zpyQWwO/a3jtstYTkPPFC/rXkD3tAou2LGvF4xwdh+sL6f6717BCgQdibX0F8OhSX2Mu1+567jdR4lN8ozDItPx/O3NTO6sO9tDAuSwKQeyh3NL4=
Received: from AM6PR0502MB3958.eurprd05.prod.outlook.com (52.133.29.12) by
 AM6PR0502MB4024.eurprd05.prod.outlook.com (52.133.28.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Mon, 30 Sep 2019 11:54:59 +0000
Received: from AM6PR0502MB3958.eurprd05.prod.outlook.com
 ([fe80::60d7:cb8e:a39a:5a16]) by AM6PR0502MB3958.eurprd05.prod.outlook.com
 ([fe80::60d7:cb8e:a39a:5a16%6]) with mapi id 15.20.2284.028; Mon, 30 Sep 2019
 11:54:59 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [RESEND PATCH] ARM: dts: Add stmpe-adc DT node to Toradex T30
 modules
Thread-Topic: [RESEND PATCH] ARM: dts: Add stmpe-adc DT node to Toradex T30
 modules
Thread-Index: AQHVUo6HlKoSMlWVHkKJ8B1IIQyZPadEZqWA
Date:   Mon, 30 Sep 2019 11:54:59 +0000
Message-ID: <b40974742543a2e8450c097bf86c5c0d3baec977.camel@toradex.com>
References: <20190814105318.21902-1-philippe.schenker@toradex.com>
In-Reply-To: <20190814105318.21902-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0c718e7-860c-4211-dc07-08d7459d052e
x-ms-traffictypediagnostic: AM6PR0502MB4024:
x-microsoft-antispam-prvs: <AM6PR0502MB4024D846E951A9016E047822F4820@AM6PR0502MB4024.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(346002)(136003)(396003)(39840400004)(189003)(199004)(102836004)(6506007)(4326008)(76116006)(3846002)(66476007)(118296001)(305945005)(7736002)(26005)(186003)(11346002)(446003)(76176011)(6246003)(6116002)(66946007)(316002)(54906003)(110136005)(25786009)(478600001)(66556008)(91956017)(64756008)(66446008)(44832011)(2616005)(476003)(486006)(14454004)(36756003)(6436002)(2906002)(66066001)(5660300002)(229853002)(2501003)(6486002)(86362001)(2201001)(71190400001)(6512007)(99286004)(8676002)(81156014)(81166006)(8936002)(14444005)(256004)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0502MB4024;H:AM6PR0502MB3958.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0ehvDwiVR7ZHgcwBRIlPVGdAKCGXZ63M+TJMuLW3GWsHrd80t6fY3hj6cJb7CgIf3T8jFtLwDzKr28TyaGTNhLvH6DndySPuGcz5C+9c1Gh80YizbHWIIo0+4qvcYr3M54maWqiehSik6Wi6NtE3N24uDpY83u1pIxZ7ep8D7Bw94eDy6v0ZEC46GJY0oqUblPuE9vn//vspoywQ7LBqYRbOcrH4qvvHiBNuJuF5Bf2FZowMaHSPAS8wDUsZtzMO0ZWZ1+7Xs9Jq2fN4vHye7shI4P7yEytg/AXLqlv5ATbT8cf7drregupjfed9Hu+AsF0D3QpCKBAct4u3nMTcU6xQBISXCDQ9lPt+ENHdFfsemjOUmj+fuxBP9ytZbk+YRbxwzR3eTxrvI+f+qxnTjxHr2Ufd9iNoNiGVlX8FpEU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4A366A8AB460B489402F808F44AA3B1@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c718e7-860c-4211-dc07-08d7459d052e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 11:54:59.3804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i+JvnKkxFVCT04EyltaMqJ5qVh/tQwIml8FHUh7oKSFVGPUVyKccRzLDyeW4Ca1+9bT2js/4kXGfcN+fKPJFx1aIbT8pEpUiRr7TH2wrSLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0502MB4024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA4LTE0IGF0IDEwOjUzICswMDAwLCBQaGlsaXBwZSBTY2hlbmtlciB3cm90
ZToNCj4gQWRkIHRoZSBzdG1wZS1hZGMgRFQgbm9kZSBhcyBmb3VuZCBvbiBUb3JhZGV4IFQzMCBt
b2R1bGVzDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBTY2hlbmtlciA8cGhpbGlwcGUu
c2NoZW5rZXJAdG9yYWRleC5jb20+DQoNCkhpIFRoaWVycnksIGNvdWxkIHlvdSBwbGVhc2UgcHVs
bCB0aGlzIHBhdGNoIGZvciA1LjQ/IE9yIHRlbGwgbWUgd2hhdCBpcw0KaG9sZGluZyBpdCBiYWNr
IGZyb20gYmVpbmcgcHVsbGVkPw0KDQpUaGFua3MgZm9yIHlvdXIgZmVlZGJhY2sNCg0KUGhpbGlw
cGUNCg0KPiANCj4gLS0tDQo+IA0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvdGVncmEzMC1hcGFsaXMt
djEuMS5kdHNpIHwgMjIgKysrKysrKysrKysrKystLS0tLS0tDQo+IC0NCj4gIGFyY2gvYXJtL2Jv
b3QvZHRzL3RlZ3JhMzAtYXBhbGlzLmR0c2kgICAgICB8IDIyICsrKysrKysrKysrKysrLS0tLS0t
LQ0KPiAtDQo+ICBhcmNoL2FybS9ib290L2R0cy90ZWdyYTMwLWNvbGlicmkuZHRzaSAgICAgfCAy
MiArKysrKysrKysrKysrKy0tLS0tLS0NCj4gLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA0MiBpbnNl
cnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9i
b290L2R0cy90ZWdyYTMwLWFwYWxpcy12MS4xLmR0c2kNCj4gYi9hcmNoL2FybS9ib290L2R0cy90
ZWdyYTMwLWFwYWxpcy12MS4xLmR0c2kNCj4gaW5kZXggMDJmODEyNjQ4MWEyLi44YjdhODI3ZDYw
NGQgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL3RlZ3JhMzAtYXBhbGlzLXYxLjEu
ZHRzaQ0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy90ZWdyYTMwLWFwYWxpcy12MS4xLmR0c2kN
Cj4gQEAgLTk5NCwxMSArOTk0LDE3IEBADQo+ICAJCQlpZCA9IDwwPjsNCj4gIAkJCWJsb2NrcyA9
IDwweDU+Ow0KPiAgCQkJaXJxLXRyaWdnZXIgPSA8MHgxPjsNCj4gKwkJCS8qIDMuMjUgTUh6IEFE
QyBjbG9jayBzcGVlZCAqLw0KPiArCQkJc3QsYWRjLWZyZXEgPSA8MT47DQo+ICsJCQkvKiAxMi1i
aXQgQURDICovDQo+ICsJCQlzdCxtb2QtMTJiID0gPDE+Ow0KPiArCQkJLyogaW50ZXJuYWwgQURD
IHJlZmVyZW5jZSAqLw0KPiArCQkJc3QscmVmLXNlbCA9IDwwPjsNCj4gKwkJCS8qIEFEQyBjb252
ZXJzdGlvbiB0aW1lOiA4MCBjbG9ja3MgKi8NCj4gKwkJCXN0LHNhbXBsZS10aW1lID0gPDQ+Ow0K
PiAgDQo+ICAJCQlzdG1wZV90b3VjaHNjcmVlbiB7DQo+ICAJCQkJY29tcGF0aWJsZSA9ICJzdCxz
dG1wZS10cyI7DQo+IC0JCQkJLyogMy4yNSBNSHogQURDIGNsb2NrIHNwZWVkICovDQo+IC0JCQkJ
c3QsYWRjLWZyZXEgPSA8MT47DQo+ICAJCQkJLyogOCBzYW1wbGUgYXZlcmFnZSBjb250cm9sICov
DQo+ICAJCQkJc3QsYXZlLWN0cmwgPSA8Mz47DQo+ICAJCQkJLyogNyBsZW5ndGggZnJhY3Rpb25h
bCBwYXJ0IGluIHogKi8NCj4gQEAgLTEwMDgsMTcgKzEwMTQsMTcgQEANCj4gIAkJCQkgKiBjdXJy
ZW50IGxpbWl0IHZhbHVlDQo+ICAJCQkJICovDQo+ICAJCQkJc3QsaS1kcml2ZSA9IDwxPjsNCj4g
LQkJCQkvKiAxMi1iaXQgQURDICovDQo+IC0JCQkJc3QsbW9kLTEyYiA9IDwxPjsNCj4gLQkJCQkv
KiBpbnRlcm5hbCBBREMgcmVmZXJlbmNlICovDQo+IC0JCQkJc3QscmVmLXNlbCA9IDwwPjsNCj4g
LQkJCQkvKiBBREMgY29udmVyc3Rpb24gdGltZTogODAgY2xvY2tzICovDQo+IC0JCQkJc3Qsc2Ft
cGxlLXRpbWUgPSA8ND47DQo+ICAJCQkJLyogMSBtcyBwYW5lbCBkcml2ZXIgc2V0dGxpbmcgdGlt
ZSAqLw0KPiAgCQkJCXN0LHNldHRsaW5nID0gPDM+Ow0KPiAgCQkJCS8qIDUgbXMgdG91Y2ggZGV0
ZWN0IGludGVycnVwdCBkZWxheSAqLw0KPiAgCQkJCXN0LHRvdWNoLWRldC1kZWxheSA9IDw1PjsN
Cj4gIAkJCX07DQo+ICsNCj4gKwkJCXN0bXBlX2FkYyB7DQo+ICsJCQkJY29tcGF0aWJsZSA9ICJz
dCxzdG1wZS1hZGMiOw0KPiArCQkJCS8qIGZvcmJpZCB0byB1c2UgQURDIGNoYW5uZWxzIDMtMA0K
PiAodG91Y2gpICovDQo+ICsJCQkJc3Qsbm9yZXF1ZXN0LW1hc2sgPSA8MHgwRj47DQo+ICsJCQl9
Ow0KPiAgCQl9Ow0KPiAgDQo+ICAJCS8qDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0
cy90ZWdyYTMwLWFwYWxpcy5kdHNpDQo+IGIvYXJjaC9hcm0vYm9vdC9kdHMvdGVncmEzMC1hcGFs
aXMuZHRzaQ0KPiBpbmRleCA3ZjExMmYxOTJmZTkuLmMxOGY2ZjYxZDc2NCAxMDA2NDQNCj4gLS0t
IGEvYXJjaC9hcm0vYm9vdC9kdHMvdGVncmEzMC1hcGFsaXMuZHRzaQ0KPiArKysgYi9hcmNoL2Fy
bS9ib290L2R0cy90ZWdyYTMwLWFwYWxpcy5kdHNpDQo+IEBAIC05NzYsMTEgKzk3NiwxNyBAQA0K
PiAgCQkJaWQgPSA8MD47DQo+ICAJCQlibG9ja3MgPSA8MHg1PjsNCj4gIAkJCWlycS10cmlnZ2Vy
ID0gPDB4MT47DQo+ICsJCQkvKiAzLjI1IE1IeiBBREMgY2xvY2sgc3BlZWQgKi8NCj4gKwkJCXN0
LGFkYy1mcmVxID0gPDE+Ow0KPiArCQkJLyogMTItYml0IEFEQyAqLw0KPiArCQkJc3QsbW9kLTEy
YiA9IDwxPjsNCj4gKwkJCS8qIGludGVybmFsIEFEQyByZWZlcmVuY2UgKi8NCj4gKwkJCXN0LHJl
Zi1zZWwgPSA8MD47DQo+ICsJCQkvKiBBREMgY29udmVyc3Rpb24gdGltZTogODAgY2xvY2tzICov
DQo+ICsJCQlzdCxzYW1wbGUtdGltZSA9IDw0PjsNCj4gIA0KPiAgCQkJc3RtcGVfdG91Y2hzY3Jl
ZW4gew0KPiAgCQkJCWNvbXBhdGlibGUgPSAic3Qsc3RtcGUtdHMiOw0KPiAtCQkJCS8qIDMuMjUg
TUh6IEFEQyBjbG9jayBzcGVlZCAqLw0KPiAtCQkJCXN0LGFkYy1mcmVxID0gPDE+Ow0KPiAgCQkJ
CS8qIDggc2FtcGxlIGF2ZXJhZ2UgY29udHJvbCAqLw0KPiAgCQkJCXN0LGF2ZS1jdHJsID0gPDM+
Ow0KPiAgCQkJCS8qIDcgbGVuZ3RoIGZyYWN0aW9uYWwgcGFydCBpbiB6ICovDQo+IEBAIC05OTAs
MTcgKzk5NiwxNyBAQA0KPiAgCQkJCSAqIGN1cnJlbnQgbGltaXQgdmFsdWUNCj4gIAkJCQkgKi8N
Cj4gIAkJCQlzdCxpLWRyaXZlID0gPDE+Ow0KPiAtCQkJCS8qIDEyLWJpdCBBREMgKi8NCj4gLQkJ
CQlzdCxtb2QtMTJiID0gPDE+Ow0KPiAtCQkJCS8qIGludGVybmFsIEFEQyByZWZlcmVuY2UgKi8N
Cj4gLQkJCQlzdCxyZWYtc2VsID0gPDA+Ow0KPiAtCQkJCS8qIEFEQyBjb252ZXJzdGlvbiB0aW1l
OiA4MCBjbG9ja3MgKi8NCj4gLQkJCQlzdCxzYW1wbGUtdGltZSA9IDw0PjsNCj4gIAkJCQkvKiAx
IG1zIHBhbmVsIGRyaXZlciBzZXR0bGluZyB0aW1lICovDQo+ICAJCQkJc3Qsc2V0dGxpbmcgPSA8
Mz47DQo+ICAJCQkJLyogNSBtcyB0b3VjaCBkZXRlY3QgaW50ZXJydXB0IGRlbGF5ICovDQo+ICAJ
CQkJc3QsdG91Y2gtZGV0LWRlbGF5ID0gPDU+Ow0KPiAgCQkJfTsNCj4gKw0KPiArCQkJc3RtcGVf
YWRjIHsNCj4gKwkJCQljb21wYXRpYmxlID0gInN0LHN0bXBlLWFkYyI7DQo+ICsJCQkJLyogZm9y
YmlkIHRvIHVzZSBBREMgY2hhbm5lbHMgMy0wDQo+ICh0b3VjaCkgKi8NCj4gKwkJCQlzdCxub3Jl
cXVlc3QtbWFzayA9IDwweDBGPjsNCj4gKwkJCX07DQo+ICAJCX07DQo+ICANCj4gIAkJLyoNCj4g
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3RlZ3JhMzAtY29saWJyaS5kdHNpDQo+IGIv
YXJjaC9hcm0vYm9vdC9kdHMvdGVncmEzMC1jb2xpYnJpLmR0c2kNCj4gaW5kZXggMzVhZjAzY2E5
ZTkwLi4xZjkxOThiYjI0ZmYgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL3RlZ3Jh
MzAtY29saWJyaS5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3RlZ3JhMzAtY29saWJy
aS5kdHNpDQo+IEBAIC04NDUsMTEgKzg0NSwxOCBAQA0KPiAgCQkJaWQgPSA8MD47DQo+ICAJCQli
bG9ja3MgPSA8MHg1PjsNCj4gIAkJCWlycS10cmlnZ2VyID0gPDB4MT47DQo+ICsJCQkvKiAzLjI1
IE1IeiBBREMgY2xvY2sgc3BlZWQgKi8NCj4gKwkJCXN0LGFkYy1mcmVxID0gPDE+Ow0KPiArCQkJ
LyogMTItYml0IEFEQyAqLw0KPiArCQkJc3QsbW9kLTEyYiA9IDwxPjsNCj4gKwkJCS8qIGludGVy
bmFsIEFEQyByZWZlcmVuY2UgKi8NCj4gKwkJCXN0LHJlZi1zZWwgPSA8MD47DQo+ICsJCQkvKiBB
REMgY29udmVyc3Rpb24gdGltZTogODAgY2xvY2tzICovDQo+ICsJCQlzdCxzYW1wbGUtdGltZSA9
IDw0PjsNCj4gKwkJCS8qIGZvcmJpZCB0byB1c2UgQURDIGNoYW5uZWxzIDMtMCAodG91Y2gpICov
DQo+ICANCj4gIAkJCXN0bXBlX3RvdWNoc2NyZWVuIHsNCj4gIAkJCQljb21wYXRpYmxlID0gInN0
LHN0bXBlLXRzIjsNCj4gLQkJCQkvKiAzLjI1IE1IeiBBREMgY2xvY2sgc3BlZWQgKi8NCj4gLQkJ
CQlzdCxhZGMtZnJlcSA9IDwxPjsNCj4gIAkJCQkvKiA4IHNhbXBsZSBhdmVyYWdlIGNvbnRyb2wg
Ki8NCj4gIAkJCQlzdCxhdmUtY3RybCA9IDwzPjsNCj4gIAkJCQkvKiA3IGxlbmd0aCBmcmFjdGlv
bmFsIHBhcnQgaW4geiAqLw0KPiBAQCAtODU5LDE3ICs4NjYsMTYgQEANCj4gIAkJCQkgKiBjdXJy
ZW50IGxpbWl0IHZhbHVlDQo+ICAJCQkJICovDQo+ICAJCQkJc3QsaS1kcml2ZSA9IDwxPjsNCj4g
LQkJCQkvKiAxMi1iaXQgQURDICovDQo+IC0JCQkJc3QsbW9kLTEyYiA9IDwxPjsNCj4gLQkJCQkv
KiBpbnRlcm5hbCBBREMgcmVmZXJlbmNlICovDQo+IC0JCQkJc3QscmVmLXNlbCA9IDwwPjsNCj4g
LQkJCQkvKiBBREMgY29udmVyc3Rpb24gdGltZTogODAgY2xvY2tzICovDQo+IC0JCQkJc3Qsc2Ft
cGxlLXRpbWUgPSA8ND47DQo+ICAJCQkJLyogMSBtcyBwYW5lbCBkcml2ZXIgc2V0dGxpbmcgdGlt
ZSAqLw0KPiAgCQkJCXN0LHNldHRsaW5nID0gPDM+Ow0KPiAgCQkJCS8qIDUgbXMgdG91Y2ggZGV0
ZWN0IGludGVycnVwdCBkZWxheSAqLw0KPiAgCQkJCXN0LHRvdWNoLWRldC1kZWxheSA9IDw1PjsN
Cj4gIAkJCX07DQo+ICsNCj4gKwkJCXN0bXBlX2FkYyB7DQo+ICsJCQkJY29tcGF0aWJsZSA9ICJz
dCxzdG1wZS1hZGMiOw0KPiArCQkJCXN0LG5vcmVxdWVzdC1tYXNrID0gPDB4MEY+Ow0KPiArCQkJ
fTsNCj4gIAkJfTsNCj4gIA0KPiAgCQkvKg0K
