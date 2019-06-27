Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B850C48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 19:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A2D2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 19:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NaRKL4nC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ID3fgXMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfF0T6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 15:58:55 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:26986 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfF0T6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 15:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561665535; x=1593201535;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=n6edhB3zslEinTxR6XjdzVfqoOAN7Hj7J8gj/v3kkmU=;
  b=NaRKL4nCf4f6DEyia1Enmv/Y9Q/MmQCNyNkCdp+qEGFbClRn3GH+Fq1B
   EjyMpVCOj+a/zeg8u8ZPbg5K0KA66wlIXunDHD7btUszKERbxmmS+mlwC
   VzEufbaopS3Rt/JrYFxGh4rJZyKIHpqL2ETOod7EmyQBQwQ8JkYsLM3zC
   zjWw6gic08Mp3goNp+T+98lUHDoxgpKJs0dFVW4AvoCA2HqAfPy2SSoHs
   vLOV2gBV4dG0CEpcRthM81hXINFGLl6yCea4y6L5mccZZWM38FAzFJFex
   ADMHmIW3G4J/U4Hep8FRPcsS9FEiP/hp9/xm4mUUU00bu71XLc5gEjMey
   w==;
X-IronPort-AV: E=Sophos;i="5.63,424,1557158400"; 
   d="scan'208";a="111722026"
Received: from mail-co1nam03lp2051.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.51])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2019 03:58:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=FrsGql4ytWzwIFg476I5wA27ntxbHl5OIz2w9mmv8NyF8AqvuoWTmehTbHNIL6o3D2FGi48OWs2ySIfJnAE9tk+nakqn97gniEf5psdZn3TD50rXOcm1AEIzD3vUxFjEALo86TP+HFf2PKNa32ehBE07OThLGgq4YhaGaMC5Azw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6edhB3zslEinTxR6XjdzVfqoOAN7Hj7J8gj/v3kkmU=;
 b=bQJQCestRN+6r+83hLJ0OIvHs4CEaCdmK2j4mJliK7DuzODgPfx6v5KVW8BLRnROfDAln2oOn5zT3hfE0idBfD2ZuAhRj1TjBMxX6hKGvx567/+hKZPzg0dkgRA6hOvHiPkGmLWxQqri93oCZOB6Vu1il+EorWwcMsKdILIQBKc=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6edhB3zslEinTxR6XjdzVfqoOAN7Hj7J8gj/v3kkmU=;
 b=ID3fgXMz+hO55eNAgSZ1WhHXsPr5NqpouwKoLcHDBYDLQhjLG5bEMsDCanGvvcPZvttn3BBh9QaVYLDKDqELndpunftiL+mmfPMCXTMVbk22dsH6ByHhBbtUpjiB0Hw1f16JpBuI5AqAJon02kka+8y2wfKipV3vFgUxsd0PIWA=
Received: from BYAPR04MB3782.namprd04.prod.outlook.com (52.135.214.142) by
 BYAPR04MB4392.namprd04.prod.outlook.com (20.176.252.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.17; Thu, 27 Jun 2019 19:58:50 +0000
Received: from BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::65e3:6069:d7d5:90a2]) by BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::65e3:6069:d7d5:90a2%5]) with mapi id 15.20.2008.014; Thu, 27 Jun 2019
 19:58:50 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>
CC:     "will.deacon@arm.com" <will.deacon@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "rfontana@redhat.com" <rfontana@redhat.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ottosabart@seberm.com" <ottosabart@seberm.com>,
        "morten.rasmussen@arm.com" <morten.rasmussen@arm.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v7 1/7] Documentation: DT: arm: add support for sockets
 defining package boundaries
Thread-Topic: [PATCH v7 1/7] Documentation: DT: arm: add support for sockets
 defining package boundaries
Thread-Index: AQHVJT7fBHlkRRyCkEKayvZI2kbcaqautN6AgAAd5ACAASg6AA==
Date:   Thu, 27 Jun 2019 19:58:50 +0000
Message-ID: <513883349e80792884b3754c259357d8066ad348.camel@wdc.com>
References: <20190617185920.29581-1-atish.patra@wdc.com>
         <20190617185920.29581-2-atish.patra@wdc.com>
         <alpine.DEB.2.21.9999.1906261724000.23534@viisi.sifive.com>
         <873a80f0-e704-dd7e-4db9-b159b23847fc@wdc.com>
In-Reply-To: <873a80f0-e704-dd7e-4db9-b159b23847fc@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 155fd803-5438-43c2-e3b0-08d6fb39dfe7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4392;
x-ms-traffictypediagnostic: BYAPR04MB4392:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR04MB4392F743BD6A9E509C34C142FAFD0@BYAPR04MB4392.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(189003)(199004)(6436002)(186003)(8676002)(26005)(76176011)(4326008)(305945005)(478600001)(99286004)(66066001)(8936002)(102836004)(6246003)(71190400001)(25786009)(81156014)(81166006)(68736007)(7736002)(71200400001)(54906003)(6306002)(53546011)(53936002)(6506007)(6512007)(36756003)(316002)(86362001)(110136005)(66446008)(66476007)(2906002)(2501003)(5660300002)(64756008)(14454004)(446003)(66556008)(73956011)(11346002)(66946007)(76116006)(3846002)(6116002)(7416002)(118296001)(476003)(486006)(72206003)(6486002)(229853002)(256004)(966005)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4392;H:BYAPR04MB3782.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MK5/kmFVBNzglmcSiekWRmgYFkbaJPDTdPr7P2JtIT4FkhV3V+n/zuXRQ4cU9WZ41SCq4bfiC9E34SzEDd8dM3bJarkqwwzC5QCVF2YbC0Y1ttJpBnB/A0Hljum4k1wGWBU1S4+R69dUP5t5sgP1GXkALMozCa8MPFnVuwLlsk7HPNVkijnPQhhP7VDTCqfAzj7Bya7orH0vW8WyqsLaVtUgafAyBF1NYfDbn/hsRgXPbz186X4ab2vB0w79wcRhorNhBqYHUGPcUo6VXiI7pUE/gXiPzLdGznPT2VKSXL4ibJhJbeY/5owcC7vk0mgriOOV1jG9BBjOak7CvKGikJMKL/mHXyeA0Q11VlQflUC0P7MX+kwvScQnkV0Z9O955N/xTmnWVxSexEf7RaecJKI0pl/wBCyBcKsCqSYVMpI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE6C3B113F433D42A951EC64A666E802@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 155fd803-5438-43c2-e3b0-08d6fb39dfe7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 19:58:50.4899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Atish.Patra@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4392
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA2LTI2IGF0IDE5OjE4IC0wNzAwLCBBdGlzaCBQYXRyYSB3cm90ZToNCj4g
T24gNi8yNi8xOSA1OjMxIFBNLCBQYXVsIFdhbG1zbGV5IHdyb3RlOg0KPiA+IEhpIFN1ZGVlcCwg
QXRpc2gsDQo+ID4gDQo+ID4gT24gTW9uLCAxNyBKdW4gMjAxOSwgQXRpc2ggUGF0cmEgd3JvdGU6
DQo+ID4gDQo+ID4gPiBGcm9tOiBTdWRlZXAgSG9sbGEgPHN1ZGVlcC5ob2xsYUBhcm0uY29tPg0K
PiA+ID4gDQo+ID4gPiBUaGUgY3VycmVudCBBUk0gRFQgdG9wb2xvZ3kgZGVzY3JpcHRpb24gcHJv
dmlkZXMgdGhlIG9wZXJhdGluZw0KPiA+ID4gc3lzdGVtDQo+ID4gPiB3aXRoIGEgdG9wb2xvZ2lj
YWwgdmlldyBvZiB0aGUgc3lzdGVtIHRoYXQgaXMgYmFzZWQgb24gbGVhZiBub2Rlcw0KPiA+ID4g
cmVwcmVzZW50aW5nIGVpdGhlciBjb3JlcyBvciB0aHJlYWRzIChpbiBhbiBTTVQgc3lzdGVtKSBh
bmQgYQ0KPiA+ID4gaGllcmFyY2hpY2FsIHNldCBvZiBjbHVzdGVyIG5vZGVzIHRoYXQgY3JlYXRl
cyBhIGhpZXJhcmNoaWNhbA0KPiA+ID4gdG9wb2xvZ3kNCj4gPiA+IHZpZXcgb2YgaG93IHRob3Nl
IGNvcmVzIGFuZCB0aHJlYWRzIGFyZSBncm91cGVkLg0KPiA+ID4gDQo+ID4gPiBIb3dldmVyIHRo
aXMgaGllcmFyY2hpY2FsIHJlcHJlc2VudGF0aW9uIG9mIGNsdXN0ZXJzIGRvZXMgbm90DQo+ID4g
PiBhbGxvdyB0bw0KPiA+ID4gZGVzY3JpYmUgd2hhdCB0b3BvbG9neSBsZXZlbCBhY3R1YWxseSBy
ZXByZXNlbnRzIHRoZSBwaHlzaWNhbA0KPiA+ID4gcGFja2FnZSBvcg0KPiA+ID4gdGhlIHNvY2tl
dCBib3VuZGFyeSwgd2hpY2ggaXMgYSBrZXkgcGllY2Ugb2YgaW5mb3JtYXRpb24gdG8gYmUNCj4g
PiA+IHVzZWQgYnkNCj4gPiA+IGFuIG9wZXJhdGluZyBzeXN0ZW0gdG8gb3B0aW1pemUgcmVzb3Vy
Y2UgYWxsb2NhdGlvbiBhbmQNCj4gPiA+IHNjaGVkdWxpbmcuDQo+ID4gPiANCj4gPiA+IExldHMg
YWRkIGEgbmV3ICJzb2NrZXQiIG5vZGUgdHlwZSBpbiB0aGUgY3B1LW1hcCBub2RlIHRvIGRlc2Ny
aWJlDQo+ID4gPiB0aGUNCj4gPiA+IHNhbWUuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6
IFN1ZGVlcCBIb2xsYSA8c3VkZWVwLmhvbGxhQGFybS5jb20+DQo+ID4gPiBSZXZpZXdlZC1ieTog
Um9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCj4gPiANCj4gPiBUaGlzIG9uZSBkb2Vzbid0
IGFwcGx5IGNsZWFubHkgaGVyZSBvbiB0b3Agb2YgdjUuMi1yYzIsIExpbnVzJ3MNCj4gPiBtYXN0
ZXINCj4gPiBicmFuY2gsIGFuZCBuZXh0LTIwMTkwNjI2LiAgVGhlIHJlamVjdCBmaWxlIGlzIGJl
bG93LiAgQW0gSSBtaXNzaW5nDQo+ID4gYSBwYXRjaD8NCj4gPiANCj4gDQo+IFRoYXQncyB3ZWly
ZC4gSSBjb3VsZCBhcHBseSB0aGUgcGF0Y2ggZnJvbSBhbnkgZ2l0IHRyZWUgKGdpdGh1YiBvciAN
Cj4gZ2l0Lmtlcm5lbC5vcmcpIGJ1dCBub3QgZnJvbSBtYWlsIG9yIHBhdGNod29ya3MuDQo+IA0K
PiBnaXQgbG9nIGRvZXNuJ3Qgc2hvdyBhbnkgcmVjZW50IG1vZGlmaWNhdGlvbnMgb2YgdGhhdCBm
aWxlLiBJIGFtDQo+IHRyeWluZyANCj4gdG8gZmlndXJlIG91dCB3aGF0J3Mgd3JvbmcuDQoNClRo
ZSBzcGFjZSBjaGFuZ2VzIGluIHRoaXMgcGF0Y2ggY2F1c2VkIHRoZSBjb25mbGljdC4gVGhlIHBh
dGNoIHdhcw0KZ2VuZXJhdGVkIHdpdGggLWIgd2hpY2ggd2FzIHN1Z2dlc3RlZCBkdXJpbmcgdGhl
IGluaXRpYWwgcmV2aWV3LiANCg0KSSBzaG91bGQgcmVtb3ZlZCBpdCBiZWZvcmUgc2VuZGluZyB2
Ny4gTXkgYmFkLg0KSSBoYXZlIGZpeGVkIHRoYXQgYW5kIHNlbnQgYSB2OCB0aGF0IHNob3VsZCBi
ZSBjbGVhbmx5IGFwcGxpZWQgb24NCmxhdGVzdCBtYXN0ZXIuIFRoZSBwYXRjaCBzZXJpZXMgaXMg
YWxzbyBhdmFpbGFibGUgYXQgDQoNCmh0dHBzOi8vZ2l0aHViLmNvbS9hdGlzaHAwNC9saW51eC90
cmVlLzUuMi1yYzZfdG9wb2xvZ3kNCg0KUmVnYXJkcywNCkF0aXNoDQo+ID4gLSBQYXVsDQo+ID4g
DQo+ID4gLS0tIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vdG9wb2xvZ3ku
dHh0DQo+ID4gKysrIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vdG9wb2xv
Z3kudHh0DQo+ID4gQEAgLTE4NSwxMyArMjA2LDE1IEBAIEJpbmRpbmdzIGZvciBjbHVzdGVyL2Nw
dS90aHJlYWQgbm9kZXMgYXJlDQo+ID4gZGVmaW5lZCBhcyBmb2xsb3dzOg0KPiA+ICAgNCAtIEV4
YW1wbGUgZHRzDQo+ID4gICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09DQo+ID4gICANCj4gPiAtRXhhbXBsZSAxIChBUk0gNjQtYml0LCAxNi1jcHUgc3lzdGVtLCB0
d28gY2x1c3RlcnMgb2YgY2x1c3RlcnMpOg0KPiA+ICtFeGFtcGxlIDEgKEFSTSA2NC1iaXQsIDE2
LWNwdSBzeXN0ZW0sIHR3byBjbHVzdGVycyBvZiBjbHVzdGVycyBpbg0KPiA+IGEgc2luZ2xlDQo+
ID4gK3BoeXNpY2FsIHNvY2tldCk6DQo+ID4gICANCj4gPiAgIGNwdXMgew0KPiA+ICAgCSNzaXpl
LWNlbGxzID0gPDA+Ow0KPiA+ICAgCSNhZGRyZXNzLWNlbGxzID0gPDI+Ow0KPiA+ICAgDQo+ID4g
ICAJY3B1LW1hcCB7DQo+ID4gKwkJc29ja2V0MCB7DQo+ID4gICAJCQljbHVzdGVyMCB7DQo+ID4g
ICAJCQkJY2x1c3RlcjAgew0KPiA+ICAgCQkJCQljb3JlMCB7DQo+ID4gDQo+IA0KPiANCg==
