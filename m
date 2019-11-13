Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B141CC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750A6206E3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Y2boQkZf";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="huSZRcJV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfKMV3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:29:04 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:18072 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726162AbfKMV3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:29:03 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xADLSTx2016857;
        Wed, 13 Nov 2019 13:28:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=YR+yK3/puMN1xS2qmOj7KCfOtqkPmOKpQil3HQowZw0=;
 b=Y2boQkZfE8mQxEyTvr0857BFO4laaHN73/cxGbJpHOnzoMJ0LOClLsHx8WrbWMqdZPpp
 US0dmurPdWZpbRBPDWvQpgxmpbsIezx7BN8wKbQp+1ziRv+Yb4h1GmiTxYdE+VCtVWEk
 G7o7XBRj0h/CD6LnA6b4oHdvLopIS4qIajg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2w8rgdgcn2-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 Nov 2019 13:28:30 -0800
Received: from ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) by
 ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 Nov 2019 13:28:12 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 13 Nov 2019 13:28:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juzVFgIewhqHPPLJXQdZLIyakwRjpljFudrUjl1SKjcMlNe07cMBWq05J1LmOeZN4bA0mh8wRO2/M/dGoopJQTxXEU8ltrz2HUxw7plzBOR6YxUv4us+mst3aNH3AF/MCtt6sfGMDZluX5YQPdb+Bgo0bGnt0y/fFbxb6zrmEsbvnh99qMr55/j2fWc4UK+8rqmZhFZV705XOQHPfxrsZnBiS6/2HXiLwkMvnRrov3EL2g5cThKdd7vD+ObM4rlIRCjghCKbjXH4be86ogDih3XO3tbd+zTHJny/xuPXc/udws/WH8mVNfzlcFZ/GHie9mdOlZjiPoX7g/UM6+qNOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YR+yK3/puMN1xS2qmOj7KCfOtqkPmOKpQil3HQowZw0=;
 b=DOmmXABs2kEW/e3EBMcS9qo4/vrP0GUGiyVqFSFVM1b54jkbo6HryD0wJcJ6ldBmK/P8UQd4jN+q3mX7rBI3QUJwOaXGYv1L7GJ9m4nW7pXqidLSJPmxIcuAwIU8E0E8r+SAl5i928Croy+N6OGjDBAKYd4zlvwT2S4vaoyCHQ0c73CPZJWwlnYr2zsrzYuNSZa9cbT9x2WUrJebX5WG7mg6/C19Bri32pELxu9wtBgQ5ylpCPeuLfjUDJ7hPBItvgW8sjs+peI2wyW7j/S/R+nh1okdx6xXoq+IOizVT61CBEsg6TD79ZbcBL+sqCqVSA4v1bxduTT9IES42OVppA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YR+yK3/puMN1xS2qmOj7KCfOtqkPmOKpQil3HQowZw0=;
 b=huSZRcJVyYJ3AlRCZI1gXTfQ25Qb/aCcuG5E6qMtPfO7WEl6NZUjMOKDLp+0tk+enQkid0UCUFjOZv4ChxON3iwP/7UddrHWWYkbfKttJmIRJD6w+UNjuJhnmnz/1i6NAxs6XMYErqfe5jIh+OCDfNV1BNXjFK8KamyZTf5sOM0=
Received: from BY5PR15MB3636.namprd15.prod.outlook.com (52.133.252.91) by
 BY5PR15MB3618.namprd15.prod.outlook.com (52.133.254.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Wed, 13 Nov 2019 21:28:11 +0000
Received: from BY5PR15MB3636.namprd15.prod.outlook.com
 ([fe80::71db:9d2a:500c:d92b]) by BY5PR15MB3636.namprd15.prod.outlook.com
 ([fe80::71db:9d2a:500c:d92b%4]) with mapi id 15.20.2430.027; Wed, 13 Nov 2019
 21:28:11 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Asmaa Mnebhi <Asmaa@mellanox.com>, Corey Minyard <minyard@acm.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "cminyard@mvista.com" <cminyard@mvista.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        Sai Dasari <sdasari@fb.com>,
        "wsa@the-dreams.de" <wsa@the-dreams.de>
Subject: Re: [PATCH v3] drivers: ipmi: Support raw i2c packet in IPMB
Thread-Topic: [PATCH v3] drivers: ipmi: Support raw i2c packet in IPMB
Thread-Index: AQHVmlgx5hC93vJeUkW0xORXbQm1S6eJjmCA//+JUQA=
Date:   Wed, 13 Nov 2019 21:28:10 +0000
Message-ID: <AC2A7BB8-52D0-4CAF-9C72-58C9CF5A4F55@fb.com>
References: <20191113192325.2821207-1-vijaykhemka@fb.com>
 <DB6PR0501MB2712FAF45EE8CB2D513465A9DA760@DB6PR0501MB2712.eurprd05.prod.outlook.com>
In-Reply-To: <DB6PR0501MB2712FAF45EE8CB2D513465A9DA760@DB6PR0501MB2712.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::63b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df6c9e83-6fbc-4f4b-0f51-08d76880624b
x-ms-traffictypediagnostic: BY5PR15MB3618:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR15MB361839707BB620564F74E3E5DD760@BY5PR15MB3618.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(366004)(376002)(396003)(189003)(199004)(13464003)(2906002)(316002)(66476007)(66556008)(99286004)(110136005)(64756008)(66946007)(8936002)(91956017)(66446008)(25786009)(4326008)(6246003)(6512007)(6436002)(478600001)(36756003)(14454004)(6116002)(76116006)(54906003)(7416002)(305945005)(229853002)(6486002)(5660300002)(7736002)(14444005)(256004)(81156014)(33656002)(46003)(446003)(11346002)(2616005)(476003)(486006)(71190400001)(86362001)(53546011)(8676002)(2201001)(6506007)(71200400001)(81166006)(76176011)(102836004)(2501003)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR15MB3618;H:BY5PR15MB3636.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q8d4vV0ElpL37/XSlkDYM9GYS2A43htmO/huRlSk0MhlL6qkolEWB5KPvHcpbMmwNvKsXAEklbu6P0VvNoZ1LHqsNmHeZsC1WQIW/Nta+4ltHXQJyJ2HSIRAsiNFKeDK2SqA1uM4JXbsJjx9Xf5A82wn8Eo0BUX4ZViTAv/av52yUsQ4kq/Ppiv6W21XQRHqofWxySt2aVNoQHMHYvtNUAR2WkLvVq0/w1rI2Q3a8vUOhwHuhxKRaC31k7ApdYRYH39gGhz5PmjJdrGmCffngYP6wlviM10Roda5DV+hLtsYhvY1lTxHdgeS3VnwR6i8lFVTQYtfDAeAwcGkKlmLtFLZoFPfMQokSPa6yE66oWFFNVLCQd0T03PqwGtZR9mVeRmRGZRHupoHSrXbpQlJlKXnLpGdJT6Hrr6ycrT1AnKB2T1bkS2EiMm9fSqMPNNN
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1CD5A6AC5EE4747884D6FB9BD09D300@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: df6c9e83-6fbc-4f4b-0f51-08d76880624b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 21:28:10.9244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r7mO9iolA9zL49Vca14qFsjBmBUAUnIvKo6arEk8s8agVA9ka/CKyVqQUpYnnnAmWkCxDj7jk2xAz0Gw2sr0yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3618
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-13_05:2019-11-13,2019-11-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 phishscore=0 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911130177
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDExLzEzLzE5LCAxMjozMyBQTSwgIkFzbWFhIE1uZWJoaSIgPEFzbWFhQG1lbGxh
bm94LmNvbT4gd3JvdGU6DQoNCiAgICBJbmxpbmUgcmVzcG9uc2U6DQogICAgDQogICAgLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCiAgICBGcm9tOiBWaWpheSBLaGVta2EgPHZpamF5a2hlbWth
QGZiLmNvbT4gDQogICAgU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAxMywgMjAxOSAyOjIzIFBN
DQogICAgVG86IENvcmV5IE1pbnlhcmQgPG1pbnlhcmRAYWNtLm9yZz47IEFybmQgQmVyZ21hbm4g
PGFybmRAYXJuZGIuZGU+OyBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRp
b24ub3JnPjsgb3BlbmlwbWktZGV2ZWxvcGVyQGxpc3RzLnNvdXJjZWZvcmdlLm5ldDsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZw0KICAgIENjOiB2aWpheWtoZW1rYUBmYi5jb207IGNtaW55
YXJkQG12aXN0YS5jb207IEFzbWFhIE1uZWJoaSA8QXNtYWFAbWVsbGFub3guY29tPjsgam9lbEBq
bXMuaWQuYXU7IGxpbnV4LWFzcGVlZEBsaXN0cy5vemxhYnMub3JnOyBzZGFzYXJpQGZiLmNvbQ0K
ICAgIFN1YmplY3Q6IFtQQVRDSCB2M10gZHJpdmVyczogaXBtaTogU3VwcG9ydCByYXcgaTJjIHBh
Y2tldCBpbiBJUE1CDQogICAgDQogICAgTWFueSBJUE1CIGRldmljZXMgZG9lc24ndCBzdXBwb3J0
IHNtYnVzIHByb3RvY29sIGFuZCBjdXJyZW50IGRyaXZlciBzdXBwb3J0IG9ubHkgc21idXMgZGV2
aWNlcy4gQWRkZWQgc3VwcG9ydCBmb3IgcmF3IGkyYyBwYWNrZXRzLg0KICAgIA0KICAgIFVzZXIg
Y2FuIGRlZmluZSB1c2UtaTJjLWJsb2NrIGluIGRldmljZSB0cmVlIHRvIHVzZSBpMmMgcmF3IHRy
YW5zZmVyLg0KICAgIA0KICAgIEFzbWFhPj4gRml4IHRoZSBkZXNjcmlwdGlvbjogIlRoZSBpcG1i
X2Rldl9pbnQgZHJpdmVyIG9ubHkgc3VwcG9ydHMgdGhlIHNtYnVzIHByb3RvY29sIGF0IHRoZSBt
b21lbnQuIEFkZCBzdXBwb3J0IGZvciB0aGUgaTJjIHByb3RvY29sIGFzIHdlbGwuIFRoZXJlIHdp
bGwgYmUgYSB2YXJpYWJsZSBwYXNzZWQgYnkgdGhvdWdoIHRoZSBkZXZpY2UgdHJlZSBvciBBQ1BJ
IHRhYmxlIHdoaWNoIHNldHMgdGhlIGNvbmZpZ3VyZXMgdGhlIHByb3RvY29sIGFzIGVpdGhlciBp
MmMgb3Igc21idXMuIg0KICAgIA0KICAgIFNpZ25lZC1vZmYtYnk6IFZpamF5IEtoZW1rYSA8dmlq
YXlraGVta2FAZmIuY29tPg0KICAgIC0tLQ0KICAgICBkcml2ZXJzL2NoYXIvaXBtaS9pcG1iX2Rl
dl9pbnQuYyB8IDQ4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogICAgIDEgZmls
ZSBjaGFuZ2VkLCA0OCBpbnNlcnRpb25zKCspDQogICAgDQogICAgZGlmZiAtLWdpdCBhL2RyaXZl
cnMvY2hhci9pcG1pL2lwbWJfZGV2X2ludC5jIGIvZHJpdmVycy9jaGFyL2lwbWkvaXBtYl9kZXZf
aW50LmMNCiAgICBpbmRleCBhZTNiZmJhMjc1MjYuLjE2ZDVkNGI2MzZhOSAxMDA2NDQNCiAgICAt
LS0gYS9kcml2ZXJzL2NoYXIvaXBtaS9pcG1iX2Rldl9pbnQuYw0KICAgICsrKyBiL2RyaXZlcnMv
Y2hhci9pcG1pL2lwbWJfZGV2X2ludC5jDQogICAgQEAgLTYzLDYgKzYzLDcgQEAgc3RydWN0IGlw
bWJfZGV2IHsNCiAgICAgCXNwaW5sb2NrX3QgbG9jazsNCiAgICAgCXdhaXRfcXVldWVfaGVhZF90
IHdhaXRfcXVldWU7DQogICAgIAlzdHJ1Y3QgbXV0ZXggZmlsZV9tdXRleDsNCiAgICArCWJvb2wg
dXNlX2kyYzsNCiAgICAgfTsNCiAgICAgDQogICAgQXNtYWE+PiByZW5hbWUgdGhpcyB2YXJpYWJs
ZSA6IGlzX2kyY19wcm90b2NvbA0KRG9uZS4NCiAgICANCiAgICAgc3RhdGljIGlubGluZSBzdHJ1
Y3QgaXBtYl9kZXYgKnRvX2lwbWJfZGV2KHN0cnVjdCBmaWxlICpmaWxlKSBAQCAtMTEyLDYgKzEx
MywzOSBAQCBzdGF0aWMgc3NpemVfdCBpcG1iX3JlYWQoc3RydWN0IGZpbGUgKmZpbGUsIGNoYXIg
X191c2VyICpidWYsIHNpemVfdCBjb3VudCwNCiAgICAgCXJldHVybiByZXQgPCAwID8gcmV0IDog
Y291bnQ7DQogICAgIH0NCiAgICAgDQogICAgK3N0YXRpYyBpbnQgaXBtYl9pMmNfd3JpdGUoc3Ry
dWN0IGkyY19jbGllbnQgKmNsaWVudCwgdTggKm1zZykgew0KICAgICsJdW5zaWduZWQgY2hhciAq
aTJjX2J1ZjsNCiAgICArCXN0cnVjdCBpMmNfbXNnIGkyY19tc2c7DQogICAgKwlzc2l6ZV90IHJl
dDsNCiAgICArCXU4IG1zZ19sZW47DQogICAgKw0KICAgICsJLyoNCiAgICArCSAqIHN1YnRyYWN0
IDEgYnl0ZSAocnFfc2EpIGZyb20gdGhlIGxlbmd0aCBvZiB0aGUgbXNnIHBhc3NlZCB0bw0KICAg
ICsJICogcmF3IGkyY190cmFuc2Zlcg0KICAgICsJICovDQogICAgKwltc2dfbGVuID0gbXNnW0lQ
TUJfTVNHX0xFTl9JRFhdIC0gMTsNCiAgICArDQogICAgKwlpMmNfYnVmID0ga3phbGxvYyhtc2df
bGVuLCBHRlBfS0VSTkVMKTsNCiAgICANCiAgICBBc21hYSA+PiBXZSBkbyBub3Qgd2FudCB0byB1
c2Uga3phbGxvYyBldmVyeSB0aW1lIHlvdSBleGVjdXRlIHRoaXMgd3JpdGUgZnVuY3Rpb24uIEl0
IHdvdWxkIGNyZWF0ZSBzbyBtdWNoIGZyYWdtZW50YXRpb24uDQogICAgWW91IGRvbid0IHJlYWxs
eSBuZWVkIHRvIHVzZSBremFsbG9jIGFueXdheXMuIA0KV2UgbmVlZCB0byBhbGxvY2F0ZSBtZW1v
cnkgdG8gcGFzcyB0byBpMmNfdHJhbnNmZXIuIFRoYXQncyB3aGF0IGJlaW5nIGRvbmUgaW4gaTJj
X3NtYnVzX3hmZXIgZnVuY3Rpb24gYXMgd2VsbC4NCiAgICANCiAgICBBbHNvLCB0aGlzIGNvZGUg
Y2h1bmsgaXMgc2hvcnQsIHNvIHlvdSBjYW4gY2FsbCBpdCBkaXJlY3RseSBmcm9tIHRoZSB3cml0
ZSBmdW5jdGlvbi4gSSBkb24ndCB0aGluayB5b3UgbmVlZCBhIHNlcGFyYXRlIGZ1bmN0aW9uIGZv
ciBpdC4NCkkgd2FudGVkIHRvIGtlZXAgdGhpcyBjaGFuZ2UgYXMgY2xlYW4gYXMgcG9zc2libGUu
DQogICAgDQogICAgKwlpZiAoIWkyY19idWYpDQogICAgKwkJcmV0dXJuIC1FRkFVTFQ7DQogICAg
Kw0KICAgICsJLyogQ29weSBtZXNzYWdlIHRvIGJ1ZmZlciBleGNlcHQgZmlyc3QgMiBieXRlcyAo
bGVuZ3RoIGFuZCBhZGRyZXNzKSAqLw0KICAgICsJbWVtY3B5KGkyY19idWYsIG1zZysyLCBtc2df
bGVuKTsNCiAgICArDQogICAgKwlpMmNfbXNnLmFkZHIgPSBHRVRfN0JJVF9BRERSKG1zZ1tSUV9T
QV84QklUX0lEWF0pOw0KICAgICsJaTJjX21zZy5mbGFncyA9IGNsaWVudC0+ZmxhZ3MgJg0KICAg
ICsJCQkoSTJDX01fVEVOIHwgSTJDX0NMSUVOVF9QRUMgfCBJMkNfQ0xJRU5UX1NDQ0IpOw0KICAg
IEFzbWFhPj4gSSBkb24ndCB0aGluayBpcG1iIHN1cHBvcnRzIDEwIGJpdCBhZGRyZXNzZXMuIFRo
ZSBtYXggbnVtYmVyIG9mIGJpdHMgaW4gdGhlIElQTUIgYWRkcmVzcyBmaWVsZCBpcyA4Lg0KRG9u
ZS4NCiAgICANCiAgICArCWkyY19tc2cubGVuID0gbXNnX2xlbjsNCiAgICArCWkyY19tc2cuYnVm
ID0gaTJjX2J1ZjsNCiAgICArDQogICAgKwlyZXQgPSBpMmNfdHJhbnNmZXIoY2xpZW50LT5hZGFw
dGVyLCAmaTJjX21zZywgMSk7DQogICAgKwlrZnJlZShpMmNfYnVmKTsNCiAgICArDQogICAgKwly
ZXR1cm4gcmV0Ow0KICAgICsNCiAgICArfQ0KICAgICsNCiAgICAgc3RhdGljIHNzaXplX3QgaXBt
Yl93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwgY29uc3QgY2hhciBfX3VzZXIgKmJ1ZiwNCiAgICAg
CQkJc2l6ZV90IGNvdW50LCBsb2ZmX3QgKnBwb3MpDQogICAgIHsNCiAgICBAQCAtMTMzLDYgKzE2
NywxMiBAQCBzdGF0aWMgc3NpemVfdCBpcG1iX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxlLCBjb25z
dCBjaGFyIF9fdXNlciAqYnVmLA0KICAgICAJcnFfc2EgPSBHRVRfN0JJVF9BRERSKG1zZ1tSUV9T
QV84QklUX0lEWF0pOw0KICAgICAJbmV0Zl9ycV9sdW4gPSBtc2dbTkVURk5fTFVOX0lEWF07DQog
ICAgIA0KICAgICsJLyogQ2hlY2sgaTJjIGJsb2NrIHRyYW5zZmVyIHZzIHNtYnVzICovDQogICAg
KwlpZiAoaXBtYl9kZXYtPnVzZV9pMmMpIHsNCiAgICArCQlyZXQgPSBpcG1iX2kyY193cml0ZShp
cG1iX2Rldi0+Y2xpZW50LCBtc2cpOw0KICAgICsJCXJldHVybiAocmV0ID09IDEpID8gY291bnQg
OiByZXQ7DQogICAgKwl9DQogICAgKw0KICAgICAJLyoNCiAgICAgCSAqIHN1YnRyYWN0IHJxX3Nh
IGFuZCBuZXRmX3JxX2x1biBmcm9tIHRoZSBsZW5ndGggb2YgdGhlIG1zZyBwYXNzZWQgdG8NCiAg
ICAgCSAqIGkyY19zbWJ1c194ZmVyDQogICAgQEAgLTI3Nyw2ICszMTcsNyBAQCBzdGF0aWMgaW50
IGlwbWJfcHJvYmUoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwNCiAgICAgCQkJY29uc3Qgc3Ry
dWN0IGkyY19kZXZpY2VfaWQgKmlkKQ0KICAgICB7DQogICAgIAlzdHJ1Y3QgaXBtYl9kZXYgKmlw
bWJfZGV2Ow0KICAgICsJc3RydWN0IGRldmljZV9ub2RlICpucDsNCiAgICAgCWludCByZXQ7DQog
ICAgIA0KICAgICAJaXBtYl9kZXYgPSBkZXZtX2t6YWxsb2MoJmNsaWVudC0+ZGV2LCBzaXplb2Yo
KmlwbWJfZGV2KSwgQEAgLTMwMiw2ICszNDMsMTMgQEAgc3RhdGljIGludCBpcG1iX3Byb2JlKHN0
cnVjdCBpMmNfY2xpZW50ICpjbGllbnQsDQogICAgIAlpZiAocmV0KQ0KICAgICAJCXJldHVybiBy
ZXQ7DQogICAgIA0KICAgICsJLyogQ2hlY2sgaWYgaTJjIGJsb2NrIHhtaXQgbmVlZHMgdG8gdXNl
IGluc3RlYWQgb2Ygc21idXMgKi8NCiAgICArCW5wID0gY2xpZW50LT5kZXYub2Zfbm9kZTsNCiAg
ICArCWlmIChucCAmJiBvZl9nZXRfcHJvcGVydHkobnAsICJ1c2UtaTJjLWJsb2NrIiwgTlVMTCkp
DQogICAgQXNtYWE+PiBSZW5hbWUgdGhpcyB2YXJpYWJsZSBpMmMtcHJvdG9jb2wuIEFuZCBhbHNv
LCBhcHBseSB0aGlzIHRvIEFDUEkgYXMgd2VsbC4NCkRvbmUuDQogICAgKwkJaXBtYl9kZXYtPnVz
ZV9pMmMgPSB0cnVlOw0KICAgICsJZWxzZQ0KICAgICsJCWlwbWJfZGV2LT51c2VfaTJjID0gZmFs
c2U7DQogICAgKw0KICAgICAJaXBtYl9kZXYtPmNsaWVudCA9IGNsaWVudDsNCiAgICAgCWkyY19z
ZXRfY2xpZW50ZGF0YShjbGllbnQsIGlwbWJfZGV2KTsNCiAgICAgCXJldCA9IGkyY19zbGF2ZV9y
ZWdpc3RlcihjbGllbnQsIGlwbWJfc2xhdmVfY2IpOw0KICAgIC0tDQogICAgMi4xNy4xDQogICAg
DQogICAgDQoNCg==
