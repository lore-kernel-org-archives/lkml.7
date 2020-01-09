Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21289C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 12:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4192067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 12:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="RIRHznKU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgAIMwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 07:52:41 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:4772 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgAIMwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 07:52:40 -0500
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: BXLgZ5ObvlACkwgkG+3KEMGKQObsYAu0mu0f3IEIKqVbSGWS4eYS83D6egvv+xF6Lw4kcHP0Tc
 hfBy3aUkYpKsOPKRMj0zplXY5tTybySkmjrqVEv8IQZO1XeN1u79bqOC9x2pyZ5Vr5AkQwhE1j
 hfrOP+0R5/JULrg2M1ogVaFKmD3lZGO/eQoL7Oqf4jkgYdtuSpz7ETEudirO6rrAPlm6D5vAer
 9XGUMtI7apUOBH/1b49vMrOjGo0s/9XEUD4boDnmuh9JTKTrPrg74a8QCevh8nEsakiJgD/mnT
 AGQ=
X-IronPort-AV: E=Sophos;i="5.69,413,1571727600"; 
   d="scan'208";a="62091151"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jan 2020 05:52:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 9 Jan 2020 05:52:38 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 9 Jan 2020 05:52:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlKLMm5s6YPlo9cUo2523wDwv8BqHMGq2QlkNHCqpoHmqZH1/FrTwMmAo+fGWts/FmnY3iBcTNOmO5ZPz2GV+jVyQ6q0LJzuaPbDtv8MfwRx3Ex5/lYQp9McNKBhoUW3w0iLbGfCDw7a5lr+ZJl/B5ItEQ4Njb6OpegHJQ7+WbD8GZnhNK54ZxbpD3F9G9GzQNbGNOdT1jSJGzSd0n3dR48hYEP3y4n83e69dSdi9aq0U2zQPtsjvHznGD1wRUYulBC+SDX+0DgbDCA5Cqweju3oj9MGkxtbxhJ8qHo12KQ+UFq6h05Lz80+Z7KluzNFtOtkg1OEify38TCo3sHrGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpwvHvGRBZFjA02+hDGVk6osB83OLmNTnGl2gH3d0GA=;
 b=fqndxkIryZNBIITtUeQ46blwcW09SsVt+Y+uoVIrbv5STArKshEpzfNOaqrHgoU6bVHv7zylU8flGsFuLkTc0NWGrPg0B1WzFs4XewXYW4stjYPn53bd438cDmqqlr4SkJNLWQUJEimYanpPtxOvQac/vEtkLLfZiHA4nArl/mHkx9DMyZuAA+/qsDH5KORUmZSj0dDlaO8z7g9v7QSScNhzkWFUJsQoiH89YK1oAkVBkNOMU7mjuqv3xdW4seSo+1GQs+zCGE4tsVRxYOQiue2MsCrDFbNdjUGgc0XIgL+/wuwzQAEgrHsO7rIxtQdY4CcOgvjqZD3pjKPKowGDRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpwvHvGRBZFjA02+hDGVk6osB83OLmNTnGl2gH3d0GA=;
 b=RIRHznKUA/dIwzM50w5CBKA3X6UR0k+AxkSNoM7nBhINGGHFctysFiKLEhNo6pbkIJq22aQppWgjZWbamIhVyZEDb7Rq4u52pmJnT8n52Hrt4FZCXfdrxf5Us5S+VWd2N7yAwU8+BEEgcduuk3s/8pFYEQWModlfyOp0mVfWxvg=
Received: from DM6PR11MB3225.namprd11.prod.outlook.com (20.176.120.224) by
 DM6PR11MB3899.namprd11.prod.outlook.com (20.176.127.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.15; Thu, 9 Jan 2020 12:52:38 +0000
Received: from DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::106f:424f:ac54:1dbb]) by DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::106f:424f:ac54:1dbb%7]) with mapi id 15.20.2623.008; Thu, 9 Jan 2020
 12:52:38 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clocksource/drivers/timer-microchip-pit64b: fix sparse
 warning
Thread-Topic: [PATCH] clocksource/drivers/timer-microchip-pit64b: fix sparse
 warning
Thread-Index: AQHVxuhw55hpJ7sylE+omp5VUHJiIg==
Date:   Thu, 9 Jan 2020 12:52:38 +0000
Message-ID: <592c845f-7d1f-b669-47a5-63b4ac99a0fe@microchip.com>
References: <1578304688-14882-1-git-send-email-claudiu.beznea@microchip.com>
 <362407a3-036a-c38d-1dc4-2730d616592b@linaro.org>
 <4e71d1f3-f28a-1c34-3869-bc24b7caad32@microchip.com>
 <18cafa75-7c01-f542-1829-3e0c0f0a7943@linaro.org>
In-Reply-To: <18cafa75-7c01-f542-1829-3e0c0f0a7943@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d087cf6-3a27-4133-bcf4-08d79502ce65
x-ms-traffictypediagnostic: DM6PR11MB3899:
x-microsoft-antispam-prvs: <DM6PR11MB389931C6C3BA1418D0F7CC1C87390@DM6PR11MB3899.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(346002)(366004)(39860400002)(189003)(199004)(2906002)(4326008)(2616005)(186003)(316002)(53546011)(6512007)(86362001)(31696002)(6506007)(81166006)(8936002)(5660300002)(26005)(8676002)(71200400001)(91956017)(66946007)(66556008)(66446008)(64756008)(66476007)(36756003)(76116006)(6486002)(81156014)(110136005)(31686004)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB3899;H:DM6PR11MB3225.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JoEsKwVzWu7/1v6dCYs35U0+pzG5l+Bc7fgm4rJcJk91zz4yvYuzZVCFAk8jczA78WBUL7PfNL8kQa7AviyhY/fwIZjMABEZWIaDBEzmldABNS3DeCSpqJ1Djm9npljOPFuFZV/NOk5J4RzCBCNls3iBFSFIAdQd+HEUP/kjijQphW9kSfedpAm9LvoKbb8afK+WSXfOV13PEeQH4ZpbDukQKVADhJd9J2HRYl9E8QbyBUVcRSu1lSxhVrEvkHWvEFN64ydQG3KH3e7/V6AgPgzGSoe0QgfnI65QNHtsrl2zGC0zpekhd2el2pIg8TmX4fqajgrlJ/1aZoSyu1uPkCang1j+MvYZRs3seX9xlQFgSVv+wVEMDcII1wBD+9vC/w2cV4MewDR6M8RefOR8GdfTmIUGsVRTDHi3tZ7eVkwTC+A0PNLqcTpyz+yH3hd7MgA/sOti7wYTZ+/9dOKklpjDKv+ukZsKleeu0MtJ+/wVmkTrFb01gddfOfUKd4L2WNhN/M+AiRwf9F9nhZF/TA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9B16811C047E04D824344C29F72C987@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d087cf6-3a27-4133-bcf4-08d79502ce65
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 12:52:38.0942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Tv4Z/wSfqOU5n/JWUdlW841j/ns7v6PuAMtXyNgh3Mm25mnq+TRdYsOr4kGmigHDCmQIOr98tSEGsLsQ+wGrsk/NY7DsaQtbzNP/E7Kp6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3899
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA5LjAxLjIwMjAgMTQ6NDAsIERhbmllbCBMZXpjYW5vIHdyb3RlOg0KPiBFWFRFUk5B
TCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlv
dSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDA5LzAxLzIwMjAgMTM6MjksIENs
YXVkaXUuQmV6bmVhQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+Pg0KPj4NCj4+IE9uIDA5LjAxLjIw
MjAgMTM6NTksIERhbmllbCBMZXpjYW5vIHdyb3RlOg0KPj4+IE9uIDA2LzAxLzIwMjAgMTA6NTgs
IENsYXVkaXUgQmV6bmVhIHdyb3RlOg0KPj4+PiBGaXggc3BhcnNlIHdhcm5pbmcuDQo+Pj4NCj4+
PiBNaW5kIHRvIGdpdmUgdGhlIHdhcm5pbmc/DQo+Pg0KPj4gU29ycnksIGlzIHRoaXMgb25lOiAi
d2FybmluZzogVXNpbmcgcGxhaW4gaW50ZWdlciBhcyBOVUxMIHBvaW50ZXIiLg0KPj4NCj4+IFdv
dWxkIHlvdSBsaWtlIG1lIHRvIHNlbmQgdjIgdXBkYXRpbmcgaXQgd2l0aCB0aGUgd2FybmluZz8N
Cj4gDQo+IE5vLCBpdCBpcyBmaW5lLCBJIHdpbGwgdXBkYXRlIHRoZSBsb2cgbWFudWFsbHkuDQoN
ClRoYW5rIHlvdSENCg0KPiANCj4gVGhhbmtzDQo+IA0KPj4+PiBSZXBvcnRlZC1ieToga2J1aWxk
IHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IENsYXVkaXUg
QmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KPj4+PiAtLS0NCj4+Pj4gIGRy
aXZlcnMvY2xvY2tzb3VyY2UvdGltZXItbWljcm9jaGlwLXBpdDY0Yi5jIHwgNCArKystDQo+Pj4+
ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4+DQo+
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLW1pY3JvY2hpcC1waXQ2
NGIuYyBiL2RyaXZlcnMvY2xvY2tzb3VyY2UvdGltZXItbWljcm9jaGlwLXBpdDY0Yi5jDQo+Pj4+
IGluZGV4IDI3YTM4OWE3ZTA3OC4uYmQ2M2QzNDg0ODM4IDEwMDY0NA0KPj4+PiAtLS0gYS9kcml2
ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLW1pY3JvY2hpcC1waXQ2NGIuYw0KPj4+PiArKysgYi9kcml2
ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLW1pY3JvY2hpcC1waXQ2NGIuYw0KPj4+PiBAQCAtMjQ4LDYg
KzI0OCw4IEBAIHN0YXRpYyBpbnQgX19pbml0IG1jaHBfcGl0NjRiX2luaXRfbW9kZShzdHJ1Y3Qg
bWNocF9waXQ2NGJfdGltZXIgKnRpbWVyLA0KPj4+PiAgICAgICBpZiAoIXBjbGtfcmF0ZSkNCj4+
Pj4gICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4+Pj4NCj4+Pj4gKyAgICAgdGltZXIt
Pm1vZGUgPSAwOw0KPj4+PiArDQo+Pj4+ICAgICAgIC8qIFRyeSB1c2luZyBHQ0xLLiAqLw0KPj4+
PiAgICAgICBnY2xrX3JvdW5kID0gY2xrX3JvdW5kX3JhdGUodGltZXItPmdjbGssIG1heF9yYXRl
KTsNCj4+Pj4gICAgICAgaWYgKGdjbGtfcm91bmQgPCAwKQ0KPj4+PiBAQCAtMzYwLDcgKzM2Miw3
IEBAIHN0YXRpYyBpbnQgX19pbml0IG1jaHBfcGl0NjRiX2R0X2luaXRfdGltZXIoc3RydWN0IGRl
dmljZV9ub2RlICpub2RlLA0KPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBib29sIGNsa2V2dCkNCj4+Pj4gIHsNCj4+Pj4gICAgICAgdTMyIGZyZXEgPSBjbGtl
dnQgPyBNQ0hQX1BJVDY0Ql9ERUZfQ0VfRlJFUSA6IE1DSFBfUElUNjRCX0RFRl9DU19GUkVROw0K
Pj4+PiAtICAgICBzdHJ1Y3QgbWNocF9waXQ2NGJfdGltZXIgdGltZXIgPSB7IDAgfTsNCj4+Pj4g
KyAgICAgc3RydWN0IG1jaHBfcGl0NjRiX3RpbWVyIHRpbWVyOw0KPj4+PiAgICAgICB1bnNpZ25l
ZCBsb25nIGNsa19yYXRlOw0KPj4+PiAgICAgICB1MzIgaXJxID0gMDsNCj4+Pj4gICAgICAgaW50
IHJldDsNCj4+Pj4NCj4+Pg0KPj4+DQo+Pj4gLS0NCj4+PiAgPGh0dHA6Ly93d3cubGluYXJvLm9y
Zy8+IExpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29Dcw0KPj4+
DQo+Pj4gRm9sbG93IExpbmFybzogIDxodHRwOi8vd3d3LmZhY2Vib29rLmNvbS9wYWdlcy9MaW5h
cm8+IEZhY2Vib29rIHwNCj4+PiA8aHR0cDovL3R3aXR0ZXIuY29tLyMhL2xpbmFyb29yZz4gVHdp
dHRlciB8DQo+Pj4gPGh0dHA6Ly93d3cubGluYXJvLm9yZy9saW5hcm8tYmxvZy8+IEJsb2cNCj4+
Pg0KPiANCj4gDQo+IC0tDQo+ICA8aHR0cDovL3d3dy5saW5hcm8ub3JnLz4gTGluYXJvLm9yZyDi
lIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzDQo+IA0KPiBGb2xsb3cgTGluYXJv
OiAgPGh0dHA6Ly93d3cuZmFjZWJvb2suY29tL3BhZ2VzL0xpbmFybz4gRmFjZWJvb2sgfA0KPiA8
aHR0cDovL3R3aXR0ZXIuY29tLyMhL2xpbmFyb29yZz4gVHdpdHRlciB8DQo+IDxodHRwOi8vd3d3
LmxpbmFyby5vcmcvbGluYXJvLWJsb2cvPiBCbG9nDQo+IA0KPiA=
