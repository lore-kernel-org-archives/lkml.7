Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5DAC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 06:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27C62178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 06:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="Wzw89B8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbfKHGuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 01:50:15 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:58946 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725802AbfKHGuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 01:50:14 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA86mQTE004853;
        Fri, 8 Nov 2019 01:50:03 -0500
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2053.outbound.protection.outlook.com [104.47.36.53])
        by mx0a-00128a01.pphosted.com with ESMTP id 2w41w6dd1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Nov 2019 01:50:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdOg66ZF6nq+kDqfPVfiQy7Jk2iG/qKIZlp2uH6y/DkqKS4oqk3/faPSUyOZ2u+ww53edqIWsgQJI53AHBDNlR7C6ryfNQZd8yru7op2TBSIylnz1C9kzrW0Kn84eQZIKPes7Z/s2NV7FgYXvfs+vf6LZWMoTVNpunepcA8G3JBgack1B/gUTgNReg4RXqpIRjPsi3CSsOlLWkYfabQKJUJTdCriMcm/OF/82DePvyunR1DFWb51Sbnp41tixQQKjvD1oxAtf6SL7dks39gsMO0EEWa3bL4iuntvtL2N9gJOSWTkrgHWAkVl2P0L7u0l1v6V5lHGLZndyjo8Q/pZ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTSxApOzRhce5z9rpuCu4juy+tamyZYwg65L/7C3ehs=;
 b=GCpB8UJE7Ace1aiaKin25VA+zjZzVAkFU3Ngjacfefca8d3ZtT1oOeiLornClNyb5jILH5iD1hx9J3Wc/s57XstvBNN7AGgelHr6Zmb82MlUSSCedVCkymjYAK4CO2YSN37A37F6N/b3PRraHcpUQX6Dxjm1DRw5EEZDGiwj81MdjgAvB+YmeETGIFarkEc6OFt4BQsv2TbmIhN8C9dza+dfvPUJU5ku6h1CZ9oJY/U+yVCB04vcjafRALjnjcv6Q9TpbFuXCzvmC1nBn6g7R7VeqnNvsNznzuX1n09N5+6p9+AjSNnzYalFtgsFWmotHbpj1fMbVeYdgE09GQsxpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTSxApOzRhce5z9rpuCu4juy+tamyZYwg65L/7C3ehs=;
 b=Wzw89B8yDi1PMxZERe0VrKki1/pQb/YBEIRAEqAY9EP5Msx4YEmHUo4ewoqLEkGgYPF/54Ld2gE3FlgZVala6XxuNzar0cWuU6xQwMX69t7PufWkr38IiK61lLpkMO31f+bLwJJ5yEa0NNfz7pVRmqGY8MvxEEuzr0JDE24+tcc=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 BL0SPR01MB0041.namprd03.prod.outlook.com (10.255.69.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Fri, 8 Nov 2019 06:50:00 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c%3]) with mapi id 15.20.2430.023; Fri, 8 Nov 2019
 06:50:00 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>
CC:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jsarha@ti.com" <jsarha@ti.com>, "ce3a@gmx.de" <ce3a@gmx.de>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
Subject: Re: [PATCH] clk: clk-gpio: Add dt option to propagate rate change to
 parent
Thread-Topic: [PATCH] clk: clk-gpio: Add dt option to propagate rate change to
 parent
Thread-Index: AQHVlJZjqNZ+PQlo4UajtQS9MSYTgad+ve6AgAD2yoCAAJ5eAIAAhW2A
Date:   Fri, 8 Nov 2019 06:50:00 +0000
Message-ID: <51dbe8f43753ca52b9732aa1f099d3499391f643.camel@analog.com>
References: <20191106113551.5557-1-alexandru.ardelean@analog.com>
         <20191106224306.A85342173E@mail.kernel.org>
         <f3992013a3811ec2292e3da403841cb6e5cb95b5.camel@analog.com>
         <20191107225313.4ED9D21D7B@mail.kernel.org>
In-Reply-To: <20191107225313.4ED9D21D7B@mail.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a589e70b-93c4-448c-0ac7-08d76417e055
x-ms-traffictypediagnostic: BL0SPR01MB0041:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0SPR01MB00415820FCB632CC8EEBE344F97B0@BL0SPR01MB0041.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(346002)(376002)(136003)(189003)(199004)(54094003)(8676002)(2201001)(6512007)(6436002)(99286004)(2906002)(6486002)(66556008)(6246003)(6306002)(4326008)(446003)(186003)(11346002)(478600001)(26005)(25786009)(66476007)(86362001)(229853002)(102836004)(14454004)(966005)(118296001)(6116002)(3846002)(256004)(2501003)(305945005)(110136005)(486006)(76176011)(7736002)(81166006)(14444005)(2616005)(316002)(5024004)(476003)(6506007)(54906003)(5660300002)(81156014)(36756003)(66066001)(66446008)(76116006)(64756008)(66946007)(71190400001)(91956017)(71200400001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0SPR01MB0041;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jeSx9b4tx8TSka7CKYLW91qfBd7UKwvUjGRVFsO0KenO+brFP7opGosvH044BG0GOkIBZt9qlVssRKO7gJhBdlOJ2sQW9bEYFXOgaNazA1tnB0M+8eMlw8QPOgxmSF5IkijTuUfkjEgbDTblNvxG71J7x/O1gN1Pf8f60fQmRbjj3kyPBMpSbJQxbOZw4iWn4xnmLUaLGKy7yFpZbPCZSCts017XNNf6KjulDhWEcZJc8QBAoFsrRW8BDm0b00I+Y9RosSNzd5dlyPHvNddna9/mhcjnfLRHz4mOc4xTJsoCjggOnY0OBNigbomC8g4qFXVXSevwSBSEGJR6Y1EXVEC9siHVD+jIRwOawdTN3ugTcUBEkDUwo+vFKld0PvoZtXT1Km1WKnVvW5StMyl2l4FR1CsdKLbHpcvVEt70d5YYQLUxdPZudBm15Eef38BQ2hur1QqEEgGREhnnJta30H0q6EcU9jdSVhBLcCcfpCw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <175D515B99F52D43BD42B1A50EA0B7C2@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a589e70b-93c4-448c-0ac7-08d76417e055
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 06:50:00.4131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9LRfvoNUtPOEj9WyH3BesBRyFqstkEk81WyuxAdw8ffxedpkv5883ptpxj04pJKsIE0S6CMNrk+fCBLNR6CZ02H0YnkJSmJR3LU1As9xwiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0SPR01MB0041
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-08_01:2019-11-07,2019-11-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911080066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTExLTA3IGF0IDE0OjUzIC0wODAwLCBTdGVwaGVuIEJveWQgd3JvdGU6DQo+
IFF1b3RpbmcgQXJkZWxlYW4sIEFsZXhhbmRydSAoMjAxOS0xMS0wNyAwNToyNTozOCkNCj4gPiBP
biBXZWQsIDIwMTktMTEtMDYgYXQgMTQ6NDMgLTA4MDAsIFN0ZXBoZW4gQm95ZCB3cm90ZToNCj4g
PiA+IFF1b3RpbmcgQWxleGFuZHJ1IEFyZGVsZWFuICgyMDE5LTExLTA2IDAzOjM1OjUxKQ0KPiA+
ID4gPiBGcm9tOiBNaWNoYWVsIEhlbm5lcmljaCA8bWljaGFlbC5oZW5uZXJpY2hAYW5hbG9nLmNv
bT4NCj4gPiA+ID4gDQo+ID4gPiA+IEZvciBjZXJ0YWluIHNldHVwcy9ib2FyZHMgaXQncyB1c2Vm
dWwgdG8gcHJvcGFnYXRlIHRoZSByYXRlIGNoYW5nZQ0KPiA+ID4gPiBvZg0KPiA+ID4gPiB0aGUN
Cj4gPiA+ID4gY2xvY2sgdXAgb25lIGxldmVsIHRvIHRoZSBwYXJlbnQgY2xvY2suDQo+ID4gPiA+
IA0KPiA+ID4gPiBUaGlzIGNoYW5nZSBpbXBsZW1lbnRzIHRoaXMgYnkgZGVmaW5pbmcgYSBgY2xr
LXNldC1yYXRlLXBhcmVudGANCj4gPiA+ID4gZGV2aWNlLQ0KPiA+ID4gPiB0cmVlDQo+ID4gPiA+
IHByb3BlcnR5IHdoaWNoIHNldHMgdGhlIGBDTEtfU0VUX1JBVEVfUEFSRU5UYCBmbGFnIHRvIHRo
ZSBjbG9jaw0KPiA+ID4gPiAod2hlbg0KPiA+ID4gPiBzZXQpLg0KPiA+ID4gPiANCj4gPiA+ID4g
U2lnbmVkLW9mZi1ieTogTWljaGFlbCBIZW5uZXJpY2ggPG1pY2hhZWwuaGVubmVyaWNoQGFuYWxv
Zy5jb20+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFu
ZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgZHJpdmVycy9j
bGsvY2xrLWdwaW8uYyB8IDggKysrKysrLS0NCj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gPiA+IA0KPiA+ID4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9jbGsvY2xrLWdwaW8uYyBiL2RyaXZlcnMvY2xrL2Nsay1ncGlvLmMNCj4gPiA+
ID4gaW5kZXggOWQ5MzBlZGQ2NTE2Li42ZGZiYzRiOTUyZmUgMTAwNjQ0DQo+ID4gPiA+IC0tLSBh
L2RyaXZlcnMvY2xrL2Nsay1ncGlvLmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9jbGsvY2xrLWdw
aW8uYw0KPiA+ID4gPiBAQCAtMjQxLDYgKzI0MSw3IEBAIHN0YXRpYyBpbnQgZ3Bpb19jbGtfZHJp
dmVyX3Byb2JlKHN0cnVjdA0KPiA+ID4gPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gPiA+
ICAgICAgICAgc3RydWN0IGRldmljZV9ub2RlICpub2RlID0gcGRldi0+ZGV2Lm9mX25vZGU7DQo+
ID4gPiA+ICAgICAgICAgY29uc3QgY2hhciAqKnBhcmVudF9uYW1lcywgKmdwaW9fbmFtZTsNCj4g
PiA+ID4gICAgICAgICB1bnNpZ25lZCBpbnQgbnVtX3BhcmVudHM7DQo+ID4gPiA+ICsgICAgICAg
dW5zaWduZWQgbG9uZyBjbGtfZmxhZ3M7DQo+ID4gPiA+ICAgICAgICAgc3RydWN0IGdwaW9fZGVz
YyAqZ3Bpb2Q7DQo+ID4gPiA+ICAgICAgICAgc3RydWN0IGNsayAqY2xrOw0KPiA+ID4gPiAgICAg
ICAgIGJvb2wgaXNfbXV4Ow0KPiA+ID4gPiBAQCAtMjc0LDEzICsyNzUsMTYgQEAgc3RhdGljIGlu
dCBncGlvX2Nsa19kcml2ZXJfcHJvYmUoc3RydWN0DQo+ID4gPiA+IHBsYXRmb3JtX2RldmljZSAq
cGRldikNCj4gPiA+ID4gICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gPiA+ICAgICAg
ICAgfQ0KPiA+ID4gPiAgDQo+ID4gPiA+ICsgICAgICAgY2xrX2ZsYWdzID0gb2ZfcHJvcGVydHlf
cmVhZF9ib29sKG5vZGUsICJjbGstc2V0LXJhdGUtDQo+ID4gPiA+IHBhcmVudCIpDQo+ID4gPiA+
ID8NCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgQ0xLX1NFVF9SQVRFX1BBUkVOVCA6
IDA7DQo+ID4gPiANCj4gPiA+IElzIHRoZXJlIGEgRFQgYmluZGluZyB1cGRhdGUgc29tZXdoZXJl
PyBJdCBsb29rcyBsaWtlIGEgbGludXgtaXNtDQo+ID4gPiBmcm9tDQo+ID4gDQo+ID4gR29vZCBw
b2ludC4gSSBkaWQgbm90IHRoaW5rIGFib3V0IHRoZSBEVCwgYW5kIEkgZ3Vlc3MgSSBkaWRuJ3Qg
c2VhcmNoDQo+ID4gaXQNCj4gPiB0aG9yb3VnaGx5IGVub3VnaC4gRm91bmQgRFQgZmlsZXMgbm93
Lg0KPiA+IA0KPiA+ID4gdGhlIERUIHBlcnNwZWN0aXZlLiBJIHdvbmRlciBpZiB3ZSBjYW4gc29t
ZWhvdyBmaWd1cmUgb3V0IHRoYXQgaXQncw0KPiA+ID4gT0sNCj4gPiA+IHRvIGNhbGwgY2xrX3Nl
dF9yYXRlKCkgb24gdGhlIHBhcmVudCBoZXJlPyBPciBpcyBpdCBzYWZlIHRvIGFzc3VtZQ0KPiA+
ID4gdGhhdA0KPiA+ID4gd2UgY2FuIGp1c3QgYWx3YXlzIGNhbGwgc2V0IHJhdGUgb24gdGhlIHBh
cmVudD8gSSB0aGluayBmb3IgYSBnYXRlDQo+ID4gPiBpdCdzDQo+ID4gPiBnb29kIGFuZCB3ZSBj
YW4ganVzdCBkbyBzbywgYnV0IGZvciBhIG11eCBtYXliZSBub3QuIENhcmUgdG8gZGVzY3JpYmUN
Cj4gPiA+IHlvdXIgc2NlbmFyaW8gYSBsaXR0bGUgbW9yZSBzbyB3ZSBjYW4gdW5kZXJzdGFuZCB3
aHkgeW91IHdhbnQgdG8gc2V0DQo+ID4gPiB0aGlzIGZsYWc/IElzIGl0IGZvciBhIG11eCBvciBh
IGdhdGUgdHlwZSBncGlvPw0KPiA+ID4gDQo+ID4gDQo+ID4gRm9yIG91ciBjYXNlIHdlIGFyZSB1
c2luZyBpdCBoZXJlIFt3aXRoIGEgc2xpZ2h0IG5hbWUgdmFyaWF0aW9uIGluIHRoZQ0KPiA+IHBy
b3ANCj4gPiBuYW1lXToNCj4gPiBodHRwczovL2dpdGh1Yi5jb20vYW5hbG9nZGV2aWNlc2luYy9s
aW51eC9ibG9iL21hc3Rlci9hcmNoL2FybS9ib290L2R0cy96eW5xLWFkcnY5MzYxLXo3MDM1LmR0
c2kjTDQzDQo+ID4gDQo+ID4gQW5kIG9uIHRoaXMgYm9hcmQ6DQo+ID4gaHR0cHM6Ly93aWtpLmFu
YWxvZy5jb20vcmVzb3VyY2VzL2V2YWwvdXNlci1ndWlkZXMvYWRydjkzNnhfcmZzb20vdXNlci1n
dWlkZS9pbnRyb2R1Y3Rpb24NCj4gPiANCj4gPiBJdCdzIGZvciBhIGdhdGUtdHlwZSBHUElPLg0K
PiA+IFRoZSBjbG9jayBkZWZpbmVkIGluIHRoYXQgRFQgKGFkOTM2MV9jbGtpbikgaXMgYXR0YWNo
ZWQgdG8gYSBjbG9jayB0aGF0DQo+ID4gaGFzDQo+ID4gYSBmaXhlZCByYXRlICh4b180MG1oel9m
aXhlZF9jbGspLCB0aGF0IGNhbiBiZWNvbWUgYSB2YXJpYWJsZSByYXRlDQo+ID4gW2Zyb20gYW4N
Cj4gPiBleHRlcm5hbCBzb3VyY2UsIHdoZW4gaXQgaXMgcHJvdmlkZWRdLg0KPiA+IA0KPiA+IE91
ciB1bmRlcnN0YW5kaW5nLCBpcyB0aGF0IGEgR1BJTyBnYXRlIGNsb2NrIHNob3VsZCBwcm9wYWdh
dGUgdGhlIHJhdGUNCj4gPiBjaGFuZ2UgdG8gdGhlIHBhcmVudCBjbG9jay4gVGhlIHNhbWUgZ29l
cyBmb3IgdGhlIEdQSU8gTVVYIGNsb2NrLg0KPiA+IFNvLCB0aGUgZGVmYXVsdCBtb2RlIHdvdWxk
IGJlIHRvIGFsd2F5cyBzZXQgQ0xLX1NFVF9SQVRFX1BBUkVOVC4NCj4gPiANCj4gPiBCdXQsIGdp
dmVuIHRoYXQgdGhlcmUgYXJlIHVzZXJzIG9mIHRoaXMgZHJpdmVyLCBzdWNoIGEgYmVoYXZpb3Ig
Y2hhbmdlDQo+ID4gY291bGQgYnJlYWsgb3RoZXIgdXNlcnMsIHNvIHdlIGFyZSB1c2luZyB0aGlz
IERUIHByb3AuDQo+ID4gDQo+ID4gVGhlcmUgc2VlbXMgdG8gYmUgb25seSBvbmUgdXNlciBvZiBn
cGlvLW11eC1jbG9jayBpbg0KPiA+IGFyY2gvYXJtNjQvYm9vdC9kdHMvcmVuZXNhcy91bGNiLWtm
LmR0c2kNCj4gPiANCj4gPiBXaGVyZWFzIGZvciBncGlvLWdhdGUtY2xvY2ssIHRoZXJlIGFyZSBt
dWx0aXBsZSB1c2Vycy4gSSBjYW4ndCBzYXkNCj4gPiB3aGV0aGVyDQo+ID4gdGhpcyBjaGFuZ2Ug
d291bGQgYnJlYWsgYW55dGhpbmcgZm9yIHRoZW0sIG9yIGl0IHdvdWxkIGJlIGZpbmUuDQo+IA0K
PiBJIHRoaW5rIHdlIGNhbiBqdXN0IGFkZCBDTEtfU0VUX1JBVEVfUEFSRU5UIGZvciBhbGwgZ3Bp
byBnYXRlIGNsa3MgdGhlbg0KPiBhbmQgeW91J2xsIGJlIGhhcHB5PyBDYXJlIHRvIHNlbmQgdGhh
dCBwYXRjaCBhbmQgQ2MgR2VlcnQgYW5kIG90aGVyDQo+IFJlbmVzYXMgbWFpbnRhaW5lcnM/IFRo
YXQgYXZvaWRzIGFueSBEVCBwcm9wZXJ0eSBhbmQgc2hvdWxkIGJlIGZpbmUgZm9yDQo+IGFueW9u
ZSBhcyBmYXIgYXMgSSBjYW4gdGVsbC4gTWF5YmUgdGhlIGludmVyc2Ugd2lsbCBiZSBkZXNpcmVk
LCBidXQgbm90DQo+IHdhbnRpbmcgcmF0ZSB0byBwcm9wYWdhdGUgaXMgYW4gZWRnZSBjYXNlIHRo
YXQgd2UgbWF5IHdhbnQgdG8gY2FsbCBvdXQNCj4gZXhwbGljaXRseSBpbiBEVCBhdCBzb21lIHBv
aW50IGluIHRoZSBmdXR1cmUsIGJ1dCBzaG91bGRuJ3Qgd29ycnkgYWJvdXQNCj4gdW50aWwgdGhl
bi4NCj4gDQoNCldpbGwgcmVzZW5kLCB0aGFua3MuDQpHZWVydCBpcyBDQy1lZCBoZXJlIGFzIHdl
bGwgW3VubGVzcyB0aGVyZSBpcyBhbm90aGVyIEdlZXJ0XS4NCg0KSSdsbCBzZW5kIGEgVjIgaW4t
cmVwbHktdG8gdGhpcyB0aHJlYWQuDQoNClRoYW5rcw0KQWxleA0K
