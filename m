Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F314BC2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D372073B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="rk/QRLhw";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ja5RbXv0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbfLLSU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 13:20:26 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56630 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730291AbfLLSUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:20:25 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBCIJbWT027599;
        Thu, 12 Dec 2019 10:19:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=G4PDbdJMHA1Gm6KFv6mS6bh7OjgH3lsN/+6zro2u+cg=;
 b=rk/QRLhwglncsvUTpU37dzzo6PNyPVfTqfVQMMGewyDZoKOzyZw9HB0tnIW/AtFZ/j6C
 3Vv9oakxC6I+WuW/Jph+Qm6pq2+xzehNZSy2J30ggixi0gH/4/pPWxL/UgxJksFP+lCM
 mRHW5Xe4IZ+Z5iF3cJkxJ7jjo5vguvh2BGw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wuskg0cuh-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Dec 2019 10:19:52 -0800
Received: from ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 12 Dec 2019 10:19:43 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 12 Dec 2019 10:19:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDx0Q0cXm3lKaUAo4kvOugwFivaltpAyt3zlsku0LmOBIn/QYeFlijX3qXEezJXtuId4T0OW+L4UwGIazhVbgoyLzfNOECRxEq4YzFNEI1B74eAQ7Bjat3n8t3PzDvzJVeCENs1RlafRsoosdpNJP1vQaH1dRadCZdTQYBrxYXEduueYCA2d++yZJxK+aJgNzyuTWsY0Smy0NmXAt/Yv847kGh9RxRmTwWGuL/+oqHQVPMTaTLiL8ldl+fRuRHylFoJc/RdZ0O5J8kzSAkR+By2fMepUn3qeTETocoCYwsuFrG7RcqC6qcjrBP4NbcYSiYnszOsmgV2RsGL4Mi7/Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4PDbdJMHA1Gm6KFv6mS6bh7OjgH3lsN/+6zro2u+cg=;
 b=OkIml16vg45W/VWanpkYZZrlIaKPq32ZCf3R5tGf4PfMWVjk40gyat4CYprN+6hQlS47Q8X0XRtjd6jOgfHJhbOzdbcBbEPg1KNtR+Y8c5LGTUWjFNYn5sgMUuD4w++8rbW/W6ag6PCM9BqHOEuL6hxWQgU5If0k/QHiE2XOWQWWBw2+/zaIp6XhU4/b7TyHcux6hKuZKfZvxvQkpSGu0SHFMyN0wdlxOpB6jCxG+tp5VA4M31e3V2DLZCu7EQe9D53ZoKfnC+Ydunn2NXa2bwh58nPK0aFjewWk7txfnjOfaXCbaw4iXCHQoWGvsgbukfNOLHiqtSDLXVnSybHF5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4PDbdJMHA1Gm6KFv6mS6bh7OjgH3lsN/+6zro2u+cg=;
 b=ja5RbXv0KbIL5SIFcR6R9JRSyNzaUXpXZxiBEgIH5tIdOY4JZWKBWzuagYGvvehpGWSS+/m3jheFcUgVlIFSNy98ngdS1LABGSFa+HT7dbYif5wt1eG8lu800hLSF6R4KMvzuuy3xJg7qGOJMDz3CDEEKP0iK4WtF2aQWEU2Y8M=
Received: from MWHPR15MB1597.namprd15.prod.outlook.com (10.173.234.137) by
 MWHPR15MB1613.namprd15.prod.outlook.com (10.175.139.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Thu, 12 Dec 2019 18:19:43 +0000
Received: from MWHPR15MB1597.namprd15.prod.outlook.com
 ([fe80::cdbf:b63c:437:4dd2]) by MWHPR15MB1597.namprd15.prod.outlook.com
 ([fe80::cdbf:b63c:437:4dd2%8]) with mapi id 15.20.2516.018; Thu, 12 Dec 2019
 18:19:43 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "joel@jms.id.au" <joel@jms.id.au>
CC:     Sai Dasari <sdasari@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "manikandan.e@hcl.com" <manikandan.e@hcl.com>
Subject: Re: [PATCH v4 2/2] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
Thread-Topic: [PATCH v4 2/2] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
Thread-Index: AQHVsO02vQqfyrGLt0+IzzReLU6SYqe2SXsA
Date:   Thu, 12 Dec 2019 18:19:42 +0000
Message-ID: <E1D0A71A-3850-4F8F-A451-DC04AD2E5716@fb.com>
References: <20191212130758.GA7388@cnn>
In-Reply-To: <20191212130758.GA7388@cnn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::3:45ed]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f831b3e7-5df9-469e-a817-08d77f2fdc2c
x-ms-traffictypediagnostic: MWHPR15MB1613:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB161392E87E21B8C6B2AA1025DD550@MWHPR15MB1613.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(136003)(376002)(346002)(47680400002)(199004)(189003)(110136005)(2906002)(6512007)(66476007)(316002)(6506007)(33656002)(86362001)(2616005)(5660300002)(186003)(54906003)(66446008)(66556008)(64756008)(36756003)(8936002)(6486002)(8676002)(81156014)(71200400001)(81166006)(66946007)(76116006)(478600001)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1613;H:MWHPR15MB1597.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8OuWLlrG6k6jKR72g4qWlA1BjPKT53RWkfIKjkS4+yVr6Hx1OCrv8H5oOr+ROOZS8VLJtp38ru+Ss4Nx3T6eCICa9LIMFerD6SUQxf30p53s4VUCaVbjcgv/mkMADtomp0gc1109FqmWhRRv+VO6D8eTNddaydf3LS9z4ZXv2/pP9XVjzs8ncDKJYexhfFI4W8Gm4Kbv+0YW9OBFz/G3BgM0eUf/DOeNe9Ubq1XwYAZRlhquu1CtC6ONjhI7MCODfW/Nr2L7ZK7gAt6K+AT2lU3SJI+M/2PpN1OEhuHB4XcOYv1zg1CRH/nA2bjh7BhZ1BuHrf4w548WhwXFsgYNHyO6vJuyTiTATaY5bgMMXCBT38xuFQeT66NwzBj8wDHLxOgZzFlZp2CJJ6rxeMElYv+4gdRjlvETPdqqBfcUvigK23Ab7nTkgpxxwanH4dKU
Content-Type: text/plain; charset="utf-8"
Content-ID: <6737FA83FE6F2D4A9EE5915BB7F55230@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f831b3e7-5df9-469e-a817-08d77f2fdc2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 18:19:42.8589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qrWG01hvk283VxvQn9FBt0MyGvQtSHcwTAgb0HZg3M+OsxCKMOoHUXtD6fDaq8vsWvRwl1jnqgVK/yLWE7OAYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1613
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_06:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912120141
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFuaSwNClBsZWFzZSBzdWJtaXQgcGF0Y2ggdmVyc2lvbiA1IGFuZCBwdXQgcmV2aWV3IGNv
bW1lbnRzIGJlbG93ICgtLS0pIGxpbmUgbGlrZSBiZWxvdy4gDQpBbmQgc2VuZCBhcyBhIHBhdGNo
IHN1Ym1pc3Npb24gbm90IHJlcGxpZWQgdG8gdGhpcyBlbWFpbC4NCg0KICAgVGhlIFlvc2VtaXRl
IFYyIGlzIGEgZmFjZWJvb2sgbXVsdGktbm9kZSBzZXJ2ZXINCiAgICBwbGF0Zm9ybSB0aGF0IGhv
c3QgZm91ciBPQ1Agc2VydmVyLiBUaGUgQk1DDQogICAgaW4gdGhlIFlvc2VtaXRlIFYyIHBsYXRm
b3JtIGJhc2VkIG9uIEFTVDI1MDAgU29DLg0KICAgIA0KICAgIFRoaXMgcGF0Y2ggYWRkcyBsaW51
eCBkZXZpY2UgdHJlZSBlbnRyeSByZWxhdGVkIHRvDQogICAgWW9zZW1pdGUgVjIgc3BlY2lmaWMg
ZGV2aWNlcyBjb25uZWN0ZWQgdG8gQk1DIFNvQy4NCg0KICAgIFNpZ25lZC1vZmYtYnk6IE1hbmlr
YW5kYW4gRWx1bWFsYWkgPG1hbmlrYW5kYW4uaGNsLmVycy5lcGxAZ21haWwuY29tPg0KICAgIEFj
a2VkLWJ5ICAgOiBBbmRyZXcgSmVmZmVyeSA8YW5kcmV3QGFqLmlkLmF1Pg0KICAgIFJldmlld2Vk
LWJ5OiBWaWpheSBLaGVta2EgPHZraGVta2FAZmIuY29tPg0KICAgIC0tLQ0KICAgIC0tLSAgICAg
djUgLSBTcGVsbCBhbmQgY29udHJpYnV0b3IgbmFtZSBjb3JyZWN0aW9uLg0KICAgIC0tLSAgICAg
ICAgICAtIExpY2Vuc2UgaWRlbnRpZmllciBjaGFuZ2VkIHRvIEdQTC0yLjAtb3ItbGF0ZXIuDQog
ICAgLS0tICAgICAgICAgIC0gYXNwZWVkLWdwaW8uaCByZW1vdmVkLg0KICAgIC0tLSAgICAgICAg
ICAtIEZBTjIgdGFjaG8gY2hhbm5lbCBjaGFuZ2VkLg0KICAgIC0tLSAgICAgIHY0IC0gQm9vdGFy
Z3MgcmVtb3ZlZC4NCiAgICAtLS0gICAgICB2MyAtIFVhcnQxIERlYnVnIHJlbW92ZWQgLg0KICAg
IC0tLSAgICAgIHYyIC0gTFBDIGFuZCBWVUFSVCByZW1vdmVkIC4NCiAgICAtLS0gICAgICB2MSAt
IEluaXRpYWwgZHJhZnQuDQoNCi4uLi9ib290L2R0cy9hc3BlZWQtYm1jLWZhY2Vib29rLXlvc2Vt
aXRldjIuZHRzICAgIHwgMTQ4ICsrKysrKysrKysrKysrKysrKysrKw0KICAgICAxIGZpbGUgY2hh
bmdlZCwgMTQ4IGluc2VydGlvbnMoKykNCiAgICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJt
L2Jvb3QvZHRzL2FzcGVlZC1ibWMtZmFjZWJvb2steW9zZW1pdGV2Mi5kdHMNCg0KUmVnYXJkcw0K
LVZpamF5DQoNCu+7v09uIDEyLzEyLzE5LCA1OjA4IEFNLCAiTWFuaWthbmRhbiBFbHVtYWxhaSIg
PG1hbmlrYW5kYW4uaGNsLmVycy5lcGxAZ21haWwuY29tPiB3cm90ZToNCg0KICAgIFRoZSBZb3Nl
bWl0ZSBWMiBpcyBhIGZhY2Vib29rIG11bHRpLW5vZGUgc2VydmVyDQogICAgcGxhdGZvcm0gdGhh
dCBob3N0IGZvdXIgT0NQIHNlcnZlci4gVGhlIEJNQw0KICAgIGluIHRoZSBZb3NlbWl0ZSBWMiBw
bGF0Zm9ybSBiYXNlZCBvbiBBU1QyNTAwIFNvQy4NCiAgICANCiAgICBUaGlzIHBhdGNoIGFkZHMg
bGludXggZGV2aWNlIHRyZWUgZW50cnkgcmVsYXRlZCB0bw0KICAgIFlvc2VtaXRlIFYyIHNwZWNp
ZmljIGRldmljZXMgY29ubmVjdGVkIHRvIEJNQyBTb0MuDQogICAgDQogICAgLS0tIFJldmlld3Mg
c3VtbWFyeQ0KICAgIC0tLSB2NFsyLzJdIC0gU3BlbGwgYW5kIGNvbnRyaWJ1dG9yIG5hbWUgY29y
cmVjdGlvbi4NCiAgICAtLS0gICAgICAgICAtIExpY2Vuc2UgaWRlbnRpZmllciBjaGFuZ2VkIHRv
IEdQTC0yLjAtb3ItbGF0ZXIuDQogICAgLS0tICAgICAgICAgLSBhc3BlZWQtZ3Bpby5oIHJlbW92
ZWQuDQogICAgLS0tICAgICAgICAgLSBGQU4yIHRhY2hvIGNoYW5uZWwgY2hhbmdlZC4NCiAgICAt
LS0gICAgICB2NCAtIEJvb3RhcmdzIHJlbW92ZWQuDQogICAgLS0tICAgICAgdjMgLSBVYXJ0MSBE
ZWJ1ZyByZW1vdmVkIC4NCiAgICAtLS0gICAgICB2MiAtIExQQyBhbmQgVlVBUlQgcmVtb3ZlZCAu
DQogICAgLS0tICAgICAgdjEgLSBJbml0aWFsIGRyYWZ0Lg0KICAgIA0KICAgIFNpZ25lZC1vZmYt
Ynk6IE1hbmlrYW5kYW4gRWx1bWFsYWkgPG1hbmlrYW5kYW4uaGNsLmVycy5lcGxAZ21haWwuY29t
Pg0KICAgIEFja2VkLWJ5ICAgOiBBbmRyZXcgSmVmZmVyeSA8YW5kcmV3QGFqLmlkLmF1Pg0KICAg
IFJldmlld2VkLWJ5OiBWaWpheSBLaGVta2EgPHZraGVta2FAZmIuY29tPg0KICAgIC0tLQ0KICAg
ICAuLi4vYm9vdC9kdHMvYXNwZWVkLWJtYy1mYWNlYm9vay15b3NlbWl0ZXYyLmR0cyAgICB8IDE0
OCArKysrKysrKysrKysrKysrKysrKysNCiAgICAgMSBmaWxlIGNoYW5nZWQsIDE0OCBpbnNlcnRp
b25zKCspDQogICAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9ib290L2R0cy9hc3BlZWQt
Ym1jLWZhY2Vib29rLXlvc2VtaXRldjIuZHRzDQogICAgDQogICAgZGlmZiAtLWdpdCBhL2FyY2gv
YXJtL2Jvb3QvZHRzL2FzcGVlZC1ibWMtZmFjZWJvb2steW9zZW1pdGV2Mi5kdHMgYi9hcmNoL2Fy
bS9ib290L2R0cy9hc3BlZWQtYm1jLWZhY2Vib29rLXlvc2VtaXRldjIuZHRzDQogICAgbmV3IGZp
bGUgbW9kZSAxMDA2NDQNCiAgICBpbmRleCAwMDAwMDAwLi5mZmQ3ZjRjDQogICAgLS0tIC9kZXYv
bnVsbA0KICAgICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC1ibWMtZmFjZWJvb2steW9z
ZW1pdGV2Mi5kdHMNCiAgICBAQCAtMCwwICsxLDE0OCBAQA0KICAgICsvLyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcg0KICAgICsvLyBDb3B5cmlnaHQgKGMpIDIwMTgg
RmFjZWJvb2sgSW5jLg0KICAgICsNCiAgICArL2R0cy12MS87DQogICAgKw0KICAgICsjaW5jbHVk
ZSAiYXNwZWVkLWc1LmR0c2kiDQogICAgKy8gew0KICAgICsJbW9kZWwgPSAiRmFjZWJvb2sgWW9z
ZW1pdGV2MiBCTUMiOw0KICAgICsJY29tcGF0aWJsZSA9ICJmYWNlYm9vayx5b3NlbWl0ZXYyLWJt
YyIsICJhc3BlZWQsYXN0MjUwMCI7DQogICAgKwlhbGlhc2VzIHsNCiAgICArCQlzZXJpYWw0ID0g
JnVhcnQ1Ow0KICAgICsJfTsNCiAgICArCWNob3NlbiB7DQogICAgKwkJc3Rkb3V0LXBhdGggPSAm
dWFydDU7DQogICAgKwl9Ow0KICAgICsNCiAgICArCW1lbW9yeUA4MDAwMDAwMCB7DQogICAgKwkJ
cmVnID0gPDB4ODAwMDAwMDAgMHgyMDAwMDAwMD47DQogICAgKwl9Ow0KICAgICsNCiAgICArCWlp
by1od21vbiB7DQogICAgKwkJLy8gVk9MQVRBR0UgU0VOU09SDQogICAgKwkJY29tcGF0aWJsZSA9
ICJpaW8taHdtb24iOw0KICAgICsJCWlvLWNoYW5uZWxzID0gPCZhZGMgMD4gLCA8JmFkYyAxPiAs
IDwmYWRjIDI+ICwgIDwmYWRjIDM+ICwNCiAgICArCQk8JmFkYyA0PiAsIDwmYWRjIDU+ICwgPCZh
ZGMgNj4gLCAgPCZhZGMgNz4gLA0KICAgICsJCTwmYWRjIDg+ICwgPCZhZGMgOT4gLCA8JmFkYyAx
MD4sIDwmYWRjIDExPiAsDQogICAgKwkJPCZhZGMgMTI+ICwgPCZhZGMgMTM+ICwgPCZhZGMgMTQ+
ICwgPCZhZGMgMTU+IDsNCiAgICArCX07DQogICAgK307DQogICAgKw0KICAgICsmZm1jIHsNCiAg
ICArCXN0YXR1cyA9ICJva2F5IjsNCiAgICArCWZsYXNoQDAgew0KICAgICsJCXN0YXR1cyA9ICJv
a2F5IjsNCiAgICArCQltMjVwLGZhc3QtcmVhZDsNCiAgICArI2luY2x1ZGUgIm9wZW5ibWMtZmxh
c2gtbGF5b3V0LmR0c2kiDQogICAgKwl9Ow0KICAgICt9Ow0KICAgICsNCiAgICArJnNwaTEgew0K
ICAgICsJc3RhdHVzID0gIm9rYXkiOw0KICAgICsJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsN
CiAgICArCXBpbmN0cmwtMCA9IDwmcGluY3RybF9zcGkxX2RlZmF1bHQ+Ow0KICAgICsJZmxhc2hA
MCB7DQogICAgKwkJc3RhdHVzID0gIm9rYXkiOw0KICAgICsJCW0yNXAsZmFzdC1yZWFkOw0KICAg
ICsJCWxhYmVsID0gInBub3IiOw0KICAgICsJfTsNCiAgICArfTsNCiAgICArDQogICAgKyZ1YXJ0
NSB7DQogICAgKwkvLyBCTUMgQ29uc29sZQ0KICAgICsJc3RhdHVzID0gIm9rYXkiOw0KICAgICt9
Ow0KICAgICsNCiAgICArJm1hYzAgew0KICAgICsJc3RhdHVzID0gIm9rYXkiOw0KICAgICsJcGlu
Y3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCiAgICArCXBpbmN0cmwtMCA9IDwmcGluY3RybF9ybWlp
MV9kZWZhdWx0PjsNCiAgICArCXVzZS1uY3NpOw0KICAgICt9Ow0KICAgICsNCiAgICArJmFkYyB7
DQogICAgKwlzdGF0dXMgPSAib2theSI7DQogICAgKwlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQi
Ow0KICAgICsJcGluY3RybC0wID0gPCZwaW5jdHJsX2FkYzBfZGVmYXVsdA0KICAgICsJCQkmcGlu
Y3RybF9hZGMxX2RlZmF1bHQNCiAgICArCQkJJnBpbmN0cmxfYWRjMl9kZWZhdWx0DQogICAgKwkJ
CSZwaW5jdHJsX2FkYzNfZGVmYXVsdA0KICAgICsJCQkmcGluY3RybF9hZGM0X2RlZmF1bHQNCiAg
ICArCQkJJnBpbmN0cmxfYWRjNV9kZWZhdWx0DQogICAgKwkJCSZwaW5jdHJsX2FkYzZfZGVmYXVs
dA0KICAgICsJCQkmcGluY3RybF9hZGM3X2RlZmF1bHQNCiAgICArCQkJJnBpbmN0cmxfYWRjOF9k
ZWZhdWx0DQogICAgKwkJCSZwaW5jdHJsX2FkYzlfZGVmYXVsdA0KICAgICsJCQkmcGluY3RybF9h
ZGMxMF9kZWZhdWx0DQogICAgKwkJCSZwaW5jdHJsX2FkYzExX2RlZmF1bHQNCiAgICArCQkJJnBp
bmN0cmxfYWRjMTJfZGVmYXVsdA0KICAgICsJCQkmcGluY3RybF9hZGMxM19kZWZhdWx0DQogICAg
KwkJCSZwaW5jdHJsX2FkYzE0X2RlZmF1bHQNCiAgICArCQkJJnBpbmN0cmxfYWRjMTVfZGVmYXVs
dD47DQogICAgK307DQogICAgKw0KICAgICsmaTJjOCB7DQogICAgKwkvL0ZSVSBFRVBST00NCiAg
ICArCXN0YXR1cyA9ICJva2F5IjsNCiAgICArCWVlcHJvbUA1MSB7DQogICAgKwkJY29tcGF0aWJs
ZSA9ICJhdG1lbCwyNGM2NCI7DQogICAgKwkJcmVnID0gPDB4NTE+Ow0KICAgICsJCXBhZ2VzaXpl
ID0gPDMyPjsNCiAgICArCX07DQogICAgK307DQogICAgKw0KICAgICsmaTJjOSB7DQogICAgKwkv
L0lOTEVUICYgT1VUTEVUIFRFTVANCiAgICArCXN0YXR1cyA9ICJva2F5IjsNCiAgICArCXRtcDQy
MUA0ZSB7DQogICAgKwkJY29tcGF0aWJsZSA9ICJ0aSx0bXA0MjEiOw0KICAgICsJCXJlZyA9IDww
eDRlPjsNCiAgICArCX07DQogICAgKwl0bXA0MjFANGYgew0KICAgICsJCWNvbXBhdGlibGUgPSAi
dGksdG1wNDIxIjsNCiAgICArCQlyZWcgPSA8MHg0Zj47DQogICAgKwl9Ow0KICAgICt9Ow0KICAg
ICsNCiAgICArJmkyYzEwIHsNCiAgICArCS8vSFNDDQogICAgKwlzdGF0dXMgPSAib2theSI7DQog
ICAgKwlhZG0xMjc4QDQwIHsNCiAgICArCQljb21wYXRpYmxlID0gImFkaSxhZG0xMjc4IjsNCiAg
ICArCQlyZWcgPSA8MHg0MD47DQogICAgKwl9Ow0KICAgICt9Ow0KICAgICsNCiAgICArJmkyYzEx
IHsNCiAgICArCS8vTUVaWl9URU1QX1NFTlNPUg0KICAgICsJc3RhdHVzID0gIm9rYXkiOw0KICAg
ICsJdG1wNDIxQDFmIHsNCiAgICArCQljb21wYXRpYmxlID0gInRpLHRtcDQyMSI7DQogICAgKwkJ
cmVnID0gPDB4MWY+Ow0KICAgICsJfTsNCiAgICArfTsNCiAgICArDQogICAgKyZpMmMxMiB7DQog
ICAgKwkvL01FWlpfRlJVDQogICAgKwlzdGF0dXMgPSAib2theSI7DQogICAgKwllZXByb21ANTEg
ew0KICAgICsJCWNvbXBhdGlibGUgPSAiYXRtZWwsMjRjNjQiOw0KICAgICsJCXJlZyA9IDwweDUx
PjsNCiAgICArCQlwYWdlc2l6ZSA9IDwzMj47DQogICAgKwl9Ow0KICAgICt9Ow0KICAgICsNCiAg
ICArJnB3bV90YWNobyB7DQogICAgKwkvL0ZTQw0KICAgICsJc3RhdHVzID0gIm9rYXkiOw0KICAg
ICsJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCiAgICArCXBpbmN0cmwtMCA9IDwmcGluY3Ry
bF9wd20wX2RlZmF1bHQgJnBpbmN0cmxfcHdtMV9kZWZhdWx0PjsNCiAgICArCWZhbkAwIHsNCiAg
ICArCQlyZWcgPSA8MHgwMD47DQogICAgKwkJYXNwZWVkLGZhbi10YWNoLWNoID0gL2JpdHMvIDgg
PDB4MDA+Ow0KICAgICsJfTsNCiAgICArCWZhbkAxIHsNCiAgICArCQlyZWcgPSA8MHgwMT47DQog
ICAgKwkJYXNwZWVkLGZhbi10YWNoLWNoID0gL2JpdHMvIDggPDB4MDE+Ow0KICAgICsJfTsNCiAg
ICArfTsNCiAgICAtLSANCiAgICAyLjcuNA0KICAgIA0KICAgIA0KDQo=
