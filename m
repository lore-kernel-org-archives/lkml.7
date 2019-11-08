Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11602C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 07:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25C32087E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 07:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="DTRPb7Hk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbfKHHKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 02:10:40 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:61482 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729896AbfKHHKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 02:10:40 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA877t0u009121;
        Fri, 8 Nov 2019 02:10:32 -0500
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2052.outbound.protection.outlook.com [104.47.32.52])
        by mx0b-00128a01.pphosted.com with ESMTP id 2w41vkws1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Nov 2019 02:10:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3qwDDlJ9cs4npUBAn3zDSQEk2exdBaN8inlsICzjVuT0ro44U+XEAe5BH9Sr9HRu42B4Y7kr0XyB/OPODFdJ5s0Zf7g23kXzauKsPr4zdKs+FNLxLzNr5hfTpuwE3GE3eBIHt6v6F+tSX47G+udn0ZGBiiLwKjWF7k8tf8Ze1FgkOLQG3Qnf5XGh9vEeTdWbL0tlenVMTSfIphCZEbx7pFrE8kQ8WErYZ3SMKDG19hmJz5ujy9JaZii1ZdBCK/MCY7XpbRDBEKQD9r4m1YtQkqJr7lKzRydUP67Cv3eh10Cxe6hNosW8kuseWFaL7Xk8VnS8aLRys1gktmYgyRoow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2w5NWPRJQ+TQS5KAulYGFYBAiZM8C/tXOWeIOYDNgI=;
 b=kaq3wJgVYLSSIVFjZA/My1JzkTYnEdBrUHXK0UDzJOzWjeD4O8SaZH4k/dYQksaiB6fYlaLbEtKaAWo9eDfJonpVOlwtVBuBiJC7XVsWrOxYvWOZ6RNU0eLZtgH3Qu2BWIu2T3iaE7bA2/YzBYWYQbCl5j0XAY0DMqQfdKzob5Uuz3/f1X0z3XEzvg8IeLkUv94PDjOFXh6Vz9UdQQyhfTGZbS3+8zaRMK+uFm53Jte4E8uNPj+OBpufWGPQTvD5zGhG3/w4yiyhuDxsGVweefunuUHEMlt7Rjsfrx2MXnFzJSPECbguRCo6r01GccT4Y5onuwaXbTiMrH3+PmpyCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2w5NWPRJQ+TQS5KAulYGFYBAiZM8C/tXOWeIOYDNgI=;
 b=DTRPb7HkNxEA0ODFsobCqKlz4C+AVwIIhjtF6qd8/GltWx5q/N/SLPMKa1gJon9mC+fiSm6BZgQAwC7ousxDZDeM5E6H9UvdeOUObDMUtUluYI/FS/wsbS/azZIotI7KrC3vwmH/H4af5sbpXVV1psNVOAQ58vLQVDxzB9TTAak=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5189.namprd03.prod.outlook.com (20.180.4.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Fri, 8 Nov 2019 07:10:30 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c%3]) with mapi id 15.20.2430.023; Fri, 8 Nov 2019
 07:10:30 +0000
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
Thread-Index: AQHVlJZjqNZ+PQlo4UajtQS9MSYTgad+ve6AgAD2yoCAAJ5eAIAAhW2AgAAFu4A=
Date:   Fri, 8 Nov 2019 07:10:29 +0000
Message-ID: <9f3988fc28a7a113661ec27a9cf5984a29751ede.camel@analog.com>
References: <20191106113551.5557-1-alexandru.ardelean@analog.com>
         <20191106224306.A85342173E@mail.kernel.org>
         <f3992013a3811ec2292e3da403841cb6e5cb95b5.camel@analog.com>
         <20191107225313.4ED9D21D7B@mail.kernel.org>
         <51dbe8f43753ca52b9732aa1f099d3499391f643.camel@analog.com>
In-Reply-To: <51dbe8f43753ca52b9732aa1f099d3499391f643.camel@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 51581221-a42c-4afc-654e-08d7641abd17
x-ms-traffictypediagnostic: CH2PR03MB5189:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB518950CFB44B65268C7DF17BF97B0@CH2PR03MB5189.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(396003)(39860400002)(376002)(54094003)(199004)(189003)(5024004)(8936002)(6436002)(186003)(25786009)(478600001)(102836004)(26005)(14444005)(966005)(71200400001)(71190400001)(256004)(6506007)(76116006)(118296001)(5660300002)(6306002)(76176011)(305945005)(14454004)(7736002)(6486002)(229853002)(8676002)(99286004)(6512007)(81156014)(81166006)(486006)(2906002)(2501003)(2616005)(476003)(86362001)(110136005)(54906003)(3846002)(316002)(6116002)(6246003)(66066001)(11346002)(66446008)(66946007)(4326008)(64756008)(66556008)(66476007)(2201001)(36756003)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5189;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g+If3kHaew4U9UqvlJs8Y7wEHaYJMK5dtKjsEyG5PMWC+WsJfyQh9nrmpENnla7nKPV9GG3iBgbLNkK2LECPngCmORaD+mH83E0mwTK3saZU7uFviEkzN9WKglu+8siwwgYw8m+t+66A5pasopiNzY393lJe9GlsuZq0tf5L9u8qLK+pnBYoY2uj/OqC/N60oQxKuDv+IzEtnEop4wywmD7C6jJfi5prC2SYyo7W1tjehd+Mi6leVG74pThuRN2MNwhu8rXgASxXETxznTyBpi9gF8ZALdvDS98vALqsOD1p6cq8aAKfSfhIIiAMQ38umgW+8jwk9BIXo9pa+lNQ8Ca25cYqrheiXJALc1YsOOScBVbcHHTRLHARPmEi7XYUsYQPCC2DTtx4jZsOZLyYN8pqdU5PZVIVxJkRH0oiT0qHx5ZfOq3e9ZCkkgBfk8zqo6Qzq5Ed4ch6rtggWHMg+6EEgs8DfN4u66izV3Z6Rnc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C293116CC9A1B54EBDF51DC077AF487B@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51581221-a42c-4afc-654e-08d7641abd17
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 07:10:29.8926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JrkWFjT2phXWvTu5vrEZMI1drDFLDFiejNXukG9rqL0NbnDWpZ2/yXsPmk8RM/bk+QhI3LRLUM0POOcYfL84/AsJoHrO9IlQQmeM5VIZXh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5189
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-08_01:2019-11-07,2019-11-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911080070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTExLTA4IGF0IDA2OjUwICswMDAwLCBBcmRlbGVhbiwgQWxleGFuZHJ1IHdy
b3RlOg0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBUaHUsIDIwMTktMTEtMDcgYXQgMTQ6NTMgLTA4
MDAsIFN0ZXBoZW4gQm95ZCB3cm90ZToNCj4gPiBRdW90aW5nIEFyZGVsZWFuLCBBbGV4YW5kcnUg
KDIwMTktMTEtMDcgMDU6MjU6MzgpDQo+ID4gPiBPbiBXZWQsIDIwMTktMTEtMDYgYXQgMTQ6NDMg
LTA4MDAsIFN0ZXBoZW4gQm95ZCB3cm90ZToNCj4gPiA+ID4gUXVvdGluZyBBbGV4YW5kcnUgQXJk
ZWxlYW4gKDIwMTktMTEtMDYgMDM6MzU6NTEpDQo+ID4gPiA+ID4gRnJvbTogTWljaGFlbCBIZW5u
ZXJpY2ggPG1pY2hhZWwuaGVubmVyaWNoQGFuYWxvZy5jb20+DQo+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gRm9yIGNlcnRhaW4gc2V0dXBzL2JvYXJkcyBpdCdzIHVzZWZ1bCB0byBwcm9wYWdhdGUgdGhl
IHJhdGUNCj4gPiA+ID4gPiBjaGFuZ2UNCj4gPiA+ID4gPiBvZg0KPiA+ID4gPiA+IHRoZQ0KPiA+
ID4gPiA+IGNsb2NrIHVwIG9uZSBsZXZlbCB0byB0aGUgcGFyZW50IGNsb2NrLg0KPiA+ID4gPiA+
IA0KPiA+ID4gPiA+IFRoaXMgY2hhbmdlIGltcGxlbWVudHMgdGhpcyBieSBkZWZpbmluZyBhIGBj
bGstc2V0LXJhdGUtcGFyZW50YA0KPiA+ID4gPiA+IGRldmljZS0NCj4gPiA+ID4gPiB0cmVlDQo+
ID4gPiA+ID4gcHJvcGVydHkgd2hpY2ggc2V0cyB0aGUgYENMS19TRVRfUkFURV9QQVJFTlRgIGZs
YWcgdG8gdGhlIGNsb2NrDQo+ID4gPiA+ID4gKHdoZW4NCj4gPiA+ID4gPiBzZXQpLg0KPiA+ID4g
PiA+IA0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgSGVubmVyaWNoIDxtaWNoYWVs
Lmhlbm5lcmljaEBhbmFsb2cuY29tPg0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRy
dSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQo+ID4gPiA+ID4gLS0t
DQo+ID4gPiA+ID4gIGRyaXZlcnMvY2xrL2Nsay1ncGlvLmMgfCA4ICsrKysrKy0tDQo+ID4gPiA+
ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2Nsay1ncGlvLmMgYi9k
cml2ZXJzL2Nsay9jbGstZ3Bpby5jDQo+ID4gPiA+ID4gaW5kZXggOWQ5MzBlZGQ2NTE2Li42ZGZi
YzRiOTUyZmUgMTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9jbGsvY2xrLWdwaW8uYw0K
PiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvY2xrL2Nsay1ncGlvLmMNCj4gPiA+ID4gPiBAQCAtMjQx
LDYgKzI0MSw3IEBAIHN0YXRpYyBpbnQgZ3Bpb19jbGtfZHJpdmVyX3Byb2JlKHN0cnVjdA0KPiA+
ID4gPiA+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiA+ID4gPiAgICAgICAgIHN0cnVjdCBk
ZXZpY2Vfbm9kZSAqbm9kZSA9IHBkZXYtPmRldi5vZl9ub2RlOw0KPiA+ID4gPiA+ICAgICAgICAg
Y29uc3QgY2hhciAqKnBhcmVudF9uYW1lcywgKmdwaW9fbmFtZTsNCj4gPiA+ID4gPiAgICAgICAg
IHVuc2lnbmVkIGludCBudW1fcGFyZW50czsNCj4gPiA+ID4gPiArICAgICAgIHVuc2lnbmVkIGxv
bmcgY2xrX2ZsYWdzOw0KPiA+ID4gPiA+ICAgICAgICAgc3RydWN0IGdwaW9fZGVzYyAqZ3Bpb2Q7
DQo+ID4gPiA+ID4gICAgICAgICBzdHJ1Y3QgY2xrICpjbGs7DQo+ID4gPiA+ID4gICAgICAgICBi
b29sIGlzX211eDsNCj4gPiA+ID4gPiBAQCAtMjc0LDEzICsyNzUsMTYgQEAgc3RhdGljIGludCBn
cGlvX2Nsa19kcml2ZXJfcHJvYmUoc3RydWN0DQo+ID4gPiA+ID4gcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KPiA+ID4gPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ID4gPiA+ICAg
ICAgICAgfQ0KPiA+ID4gPiA+ICANCj4gPiA+ID4gPiArICAgICAgIGNsa19mbGFncyA9IG9mX3By
b3BlcnR5X3JlYWRfYm9vbChub2RlLCAiY2xrLXNldC1yYXRlLQ0KPiA+ID4gPiA+IHBhcmVudCIp
DQo+ID4gPiA+ID4gPw0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIENMS19TRVRf
UkFURV9QQVJFTlQgOiAwOw0KPiA+ID4gPiANCj4gPiA+ID4gSXMgdGhlcmUgYSBEVCBiaW5kaW5n
IHVwZGF0ZSBzb21ld2hlcmU/IEl0IGxvb2tzIGxpa2UgYSBsaW51eC1pc20NCj4gPiA+ID4gZnJv
bQ0KPiA+ID4gDQo+ID4gPiBHb29kIHBvaW50LiBJIGRpZCBub3QgdGhpbmsgYWJvdXQgdGhlIERU
LCBhbmQgSSBndWVzcyBJIGRpZG4ndCBzZWFyY2gNCj4gPiA+IGl0DQo+ID4gPiB0aG9yb3VnaGx5
IGVub3VnaC4gRm91bmQgRFQgZmlsZXMgbm93Lg0KPiA+ID4gDQo+ID4gPiA+IHRoZSBEVCBwZXJz
cGVjdGl2ZS4gSSB3b25kZXIgaWYgd2UgY2FuIHNvbWVob3cgZmlndXJlIG91dCB0aGF0IGl0J3MN
Cj4gPiA+ID4gT0sNCj4gPiA+ID4gdG8gY2FsbCBjbGtfc2V0X3JhdGUoKSBvbiB0aGUgcGFyZW50
IGhlcmU/IE9yIGlzIGl0IHNhZmUgdG8gYXNzdW1lDQo+ID4gPiA+IHRoYXQNCj4gPiA+ID4gd2Ug
Y2FuIGp1c3QgYWx3YXlzIGNhbGwgc2V0IHJhdGUgb24gdGhlIHBhcmVudD8gSSB0aGluayBmb3Ig
YSBnYXRlDQo+ID4gPiA+IGl0J3MNCj4gPiA+ID4gZ29vZCBhbmQgd2UgY2FuIGp1c3QgZG8gc28s
IGJ1dCBmb3IgYSBtdXggbWF5YmUgbm90LiBDYXJlIHRvDQo+ID4gPiA+IGRlc2NyaWJlDQo+ID4g
PiA+IHlvdXIgc2NlbmFyaW8gYSBsaXR0bGUgbW9yZSBzbyB3ZSBjYW4gdW5kZXJzdGFuZCB3aHkg
eW91IHdhbnQgdG8NCj4gPiA+ID4gc2V0DQo+ID4gPiA+IHRoaXMgZmxhZz8gSXMgaXQgZm9yIGEg
bXV4IG9yIGEgZ2F0ZSB0eXBlIGdwaW8/DQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBGb3Igb3Vy
IGNhc2Ugd2UgYXJlIHVzaW5nIGl0IGhlcmUgW3dpdGggYSBzbGlnaHQgbmFtZSB2YXJpYXRpb24g
aW4NCj4gPiA+IHRoZQ0KPiA+ID4gcHJvcA0KPiA+ID4gbmFtZV06DQo+ID4gPiBodHRwczovL2dp
dGh1Yi5jb20vYW5hbG9nZGV2aWNlc2luYy9saW51eC9ibG9iL21hc3Rlci9hcmNoL2FybS9ib290
L2R0cy96eW5xLWFkcnY5MzYxLXo3MDM1LmR0c2kjTDQzDQo+ID4gPiANCj4gPiA+IEFuZCBvbiB0
aGlzIGJvYXJkOg0KPiA+ID4gaHR0cHM6Ly93aWtpLmFuYWxvZy5jb20vcmVzb3VyY2VzL2V2YWwv
dXNlci1ndWlkZXMvYWRydjkzNnhfcmZzb20vdXNlci1ndWlkZS9pbnRyb2R1Y3Rpb24NCj4gPiA+
IA0KPiA+ID4gSXQncyBmb3IgYSBnYXRlLXR5cGUgR1BJTy4NCj4gPiA+IFRoZSBjbG9jayBkZWZp
bmVkIGluIHRoYXQgRFQgKGFkOTM2MV9jbGtpbikgaXMgYXR0YWNoZWQgdG8gYSBjbG9jaw0KPiA+
ID4gdGhhdA0KPiA+ID4gaGFzDQo+ID4gPiBhIGZpeGVkIHJhdGUgKHhvXzQwbWh6X2ZpeGVkX2Ns
ayksIHRoYXQgY2FuIGJlY29tZSBhIHZhcmlhYmxlIHJhdGUNCj4gPiA+IFtmcm9tIGFuDQo+ID4g
PiBleHRlcm5hbCBzb3VyY2UsIHdoZW4gaXQgaXMgcHJvdmlkZWRdLg0KPiA+ID4gDQo+ID4gPiBP
dXIgdW5kZXJzdGFuZGluZywgaXMgdGhhdCBhIEdQSU8gZ2F0ZSBjbG9jayBzaG91bGQgcHJvcGFn
YXRlIHRoZQ0KPiA+ID4gcmF0ZQ0KPiA+ID4gY2hhbmdlIHRvIHRoZSBwYXJlbnQgY2xvY2suIFRo
ZSBzYW1lIGdvZXMgZm9yIHRoZSBHUElPIE1VWCBjbG9jay4NCj4gPiA+IFNvLCB0aGUgZGVmYXVs
dCBtb2RlIHdvdWxkIGJlIHRvIGFsd2F5cyBzZXQgQ0xLX1NFVF9SQVRFX1BBUkVOVC4NCj4gPiA+
IA0KPiA+ID4gQnV0LCBnaXZlbiB0aGF0IHRoZXJlIGFyZSB1c2VycyBvZiB0aGlzIGRyaXZlciwg
c3VjaCBhIGJlaGF2aW9yDQo+ID4gPiBjaGFuZ2UNCj4gPiA+IGNvdWxkIGJyZWFrIG90aGVyIHVz
ZXJzLCBzbyB3ZSBhcmUgdXNpbmcgdGhpcyBEVCBwcm9wLg0KPiA+ID4gDQo+ID4gPiBUaGVyZSBz
ZWVtcyB0byBiZSBvbmx5IG9uZSB1c2VyIG9mIGdwaW8tbXV4LWNsb2NrIGluDQo+ID4gPiBhcmNo
L2FybTY0L2Jvb3QvZHRzL3JlbmVzYXMvdWxjYi1rZi5kdHNpDQo+ID4gPiANCj4gPiA+IFdoZXJl
YXMgZm9yIGdwaW8tZ2F0ZS1jbG9jaywgdGhlcmUgYXJlIG11bHRpcGxlIHVzZXJzLiBJIGNhbid0
IHNheQ0KPiA+ID4gd2hldGhlcg0KPiA+ID4gdGhpcyBjaGFuZ2Ugd291bGQgYnJlYWsgYW55dGhp
bmcgZm9yIHRoZW0sIG9yIGl0IHdvdWxkIGJlIGZpbmUuDQo+ID4gDQo+ID4gSSB0aGluayB3ZSBj
YW4ganVzdCBhZGQgQ0xLX1NFVF9SQVRFX1BBUkVOVCBmb3IgYWxsIGdwaW8gZ2F0ZSBjbGtzIHRo
ZW4NCj4gPiBhbmQgeW91J2xsIGJlIGhhcHB5PyBDYXJlIHRvIHNlbmQgdGhhdCBwYXRjaCBhbmQg
Q2MgR2VlcnQgYW5kIG90aGVyDQo+ID4gUmVuZXNhcyBtYWludGFpbmVycz8gVGhhdCBhdm9pZHMg
YW55IERUIHByb3BlcnR5IGFuZCBzaG91bGQgYmUgZmluZSBmb3INCj4gPiBhbnlvbmUgYXMgZmFy
IGFzIEkgY2FuIHRlbGwuIE1heWJlIHRoZSBpbnZlcnNlIHdpbGwgYmUgZGVzaXJlZCwgYnV0IG5v
dA0KPiA+IHdhbnRpbmcgcmF0ZSB0byBwcm9wYWdhdGUgaXMgYW4gZWRnZSBjYXNlIHRoYXQgd2Ug
bWF5IHdhbnQgdG8gY2FsbCBvdXQNCj4gPiBleHBsaWNpdGx5IGluIERUIGF0IHNvbWUgcG9pbnQg
aW4gdGhlIGZ1dHVyZSwgYnV0IHNob3VsZG4ndCB3b3JyeSBhYm91dA0KPiA+IHVudGlsIHRoZW4u
DQo+ID4gDQo+IA0KPiBXaWxsIHJlc2VuZCwgdGhhbmtzLg0KPiBHZWVydCBpcyBDQy1lZCBoZXJl
IGFzIHdlbGwgW3VubGVzcyB0aGVyZSBpcyBhbm90aGVyIEdlZXJ0XS4NCg0KT2ggcmlnaHQuDQpZ
b3UgQ0MtZWQgR2VlcnQgdGhpcyB0aW1lLiBJIGFzc3VtZWQgdGhhdCBJIGRpZCwgZnJvbSB0aGUg
Z2V0X21haW50YWluZXJzDQpzY3JpcHQuIEl0J3Mgc3RpbGwgc2VlbXMgbGlrZSBibGFjay1hcnQg
dHJ5aW5nIHRvIHNlZSBob3cgdGFnIHBlb3BsZSB3aGVuDQpzZW5kaW5nIHBhdGNoZXMuIEVzcGVj
aWFsbHkgaWYgeW91J3JlIG5ldy4NCg0KPiANCj4gSSdsbCBzZW5kIGEgVjIgaW4tcmVwbHktdG8g
dGhpcyB0aHJlYWQuDQo+IA0KPiBUaGFua3MNCj4gQWxleA0K
