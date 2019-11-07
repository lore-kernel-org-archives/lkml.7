Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2619DC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D916E2178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="FXzhQJWT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388411AbfKGNZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:25:49 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:5900 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726754AbfKGNZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:25:49 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA7DNNBq009619;
        Thu, 7 Nov 2019 08:25:42 -0500
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2052.outbound.protection.outlook.com [104.47.38.52])
        by mx0a-00128a01.pphosted.com with ESMTP id 2w41w6a49s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 07 Nov 2019 08:25:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbqXqRsTgtPGVz8r6r6OCgGQEqaR1U0VGVQwWJxRDJc5CfvqJNpBtXoSrAziL2iY3xlZVqsYyCBFdB80pTnzR8VXz6hJ/2MPVSEwDHWlbP7uvAtxSs4BgUWBck07m4fDCxDe4YgqY6KV+Lwse2EM+ChRopuvCQp41BioC+MP0EVbPfwWvKJbFHLJYCYVf0qUtcT5flwN1hTCef4WZm2HFkn/UmfpDb+TRaUapbJ0T2QRzz/wtfZTa1msiDOMxpsVNRj+1yWUctMmKLLFv04FNS76MF2LFmFWl8aNAgU5tgO5pd+kDmxGR+YU6q6gAr1e2XM1JKOZT2vrIfztVoVwUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBYC6y0MjuXEFY1OV53pTDZtHF65X8R7MW4qLKVpijU=;
 b=ING3i/RF1SnjN6zIuYm0PDs7ygXYZapeE1+O37s0N5jL1JuPChYCHWah2Yg4dNe+O0pq0qZBeSwM1yC8JBn6X96F3OC1B3HRRa2sP6xjBc040ZEZlJ7+jHjlV/kw4HLWVPhwEJWeuGtu3+xGTxzjfyLwxNozOG4Vj9hi+PCqoe6K/eyRHf7jWXjwiJRKCY2M8ePCWp2MA+PX7tkhvWofFrgu8SkQT980bW5uh7xw+NuHQaYi20Gxme4I4JM17jYJtGWgKFPDgI20r0DogfcDkaltqoMjD1pOQ8TD47X978qg2LFhZee3nIBGD7F5DsWFHH/2Jipll4gEkfeCUiiA/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBYC6y0MjuXEFY1OV53pTDZtHF65X8R7MW4qLKVpijU=;
 b=FXzhQJWTaFwiLTlB4ZZsGdRTfAfoM55Hfxku/emvYudwgvgx/DEyETTIW4mRlrc+hT6uXIBe+UyF/SXNsBL1qwJOx9Ey2GKRn+1ioMKLJWdbhGmXJTq++QtIWkExDqvGzD2Sh0ANjga15CQqoP3L2FlkMENUX3w0ylhdEv2f3tE=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5319.namprd03.prod.outlook.com (20.180.13.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Thu, 7 Nov 2019 13:25:39 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c%3]) with mapi id 15.20.2430.020; Thu, 7 Nov 2019
 13:25:38 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>
CC:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jsarha@ti.com" <jsarha@ti.com>, "ce3a@gmx.de" <ce3a@gmx.de>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
Subject: Re: [PATCH] clk: clk-gpio: Add dt option to propagate rate change to
 parent
Thread-Topic: [PATCH] clk: clk-gpio: Add dt option to propagate rate change to
 parent
Thread-Index: AQHVlJZjqNZ+PQlo4UajtQS9MSYTgad+ve6AgAD2yoA=
Date:   Thu, 7 Nov 2019 13:25:38 +0000
Message-ID: <f3992013a3811ec2292e3da403841cb6e5cb95b5.camel@analog.com>
References: <20191106113551.5557-1-alexandru.ardelean@analog.com>
         <20191106224306.A85342173E@mail.kernel.org>
In-Reply-To: <20191106224306.A85342173E@mail.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0d5bb7b8-4e82-479b-4b84-08d76385fb0a
x-ms-traffictypediagnostic: CH2PR03MB5319:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB53195C7B16ACA97B8AE5EE16F9780@CH2PR03MB5319.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(366004)(396003)(136003)(54094003)(189003)(199004)(6512007)(7736002)(26005)(305945005)(6486002)(14454004)(6506007)(76176011)(86362001)(99286004)(118296001)(6246003)(966005)(25786009)(229853002)(102836004)(76116006)(6306002)(6436002)(64756008)(66446008)(66556008)(3846002)(66946007)(478600001)(66476007)(486006)(6116002)(2201001)(446003)(11346002)(110136005)(316002)(8676002)(256004)(5660300002)(2906002)(2501003)(4326008)(54906003)(81156014)(66066001)(81166006)(186003)(14444005)(5024004)(476003)(8936002)(71200400001)(71190400001)(36756003)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5319;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SloFqz0ch8rPl+9tcj53ZeQeYt+uyNJkIpq+eOxCNAJGtclckzOSjhUk/OqgGqTrM5tn/ahyvyhi5ri+90rPoSzINHzJ9a34U3WwJm7TCmRE58hrcub8kxiGosOFvS3R2RYfNCifeK8LFmZHcLpkqH7uGVIzj1ZEtc8l3tKxn8s0Wq6b3LkGweAByWT5RF78T8C4i8HhZ6duQWvIgWeZM4sR3Lx2V+eArUEdxukNRkAyAEk+x7FATc70R+fWn8gvsRTiLQwb7tJbCB5ZqU6MVEBN3IIJOudpl28DiJUm2rx9M/O72GXLN/3SSJSRRYt8NYdr5cU+G/lKcJi6JCRiHyUT0B6L41xNKVqm+NbTYDLnW3y+iJd+w3hg2AlV5UtYlTthctrNYeOiKfJorD5Zd/8IV+xnjuN+Ulqb6mqXMQ5q9nNQbCSUXACW1OeeGi6mIpHjUYIQzUpUUb0kdw31zi1X+W7vAtaGbxaJKH2qa38=
Content-Type: text/plain; charset="utf-8"
Content-ID: <08DD857E66EEB14BAE766CC478A4A5D1@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5bb7b8-4e82-479b-4b84-08d76385fb0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 13:25:38.8267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l4shrXY+tDAeynl0a9Alqrkk8zNRhGxV5KK3KB1Jfg/YKHdGoU+/ch/HuwuNXFgE8m5NgFWaQZM1+WN8zZSgxQgZGksXr+wWWZxBeW/dK5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5319
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-07_04:2019-11-07,2019-11-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911070135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTExLTA2IGF0IDE0OjQzIC0wODAwLCBTdGVwaGVuIEJveWQgd3JvdGU6DQo+
IFF1b3RpbmcgQWxleGFuZHJ1IEFyZGVsZWFuICgyMDE5LTExLTA2IDAzOjM1OjUxKQ0KPiA+IEZy
b206IE1pY2hhZWwgSGVubmVyaWNoIDxtaWNoYWVsLmhlbm5lcmljaEBhbmFsb2cuY29tPg0KPiA+
IA0KPiA+IEZvciBjZXJ0YWluIHNldHVwcy9ib2FyZHMgaXQncyB1c2VmdWwgdG8gcHJvcGFnYXRl
IHRoZSByYXRlIGNoYW5nZSBvZg0KPiA+IHRoZQ0KPiA+IGNsb2NrIHVwIG9uZSBsZXZlbCB0byB0
aGUgcGFyZW50IGNsb2NrLg0KPiA+IA0KPiA+IFRoaXMgY2hhbmdlIGltcGxlbWVudHMgdGhpcyBi
eSBkZWZpbmluZyBhIGBjbGstc2V0LXJhdGUtcGFyZW50YCBkZXZpY2UtDQo+ID4gdHJlZQ0KPiA+
IHByb3BlcnR5IHdoaWNoIHNldHMgdGhlIGBDTEtfU0VUX1JBVEVfUEFSRU5UYCBmbGFnIHRvIHRo
ZSBjbG9jayAod2hlbg0KPiA+IHNldCkuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTWljaGFl
bCBIZW5uZXJpY2ggPG1pY2hhZWwuaGVubmVyaWNoQGFuYWxvZy5jb20+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgZHJpdmVycy9jbGsvY2xrLWdwaW8uYyB8IDggKysrKysrLS0NCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvY2xrLWdwaW8uYyBiL2RyaXZlcnMvY2xrL2Nsay1n
cGlvLmMNCj4gPiBpbmRleCA5ZDkzMGVkZDY1MTYuLjZkZmJjNGI5NTJmZSAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2Nsay9jbGstZ3Bpby5jDQo+ID4gKysrIGIvZHJpdmVycy9jbGsvY2xrLWdw
aW8uYw0KPiA+IEBAIC0yNDEsNiArMjQxLDcgQEAgc3RhdGljIGludCBncGlvX2Nsa19kcml2ZXJf
cHJvYmUoc3RydWN0DQo+ID4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAgICAgICAgc3Ry
dWN0IGRldmljZV9ub2RlICpub2RlID0gcGRldi0+ZGV2Lm9mX25vZGU7DQo+ID4gICAgICAgICBj
b25zdCBjaGFyICoqcGFyZW50X25hbWVzLCAqZ3Bpb19uYW1lOw0KPiA+ICAgICAgICAgdW5zaWdu
ZWQgaW50IG51bV9wYXJlbnRzOw0KPiA+ICsgICAgICAgdW5zaWduZWQgbG9uZyBjbGtfZmxhZ3M7
DQo+ID4gICAgICAgICBzdHJ1Y3QgZ3Bpb19kZXNjICpncGlvZDsNCj4gPiAgICAgICAgIHN0cnVj
dCBjbGsgKmNsazsNCj4gPiAgICAgICAgIGJvb2wgaXNfbXV4Ow0KPiA+IEBAIC0yNzQsMTMgKzI3
NSwxNiBAQCBzdGF0aWMgaW50IGdwaW9fY2xrX2RyaXZlcl9wcm9iZShzdHJ1Y3QNCj4gPiBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4g
ICAgICAgICB9DQo+ID4gIA0KPiA+ICsgICAgICAgY2xrX2ZsYWdzID0gb2ZfcHJvcGVydHlfcmVh
ZF9ib29sKG5vZGUsICJjbGstc2V0LXJhdGUtcGFyZW50IikNCj4gPiA/DQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgQ0xLX1NFVF9SQVRFX1BBUkVOVCA6IDA7DQo+IA0KPiBJcyB0aGVyZSBh
IERUIGJpbmRpbmcgdXBkYXRlIHNvbWV3aGVyZT8gSXQgbG9va3MgbGlrZSBhIGxpbnV4LWlzbSBm
cm9tDQoNCkdvb2QgcG9pbnQuIEkgZGlkIG5vdCB0aGluayBhYm91dCB0aGUgRFQsIGFuZCBJIGd1
ZXNzIEkgZGlkbid0IHNlYXJjaCBpdA0KdGhvcm91Z2hseSBlbm91Z2guIEZvdW5kIERUIGZpbGVz
IG5vdy4NCg0KPiB0aGUgRFQgcGVyc3BlY3RpdmUuIEkgd29uZGVyIGlmIHdlIGNhbiBzb21laG93
IGZpZ3VyZSBvdXQgdGhhdCBpdCdzIE9LDQo+IHRvIGNhbGwgY2xrX3NldF9yYXRlKCkgb24gdGhl
IHBhcmVudCBoZXJlPyBPciBpcyBpdCBzYWZlIHRvIGFzc3VtZSB0aGF0DQo+IHdlIGNhbiBqdXN0
IGFsd2F5cyBjYWxsIHNldCByYXRlIG9uIHRoZSBwYXJlbnQ/IEkgdGhpbmsgZm9yIGEgZ2F0ZSBp
dCdzDQo+IGdvb2QgYW5kIHdlIGNhbiBqdXN0IGRvIHNvLCBidXQgZm9yIGEgbXV4IG1heWJlIG5v
dC4gQ2FyZSB0byBkZXNjcmliZQ0KPiB5b3VyIHNjZW5hcmlvIGEgbGl0dGxlIG1vcmUgc28gd2Ug
Y2FuIHVuZGVyc3RhbmQgd2h5IHlvdSB3YW50IHRvIHNldA0KPiB0aGlzIGZsYWc/IElzIGl0IGZv
ciBhIG11eCBvciBhIGdhdGUgdHlwZSBncGlvPw0KPiANCg0KRm9yIG91ciBjYXNlIHdlIGFyZSB1
c2luZyBpdCBoZXJlIFt3aXRoIGEgc2xpZ2h0IG5hbWUgdmFyaWF0aW9uIGluIHRoZSBwcm9wDQpu
YW1lXToNCmh0dHBzOi8vZ2l0aHViLmNvbS9hbmFsb2dkZXZpY2VzaW5jL2xpbnV4L2Jsb2IvbWFz
dGVyL2FyY2gvYXJtL2Jvb3QvZHRzL3p5bnEtYWRydjkzNjEtejcwMzUuZHRzaSNMNDMNCg0KQW5k
IG9uIHRoaXMgYm9hcmQ6DQpodHRwczovL3dpa2kuYW5hbG9nLmNvbS9yZXNvdXJjZXMvZXZhbC91
c2VyLWd1aWRlcy9hZHJ2OTM2eF9yZnNvbS91c2VyLWd1aWRlL2ludHJvZHVjdGlvbg0KDQpJdCdz
IGZvciBhIGdhdGUtdHlwZSBHUElPLg0KVGhlIGNsb2NrIGRlZmluZWQgaW4gdGhhdCBEVCAoYWQ5
MzYxX2Nsa2luKSBpcyBhdHRhY2hlZCB0byBhIGNsb2NrIHRoYXQgaGFzDQphIGZpeGVkIHJhdGUg
KHhvXzQwbWh6X2ZpeGVkX2NsayksIHRoYXQgY2FuIGJlY29tZSBhIHZhcmlhYmxlIHJhdGUgW2Zy
b20gYW4NCmV4dGVybmFsIHNvdXJjZSwgd2hlbiBpdCBpcyBwcm92aWRlZF0uDQoNCk91ciB1bmRl
cnN0YW5kaW5nLCBpcyB0aGF0IGEgR1BJTyBnYXRlIGNsb2NrIHNob3VsZCBwcm9wYWdhdGUgdGhl
IHJhdGUNCmNoYW5nZSB0byB0aGUgcGFyZW50IGNsb2NrLiBUaGUgc2FtZSBnb2VzIGZvciB0aGUg
R1BJTyBNVVggY2xvY2suDQpTbywgdGhlIGRlZmF1bHQgbW9kZSB3b3VsZCBiZSB0byBhbHdheXMg
c2V0IENMS19TRVRfUkFURV9QQVJFTlQuDQoNCkJ1dCwgZ2l2ZW4gdGhhdCB0aGVyZSBhcmUgdXNl
cnMgb2YgdGhpcyBkcml2ZXIsIHN1Y2ggYSBiZWhhdmlvciBjaGFuZ2UNCmNvdWxkIGJyZWFrIG90
aGVyIHVzZXJzLCBzbyB3ZSBhcmUgdXNpbmcgdGhpcyBEVCBwcm9wLg0KDQpUaGVyZSBzZWVtcyB0
byBiZSBvbmx5IG9uZSB1c2VyIG9mIGdwaW8tbXV4LWNsb2NrIGluDQphcmNoL2FybTY0L2Jvb3Qv
ZHRzL3JlbmVzYXMvdWxjYi1rZi5kdHNpDQoNCldoZXJlYXMgZm9yIGdwaW8tZ2F0ZS1jbG9jaywg
dGhlcmUgYXJlIG11bHRpcGxlIHVzZXJzLiBJIGNhbid0IHNheSB3aGV0aGVyDQp0aGlzIGNoYW5n
ZSB3b3VsZCBicmVhayBhbnl0aGluZyBmb3IgdGhlbSwgb3IgaXQgd291bGQgYmUgZmluZS4NCg==
