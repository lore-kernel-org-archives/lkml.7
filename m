Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC9CC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 02:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B731921852
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 02:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GW/Z4LPb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfHSCO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 22:14:27 -0400
Received: from mail-eopbgr130042.outbound.protection.outlook.com ([40.107.13.42]:51837
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726242AbfHSCO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 22:14:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNwU+9mTNB/texW3KcazbOhu1U4VAobmEiYEgyzDbrCFn8MdFDpXf07t3l4tv+Chf54YNMPqNPn2/KTLO1m84kXTPH0C3kaoMsf4Szom/wgHu0Nc82fgW132gofLEcggdqEjI5FVEKXCqd6E4tt/fyJvNrC/H/Y1k7Rvs1uPiOiM6/VUOOV3MKBO/YIpv5Eb1AxEOTAbW0mg92JcNB+4dlG3SDwD1MXPNvRwuTE1YDF5KlUdSmxNCj/q9A09gV1oVjsleiH8KKP6oqTfXLRyw5zGwGv4HVdhzLDdp/lgKrt4oDwQRSgRcVruUnPUFuSzaWAsrwiJu1TF3UYJZVdoNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ad9b45Vdp96fSrROJSjVamOqe4mZFNhd66lR+tMGzo0=;
 b=PPOUXMH97/tkJn6fYMPu0260sGv744bxoceu9T5g1ZNkKF3cVcuAUZl9EYcmaDQwlEopypqECsG+zew3LqagGClNlSywOaqfxctRB5hzU3q2Lp36yjcOrG/zZLWY9zWO+fdw+X+0v4jtmtUBOj6jV2nUl5B49ppr+lURjKqx02btLNosqTs3HtyrMSmrxwbtEe+NvFz9u2IpEJCGt/WIYvLASRpSvsBwLvWMpotqH+yTz2BI3cZi6m8grgQUx2OkviUFPqHfqbYN1HRy9czWG++ncWL0kMu3+S8F0S6EVKBXTaUS1nBcHdrkcOOgDAYsYFxeRqyQN+twmABgg9WDaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ad9b45Vdp96fSrROJSjVamOqe4mZFNhd66lR+tMGzo0=;
 b=GW/Z4LPbb/nW0c4XYGdgRV5tZb1DJFqDIGoOV6i12O8MyJpcIImoyHLJ+Mwqx+AWIPSjSqp532qgZxYgnPWE06Esj2JOrVf+21su1Jr4iZpRv4RCitiV4CvYbPO1ecaqZigff4kJ5uOLlvamljPPbEagKm2OaBhDVplYUJfnyZk=
Received: from DB7PR04MB5195.eurprd04.prod.outlook.com (20.176.236.27) by
 DB7PR04MB5004.eurprd04.prod.outlook.com (20.176.236.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Mon, 19 Aug 2019 02:14:19 +0000
Received: from DB7PR04MB5195.eurprd04.prod.outlook.com
 ([fe80::e854:ffa9:a285:88a4]) by DB7PR04MB5195.eurprd04.prod.outlook.com
 ([fe80::e854:ffa9:a285:88a4%5]) with mapi id 15.20.2178.018; Mon, 19 Aug 2019
 02:14:19 +0000
From:   Wen He <wen.he_1@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-devel@linux.nxdi.nxp.com" <linux-devel@linux.nxdi.nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Leo Li <leoyang.li@nxp.com>,
        "liviu.dudau@arm.com" <liviu.dudau@arm.com>
Subject: RE: [EXT] Re: [v2 1/3] dt/bindings: clk: Add YAML schemas for LS1028A
 Display Clock bindings
Thread-Topic: [EXT] Re: [v2 1/3] dt/bindings: clk: Add YAML schemas for
 LS1028A Display Clock bindings
Thread-Index: AQHVU1Paq6glt3g2YE+F+EUX+1sTlqb+DqmAgAOyKgA=
Date:   Mon, 19 Aug 2019 02:14:19 +0000
Message-ID: <DB7PR04MB51959AD8499EA16559EA708EE2A80@DB7PR04MB5195.eurprd04.prod.outlook.com>
References: <20190815101613.22872-1-wen.he_1@nxp.com>
 <20190816174724.5CD5B205F4@mail.kernel.org>
In-Reply-To: <20190816174724.5CD5B205F4@mail.kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wen.he_1@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc49bbbf-0215-4ba7-1de1-08d7244af1d3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB7PR04MB5004;
x-ms-traffictypediagnostic: DB7PR04MB5004:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB5004E7476E198392B6331AB9E2A80@DB7PR04MB5004.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(13464003)(199004)(189003)(305945005)(229853002)(71200400001)(2501003)(7736002)(66066001)(71190400001)(2201001)(4744005)(55016002)(8936002)(8676002)(81156014)(81166006)(26005)(86362001)(74316002)(478600001)(33656002)(256004)(6436002)(9686003)(316002)(52536014)(14454004)(66946007)(99286004)(476003)(76116006)(110136005)(64756008)(76176011)(66476007)(54906003)(66446008)(7696005)(5660300002)(446003)(102836004)(186003)(25786009)(11346002)(4326008)(53546011)(2906002)(486006)(53936002)(6116002)(6506007)(6246003)(66556008)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5004;H:DB7PR04MB5195.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EwVDK7LeBuBhcDSpG270pPYGR6pI1uPnBLgM5lLFOXuwKL2HE0YMLdyB/wWeq6G5C0IcOhuGJ/C37hp1MsniUMcikwNHkVmCPHiXeyVFSRpqF9W88iPd5MSKyfMcDle8veIzDM0DedvZNbiO1i2pwteUrx23ADfslvmte72XLJupt3tVluMivKezkdf4w7JfBFip6AsCxajQnKbZbYUogU4t5vzLFp7dEDlzJMkfNgwuNbMZSF0UlrHtyZI9EYdMYzZLfr5hNIprpU9vCsqbZC3RWafEvduyymuMZ7LW3B5CWVRlgxO2bmFDkg+UwWiLGV1inTptx+6o/YTP2Tp66HMjoNabVEdqkDlPbU0vzygPx6ZbFGHa/LFKJCN5K28B1aZy3lJyfJ2EUiFADol+phPIJePV0r8Df4ARXcSDF4o=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc49bbbf-0215-4ba7-1de1-08d7244af1d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 02:14:19.7860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vXWUISxGW//38JYf6xYhfu5UjJU93Abhj/rOCO9wId+RJANqyskC41P9WinvIMGkNdVcZRx3103g0ZPtUfXNYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5004
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlcGhlbiBCb3lkIDxz
Ym95ZEBrZXJuZWwub3JnPg0KPiBTZW50OiAyMDE55bm0OOaciDE35pelIDE6NDcNCj4gVG86IE1h
cmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+OyBNaWNoYWVsIFR1cnF1ZXR0ZQ0KPiA8
bXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb20+OyBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3Jn
PjsgU2hhd24gR3VvDQo+IDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgV2VuIEhlIDx3ZW4uaGVfMUBu
eHAuY29tPjsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWNsa0B2Z2VyLmtl
cm5lbC5vcmc7DQo+IGxpbnV4LWRldmVsQGxpbnV4Lm54ZGkubnhwLmNvbTsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZw0KPiBDYzogTGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+OyBsaXZp
dS5kdWRhdUBhcm0uY29tOyBXZW4gSGUNCj4gPHdlbi5oZV8xQG54cC5jb20+DQo+IFN1YmplY3Q6
IFtFWFRdIFJlOiBbdjIgMS8zXSBkdC9iaW5kaW5nczogY2xrOiBBZGQgWUFNTCBzY2hlbWFzIGZv
ciBMUzEwMjhBDQo+IERpc3BsYXkgQ2xvY2sgYmluZGluZ3MNCj4gDQo+IENhdXRpb246IEVYVCBF
bWFpbA0KPiANCj4gUXVvdGluZyBXZW4gSGUgKDIwMTktMDgtMTUgMDM6MTY6MTEpDQo+ID4gTFMx
MDI4QSBoYXMgYSBjbG9jayBkb21haW4gUFhMQ0xLMCB1c2VkIGZvciBwcm92aWRlIHBpeGVsIGNs
b2NrcyB0bw0KPiA+IERpc3BsYXkgb3V0cHV0IGludGVyZmFjZS4gQWRkIGEgWUFNTCBzY2hlbWEg
Zm9yIHRoaXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBXZW4gSGUgPHdlbi5oZV8xQG54cC5j
b20+DQo+ID4gLS0tDQo+IA0KPiBQYXRjaCBsb29rcyBnb29kLiBQbGVhc2Ugc2VuZCBtdWx0aS1w
YXRjaCBzZXJpZXMgd2l0aCBhIGNvdmVyIGxldHRlciBuZXh0IHRpbWUNCj4gd2hlbiB5b3UgcmVz
ZW5kIGFuZCBwaWNrIHVwIFJvYidzIHJldmlldy4NCg0KVW5kZXJzdGFuZCwgVGhhbmsgeW91IGZv
ciB0aGUgcmV2aWV3Lg0KDQpCZXN0IFJlZ2FyZHMsDQpXZW4NCg0KPiANCj4gPiBjaGFuZ2UgaW4g
djI6DQo+ID4gICAgICAgICAtIENvbnZlcnQgYmluZGluZ3MgdG8gWUFNTCBmb3JtYXQNCj4gPg0K
