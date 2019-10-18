Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A41CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345B621835
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PGiuxm/g";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zobaZlST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505572AbfJRRyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 13:54:09 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:43661 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502168AbfJRRyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 13:54:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1571421261; x=1602957261;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oaJpbl2KIp05HqcOD4TAd3bXp2LZKmpimTVk7Wqq2xg=;
  b=PGiuxm/gDxh9tfZoLCbs6AECeQj9yU5RKUWn1MmB904cn5NhUy35AVSY
   LR2F+ECVRHV7r1VUN4EepGmAs8HXk0ZUblPIL90O6tHcLjnkgXs/i8oDc
   bSQP4+Nwsx3DX1iU6CvJj0TIU3ZCcuVIZXpwqg6/aCF3DXFy0pwYStcyI
   0pZmU5ftqdN3Eo4chgGbmg1KZ14B7t7tys7P/n5oGVp3gRhcmQRDCSKbc
   isnPc8mCjf1sLKXku1R4i/YucXN7cqy/NpAvBuKVT8idu+k3idcf/iitg
   ZXhpIsygIGbKrAoKq3aGAgy8ezGhCIYA5PTEaALuCveb6m5xoWPLzcj7d
   Q==;
IronPort-SDR: O3+ISaAKRro0lPiUTpGE6+tsfKLbo779yq/gA0FxTDDkxcXkvFZi3rsbAFtyR1S26StYtwZqMp
 thLlQDoBxDJDOXVuY61HrZIK9DZozBwcGeo140IELbu7WxPIKhr4JcFXVO/pAJEbF0m/ZenYMI
 lImnyL9e6hWaeCpY6BgEjsxpaT7jdkhqMrR/t/SIY9Q6pxZxZ5pjKrcw/esxXn0mRFXAB6Wn3z
 8pxRJQOc3h1FBuaNjtMBWLCl5Rcl9Fm/d0ntqZx1sjS6mJU+gXYHd0KVS/VjJ6hbTHgcLluVDj
 G+w=
X-IronPort-AV: E=Sophos;i="5.67,312,1566835200"; 
   d="scan'208";a="221933761"
Received: from mail-bl2nam02lp2052.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.52])
  by ob1.hgst.iphmx.com with ESMTP; 19 Oct 2019 01:54:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWHSY/yoUY1zHJeRWOG54KjncFoA/L0Vas+ymQUQH6Yci5Ft4XM0dvm/vAu0suj7orvmiuDFOtDXmBZmqdCzQP24a2rl7G5zf5XPnzPnO43sO0t5b2zN0CK2nqtRA0HX+G4eBPurqfBohzYNqL3s1E9uf/ONiY8j0TAVh5RryMlkCj0QRyQhN8d4X9xXw4jzwdz+0gIzCZdYC0aI9IoGFLtronEcLTE6RU4GOfGlSXHeltppOwrCXf1vmmeXLAZ8xyH4YN49LVI+xMylCsrWmIY6MKV37I5ZcKzHGvWw0MfKy6B6Zb9TMnHC8Hmx3reesPq1s+CUe7Ah8MR0Dv53Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oaJpbl2KIp05HqcOD4TAd3bXp2LZKmpimTVk7Wqq2xg=;
 b=LxQJGaa2/UJO+nIuXu3j4Iyi49H0BiRxxznmz9VBOF+0rxtaJZ1zSqrk6kht433AkiENyp14oTqq5u3fCS2AxGacFi5dBq+rJQvlzuk41gtQQCZbPZT+TEfDeajzvRZXDk7ujiWMJw057KMxAuP8BC3NWWG0AbToRj3BW0mPhwbgHH57W26jLshDNZOABXW5L90kaQySlgetNrpv5a2Z0WCp6iDgpr9Fr+1gRkLkdJVvPDuZ2cE05/KDVc5bF9gZV5QbjTRDrQHHjk+UjTm9ioHCUZbTpek5yOjL5rCnKMchB7SehnOiZQHfwFoEGQIMCOL9qgKZmniMAjyFL5Nukg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oaJpbl2KIp05HqcOD4TAd3bXp2LZKmpimTVk7Wqq2xg=;
 b=zobaZlSTXq3WTVyPNfhAAYCAf1H6A6rYOf8IXAIgX/7+t6kT/l8TAJH4EOlKZML9GSp2YZ2vPxA8DeXUCIKGvoTn0hXSY82A9OOyOktFqQwLK+cx426Ef/z9P8Jx5bFh1NGSBulHQ7OXc8W8+PaZT8bbr+jw9ZOv4h7sWkGKFVY=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB6262.namprd04.prod.outlook.com (20.178.232.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.20; Fri, 18 Oct 2019 17:53:59 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::51dd:7de9:c4a1:f9f3]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::51dd:7de9:c4a1:f9f3%3]) with mapi id 15.20.2347.024; Fri, 18 Oct 2019
 17:53:59 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "info@metux.net" <info@metux.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rfontana@redhat.com" <rfontana@redhat.com>,
        "johan@kernel.org" <johan@kernel.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "allison@lohutok.net" <allison@lohutok.net>
Subject: Re: [PATCH v2  2/2] RISC-V: Consolidate isa correctness check
Thread-Topic: [PATCH v2  2/2] RISC-V: Consolidate isa correctness check
Thread-Index: AQHVfu0fDoAFDM4020SNIx23VNFenqdgImCAgACZzQA=
Date:   Fri, 18 Oct 2019 17:53:59 +0000
Message-ID: <a45f0c0e3db2e852770485bc581d489b6ee7545e.camel@wdc.com>
References: <20191009220058.24964-1-atish.patra@wdc.com>
         <20191009220058.24964-3-atish.patra@wdc.com>
         <alpine.DEB.2.21.9999.1910180142460.21875@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1910180142460.21875@viisi.sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e41c5587-c92d-447b-4675-08d753f4276f
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: BYAPR04MB6262:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR04MB626271824621AD19985CD5CCFA6C0@BYAPR04MB6262.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(189003)(199004)(966005)(229853002)(6486002)(86362001)(4326008)(7416002)(4001150100001)(5660300002)(8936002)(118296001)(478600001)(2906002)(14454004)(186003)(66066001)(2351001)(36756003)(6116002)(3846002)(2616005)(71190400001)(71200400001)(476003)(66446008)(316002)(76176011)(256004)(66556008)(6506007)(446003)(66476007)(11346002)(76116006)(26005)(64756008)(66946007)(81166006)(81156014)(6436002)(8676002)(2501003)(5640700003)(6246003)(7736002)(25786009)(54906003)(6512007)(6306002)(486006)(102836004)(99286004)(6916009)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB6262;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7/zCNB44tFvC4gap487EjQFF6lTT6iqgXAUZDDdQio2P8i51/r7gVmSZMBGwB9T4VsHO33o1+MzThx1sVBlC1VMAxj09InV8lAL8aaIW1VLwyRnFlF3oSnDvquGpP8eaw5It1/L/CXtyVTdmcQGTlzK2IC0XB3uSjzMjhyK3dVaBscyfG75zAsC41hfExKBtV4Vzk2/Ry+HS5JRJ7mG0dV9vwZzAXwwrvBvA0ejmdR2T+B8Kv6d+y7NUcz+2D8PKHq6SIv1zYH3pk8B0a4B+e2RR4lDUUFs2umE0mz76bQCPmqBkbGdS1HraWvHnT1FOqaRLV7SWwX2zXWx/Nxt1zo4LqSplJCR2EbuJljtzU/7DY/ODlxvKGAhXUHQPhFdyNGfEcZQIEp/XmWY/kYVF0DxJb8kLM/wzSyHwGPXCVxjtiwc0I5PknfuZa6TT2sAx1O/UmV2Y5IkU7bOFTEI5pl0RsSckaAXZ2zo4kHjvkcE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD0F904F9F291B41BE368A262B3ADA8B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e41c5587-c92d-447b-4675-08d753f4276f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 17:53:59.2935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cSHicCRO9IHv/Hqbuu1mAKKI/Ybls90TOAeC7BFM/rX3ZH+uFf0acm2/gTISBP1h64iWsFRNxj5vUTBVEEH93A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6262
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTEwLTE4IGF0IDAxOjQzIC0wNzAwLCBQYXVsIFdhbG1zbGV5IHdyb3RlOg0K
PiBPbiBXZWQsIDkgT2N0IDIwMTksIEF0aXNoIFBhdHJhIHdyb3RlOg0KPiANCj4gPiBDdXJyZW50
bHksIGlzYSBzdHJpbmcgaXMgcmVhZCBhbmQgY2hlY2tlZCBmb3IgY29ycmVjdG5lc3MgYXQNCj4g
PiBtdWx0aXBsZQ0KPiA+IHBsYWNlcy4NCj4gPiANCj4gPiBDb25zb2xpZGF0ZSB0aGVtIGludG8g
b25lIGZ1bmN0aW9uIGFuZCB1c2UgaXQgb25seSBkdXJpbmcgZWFybHkNCj4gPiBib290dXAuDQo+
ID4gSW4gY2FzZSBvZiBhIGluY29ycmVjdCBpc2Egc3RyaW5nLCB0aGUgY3B1IHNob3VsZG4ndCBi
b290IGF0IGFsbC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBBdGlzaCBQYXRyYSA8YXRpc2gu
cGF0cmFAd2RjLmNvbT4NCj4gDQo+IExvb2tzIGxpa2UgcmlzY3ZfcmVhZF9jaGVja19pc2EoKSBp
cyBjYWxsZWQgdHdpY2UgZm9yIGVhY2ggaGFydC4gIElzDQo+IHRoZXJlIA0KPiBhbnkgd2F5IHRv
IGNhbGwgaXQgb25seSBvbmNlIHBlciBoYXJ0Pw0KPiANCg0KSSBoYWQgdG8gYWRkIHRoZSBjaGVj
ayBpbiByaXNjdl9maWxsX2h3Y2FwKCkgYmVjYXVzZSB0aGF0IGZ1bmN0aW9uIGlzDQppdGVyYXRp
bmcgb3ZlciBhbGwgY3B1IG5vZGVzIHRvIHNldCB0aGUgaHdjYXAuIFRodXMsIHNvbWUgb2YgdGhl
IGhhcnRzDQp0aGF0IGFyZSBub3QgYXZhaWxhYmxlIGR1ZSB0byBpbmNvcnJlY3QgaXNhIHN0cmlu
ZyBjYW4gYWZmZWN0IGh3Y2FwLg0KDQpXZSBjYW4gY2hlY2sgY3B1X3Bvc3NpYmxlX21hc2sgdG8g
ZmlndXJlIG91dCB0aGUgaGFydHMgd2l0aCBpbnZhbGlkIGlzYQ0Kc3RyaW5ncyBidXQgdGhhdCB3
aWxsIHBlcmZvcm0gcG9vcmx5IGFzIFJJU0MtViBoYXZlIG1vcmUgaGFydHMgaW4NCmZ1dHVyZS4N
Cg0KDQo+IA0KPiAtIFBhdWwNCj4gDQo+ID4gLS0tDQo+ID4gIGFyY2gvcmlzY3YvaW5jbHVkZS9h
c20vcHJvY2Vzc29yLmggfCAgMSArDQo+ID4gIGFyY2gvcmlzY3Yva2VybmVsL2NwdS5jICAgICAg
ICAgICAgfCA0MSArKysrKysrKysrKysrKysrKysrKysrLS0NCj4gPiAtLS0tLS0NCj4gPiAgYXJj
aC9yaXNjdi9rZXJuZWwvY3B1ZmVhdHVyZS5jICAgICB8ICA0ICstLQ0KPiA+ICBhcmNoL3Jpc2N2
L2tlcm5lbC9zbXBib290LmMgICAgICAgIHwgIDQgKysrDQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwg
MzcgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBh
L2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vcHJvY2Vzc29yLmgNCj4gPiBiL2FyY2gvcmlzY3YvaW5j
bHVkZS9hc20vcHJvY2Vzc29yLmgNCj4gPiBpbmRleCBmNTM5MTQ5ZDA0YzIuLjE4OWJmOThmOWEz
ZiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3Byb2Nlc3Nvci5oDQo+
ID4gKysrIGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9wcm9jZXNzb3IuaA0KPiA+IEBAIC03NCw2
ICs3NCw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCB3YWl0X2Zvcl9pbnRlcnJ1cHQodm9pZCkNCj4g
PiAgfQ0KPiA+ICANCj4gPiAgc3RydWN0IGRldmljZV9ub2RlOw0KPiA+ICtpbnQgcmlzY3ZfcmVh
ZF9jaGVja19pc2Eoc3RydWN0IGRldmljZV9ub2RlICpub2RlLCBjb25zdCBjaGFyDQo+ID4gKipp
c2EpOw0KPiA+ICBpbnQgcmlzY3Zfb2ZfcHJvY2Vzc29yX2hhcnRpZChzdHJ1Y3QgZGV2aWNlX25v
ZGUgKm5vZGUpOw0KPiA+ICANCj4gPiAgZXh0ZXJuIHZvaWQgcmlzY3ZfZmlsbF9od2NhcCh2b2lk
KTsNCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9rZXJuZWwvY3B1LmMgYi9hcmNoL3Jpc2N2
L2tlcm5lbC9jcHUuYw0KPiA+IGluZGV4IDQwYTNjNDQyYWM1Zi4uNmJkNGM3MTc2YmY2IDEwMDY0
NA0KPiA+IC0tLSBhL2FyY2gvcmlzY3Yva2VybmVsL2NwdS5jDQo+ID4gKysrIGIvYXJjaC9yaXNj
di9rZXJuZWwvY3B1LmMNCj4gPiBAQCAtOCwxMyArOCw0MyBAQA0KPiA+ICAjaW5jbHVkZSA8bGlu
dXgvb2YuaD4NCj4gPiAgI2luY2x1ZGUgPGFzbS9zbXAuaD4NCj4gPiAgDQo+ID4gK2ludCByaXNj
dl9yZWFkX2NoZWNrX2lzYShzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUsIGNvbnN0IGNoYXINCj4g
PiAqKmlzYSkNCj4gPiArew0KPiA+ICsJdTMyIGhhcnQ7DQo+ID4gKw0KPiA+ICsJaWYgKG9mX3By
b3BlcnR5X3JlYWRfdTMyKG5vZGUsICJyZWciLCAmaGFydCkpIHsNCj4gPiArCQlwcl93YXJuKCJG
b3VuZCBDUFUgd2l0aG91dCBoYXJ0IElEXG4iKTsNCj4gPiArCQlyZXR1cm4gLUVOT0RFVjsNCj4g
PiArCX0NCj4gPiArDQo+ID4gKwlpZiAob2ZfcHJvcGVydHlfcmVhZF9zdHJpbmcobm9kZSwgInJp
c2N2LGlzYSIsIGlzYSkpIHsNCj4gPiArCQlwcl93YXJuKCJDUFUgd2l0aCBoYXJ0aWQ9JWQgaGFz
IG5vIFwicmlzY3YsaXNhXCINCj4gPiBwcm9wZXJ0eVxuIiwNCj4gPiArCQkJaGFydCk7DQo+ID4g
KwkJcmV0dXJuIC1FTk9ERVY7DQo+ID4gKwl9DQo+ID4gKwkvKg0KPiA+ICsJICogTGludXggZG9l
c24ndCBzdXBwb3J0IHJ2MzJlIG9yIHJ2MTI4aSwgYW5kIHdlIG9ubHkgc3VwcG9ydA0KPiA+IGJv
b3RpbmcNCj4gPiArCSAqIGtlcm5lbHMgb24gaGFydHMgd2l0aCB0aGUgc2FtZSBJU0EgdGhhdCB0
aGUga2VybmVsIGlzDQo+ID4gY29tcGlsZWQgZm9yLg0KPiA+ICsJICovDQo+ID4gKwlpZiAoSVNf
RU5BQkxFRChDT05GSUdfMzJCSVQpICYmIChzdHJuY21wKCppc2EsICJydjMyaSIsIDUpICE9DQo+
ID4gMCkpIHsNCj4gPiArCQlwcl93YXJuKCJoYXJ0aWQ9JWQgaGFzIGFuIGludmFsaWQgSVNBIFwi
JXNcIiBmb3IgMzJiaXQNCj4gPiBjb25maWdcbiIsDQo+ID4gKwkJCWhhcnQsICppc2EpOw0KPiA+
ICsJCXJldHVybiAtRU5PREVWOw0KPiA+ICsJfSBlbHNlIGlmIChJU19FTkFCTEVEKENPTkZJR182
NEJJVCkgJiYNCj4gPiArCQkgIChzdHJuY21wKCppc2EsICJydjY0aSIsIDUpICE9IDApKSB7DQo+
ID4gKwkJcHJfd2FybigiaGFydGlkPSVkIGhhcyBhbiBpbnZhbGlkIElTQSBcIiVzXCIgZm9yIDY0
Yml0DQo+ID4gY29uZmlnXG4iLA0KPiA+ICsJCQloYXJ0LCAqaXNhKTsNCj4gPiArCQlyZXR1cm4g
LUVOT0RFVjsNCj4gPiArCX0NCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICAv
Kg0KPiA+ICAgKiBSZXR1cm5zIHRoZSBoYXJ0IElEIG9mIHRoZSBnaXZlbiBkZXZpY2UgdHJlZSBu
b2RlLCBvciAtRU5PREVWDQo+ID4gaWYgdGhlIG5vZGUNCj4gPiAgICogaXNuJ3QgYW4gZW5hYmxl
ZCBhbmQgdmFsaWQgUklTQy1WIGhhcnQgbm9kZS4NCj4gPiAgICovDQo+ID4gIGludCByaXNjdl9v
Zl9wcm9jZXNzb3JfaGFydGlkKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZSkNCj4gPiAgew0KPiA+
IC0JY29uc3QgY2hhciAqaXNhOw0KPiA+ICAJdTMyIGhhcnQ7DQo+ID4gIA0KPiA+ICAJaWYgKCFv
Zl9kZXZpY2VfaXNfY29tcGF0aWJsZShub2RlLCAicmlzY3YiKSkgew0KPiA+IEBAIC0zMiwxNSAr
NjIsNiBAQCBpbnQgcmlzY3Zfb2ZfcHJvY2Vzc29yX2hhcnRpZChzdHJ1Y3QgZGV2aWNlX25vZGUN
Cj4gPiAqbm9kZSkNCj4gPiAgCQlyZXR1cm4gLUVOT0RFVjsNCj4gPiAgCX0NCj4gPiAgDQo+ID4g
LQlpZiAob2ZfcHJvcGVydHlfcmVhZF9zdHJpbmcobm9kZSwgInJpc2N2LGlzYSIsICZpc2EpKSB7
DQo+ID4gLQkJcHJfd2FybigiQ1BVIHdpdGggaGFydGlkPSVkIGhhcyBubyBcInJpc2N2LGlzYVwi
DQo+ID4gcHJvcGVydHlcbiIsIGhhcnQpOw0KPiA+IC0JCXJldHVybiAtRU5PREVWOw0KPiA+IC0J
fQ0KPiA+IC0JaWYgKGlzYVswXSAhPSAncicgfHwgaXNhWzFdICE9ICd2Jykgew0KPiA+IC0JCXBy
X3dhcm4oIkNQVSB3aXRoIGhhcnRpZD0lZCBoYXMgYW4gaW52YWxpZCBJU0Egb2YNCj4gPiBcIiVz
XCJcbiIsIGhhcnQsIGlzYSk7DQo+ID4gLQkJcmV0dXJuIC1FTk9ERVY7DQo+ID4gLQl9DQo+ID4g
LQ0KPiA+ICAJcmV0dXJuIGhhcnQ7DQo+ID4gIH0NCj4gPiAgDQo+ID4gZGlmZiAtLWdpdCBhL2Fy
Y2gvcmlzY3Yva2VybmVsL2NwdWZlYXR1cmUuYw0KPiA+IGIvYXJjaC9yaXNjdi9rZXJuZWwvY3B1
ZmVhdHVyZS5jDQo+ID4gaW5kZXggYjFhZGU5YTQ5MzQ3Li5lYWFkNWFhMDc0MDMgMTAwNjQ0DQo+
ID4gLS0tIGEvYXJjaC9yaXNjdi9rZXJuZWwvY3B1ZmVhdHVyZS5jDQo+ID4gKysrIGIvYXJjaC9y
aXNjdi9rZXJuZWwvY3B1ZmVhdHVyZS5jDQo+ID4gQEAgLTM4LDEwICszOCw4IEBAIHZvaWQgcmlz
Y3ZfZmlsbF9od2NhcCh2b2lkKQ0KPiA+ICAJCWlmIChyaXNjdl9vZl9wcm9jZXNzb3JfaGFydGlk
KG5vZGUpIDwgMCkNCj4gPiAgCQkJY29udGludWU7DQo+ID4gIA0KPiA+IC0JCWlmIChvZl9wcm9w
ZXJ0eV9yZWFkX3N0cmluZyhub2RlLCAicmlzY3YsaXNhIiwgJmlzYSkpIHsNCj4gPiAtCQkJcHJf
d2FybigiVW5hYmxlIHRvIGZpbmQgXCJyaXNjdixpc2FcIg0KPiA+IGRldmljZXRyZWUgZW50cnlc
biIpOw0KPiA+ICsJCWlmIChyaXNjdl9yZWFkX2NoZWNrX2lzYShub2RlLCAmaXNhKSA8IDApDQo+
ID4gIAkJCWNvbnRpbnVlOw0KPiA+IC0JCX0NCj4gPiAgDQo+ID4gIAkJZm9yIChpID0gMDsgaSA8
IHN0cmxlbihpc2EpOyArK2kpDQo+ID4gIAkJCXRoaXNfaHdjYXAgfD0gaXNhMmh3Y2FwWyh1bnNp
Z25lZA0KPiA+IGNoYXIpKGlzYVtpXSldOw0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2tl
cm5lbC9zbXBib290LmMNCj4gPiBiL2FyY2gvcmlzY3Yva2VybmVsL3NtcGJvb3QuYw0KPiA+IGlu
ZGV4IDE4YWU2ZGE1MTE1ZS4uMTVlZTcxMjk3YWJmIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvcmlz
Y3Yva2VybmVsL3NtcGJvb3QuYw0KPiA+ICsrKyBiL2FyY2gvcmlzY3Yva2VybmVsL3NtcGJvb3Qu
Yw0KPiA+IEBAIC02MCwxMiArNjAsMTYgQEAgdm9pZCBfX2luaXQgc2V0dXBfc21wKHZvaWQpDQo+
ID4gIAlpbnQgaGFydDsNCj4gPiAgCWJvb2wgZm91bmRfYm9vdF9jcHUgPSBmYWxzZTsNCj4gPiAg
CWludCBjcHVpZCA9IDE7DQo+ID4gKwljb25zdCBjaGFyICppc2E7DQo+ID4gIA0KPiA+ICAJZm9y
X2VhY2hfb2ZfY3B1X25vZGUoZG4pIHsNCj4gPiAgCQloYXJ0ID0gcmlzY3Zfb2ZfcHJvY2Vzc29y
X2hhcnRpZChkbik7DQo+ID4gIAkJaWYgKGhhcnQgPCAwKQ0KPiA+ICAJCQljb250aW51ZTsNCj4g
PiAgDQo+ID4gKwkJaWYgKHJpc2N2X3JlYWRfY2hlY2tfaXNhKGRuLCAmaXNhKSA8IDApDQo+ID4g
KwkJCWNvbnRpbnVlOw0KPiA+ICsNCj4gPiAgCQlpZiAoaGFydCA9PSBjcHVpZF90b19oYXJ0aWRf
bWFwKDApKSB7DQo+ID4gIAkJCUJVR19PTihmb3VuZF9ib290X2NwdSk7DQo+ID4gIAkJCWZvdW5k
X2Jvb3RfY3B1ID0gMTsNCj4gPiAtLSANCj4gPiAyLjIxLjANCj4gPiANCj4gPiANCj4gDQo+IC0g
UGF1bA0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18NCj4gbGludXgtcmlzY3YgbWFpbGluZyBsaXN0DQo+IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJh
ZGVhZC5vcmcNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1yaXNjdg0KDQotLSANClJlZ2FyZHMsDQpBdGlzaA0K
