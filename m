Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA199C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 18:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BEDF206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 18:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TTwfUtw9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KwxmVmK3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfHPSzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 14:55:20 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:37435 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfHPSzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 14:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565981720; x=1597517720;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EP7D8dLGMksDUznalFCyjN0yhbWtiDz+9nroUKJi+LE=;
  b=TTwfUtw9xq0CIjzFB9897sovc33UlVS0yOzsPCyigzaAC4NBqtF3TQVf
   y8hWx+L48SRaVB6s4dVuEEV3RIlJRFWQgM58CkvNx9miW41toDFFOKl0l
   lzUeShF0kxAd9Hj+QwND7b7uUnLE1YsMBUVG+FBCE67zglBaMAIu9M6mD
   YloJ9f4WxxpVRxjHsWcJJ42HtX9dok7IWYKhzTk72/Aonvv5yg6ip/m45
   pEulA11XxH6sISFu8r6D5pl4zI18upLnBOWa581Vhw3IBhL2syLLmGjby
   bk2bIQFbLeZA6HpLk5kBnzDHnOa2FJKdskxSAhqfp7JtfzP5LWOwSjfk7
   A==;
IronPort-SDR: JE3c9BCIMiIDrmcvS31iH+mUpWS5dveO5xqY5dBwECJN6ji7A/eEiOX+phULi3VvysEOJa5bx7
 NFZlxXfOTysZU1F5qepSmuomDQYa7klCHFN/cQtaL7AeloBF+8dR1d8Z5z/xXGmAKsaSP0uANr
 zA0I5Ma8LNS6TTB0TFrKuuLBgiJOycilUQLtdj1hLoiQhB1dJW0gNxkY6YK1AVVzg6rEyQ8iPK
 lyya2aOLK+O7aI65x8jlffiN9qj0rATlUm8IFveBd9k/qG6MIPPFQNHVrcxfxigh2Qwf8TEYy5
 rh8=
X-IronPort-AV: E=Sophos;i="5.64,394,1559491200"; 
   d="scan'208";a="117618533"
Received: from mail-bn3nam04lp2050.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.50])
  by ob1.hgst.iphmx.com with ESMTP; 17 Aug 2019 02:55:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bg0DFy99WSjwbJHn3MKj5h6pf7tWTEdtCTqkU0XzBqXR3nM5r0T/7vKIUccTx9VwfWIbifB2Whnu0qK+kUxoXQzbKw37OHbTmZVh2FgKfTqVTNzcCmm3pJdHN5vNSg7UINrmbcEqMU+xk/puR9a5+xR8gcmtcNvsqFsLwBPJJ+cis64g0C2l0hMwxzmpEZB33x8Gh0ggZ5bp0IkqdB2Ykcmqn20bb/z7pkCjEtF7l58bAlPNNkDuRo+ioJl8Fyb2Xfy1J+ABnskm+DSKtN7J7iisUKWujx+4WfOPVPnbCh2y4DazAYV+IThIiBpsysisnXKek0Y5RgSNbt31fns9/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EP7D8dLGMksDUznalFCyjN0yhbWtiDz+9nroUKJi+LE=;
 b=F68RU+VmV7GSVfvdIhTf9XRuR357flkNB6ZhqRPlFRtWXWcsYTDHlor2Szu97wcu/vQkCbgDZC/R9uYux2x2UQCZPNIhTYAM1BTiALGMXTzRC4IBKt/2S67BEzZlU4mmmzEJPjYrBJU8L+qW39UmNqWz7Wlfbo0VdOHIvl5MnmqeBE/bYmXRshs5tsnaA9T6CpxIzzvBN+YERndksEGuWvnAVtRhJUYmT/BtwvWrUQHk3izQtfD8dIB3AdDC1SfiYfrL36Qcr51B80lZ0Y3g7SDCGKgd50OCY3v2buWj/ifagnijRmWY911g06Mz7i3Um8px8NZU6avAoondzl1i8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EP7D8dLGMksDUznalFCyjN0yhbWtiDz+9nroUKJi+LE=;
 b=KwxmVmK3AOHV2bY05iQ9GO0YJ+3tdsxP3NUvWboMs4sMoU5tYfnENgWcTKUMRKN91NM80VG5RyJlMJhKOuGREUqcP7KjesZE7tr+cGYQ0jGWXRNuSjngeJb1K3HhQg0VHtcrPBAFl+gDs9YOFN6dU+imC7FD7mYOegUnkgpxohQ=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB5687.namprd04.prod.outlook.com (20.179.57.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.23; Fri, 16 Aug 2019 18:55:14 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::d89b:cb55:d563:79e9]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::d89b:cb55:d563:79e9%6]) with mapi id 15.20.2157.022; Fri, 16 Aug 2019
 18:55:14 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "palmer@sifive.com" <palmer@sifive.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "info@metux.net" <info@metux.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "johan@kernel.org" <johan@kernel.org>,
        "alexios.zavras@intel.com" <alexios.zavras@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/5] RISC-V: Remove per cpu clocksource
Thread-Topic: [PATCH v2 1/5] RISC-V: Remove per cpu clocksource
Thread-Index: AQHVRz65fC3jo+jL5k+gKVmQfc/Feab9+puAgAA/LIA=
Date:   Fri, 16 Aug 2019 18:55:14 +0000
Message-ID: <089a5ee46759074af391c50f5e9d28344b429de4.camel@wdc.com>
References: <20190731012418.24565-1-atish.patra@wdc.com>
         <20190731012418.24565-2-atish.patra@wdc.com>
         <6ba37c45-2d9b-c01e-5f17-3ab919da4de8@linaro.org>
In-Reply-To: <6ba37c45-2d9b-c01e-5f17-3ab919da4de8@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.175]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91821217-9a93-4693-c3a1-08d7227b45ec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5687;
x-ms-traffictypediagnostic: BYAPR04MB5687:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB568716BCF2CE159C5F78C326FAAF0@BYAPR04MB5687.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0131D22242
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(189003)(199004)(4326008)(5660300002)(2906002)(66066001)(11346002)(76116006)(2201001)(64756008)(229853002)(102836004)(66946007)(6436002)(66476007)(66446008)(66556008)(2501003)(25786009)(99286004)(54906003)(53936002)(486006)(110136005)(256004)(316002)(36756003)(6246003)(476003)(2616005)(446003)(86362001)(6486002)(478600001)(6306002)(8936002)(81166006)(3846002)(76176011)(118296001)(71190400001)(7416002)(81156014)(8676002)(14454004)(7736002)(6116002)(71200400001)(186003)(6506007)(305945005)(6512007)(53546011)(26005)(966005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5687;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 48ViOSj15fVdY5IiizhJ+DGgM+6Oe1jxlDZR4p+iTKTCS/pI5UwtqwotyOyy+y6urMSjKOK/Gx73HTN9XYUiZOeKgUCh58JR/2JxA/Kj0mc3MO58Mr/EzJpwN/ebFH0f39GmnfkFDeN5787rPPIrGNvD5IbTJsqLPf8LgCpu6buXBY2inC5CYf67viREBqho0Xw1P3raN1QOr+wGVS2CpCwvHxpL9bm8Xbi2FY69bmtWQsuLx3c82rvy0c9JHiQQuy4coaKTgAtNf+wJWdEHrWdCuTip7OzlM9w4GnWZ8Tohq+s/DYwDvaZz7wJdohv6EmowzYH8SvZJYPkKRI3RsTKgV2J/R2U9/ioIaVFzLsW79MDus6mLvwhvhYSoxOjZ0o6HQTVzIqauHybG1vU8COedr8m+gIhdbC4p9VTFdRs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFC2111BBC7AEE47B65ACD5C5909EF48@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91821217-9a93-4693-c3a1-08d7227b45ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2019 18:55:14.3961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wdmaUROIGtxIxVdUl0fuR5jDt9qudKlCh8B2AH/bM3KQ5HzV6qYD4EIMtcLARm4uzEx2f1A1HrA8QYRa8F1abw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5687
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTA4LTE2IGF0IDE3OjA5ICswMjAwLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToN
Cj4gT24gMzEvMDcvMjAxOSAwMzoyNCwgQXRpc2ggUGF0cmEgd3JvdGU6DQo+ID4gVGhlcmUgaXMg
b25seSBvbmUgY2xvY2tzb3VyY2UgaW4gUklTQy1WLiBUaGUgYm9vdCBjcHUgaW5pdGlhbGl6ZXMN
Cj4gPiB0aGF0IGNsb2Nrc291cmNlLiBObyBuZWVkIHRvIGtlZXAgYSBwZXJjcHUgZGF0YSBzdHJ1
Y3R1cmUuDQo+IA0KPiBUaGF0IGlzIG5vdCB3aGF0IGlzIHN0YXRlZCBpbiB0aGUgaW5pdGlhbCBw
YXRjaCBbMV0uDQo+IA0KPiBDYW4geW91IGNsYXJpZnkgdGhhdCA/DQo+IA0KDQpJIHRoaW5rIHdo
YXQgSSBtZWFudCB0byBzYXkgd2FzICJUaGVyZSBpcyBvbmx5IG9uZSBjbG9ja3NvdXJjZSB1c2Vk
IGluDQpSSVNDLVYgTGludXgiIGFzIGl0IGlzIGd1cmFudGVlZCB0aGF0IGFsbCB0aGUgdGltZXJz
IGFjcm9zcyBhbGwgdGhlDQpoYXJ0cyBhcmUgc3luY2hyb25pemVkIHdpdGhpbiBvbmUgdGljayBv
ZiBlYWNoIG90aGVyIFsyXS4gDQpBcG9sb2dpZXMgZm9yIG5vdCBiZWluZyB2ZXJib3NlIGhlcmUu
DQoNCkhvd2V2ZXIsIHJlYWRpbmcgdGhlIHByaXZpbGVnZSBzcGVjaWZpY2F0aW9uKDEuMTItZHJh
ZnQpIA0KDQpTZWN0aW9uLiAzLjEuMTAgc3RhdGVzIHRoYXQgDQoNCiJBY2N1cmF0ZSByZWFsLXRp
bWUgY2xvY2tzIChSVENzKSBhcmUgcmVsYXRpdmVseSBleHBlbnNpdmUgdG8gcHJvdmlkZQ0KKHJl
cXVpcmluZyBhIGNyeXN0YWwgb3IgTUVNUyBvc2NpbGxhdG9yKSBhbmQgaGF2ZSB0byBydW4gZXZl
biB3aGVuIHRoZQ0KcmVzdCBvZiBzeXN0ZW0gaXMgcG93ZXJlZCBkb3duLCBhbmQgc28gdGhlcmUg
aXMgdXN1YWxseSBvbmx5IG9uZSBpbiBhDQpzeXN0ZW0gbG9jYXRlZCBpbiBhIGRpZmZlcmVudCBm
cmVxdWVuY3kvdm9sdGFnZSBkb21haW4gZnJvbSB0aGUNCnByb2Nlc3NvcnMuIEhlbmNlLCB0aGUg
UlRDIG11c3QgYmUgc2hhcmVkIGJ5IGFsbCB0aGUgaGFydHMgaW4gYSBzeXN0ZW0iDQoNClRoaXMg
aXMgZGlmZmVyZW50IGZyb20gdGhlIGNvbW1pdCB0ZXh0IGluIFsxXS4NCg0KUGVyaGFwcyBJIG1p
c3VuZGVyc3Rvb2Qgc29tZXRoaW5nLiBAUGFsbWVyID8NCg0KDQpbMl0gDQpodHRwczovL2VsaXhp
ci5ib290bGluLmNvbS9saW51eC92NS4zLXJjNC9zb3VyY2UvZHJpdmVycy9jbG9ja3NvdXJjZS90
aW1lci1yaXNjdi5jI0w0NA0KDQo+IFRoYW5rcw0KPiANCj4gICAtLSBEYW5pZWwNCj4gDQo+IFsx
XSBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOC84LzQvNTENCj4gDQo+IA0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEF0aXNoIFBhdHJhIDxhdGlzaC5wYXRyYUB3ZGMuY29tPg0KPiA+IC0tLQ0KPiA+ICBk
cml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLXJpc2N2LmMgfCA2ICsrLS0tLQ0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLXJpc2N2LmMNCj4gPiBiL2RyaXZlcnMv
Y2xvY2tzb3VyY2UvdGltZXItcmlzY3YuYw0KPiA+IGluZGV4IDVlNjAzOGZiZjExNS4uMDllMDMx
MTc2YmM2IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xvY2tzb3VyY2UvdGltZXItcmlzY3Yu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvY2xvY2tzb3VyY2UvdGltZXItcmlzY3YuYw0KPiA+IEBAIC01
NSw3ICs1NSw3IEBAIHN0YXRpYyB1NjQgcmlzY3Zfc2NoZWRfY2xvY2sodm9pZCkNCj4gPiAgCXJl
dHVybiBnZXRfY3ljbGVzNjQoKTsNCj4gPiAgfQ0KPiA+ICANCj4gPiAtc3RhdGljIERFRklORV9Q
RVJfQ1BVKHN0cnVjdCBjbG9ja3NvdXJjZSwgcmlzY3ZfY2xvY2tzb3VyY2UpID0gew0KPiA+ICtz
dGF0aWMgc3RydWN0IGNsb2Nrc291cmNlIHJpc2N2X2Nsb2Nrc291cmNlID0gew0KPiA+ICAJLm5h
bWUJCT0gInJpc2N2X2Nsb2Nrc291cmNlIiwNCj4gPiAgCS5yYXRpbmcJCT0gMzAwLA0KPiA+ICAJ
Lm1hc2sJCT0gQ0xPQ0tTT1VSQ0VfTUFTSyg2NCksDQo+ID4gQEAgLTkyLDcgKzkyLDYgQEAgdm9p
ZCByaXNjdl90aW1lcl9pbnRlcnJ1cHQodm9pZCkNCj4gPiAgc3RhdGljIGludCBfX2luaXQgcmlz
Y3ZfdGltZXJfaW5pdF9kdChzdHJ1Y3QgZGV2aWNlX25vZGUgKm4pDQo+ID4gIHsNCj4gPiAgCWlu
dCBjcHVpZCwgaGFydGlkLCBlcnJvcjsNCj4gPiAtCXN0cnVjdCBjbG9ja3NvdXJjZSAqY3M7DQo+
ID4gIA0KPiA+ICAJaGFydGlkID0gcmlzY3Zfb2ZfcHJvY2Vzc29yX2hhcnRpZChuKTsNCj4gPiAg
CWlmIChoYXJ0aWQgPCAwKSB7DQo+ID4gQEAgLTExMiw4ICsxMTEsNyBAQCBzdGF0aWMgaW50IF9f
aW5pdCByaXNjdl90aW1lcl9pbml0X2R0KHN0cnVjdA0KPiA+IGRldmljZV9ub2RlICpuKQ0KPiA+
ICANCj4gPiAgCXByX2luZm8oIiVzOiBSZWdpc3RlcmluZyBjbG9ja3NvdXJjZSBjcHVpZCBbJWRd
IGhhcnRpZCBbJWRdXG4iLA0KPiA+ICAJICAgICAgIF9fZnVuY19fLCBjcHVpZCwgaGFydGlkKTsN
Cj4gPiAtCWNzID0gcGVyX2NwdV9wdHIoJnJpc2N2X2Nsb2Nrc291cmNlLCBjcHVpZCk7DQo+ID4g
LQllcnJvciA9IGNsb2Nrc291cmNlX3JlZ2lzdGVyX2h6KGNzLCByaXNjdl90aW1lYmFzZSk7DQo+
ID4gKwllcnJvciA9IGNsb2Nrc291cmNlX3JlZ2lzdGVyX2h6KCZyaXNjdl9jbG9ja3NvdXJjZSwN
Cj4gPiByaXNjdl90aW1lYmFzZSk7DQo+ID4gIAlpZiAoZXJyb3IpIHsNCj4gPiAgCQlwcl9lcnIo
IlJJU0NWIHRpbWVyIHJlZ2lzdGVyIGZhaWxlZCBbJWRdIGZvciBjcHUgPQ0KPiA+IFslZF1cbiIs
DQo+ID4gIAkJICAgICAgIGVycm9yLCBjcHVpZCk7DQo+ID4gDQo+IA0KPiANCg0K
