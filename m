Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74606C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2138E214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="HIJPPV87";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="GktB6i1R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfKLR6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 12:58:02 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:64432 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726738AbfKLR6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:58:01 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xACHtfLM008787;
        Tue, 12 Nov 2019 09:57:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=y7Z/L/5qUToT3MXjtU/rPe58p//hhDwZEO6mvniyG1c=;
 b=HIJPPV87iRCalgywp5S6ENBVC4mxXF0c0+7Qwdl8oAnzKil6Gw366jrSSM1g5FrZMuNA
 aoU8ttMJdnKUcXntWHjFtSvc+CJDbSDsn2QChzuoM9bwortJXv8L2f90ssTkM5j9zlsC
 44U3h+O69cDzRQy0b+ns6qgE4fVQfehct6g= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2w7prjb6bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 12 Nov 2019 09:57:28 -0800
Received: from ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) by
 ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 12 Nov 2019 09:57:27 -0800
Received: from ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) by
 ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 12 Nov 2019 09:57:27 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 12 Nov 2019 09:57:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDO5JBCbs7g7/XYzpmlnxwFPvyazKf3IYkbktA70yRxKbZ062Ie4kFJeN8wRVeHYGpjdfNhLu6kWG1XViW+dmaw8cWXQi2R9w01nZhelSvH1Dm0nm1cBQkUTMzfArzucnITAIuGVetChqH+KJo6Pav9jFSEz7LMM0JlekJt4gX2jAbs3Q7b30SSyCHZXH8bOY7G4MjPaLqyX49E0tBoGJO2smFE/NfkqhhBQJpJC/oelGvNDk10uJzlwAzoqQkEkPyWXwEwopNnzoDAzLuPwp2p2KWkzVVFTLJMWUELitcKTuOSgPU7AFDszhm5OUHp5hHo/HqPp7pTb/eNYwIvx2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7Z/L/5qUToT3MXjtU/rPe58p//hhDwZEO6mvniyG1c=;
 b=OMTOM6BA3z73Tp6nznrLH9zpf3ywPa6KrQIUcam+Ga88UrAOaNjBZ9NJhkBtib78IvbqwkIYut3AwUyuSZi1WCBmOLC76AdQo35wsYdAYPzWc2NcvNjVojEPYEoBUgbDWrwbRO5jCzfsvt6l5QPc9nKEiSgn46S64OjhNMZJzISRKljhHQVRKQ2W6VxwtJt3Rb1GnwCHrZCCFJNmagubIqogZbH+oWTddCjvW7L4SGQ6E56unH3gdBC0bTDXHC+t/IfyRFtM3k7Zj4yumP/W3iEyIIMDrKsqtW9nS5evuiHozPPUrfsagkV378KzGHpfnE46yzuDFi0GvJ9YvEMNXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7Z/L/5qUToT3MXjtU/rPe58p//hhDwZEO6mvniyG1c=;
 b=GktB6i1R30dlH46JcePtOwDb+nHrgBDNHtWLUHKFeSrIDFeFRjZ0qZ/rfW+13GRaXs0eLnEX7cAg/WatkCUK6IYFkXop/7ppo5kks7U5SmRyEv5Uh1EnShWoNNohkJbrUzQtYhREXub4BrwhYX/PfrCLKkQYM2l6k4sc7UVNkF8=
Received: from BY5PR15MB3636.namprd15.prod.outlook.com (52.133.252.91) by
 BY5PR15MB3617.namprd15.prod.outlook.com (52.133.253.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Tue, 12 Nov 2019 17:57:25 +0000
Received: from BY5PR15MB3636.namprd15.prod.outlook.com
 ([fe80::71db:9d2a:500c:d92b]) by BY5PR15MB3636.namprd15.prod.outlook.com
 ([fe80::71db:9d2a:500c:d92b%4]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 17:57:25 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     "minyard@acm.org" <minyard@acm.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cminyard@mvista.com" <cminyard@mvista.com>,
        "asmaa@mellanox.com" <asmaa@mellanox.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        Sai Dasari <sdasari@fb.com>
Subject: Re: [PATCH 1/2] drivers: ipmi: Support raw i2c packet in IPMB
Thread-Topic: [PATCH 1/2] drivers: ipmi: Support raw i2c packet in IPMB
Thread-Index: AQHVmQJfp1K9cdweJkCb8BSV+019/aeHeXcA///TrgA=
Date:   Tue, 12 Nov 2019 17:57:25 +0000
Message-ID: <493C2E64-2E41-47FF-BDA6-6EA1DA758016@fb.com>
References: <20191112023610.3644314-1-vijaykhemka@fb.com>
 <20191112123602.GD2882@minyard.net>
In-Reply-To: <20191112123602.GD2882@minyard.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::1:8011]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f1038c5-5af2-47ce-a74a-08d76799c6ba
x-ms-traffictypediagnostic: BY5PR15MB3617:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR15MB361767D1F34FEC48ECDC30B3DD770@BY5PR15MB3617.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(376002)(396003)(346002)(189003)(199004)(6506007)(81156014)(14454004)(81166006)(256004)(14444005)(6246003)(8936002)(1730700003)(5660300002)(7736002)(8676002)(102836004)(71200400001)(71190400001)(4326008)(76176011)(478600001)(6512007)(33656002)(2906002)(186003)(305945005)(5640700003)(54906003)(2501003)(446003)(6436002)(2616005)(476003)(6916009)(6486002)(76116006)(11346002)(486006)(229853002)(46003)(316002)(66946007)(86362001)(99286004)(64756008)(2351001)(6116002)(25786009)(66556008)(66476007)(36756003)(66446008);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR15MB3617;H:BY5PR15MB3636.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U4KhLL4zVeag239FIosaet4beT9oI8tSOqtLuTpkYO8o1V2WMFCJG73I6DeVUjWudZTDUlHXTMqaM6z5jJz31k7WIQ0300yvWgljw81RNzOi082bzwezDypFCX3rbKej9BBQpGcQG1ExK6rXRx7LY0+HZpgdISRiI0gFA8hfGxtcXszEoFoTWPHekJQnlt8xzJyvDd6pXKt48ib4idkxmHVC2mHWmdwBc/SVms6GrSv4PA87RIXCEVRgd8h6JMvol7KruskWpZegYHOjCM4OcZuutNjMzIapMDqy7Iw9JsauPyPjXMSz6Krs2PUGhEAbmUpN75NCPPl+46hiHCyii+Cjm/lgLRl8WOOjt8LyY2JRoMbLt87KaK17v/BmILPwxzc3KqKnaDfOvAprpMtnN8X6D2ntw8CJ80ypWMaS+lvGq6Uu1Z/OzZOO7Z5iG0+D
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C4327AA6ABB274AB511DC63CE0319AD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1038c5-5af2-47ce-a74a-08d76799c6ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 17:57:25.6084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wY3xC2QYDsQ/Mt+QJ4qPzxZ4merIwyeemmaaIRV4lbK/ANDRsQMWR6OAHb1/XxSRohxtN1b52ieTjSHuf8HQmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3617
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-12_06:2019-11-11,2019-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911120154
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDExLzEyLzE5LCA0OjM2IEFNLCAiQ29yZXkgTWlueWFyZCIgPHRjbWlueWFyZEBn
bWFpbC5jb20gb24gYmVoYWxmIG9mIG1pbnlhcmRAYWNtLm9yZz4gd3JvdGU6DQoNCiAgICBPbiBN
b24sIE5vdiAxMSwgMjAxOSBhdCAwNjozNjowOVBNIC0wODAwLCBWaWpheSBLaGVta2Egd3JvdGU6
DQogICAgPiBNYW55IElQTUIgZGV2aWNlcyBkb2Vzbid0IHN1cHBvcnQgc21idXMgcHJvdG9jb2wg
YW5kIGN1cnJlbnQgZHJpdmVyDQogICAgPiBzdXBwb3J0IG9ubHkgc21idXMgZGV2aWNlcy4gU28g
YWRkZWQgc3VwcG9ydCBmb3IgcmF3IGkyYyBwYWNrZXRzLg0KICAgIA0KICAgIEkgaGF2ZW4ndCBy
ZXZpZXdlZCB0aGlzLCByZWFsbHksIGJlY2F1c2UgSSBoYXZlIGEgbW9yZSBnZW5lcmFsDQogICAg
Y29uY2Vybi4uLg0KICAgIA0KICAgIElzIGl0IHBvc3NpYmxlIHRvIG5vdCBkbyB0aGlzIHdpdGgg
YSBjb25maWcgaXRlbT8gIENhbiB5b3UgYWRkIHNvbWV0aGluZw0KICAgIHRvIHRoZSBkZXZpY2Ug
dHJlZSBhbmQvb3IgdmlhIGFuIGlvY3RsIHRvIG1ha2UgdGhpcyBkeW5hbWljYWxseQ0KICAgIGNv
bmZpZ3VyYWJsZT8gIFRoYXQncyBtb3JlIGZsZXhpYmxlIChpdCBjYW4gc3VwcG9ydCBtaXhlZCBk
ZXZpY2VzKSBhbmQNCiAgICBpcyBmcmllbmRsaWVyIHRvIHVzZXJzIChkb24ndCBoYXZlIHRvIGdl
dCB0aGUgY29uZmlnIHJpZ2h0KS4NCkkgYWdyZWUgd2l0aCB5b3UsIEkgd2FzIGFsc28gbm90IGNv
bWZvcnRhYmxlIHVzaW5nIGNvbmZpZyBhbmQgY291bGRuJ3QgZmluZCBvdGhlciANCk9wdGlvbnMs
IEkgd2lsbCBsb29rIGludG8gbW9yZSBvcHRpb24gbm93IGFuZCB1cGRhdGUgcGF0Y2guDQogICAg
DQogICAgQ29uZmlnIGl0ZW1zIGZvciBhZGRpbmcgbmV3IGZ1bmN0aW9uYWxpdHkgYXJlIGdlbmVy
YWxseSBvay4gIENvbmZpZw0KICAgIGl0ZW1zIGZvciBjaG9vc2luZyBiZXR3ZWVuIHR3byBtdXR1
YWxseSBleGNsdXNpdmUgY2hvaWNlcyBhcmUNCiAgICBnZW5lcmFsbHkgbm90Lg0KICAgIA0KICAg
IC1jb3JleQ0KICAgIA0KICAgID4gDQogICAgPiBTaWduZWQtb2ZmLWJ5OiBWaWpheSBLaGVta2Eg
PHZpamF5a2hlbWthQGZiLmNvbT4NCiAgICA+IC0tLQ0KICAgID4gIGRyaXZlcnMvY2hhci9pcG1p
L0tjb25maWcgICAgICAgIHwgIDYgKysrKysrDQogICAgPiAgZHJpdmVycy9jaGFyL2lwbWkvaXBt
Yl9kZXZfaW50LmMgfCAzMCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiAgICA+ICAy
IGZpbGVzIGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKykNCiAgICA+IA0KICAgID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvY2hhci9pcG1pL0tjb25maWcgYi9kcml2ZXJzL2NoYXIvaXBtaS9LY29uZmln
DQogICAgPiBpbmRleCBhOWNmZTRjMDVlNjQuLmU1MjY4NDQzYjQ3OCAxMDA2NDQNCiAgICA+IC0t
LSBhL2RyaXZlcnMvY2hhci9pcG1pL0tjb25maWcNCiAgICA+ICsrKyBiL2RyaXZlcnMvY2hhci9p
cG1pL0tjb25maWcNCiAgICA+IEBAIC0xMzksMyArMTM5LDkgQEAgY29uZmlnIElQTUJfREVWSUNF
X0lOVEVSRkFDRQ0KICAgID4gIAkgIFByb3ZpZGVzIGEgZHJpdmVyIGZvciBhIGRldmljZSAoU2F0
ZWxsaXRlIE1DKSB0bw0KICAgID4gIAkgIHJlY2VpdmUgcmVxdWVzdHMgYW5kIHNlbmQgcmVzcG9u
c2VzIGJhY2sgdG8gdGhlIEJNQyB2aWENCiAgICA+ICAJICB0aGUgSVBNQiBpbnRlcmZhY2UuIFRo
aXMgbW9kdWxlIHJlcXVpcmVzIEkyQyBzdXBwb3J0Lg0KICAgID4gKw0KICAgID4gK2NvbmZpZyBJ
UE1CX1NNQlVTX0RJU0FCTEUNCiAgICA+ICsJYm9vbCAnRGlzYWJsZSBTTUJVUyBwcm90b2NvbCBm
b3Igc2VuZGluZyBwYWNrZXQgdG8gSVBNQiBkZXZpY2UnDQogICAgPiArCWRlcGVuZHMgb24gSVBN
Ql9ERVZJQ0VfSU5URVJGQUNFDQogICAgPiArCWhlbHANCiAgICA+ICsJICBwcm92aWRlcyBmdW5j
dGlvbmFsaXR5IG9mIHNlbmRpbmcgcmF3IGkyYyBwYWNrZXRzIHRvIElQTUIgZGV2aWNlLg0KICAg
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci9pcG1pL2lwbWJfZGV2X2ludC5jIGIvZHJpdmVy
cy9jaGFyL2lwbWkvaXBtYl9kZXZfaW50LmMNCiAgICA+IGluZGV4IGFlM2JmYmEyNzUyNi4uMjQx
OWI5YTkyOGIyIDEwMDY0NA0KICAgID4gLS0tIGEvZHJpdmVycy9jaGFyL2lwbWkvaXBtYl9kZXZf
aW50LmMNCiAgICA+ICsrKyBiL2RyaXZlcnMvY2hhci9pcG1pL2lwbWJfZGV2X2ludC5jDQogICAg
PiBAQCAtMTE4LDYgKzExOCwxMCBAQCBzdGF0aWMgc3NpemVfdCBpcG1iX3dyaXRlKHN0cnVjdCBm
aWxlICpmaWxlLCBjb25zdCBjaGFyIF9fdXNlciAqYnVmLA0KICAgID4gIAlzdHJ1Y3QgaXBtYl9k
ZXYgKmlwbWJfZGV2ID0gdG9faXBtYl9kZXYoZmlsZSk7DQogICAgPiAgCXU4IHJxX3NhLCBuZXRm
X3JxX2x1biwgbXNnX2xlbjsNCiAgICA+ICAJdW5pb24gaTJjX3NtYnVzX2RhdGEgZGF0YTsNCiAg
ICA+ICsjaWZkZWYgQ09ORklHX0lQTUJfU01CVVNfRElTQUJMRQ0KICAgID4gKwl1bnNpZ25lZCBj
aGFyICppMmNfYnVmOw0KICAgID4gKwlzdHJ1Y3QgaTJjX21zZyBpMmNfbXNnOw0KICAgID4gKyNl
bmRpZg0KICAgID4gIAl1OCBtc2dbTUFYX01TR19MRU5dOw0KICAgID4gIAlzc2l6ZV90IHJldDsN
CiAgICA+ICANCiAgICA+IEBAIC0xMzMsNiArMTM3LDMxIEBAIHN0YXRpYyBzc2l6ZV90IGlwbWJf
d3JpdGUoc3RydWN0IGZpbGUgKmZpbGUsIGNvbnN0IGNoYXIgX191c2VyICpidWYsDQogICAgPiAg
CXJxX3NhID0gR0VUXzdCSVRfQUREUihtc2dbUlFfU0FfOEJJVF9JRFhdKTsNCiAgICA+ICAJbmV0
Zl9ycV9sdW4gPSBtc2dbTkVURk5fTFVOX0lEWF07DQogICAgPiAgDQogICAgPiArI2lmZGVmIENP
TkZJR19JUE1CX1NNQlVTX0RJU0FCTEUNCiAgICA+ICsJLyoNCiAgICA+ICsJICogc3VidHJhY3Qg
MSBieXRlIChycV9zYSkgZnJvbSB0aGUgbGVuZ3RoIG9mIHRoZSBtc2cgcGFzc2VkIHRvDQogICAg
PiArCSAqIHJhdyBpMmNfdHJhbnNmZXINCiAgICA+ICsJICovDQogICAgPiArCW1zZ19sZW4gPSBt
c2dbSVBNQl9NU0dfTEVOX0lEWF0gLSAxOw0KICAgID4gKw0KICAgID4gKwlpMmNfYnVmID0ga3ph
bGxvYyhtc2dfbGVuLCBHRlBfS0VSTkVMKTsNCiAgICA+ICsJaWYgKCFpMmNfYnVmKQ0KICAgID4g
KwkJcmV0dXJuIC1FRkFVTFQ7DQogICAgPiArDQogICAgPiArCS8qIENvcHkgbWVzc2FnZSB0byBi
dWZmZXIgZXhjZXB0IGZpcnN0IDIgYnl0ZXMgKGxlbmd0aCBhbmQgYWRkcmVzcykgKi8NCiAgICA+
ICsJbWVtY3B5KGkyY19idWYsIG1zZysyLCBtc2dfbGVuKTsNCiAgICA+ICsNCiAgICA+ICsJaTJj
X21zZy5hZGRyID0gcnFfc2E7DQogICAgPiArCWkyY19tc2cuZmxhZ3MgPSBpcG1iX2Rldi0+Y2xp
ZW50LT5mbGFncyAmDQogICAgPiArCQkJKEkyQ19NX1RFTiB8IEkyQ19DTElFTlRfUEVDIHwgSTJD
X0NMSUVOVF9TQ0NCKTsNCiAgICA+ICsJaTJjX21zZy5sZW4gPSBtc2dfbGVuOw0KICAgID4gKwlp
MmNfbXNnLmJ1ZiA9IGkyY19idWY7DQogICAgPiArDQogICAgPiArCXJldCA9IGkyY190cmFuc2Zl
cihpcG1iX2Rldi0+Y2xpZW50LT5hZGFwdGVyLCAmaTJjX21zZywgMSk7DQogICAgPiArCWtmcmVl
KGkyY19idWYpOw0KICAgID4gKw0KICAgID4gKwlyZXR1cm4gKHJldCA9PSAxKSA/IGNvdW50IDog
cmV0Ow0KICAgID4gKyNlbHNlDQogICAgPiAgCS8qDQogICAgPiAgCSAqIHN1YnRyYWN0IHJxX3Nh
IGFuZCBuZXRmX3JxX2x1biBmcm9tIHRoZSBsZW5ndGggb2YgdGhlIG1zZyBwYXNzZWQgdG8NCiAg
ICA+ICAJICogaTJjX3NtYnVzX3hmZXINCiAgICA+IEBAIC0xNDksNiArMTc4LDcgQEAgc3RhdGlj
IHNzaXplX3QgaXBtYl93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwgY29uc3QgY2hhciBfX3VzZXIg
KmJ1ZiwNCiAgICA+ICAJCQkgICAgIEkyQ19TTUJVU19CTE9DS19EQVRBLCAmZGF0YSk7DQogICAg
PiAgDQogICAgPiAgCXJldHVybiByZXQgPyA6IGNvdW50Ow0KICAgID4gKyNlbmRpZg0KICAgID4g
IH0NCiAgICA+ICANCiAgICA+ICBzdGF0aWMgdW5zaWduZWQgaW50IGlwbWJfcG9sbChzdHJ1Y3Qg
ZmlsZSAqZmlsZSwgcG9sbF90YWJsZSAqd2FpdCkNCiAgICA+IC0tIA0KICAgID4gMi4xNy4xDQog
ICAgPiANCiAgICANCg0K
