Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6D6C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 09:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D66E52184D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 09:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Fxh1F/9o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfHSJVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 05:21:21 -0400
Received: from mail-eopbgr750049.outbound.protection.outlook.com ([40.107.75.49]:31412
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725790AbfHSJVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 05:21:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVZ0UdH4bNYgadc6hyAZCDnJZyJvxSqiciZXADyUrrs/nN/XtHyTLQ48uKuZakytyeuvEu/xQ89262oodvnhYKAu8wljVvqTIZlR+Rz/Kcn7FuHuKmI23GoKNINTypY9bD0kA7EQ5Lg73CjIP2PUhz/R6MrmUF/EDerqXhkq5dQbiiFuMGz6psYvhrCCOGlM2U1cdMa34WUkE3Z+TCvY5MUku1mNSfIWZ+7akdrlbt7eZO7Zkx9pOqd6CM8VCYtTP0i2+jDiGijooSiUwwmwCCzisG6XJ/rwDlnY0U0W7A9XokvwdwRCaSOICpYt8WHT2kmGc+82GLdlNgWCBBgA+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8UgBCauNgoyP9AgEAhPPV6B7Eku2U7GBDTtMeBKpcc=;
 b=QEtAwI3Rle2zas6Pqj1qujKrMb/EwiDwQ0NPjbDLsi6yo+/Ja03bvFsIq/P5BRX0+Ot4h6G1RxZ3Ew7WDANM9lJ2Z+CamXbDyx1HhoftqbNtYwUvbOn9cDMRkjeDsBZPK/hFCHC+3r/gbPBV7FLqQCmLsqFw1uaYqPDnbmkgGZ50XIIz2ah0aUB/rVPw/eUeoIu7aOgEmuq5qpqIqodQHshtmVv6vXVAtTKCNXh1l9tgSp4MUJPQjAr84w+mkOvPnLAjIsnUFTFoYcbSWO3f1SDsY2c+3OE6fkL8awNRCUT3S315nWOeJ4Q+OuCSeyFUD+SwXZDZnQq6jqlqLVcYBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8UgBCauNgoyP9AgEAhPPV6B7Eku2U7GBDTtMeBKpcc=;
 b=Fxh1F/9or7PuDt3MsWHELnJlcIa37VcFF4wJf9rKAhOm3BdtdTgYEodSijJBi+jFPAEN1/alhe5jmBsyMN7HRE1GyFnXmTEbc8iFRiEnzWjq0LaxTwfgRaUFv5ncrJWxVo+OnHNIckPtGlGoFxugO7F/5IAXOTH9cUvDia4lYyk=
Received: from MN2PR02MB6029.namprd02.prod.outlook.com (10.255.7.10) by
 MN2PR02MB7005.namprd02.prod.outlook.com (20.180.26.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Mon, 19 Aug 2019 09:21:13 +0000
Received: from MN2PR02MB6029.namprd02.prod.outlook.com
 ([fe80::6930:d45:6895:4255]) by MN2PR02MB6029.namprd02.prod.outlook.com
 ([fe80::6930:d45:6895:4255%4]) with mapi id 15.20.2178.018; Mon, 19 Aug 2019
 09:21:12 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Michal Simek <michals@xilinx.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "christoph.muellner@theobroma-systems.com" 
        <christoph.muellner@theobroma-systems.com>,
        "philipp.tomsich@theobroma-systems.com" 
        <philipp.tomsich@theobroma-systems.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "scott.branden@broadcom.com" <scott.branden@broadcom.com>,
        "ayaka@soulik.info" <ayaka@soulik.info>,
        "kernel@esmil.dk" <kernel@esmil.dk>,
        "tony.xie@rock-chips.com" <tony.xie@rock-chips.com>,
        Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>,
        Nava kishore Manne <navam@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
Subject: RE: [PATCH v2 01/11] dt-bindings: mmc: arasan: Update documentation
 for SD Card Clock
Thread-Topic: [PATCH v2 01/11] dt-bindings: mmc: arasan: Update documentation
 for SD Card Clock
Thread-Index: AQHVL84QKtDrcydqmkObCTy1mFTFVabXUFgAgAB7vdCAA6ZJgIAnAKOw
Date:   Mon, 19 Aug 2019 09:21:12 +0000
Message-ID: <MN2PR02MB60299EB8B83C4EA68A0F2B33C1A80@MN2PR02MB6029.namprd02.prod.outlook.com>
References: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
 <1561958991-21935-2-git-send-email-manish.narani@xilinx.com>
 <20190722215404.GA28292@bogus>
 <MN2PR02MB602907616249FF19C1A737D8C1C70@MN2PR02MB6029.namprd02.prod.outlook.com>
 <CAPDyKFostBKYipTkCsDbggsrux7w8BPqARx7fwRsL1XqEEX2NQ@mail.gmail.com>
In-Reply-To: <CAPDyKFostBKYipTkCsDbggsrux7w8BPqARx7fwRsL1XqEEX2NQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0bda46b1-bb8a-40cc-a9ea-08d724869460
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MN2PR02MB7005;
x-ms-traffictypediagnostic: MN2PR02MB7005:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB7005D4E4074702451130B173C1A80@MN2PR02MB7005.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(13464003)(189003)(199004)(6116002)(478600001)(7696005)(3846002)(76176011)(4326008)(66446008)(33656002)(66946007)(256004)(186003)(14454004)(14444005)(76116006)(64756008)(66556008)(26005)(25786009)(53546011)(54906003)(6506007)(86362001)(446003)(11346002)(71200400001)(71190400001)(66476007)(316002)(476003)(99286004)(102836004)(486006)(52536014)(305945005)(74316002)(6916009)(15650500001)(7736002)(8936002)(8676002)(81166006)(81156014)(7416002)(229853002)(53936002)(6436002)(9686003)(66066001)(6306002)(6246003)(2906002)(5660300002)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB7005;H:MN2PR02MB6029.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XNF/OHUuS6/Pnik883NIB9x3OfKeXDyL4OIMidZ/a7yRTX0s1GbdSulJ0XwECdKDAWgWLDotSVaEQlPmBtfh/5wkW24o41JnyIptie1u7HLUuGPBsaucxv7JVy8HKNpCAyQlSC6iaPQZ0vOrEQy9NMyjTL3oKtw+mAr7DbH0Re8cZFYENDV4qCaEtIGowrx8JNC164usR5uG2pwN3Y1fjWrBZ8REvtvk15ML6Ss6ZAEtu9zAAPn4lpHO+yc7jgjhB9qE/zcbat0SFL957l+YfYDIxhXwFwmbcthmhorstii/jwjdxNHO9JtKzBVevUw4HZRyUYTGonBxJaOVmjC9HBGcnzvN2u1TTBmP/1QiLf28+s9YY+j92ePzJQatHRK3QOWCGbWbR7/cw0pQy31k4FQyfwTvt/YpYTkm9YpTSic=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bda46b1-bb8a-40cc-a9ea-08d724869460
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 09:21:12.8885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0xLgSs68oTX45JdQEtG7Cb8W0V8J4uMMiOXocPTfvhlIwORiIZnEw6Ow8RmBrFtj3ToXz4EaXEtw5Tm0m7wFJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVWZmZSwNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFVsZiBI
YW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgSnVseSAy
NSwgMjAxOSA2OjMxIFBNDQo+IFRvOiBNYW5pc2ggTmFyYW5pIDxNTkFSQU5JQHhpbGlueC5jb20+
DQo+IENjOiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsgbWFyay5ydXRsYW5kQGFybS5j
b207DQo+IGhlaWtvQHNudGVjaC5kZTsgTWljaGFsIFNpbWVrIDxtaWNoYWxzQHhpbGlueC5jb20+
Ow0KPiBhZHJpYW4uaHVudGVyQGludGVsLmNvbTsgY2hyaXN0b3BoLm11ZWxsbmVyQHRoZW9icm9t
YS1zeXN0ZW1zLmNvbTsNCj4gcGhpbGlwcC50b21zaWNoQHRoZW9icm9tYS1zeXN0ZW1zLmNvbTsg
dmlyZXNoLmt1bWFyQGxpbmFyby5vcmc7DQo+IHNjb3R0LmJyYW5kZW5AYnJvYWRjb20uY29tOyBh
eWFrYUBzb3VsaWsuaW5mbzsga2VybmVsQGVzbWlsLmRrOw0KPiB0b255LnhpZUByb2NrLWNoaXBz
LmNvbTsgUmFqYW4gVmFqYSA8UkFKQU5WQHhpbGlueC5jb20+OyBKb2xseSBTaGFoDQo+IDxKT0xM
WVNAeGlsaW54LmNvbT47IE5hdmEga2lzaG9yZSBNYW5uZSA8bmF2YW1AeGlsaW54LmNvbT47DQo+
IG1kZkBrZXJuZWwub3JnOyBvbG9mQGxpeG9tLm5ldDsgbGludXgtbW1jQHZnZXIua2VybmVsLm9y
ZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LXJv
Y2tjaGlwQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwMS8x
MV0gZHQtYmluZGluZ3M6IG1tYzogYXJhc2FuOiBVcGRhdGUNCj4gZG9jdW1lbnRhdGlvbiBmb3Ig
U0QgQ2FyZCBDbG9jaw0KPiANCj4gT24gVHVlLCAyMyBKdWwgMjAxOSBhdCAxMDoyMywgTWFuaXNo
IE5hcmFuaSA8TU5BUkFOSUB4aWxpbnguY29tPiB3cm90ZToNCj4gPg0KPiA+IEhpIFJvYiwNCj4g
Pg0KPiA+IFRoYW5rcyBhIGxvdCBmb3IgdGhlIHJldmlldyENCj4gPg0KPiA+DQo+ID4gPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogUm9iIEhlcnJpbmcgPHJvYmhAa2Vy
bmVsLm9yZz4NCj4gPiA+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMjMsIDIwMTkgMzoyNCBBTQ0KPiA+
ID4gVG86IE1hbmlzaCBOYXJhbmkgPE1OQVJBTklAeGlsaW54LmNvbT4NCj4gPiA+IENjOiB1bGYu
aGFuc3NvbkBsaW5hcm8ub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgaGVpa29Ac250ZWNoLmRl
Ow0KPiBNaWNoYWwNCj4gPiA+IFNpbWVrIDxtaWNoYWxzQHhpbGlueC5jb20+OyBhZHJpYW4uaHVu
dGVyQGludGVsLmNvbTsNCj4gPiA+IGNocmlzdG9waC5tdWVsbG5lckB0aGVvYnJvbWEtc3lzdGVt
cy5jb207IHBoaWxpcHAudG9tc2ljaEB0aGVvYnJvbWEtDQo+ID4gPiBzeXN0ZW1zLmNvbTsgdmly
ZXNoLmt1bWFyQGxpbmFyby5vcmc7IHNjb3R0LmJyYW5kZW5AYnJvYWRjb20uY29tOw0KPiA+ID4g
YXlha2FAc291bGlrLmluZm87IGtlcm5lbEBlc21pbC5kazsgdG9ueS54aWVAcm9jay1jaGlwcy5j
b207IFJhamFuIFZhamENCj4gPiA+IDxSQUpBTlZAeGlsaW54LmNvbT47IEpvbGx5IFNoYWggPEpP
TExZU0B4aWxpbnguY29tPjsgTmF2YSBraXNob3JlDQo+IE1hbm5lDQo+ID4gPiA8bmF2YW1AeGls
aW54LmNvbT47IG1kZkBrZXJuZWwub3JnOyBvbG9mQGxpeG9tLm5ldDsgbGludXgtDQo+ID4gPiBt
bWNAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+
ID4gPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmc7IGxpbnV4LQ0KPiA+ID4gcm9ja2NoaXBAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiA+
ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwMS8xMV0gZHQtYmluZGluZ3M6IG1tYzogYXJhc2Fu
OiBVcGRhdGUNCj4gPiA+IGRvY3VtZW50YXRpb24gZm9yIFNEIENhcmQgQ2xvY2sNCj4gPiA+DQo+
ID4gPiBPbiBNb24sIEp1bCAwMSwgMjAxOSBhdCAxMDo1OTo0MUFNICswNTMwLCBNYW5pc2ggTmFy
YW5pIHdyb3RlOg0KPiA+ID4gPiBUaGUgY2xvY2sgaGFuZGxpbmcgaXMgdG8gYmUgdXBkYXRlZCBp
biB0aGUgQXJhc2FuIFNESENJLiBBcyB0aGUNCj4gPiA+ID4gJ2Rldm1fY2xrX3JlZ2lzdGVyJyBp
cyBkZXByZWNhdGVkIGluIHRoZSBjbG9jayBmcmFtZXdvcmssIHRoaXMgbmVlZHMgdG8NCj4gPiA+
ID4gc3BlY2lmeSBvbmUgbW9yZSBjbG9jayBuYW1lZCAnY2xrX3NkY2FyZCcgdG8gZ2V0IHRoZSBj
bG9jayBpbiB0aGUgZHJpdmVyDQo+ID4gPiA+IHZpYSAnZGV2bV9jbGtfZ2V0KCknLiBUaGlzIGNs
b2NrIHJlcHJlc2VudHMgdGhlIGNsb2NrIGZyb20gY29udHJvbGxlciB0bw0KPiA+ID4gPiB0aGUg
Y2FyZC4NCj4gPiA+DQo+ID4gPiBQbGVhc2UgZXhwbGFpbiB3aHkgaW4gdGVybXMgb2YgdGhlIGJp
bmRpbmcsIG5vdCBzb21lIGRyaXZlciBjYWxscy4NCj4gPiBPa2F5Lg0KPiA+DQo+ID4gPg0KPiA+
ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTWFuaXNoIE5hcmFuaSA8bWFuaXNoLm5hcmFuaUB4
aWxpbnguY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9tbWMvYXJhc2FuLHNkaGNpLnR4dCB8IDE1DQo+ICsrKysrKysrKystDQo+ID4g
PiAtLS0tDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNSBkZWxl
dGlvbnMoLSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9tbWMvYXJhc2FuLHNkaGNpLnR4dA0KPiA+ID4gYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL2FyYXNhbixzZGhjaS50eHQNCj4gPiA+ID4gaW5k
ZXggMWVkYmIwNC4uMTVjNjM5NyAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9hcmFzYW4sc2RoY2kudHh0DQo+ID4gPiA+ICsrKyBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvYXJhc2FuLHNkaGNpLnR4dA0KPiA+
ID4gPiBAQCAtMjMsNiArMjMsMTAgQEAgUmVxdWlyZWQgUHJvcGVydGllczoNCj4gPiA+ID4gICAg
LSByZWc6IEZyb20gbW1jIGJpbmRpbmdzOiBSZWdpc3RlciBsb2NhdGlvbiBhbmQgbGVuZ3RoLg0K
PiA+ID4gPiAgICAtIGNsb2NrczogRnJvbSBjbG9jayBiaW5kaW5nczogSGFuZGxlcyB0byBjbG9j
ayBpbnB1dHMuDQo+ID4gPiA+ICAgIC0gY2xvY2stbmFtZXM6IEZyb20gY2xvY2sgYmluZGluZ3M6
IFR1cGxlIGluY2x1ZGluZyAiY2xrX3hpbiIgYW5kDQo+ICJjbGtfYWhiIg0KPiA+ID4gPiArICAg
ICAgICAgICAgQXBhcnQgZnJvbSB0aGVzZSB0d28gdGhlcmUgaXMgb25lIG1vcmUgb3B0aW9uYWwg
Y2xvY2sgd2hpY2gNCj4gPiA+ID4gKyAgICAgICAgICAgIGlzICJjbGtfc2RjYXJkIi4gVGhpcyBj
bG9jayByZXByZXNlbnRzIG91dHB1dCBjbG9jayBmcm9tDQo+ID4gPiA+ICsgICAgICAgICAgICBj
b250cm9sbGVyIGFuZCBjYXJkLiBUaGlzIG11c3QgYmUgc3BlY2lmaWVkIHdoZW4gI2Nsb2NrLWNl
bGxzDQo+ID4gPiA+ICsgICAgICAgICAgICBpcyBzcGVjaWZpZWQuDQo+ID4gPiA+ICAgIC0gaW50
ZXJydXB0czogSW50ZXJydXB0IHNwZWNpZmllcg0KPiA+ID4gPg0KPiA+ID4gPiAgUmVxdWlyZWQg
UHJvcGVydGllcyBmb3IgImFyYXNhbixzZGhjaS01LjEiOg0KPiA+ID4gPiBAQCAtMzYsOSArNDAs
MTAgQEAgT3B0aW9uYWwgUHJvcGVydGllczoNCj4gPiA+ID4gICAgLSBjbG9jay1vdXRwdXQtbmFt
ZXM6IElmIHNwZWNpZmllZCwgdGhpcyB3aWxsIGJlIHRoZSBuYW1lIG9mIHRoZSBjYXJkDQo+IGNs
b2NrDQo+ID4gPiA+ICAgICAgd2hpY2ggd2lsbCBiZSBleHBvc2VkIGJ5IHRoaXMgZGV2aWNlLiAg
UmVxdWlyZWQgaWYgI2Nsb2NrLWNlbGxzIGlzDQo+ID4gPiA+ICAgICAgc3BlY2lmaWVkLg0KPiA+
ID4gPiAtICAtICNjbG9jay1jZWxsczogSWYgc3BlY2lmaWVkIHRoaXMgc2hvdWxkIGJlIHRoZSB2
YWx1ZSA8MD4uICBXaXRoIHRoaXMNCj4gcHJvcGVydHkNCj4gPiA+ID4gLSAgICBpbiBwbGFjZSB3
ZSB3aWxsIGV4cG9ydCBhIGNsb2NrIHJlcHJlc2VudGluZyB0aGUgQ2FyZCBDbG9jay4gIFRoaXMg
Y2xvY2sNCj4gPiA+ID4gLSAgICBpcyBleHBlY3RlZCB0byBiZSBjb25zdW1lZCBieSBvdXIgUEhZ
LiAgWW91IG11c3QgYWxzbyBzcGVjaWZ5DQo+ID4gPiA+ICsgIC0gI2Nsb2NrLWNlbGxzOiBJZiBz
cGVjaWZpZWQgdGhpcyBzaG91bGQgYmUgdGhlIHZhbHVlIDwwPi4gV2l0aCB0aGlzDQo+ID4gPiA+
ICsgICAgcHJvcGVydHkgaW4gcGxhY2Ugd2Ugd2lsbCBleHBvcnQgb25lIGNsb2NrIHJlcHJlc2Vu
dGluZyB0aGUgQ2FyZA0KPiA+ID4gPiArICAgIENsb2NrLiBUaGlzIGNsb2NrIGlzIGV4cGVjdGVk
IHRvIGJlIGNvbnN1bWVkIGJ5IG91ciBQSFkuIFlvdSBtdXN0DQo+IGFsc28NCj4gPiA+ID4gKyAg
ICBzcGVjaWZ5DQo+ID4gPg0KPiA+ID4gc3BlY2lmeSB3aGF0Pw0KPiA+IEkgdGhpbmsgdGhpcyBs
aW5lIHdhcyBhbHJlYWR5IHRoZXJlLCBJIG1pc3NlZCB0byBjb3JyZWN0IGl0LCBXaWxsIHVwZGF0
ZSBpbiB2My4NCj4gPg0KPiA+ID4NCj4gPiA+IFRoZSAzcmQgY2xvY2sgaW5wdXQgSSBhc3N1bWU/
IFRoaXMgc3RhdGVtZW50IG1lYW5zIGFueSBleGlzdGluZyB1c2Vycw0KPiA+ID4gd2l0aCAyIGNs
b2NrIGlucHV0cyBhbmQgI2Nsb2NrLWNlbGxzIGFyZSBpbiBlcnJvciBub3cuIElzIHRoYXQgY29y
cmVjdD8NCj4gPiBZZXMsIHRoaXMgaXMgY29ycmVjdC4gU28gZmFyIHRoZXJlIHdhcyBvbmx5IG9u
ZSB2ZW5kb3IgdXNpbmcgJyNjbG9jay1jZWxscycNCj4gd2hpY2ggaXMgUm9ja2NoaXAuIEkgaGF2
ZSBzZW50IERUIHBhdGNoICgwMi8xMSkgZm9yIHRoYXQgYWxzby4NCj4gPiBIZXJlIHRoaXMgaXMg
bmVlZGVkIGFzIGVhcmxpZXIgaW1wbGVtZW50YXRpb24gaXNuJ3QgY29ycmVjdCBhcyBzdWdnZXN0
ZWQgYnkNCj4gVWZmZS4gKGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE5LzYvMjAvNDg2KSAuDQo+
IA0KPiBJIGFtIG5vdCBzdXJlIGhvdyBiaWcgb2YgYSBwcm9ibGVtIHRoZSBiYWNrd2FyZHMgY29t
cGF0aWJsZSB0aGluZ3kNCj4gd2l0aCBEVCBpcywgaW4gZ2VuZXJhbCB3ZSBtdXN0IG5vdCBicmVh
ayBpdC4gV2hhdCBkbyB5b3Ugc2F5IE1hbmlzaD8NCg0KVGhvdWdoIEkgYWdyZWUgd2l0aCBVZmZl
IG9uIHRoaXMsIHRoZXJlIGlzIG5vIG90aGVyIHdheSBmcm9tIG15IHVuZGVyc3RhbmRpbmcuIFBs
ZWFzZSBzdWdnZXN0Lg0KDQo+IA0KPiBBcyBhIHdvcmthcm91bmQsIHdvdWxkIGl0IGJlIHBvc3Np
YmxlIHRvIHVzZQ0KPiBvZl9jbGtfZ2V0X2Zyb21fcHJvdmlkZXIoKSBzb21laG93IHRvIGFkZHJl
c3MgdGhlIGNvbXBhdGliaWxpdHkgaXNzdWU/DQoNCkZvciB0aGlzIHRvIGJlIHVzZWQgd2UgaGF2
ZSB0byBwYXJzZSAnY2xrc3BlYycgZnJvbSB0aGUgRFQgbm9kZSBhbmQgcGFzcyB0aGUgc2FtZSBh
cyBhbiBhcmd1bWVudCB0byB0aGlzIGZ1bmN0aW9uLiBJbiB0aGlzIGNhc2UgYWxzbyB0aGUgRFQg
bm9kZSBuZWVkcyB0byBiZSB1cGRhdGVkLCB3aGljaCBpcyBzYW1lIGFzIHdlIGhhdmUgZG9uZSBp
biB0aGlzIHNlcmllcy4NCg0KDQoNClRoYW5rcywNCk1hbmlzaA0K
