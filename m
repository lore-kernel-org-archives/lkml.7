Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB05CC4CECB
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 11:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89A42067D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 11:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="rHaL8KzJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731425AbfILL2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 07:28:20 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:5215 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731209AbfILL2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 07:28:18 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 0aMsjrkhRmOEsqOEo6VQRljS3wYjxSGCIfonEs1oTcY3L9sYbOPsZQtjtlk0697voh5BcHKDZi
 gDb9AfM53v4qHg6cLGvcr/9qE7sYjobapEUau6RUwPPBsoIt9QJjcjeXjgmwyIyUQNtHIqyCEf
 kJpBx9/ENOIzOJPMt5SG57W53ExgVMvMpvVCbCfx1ryBBrNvMI+h3hbfzQ6EyfFsA/9fAnr405
 j1Ep2L4MR5MpK6Nt5U+53g3yZ+0Iivvqus5xlgxmTe4NITVZBMPpOBXCzbnCOyytHn50Oy3jIy
 Rdo=
X-IronPort-AV: E=Sophos;i="5.64,495,1559545200"; 
   d="scan'208";a="45911495"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Sep 2019 04:28:10 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 12 Sep 2019 04:28:03 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 12 Sep 2019 04:28:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nldYeHXQU1hzeZ0pNLDYTRxZF3sxtaI/xWWCQfyeGoTuLvD/S94ouBZ52pfSPdO3aAeL1oianGNXUV156UOK2qMpLeqEWePYWtE1vj/1u41oPCGoWgrxbs6ydaqy//oFuRcD9a4mfiRRYXDfQattvViN224/P3PsyNlYxAVKIy38k+88H4C8HsMWaV/N8sEBANHxf4NvjBu9rO2xnHB5NZ+/CPnBdQXTAv49DSFZ1JFXF4hVdnE5qwPi4c3uH1drGph49RJoitvp0zAXSmzfZ1VqQYpuKr9SxItbIcorthIKbnFAe04Ypl3NypEU3inZovQCMlfb6Safbt0Mtzzguw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SikDPOhLa8tGXW00dhauu18ANaTEp8htUxr5fHSTJVM=;
 b=Yy+rvwODkpKJXfcxCT0z5KLMAnvo7mxAu4sxcRRxnM7aEmgoOAIoi+l6tQxN4XB/U4IEfrAFTZkNior4B/JpXHyeD/nEMMPIeaSZ/9mKwct2ncPJIMIpu28Ers4OH71FqQ8IKI2lfaW752Yptc1C9Z9ugoCWA1D5/eOLvZFBfWOauN8jsPAMKXBl4IVNU0RdOTAjW59uK01NDSjRp6fnmV25IiGhrjdQD2ZdomNY/tvX2dLdnc0lCvmhycLC1PRAN4E3CFh2sIuD1EHSRvSNW7hNbbkBtufWuhb8Uxc7svm2ervZZmTOFxHmcqeSIOYsq7/Lr4vcaySbZhPzpg2kzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SikDPOhLa8tGXW00dhauu18ANaTEp8htUxr5fHSTJVM=;
 b=rHaL8KzJhabd03orwulCBj0Fd/tijAfSCVAah18ihaU5dlHO8KVtuSHD2uWz2n4CH8lQV0P1WBSB3fZ/vvieXCeXHCHFRzaMlqjDAhJqQXO8hyYmHHpv5/nnUARPVr7c/Yh0+XQ9437UZ3pTK1JgSxD/Bp1nXBMnS5hFCzVjgj4=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1417.namprd11.prod.outlook.com (10.168.103.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.20; Thu, 12 Sep 2019 11:28:00 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::a141:1974:9668:fbe2]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::a141:1974:9668:fbe2%12]) with mapi id 15.20.2241.022; Thu, 12 Sep
 2019 11:28:00 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <ada@thorsis.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <alexandre.belloni@bootlin.com>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: at91: allow 24 Mhz clock as input for PLL
Thread-Topic: [PATCH] clk: at91: allow 24 Mhz clock as input for PLL
Thread-Index: AQHVaGukjPTRbry/ckGMFC3Lf3IeQKcn414AgAAEhwA=
Date:   Thu, 12 Sep 2019 11:28:00 +0000
Message-ID: <a208cec2-7aa6-e6e8-e6e0-f37769273d5d@microchip.com>
References: <1568183622-7858-1-git-send-email-eugen.hristev@microchip.com>
 <30755021.BkS3ObC0RA@ada>
In-Reply-To: <30755021.BkS3ObC0RA@ada>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0210.eurprd08.prod.outlook.com
 (2603:10a6:802:15::19) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190912142232678
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0016782-c69f-4fe0-8aeb-08d7377444c0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR11MB1417;
x-ms-traffictypediagnostic: DM5PR11MB1417:
x-microsoft-antispam-prvs: <DM5PR11MB14174BFE3DF053FD47EE4635E8B00@DM5PR11MB1417.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(346002)(366004)(376002)(189003)(199004)(229853002)(6486002)(71190400001)(71200400001)(8936002)(6436002)(81166006)(81156014)(8676002)(7736002)(305945005)(102836004)(386003)(6506007)(11346002)(26005)(316002)(53546011)(99286004)(5660300002)(66066001)(476003)(2616005)(31686004)(486006)(76176011)(186003)(446003)(52116002)(14444005)(66946007)(256004)(66476007)(66556008)(66446008)(64756008)(6116002)(2501003)(4326008)(3846002)(86362001)(54906003)(36756003)(478600001)(14454004)(53936002)(2906002)(6512007)(6246003)(110136005)(31696002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1417;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4EqnHdqYr5JyYvWkmA9ZpIc3r1e+QgDnUXtn8otmdIIvxK+jJA+aJZrbTJgntkut8ks/VQSEh3O1Be7ylanW1LLpHz6LKMkMmYK1pIufKTj7de36VvSelYl71zg0C58P2vIjqbOo3R9PhJpbzFEcRdOkY0kJnv1TNnShc5gpi3upPVKorYm5xG3fdRPEFpat1lYu5Aw6F4ZvFY5uVjZu9isHoAqmRkl6j0zZiXiyCSV9QsR5e0Tdk8XadeaKuezhFdP98nsctynvUgusx5pZnbkgxseUSsgDBLzRmT0Q8mmwqY8HIv+DPmjNCsyid6Kt5C7ZEGSlu8nkOEnLXz/PLhPc9CrSGK38HnYppHfZ4rrQ9ZtMecTXsODH9HNQPOBJjeVRWhQQ4HjypueFz3QBaQLxJwRHCe1ifnHd0KfU6YQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D44F0FA8B6EE3A46BC1F3C8CCAAB971D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d0016782-c69f-4fe0-8aeb-08d7377444c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 11:28:00.7946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MgiwCBxEuHqE0Gt6qm0M9njoxZQTVDQUzLQZBVEM2l9CaHjBgrad8IvC85erwEA3GI/+wPEjbY2rnEk29rhpZjCBMxdJJuRMbFOmJYEZNZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1417
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEyLjA5LjIwMTkgMTQ6MDYsIEFsZXhhbmRlciBEYWhsIHdyb3RlOg0KDQo+IA0KPiBI
ZWxsbywNCj4gDQo+IG91dCBvZiBjdXJpb3NpdHk6IFRoZSBTQU1BNUQyNy1TT00xLUVLIGJvYXJk
IGhhcyBhIDI0IE1IeiBjcnlzdGFsLCB0aGF0IGlzDQo+IGFsc28gd2hhdCAvc3lzL2tlcm5lbC9k
ZWJ1Zy9jbGsvY2xrX3N1bW1hcnkgc2F5cyBhbmQgdGhlIGJvYXJkIHJ1bnMgd2l0aG91dA0KPiBv
YnZpb3VzIHByb2JsZW1zLiBXaGF0IGlzIHRoaXMgY2hhbmdlIGltcHJvdmluZyBpbiByZWFsIHBy
YWN0aWNlIHRoZW4/DQo+IA0KDQpUaGUgYm9hcmQgd29ya3MsIGJ1dCwgdGhlIGNoYXJhY3Rlcmlz
dGljcyBvZiB0aGUgUExMIGFyZSBpbmNvcnJlY3QuDQpUaGlzIGNhbiBsZWFkIHRvIHVud2FudGVk
IGJlaGF2aW9yLCBsaWtlIGNhbGN1bGF0aW5nIHdyb25nIG1pbmltdW0gDQp2YWx1ZXMgZm9yIG11
bHRpcGxpZXJzLCBvciBvdGhlciBpc3N1ZXMNCg0KSW4gdGhpcyBjb2RlIGhlcmUgaW4gY2xrLXBs
bC5jIGZvciBleGFtcGxlDQoNCmlmIChwYXJlbnRfcmF0ZSA+IGNoYXJhY3RlcmlzdGljcy0+aW5w
dXQubWF4KSB7DQogICAgICAgICAgICAgICAgIHRtcGRpdiA9IERJVl9ST1VORF9VUChwYXJlbnRf
cmF0ZSwgDQpjaGFyYWN0ZXJpc3RpY3MtPmlucHV0Lm1heCk7DQogICAgICAgICAgICAgICAgIGlm
ICh0bXBkaXYgPiBQTExfRElWX01BWCkgDQoNCiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1
cm4gLUVSQU5HRTsgDQoNCiANCg0KICAgICAgICAgICAgICAgICBpZiAodG1wZGl2ID4gbWluZGl2
KSANCg0KICAgICAgICAgICAgICAgICAgICAgICAgIG1pbmRpdiA9IHRtcGRpdjsgDQoNCiAgICAg
ICAgIH0NCg0KVGhlIGRpdmlzb3IgaXMgY2FwcGVkIGJ5IGNoZWNrcywgYnV0IGF0IGFub3RoZXIg
cG9zc2libGUgcmVxdWVzdGVkIA0KcGFyZW50IHJhdGUsIHRoaXMgbWF5IGxlYWQgdG8gc29tZXRo
aW5nIHdyb25nLCBsaWtlIGhlcmUsIHRoZSBtaW5pbXVtIA0KZGl2aXNvciBtaWdodCBiZSBncmVh
dGVyIHRoYW4gd2hhdCBpcyB0aGUgcmVhbCBwb3NzaWJsZSBvbmUuIFNvIGluIHNvbWUgDQpjYXNl
cyBpdCBjYW4gaGFwcGVuIHRoYXQgdW53YW50ZWQgcmVzdWx0cyBvY2N1ci4NCg0KV2UgbWF5IGNv
bnNpZGVyIGF0IHNvbWUgcG9pbnRzIHRvIHJlbHkgb24gdGhlc2UgdmFsdWVzIG1vcmUsIHNvLCBp
dCdzIA0Kb2J2aW91cyB0aGF0IHRoZXkgc2hvdWxkIGJlIGNvcnJlY3QgaW4gdGhlIGNoYXJhY3Rl
cmlzdGljcw0KDQpTbyBzaG9ydCBhbnN3ZXI6IG5vIGltcHJvdmUgaW4geW91ciBjYXNlICwgd2hl
cmUgdGhlIHJhdGVzIHJlcXVpcmVkIGFyZSANCmFyb3VuZCA0OTIgTWh6IGNwdS8xMzIgbWh6IGJ1
cyAoSUlSQyksIGJ1dCB0aGUgY2hhcmFjdGVyaXN0aWNzIG5lZWQgdG8gDQpiZSBjb3JyZWN0IHRv
IGNvdmVyIGFsbCBwb3NzaWJsZSBjYXNlcy4NCg0KRXVnZW4NCg0KDQo+IEdyZWV0cw0KPiBBbGV4
DQo+IA0KPiBBbSBNaXR0d29jaCwgMTEuIFNlcHRlbWJlciAyMDE5LCAwNjozOToyMCBDRVNUIHNj
aHJpZWINCj4gRXVnZW4uSHJpc3RldkBtaWNyb2NoaXAuY29tOg0KPj4gRnJvbTogRXVnZW4gSHJp
c3RldiA8ZXVnZW4uaHJpc3RldkBtaWNyb2NoaXAuY29tPg0KPj4NCj4+IFRoZSBQTEwgaW5wdXQg
cmFuZ2UgbmVlZHMgdG8gYmUgYWJsZSB0byBhbGxvdyAyNCBNaHogY3J5c3RhbCBhcyBpbnB1dA0K
Pj4gVXBkYXRlIHRoZSByYW5nZSBhY2NvcmRpbmdseSBpbiBwbGxhIGNoYXJhY3RlcmlzdGljcyBz
dHJ1Y3QNCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBFdWdlbiBIcmlzdGV2IDxldWdlbi5ocmlzdGV2
QG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9jbGsvYXQ5MS9zYW1hNWQyLmMg
fCAyICstDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9hdDkxL3NhbWE1ZDIuYyBiL2RyaXZl
cnMvY2xrL2F0OTEvc2FtYTVkMi5jDQo+PiBpbmRleCA2NTA5ZDA5Li4wZGUxMTA4IDEwMDY0NA0K
Pj4gLS0tIGEvZHJpdmVycy9jbGsvYXQ5MS9zYW1hNWQyLmMNCj4+ICsrKyBiL2RyaXZlcnMvY2xr
L2F0OTEvc2FtYTVkMi5jDQo+PiBAQCAtMjEsNyArMjEsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IGNsa19yYW5nZSBwbGxhX291dHB1dHNbXSA9IHsNCj4+ICAgfTsNCj4+DQo+PiAgIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgY2xrX3BsbF9jaGFyYWN0ZXJpc3RpY3MgcGxsYV9jaGFyYWN0ZXJpc3RpY3Mg
PSB7DQo+PiAtCS5pbnB1dCA9IHsgLm1pbiA9IDEyMDAwMDAwLCAubWF4ID0gMTIwMDAwMDAgfSwN
Cj4+ICsJLmlucHV0ID0geyAubWluID0gMTIwMDAwMDAsIC5tYXggPSAyNDAwMDAwMCB9LA0KPj4g
ICAJLm51bV9vdXRwdXQgPSBBUlJBWV9TSVpFKHBsbGFfb3V0cHV0cyksDQo+PiAgIAkub3V0cHV0
ID0gcGxsYV9vdXRwdXRzLA0KPj4gICAJLmljcGxsID0gcGxsYV9pY3BsbCwNCj4gDQo+IA0KPiAN
Cj4gDQo=
