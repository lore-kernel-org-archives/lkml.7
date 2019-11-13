Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B1DC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85297206EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="b9OZlhHS";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ZwjNZAcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKMRll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:41:41 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:28468 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbfKMRll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 12:41:41 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xADHeHdL007578;
        Wed, 13 Nov 2019 09:40:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=7YmObVeuY77PzNixCgKN8HyL71xo4/rvuQtvFOB3jdc=;
 b=b9OZlhHSlCEF1aGqMMY5tLeICPM64KWtEaPnnysi+wrU4JnQcgSVYMwsVkO4nsTqYiAX
 84k/a2B4iskHB7A1mBQ2MUvWhAhYIzIDOI/bHMAade7AAa1aQIV1gPz3CNX76fDJHGS8
 e4lAieHKDsTPNqsTc08m/42lGTPykZlNUqQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2w8n9s0dt4-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 Nov 2019 09:40:57 -0800
Received: from ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 Nov 2019 09:40:56 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 13 Nov 2019 09:40:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9TJahUAya1k6Urn/vGUrKyTdGCM6ZFnj35q6j25QNCNcRxTPdAVCBcIIGuQJ/BH+6ufKvX7L8hYVurMObeyA+Gyd4hzIRNLECTsOH5Cmf4h5wlkdshqgEel8OtHFpqh/grkvRCcipGDOZUSz7SklggYBx6bpMpK/h8e0o8sgfdfj7e/lzo5zer3tM+BAyW0U13U6UjF8Z1IxUC4ddY/I5XBX4KHRpnFaz13tRiJ6l3OxKy2Dk0axUHtBjKaGXAiKiGvh7voe/3oVKfoBqwMjZ4ISRf922RKTPTjUOxJ9IUeLuhpTolJxAHti8P3Msgozs9VhXmQ30MYbcoG/cx0hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YmObVeuY77PzNixCgKN8HyL71xo4/rvuQtvFOB3jdc=;
 b=kWUtS4J7kqYyk4JQxTqhipd5xCCp8wSEbF+e1WK8MVltCcVpmX4eiO+z5GqdAlqDkTb0SLyb6a/LEHOeHz7uguktU4gGwDU1J4CCOIBZZ2YHLKKMdbcfapL9a1bPgmdWIFaoaPN/SX1FF7PlZqrX/mTvg42+v6WA5jLHCBc2OYRM+5ANLdJ0ZWQysoh4nLfZSPa4wDII9p1iooX7GQat9FTPFPavPxLOsYYnuLr0f3o5fT6mmcQHIFX6KDvGnsNuSz06F0OnTStSj3VeKU4B26iUgLdMy9u4inw+Y/Y/7SEaXcfjwnoHAOXg50Q2kKRu05RbOrh15XYv9Q0TZNXyxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YmObVeuY77PzNixCgKN8HyL71xo4/rvuQtvFOB3jdc=;
 b=ZwjNZAcBZG7p6E8HfJZpWjlDcHkgojOKew+/96Wzvy9tFasfJQyNEn9Eduq9hnC5+F1ya4kOGkKZwbK4BWnJjgO4ShOHlM3o0wgmzhZrPByh01n/il1NnjbUcZfw31HMYRfB4dn7VrTrY9uBvkDOol4NK967P9fWopnIrdDGoGg=
Received: from BY5PR15MB3636.namprd15.prod.outlook.com (52.133.252.91) by
 BY5PR15MB3521.namprd15.prod.outlook.com (10.255.245.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Wed, 13 Nov 2019 17:40:55 +0000
Received: from BY5PR15MB3636.namprd15.prod.outlook.com
 ([fe80::71db:9d2a:500c:d92b]) by BY5PR15MB3636.namprd15.prod.outlook.com
 ([fe80::71db:9d2a:500c:d92b%4]) with mapi id 15.20.2430.027; Wed, 13 Nov 2019
 17:40:55 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     "minyard@acm.org" <minyard@acm.org>,
        Asmaa Mnebhi <Asmaa@mellanox.com>
CC:     "cminyard@mvista.com" <cminyard@mvista.com>,
        Sai Dasari <sdasari@fb.com>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>
Subject: Re: [Openipmi-developer] [PATCH 2/2] drivers: ipmi: Modify max length
 of IPMB packet
Thread-Topic: [Openipmi-developer] [PATCH 2/2] drivers: ipmi: Modify max
 length of IPMB packet
Thread-Index: AQHVmQJeBnbge6VCjUulKeqNucSkKaeHfQWA///xaoCAAI9UAIAAGvMAgAAuLICAAJP9gA==
Date:   Wed, 13 Nov 2019 17:40:55 +0000
Message-ID: <C9D94D1B-A992-425E-826F-3BDA98E26999@fb.com>
References: <20191112023610.3644314-1-vijaykhemka@fb.com>
 <20191112023610.3644314-2-vijaykhemka@fb.com>
 <20191112124845.GE2882@minyard.net>
 <7BC487D6-6ACA-46CE-A751-8367FEDEE647@fb.com>
 <20191112202932.GJ2882@minyard.net>
 <DB6PR0501MB27127CF534336BDEB5D005FFDA770@DB6PR0501MB2712.eurprd05.prod.outlook.com>
 <20191113005115.GK2882@minyard.net>
In-Reply-To: <20191113005115.GK2882@minyard.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::63b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ef4f693-0fc1-4d66-01a9-08d76860a303
x-ms-traffictypediagnostic: BY5PR15MB3521:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR15MB35215A5F086DFB941DBE983EDD760@BY5PR15MB3521.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(366004)(39860400002)(346002)(396003)(13464003)(189003)(199004)(33656002)(14454004)(86362001)(6486002)(478600001)(81166006)(6306002)(81156014)(76116006)(8676002)(6512007)(4326008)(66476007)(36756003)(6246003)(186003)(6436002)(966005)(99286004)(64756008)(66446008)(66946007)(66556008)(14444005)(102836004)(53546011)(6506007)(256004)(6116002)(71190400001)(71200400001)(5660300002)(11346002)(446003)(476003)(2616005)(46003)(486006)(2501003)(2906002)(54906003)(229853002)(8936002)(316002)(305945005)(7736002)(25786009)(76176011)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR15MB3521;H:BY5PR15MB3636.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B4zYf7VTM4zbVv2uJ7HX2MKOo5IPV2bNGoRXz7dxERH03j7B7GZXHOtqjjTOW/LnZ6qGVWBgHEUAoumGSAh+zBsnr20hs3c1oqr9Y6e5egqKNyBZKJVmoNl5ih/W8n0oVA88umx7yKpquI7wlPvAOaHgBUhTJxQBUJCYXapm2roh5daWGU1bbdd50ydT5r3wplFZuLZxqFMeENl1BvoFjFzaQuH7bF+qAht2ex46um5BWIV84GNKoZ3xJU5LmZj/epvq0zobAz6u8H2fIWBkvOOc19weUkkdtc3SiYcBK6MHt4Jv1+7k4BfNTWvHbnKy3xyIVk/4aJrW6tg0seGxOc9w32bEES9tNFB0GBbCe+fUa6NVV6tjtS8qhpogq8G/kq1blP5wj2ekQGZ/uQb2IQgklx9B1I6tNuUKSCIfhaHfktgpvINKTtsG/9UIt6G+
Content-Type: text/plain; charset="utf-8"
Content-ID: <7685C4B590313B4FAE4F17A39880C86A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef4f693-0fc1-4d66-01a9-08d76860a303
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 17:40:55.6387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I7FCi2+2QX2O6PUqxk73co3C65g/MZ1+lU0JiXR93uEfsLcpwTbevIukhd+MOvp8kzkcWEgWRIVUgBAzOYrhtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3521
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-13_04:2019-11-13,2019-11-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 mlxscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911130152
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDExLzEyLzE5LCA0OjUxIFBNLCAiQ29yZXkgTWlueWFyZCIgPHRjbWlueWFyZEBn
bWFpbC5jb20gb24gYmVoYWxmIG9mIG1pbnlhcmRAYWNtLm9yZz4gd3JvdGU6DQoNCiAgICBPbiBU
dWUsIE5vdiAxMiwgMjAxOSBhdCAxMDowNjowMFBNICswMDAwLCBBc21hYSBNbmViaGkgd3JvdGU6
DQogICAgPiBBbHNvLCBsZXQgbWUgY2xhcmlmeSBvbmUgdGhpbmcuIEl0IGRvZXNuJ3QgbWF0dGVy
IGhvdyBiaWcgdGhlIHJlc3BvbnNlIGlzLiBJbiBteSB0ZXN0aW5nLCBJIGFsc28gaGFkIHNvbWUg
cmVzcG9uc2VzIHRoYXQgYXJlIG92ZXIgMTI4IGJ5dGVzLCBhbmQgdGhpcyBkcml2ZXIgc3RpbGwg
d29ya3MuIEl0IGlzIHRoZSB1c2VyIHNwYWNlIHByb2dyYW0gd2hpY2ggZGV0ZXJtaW5lcyB0aGUg
bGFzdCBieXRlcyByZWNlaXZlZC4gVGhlIDEyOCBieXRlcyBpcyB0aGUgbWF4IG51bWJlciBvZiBi
eXRlcyBoYW5kbGVkIGJ5IHlvdXIgaTJjL3NtYnVzIGRyaXZlciBhdCBlYWNoIGkyYyB0cmFuc2Fj
dGlvbi4gTXkgaTJjIGRyaXZlciBjYW4gb25seSB0cmFuc21pdCAxMjggYnl0ZXMgYXQgYSB0aW1l
LiBTbyBqdXN0IGxpa2UgQ29yZXkgcG9pbnRlZCBvdXQsIGl0IHdvdWxkIGJlIGJldHRlciB0byBw
YXNzIHRoaXMgdGhyb3VnaCBBQ1BJL2RldmljZSB0cmVlLg0KICAgIA0KICAgIFllYWgsIEkgd291
bGQgcmVhbGx5IHByZWZlciBkZXZpY2UgdHJlZS4gIFRoYXQncyB3aGF0IGl0J3MgZGVzaWduZWQg
Zm9yLA0KICAgIHJlYWxseS4gIGlvY3RscyBhcmUgbm90IHJlYWxseSB3aGF0IHlvdSB3YW50IGZv
ciB0aGlzLiAgc3lzZnMgaXMgYQ0KICAgIGJldHRlciBjaG9pY2UgYXMgYSBiYWNrdXAgZm9yIGRl
dmljZSB0cmVlIChzbyB5b3UgY2FuIGNoYW5nZSBpdCBpZiBpdCdzDQogICAgd3JvbmcpLg0KDQpD
b3JleS9Bc21hYSwgDQpPaywgSSB3aWxsIHBhc3MgdGhpcyBtYXggc2l6ZSB0aHJvdWdoIGRldmlj
ZSB0cmVlIGFuZCBjaGFuZ2UgdGhpcyBwYXRjaC4gDQpJIGhhdmUgc2VudCBwYXRjaCBmb3IgaTJj
IHRyYW5zZmVyIHVzaW5nIGlvY3RsLCBJIGhvcGUgdGhhdCBzaG91bGQgYmUgZmluZS4gDQpQbGVh
c2UgcmV2aWV3IHRoYXQgdjIgcGF0Y2guDQogICAgDQogICAgLWNvcmV5DQogICAgDQogICAgPiAN
CiAgICA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQogICAgPiBGcm9tOiBDb3JleSBNaW55
YXJkIDx0Y21pbnlhcmRAZ21haWwuY29tPiBPbiBCZWhhbGYgT2YgQ29yZXkgTWlueWFyZA0KICAg
ID4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMTIsIDIwMTkgMzozMCBQTQ0KICAgID4gVG86IFZp
amF5IEtoZW1rYSA8dmlqYXlraGVta2FAZmIuY29tPg0KICAgID4gQ2M6IEFybmQgQmVyZ21hbm4g
PGFybmRAYXJuZGIuZGU+OyBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRp
b24ub3JnPjsgb3BlbmlwbWktZGV2ZWxvcGVyQGxpc3RzLnNvdXJjZWZvcmdlLm5ldDsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgY21pbnlhcmRAbXZpc3RhLmNvbTsgQXNtYWEgTW5lYmhp
IDxBc21hYUBtZWxsYW5veC5jb20+OyBqb2VsQGptcy5pZC5hdTsgbGludXgtYXNwZWVkQGxpc3Rz
Lm96bGFicy5vcmc7IFNhaSBEYXNhcmkgPHNkYXNhcmlAZmIuY29tPg0KICAgID4gU3ViamVjdDog
UmU6IFtQQVRDSCAyLzJdIGRyaXZlcnM6IGlwbWk6IE1vZGlmeSBtYXggbGVuZ3RoIG9mIElQTUIg
cGFja2V0DQogICAgPiANCiAgICA+IE9uIFR1ZSwgTm92IDEyLCAyMDE5IGF0IDA3OjU2OjM0UE0g
KzAwMDAsIFZpamF5IEtoZW1rYSB3cm90ZToNCiAgICA+ID4gDQogICAgPiA+IA0KICAgID4gPiBP
biAxMS8xMi8xOSwgNDo0OCBBTSwgIkNvcmV5IE1pbnlhcmQiIDx0Y21pbnlhcmRAZ21haWwuY29t
IG9uIGJlaGFsZiBvZiBtaW55YXJkQGFjbS5vcmc+IHdyb3RlOg0KICAgID4gPiANCiAgICA+ID4g
ICAgIE9uIE1vbiwgTm92IDExLCAyMDE5IGF0IDA2OjM2OjEwUE0gLTA4MDAsIFZpamF5IEtoZW1r
YSB3cm90ZToNCiAgICA+ID4gICAgID4gQXMgcGVyIElQTUIgc3BlY2lmaWNhdGlvbiwgbWF4aW11
bSBwYWNrZXQgc2l6ZSBzdXBwb3J0ZWQgaXMgMjU1LA0KICAgID4gPiAgICAgPiBtb2RpZmllZCBN
YXggbGVuZ3RoIHRvIDI0MCBmcm9tIDEyOCB0byBhY2NvbW1vZGF0ZSBtb3JlIGRhdGEuDQogICAg
PiA+ICAgICANCiAgICA+ID4gICAgIEkgY291bGRuJ3QgZmluZCB0aGlzIGluIHRoZSBJUE1CIHNw
ZWNpZmljYXRpb24uDQogICAgPiA+ICAgICANCiAgICA+ID4gICAgIElJUkMsIHRoZSBtYXhpbXVt
IG9uIEkyQyBpcyAzMiBieXRzLCBhbmQgdGFibGUgNi05IGluIHRoZSBJUE1JIHNwZWMsDQogICAg
PiA+ICAgICB1bmRlciAiSVBNQiBPdXRwdXQiIHN0YXRlczogVGhlIElQTUIgc3RhbmRhcmQgbWVz
c2FnZSBsZW5ndGggaXMNCiAgICA+ID4gICAgIHNwZWNpZmllZCBhcyAzMiBieXRlcywgbWF4aW11
bSwgaW5jbHVkaW5nIHNsYXZlIGFkZHJlc3MuDQogICAgPiA+IA0KICAgID4gPiBXZSBhcmUgdXNp
bmcgSVBNSSBPRU0gbWVzc2FnZXMgYW5kIG91ciByZXNwb25zZSBzaXplIGlzIGFyb3VuZCAxNTAg
DQogICAgPiA+IGJ5dGVzIEZvciBzb21lIG9mIHJlc3BvbnNlcy4gVGhhdCdzIHdoeSBJIGhhZCBz
ZXQgaXQgdG8gMjQwIGJ5dGVzLg0KICAgID4gDQogICAgPiBIbW0uICBXZWxsLCB0aGF0IGlzIGEg
cHJldHR5IHNpZ25pZmljYW50IHZpb2xhdGlvbiBvZiB0aGUgc3BlYywgYnV0IHRoZXJlJ3Mgbm90
aGluZyBoYXJkIGluIHRoZSBwcm90b2NvbCB0aGF0IHByb2hpYml0cyBpdCwgSSBndWVzcy4NCiAg
ICA+IA0KICAgID4gSWYgQXNtYWEgaXMgb2sgd2l0aCB0aGlzLCBJJ20gb2sgd2l0aCBpdCwgdG9v
Lg0KICAgID4gDQogICAgPiAtY29yZXkNCiAgICA+IA0KICAgID4gPiAgICAgDQogICAgPiA+ICAg
ICBJJ20gbm90IHN1cmUgd2hlcmUgMTI4IGNhbWUgZnJvbSwgYnV0IG1heWJlIGl0IHNob3VsZCBi
ZSByZWR1Y2VkIHRvIDMxLg0KICAgID4gPiAgICAgDQogICAgPiA+ICAgICAtY29yZXkNCiAgICA+
ID4gICAgIA0KICAgID4gPiAgICAgPiANCiAgICA+ID4gICAgID4gU2lnbmVkLW9mZi1ieTogVmlq
YXkgS2hlbWthIDx2aWpheWtoZW1rYUBmYi5jb20+DQogICAgPiA+ICAgICA+IC0tLQ0KICAgID4g
PiAgICAgPiAgZHJpdmVycy9jaGFyL2lwbWkvaXBtYl9kZXZfaW50LmMgfCAyICstDQogICAgPiA+
ICAgICA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCiAg
ICA+ID4gICAgID4gDQogICAgPiA+ICAgICA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvaXBt
aS9pcG1iX2Rldl9pbnQuYyBiL2RyaXZlcnMvY2hhci9pcG1pL2lwbWJfZGV2X2ludC5jDQogICAg
PiA+ICAgICA+IGluZGV4IDI0MTliOWE5MjhiMi4uN2Y5MTk4YmJjZTk2IDEwMDY0NA0KICAgID4g
PiAgICAgPiAtLS0gYS9kcml2ZXJzL2NoYXIvaXBtaS9pcG1iX2Rldl9pbnQuYw0KICAgID4gPiAg
ICAgPiArKysgYi9kcml2ZXJzL2NoYXIvaXBtaS9pcG1iX2Rldl9pbnQuYw0KICAgID4gPiAgICAg
PiBAQCAtMTksNyArMTksNyBAQA0KICAgID4gPiAgICAgPiAgI2luY2x1ZGUgPGxpbnV4L3NwaW5s
b2NrLmg+DQogICAgPiA+ICAgICA+ICAjaW5jbHVkZSA8bGludXgvd2FpdC5oPg0KICAgID4gPiAg
ICAgPiAgDQogICAgPiA+ICAgICA+IC0jZGVmaW5lIE1BWF9NU0dfTEVOCQkxMjgNCiAgICA+ID4g
ICAgID4gKyNkZWZpbmUgTUFYX01TR19MRU4JCTI0MA0KICAgID4gPiAgICAgPiAgI2RlZmluZSBJ
UE1CX1JFUVVFU1RfTEVOX01JTgk3DQogICAgPiA+ICAgICA+ICAjZGVmaW5lIE5FVEZOX1JTUF9C
SVRfTUFTSwkweDQNCiAgICA+ID4gICAgID4gICNkZWZpbmUgUkVRVUVTVF9RVUVVRV9NQVhfTEVO
CTI1Ng0KICAgID4gPiAgICAgPiAtLSANCiAgICA+ID4gICAgID4gMi4xNy4xDQogICAgPiA+ICAg
ICA+DQogICAgPiA+ICAgICANCiAgICA+ID4gDQogICAgPiANCiAgICA+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQogICAgPiBPcGVuaXBtaS1kZXZlbG9w
ZXIgbWFpbGluZyBsaXN0DQogICAgPiBPcGVuaXBtaS1kZXZlbG9wZXJAbGlzdHMuc291cmNlZm9y
Z2UubmV0DQogICAgPiBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9
aHR0cHMtM0FfX2xpc3RzLnNvdXJjZWZvcmdlLm5ldF9saXN0c19saXN0aW5mb19vcGVuaXBtaS0y
RGRldmVsb3BlciZkPUR3SURhUSZjPTVWRDBSVHRObFRoM3ljZDQxYjNNVXcmcj12OU1VMEtpOXBX
blRYQ1d3akhQVmdwbkNSODB2WGtrY3JJYXFVN1VTbDVnJm09UUZPNUNsQWpaNUttZnVya2hrUnBR
UXh4MzNoMFEzTlo5ZUZSYlIzdkd5ayZzPW1aVUl5aVZGMXRCWE8xdjdaaExXT1dfQndJRVJCVG95
dGFWNFVMalhoa00mZT0gDQogICAgDQoNCg==
