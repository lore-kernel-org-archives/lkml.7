Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9309ECA9ECE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 08:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A9F2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 08:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="IQNpmM8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfJaIyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 04:54:39 -0400
Received: from mail-eopbgr720053.outbound.protection.outlook.com ([40.107.72.53]:5242
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726874AbfJaIyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 04:54:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhE8rDXktJoGtjvoWoKZ1Tw88OKqcUDXiGyxwvhOw392UchQj4ucXgpkB1eNkX+Oa+rsvWIS4W1Z049dsI9fxdhg9Ek2ryDAm595XHyymg1zyHwPGNvs0gzvfPCYSAc9wqKmNBUtZQIDiHxxEk8u02bz/hMXA4hcOqgjnrxx5KQvk76ACM64YSX7ef57e1Hb0TUQDzAYwYuG4RNgoQiIObn7N4I8Z44vStptDPUlZB1ZJPxlHzym/iWG3XDCn0+4ovlsCfbNxsNshCHqVBZYEorpYZUChJstTC0JbV4pJ+cO+nooA8Bu60cmnGd2nq+TzCwYG78UGOX2KuZYiD0few==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iAdrVSZ0w1Lv0YwTulegCXbSbcN8fVpQABmRwr3vP4=;
 b=HjeUI47hMWVZ4vz/3CWwEBnSPLo3qUR5Qjw57IR0pZT3Q6XRqi4j9VI4MesYRumyUHdz4O6XmP53OJaqD5Xo0UyB6U+XHXjlcRRd9pP7965HiMyOzcngkq8pCgjy6cBA7SwvlYuO5xCXoJJl3wBREBPL0n4Mg+RDsDkZPeRDDiUoo7C6KjzDbS1Hw8gsiyJLKItrIz/iekWZflUDvZ4CU31GQ4d9tLSDAuQpuZyoVzwWxe7pVV96FlkFCZu6gJkVvVGtqSaACoLJqWbpBMPruCpNJ1pJyOzubXtfGgmIsMU9Inkws38cHE3M9ZHHtYL70+tvNUZnyeZ4JLDFKyEi5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iAdrVSZ0w1Lv0YwTulegCXbSbcN8fVpQABmRwr3vP4=;
 b=IQNpmM8TQya9Y+OHrHDZzYKT0UgpPm9pHPFAtaYBJvu6wIH3CkCbxm0b+yxS9RU9KlT3UPrixs6VM8/IZmanVNwucbM4xDCce3kLcJ6MBdpgQcSLxchtIOKa1uk+wuA4XXwtb34DruWTlYS80uZ/cYJ3kGuKrhmDUf/+/QJBjxo=
Received: from MN2PR02MB6029.namprd02.prod.outlook.com (52.132.174.207) by
 MN2PR02MB6144.namprd02.prod.outlook.com (52.132.175.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.18; Thu, 31 Oct 2019 08:54:28 +0000
Received: from MN2PR02MB6029.namprd02.prod.outlook.com
 ([fe80::60f4:2360:4c7d:cad6]) by MN2PR02MB6029.namprd02.prod.outlook.com
 ([fe80::60f4:2360:4c7d:cad6%5]) with mapi id 15.20.2387.028; Thu, 31 Oct 2019
 08:54:28 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michals@xilinx.com>,
        Jolly Shah <JOLLYS@xilinx.com>,
        Nava kishore Manne <navam@xilinx.com>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        git <git@xilinx.com>
Subject: RE: [PATCH v4 4/8] dt-bindings: mmc: arasan: Add optional properties
 for Arasan SDHCI
Thread-Topic: [PATCH v4 4/8] dt-bindings: mmc: arasan: Add optional properties
 for Arasan SDHCI
Thread-Index: AQHVjkQMPZqKO+Pc1k66gPgz7rOXfKdzSCqAgAEsgNA=
Date:   Thu, 31 Oct 2019 08:54:28 +0000
Message-ID: <MN2PR02MB60299A66F6E18111D34983E6C1630@MN2PR02MB6029.namprd02.prod.outlook.com>
References: <1572345042-101207-1-git-send-email-manish.narani@xilinx.com>
 <1572345042-101207-4-git-send-email-manish.narani@xilinx.com>
 <CAPDyKFqRmFPaiM=AoiWvy5xhYj=fHTt+S1wu8o0W67Nc5ZZ1kA@mail.gmail.com>
In-Reply-To: <CAPDyKFqRmFPaiM=AoiWvy5xhYj=fHTt+S1wu8o0W67Nc5ZZ1kA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 724239a6-cb55-4773-fb6f-08d75ddff00e
x-ms-traffictypediagnostic: MN2PR02MB6144:|MN2PR02MB6144:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB61443F0EF09A2C28AC9703E9C1630@MN2PR02MB6144.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02070414A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(13464003)(189003)(199004)(26005)(7416002)(11346002)(74316002)(7696005)(229853002)(71190400001)(52536014)(486006)(478600001)(102836004)(6246003)(305945005)(99286004)(6916009)(476003)(66066001)(86362001)(446003)(7736002)(6436002)(9686003)(186003)(53546011)(107886003)(76176011)(5660300002)(55016002)(6506007)(81166006)(54906003)(3846002)(33656002)(8936002)(81156014)(256004)(2906002)(8676002)(6116002)(4326008)(316002)(25786009)(64756008)(66946007)(66476007)(76116006)(66446008)(14454004)(71200400001)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB6144;H:MN2PR02MB6029.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7hpqiFuHBhn4CSvOUrkryG6PvYjQzN7uJ5/DNWT6E+KhUFSC6INXrV17V89bA0yUtRQ+YAcl16kbkHOAqUIvckWCZAolafUdOnU5d5JkaZ7Jtrc83bdMtrx3i2C83magmENVhwWWN4sM4VMP5t3AlIOreVcpWEcixajKGthu4ad3nULqgO6qOh3ACByxvCewdO3k4/hQFpX8Ys043CzvzxP2wDKZIslTGZtGqzsrjHCIpqX5Qf994TlvaHV27lIhTgricOo84JYSZL/emSTAFpb0NhBwl5sN5WwHdFrJ90xibzo5YLC32sUFvKBOulNidFrm62GToiz/hDa9vGfv1jC3tTUcuh0JUHJVy2Pcy+gThfyE5N4y0Vw2K1ogLFckKbY1hWSzUGSzxkEwbMQN9TuKOgsVfRrixVntYaccvwhUD93VtuXK2p5SxljUlIk8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 724239a6-cb55-4773-fb6f-08d75ddff00e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2019 08:54:28.1559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Oe3k0ebyiPztMHk8MINnpXYKnHThzPLuszq+MiXYFmI4Yy410NUO5mSGLbm5VbTa+Olps/A1nFltmjeTm+Rng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVWZmZSwNCg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLiBQbGVhc2Ugc2VlIGJlbG93IGlu
bGluZS4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBVbGYgSGFuc3Nv
biA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDMw
LCAyMDE5IDg6MjcgUE0NCj4gVG86IE1hbmlzaCBOYXJhbmkgPE1OQVJBTklAeGlsaW54LmNvbT4N
Cj4gQ2M6IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBNYXJrIFJ1dGxhbmQNCj4g
PG1hcmsucnV0bGFuZEBhcm0uY29tPjsgQWRyaWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRl
bC5jb20+Ow0KPiBNaWNoYWwgU2ltZWsgPG1pY2hhbHNAeGlsaW54LmNvbT47IEpvbGx5IFNoYWgg
PEpPTExZU0B4aWxpbnguY29tPjsgTmF2YQ0KPiBraXNob3JlIE1hbm5lIDxuYXZhbUB4aWxpbngu
Y29tPjsgUmFqYW4gVmFqYSA8UkFKQU5WQHhpbGlueC5jb20+Ow0KPiBsaW51eC1tbWNAdmdlci5r
ZXJuZWwub3JnOyBEVE1MIDxkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZz47IExpbnV4DQo+IEtl
cm5lbCBNYWlsaW5nIExpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBMaW51eCBB
Uk0gPGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+OyBnaXQgPGdpdEB4
aWxpbnguY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDQvOF0gZHQtYmluZGluZ3M6IG1t
YzogYXJhc2FuOiBBZGQgb3B0aW9uYWwNCj4gcHJvcGVydGllcyBmb3IgQXJhc2FuIFNESENJDQo+
IA0KPiBPbiBUdWUsIDI5IE9jdCAyMDE5IGF0IDExOjMwLCBNYW5pc2ggTmFyYW5pIDxtYW5pc2gu
bmFyYW5pQHhpbGlueC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gQWRkIG9wdGlvbmFsIHByb3Bl
cnRpZXMgZm9yIEFyYXNhbiBTREhDSSB3aGljaCBhcmUgdXNlZCB0byBzZXQgY2xrIGRlbGF5cw0K
PiA+IGZvciBkaWZmZXJlbnQgc3BlZWQgbW9kZXMgaW4gdGhlIGNvbnRyb2xsZXIuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBNYW5pc2ggTmFyYW5pIDxtYW5pc2gubmFyYW5pQHhpbGlueC5jb20+
DQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9hcmFzYW4sc2RoY2ku
dHh0ICAgICB8IDE2ICsrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE2IGlu
c2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbW1jL2FyYXNhbixzZGhjaS50eHQNCj4gYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbW1jL2FyYXNhbixzZGhjaS50eHQNCj4gPiBpbmRleCBiNTFlNDBiMmUw
YzUuLmMwZjUwNWI2Y2FiNSAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbW1jL2FyYXNhbixzZGhjaS50eHQNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbW1jL2FyYXNhbixzZGhjaS50eHQNCj4gPiBAQCAtNDYsNiAr
NDYsMjIgQEAgT3B0aW9uYWwgUHJvcGVydGllczoNCj4gPiAgICAgIHByb3Blcmx5LiBUZXN0IG1v
ZGUgY2FuIGJlIHVzZWQgdG8gZm9yY2UgdGhlIGNvbnRyb2xsZXIgdG8gZnVuY3Rpb24uDQo+ID4g
ICAgLSB4bG54LGludC1jbG9jay1zdGFibGUtYnJva2VuOiB3aGVuIHByZXNlbnQsIHRoZSBjb250
cm9sbGVyIGFsd2F5cw0KPiByZXBvcnRzDQo+ID4gICAgICB0aGF0IHRoZSBpbnRlcm5hbCBjbG9j
ayBpcyBzdGFibGUgZXZlbiB3aGVuIGl0IGlzIG5vdC4NCj4gPiArICAtIGFyYXNhbi1jbGstcGhh
c2UtbGVnYWN5OiBJbnB1dC9PdXRwdXQgQ2xvY2sgRGVsYXkgcGFpciBpbiBkZWdyZWVzIGZvcg0K
PiBMZWdhY3kgTW9kZS4NCj4gPiArICAtIGFyYXNhbi1jbGstcGhhc2UtbW1jLWhzOiBJbnB1dC9P
dXRwdXQgQ2xvY2sgRGVsYXkgcGFpciBkZWdyZWVzIGZvcg0KPiBNTUMgSFMuDQo+ID4gKyAgLSBh
cmFzYW4tY2xrLXBoYXNlLXNkLWhzOiBJbnB1dC9PdXRwdXQgQ2xvY2sgRGVsYXkgcGFpciBpbiBk
ZWdyZWVzIGZvciBTRA0KPiBIUy4NCj4gPiArICAtIGFyYXNhbi1jbGstcGhhc2UtdWhzLXNkcjEy
OiBJbnB1dC9PdXRwdXQgQ2xvY2sgRGVsYXkgcGFpciBpbiBkZWdyZWVzDQo+IGZvciBTRFIxMi4N
Cj4gPiArICAtIGFyYXNhbi1jbGstcGhhc2UtdWhzLXNkcjI1OiBJbnB1dC9PdXRwdXQgQ2xvY2sg
RGVsYXkgcGFpciBpbiBkZWdyZWVzDQo+IGZvciBTRFIyNS4NCj4gPiArICAtIGFyYXNhbi1jbGst
cGhhc2UtdWhzLXNkcjUwOiBJbnB1dC9PdXRwdXQgQ2xvY2sgRGVsYXkgcGFpciBpbiBkZWdyZWVz
DQo+IGZvciBTRFI1MC4NCj4gPiArICAtIGFyYXNhbi1jbGstcGhhc2UtdWhzLXNkcjEwNDogSW5w
dXQvT3V0cHV0IENsb2NrIERlbGF5IHBhaXIgaW4gZGVncmVlcw0KPiBmb3IgU0RSMTA0Lg0KPiA+
ICsgIC0gYXJhc2FuLWNsay1waGFzZS11aHMtZGRyNTA6IElucHV0L091dHB1dCBDbG9jayBEZWxh
eSBwYWlyIGluIGRlZ3JlZXMNCj4gZm9yIFNEIEREUjUwLg0KPiA+ICsgIC0gYXJhc2FuLWNsay1w
aGFzZS1tbWMtZGRyNTI6IElucHV0L091dHB1dCBDbG9jayBEZWxheSBwYWlyIGluIGRlZ3JlZXMN
Cj4gZm9yIE1NQyBERFI1Mi4NCj4gPiArICAtIGFyYXNhbi1jbGstcGhhc2UtbW1jLWhzMjAwOiBJ
bnB1dC9PdXRwdXQgQ2xvY2sgRGVsYXkgcGFpciBpbiBkZWdyZWVzDQo+IGZvciBNTUMgSFMyMDAu
DQo+ID4gKyAgLSBhcmFzYW4tY2xrLXBoYXNlLW1tYy1oczQwMDogSW5wdXQvT3V0cHV0IENsb2Nr
IERlbGF5IHBhaXIgaW4gZGVncmVlcw0KPiBmb3IgTU1DIEhTNDAwLg0KPiANCj4gSSBkb24ndCBt
aW5kIGlmIHlvdSBjb252ZXJ0IHRoZXNlIHRvIGNvbW1vbiBtbWMgYmluZGluZ3MuDQo+IA0KPiBJ
IHRoaW5rIG90aGVyIGNvbnRyb2xsZXJzL3BsYXRmb3JtcyBtYXkgZmluZCB0aGVtIHVzZWZ1bCwg
YXQgbGVhc3QgYXQNCj4gc29tZSBwb2ludCwgaWYgbm90IGFscmVhZHkuDQoNClRoYXQgd2lsbCBi
ZSBhIGdvb2QgdGhpbmcgdG8gZG8gaW5kZWVkLiBXaWxsIHNlbmQgdjUgd2l0aCBtYWtpbmcgdGhl
c2UgcHJvcGVydGllcyBhcyBjb21tb24uDQoNClRoYW5rcywNCk1hbmlzaA0KDQo+IA0KPiA+ICsN
Cj4gPiArICBBYm92ZSBtZW50aW9uZWQgYXJlIHRoZSBjbG9jayAocGhhc2UpIGRlbGF5cyB3aGlj
aCBhcmUgdG8gYmUNCj4gY29uZmlndXJlZCBpbiB0aGUNCj4gPiArICBjb250cm9sbGVyIHdoaWxl
IHN3aXRjaGluZyB0byBwYXJ0aWN1bGFyIHNwZWVkIG1vZGUuIFRoZSByYW5nZSBvZiB2YWx1ZXMN
Cj4gYXJlDQo+ID4gKyAgMCB0byAzNTkgZGVncmVlcy4gSWYgbm90IHNwZWNpZmllZCwgZHJpdmVy
IHdpbGwgY29uZmlndXJlIHRoZSBkZWZhdWx0IHZhbHVlDQo+ID4gKyAgZGVmaW5lZCBmb3IgcGFy
dGljdWxhciBtb2RlIGluIGl0Lg0KPiA+DQo+ID4gIEV4YW1wbGU6DQo+ID4gICAgICAgICBzZGhj
aUBlMDEwMDAwMCB7DQo+ID4gLS0NCj4gPiAyLjE3LjENCj4gPg0KPiANCj4gS2luZCByZWdhcmRz
DQo+IFVmZmUNCg==
