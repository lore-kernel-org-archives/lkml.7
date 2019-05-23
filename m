Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80378C282DE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 22:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3426620863
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 22:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="vboiF41B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388566AbfEWW4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 18:56:47 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:23695 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387828AbfEWW4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 18:56:46 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Don.Brace@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Don.Brace@microchip.com";
  x-sender="Don.Brace@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Don.Brace@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Don.Brace@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.60,504,1549954800"; 
   d="scan'208";a="34635170"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 23 May 2019 15:56:29 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 23 May 2019 15:56:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RI+hsFUvp61K6uSUFrHIQx38YobOJYBePhcgKLA69lk=;
 b=vboiF41By+IylOSWBXRPDYoYinXreark9IdGQWZ+qBKijCtNhox8Eik82fj27bj0wnprApYTih/Ec/l0kjzXJt4hPc5fgge/IzpXGj/q7zF1BOu704lPpslf7gg44xmgAROeiEt2dp5/58t7MUTMPPx03VG+6melUsIVqrTXELE=
Received: from SN6PR11MB2767.namprd11.prod.outlook.com (52.135.92.154) by
 SN6PR11MB3502.namprd11.prod.outlook.com (52.135.125.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16; Thu, 23 May 2019 22:55:55 +0000
Received: from SN6PR11MB2767.namprd11.prod.outlook.com
 ([fe80::d415:48f:41b6:1ae8]) by SN6PR11MB2767.namprd11.prod.outlook.com
 ([fe80::d415:48f:41b6:1ae8%6]) with mapi id 15.20.1922.018; Thu, 23 May 2019
 22:55:55 +0000
From:   <Don.Brace@microchip.com>
To:     <Thomas.Lendacky@amd.com>, <lijiang@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     <don.brace@microsemi.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        <esc.storagedev@microsemi.com>, <dyoung@redhat.com>
Subject: RE: [PATCH] scsi: smartpqi: properly set both the DMA mask and the
 coherent DMA mask in pqi_pci_init()
Thread-Topic: [PATCH] scsi: smartpqi: properly set both the DMA mask and the
 coherent DMA mask in pqi_pci_init()
Thread-Index: AQHVESv6mWMB+P3X6UO5zLv0IXveVaZ4yegAgACIv3A=
Date:   Thu, 23 May 2019 22:55:55 +0000
Message-ID: <SN6PR11MB2767D4410415F0B03BFE900DE1010@SN6PR11MB2767.namprd11.prod.outlook.com>
References: <20190523055212.23568-1-lijiang@redhat.com>
 <c5d45523-43f5-d2fd-01ac-85f285146ecd@amd.com>
In-Reply-To: <c5d45523-43f5-d2fd-01ac-85f285146ecd@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [216.54.225.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d660989-534f-43d3-a886-08d6dfd1d057
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:SN6PR11MB3502;
x-ms-traffictypediagnostic: SN6PR11MB3502:
x-microsoft-antispam-prvs: <SN6PR11MB35023E8A9C849C6D19527EA3E1010@SN6PR11MB3502.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(366004)(396003)(39860400002)(199004)(189003)(13464003)(256004)(14444005)(229853002)(66066001)(110136005)(316002)(9686003)(33656002)(3846002)(55016002)(6116002)(71200400001)(2906002)(186003)(86362001)(478600001)(52536014)(74316002)(71190400001)(53936002)(25786009)(476003)(8936002)(6246003)(81156014)(66946007)(8676002)(5660300002)(76116006)(4326008)(68736007)(73956011)(72206003)(76176011)(102836004)(486006)(11346002)(14454004)(6436002)(66446008)(446003)(6506007)(2501003)(53546011)(7736002)(305945005)(81166006)(7696005)(99286004)(66476007)(54906003)(64756008)(26005)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR11MB3502;H:SN6PR11MB2767.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5aGfwdz08jlOirF9OLdzzgJECVsFq+yow8yFf4v0qT4bU7fGj8MdVaPjyF3N/itxS664sdDkEaT5iUIyNnrnPiMNmKwr/anqK4hrw85dZsCv25VvYr/neTfspV6WxRK9ff+Ztj3Ay7n+gh6WTMnj7/39fLuEgpYjXUt4LSxDpz+4+Cdo0WbhOPZSNE9tv36DX8ky8rFMhC66FrSVwu/5HcFj3dEdF3nmx/6usIuUpDRjX3vxEkp8ozBRpqddaWjhiQXppIC0WkVFhAwkBZvVClRbO2dHL2i2KBECoMDXMKHgr3x4tkV3vuJzPWpAosdxVDeSvTdswRbuckP7fBzzD5YPDtQy5F7PR5gWqS+w240yZy1goIi6zIxBUiz3mpwpVZlRU+pZ+tbLh7s+qDrjQdDk35uSYLFQIx7CoUnICII=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d660989-534f-43d3-a886-08d6dfd1d057
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 22:55:55.5268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Don.Brace@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3502
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGxpbnV4LXNjc2ktb3duZXJAdmdlci5r
ZXJuZWwub3JnIFttYWlsdG86bGludXgtc2NzaS1vd25lckB2Z2VyLmtlcm5lbC5vcmddIE9uIEJl
aGFsZiBPZiBMZW5kYWNreSwgVGhvbWFzDQpTZW50OiBUaHVyc2RheSwgTWF5IDIzLCAyMDE5IDk6
NDUgQU0NClRvOiBMaWFuYm8gSmlhbmcgPGxpamlhbmdAcmVkaGF0LmNvbT47IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCkNjOiBkb24uYnJhY2VAbWljcm9zZW1pLmNvbTsgamVqYkBsaW51
eC5pYm0uY29tOyBtYXJ0aW4ucGV0ZXJzZW5Ab3JhY2xlLmNvbTsgbGludXgtc2NzaUB2Z2VyLmtl
cm5lbC5vcmc7IGVzYy5zdG9yYWdlZGV2QG1pY3Jvc2VtaS5jb207IGR5b3VuZ0ByZWRoYXQuY29t
DQpTdWJqZWN0OiBSZTogW1BBVENIXSBzY3NpOiBzbWFydHBxaTogcHJvcGVybHkgc2V0IGJvdGgg
dGhlIERNQSBtYXNrIGFuZCB0aGUgY29oZXJlbnQgRE1BIG1hc2sgaW4gcHFpX3BjaV9pbml0KCkN
Cg0KT24gNS8yMy8xOSAxMjo1MiBBTSwgTGlhbmJvIEppYW5nIHdyb3RlOg0KPiBXaGVuIFNNRSBp
cyBlbmFibGVkLCB0aGUgc21hcnRwcWkgZHJpdmVyIHdvbid0IHdvcmsgb24gdGhlIEhQIERMMzg1
DQo+IEcxMCBtYWNoaW5lLCB3aGljaCBjYXVzZXMgdGhlIGZhaWx1cmUgb2Yga2VybmVsIGJvb3Qg
YmVjYXVzZSBpdCBmYWlscyANCj4gdG8gYWxsb2NhdGUgcHFpIGVycm9yIGJ1ZmZlci4gUGxlYXNl
IHJlZmVyIHRvIHRoZSBrZXJuZWwgbG9nOg0KPiAuLi4uDQo+IFsgICAgOS40MzE3NDldIHVzYmNv
cmU6IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFjZSBkcml2ZXIgdWFzDQo+IFsgICAgOS40NDE1MjRd
IE1pY3Jvc2VtaSBQUUkgRHJpdmVyICh2MS4xLjQtMTMwKQ0KPiBbICAgIDkuNDQyOTU2XSBpNDBl
IDAwMDA6MDQ6MDAuMDogZncgNi43MC40ODc2OCBhcGkgMS43IG52bSAxMC4yLjUNCj4gWyAgICA5
LjQ0NzIzN10gc21hcnRwcWkgMDAwMDoyMzowMC4wOiBNaWNyb3NlbWkgU21hcnQgRmFtaWx5IENv
bnRyb2xsZXIgZm91bmQNCj4gICAgICAgICAgU3RhcnRpbmcgZHJhY3V0IGluaXRxdWV1ZSBob29r
Li4uDQo+IFsgIE9LICBdIFN0YXJ0ZWQgU2hvdyBQbHltb3V0aCBCb290IFNjcmVbICAgIDkuNDcx
NjU0XSBCcm9hZGNvbSBOZXRYdHJlbWUtQy9FIGRyaXZlciBibnh0X2VuIHYxLjkuMQ0KPiBlbi4N
Cj4gWyAgT0sgIF0gU3RhcnRlZCBGb3J3YXJkIFBhc3N3b3JkIFJlcXVlc3RzIHRvIFBseW1vdXRo
IERpcmVjdG9yeSBXYXRjaC4NCj4gW1swO1sgICAgOS40ODcxMDhdIHNtYXJ0cHFpIDAwMDA6MjM6
MDAuMDogZmFpbGVkIHRvIGFsbG9jYXRlIFBRSSBlcnJvciBidWZmZXINCj4gLi4uLg0KPiBbICAx
MzkuMDUwNTQ0XSBkcmFjdXQtaW5pdHF1ZXVlWzk0OV06IFdhcm5pbmc6IGRyYWN1dC1pbml0cXVl
dWUgDQo+IHRpbWVvdXQgLSBzdGFydGluZyB0aW1lb3V0IHNjcmlwdHMgWyAgMTM5LjU4OTc3OV0g
DQo+IGRyYWN1dC1pbml0cXVldWVbOTQ5XTogV2FybmluZzogZHJhY3V0LWluaXRxdWV1ZSB0aW1l
b3V0IC0gc3RhcnRpbmcgDQo+IHRpbWVvdXQgc2NyaXB0cw0KPiANCj4gRm9yIGNvcnJlY3Qgb3Bl
cmF0aW9uLCBsZXRzIGNhbGwgdGhlIGRtYV9zZXRfbWFza19hbmRfY29oZXJlbnQoKSB0byANCj4g
cHJvcGVybHkgc2V0IHRoZSBtYXNrIGZvciBib3RoIHN0cmVhbWluZyBhbmQgY29oZXJlbnQsIGlu
IG9yZGVyIHRvIA0KPiBpbmZvcm0gdGhlIGtlcm5lbCBhYm91dCB0aGUgZGV2aWNlcyBETUEgYWRk
cmVzc2luZyBjYXBhYmlsaXRpZXMuDQoNCllvdSBzaG91bGQgcHJvYmFibHkgZXhwYW5kIG9uIHRo
aXMgYSBiaXQuLi4gIEJhc2ljYWxseSwgdGhlIGZhY3QgdGhhdCB0aGUgY29oZXJlbnQgRE1BIG1h
c2sgdmFsdWUgd2Fzbid0IHNldCBjYXVzZWQgdGhlIGRyaXZlciB0byBmYWxsIGJhY2sgdG8gU1dJ
T1RMQiB3aGVuIFNNRSBpcyBhY3RpdmUuIEknbSBub3Qgc3VyZSBpZiB0aGUgZmFpbHVyZSB3YXMg
ZnJvbSBydW5uaW5nIG91dCBvZiBTV0lPVExCIG9yIGV4Y2VlZGluZyB0aGUgbWF4aW11bSBhbGxv
Y2F0aW9uIHNpemUgZm9yIFNXSU9UTEIuDQoNCkkgYmVsaWV2ZSB0aGUgZml4IGlzIHByb3Blciwg
YnV0IEknbGwgbGV0IHRoZSBkcml2ZXIgb3duZXIgY29tbWVudCBvbiB0aGF0Lg0KDQpUaGFua3Ms
DQpUb20NCg0KQWNrZWQtYnk6IERvbiBCcmFjZSA8ZG9uLmJyYWNlQG1pY3Jvc2VtaS5jb20+DQpU
ZXN0ZWQtYnk6IERvbiBCcmFjZSA8ZG9uLmJyYWNlQG1pY3Jvc2VtaS5jb20+DQoNClBsZWFzZSBh
ZGQgdGhlIGV4dHJhIGRlc2NyaXB0aW9uIHN1Z2dlc3RlZCBieSBUaG9tYXMuDQoNCg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogTGlhbmJvIEppYW5nIDxsaWppYW5nQHJlZGhhdC5jb20+DQo+IC0tLQ0K
PiAgZHJpdmVycy9zY3NpL3NtYXJ0cHFpL3NtYXJ0cHFpX2luaXQuYyB8IDIgKy0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvc2NzaS9zbWFydHBxaS9zbWFydHBxaV9pbml0LmMgDQo+IGIvZHJpdmVycy9z
Y3NpL3NtYXJ0cHFpL3NtYXJ0cHFpX2luaXQuYw0KPiBpbmRleCBjMjZjYWM4MTlmOWUuLjhiMWZk
ZTZjN2RhYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zY3NpL3NtYXJ0cHFpL3NtYXJ0cHFpX2lu
aXQuYw0KPiArKysgYi9kcml2ZXJzL3Njc2kvc21hcnRwcWkvc21hcnRwcWlfaW5pdC5jDQo+IEBA
IC03MjgyLDcgKzcyODIsNyBAQCBzdGF0aWMgaW50IHBxaV9wY2lfaW5pdChzdHJ1Y3QgcHFpX2N0
cmxfaW5mbyAqY3RybF9pbmZvKQ0KPiAgICAgICAgIGVsc2UNCj4gICAgICAgICAgICAgICAgIG1h
c2sgPSBETUFfQklUX01BU0soMzIpOw0KPiANCj4gLSAgICAgICByYyA9IGRtYV9zZXRfbWFzaygm
Y3RybF9pbmZvLT5wY2lfZGV2LT5kZXYsIG1hc2spOw0KPiArICAgICAgIHJjID0gZG1hX3NldF9t
YXNrX2FuZF9jb2hlcmVudCgmY3RybF9pbmZvLT5wY2lfZGV2LT5kZXYsIA0KPiArIG1hc2spOw0K
PiAgICAgICAgIGlmIChyYykgew0KPiAgICAgICAgICAgICAgICAgZGV2X2VycigmY3RybF9pbmZv
LT5wY2lfZGV2LT5kZXYsICJmYWlsZWQgdG8gc2V0IERNQSBtYXNrXG4iKTsNCj4gICAgICAgICAg
ICAgICAgIGdvdG8gZGlzYWJsZV9kZXZpY2U7DQo+IC0tDQo+IDIuMTcuMQ0KPiANCg==
