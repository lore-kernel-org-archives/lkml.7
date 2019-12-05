Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B037EC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775B62464F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=silabs.onmicrosoft.com header.i=@silabs.onmicrosoft.com header.b="nCdk8LZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbfLEOIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 09:08:30 -0500
Received: from mail-co1nam11on2043.outbound.protection.outlook.com ([40.107.220.43]:49023
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729558AbfLEOI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 09:08:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4apinyY7eC7CrwneHh/V6UcH4SaL++iGqqxNhN4Oh/r2II2YzFSlMWivF3yVR2mZphVtkGElsQ+3Uz6DTjHnSGs/bdPICf2/KI7jljcIkhNSymk8qKDVFydkyr5HifFW9fGbXlclqAkLGS0j/eukmY9kgwZTeHqYkQcMGsRyvSySCAb/SP1DKt/Cy5fvL9eMJZQ/PtzcRR/UlWvMuhtGD0OMkclgU7H2wWO1NVFDwZHcBPKvSXRkkW083kls8MmLWSq6YNo4JJwr/x1FGxw2DFWI9vgjmckcFAQ+RRPy1Yf0Yz7BAb5Jcx+8EIYVtUTROnR1ObxiK+JCF8kOWsQJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jJKE5PjoAhDR2ip/UMEDMHOrm4xmX0aTdTcgHzJV98=;
 b=KlmlTxuLJ9CnvQtOAwv/MAGltsD+Dn8i2QVvusAyXDlpeP8jZLB5H6bdJtUC0ceG8oRaoNpeIquLcQHOsGbgR66tqePge37dCDX0TAUzrdk0PsgAEFNWoFKbCceGhiULIkiyRw1ham9oSBDzV4f3rzkBXmMhl330LVBmsCs6KIS26Plt70IHR87SHbg+S/HaCP5WXtIdxbejsUHzz/7QVRWp17Tyh7psVPsouF9LbPMclGNsnABGnAuoMqfp8RWzv3Tygn6vkeV2AToWinylVVKT6SSLMiLc7HIIKd2A0OLitM42uksc+JZt9n5NW/GBCBRZKGrg8iciMkj5KJfbGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jJKE5PjoAhDR2ip/UMEDMHOrm4xmX0aTdTcgHzJV98=;
 b=nCdk8LZqAUU4YiL32zKp6YjtzMdVnLXe/tVrI/WizVByLP90nDk8m0nr16hfrNYYGELWDd8jbIA/3AiZxUhCijGFf4Bqoty/7Pb/EX1Cn4oV9eLOrWcZ4XgrGqAnoSjlLgWDAEc3hks2uxXUXxZLybunuttLiPKN2zmDeVY/GXY=
Received: from MN2PR11MB4063.namprd11.prod.outlook.com (10.255.180.22) by
 MN2PR11MB3774.namprd11.prod.outlook.com (20.178.254.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Thu, 5 Dec 2019 14:08:24 +0000
Received: from MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::f46c:e5b4:2a85:f0bf]) by MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::f46c:e5b4:2a85:f0bf%4]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 14:08:23 +0000
From:   =?utf-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <Jerome.Pouiller@silabs.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: wfx: fix reset GPIO polarity
Thread-Topic: [PATCH] staging: wfx: fix reset GPIO polarity
Thread-Index: AQHVqsQ7GK4GtaETQkCLDhcnUtoexqerlV8A
Date:   Thu, 5 Dec 2019 14:08:23 +0000
Message-ID: <3343657.nOMI9WY9u8@pc-42>
References: <f9ebb05f4a13cce4a8724dfb17f8383ec9b2d468.1575478705.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <f9ebb05f4a13cce4a8724dfb17f8383ec9b2d468.1575478705.git.mirq-linux@rere.qmqm.pl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jerome.Pouiller@silabs.com; 
x-originating-ip: [37.71.187.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1245bcae-6d62-400b-d94d-08d7798c9771
x-ms-traffictypediagnostic: MN2PR11MB3774:
x-microsoft-antispam-prvs: <MN2PR11MB37749493FD813BE6AFB6E883935C0@MN2PR11MB3774.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(136003)(39860400002)(366004)(346002)(376002)(189003)(199004)(305945005)(76176011)(71190400001)(71200400001)(316002)(54906003)(76116006)(66446008)(64756008)(66946007)(66476007)(11346002)(66556008)(6916009)(25786009)(102836004)(99286004)(5660300002)(186003)(26005)(6506007)(8676002)(9686003)(86362001)(6512007)(85202003)(33716001)(81166006)(91956017)(81156014)(8936002)(85182001)(4326008)(478600001)(229853002)(2906002)(6486002)(14454004)(39026012);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3774;H:MN2PR11MB4063.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: silabs.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Vp46BwFe3QlqeJXLh6dh95bL0zna+Tt+bNGfa7WUnpmBfrXKs4SCwSHLJWe4FgibFhBVwEdkr4BQWhFInFsK0Xu2KrAVyciZuZT4FU8VRneq9PIDuHecl+6LwQAh9xzlqweVTNB+E7mRn3GC3pdePUIpcP4EZPB9q/5f+mgh3dr37TX+xOwIgBtrAs0tiG9PB6mCgMM847eXGvV1MD03jSDHdPSRZiuZsymtrpUr+Nys7/2Rqk+0UfgNB7iCaMFy6M9wcWh1sCLdPEEbmp3XGOqh1twXTJ29ba+9iyEOj6VwORybThLeu0P/WWcz0sgm9frUl/cIM7UUmXD90kHAM+r/n0pnzjgqpRtP44LMnNTcLtryzvt4xwnsNcsE2IVUYGESNls2jXES4J2PZvOc8b3N0sSxajFGIRUuCeBxkRGYJhX2iJtvcJiGfXSafBvhTdEDlU23XlMwW7VM/Jqe5LccHRNBjbX9Qdc0uptBwOg+ke/A4ZpYpKQSF1OCXLC
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2B376F7008D1E4D824AA27AEC5A99E5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1245bcae-6d62-400b-d94d-08d7798c9771
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 14:08:23.8248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wy43rc+IlAdU0YmmTxENPsTbUWAWo0Or3fD8svt+IlFMD2BAmegwq1v55ympP/m7k3VMk6q5XyCE0+ncNCBNvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3774
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkbmVzZGF5IDQgRGVjZW1iZXIgMjAxOSAxNzo1OTo0NiBDRVQgTWljaGHFgiBNaXJvc8WC
YXcgd3JvdGU6DQo+IERyaXZlciBpbnZlcnRzIG1lYW5pbmcgb2YgR1BJT19BQ1RJVkVfTE9XL0hJ
R0guIEZpeCBpdCB0byBwcmV2ZW50DQo+IGNvbmZ1c2lvbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IE1pY2hhxYIgTWlyb3PFgmF3IDxtaXJxLWxpbnV4QHJlcmUucW1xbS5wbD4NCj4gLS0tDQo+ICBk
cml2ZXJzL3N0YWdpbmcvd2Z4L2J1c19zcGkuYyB8IDQgKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3N0YWdpbmcvd2Z4L2J1c19zcGkuYyBiL2RyaXZlcnMvc3RhZ2luZy93ZngvYnVzX3NwaS5j
DQo+IGluZGV4IGFiMGNkYTFlMTI0Zi4uNzNkMDE1N2E4NmJhIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL3N0YWdpbmcvd2Z4L2J1c19zcGkuYw0KPiArKysgYi9kcml2ZXJzL3N0YWdpbmcvd2Z4L2J1
c19zcGkuYw0KPiBAQCAtMTk5LDkgKzE5OSw5IEBAIHN0YXRpYyBpbnQgd2Z4X3NwaV9wcm9iZShz
dHJ1Y3Qgc3BpX2RldmljZSAqZnVuYykNCj4gICAgICAgICBpZiAoIWJ1cy0+Z3Bpb19yZXNldCkg
ew0KPiAgICAgICAgICAgICAgICAgZGV2X3dhcm4oJmZ1bmMtPmRldiwgInRyeSB0byBsb2FkIGZp
cm13YXJlIGFueXdheVxuIik7DQo+ICAgICAgICAgfSBlbHNlIHsNCj4gLSAgICAgICAgICAgICAg
IGdwaW9kX3NldF92YWx1ZShidXMtPmdwaW9fcmVzZXQsIDApOw0KPiAtICAgICAgICAgICAgICAg
dWRlbGF5KDEwMCk7DQo+ICAgICAgICAgICAgICAgICBncGlvZF9zZXRfdmFsdWUoYnVzLT5ncGlv
X3Jlc2V0LCAxKTsNCj4gKyAgICAgICAgICAgICAgIHVkZWxheSgxMDApOw0KPiArICAgICAgICAg
ICAgICAgZ3Bpb2Rfc2V0X3ZhbHVlKGJ1cy0+Z3Bpb19yZXNldCwgMCk7DQo+ICAgICAgICAgICAg
ICAgICB1ZGVsYXkoMjAwMCk7DQo+ICAgICAgICAgfQ0KSGVsbG8gTWljaGHFgiwNCg0KSSBkaWQg
bm90IGZpbmQgcmVhbCBjb25zZW5zdXMgaW4ga2VybmVsIGNvZGUuIE15IHBlcnNvbmFsIHRhc3Rl
IHdvdWxkDQpiZSB0byBrZWVwIHRoaXMgZ3BpbyAiQUNUSVZFX0hJR0giIGFuZCByZW5hbWUgaXQg
Z3Bpb19ucmVzZXQuIFdoYXQgZG8NCnlvdSB0aGluayBhYm91dCBpdD8NCg0KKGluIGFkZCwgdGhp
cyBzb2x1dGlvbiB3b3VsZCBleHBsaWNpdGx5IGNoYW5nZSB0aGUgbmFtZSBvZiB0aGUgRFQNCmF0
dHJpYnV0ZSBpbnN0ZWFkIG9mIGNoYW5naW5nIHRoZSBzZW1hbnRpYyBvZiB0aGUgZXhpc3Rpbmcg
YXR0cmlidXRlKQ0KDQotLSANCkrDqXLDtG1lIFBvdWlsbGVyDQoNCg==
