Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32865C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFCE62084B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="2Tv9Xk4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbfFRJKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 05:10:31 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:12816 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbfFRJKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 05:10:31 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,388,1557212400"; 
   d="scan'208";a="36289472"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Jun 2019 02:10:30 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex04.mchp-main.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 18 Jun 2019 02:10:26 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 18 Jun 2019 02:10:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCJ7UjcLdGTOJxl2Ic/6pe3UiUCoa+Tx0rGHCExjeyo=;
 b=2Tv9Xk4SkWto4IJEpdrrXDV18DTVJ5W4I1PAS+L81MdRwJ6EYjWOSUxhqPn9UBsB41AXyAt6hFwnKJ3v+OtEiCUmMPzXHNtYhVYqU3/yLDgGOMAhwY12Z6bfnlWYr91XWMMhivEhb+haBnTAlpiUm2QxwZgBn4I54FHNueoJt9Y=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB0019.namprd11.prod.outlook.com (10.161.155.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Tue, 18 Jun 2019 09:10:25 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::e581:f807:acdc:cb36]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::e581:f807:acdc:cb36%9]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 09:10:25 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <dinguyen@kernel.org>, <robh@kernel.org>
CC:     <linux-mtd@lists.infradead.org>, <marex@denx.de>,
        <bbrezillon@kernel.org>, <linux-kernel@vger.kernel.org>,
        <computersforpeace@gmail.com>, <dwmw2@infradead.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCHv6 1/2] dt-bindings: cadence-quadspi: add options reset
 property
Thread-Topic: [PATCHv6 1/2] dt-bindings: cadence-quadspi: add options reset
 property
Thread-Index: AQHVIdusqBYcLDcbq02njfD9Z3kc16ahJ4oA
Date:   Tue, 18 Jun 2019 09:10:24 +0000
Message-ID: <40d77b71-efdd-08e6-3d66-743ab0623906@microchip.com>
References: <20190613113138.8280-1-dinguyen@kernel.org>
In-Reply-To: <20190613113138.8280-1-dinguyen@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0602CA0020.eurprd06.prod.outlook.com
 (2603:10a6:800:bc::30) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80031b57-9825-42cf-990f-08d6f3cccc2f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB0019;
x-ms-traffictypediagnostic: BN6PR11MB0019:
x-microsoft-antispam-prvs: <BN6PR11MB0019D3F6A892EA381E5BA4BBF0EA0@BN6PR11MB0019.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39860400002)(376002)(346002)(199004)(189003)(102836004)(14454004)(256004)(14444005)(305945005)(316002)(72206003)(478600001)(73956011)(386003)(66946007)(6506007)(76176011)(66476007)(66446008)(66556008)(7736002)(25786009)(4326008)(186003)(5660300002)(36756003)(26005)(64756008)(110136005)(54906003)(53546011)(31686004)(6512007)(86362001)(486006)(6246003)(8676002)(6116002)(446003)(11346002)(476003)(2501003)(2616005)(52116002)(8936002)(3846002)(81156014)(81166006)(71190400001)(71200400001)(66066001)(68736007)(229853002)(31696002)(2906002)(53936002)(6436002)(99286004)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB0019;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /2p8k4z2ke/Asrh0RW8F1om2H7H4t18CC89U4MYPG6jZFajhPGmvCA5iQUQA25N0DNhVzZvs6kD3tPhlyXkXjVamao7ha0yfAvnhIRHm7z/jJtMljDn7wWHsjHMXQUabfeFlZiSMOX8hR9/xl8N1QQKmJ4OQ9MdDA4xQkR5yD2u18I9MnhImcerbjg+7GS7+v9EyyAnpBKVX4KDQyVsDviDtkBVosLBzufDnkANZiFS9ZROp3N8Q90VpWWoWQOvjcmwcikBtHYTKBzh/JIUOjOu+WaPA4o8jKO2csoDeMrZAzRtT+N3JWArZH1G3u0N40q8+Dnyysu+d8OA+Pub2QJ6KRx+Bzq85FsuyyXbBJf3bi3SYiTg+uL1NXLVbZiColSiivZwdP8mfOVp08W8WBbwbv4VeTU9OjE75eD98nL8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1498D07C711E3A46BBAE89F1988EAF56@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 80031b57-9825-42cf-990f-08d6f3cccc2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 09:10:24.8496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0019
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

K1JvYiwgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCg0KSGksIFJvYiwNCg0KRGluaCBmb3Jn
b3QgdG8gc2VuZCB0aGlzIHRvIHRoZSBkZXZpY2UgdHJlZSBtYWlsaW5nIGxpc3QuIFdvdWxkIHlv
dSBwbGVhc2UNCnJldmlldyBpdD8NCg0KVGhhbmtzLA0KdGENCg0KT24gMDYvMTMvMjAxOSAwMjoz
MSBQTSwgRGluaCBOZ3V5ZW4gd3JvdGU6DQo+IEV4dGVybmFsIEUtTWFpbA0KPiANCj4gDQo+IFRo
ZSBRU1BJIG1vZHVsZSBjYW4gaGF2ZSBhbiBvcHRpb25hbCByZXNldCBzaWduYWxzIHRoYXQgd2ls
bCBob2xkIHRoZQ0KPiBtb2R1bGUgaW4gYSByZXNldCBzdGF0ZS4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IERpbmggTmd1eWVuIDxkaW5ndXllbkBrZXJuZWwub3JnPg0KPiAtLS0NCj4gdjY6IG5vIGNo
YW5nZQ0KPiB2NTogZG9jdW1lbnQgcmVzZXQtbmFtZXMNCj4gdjQ6IG5vIGNoYW5nZQ0KPiB2Mzog
Y3JlYXRlZCBiYXNlIG9uIHJldmlldyBjb21tZW50cw0KPiB2MjogZGlkIG5vdCBleGlzdA0KPiB2
MTogZGlkIG5vdCBleGlzdA0KPiAtLS0NCj4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9tdGQvY2FkZW5jZS1xdWFkc3BpLnR4dCB8IDUgKysrKysNCj4gIDEgZmlsZSBjaGFuZ2Vk
LCA1IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbXRkL2NhZGVuY2UtcXVhZHNwaS50eHQgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbXRkL2NhZGVuY2UtcXVhZHNwaS50eHQNCj4gaW5kZXggNDM0NWMz
YTZmNTMwLi45NDViZTdkNWIyMzYgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9tdGQvY2FkZW5jZS1xdWFkc3BpLnR4dA0KPiArKysgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbXRkL2NhZGVuY2UtcXVhZHNwaS50eHQNCj4gQEAgLTM1
LDYgKzM1LDkgQEAgY3VzdG9tIHByb3BlcnRpZXM6DQo+ICAJCSAgKHFzcGlfbl9zc19vdXQpLg0K
PiAgLSBjZG5zLHRzbGNoLW5zIDogRGVsYXkgaW4gbmFub3NlY29uZHMgYmV0d2VlbiBzZXR0aW5n
IHFzcGlfbl9zc19vdXQgbG93DQo+ICAgICAgICAgICAgICAgICAgICBhbmQgZmlyc3QgYml0IHRy
YW5zZmVyLg0KPiArLSByZXNldHMJOiBNdXN0IGNvbnRhaW4gYW4gZW50cnkgZm9yIGVhY2ggZW50
cnkgaW4gcmVzZXQtbmFtZXMuDQo+ICsJCSAgU2VlIC4uL3Jlc2V0L3Jlc2V0LnR4dCBmb3IgZGV0
YWlscy4NCj4gKy0gcmVzZXQtbmFtZXMJOiBNdXN0IGluY2x1ZGUgZWl0aGVyICJxc3BpIiBhbmQv
b3IgInFzcGktb2NwIi4NCj4gIA0KPiAgRXhhbXBsZToNCj4gIA0KPiBAQCAtNTAsNiArNTMsOCBA
QCBFeGFtcGxlOg0KPiAgCQljZG5zLGZpZm8tZGVwdGggPSA8MTI4PjsNCj4gIAkJY2RucyxmaWZv
LXdpZHRoID0gPDQ+Ow0KPiAgCQljZG5zLHRyaWdnZXItYWRkcmVzcyA9IDwweDAwMDAwMDAwPjsN
Cj4gKwkJcmVzZXRzID0gPCZyc3QgUVNQSV9SRVNFVD4sIDwmcnN0IFFTUElfT0NQX1JFU0VUPjsN
Cj4gKwkJcmVzZXQtbmFtZXMgPSAicXNwaSIsICJxc3BpLW9jcCI7DQo+ICANCj4gIAkJZmxhc2gw
OiBuMjVxMDBAMCB7DQo+ICAJCQkuLi4NCj4gDQo=
