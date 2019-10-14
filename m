Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25132C47404
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 06:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D1C20854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 06:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="b0WQRXgB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbfJNG0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 02:26:22 -0400
Received: from mail-eopbgr140058.outbound.protection.outlook.com ([40.107.14.58]:21631
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726351AbfJNG0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 02:26:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrLhTrHH9bN6a+pHnvDP17UNmpcQrIMrzT+vodmPgOADFzIMSqnMe0Uw52TFd0G3sNJNIiZGSHrk8ksZpvctcyqRbPEx6wilaMKsZWSGLHQMT+PiSM/zFlSmt/SBChPhamFXjujmWcKlw0oVvf9WgrJAHJYcqMr5effN6GfS1VmNFzpg2UB7pPs7O6ObnQnvaYnxMRWNbY3LHrEhimUcsiUn5bpxvjG+NZtRi0mdA8c4xpXe/nutkFSF/MrV45RI2td1BT0jpuisuMSP1HR7MiGZnl310OgYr1YsH4d1gDEJTd9IZKEDPpXpBmAqxDuY1e+onkuaLB4tXCysWKhdvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0KUnkIx78Sz7wZHChnp2rIe7maiJugBbk2P/GV9PV4=;
 b=KhMuKkqo41TksgwTKdaQWKlftjmDu6lAgHPSGWerFSeAJp335RINvf8M6Ib9HCOPg89TLIbv97HMJ2PVwfm+TrbJHzjX17UXoYpOwrc+jTlYglRAxFbV7qPEsNhOGG9h2SjqEbR2N9spn22PkSR3KFCBPL2XKN7kz0YzFSYe2uCPaFYqsTsLUsqlAINfuKb0xEkUgfgY198iZDLi3xqEjD3va3sufev2RUtWjzne5kwcUfiVMymBOI/6y/3uKf70tjXjiV1HL6kruhyKfbn3/AhLe7rEZ7VzpRtUJNQDo+jRqxwSQ6aNaLhOVHIHI8ndHNnI/uc6wkw5WICy14VSzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0KUnkIx78Sz7wZHChnp2rIe7maiJugBbk2P/GV9PV4=;
 b=b0WQRXgBUITZj+4EM5ARrH3vAvdZOrSRTPZxx7j6bCsmK3vHFuxKaVmqrS9ZKfLee84VuPC4m6KeRYlWRsWYlTyYt/3xPH0xLBnHjI81wEzSgHMvqYCMeFRXTOjcOwb6DZdImRwJ3sHPLIuJDaMC9i7ToTl0Lv+/upgQnTuBhxg=
Received: from DB7PR04MB5195.eurprd04.prod.outlook.com (20.176.236.27) by
 DB7PR04MB5449.eurprd04.prod.outlook.com (20.178.107.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Mon, 14 Oct 2019 06:25:36 +0000
Received: from DB7PR04MB5195.eurprd04.prod.outlook.com
 ([fe80::8815:267e:b311:ca91]) by DB7PR04MB5195.eurprd04.prod.outlook.com
 ([fe80::8815:267e:b311:ca91%7]) with mapi id 15.20.2347.021; Mon, 14 Oct 2019
 06:25:36 +0000
From:   Wen He <wen.he_1@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "linux-devel@linux.nxdi.nxp.com" <linux-devel@linux.nxdi.nxp.com>,
        Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [v2 2/2] arm64: dts: ls1028a: Update the DT node
 definition for dpclk
Thread-Topic: [EXT] Re: [v2 2/2] arm64: dts: ls1028a: Update the DT node
 definition for dpclk
Thread-Index: AQHVb4/DBY2rISwX9U+w/S8iZglPI6dPODUAgADjkBCACbRxAIAAANwQ
Date:   Mon, 14 Oct 2019 06:25:36 +0000
Message-ID: <DB7PR04MB51950A4F660184CF63189F9AE2900@DB7PR04MB5195.eurprd04.prod.outlook.com>
References: <20190920083419.5092-1-wen.he_1@nxp.com>
 <20190920083419.5092-2-wen.he_1@nxp.com> <20191007123512.GM7150@dragon>
 <DB7PR04MB5195760127B83B88B68CC602E29A0@DB7PR04MB5195.eurprd04.prod.outlook.com>
 <20191014062150.GC12262@dragon>
In-Reply-To: <20191014062150.GC12262@dragon>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wen.he_1@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb867afb-9d9b-40a8-fa5d-08d7506f5364
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DB7PR04MB5449:|DB7PR04MB5449:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB5449BA4B16616A53229D0A1AE2900@DB7PR04MB5449.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01901B3451
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(199004)(189003)(13464003)(52536014)(256004)(14444005)(25786009)(2906002)(305945005)(54906003)(186003)(6246003)(26005)(102836004)(6436002)(71190400001)(71200400001)(229853002)(9686003)(76176011)(15650500001)(99286004)(7696005)(76116006)(6506007)(53546011)(66946007)(4326008)(66476007)(66556008)(64756008)(66446008)(55016002)(486006)(86362001)(476003)(6916009)(33656002)(14454004)(8936002)(316002)(81156014)(8676002)(5660300002)(81166006)(478600001)(3846002)(74316002)(6116002)(446003)(11346002)(66066001)(7736002)(17423001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5449;H:DB7PR04MB5195.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xc1R14kNi0jztWcRn4gXzJ9uCdkAtncM+rKVaj1lX1sKdf3+yhnWYxJ31ALjOy0Zk8zB5A1VqyDF+YTY/gW9DqiHWt7ahoVbBe2M5GgSvEOn9rgw08QzE5PVvf46bfJFOhRDiIcdWENrpuLA5AzWvvTHtxvGyR0GxN4COaO3Zh4rwS7cezyBMed7JS0vtbz1zDGWhnrRTyBwO+EvZM4JavDUI/jDgXBZ5ayvSx3UBVV6LwoNBLyqyKTYT/aAC9SvUg2K0J67hxIJ1tyKHofVtjfFEJEMufoqvk//t4RTKzaz38RgNEMMAe9w8LrdIwiCAf6PJr2xUcMsnUgFdObyhmemzuyOP/wWbEkmEyku2pyB4FNTNL3DIu7f/CphCqlb2kPaevvLMtWuA2J1FCq5tUwPIxICeYmRCTRhOD9wiiE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb867afb-9d9b-40a8-fa5d-08d7506f5364
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2019 06:25:36.6083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jPi9uJJt5kFNHnZhY0M2ddXjVMkxRZIw8unISQZ3dN5WwjikDJ+7lg5Uy82jyJQWTvPYlxiR1FgdBjA/xBTjFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhd24gR3VvIDxzaGF3
bmd1b0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMDE55bm0MTDmnIgxNOaXpSAxNDoyMg0KPiBUbzog
V2VuIEhlIDx3ZW4uaGVfMUBueHAuY29tPg0KPiBDYzogbGludXgtZGV2ZWxAbGludXgubnhkaS5u
eHAuY29tOyBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT47IFJvYiBIZXJyaW5nDQo+IDxyb2Jo
K2R0QGtlcm5lbC5vcmc+OyBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPjsNCj4g
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBSZTog
W0VYVF0gUmU6IFt2MiAyLzJdIGFybTY0OiBkdHM6IGxzMTAyOGE6IFVwZGF0ZSB0aGUgRFQgbm9k
ZQ0KPiBkZWZpbml0aW9uIGZvciBkcGNsaw0KPiANCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+IA0K
PiBPbiBUdWUsIE9jdCAwOCwgMjAxOSBhdCAwNDowODo1N0FNICswMDAwLCBXZW4gSGUgd3JvdGU6
DQo+ID4NCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206
IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz4NCj4gPiA+IFNlbnQ6IDIwMTnlubQxMOac
iDfml6UgMjA6MzUNCj4gPiA+IFRvOiBXZW4gSGUgPHdlbi5oZV8xQG54cC5jb20+DQo+ID4gPiBD
YzogbGludXgtZGV2ZWxAbGludXgubnhkaS5ueHAuY29tOyBMZW8gTGkgPGxlb3lhbmcubGlAbnhw
LmNvbT47IFJvYg0KPiA+ID4gSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgTWFyayBSdXRs
YW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT47DQo+ID4gPiBkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiA+ID4gU3ViamVjdDogW0VYVF0gUmU6IFt2MiAyLzJd
IGFybTY0OiBkdHM6IGxzMTAyOGE6IFVwZGF0ZSB0aGUgRFQgbm9kZQ0KPiA+ID4gZGVmaW5pdGlv
biBmb3IgZHBjbGsNCj4gPiA+DQo+ID4gPg0KPiA+ID4gT24gRnJpLCBTZXAgMjAsIDIwMTkgYXQg
MDQ6MzQ6MTlQTSArMDgwMCwgV2VuIEhlIHdyb3RlOg0KPiA+ID4gPiBVcGRhdGUgRFQgbm9kZSBu
YW1lIGNsb2NrLWNvbnRyb2xsZXIgdG8gY2xvY2stZGlzcGxheSwNCj4gPiA+DQo+ID4gPiBUaGUg
bm9kZSBuYW1lIGNsb2NrLWNvbnRyb2xsZXIgaXMgc28gZ29vZCwgYW5kIEkgZG8gbm90IHVuZGVy
c3RhbmQNCj4gPiA+IHdoeSB5b3UgbmVlZCB0byBjaGFuZ2UgaXQuDQo+ID4gPg0KPiA+DQo+ID4g
VGhlIG5vZGUgbmFtZSBjbG9jay1jb250cm9sbGVyIHVzZWQgZm9yIHRoZSBzeXN0ZW0gY2xvY2tn
ZW4gYW5kIHRoaXMNCj4gPiBjbG9jayBvbmx5IHVzZWQgZm9yIHRoZSBEaXNwbGF5IGNvcmUuDQo+
ID4gVG8gY2xlYXJseSB0aGUgbm9kZSwgdGhhdCB3aHkgSSBoYXZlIHRvIHVzZSBjbG9jay1kaXNw
bGF5IHRvIGluc3RlYWQNCj4gPiBvZiB0aGUgY2xvY2stY29udHJvbGxlcg0KPiANCj4gTGFiZWwg
aXMgYmVpbmcgdXNlZCB0byBzcGVjaWZ5IHRoaW5ncywgYW5kIG5vZGUgbmFtZSBzaG91bGQganVz
dCBiZSBhcyBnZW5lcmljDQo+IGFzIHBvc3NpYmxlLg0KDQpVbmRlcnN0YW5kLCB3aWxsIGNvcnJl
Y3Rpb24gaXQuDQoNClRoYW5rcyAmJiBCZXN0IFJlZ2FyZHMsDQpXZW4NCg0KPiANCj4gU2hhd24N
Cg==
