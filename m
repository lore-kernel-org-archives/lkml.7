Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA71CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 00:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E4920862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 00:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GcZNB+m2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbfJaAjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 20:39:04 -0400
Received: from mail-eopbgr50043.outbound.protection.outlook.com ([40.107.5.43]:32326
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726713AbfJaAjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 20:39:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAeEcjbZlLNdgvsgaq0SXSfBzOVfFzlA1AsJlI0YtYkvLWo131p7Vsg6Dn6gOM4dX1fUzI53WQOAoQVhxJzE94GbLFzuEGN5fOl6pK0NagNOfw+ldWLfCMaY00mWm8YTUfI8ZGXTJe4n4Gibx/+IQ3KP8QAcFNrnf/+GZwayXkKDG0Wz8rsBeK7k4oCkyMcajGeWwRb3EpZfO/fBxjq57SNV3wxY9DKnfZ3peqMnUngLLnB8Wg9BRtkrA88H2tUGnFJhVJIKj2/YVKNltDuumAunWFLT8GBjJCIVDTxf9ovobZpyHYqN/QMuYE9Wx0xEwrguHRlJa509IX2NW77xPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPh/al13WmMDAcCnTRa2FyjLaEBQYGYYBFBr7I7TlHg=;
 b=DLW45kHBSz/u3PbH2UyOpH2MJjDjYdxpV/enrKH/cWzJvry+gBCRPYnuS6dSve/9lL7zIpAm2okF26SCVghSA5Xfy5XdrGpJOPOIuxoso2BJ0K4He9iwLXcm/6vEkd/oBzKe5ZInO6c5VORofSyEnXb9Lmy13ukPsr1vWKjLnHw+U4RcL73nU1zaw9Y6ygtI6IVGyYo9YnYmMLwwrNOKDm7Zj5WfsGg/+ABmSnbQzBanDnOn5+PGhtfmDV0pUADXo8mirtfPIOQZ39yfM5x9nDNcEW8ePliII8dlPd6hh00tKiNV204Yta9rVxSRqCDYnHs9zbJ3tDOCVUlFv0Dyiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPh/al13WmMDAcCnTRa2FyjLaEBQYGYYBFBr7I7TlHg=;
 b=GcZNB+m2LW9xEVAKF+6BySeMPVNPEWcIJEK65/Gv0vU6wQxQn5zfxr6/Hs6hXsq4TntVGFio8jDb/BQtqwF7+DcDxTHHe71vyGXWSo28+/GHCkyqIwmL9ZL7SAs8txiLdfrL0YYBqjJJ/Tf2B4i3njvBlV35b/6UwCooJJX6ZKg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3948.eurprd04.prod.outlook.com (52.134.70.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Thu, 31 Oct 2019 00:38:56 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d469:ad51:2bec:19f0]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d469:ad51:2bec:19f0%6]) with mapi id 15.20.2387.025; Thu, 31 Oct 2019
 00:38:56 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] ARM: dts: imx7ulp-evk: Use APLL_PFD1 as usdhc's clock
 source
Thread-Topic: [PATCH] ARM: dts: imx7ulp-evk: Use APLL_PFD1 as usdhc's clock
 source
Thread-Index: AQHVjkCC3ogaxYgXmk2GcsFLOZjtv6dxmV+AgAJRHqA=
Date:   Thu, 31 Oct 2019 00:38:55 +0000
Message-ID: <DB3PR0402MB391696BD522A252C9E386F0BF5630@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1572343372-6303-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5CnBCbM2uhDpgUgRVXkVsPTDw27CxZUp3+FMZi+7DH1XQ@mail.gmail.com>
In-Reply-To: <CAOMZO5CnBCbM2uhDpgUgRVXkVsPTDw27CxZUp3+FMZi+7DH1XQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 898f49bc-107f-4396-a3ee-08d75d9ab647
x-ms-traffictypediagnostic: DB3PR0402MB3948:|DB3PR0402MB3948:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB39484F5E5200636B0CA511A9F5630@DB3PR0402MB3948.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 02070414A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(189003)(199004)(9686003)(8676002)(44832011)(4326008)(6246003)(305945005)(99286004)(7696005)(6436002)(74316002)(2906002)(66066001)(81166006)(316002)(8936002)(54906003)(7736002)(76176011)(25786009)(5660300002)(76116006)(66476007)(66446008)(66556008)(6116002)(64756008)(256004)(6916009)(55016002)(229853002)(11346002)(478600001)(476003)(71190400001)(52536014)(3846002)(486006)(33656002)(14454004)(81156014)(446003)(102836004)(71200400001)(186003)(66946007)(26005)(53546011)(6506007)(86362001)(1411001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3948;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KvTlvNpDUuBR4iPkUw2b/SnPblCY8f8Wu5Ja4mNgEpE8iPqTk1YrH37y4OxnqIKffvY4e4Ud5exgOxfF3u+QWMfp5t3pGSPN3NiMEm4D9OmkfeiG5XsD1NHDKSQw3nBF3GLB/GYIHs1t1CrSXw6BoB9tPePPd4ai2cHaTSFaenPE89oLNojJ7fbe57wGCjaChaWtDC1cy9tRKsV05EpqO6L2YByQMQTr7u4MWcVeJk0q/gqgKf8dAfRKHgKkYKS8ZPUl2ZK8jm5f8e6w1rpKrB2pStRACCLp4PEYuEZ43LBJTKq49KB9LH+TdFI8P9tk5GyrnBEHoP6lgUnBn4YdqhBgrqkh7a0pO1i62hr4zijNFclvcKt+lDRpkNKdjEoGBPtIc7BWggkkK4w+cGWgaGnJCjg1T33GzlRASHS8eSVcJmaNQ3V3NCn2sJkZMLdh
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 898f49bc-107f-4396-a3ee-08d75d9ab647
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2019 00:38:55.7861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fs2mqTOZUtokOGL3nd37v3Llgs2jl38IyHoLJ8ruq3jqmjWmdCx2mEpkeI/3/KtLZGVjCPItcVqQOX6KYTUmRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3948
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEZhYmlvDQoNCj4gT24gVHVlLCBPY3QgMjksIDIwMTkgYXQgNzowNiBBTSBBbnNvbiBIdWFu
ZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBpLk1YN1VMUCBkb2Vz
IE5PVCBzdXBwb3J0IHJ1bnRpbWUgc3dpdGNoaW5nIGNsb2NrIHNvdXJjZSBmb3IgUENDLA0KPiA+
IEFQTExfUEZEMSBieSBkZWZhdWx0IGlzIHVzZGhjJ3MgY2xvY2sgc291cmNlLCBzbyBqdXN0IHVz
ZSBpdCBpbiBrZXJuZWwNCj4gPiB0byBhdm9pZCBiZWxvdyBrZXJuZWwgZHVtcCBkdXJpbmcga2Vy
bmVsIGJvb3QgdXAgYW5kIG1ha2Ugc3VyZSBrZXJuZWwNCj4gPiBjYW4gYm9vdCB1cCB3aXRoIFNE
IHJvb3QgZmlsZS1zeXN0ZW0uDQo+ID4NCj4gPiBbICAgIDMuMDM1ODkyXSBMb2FkaW5nIGNvbXBp
bGVkLWluIFguNTA5IGNlcnRpZmljYXRlcw0KPiA+IFsgICAgMy4xMzYzMDFdIHNkaGNpLWVzZGhj
LWlteCA0MDM3MDAwMC5tbWM6IEdvdCBDRCBHUElPDQo+ID4gWyAgICAzLjI0Mjg4Nl0gbW1jMDog
UmVzZXQgMHgxIG5ldmVyIGNvbXBsZXRlZC4NCj4gPiBbICAgIDMuMjQ3MTkwXSBtbWMwOiBzZGhj
aTogPT09PT09PT09PT09IFNESENJIFJFR0lTVEVSIERVTVANCj4gPT09PT09PT09PT0NCj4gPiBb
ICAgIDMuMjUzNzUxXSBtbWMwOiBzZGhjaTogU3lzIGFkZHI6ICAweDAwMDAwMDAwIHwgVmVyc2lv
bjogIDB4MDAwMDAwMDINCj4gPiBbICAgIDMuMjYwMjE4XSBtbWMwOiBzZGhjaTogQmxrIHNpemU6
ICAweDAwMDAwMjAwIHwgQmxrIGNudDogIDB4MDAwMDAwMDENCj4gPiBbICAgIDMuMjY2Nzc1XSBt
bWMwOiBzZGhjaTogQXJndW1lbnQ6ICAweDAwMDA5YTY0IHwgVHJuIG1vZGU6DQo+IDB4MDAwMDAw
MDANCj4gPiBbICAgIDMuMjczMzMzXSBtbWMwOiBzZGhjaTogUHJlc2VudDogICAweDAwMDg4MDg4
IHwgSG9zdCBjdGw6IDB4MDAwMDAwMDINCj4gPiBbICAgIDMuMjc5Nzk0XSBtbWMwOiBzZGhjaTog
UG93ZXI6ICAgICAweDAwMDAwMDAwIHwgQmxrIGdhcDogIDB4MDAwMDAwODANCj4gPiBbICAgIDMu
Mjg2MzUwXSBtbWMwOiBzZGhjaTogV2FrZS11cDogICAweDAwMDAwMDA4IHwgQ2xvY2s6ICAgIDB4
MDAwMDAwN2YNCj4gPiBbICAgIDMuMjkyOTAxXSBtbWMwOiBzZGhjaTogVGltZW91dDogICAweDAw
MDAwMDhjIHwgSW50IHN0YXQ6IDB4MDAwMDAwMDANCj4gPiBbICAgIDMuMjk5MzY0XSBtbWMwOiBz
ZGhjaTogSW50IGVuYWI6ICAweDAwN2YwMTBiIHwgU2lnIGVuYWI6IDB4MDAwMDAwMDANCj4gPiBb
ICAgIDMuMzA1OTE4XSBtbWMwOiBzZGhjaTogQUNtZCBzdGF0OiAweDAwMDAwMDAwIHwgU2xvdCBp
bnQ6IDB4MDAwMDg0MDINCj4gPiBbICAgIDMuMzEyNDcxXSBtbWMwOiBzZGhjaTogQ2FwczogICAg
ICAweDA3ZWIwMDAwIHwgQ2Fwc18xOiAgIDB4MDAwMGI0MDANCj4gPiBbICAgIDMuMzE4OTM0XSBt
bWMwOiBzZGhjaTogQ21kOiAgICAgICAweDAwMDAxMTNhIHwgTWF4IGN1cnI6IDB4MDBmZmZmZmYN
Cj4gPiBbICAgIDMuMzI1NDg4XSBtbWMwOiBzZGhjaTogUmVzcFswXTogICAweDAwMDAwOTAwIHwg
UmVzcFsxXTogIDB4MDAzOWIzN2YNCj4gPiBbICAgIDMuMzMyMDQwXSBtbWMwOiBzZGhjaTogUmVz
cFsyXTogICAweDMyNWI1OTAwIHwgUmVzcFszXTogIDB4MDA0MDBlMDANCj4gPiBbICAgIDMuMzM4
NTAxXSBtbWMwOiBzZGhjaTogSG9zdCBjdGwyOiAweDAwMDAwMDAwDQo+ID4gWyAgICAzLjM0MzA1
MV0gbW1jMDogc2RoY2k6DQo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdA
bnhwLmNvbT4NCj4gDQo+IFRoYW5rcywgd2l0aCB0aGlzIHBhdGNoIGFwcGxpZWQgSSBjYW4gZ2V0
IFNEIGNhcmQgcm9vdGZzIHRvIGdldCBtb3VudGVkOg0KPiANCj4gVGVzdGVkLWJ5OiBGYWJpbyBF
c3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+DQo+IA0KPiBJIHRoaW5rIHRoaXMgZml4IGRlc2Vy
dmVzIGEgRml4ZXMgdGFnIHNvIHRoYXQgaXQgY2FuIGJlIGJhY2twb3J0ZWQgdG8gb2xkZXINCj4g
a2VybmVscy4NCg0KV2lsbCBhZGQgZml4IHRhZyBpbiBWMiwgdGhhbmtzLg0KDQpBbnNvbg0KDQo=
