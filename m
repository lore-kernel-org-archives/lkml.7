Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCDEC432C3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 02:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 276D12073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 02:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MxQM141x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfLDCwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 21:52:16 -0500
Received: from mail-eopbgr30057.outbound.protection.outlook.com ([40.107.3.57]:39748
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726363AbfLDCwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 21:52:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuYWeFMTXxYL9xdXgm7pwoKOUZgI0I6eLrs/0+qGE84/QinbnTxfxecWpb1P/vmUppBqwwJxw8Pzw45U+B6Nq0Hz0Ktbk+yHC3SMQ/aeo8k5JucD3AOkWtRnxCU1QzlHhkkZfkwE9MVT9nXDEc1h6J/KQikIC32jF0IWhxwyYB1Y+saDcmquPwaKcZXKo7zDcFneSYN3qwGc/cYVxUQrgz7dttyRqLHyRbtt9vs4eFiVhYAyKBWguK937gcJyTFIpuoEeBGbJUViqeqgtAh8MPq9TPW3uMLSlHtNyH7SIkEKz735k/0NUuA3bkw+ZDLtHoE0HL0Ez3duMBfmoAfifw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FimZrBJugofFf5K5rxmRFpLjqQZ9nFzMAljErApUkFs=;
 b=Hnw52gqZQ9RRyzvBsyT5wPBZHqkKXK8PaJ0F+MIG3yRfPG+eH44azx/7HRqZmiT8/YLb6W3Q0ehOTnDCOWVV5GreCEINQgRu7zCdojdT6NSKuy/WXKRp0TO//i8YNH6fvTRei+h5J37EpVlxkSjNlU8E2ueS0ulca48i3ufDCmgvUZ0pPDvVgDVvotxbgb5yPbK5x59jcjZMjn2rghq/rjgvTJiDATRAOcjdeFRsk/5iBBv1QMg1Zk9FzmM0kGQpO2HxHTm4ao0wXA1llQzvudcUy2A794SrZ7ObvI2XYXB/tuob548vAqEAAoWq4Wimk833YjS4adxsCQpWusr4Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FimZrBJugofFf5K5rxmRFpLjqQZ9nFzMAljErApUkFs=;
 b=MxQM141xE5pPUEAjKKxq4is1lZCCKrjkl4o82vKItEUdsO2EOIbxPr19fGgFA4VabWUKn9bZWp5psVEK5/fQukle/0PBgwXt+0ehJVC7NYWHJaIOlCfXWITbyR3zAlSi8PHqf0ne/+trBIGi0d/Z2Z7n2Mnm7szbTjXO69gQBm8=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3847.eurprd04.prod.outlook.com (52.133.29.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Wed, 4 Dec 2019 02:52:11 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::1dd5:831a:28cc:d5f3]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::1dd5:831a:28cc:d5f3%6]) with mapi id 15.20.2516.003; Wed, 4 Dec 2019
 02:52:11 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 3/3] ARM: dts: imx6sll: Add Rev A board support
Thread-Topic: [PATCH 3/3] ARM: dts: imx6sll: Add Rev A board support
Thread-Index: AQHVlIduoosfFYvtfEafWXvtkEL5lqepbwGAgAAA5iA=
Date:   Wed, 4 Dec 2019 02:52:11 +0000
Message-ID: <AM6PR0402MB39111817A837FD03558B0E79F55D0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
References: <1573033650-11848-1-git-send-email-Anson.Huang@nxp.com>
 <1573033650-11848-3-git-send-email-Anson.Huang@nxp.com>
 <20191204023920.GO9767@dragon>
In-Reply-To: <20191204023920.GO9767@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b18ad85e-c2a2-4175-e1a5-08d77864f5ef
x-ms-traffictypediagnostic: AM6PR0402MB3847:|AM6PR0402MB3847:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0402MB384719F2CB6260410AF5B594F55D0@AM6PR0402MB3847.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(189003)(199004)(52536014)(64756008)(66556008)(256004)(99286004)(71190400001)(66476007)(7736002)(86362001)(66446008)(6506007)(7696005)(446003)(66946007)(316002)(186003)(8936002)(81166006)(81156014)(102836004)(11346002)(26005)(76176011)(76116006)(8676002)(71200400001)(44832011)(478600001)(74316002)(6916009)(4326008)(9686003)(55016002)(305945005)(54906003)(6436002)(25786009)(6116002)(2906002)(229853002)(6246003)(14454004)(33656002)(3846002)(5660300002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3847;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pu7L3Ac8g099qmV4fZ5Ml3MCjY92TWi6AOnVgDPyyqxFOxb3dvgDtOZUVhVaPHvttz4EK8Tuq7VHF1O6MKCpdsz8xe77wGQgC31LvDx8dCmICnqWpXW37NcmShHhnj+uNER9nSkEUc7XT5QpA8772QYZdsXlmc42yIw1qBjdHHAZWMfDwnJFUdRWtnAyaX1nrXvVec+upxE5WTYw8rf1j4RGrDRmNMaqbGt/bYgq7cbCeSqMIgRNyCgPWveALWZp0uZgleYSEJbzW+JstvFNd+HMyYKMYYnhecp/r0lKffIKyGh9C2mTkI5OhqipLLsrMw089Jz5PpoWvpDLrOKLGOrf6s+BVTMa6Toxj9ar8t9BGhyMtPyHYHi0PC2svimc4QrN9IqwG90rx34zAF+SRCAnR6SZLGGEUfmfBv0s9IBaVK3XXeSASOze6vgONPgT3X8OvnGDC4zZ+wyS5n0iJ02CVmG06zArD/tomfi1nwVkMnD1greFl+S6Ct7bmod4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b18ad85e-c2a2-4175-e1a5-08d77864f5ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 02:52:11.3926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jGTT0nzUu4yvSHOvq+PeIkry9DepUVAfIzEr+VKwzR0lOfPZzuGMTh0NlZV4TVLIsESM6JrFTBUBdm3vD5YlQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3847
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAzLzNdIEFSTTogZHRzOiBpbXg2c2xsOiBBZGQgUmV2
IEEgYm9hcmQgc3VwcG9ydA0KPiANCj4gT24gV2VkLCBOb3YgMDYsIDIwMTkgYXQgMDU6NDc6MzBQ
TSArMDgwMCwgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gaS5NWDZTTEwgRVZLIFJldiBBIGJvYXJk
IGlzIHNhbWUgd2l0aCBsYXRlc3QgaS5NWDZTTEwgRVZLIGJvYXJkIGV4Y2VwdA0KPiA+IGVNTUMg
Y2FuIE9OTFkgcnVuIGF0IEhTMjAwIG1vZGUsIGFkZCBzdXBwb3J0IGZvciB0aGlzIGJvYXJkLg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+
DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtL2Jvb3QvZHRzL01ha2VmaWxlICAgICAgICAgICAgIHwg
IDEgKw0KPiA+ICBhcmNoL2FybS9ib290L2R0cy9pbXg2c2xsLWV2ay1yZXZhLmR0cyB8IDEyICsr
KysrKysrKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykNCj4gPiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZzbGwtZXZrLXJldmEuZHRz
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUgYi9hcmNo
L2FybS9ib290L2R0cy9NYWtlZmlsZQ0KPiA+IGluZGV4IDcxZjA4ZTcuLjM4NDViYmYgMTAwNjQ0
DQo+ID4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUNCj4gPiArKysgYi9hcmNoL2Fy
bS9ib290L2R0cy9NYWtlZmlsZQ0KPiA+IEBAIC01NTcsNiArNTU3LDcgQEAgZHRiLSQoQ09ORklH
X1NPQ19JTVg2U0wpICs9IFwNCj4gPiAgCWlteDZzbC13YXJwLmR0Yg0KPiA+ICBkdGItJChDT05G
SUdfU09DX0lNWDZTTEwpICs9IFwNCj4gPiAgCWlteDZzbGwtZXZrLmR0YiBcDQo+ID4gKwlpbXg2
c2xsLWV2ay1yZXZhLmR0YiBcDQo+ID4gIAlpbXg2c2xsLWtvYm8tY2xhcmFoZC5kdGINCj4gPiAg
ZHRiLSQoQ09ORklHX1NPQ19JTVg2U1gpICs9IFwNCj4gPiAgCWlteDZzeC1uaXRyb2dlbjZzeC5k
dGIgXA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9pbXg2c2xsLWV2ay1yZXZh
LmR0cw0KPiA+IGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnNsbC1ldmstcmV2YS5kdHMNCj4gPiBu
ZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAuLjdjYTI1NjMNCj4gPiAtLS0g
L2Rldi9udWxsDQo+ID4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnNsbC1ldmstcmV2YS5k
dHMNCj4gPiBAQCAtMCwwICsxLDEyIEBADQo+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiAoR1BMLTIuMCBPUiBNSVQpDQo+ID4gKy8qDQo+ID4gKyAqIENvcHlyaWdodCAyMDE2IEZyZWVz
Y2FsZSBTZW1pY29uZHVjdG9yLCBJbmMuDQo+ID4gKyAqIENvcHlyaWdodCAyMDE3LTIwMTkgTlhQ
Lg0KPiA+ICsgKg0KPiA+ICsgKi8NCj4gPiArDQo+ID4gKyNpbmNsdWRlICJpbXg2c2xsLWV2ay5k
dHMiDQo+ID4gKw0KPiA+ICsmdXNkaGMyIHsNCj4gPiArCWNvbXBhdGlibGUgPSAiZnNsLGlteDZz
bGwtdXNkaGMiLCAiZnNsLGlteDZzeC11c2RoYyI7DQo+IA0KPiBJdCBsb29rcyBvZGQgdG8gbWUg
dGhhdCB3ZSBuZWVkIHRvIGRlYWwgd2l0aCBhIGJvYXJkIGxldmVsIGRpZmZlcmVuY2Ugd2l0aCBh
DQo+IFNvQyBsZXZlbCBjb21wYXRpYmxlLiAgVGhlIFVTREhDIGNvbXBhdGlibGUgc2hvdWxkIGJl
IHNvbGVseSBkZXRlcm1pbmVkIGJ5DQo+IHRoZSBJUCBwcm9ncmFtbWluZyBtb2RlbCwgbm90IHRo
ZSBib2FyZCBsZXZlbCBjYXBhYmlsaXR5Lg0KDQpTbyBob3cgdG8gaGFuZGxlIHN1Y2ggc2NlbmFy
aW8/IEN1cnJlbnQgdXNkaGMgZHJpdmVyIHVzZXMgU29DIGNvbXBhdGlibGUgdG8gZGlzdGluZ3Vp
c2gNCmRpZmZlcmVudCBmdW5jdGlvbnMgb2YgdVNESEMgSVAsIGlmIHNvbWUgYm9hcmRzIGNhbiBO
T1Qgc3VwcG9ydCBkZWRpY2F0ZWQgZnVuY3Rpb24gZHVlIHRvDQpib2FyZCBkZXNpZ24gcmVnYXJk
bGVzcyBvZiB0aGUgSVAgaW5zaWRlLCB0aGUgZWFzeSB3YXkgaXMganVzdCB0byBkb3duZ3JhZGUg
dGhlIFNvQyBjb21wYXRpYmxlLA0Kb3IgbmVlZCB1U0RIQyBkcml2ZXIgdG8gcHJvdmlkZSBzb21l
IERUIHByb3BlcnRpZXMgZm9yIHN1Y2ggY2FzZT8gDQoNClRoYW5rcywNCkFuc29uIA0K
