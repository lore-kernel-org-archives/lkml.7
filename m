Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFA8C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28BC12071F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ZSMZ5Itp";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="FdwTY5MS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfKNSED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:04:03 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52546 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726980AbfKNSEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:04:02 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAEI3TFS004117;
        Thu, 14 Nov 2019 10:03:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=3wnIDzDz/1H2s2Do+LBCGEJbninQRP7sYctBUhIrDCM=;
 b=ZSMZ5ItpUCvfglgp8at1EJbzu0+zhT6QH9ArjYiJf4BrQb94GggkZCi8eFB+CAYXLWgm
 6eJovFlVV03bOCAlyssoiTne1lSU531fPATM9UuAvl8gNvdFs4T9FFpniQcLV7lMVB3X
 zjTpJfwnCmufLhxUqkZT8sNrZOg8j3NVLHw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2w8tnf4c9v-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 Nov 2019 10:03:34 -0800
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 14 Nov 2019 10:03:28 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 14 Nov 2019 10:03:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWXo0Fw0uteFVHvtLZkuD9E6RH1szsJrK0yRkVsJEEtBsgKszTCLdQ49NvNsuqZfW7GspgMesZWcu0jCd8GBVBA7CFweJN/3tMxU98y7v8WSwIwDqtZegvxcU0Oxb6Y+FAcCDiqXtgqMY40g/N6utfb6ZADrXHl2GY8SwU3HIlI+j0fdl2JssX2qLcznaSkKkG+4ueoQG1s3TGY2d0axMdzwnn2YxYKPAa+v5JiD7jEA2BEOnc5eM1gR3ahIl8i5dMACZaqVYd/mwm8MSK6wSeDCJQ86+ZuJ9Whi0Z+y8Tyaiib6AtVdAq4jcaJaaeEabtjIQobebZJ41z3Pzu8zEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wnIDzDz/1H2s2Do+LBCGEJbninQRP7sYctBUhIrDCM=;
 b=gAAOn1fAwVjH8+j+zpqLyiApIbRSPRn2W3nM5SxuW8MHX6LSbVwA2Qvun4QQvQ+yQwJQHI73dD+NPdx1+G/KgcpMOzBrXSXx+BgOlq0AM306pgCOajSpMqC8pK9pkvS7Wv4CGlwQEqpnAtw23ikawTFQVr9zzeFHlSAViZYMLqujbw148RZFw2gLKY8GYt5tpvI1CXgFMuMZ2UI0dQmjY9jG1Q85OEv6Mcyzar5K+yM6M0Xpio/I+7emCQqgeZMUSpywe7hXUVnzvQoLiF0W2uRXaJiJ2J8D7syGrbwPa5gr09mGQ7msiUto2ysdC6FFTcJQ3A8pWe1goX9fqikU4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wnIDzDz/1H2s2Do+LBCGEJbninQRP7sYctBUhIrDCM=;
 b=FdwTY5MSlgV8u6wRexOjlNWzyrY3XJvoLaAz0UWbMaG+IHR39hk9Y0rjATTwwlMcoA1ykdfzL8wv4CIQZ7Q91j7HhujKBkBDhXjxcgIJxhkBmFhE94ivRaSrt+LeOEmEXsduu8s94tAUk+n2qMvUAQDa0pDR3Oft1OiBXx1k6b8=
Received: from BY5PR15MB3636.namprd15.prod.outlook.com (52.133.252.91) by
 BY5PR15MB3585.namprd15.prod.outlook.com (52.133.253.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.28; Thu, 14 Nov 2019 18:03:27 +0000
Received: from BY5PR15MB3636.namprd15.prod.outlook.com
 ([fe80::71db:9d2a:500c:d92b]) by BY5PR15MB3636.namprd15.prod.outlook.com
 ([fe80::71db:9d2a:500c:d92b%4]) with mapi id 15.20.2430.027; Thu, 14 Nov 2019
 18:03:27 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Asmaa Mnebhi <asmaa@mellanox.com>, Corey Minyard <minyard@acm.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "cminyard@mvista.com" <cminyard@mvista.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        Sai Dasari <sdasari@fb.com>
Subject: Re: [PATCH v4] drivers: ipmi: Support raw i2c packet in IPMB
Thread-Topic: [PATCH v4] drivers: ipmi: Support raw i2c packet in IPMB
Thread-Index: AQHVmnw2JTo54xh3Oky71cdINa8VKqeKt0kA//+5Q4A=
Date:   Thu, 14 Nov 2019 18:03:27 +0000
Message-ID: <1A8C63F8-6295-441A-B78F-68F9152A5DB1@fb.com>
References: <20191113234133.3790374-1-vijaykhemka@fb.com>
 <DB6PR0501MB2712658DD269E4B22A327A2DDA710@DB6PR0501MB2712.eurprd05.prod.outlook.com>
In-Reply-To: <DB6PR0501MB2712658DD269E4B22A327A2DDA710@DB6PR0501MB2712.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::2860]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4146b81e-21a1-4a52-7927-08d7692cf344
x-ms-traffictypediagnostic: BY5PR15MB3585:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR15MB35858F5A33E34949256A8F41DD710@BY5PR15MB3585.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(39860400002)(396003)(366004)(346002)(189003)(199004)(13464003)(2201001)(86362001)(71200400001)(36756003)(71190400001)(2906002)(110136005)(305945005)(7736002)(6116002)(54906003)(33656002)(99286004)(6486002)(316002)(446003)(11346002)(229853002)(8936002)(66946007)(476003)(2616005)(66476007)(66556008)(64756008)(6436002)(66446008)(478600001)(46003)(6512007)(14454004)(2501003)(486006)(76176011)(5660300002)(76116006)(256004)(14444005)(53546011)(25786009)(102836004)(6506007)(8676002)(4326008)(81166006)(81156014)(186003)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR15MB3585;H:BY5PR15MB3636.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: StwUYlnmftLJGjqG5TLa0dOhUxgmqI7+9e69QEnvYhKDeK1L8SvPZhu0irFKBtVHywsVNnlMJjISZR6Ln30YAJnlExAoawxYQK7OH7pct4KCKWohxNd3imW30ZewH+BZpEDDhvMg6RMWb5CIEnmtB+z6P5i8izZPJuoBe0CiyJkPKkKcLxhFCbKk8gIWnZm+NljI8jFBndYCVv8UI+HPWnGC5dzwsDr4Dg08cRybrtc8fENZ6XrumJhBjRKEszhcAe8mgtgNQgqa7LIxrIOgts6VqDL220FkmGl4t25lqxTeXS3OhF9E3be8pZIASHk4MiK78MinYIiiSND2WfANl/IUqe9CbacyHQ/1i0yrw/1eZBAUIWAKkr38FsopVXQ9ZhmP5KmHF1zTsoZPEifbjxOVHGDxr/BQwMiZRCC7iA8zJVcPE7r9QS/0rkxJFreC
Content-Type: text/plain; charset="utf-8"
Content-ID: <55398E8B7710C042937C0F2709A79225@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4146b81e-21a1-4a52-7927-08d7692cf344
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 18:03:27.5473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8DV19QMwKgSBNwe3Tilcv2+2qfwXAOlO4FFL3F9ku3k+nxs1sP//tr68LYf4sX2plckIGbbmR5AjE11f/kLsxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3585
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-14_05:2019-11-14,2019-11-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911140155
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T2sgSSB3aWxsIHNlbmQgYW5vdGhlciBwYXRjaCB3aXRoIGFjcGkgc3VwcG9ydC4NCg0K77u/T24g
MTEvMTQvMTksIDY6MTYgQU0sICJBc21hYSBNbmViaGkiIDxhc21hYUBtZWxsYW5veC5jb20+IHdy
b3RlOg0KDQogICAgSGkgVmlqYXksDQogICAgDQogICAgWW91IGhhdmVuJ3QgYWRkcmVzc2VkIHNv
bWUgb2YgbXkgY29tbWVudHMuDQogICAgDQogICAgLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
CiAgICBGcm9tOiBWaWpheSBLaGVta2EgPHZpamF5a2hlbWthQGZiLmNvbT4gDQogICAgU2VudDog
V2VkbmVzZGF5LCBOb3ZlbWJlciAxMywgMjAxOSA2OjQyIFBNDQogICAgVG86IENvcmV5IE1pbnlh
cmQgPG1pbnlhcmRAYWNtLm9yZz47IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+OyBHcmVn
IEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsgb3BlbmlwbWktZGV2
ZWxvcGVyQGxpc3RzLnNvdXJjZWZvcmdlLm5ldDsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zw0KICAgIENjOiB2aWpheWtoZW1rYUBmYi5jb207IGNtaW55YXJkQG12aXN0YS5jb207IEFzbWFh
IE1uZWJoaSA8QXNtYWFAbWVsbGFub3guY29tPjsgam9lbEBqbXMuaWQuYXU7IGxpbnV4LWFzcGVl
ZEBsaXN0cy5vemxhYnMub3JnOyBzZGFzYXJpQGZiLmNvbQ0KICAgIFN1YmplY3Q6IFtQQVRDSCB2
NF0gZHJpdmVyczogaXBtaTogU3VwcG9ydCByYXcgaTJjIHBhY2tldCBpbiBJUE1CDQogICAgDQog
ICAgTWFueSBJUE1CIGRldmljZXMgZG9lc24ndCBzdXBwb3J0IHNtYnVzIHByb3RvY29sIGFuZCBj
dXJyZW50IGRyaXZlciBzdXBwb3J0IG9ubHkgc21idXMgZGV2aWNlcy4gQWRkZWQgc3VwcG9ydCBm
b3IgcmF3IGkyYyBwYWNrZXRzLg0KICAgIA0KICAgIFVzZXIgY2FuIGRlZmluZSBpMmMtcHJvdG9j
b2wgaW4gZGV2aWNlIHRyZWUgdG8gdXNlIGkyYyByYXcgdHJhbnNmZXIuDQogICAgDQogICAgQT4+
IFBsZWFzZSBmaXggdGhlIGRlc2NyaXB0aW9uIGFzIHN1Z2dlc3RlZCBpbiBwcmV2aW91cyBjb21t
ZW50cw0KICAgIA0KICAgIFNpZ25lZC1vZmYtYnk6IFZpamF5IEtoZW1rYSA8dmlqYXlraGVta2FA
ZmIuY29tPg0KICAgIC0tLQ0KICAgICBkcml2ZXJzL2NoYXIvaXBtaS9pcG1iX2Rldl9pbnQuYyB8
IDMyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogICAgIDEgZmlsZSBjaGFuZ2Vk
LCAzMiBpbnNlcnRpb25zKCspDQogICAgDQogICAgZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci9p
cG1pL2lwbWJfZGV2X2ludC5jIGIvZHJpdmVycy9jaGFyL2lwbWkvaXBtYl9kZXZfaW50LmMNCiAg
ICBpbmRleCBhZTNiZmJhMjc1MjYuLjEwOTA0YmVjMWRlMCAxMDA2NDQNCiAgICAtLS0gYS9kcml2
ZXJzL2NoYXIvaXBtaS9pcG1iX2Rldl9pbnQuYw0KICAgICsrKyBiL2RyaXZlcnMvY2hhci9pcG1p
L2lwbWJfZGV2X2ludC5jDQogICAgQEAgLTYzLDYgKzYzLDcgQEAgc3RydWN0IGlwbWJfZGV2IHsN
CiAgICAgCXNwaW5sb2NrX3QgbG9jazsNCiAgICAgCXdhaXRfcXVldWVfaGVhZF90IHdhaXRfcXVl
dWU7DQogICAgIAlzdHJ1Y3QgbXV0ZXggZmlsZV9tdXRleDsNCiAgICArCWJvb2wgaXNfaTJjX3By
b3RvY29sOw0KICAgICB9Ow0KICAgICANCiAgICAgc3RhdGljIGlubGluZSBzdHJ1Y3QgaXBtYl9k
ZXYgKnRvX2lwbWJfZGV2KHN0cnVjdCBmaWxlICpmaWxlKSBAQCAtMTEyLDYgKzExMywyNSBAQCBz
dGF0aWMgc3NpemVfdCBpcG1iX3JlYWQoc3RydWN0IGZpbGUgKmZpbGUsIGNoYXIgX191c2VyICpi
dWYsIHNpemVfdCBjb3VudCwNCiAgICAgCXJldHVybiByZXQgPCAwID8gcmV0IDogY291bnQ7DQog
ICAgIH0NCiAgICAgDQogICAgK3N0YXRpYyBpbnQgaXBtYl9pMmNfd3JpdGUoc3RydWN0IGkyY19j
bGllbnQgKmNsaWVudCwgdTggKm1zZykgew0KICAgICsJc3RydWN0IGkyY19tc2cgaTJjX21zZzsN
CiAgICArDQogICAgKwkvKg0KICAgICsJICogc3VidHJhY3QgMSBieXRlIChycV9zYSkgZnJvbSB0
aGUgbGVuZ3RoIG9mIHRoZSBtc2cgcGFzc2VkIHRvDQogICAgKwkgKiByYXcgaTJjX3RyYW5zZmVy
DQogICAgKwkgKi8NCiAgICArCWkyY19tc2cubGVuID0gbXNnW0lQTUJfTVNHX0xFTl9JRFhdIC0g
MTsNCiAgICArDQogICAgKwkvKiBBc3NpZ24gbWVzc2FnZSB0byBidWZmZXIgZXhjZXB0IGZpcnN0
IDIgYnl0ZXMgKGxlbmd0aCBhbmQgYWRkcmVzcykgKi8NCiAgICArCWkyY19tc2cuYnVmID0gbXNn
ICsgMjsNCiAgICArDQogICAgKwlpMmNfbXNnLmFkZHIgPSBHRVRfN0JJVF9BRERSKG1zZ1tSUV9T
QV84QklUX0lEWF0pOw0KICAgIA0KICAgIFlvdSBjYW4gaGF2ZToNCiAgICBpMmNfbXNnLmZsYWdz
ID0gYWRkcjsNCiAgICBhZGRyIGJlaW5nIGFuIGFyZ3VtZW50IG9mIHRoZSBpcG1iX2kyY193cml0
ZSBmdW5jdGlvbiBhbmQgcGFzc2VkIGluIGlwbWJfd3JpdGUuIFdlIGFscmVhZHkgZGVmaW5lIGl0
Lg0KICAgIA0KICAgICsJaTJjX21zZy5mbGFncyA9IGNsaWVudC0+ZmxhZ3MgJiBJMkNfQ0xJRU5U
X1BFQzsNCiAgICArDQogICAgKwlyZXR1cm4gaTJjX3RyYW5zZmVyKGNsaWVudC0+YWRhcHRlciwg
JmkyY19tc2csIDEpOyB9DQogICAgKw0KICAgICBzdGF0aWMgc3NpemVfdCBpcG1iX3dyaXRlKHN0
cnVjdCBmaWxlICpmaWxlLCBjb25zdCBjaGFyIF9fdXNlciAqYnVmLA0KICAgICAJCQlzaXplX3Qg
Y291bnQsIGxvZmZfdCAqcHBvcykNCiAgICAgew0KICAgIEBAIC0xMzMsNiArMTUzLDEyIEBAIHN0
YXRpYyBzc2l6ZV90IGlwbWJfd3JpdGUoc3RydWN0IGZpbGUgKmZpbGUsIGNvbnN0IGNoYXIgX191
c2VyICpidWYsDQogICAgIAlycV9zYSA9IEdFVF83QklUX0FERFIobXNnW1JRX1NBXzhCSVRfSURY
XSk7DQogICAgIAluZXRmX3JxX2x1biA9IG1zZ1tORVRGTl9MVU5fSURYXTsNCiAgICAgDQogICAg
KwkvKiBDaGVjayBpMmMgYmxvY2sgdHJhbnNmZXIgdnMgc21idXMgKi8NCiAgICArCWlmIChpcG1i
X2Rldi0+aXNfaTJjX3Byb3RvY29sKSB7DQogICAgKwkJcmV0ID0gaXBtYl9pMmNfd3JpdGUoaXBt
Yl9kZXYtPmNsaWVudCwgbXNnKTsNCiAgICArCQlyZXR1cm4gKHJldCA9PSAxKSA/IGNvdW50IDog
cmV0Ow0KICAgICsJfQ0KICAgICsNCiAgICAgCS8qDQogICAgIAkgKiBzdWJ0cmFjdCBycV9zYSBh
bmQgbmV0Zl9ycV9sdW4gZnJvbSB0aGUgbGVuZ3RoIG9mIHRoZSBtc2cgcGFzc2VkIHRvDQogICAg
IAkgKiBpMmNfc21idXNfeGZlcg0KICAgIEBAIC0yNzcsNiArMzAzLDcgQEAgc3RhdGljIGludCBp
cG1iX3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQsDQogICAgIAkJCWNvbnN0IHN0cnVj
dCBpMmNfZGV2aWNlX2lkICppZCkNCiAgICAgew0KICAgICAJc3RydWN0IGlwbWJfZGV2ICppcG1i
X2RldjsNCiAgICArCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnA7DQogICAgIAlpbnQgcmV0Ow0KICAg
ICANCiAgICAgCWlwbWJfZGV2ID0gZGV2bV9remFsbG9jKCZjbGllbnQtPmRldiwgc2l6ZW9mKCpp
cG1iX2RldiksIEBAIC0zMDIsNiArMzI5LDExIEBAIHN0YXRpYyBpbnQgaXBtYl9wcm9iZShzdHJ1
Y3QgaTJjX2NsaWVudCAqY2xpZW50LA0KICAgICAJaWYgKHJldCkNCiAgICAgCQlyZXR1cm4gcmV0
Ow0KICAgICANCiAgICArCS8qIENoZWNrIGlmIGkyYyBibG9jayB4bWl0IG5lZWRzIHRvIHVzZSBp
bnN0ZWFkIG9mIHNtYnVzICovDQogICAgKwlucCA9IGNsaWVudC0+ZGV2Lm9mX25vZGU7DQogICAg
KwlpZiAobnAgJiYgb2ZfZ2V0X3Byb3BlcnR5KG5wLCAiaTJjLXByb3RvY29sIiwgTlVMTCkpDQog
ICAgKwkJaXBtYl9kZXYtPmlzX2kyY19wcm90b2NvbCA9IHRydWU7DQogICAgDQogICAgSSBrbm93
IENvcmV5IHNhaWQgdGhhdCBBQ1BJIGlzIG5vdCBhIHByaW9yaXR5IGJ1dCBtYW55IGNvbXBhbmll
cyAoaW5jbHVkaW5nIG1pbmUpIHVzZSBBQ1BJIGFuZCBJIHdvdWxkIHByZWZlciBpZiB3ZSBpbXBs
ZW1lbnQgaXQuIEFsbCB5b3UgbmVlZCB0byBkbyBpcyB1c2UNCiAgICBkZXZpY2VfcHJvcGVydHlf
cmVhZF91MzIgZnVuY3Rpb24gaW5zdGVhZCBvZiBvZl9nZXRfcHJvcGVydHk6DQogICAgcmV0ID0g
ZGV2aWNlX3Byb3BlcnR5X3JlYWRfdTMyKCZjbGllbnQtPmRldiwgImkyYy1wcm90b2NvbCIsICZp
cG1iX2Rldi0+aXNfaTJjX3Byb3RvY29sKTsNCiAgICBUaGlzIGZ1bmN0aW9uIGRvZXMgdGhlIGpv
YiBmb3IgYm90aCBkdCBhbmQgYWNwaS4NCiAgICANCiAgICArDQogICAgIAlpcG1iX2Rldi0+Y2xp
ZW50ID0gY2xpZW50Ow0KICAgICAJaTJjX3NldF9jbGllbnRkYXRhKGNsaWVudCwgaXBtYl9kZXYp
Ow0KICAgICAJcmV0ID0gaTJjX3NsYXZlX3JlZ2lzdGVyKGNsaWVudCwgaXBtYl9zbGF2ZV9jYik7
DQogICAgLS0NCiAgICAyLjE3LjENCiAgICANCiAgICANCg0K
