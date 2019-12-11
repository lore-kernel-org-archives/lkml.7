Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B990BC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 11:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8314B208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 11:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Z6Jeu9u5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbfLKLz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 06:55:26 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:55717 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbfLKLzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 06:55:25 -0500
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: Xca9Va4L8bZ06TH98A+wzzQJYp4w/1UuCAAQdmLHeopb2tkZnpxALjWAnc6ILkoe3501/TynwX
 whWgtbhj+cM7SgYgh9A8gLjDPlsoyYiGlZodGF2IhLAl+8xEDOzUqUQ8NfhmKZjxrTO6NX3Cri
 L7I/okdKioKPHYoyKLpcOBDnrdhP34SvqERpD5pm082ToOMNVPyS+Ohw6NCgozhjwxMxMJPxRX
 hSClFMJ5GzbxGhHvqGs+t7MYkJgNRCXebs+8x2fZsafKnpSRqnTC/WgIy3Hv6obnWq0/otntL9
 J18=
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600"; 
   d="scan'208";a="59983848"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Dec 2019 04:55:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 11 Dec 2019 04:55:23 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 11 Dec 2019 04:55:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+v7fgsOZqDTH63k/T5WRIpx2On21z+Lk2GrNvxln4FvZtNQwUefxaODsTaZ1GMrmGW0VEV2HW1bgvKc60+tUHGmIrThaCAaqEqMZK/rVbscPom5kZT5ZcJ27BIWvy/vQpmqHj8Nfwhsa/Tsf0YVcoSug1tGleTa/Gfm1Ndz2SLjGebg9qHc0wsl+zKjn4YyV1l2k1mmcSYaLliR8Wj0CHEPgSR+eTUo6/rWY3uIQfpUKF62eZP85w0e+gjiFc2aUOACv3Y9Tv2ap8BrDUAwKjTGdRe6cHJufymaYhhqjh5JtVrritl441MRYx4nDz16uWRNj9NeztwkxnAav2KLRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7bjXlBAyX6EXBKcW3knaX8HA4PAzbyuoW6oX6cclVc=;
 b=SArq66iz2KrJkZYqcakJ2bhb2VDsP2BsIvSGotQNheZ0ZQTH3NpdxSle6VT+Epa/TvS8FBtnmsdWqXqdYC3/qYTLpNNUpk9nDXmWSlMGDDTXT565LZbx9x7Pj6q6go3TmktiMSNUOj2+hgJJCHYrfO/DJqG5gImAGjRGHg476BJkuTWjdc/UgrzCekUJun2whniN7/Hk0kpf/cerK4KGTl/9Gl1oUJ36co3Fyb55Sc5eyuvySF42RbnU0sIfCuxPD+jru8HLeJcAr212otpRDcI0CSY+0SUrSu1p988ED0x4thFH+h2feSTh1++7uaGjEKIAquSsT+22XnxcC34Liw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7bjXlBAyX6EXBKcW3knaX8HA4PAzbyuoW6oX6cclVc=;
 b=Z6Jeu9u5kR8DigXSSsdhU+UpLjpRkoHlAb8u6krteJ5SslDJazfZP/8RjbdQnzVD6dHKXUfDPU8lqaRJMexwT2gcwDxp4mD4LFJ4CupToBz7thjO7pWKK4lTJ6Yj9ZZxnPwIqrmh4DpIrZzzyKHC9mGKVblFbGx2sGmvrqyrLE4=
Received: from DM6PR11MB3225.namprd11.prod.outlook.com (20.176.120.224) by
 DM6PR11MB3625.namprd11.prod.outlook.com (20.178.230.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Wed, 11 Dec 2019 11:55:21 +0000
Received: from DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::ed7d:d06f:7d55:cbe2]) by DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::ed7d:d06f:7d55:cbe2%6]) with mapi id 15.20.2538.012; Wed, 11 Dec 2019
 11:55:21 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <sam@ravnborg.org>
CC:     <bbrezillon@kernel.org>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <lee.jones@linaro.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Sandeep.Sheriker@microchip.com>
Subject: Re: [PATCH 5/5] Revert "drm: atmel-hlcdc: enable sys_clk during
 initalization."
Thread-Topic: [PATCH 5/5] Revert "drm: atmel-hlcdc: enable sys_clk during
 initalization."
Thread-Index: AQHVsBnYQZ15xrGMOEKSh87APGOhBA==
Date:   Wed, 11 Dec 2019 11:55:20 +0000
Message-ID: <67fab980-1371-2658-4b32-b101a248498d@microchip.com>
References: <1575984287-26787-1-git-send-email-claudiu.beznea@microchip.com>
 <1575984287-26787-6-git-send-email-claudiu.beznea@microchip.com>
 <20191210203419.GB24756@ravnborg.org>
In-Reply-To: <20191210203419.GB24756@ravnborg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR01CA0089.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::30) To DM6PR11MB3225.namprd11.prod.outlook.com
 (2603:10b6:5:5b::32)
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191211135513350
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d181a78-47f8-41d8-34db-08d77e30ffa2
x-ms-traffictypediagnostic: DM6PR11MB3625:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3625BEDE354F46DC248DF019875A0@DM6PR11MB3625.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(199004)(189003)(86362001)(52116002)(6486002)(31696002)(36756003)(107886003)(6512007)(4326008)(66946007)(66446008)(71200400001)(66556008)(64756008)(66476007)(54906003)(6916009)(81156014)(81166006)(31686004)(53546011)(5660300002)(6506007)(186003)(26005)(498600001)(2906002)(2616005)(8676002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB3625;H:DM6PR11MB3225.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WHz0Y/NBJZFSam1plUDgw9YLsjynCKdJZgJ6HdBLUFz76jDh1Gi5mqPMAmvuo2TOm1+JFDuDIh1k93jRKjwe8RsTaobT73+/ag+PtPJ7/s32/ThN3DcZrNk3hYmsWmMCOUmX9/XV+ePlDWOpYaumoE59X0oTVRVNfo4Hm5flmpFGF4Nh1BMnPKLqChH/6l/WViKkiHzlgfcxAZDAr4IuWgQxZbx8MUnWMRSIF6pWLVvshHdRfAzKJnYk/A6OMyFKEoc0a0Ty4OZZg6d4qup9AmCXbaUbjLsHfAXvx0HzgtX/nFyXuexevYFwaRrDLwMyhIwYhSuCLvpwzvRz7MuvgN6mR3V5qqzYl6StwkjeMAdpVVSlrTkY2J1RxV39/ntNbucG7Ev8F1TP9HgJnPYY2Hxz6Wc2lVJkgdixq+CZQomQ+bVs+G6cwHFvaYzJlQxG
Content-Type: text/plain; charset="utf-8"
Content-ID: <675EA5625499E548A9C443A2306EB68C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d181a78-47f8-41d8-34db-08d77e30ffa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 11:55:20.9624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IEFXlJz3PuG0G4Kk1E589xrQzWzhPrSDfrLI0s304muV/UF1abvWkTFWL/0O3ViSDToyZNoxUYXOLcTq0/vcfHK5/1C1GV25T3+mgHzWy2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3625
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLjEyLjIwMTkgMjI6MzQsIFNhbSBSYXZuYm9yZyB3cm90ZToNCj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBIaSBDbGFkaXUNCj4gDQo+IE9uIFR1ZSwg
RGVjIDEwLCAyMDE5IGF0IDAzOjI0OjQ3UE0gKzAyMDAsIENsYXVkaXUgQmV6bmVhIHdyb3RlOg0K
Pj4gVGhpcyByZXZlcnRzIGNvbW1pdCBkMmM3NTVlNjY2MTc2MjBiNzI5MDQxYzYyNWE2Mzk2Yzgx
ZDEyMzFjLg0KPj4gKCJkcm06IGF0bWVsLWhsY2RjOiBlbmFibGUgc3lzX2NsayBkdXJpbmcgaW5p
dGFsaXphdGlvbi4iKS4gV2l0aA0KPj4gY29tbWl0ICJkcm06IGF0bWVsLWhsY2RjOiBlbmFibGUg
Y2xvY2sgYmVmb3JlIGNvbmZpZ3VyaW5nIHRpbWluZyBlbmdpbmUiDQo+PiB0aGVyZSBpcyBubyBu
ZWVkIGZvciB0aGlzIHBhdGNoLiBDb2RlIGlzIGFsc28gc2ltcGxlci4NCj4+DQo+PiBDYzogU2Fu
ZGVlcCBTaGVyaWtlciBNYWxsaWthcmp1biA8c2FuZGVlcHNoZXJpa2VyLm1hbGxpa2FyanVuQG1p
Y3JvY2hpcC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5i
ZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4gDQo+IEdldHRpbmcgZnVydGhlciBpbiB0aGUgcGF0Y2hl
cyB0ZWxscyBtZSB5b3UgbG9va2VkIGF0IHRoZQ0KPiBwYXRjaCBJIHJlZmVyZW5jZWQgaW4gcHJl
dmlvdXMgbWFpbC4NCj4gUGxlYXNlIHNxdWFzaCB0aGUgdHdvIHBhdGNoZXMgdG9nZXRoZXIgLSB0
aGF0IHdvdWxkIG1ha2UgaXQNCj4gZWFzaWVyIHRvIGZvbGxvdyB3aGF0IGlzIGRvbmUuDQoNCldv
dWxkbid0IHRoaXMgbGVhZCB0byBhIHBhdGNoIGRvaW5nIDIgdGhpbmdzPw0KMS8gZml4IHRoZSB0
aW1lb3V0IG9mIHRoZSB0aW1pbmcgZW5naW5lIGFmdGVyIHNldHRpbmcgcGl4ZWwgY2xvY2sgd2hp
Y2ggaXMNCiAgIGZyb20gdGhlIGJlZ2lubmluZyBvZiB0aGUgZHJpdmVyIGFuZCBoYXMgbm90aGlu
ZyB0byBkbyB3aXRoIHBhdGNoDQogICByZXZlcnRlZCBoZXJlIChidXQsIGFjdHVhbGx5IHdlIHdv
dWxkbid0IGhhZCByZWFjaCB0aGUgcG9pbnQgb2YNCiAgIGludHJvZHVjaW5nIHRoZSBwYXRjaCBy
ZXZlcnRlZCBoZXJlIHdpdGggdGhhdCBmaXgpDQoyLyByZXZlcnQgYSBwcmV2aW91cyBmdW5jdGlv
bmFsaXR5IGFzIGEgcmVzdWx0IG9mIGZpeGluZyB0aGUgdGltZW91dC4NCg0KV2l0aCB0aGlzIGlu
IG1pbmQgd291bGQgeW91IHN0aWxsIHdhbnQgdG8gc3F1YXNoIHRoZW0/DQoNClRoYW5rIHlvdSwN
CkNsYXVkaXUgQmV6bmVhDQoNCj4gDQo+IFdpdGggdGhlIHR3byBwYXRjaGVzIGFwcGxpZWQgc3lz
Y2xrIGlzIGVuYWJsZWQgb25seSBpbiBtb2RlX3NldF9ub2ZiKCkNCj4gYW5kIGF0b21pY19lbmFi
bGUoKS4gQW5kIGRpc2FibGVkIGluIGF0b21pY19kaXNhYmxlKCkuDQo+IFRoaXMgaXMgc2ltcGxl
ciBhbmQgd2UgZHJvcCB0aGUgY29uZGl0aW9uYWxzLiBBbHNvIGdvb2QuDQo+IFNvIHRoZSBlbmQg
cmVzdWx0IGxvb2tzIE9LLg0KPiANCj4gICAgICAgICBTYW0NCj4gDQo+PiAtLS0NCj4+ICBkcml2
ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxjZGNfZGMuYyB8IDE5ICstLS0tLS0tLS0t
LS0tLS0tLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDE4IGRlbGV0aW9u
cygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMvYXRt
ZWxfaGxjZGNfZGMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hdG1lbC1obGNkYy9hdG1lbF9obGNkY19k
Yy5jDQo+PiBpbmRleCA4ZGM5MTdhMTI3MGIuLjExMmFhNTA2NmNlZSAxMDA2NDQNCj4+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hdG1lbC1obGNkYy9hdG1lbF9obGNkY19kYy5jDQo+PiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxjZGNfZGMuYw0KPj4gQEAgLTcyMSwx
OCArNzIxLDEwIEBAIHN0YXRpYyBpbnQgYXRtZWxfaGxjZGNfZGNfbG9hZChzdHJ1Y3QgZHJtX2Rl
dmljZSAqZGV2KQ0KPj4gICAgICAgZGMtPmhsY2RjID0gZGV2X2dldF9kcnZkYXRhKGRldi0+ZGV2
LT5wYXJlbnQpOw0KPj4gICAgICAgZGV2LT5kZXZfcHJpdmF0ZSA9IGRjOw0KPj4NCj4+IC0gICAg
IGlmIChkYy0+ZGVzYy0+Zml4ZWRfY2xrc3JjKSB7DQo+PiAtICAgICAgICAgICAgIHJldCA9IGNs
a19wcmVwYXJlX2VuYWJsZShkYy0+aGxjZGMtPnN5c19jbGspOw0KPj4gLSAgICAgICAgICAgICBp
ZiAocmV0KSB7DQo+PiAtICAgICAgICAgICAgICAgICAgICAgZGV2X2VycihkZXYtPmRldiwgImZh
aWxlZCB0byBlbmFibGUgc3lzX2Nsa1xuIik7DQo+PiAtICAgICAgICAgICAgICAgICAgICAgZ290
byBlcnJfZGVzdHJveV93cTsNCj4+IC0gICAgICAgICAgICAgfQ0KPj4gLSAgICAgfQ0KPj4gLQ0K
Pj4gICAgICAgcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGRjLT5obGNkYy0+cGVyaXBoX2Nsayk7
DQo+PiAgICAgICBpZiAocmV0KSB7DQo+PiAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LT5kZXYs
ICJmYWlsZWQgdG8gZW5hYmxlIHBlcmlwaF9jbGtcbiIpOw0KPj4gLSAgICAgICAgICAgICBnb3Rv
IGVycl9zeXNfY2xrX2Rpc2FibGU7DQo+PiArICAgICAgICAgICAgIGdvdG8gZXJyX2Rlc3Ryb3lf
d3E7DQo+PiAgICAgICB9DQo+Pg0KPj4gICAgICAgcG1fcnVudGltZV9lbmFibGUoZGV2LT5kZXYp
Ow0KPj4gQEAgLTc2OCw5ICs3NjAsNiBAQCBzdGF0aWMgaW50IGF0bWVsX2hsY2RjX2RjX2xvYWQo
c3RydWN0IGRybV9kZXZpY2UgKmRldikNCj4+ICBlcnJfcGVyaXBoX2Nsa19kaXNhYmxlOg0KPj4g
ICAgICAgcG1fcnVudGltZV9kaXNhYmxlKGRldi0+ZGV2KTsNCj4+ICAgICAgIGNsa19kaXNhYmxl
X3VucHJlcGFyZShkYy0+aGxjZGMtPnBlcmlwaF9jbGspOw0KPj4gLWVycl9zeXNfY2xrX2Rpc2Fi
bGU6DQo+PiAtICAgICBpZiAoZGMtPmRlc2MtPmZpeGVkX2Nsa3NyYykNCj4+IC0gICAgICAgICAg
ICAgY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGRjLT5obGNkYy0+c3lzX2Nsayk7DQo+Pg0KPj4gIGVy
cl9kZXN0cm95X3dxOg0KPj4gICAgICAgZGVzdHJveV93b3JrcXVldWUoZGMtPndxKTsNCj4+IEBA
IC03OTUsOCArNzg0LDYgQEAgc3RhdGljIHZvaWQgYXRtZWxfaGxjZGNfZGNfdW5sb2FkKHN0cnVj
dCBkcm1fZGV2aWNlICpkZXYpDQo+Pg0KPj4gICAgICAgcG1fcnVudGltZV9kaXNhYmxlKGRldi0+
ZGV2KTsNCj4+ICAgICAgIGNsa19kaXNhYmxlX3VucHJlcGFyZShkYy0+aGxjZGMtPnBlcmlwaF9j
bGspOw0KPj4gLSAgICAgaWYgKGRjLT5kZXNjLT5maXhlZF9jbGtzcmMpDQo+PiAtICAgICAgICAg
ICAgIGNsa19kaXNhYmxlX3VucHJlcGFyZShkYy0+aGxjZGMtPnN5c19jbGspOw0KPj4gICAgICAg
ZGVzdHJveV93b3JrcXVldWUoZGMtPndxKTsNCj4+ICB9DQo+Pg0KPj4gQEAgLTkxMCw4ICs4OTcs
NiBAQCBzdGF0aWMgaW50IGF0bWVsX2hsY2RjX2RjX2RybV9zdXNwZW5kKHN0cnVjdCBkZXZpY2Ug
KmRldikNCj4+ICAgICAgIHJlZ21hcF9yZWFkKHJlZ21hcCwgQVRNRUxfSExDRENfSU1SLCAmZGMt
PnN1c3BlbmQuaW1yKTsNCj4+ICAgICAgIHJlZ21hcF93cml0ZShyZWdtYXAsIEFUTUVMX0hMQ0RD
X0lEUiwgZGMtPnN1c3BlbmQuaW1yKTsNCj4+ICAgICAgIGNsa19kaXNhYmxlX3VucHJlcGFyZShk
Yy0+aGxjZGMtPnBlcmlwaF9jbGspOw0KPj4gLSAgICAgaWYgKGRjLT5kZXNjLT5maXhlZF9jbGtz
cmMpDQo+PiAtICAgICAgICAgICAgIGNsa19kaXNhYmxlX3VucHJlcGFyZShkYy0+aGxjZGMtPnN5
c19jbGspOw0KPj4NCj4+ICAgICAgIHJldHVybiAwOw0KPj4gIH0NCj4+IEBAIC05MjEsOCArOTA2
LDYgQEAgc3RhdGljIGludCBhdG1lbF9obGNkY19kY19kcm1fcmVzdW1lKHN0cnVjdCBkZXZpY2Ug
KmRldikNCj4+ICAgICAgIHN0cnVjdCBkcm1fZGV2aWNlICpkcm1fZGV2ID0gZGV2X2dldF9kcnZk
YXRhKGRldik7DQo+PiAgICAgICBzdHJ1Y3QgYXRtZWxfaGxjZGNfZGMgKmRjID0gZHJtX2Rldi0+
ZGV2X3ByaXZhdGU7DQo+Pg0KPj4gLSAgICAgaWYgKGRjLT5kZXNjLT5maXhlZF9jbGtzcmMpDQo+
PiAtICAgICAgICAgICAgIGNsa19wcmVwYXJlX2VuYWJsZShkYy0+aGxjZGMtPnN5c19jbGspOw0K
Pj4gICAgICAgY2xrX3ByZXBhcmVfZW5hYmxlKGRjLT5obGNkYy0+cGVyaXBoX2Nsayk7DQo+PiAg
ICAgICByZWdtYXBfd3JpdGUoZGMtPmhsY2RjLT5yZWdtYXAsIEFUTUVMX0hMQ0RDX0lFUiwgZGMt
PnN1c3BlbmQuaW1yKTsNCj4+DQo+PiAtLQ0KPj4gMi43LjQNCj4gDQo=
