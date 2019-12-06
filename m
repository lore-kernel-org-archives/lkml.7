Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCC6C2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 03:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B7F721823
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 03:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gfRjPBNG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfLFDBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 22:01:55 -0500
Received: from mail-eopbgr00064.outbound.protection.outlook.com ([40.107.0.64]:9663
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726097AbfLFDBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 22:01:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnmn/yVT18kbwkdw8hqXBsASyPce0ElayZctdO2dQJifRackhj5Mxi958j7XvUovxbU7j/j9C55ks/hOrVqh+j5dZMtXSkKd7OH5Dqm0rJjc2ek36KmOSho0QRrifvRLFaahqk7P6kSXgsfpWN4XTroSY7f2M9Zsg1HPutuTJmXK87Dflg3j/7Tr3sP5zrxAebJ8beV8//kk3GaC9seZqO8B+IVj/acMemL0ryCVdDE0xV3Q+ES1WxxCxeGl2cwMwAVn4mFKJQ1NWtQb0XyThwxoz6Kk60PLdxZdzXmZtX7UWoZBEb8Ml0w2Qm9aPRk7np1oCIQ9yTWU4T9EyWf15Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVRJrmfh44c6GzGsZ91vL9j8SdUVeL5uXlP6QfwtzMs=;
 b=Cs1HRqu5bkarYk9pOLcZlHsNrLu7zAh8WOCJ+z591RMTWVVUzDO13CLDXMxgItiUJqUQo9nEUt9uZS4knIKfmKX6gBDzB2XGG1G9gc4P+G7kNS77wUQjexQQl3NV661CG1S5eq/PgD7yDR0UFlXSW+hDZs5wyVHQyn1n2SJcQfwxLPNOyMAS4EytnBJEyxCMzNwHKOU8YFQS7P9Sh42ez28pEKBkQFHPBYiLGM37cWTEkAbR0+bkYNGFxqrjoA8yDWemdHZdtMKj0sFFWauITtEEm9t27mDEffytMMFnB1JBSROdkOEpsDHXQvtd5JJey6DtYxKVlLZ3G7hECCBo3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVRJrmfh44c6GzGsZ91vL9j8SdUVeL5uXlP6QfwtzMs=;
 b=gfRjPBNGDGUIcujaalFk3Fq2X8xXHoV1UBeLpzS1cH56v0tlWNhcxjlUXlzMrgHMR2JbbSsc/FQpP6Ed98c/GRTr/t79lh85njolRXubLOXlzAB44j83m9+WvHzDgQ4nJYRK8CwOscMuSzhMZ+3tGQjfnjZruHgbiimMRA6Sp+o=
Received: from DB7PR04MB5195.eurprd04.prod.outlook.com (20.176.236.27) by
 DB7PR04MB4507.eurprd04.prod.outlook.com (52.135.139.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Fri, 6 Dec 2019 03:01:44 +0000
Received: from DB7PR04MB5195.eurprd04.prod.outlook.com
 ([fe80::742b:b817:f90f:f444]) by DB7PR04MB5195.eurprd04.prod.outlook.com
 ([fe80::742b:b817:f90f:f444%3]) with mapi id 15.20.2516.014; Fri, 6 Dec 2019
 03:01:44 +0000
From:   Wen He <wen.he_1@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Walle <michael@walle.cc>, Leo Li <leoyang.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [v11 1/2] dt/bindings: clk: Add YAML schemas for
 LS1028A Display Clock bindings
Thread-Topic: [EXT] Re: [v11 1/2] dt/bindings: clk: Add YAML schemas for
 LS1028A Display Clock bindings
Thread-Index: AQHVqz131RIPeWxBDUyVjDElENZugaermZSAgADQtTA=
Date:   Fri, 6 Dec 2019 03:01:44 +0000
Message-ID: <DB7PR04MB519531AFC4C84AE8A5916E95E25F0@DB7PR04MB5195.eurprd04.prod.outlook.com>
References: <20191205072653.34701-1-wen.he_1@nxp.com>
 <20191205142649.GA22738@bogus>
In-Reply-To: <20191205142649.GA22738@bogus>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wen.he_1@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5f4e4ed0-e793-4431-5889-08d779f8a061
x-ms-traffictypediagnostic: DB7PR04MB4507:|DB7PR04MB4507:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB4507837BDC417D487025024BE25F0@DB7PR04MB4507.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0243E5FD68
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(199004)(189003)(13464003)(4326008)(316002)(5660300002)(54906003)(74316002)(305945005)(25786009)(55016002)(33656002)(9686003)(229853002)(76116006)(66556008)(6506007)(26005)(53546011)(2906002)(186003)(71190400001)(71200400001)(478600001)(6916009)(99286004)(11346002)(66476007)(86362001)(52536014)(64756008)(66446008)(66946007)(45080400002)(8936002)(102836004)(8676002)(7696005)(81166006)(81156014)(76176011)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4507;H:DB7PR04MB5195.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TaJmrJNCIdJv/zXyM6gG97Zk+OGlFGRxuVXJLKfRxKYrgRPcp9w+ZxT6W5w2WNBRIpZOlSKh4xjYCQ+mfDNbdfzfG38Xn3BXf9OZoX5m2TN21ViWPmhHJnK0hGYybx517PKtSrA920fKZ9pUnMGFTzUeaGnBU4OTQTF9Ll7w3L7uPnkZDNXhVRAJM1HQgHH7RrYjbFnI5uNKpllb8dnXWo979Yb+lnWeu4HaCf4PLv+zqme4NmbCT/le0rZQeAUHfrq07tNuo9eZpUEnmiV6yQt3DbeKja72caeLo4LJ5MbdtOzMB4n9u1cHZbw3y6csVWXN6oGlUA0hkDgT9xFcVuqA+qorrYVRsPtiArtTxb3/n2/ds3VcgRZxf8svtUyHSiDoZ3J/p8E+ZSSqed/4P05Jrv3IcaEZwXjqQeCAnbb+QIEpkV/mcDigOnP1JvbZDoLw7OCSZk6r7nbigr5jWVwkoMI4R2DKTqKCh8qrx0u0lhOUWx8qI6jhsNPq1V0s
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4e4ed0-e793-4431-5889-08d779f8a061
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2019 03:01:44.4279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mvIzWVXwx1PTABgCsFy091M1TP559u1V5b64Qr2BOLFm8vyf9qUi0dBkkGvbW0ETwnnU8mnp0MF2CNZ6Ap7faQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4507
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iIEhlcnJpbmcgPHJv
YmhAa2VybmVsLm9yZz4NCj4gU2VudDogMjAxOcTqMTLUwjXI1SAyMjoyNw0KPiBUbzogV2VuIEhl
IDx3ZW4uaGVfMUBueHAuY29tPg0KPiBDYzogTWljaGFlbCBUdXJxdWV0dGUgPG10dXJxdWV0dGVA
YmF5bGlicmUuY29tPjsgU3RlcGhlbiBCb3lkDQo+IDxzYm95ZEBrZXJuZWwub3JnPjsgTWFyayBS
dXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT47IE1pY2hhZWwgV2FsbGUNCj4gPG1pY2hhZWxA
d2FsbGUuY2M+OyBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT47DQo+IGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBbdjExIDEvMl0gZHQvYmluZGlu
Z3M6IGNsazogQWRkIFlBTUwgc2NoZW1hcyBmb3IgTFMxMDI4QQ0KPiBEaXNwbGF5IENsb2NrIGJp
bmRpbmdzDQo+IA0KPiBDYXV0aW9uOiBFWFQgRW1haWwNCj4gDQo+IE9uIFRodSwgRGVjIDA1LCAy
MDE5IGF0IDAzOjI2OjUyUE0gKzA4MDAsIFdlbiBIZSB3cm90ZToNCj4gPiBMUzEwMjhBIGhhcyBh
IGNsb2NrIGRvbWFpbiBQWExDTEswIHVzZWQgZm9yIHByb3ZpZGUgcGl4ZWwgY2xvY2tzIHRvDQo+
ID4gRGlzcGxheSBvdXRwdXQgaW50ZXJmYWNlLiBBZGQgYSBZQU1MIHNjaGVtYSBmb3IgdGhpcy4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFdlbiBIZSA8d2VuLmhlXzFAbnhwLmNvbT4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFdhbGxlIDxtaWNoYWVsQHdhbGxlLmNjPg0KPiA+IC0tLQ0K
PiA+IGNoYW5nZSBpbiB2MTE6DQo+ID4gICAgICAgLSByZW5hbWVkICd2Y28tZnJlcXVlbmN5JyB0
byAnZnNsLHZjby1oeicgdG8gY2xlYXJseSBmZWlsZA0KPiA+IGRlZmluaWF0aW9uDQo+ID4NCj4g
PiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svZnNsLHBsbGRpZy55YW1sIHwgNTUNCj4g
PiArKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1NSBpbnNlcnRpb25z
KCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9jbG9jay9mc2wscGxsZGlnLnlhbWwNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svZnNsLHBsbGRpZy55YW1sDQo+
ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svZnNsLHBsbGRpZy55
YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjIz
Y2NlNjViM2E5Mw0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvY2xvY2svZnNsLHBsbGRpZy55YW1sDQo+ID4gQEAgLTAsMCArMSw1
NSBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ID4gKyVZQU1M
IDEuMg0KPiA+ICstLS0NCj4gPiArJGlkOg0KPiA+ICtodHRwczovL2V1cjAxLnNhZmVsaW5rcy5w
cm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRmRldmkNCj4gPg0KPiArY2V0
cmVlLm9yZyUyRnNjaGVtYXMlMkZiaW5kaW5ncyUyRmNsb2NrJTJGZnNsJTJDcGxsZGlnLnlhbWwl
MjMmYW1wOw0KPiBkYQ0KPiA+DQo+ICt0YT0wMiU3QzAxJTdDd2VuLmhlXzElNDBueHAuY29tJTdD
YmMzZTdlYWJjZmVmNGY3NTMxNmUwOGQ3Nzk4Zg0KPiAyYzJlJTdDDQo+ID4NCj4gKzY4NmVhMWQz
YmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzcxMTE1MjgxMzMxNTA3Mg0KPiA0
JmFtcDtzZGENCj4gPg0KPiArdGE9dkZSdldhV2dkeUlXcVFBVkU3TlhuVUtDbkUlMkJVMzhzdkEl
MkJqV3FOYyUyRmI4dyUzRCZhDQo+IG1wO3Jlc2VydmVkPQ0KPiA+ICswDQo+ID4gKyRzY2hlbWE6
DQo+ID4gK2h0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3Vy
bD1odHRwJTNBJTJGJTJGZGV2aQ0KPiA+DQo+ICtjZXRyZWUub3JnJTJGbWV0YS1zY2hlbWFzJTJG
Y29yZS55YW1sJTIzJmFtcDtkYXRhPTAyJTdDMDElN0N3ZW4NCj4gLmhlXzElDQo+ID4NCj4gKzQw
bnhwLmNvbSU3Q2JjM2U3ZWFiY2ZlZjRmNzUzMTZlMDhkNzc5OGYyYzJlJTdDNjg2ZWExZDNiYzJi
NGM2Zg0KPiBhOTJjZDkNCj4gPg0KPiArOWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM3MTExNTI4MTMz
MTUwNzI0JmFtcDtzZGF0YT1kcWolMkZCSyUyDQo+IEY0JTJCQm1maw0KPiA+ICtIa0dqZU5abTNG
WlpsVFlQSk96RUtyb3lIMGpLREElM0QmYW1wO3Jlc2VydmVkPTANCj4gPiArDQo+ID4gK3RpdGxl
OiBOWFAgUW9ySVEgTGF5ZXJzY2FwZSBMUzEwMjhBIERpc3BsYXkgUElYRUwgQ2xvY2sgQmluZGlu
Zw0KPiA+ICsNCj4gPiArbWFpbnRhaW5lcnM6DQo+ID4gKyAgLSBXZW4gSGUgPHdlbi5oZV8xQG54
cC5jb20+DQo+ID4gKw0KPiA+ICtkZXNjcmlwdGlvbjogfA0KPiA+ICsgIE5YUCBMUzEwMjhBIGhh
cyBhIGNsb2NrIGRvbWFpbiBQWExDTEswIHVzZWQgZm9yIHRoZSBEaXNwbGF5IG91dHB1dA0KPiA+
ICsgIGludGVyZmFjZSBpbiB0aGUgZGlzcGxheSBjb3JlLCBhcyBpbXBsZW1lbnRlZCBpbiBUU01D
IENMTjI4SFBNIFBMTC4NCj4gPiArICB3aGljaCBnZW5lcmF0ZSBhbmQgb2ZmZXJzIHBpeGVsIGNs
b2NrcyB0byBEaXNwbGF5Lg0KPiA+ICsNCj4gPiArcHJvcGVydGllczoNCj4gPiArICBjb21wYXRp
YmxlOg0KPiA+ICsgICAgY29uc3Q6IGZzbCxsczEwMjhhLXBsbGRpZw0KPiA+ICsNCj4gPiArICBy
ZWc6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICAnI2Nsb2NrLWNlbGxzJzoN
Cj4gPiArICAgIGNvbnN0OiAwDQo+ID4gKw0KPiA+ICsgIGZzbCx2Y28taHo6DQo+ID4gKyAgICAg
JHJlZjogJy9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMicNCj4gDQo+IERy
b3AgdGhpcyBhcyAnKi1oeicgYWxyZWFkeSBoYXMgYSB0eXBlLg0KPiANCj4gV2l0aCB0aGF0LA0K
PiANCj4gUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQoNClRoYW5r
cyBhIGxvdDsgDQoNCkJlc3QgUmVnYXJkcywNCldlbg0KDQo+IA0KPiA+ICsgICAgIGRlc2NyaXB0
aW9uOiBPcHRpb25hbCBmb3IgVkNPIGZyZXF1ZW5jeSBvZiB0aGUgUExMIGluIEhlcnR6Lg0KPiA+
ICsgICAgICAgIFRoZSBWQ08gZnJlcXVlbmN5IG9mIHRoaXMgUExMIGNhbm5vdCBiZSBjaGFuZ2Vk
IGR1cmluZyBydW50aW1lDQo+ID4gKyAgICAgICAgb25seSBhdCBzdGFydHVwLiBUaGVyZWZvcmUs
IHRoZSBvdXRwdXQgZnJlcXVlbmNpZXMgYXJlIHZlcnkNCj4gPiArICAgICAgICBsaW1pdGVkIGFu
ZCBtaWdodCBub3QgZXZlbiBjbG9zZWx5IG1hdGNoIHRoZSByZXF1ZXN0ZWQNCj4gZnJlcXVlbmN5
Lg0KPiA+ICsgICAgICAgIFRvIHdvcmsgYXJvdW5kIHRoaXMgcmVzdHJpY3Rpb24gdGhlIHVzZXIg
bWF5IHNwZWNpZnkgaXRzIG93bg0KPiA+ICsgICAgICAgIGRlc2lyZWQgVkNPIGZyZXF1ZW5jeSBm
b3IgdGhlIFBMTC4NCj4gPiArICAgICBtaW5pbXVtOiA2NTAwMDAwMDANCj4gPiArICAgICBtYXhp
bXVtOiAxMzAwMDAwMDAwDQo+ID4gKyAgICAgZGVmYXVsdDogMTE4ODAwMDAwMA0KPiA+ICsNCj4g
PiArcmVxdWlyZWQ6DQo+ID4gKyAgLSBjb21wYXRpYmxlDQo+ID4gKyAgLSByZWcNCj4gPiArICAt
IGNsb2Nrcw0KPiA+ICsgIC0gJyNjbG9jay1jZWxscycNCj4gPiArDQo+ID4gK2V4YW1wbGVzOg0K
PiA+ICsgICMgRGlzcGxheSBQSVhFTCBDbG9jayBub2RlOg0KPiA+ICsgIC0gfA0KPiA+ICsgICAg
ZHBjbGs6IGNsb2NrLWRpc3BsYXlAZjFmMDAwMCB7DQo+ID4gKyAgICAgICAgY29tcGF0aWJsZSA9
ICJmc2wsbHMxMDI4YS1wbGxkaWciOw0KPiA+ICsgICAgICAgIHJlZyA9IDwweDAgMHhmMWYwMDAw
IDB4MCAweGZmZmY+Ow0KPiA+ICsgICAgICAgICNjbG9jay1jZWxscyA9IDwwPjsNCj4gPiArICAg
ICAgICBjbG9ja3MgPSA8Jm9zY18yN20+Ow0KPiA+ICsgICAgfTsNCj4gPiArDQo+ID4gKy4uLg0K
PiA+IC0tDQo+ID4gMi4xNy4xDQo+ID4NCg==
