Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191B5C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D384D208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="S6wKgj5q";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="6eZx3AP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbfHNOaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 10:30:16 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:3570 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727900AbfHNOaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:30:13 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7EEIsQN009411;
        Wed, 14 Aug 2019 07:30:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=hxfK9OSNdaK4+mmNMVd6LsYgFvb5acNVD4GCUae02Fs=;
 b=S6wKgj5qZzme6YzrMV1AJ9VcBieClOO33WLS025QHagd76gdwd2Xtj7WmDvvAXIPKOJg
 VaT5Uo1bvZ5RDJ6wTzlU+IUC2VXZhXXN4rbYoitMcoRxZeodGMgQ0p8o38FbtimD7IFM
 P2gvaHrSC7UjV3KtBA3d14W917F337yssmLmgFmpc+OjMK9Y0LNGWtosGnR44iLUtjNk
 2XgcTbYi7uuTqUNtxKkKKLC0XYmSCHOcpkgs2pgSD1BUThRzZTnRMaex0Xcc7JUQzOPX
 kABZW6kTuUIbhyazXndZgnEs6MGFzRnYfhbKZbyEdYUsgdj5HPjrrDHW1IJhyoJ8Ajeq 8A== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2058.outbound.protection.outlook.com [104.47.33.58])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2u9tfsexc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 14 Aug 2019 07:30:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsFvv4PI1mqsIE6RbY581pPXHQ7R12ajBhTu7npx0hoKnxfawqtzgFO0vAS1bczCk2UjRq7URs6tvRWDCYM5SEkcFdR8ZJf3kQdrqA6YkWT8xh/9fvBwk3Y6EBWCHyKJLjqbMXo4We/25Outc4nhIYSREfM5IfBLPwwR7t6SoI425EtQqcGIu3A7mxMpuDnSssJgsMyZbj/1fNOEikxYmp5kIbCVuka8TF8XgxSwDCI27H8/heaR7onGGudYNHpugym0ShCM6cLKnrX/r4Gq8DL0bkMfbGxKRGh773x93MBysCc5+pUG3zYQLLEcWguRAg7efGqEbJhAG5XON1l7Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxfK9OSNdaK4+mmNMVd6LsYgFvb5acNVD4GCUae02Fs=;
 b=hOse99y8sqXUEibzYDWvyZYiN4D4MGtQ2+T6kWlgIy3PZQ8CcdiWvt+SEf20Jtzkf84TcS17/68ZVhiY5M1VAHX1PqHOaWLA9coiIFbyeRO69BoDoe3RSpzIsxbaTdtF627jZ/hqybtq+CrJTrR8cb4bJDT7o8IQrGvHIKb0sEcythIuVIvXgbpxUALT5S2cEliN/I0Cd9LLjkRmm/NsSrSY91EF53og9FtH7hWpDm1ad9ScvwQVuf2uA8UsSXlX7zw0w+t+78eNu0kQPpRB8oW5MoAUBWWH5YS95ChnrHNJ8xNxZkkbuXlu0f9oR8W1jTgH34l9aWDxuDzqzZRfKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxfK9OSNdaK4+mmNMVd6LsYgFvb5acNVD4GCUae02Fs=;
 b=6eZx3AP8klTBNea6E+ft+2NyK79CW8YB7P535xLfUTaOfSqnXNPCz6D9IEeSf1Qo/8HY2Zoy4rPZ5yuzSbUBJ3k6IuozWObZCLIB+qhAgDrY569wP/HdQ6mN12/1s2PiOfzzLPsc1bQgDanvLVRAQvnX7yLb648rMQYdFWkjckI=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5640.namprd07.prod.outlook.com (20.177.231.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Wed, 14 Aug 2019 14:30:06 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::98f2:1592:6dff:63e]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::98f2:1592:6dff:63e%7]) with mapi id 15.20.2157.022; Wed, 14 Aug 2019
 14:30:05 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Roger Quadros <rogerq@ti.com>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Anil Joy Varughese <aniljoy@cadence.com>
Subject: RE: [PATCH v10 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Topic: [PATCH v10 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Index: AQHVP/LMLOdqGz4qV0qb+zFnj54Ok6b6yyiAgAANnXA=
Date:   Wed, 14 Aug 2019 14:30:05 +0000
Message-ID: <BYAPR07MB4709941410AE163EB0627C16DDAD0@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1563733939-21214-1-git-send-email-pawell@cadence.com>
 <1563733939-21214-6-git-send-email-pawell@cadence.com>
 <2c5ed505-6fee-1816-e5bb-59a9ed96fb70@ti.com>
In-Reply-To: <2c5ed505-6fee-1816-e5bb-59a9ed96fb70@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZGIxODI2NWItYmU5Zi0xMWU5LTg3NDUtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGRiMTgyNjVkLWJlOWYtMTFlOS04NzQ1LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iNTIyNCIgdD0iMTMyMTAyNjY1NDA2NzEwMzU4IiBoPSJQQTlCR0Q2SFUxcVMySDJ4QWRHWFJhY2tiZEU9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7eb94c5-0fda-4bdd-86d9-08d720c3e6d3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB5640;
x-ms-traffictypediagnostic: BYAPR07MB5640:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB564003C74C9D222265D92D29DDAD0@BYAPR07MB5640.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01294F875B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(36092001)(189003)(199004)(66066001)(26005)(7696005)(316002)(76176011)(6506007)(102836004)(66476007)(66556008)(64756008)(66446008)(66946007)(9686003)(74316002)(110136005)(81166006)(81156014)(8676002)(54906003)(2906002)(76116006)(6116002)(256004)(3846002)(305945005)(33656002)(8936002)(14444005)(71190400001)(71200400001)(86362001)(99286004)(7736002)(55016002)(14454004)(2501003)(52536014)(53936002)(6246003)(107886003)(6436002)(229853002)(5660300002)(25786009)(4326008)(486006)(11346002)(446003)(476003)(186003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5640;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zjsDr/+0S3QSiVaczWGfZGNtjBwvEzHgTuNrjlO2xxFhREoeBR/4knJEZhmDgWBVw6QFPyTs+J66vbU9qgGryvlYcqe8VSqqdcFy0QG1GWIuPUdMFKwHYeQCftO9TDBOfSjnZIUKpX4hK3Y64cXzGduqp5H4BvJUwRz+FCBFYuphpelgRGZqMxRTq+tiTtJg95xZOum6BgnQI34VLGzm8k38FcFGv1xRMU6unMevfgFiZl1jT+vHnnnqFMU59JpkEFNTS/gEbmhZ+XBa3w8OeWJWoCxZwF/Fl1F9+fXcwuUk5FdDLH9x5vNzKM/vmEHpreRe0IiT41AKfbmD5Wp5k81duc7dOZekOME8vKoovoNJQG+/WZKtyq7ICII1JCJHxNyFJLgQGp3ge5L0ugtQ/FN1lSv6arIKhtkU8CP8n3M=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7eb94c5-0fda-4bdd-86d9-08d720c3e6d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2019 14:30:05.6430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eEqSNgjWELKhG1KaKBDAFmQ7kTpIl5Tcx1FiK1Gjr/vp6vuC4mAr4C8Q2qz8aKv08YYuzfz8IKlfvzs94fEq5NNNcxlNbBM7xoNeb/WUXP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5640
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-14_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908140149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9nZXIsDQoNCj4NCj5PbiAyMS8wNy8yMDE5IDIxOjMyLCBQYXdlbCBMYXN6Y3phayB3cm90
ZToNCj4+IFRoaXMgcGF0Y2ggaW50cm9kdWNlIG5ldyBDYWRlbmNlIFVTQlNTIERSRCBkcml2ZXIg
dG8gTGludXgga2VybmVsLg0KPj4NCj4+IFRoZSBDYWRlbmNlIFVTQlNTIERSRCBDb250cm9sbGVy
IGlzIGEgaGlnaGx5IGNvbmZpZ3VyYWJsZSBJUCBDb3JlIHdoaWNoDQo+PiBjYW4gYmUgaW5zdGFu
dGlhdGVkIGFzIER1YWwtUm9sZSBEZXZpY2UgKERSRCksIFBlcmlwaGVyYWwgT25seSBhbmQNCj4+
IEhvc3QgT25seSAoWEhDSSljb25maWd1cmF0aW9ucy4NCj4+DQo+PiBUaGUgY3VycmVudCBkcml2
ZXIgaGFzIGJlZW4gdmFsaWRhdGVkIHdpdGggRlBHQSBwbGF0Zm9ybS4gV2UgaGF2ZQ0KPj4gc3Vw
cG9ydCBmb3IgUENJZSBidXMsIHdoaWNoIGlzIHVzZWQgb24gRlBHQSBwcm90b3R5cGluZy4NCj4+
DQo+PiBUaGUgaG9zdCBzaWRlIG9mIFVTQlNTLURSRCBjb250cm9sbGVyIGlzIGNvbXBsaWFudCB3
aXRoIFhIQ0kNCj4+IHNwZWNpZmljYXRpb24sIHNvIGl0IHdvcmtzIHdpdGggc3RhbmRhcmQgWEhD
SSBMaW51eCBkcml2ZXIuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogUGF3ZWwgTGFzemN6YWsgPHBh
d2VsbEBjYWRlbmNlLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvdXNiL0tjb25maWcgICAgICAg
ICAgICAgICAgfCAgICAyICsNCj4+ICBkcml2ZXJzL3VzYi9NYWtlZmlsZSAgICAgICAgICAgICAg
IHwgICAgMiArDQo+PiAgZHJpdmVycy91c2IvY2RuczMvS2NvbmZpZyAgICAgICAgICB8ICAgNDYg
Kw0KPj4gIGRyaXZlcnMvdXNiL2NkbnMzL01ha2VmaWxlICAgICAgICAgfCAgIDE3ICsNCj4+ICBk
cml2ZXJzL3VzYi9jZG5zMy9jZG5zMy1wY2ktd3JhcC5jIHwgIDIwMyArKysNCj4+ICBkcml2ZXJz
L3VzYi9jZG5zMy9jb3JlLmMgICAgICAgICAgIHwgIDU1NCArKysrKysrDQo+PiAgZHJpdmVycy91
c2IvY2RuczMvY29yZS5oICAgICAgICAgICB8ICAxMDkgKysNCj4+ICBkcml2ZXJzL3VzYi9jZG5z
My9kZWJ1Zy5oICAgICAgICAgIHwgIDE3MSArKw0KPj4gIGRyaXZlcnMvdXNiL2NkbnMzL2RlYnVn
ZnMuYyAgICAgICAgfCAgIDg3ICsrDQo+PiAgZHJpdmVycy91c2IvY2RuczMvZHJkLmMgICAgICAg
ICAgICB8ICAzOTAgKysrKysNCj4+ICBkcml2ZXJzL3VzYi9jZG5zMy9kcmQuaCAgICAgICAgICAg
IHwgIDE2NiArKw0KPj4gIGRyaXZlcnMvdXNiL2NkbnMzL2VwMC5jICAgICAgICAgICAgfCAgOTE0
ICsrKysrKysrKysrDQo+PiAgZHJpdmVycy91c2IvY2RuczMvZ2FkZ2V0LWV4cG9ydC5oICB8ICAg
MjggKw0KPj4gIGRyaXZlcnMvdXNiL2NkbnMzL2dhZGdldC5jICAgICAgICAgfCAyMzM4ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCj4+ICBkcml2ZXJzL3VzYi9jZG5zMy9nYWRnZXQuaCAg
ICAgICAgIHwgMTMyMSArKysrKysrKysrKysrKysrDQo+PiAgZHJpdmVycy91c2IvY2RuczMvaG9z
dC1leHBvcnQuaCAgICB8ICAgMjggKw0KPj4gIGRyaXZlcnMvdXNiL2NkbnMzL2hvc3QuYyAgICAg
ICAgICAgfCAgIDcxICsNCj4+ICBkcml2ZXJzL3VzYi9jZG5zMy90cmFjZS5jICAgICAgICAgIHwg
ICAxMSArDQo+PiAgZHJpdmVycy91c2IvY2RuczMvdHJhY2UuaCAgICAgICAgICB8ICA0OTMgKysr
KysrDQo+PiAgMTkgZmlsZXMgY2hhbmdlZCwgNjk1MSBpbnNlcnRpb25zKCspDQo+PiAgY3JlYXRl
IG1vZGUgMTAwNjQ0IGRyaXZlcnMvdXNiL2NkbnMzL0tjb25maWcNCj4+ICBjcmVhdGUgbW9kZSAx
MDA2NDQgZHJpdmVycy91c2IvY2RuczMvTWFrZWZpbGUNCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy91c2IvY2RuczMvY2RuczMtcGNpLXdyYXAuYw0KPj4gIGNyZWF0ZSBtb2RlIDEwMDY0
NCBkcml2ZXJzL3VzYi9jZG5zMy9jb3JlLmMNCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVy
cy91c2IvY2RuczMvY29yZS5oDQo+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdXNiL2Nk
bnMzL2RlYnVnLmgNCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy91c2IvY2RuczMvZGVi
dWdmcy5jDQo+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdXNiL2NkbnMzL2RyZC5jDQo+
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdXNiL2NkbnMzL2RyZC5oDQo+PiAgY3JlYXRl
IG1vZGUgMTAwNjQ0IGRyaXZlcnMvdXNiL2NkbnMzL2VwMC5jDQo+PiAgY3JlYXRlIG1vZGUgMTAw
NjQ0IGRyaXZlcnMvdXNiL2NkbnMzL2dhZGdldC1leHBvcnQuaA0KPj4gIGNyZWF0ZSBtb2RlIDEw
MDY0NCBkcml2ZXJzL3VzYi9jZG5zMy9nYWRnZXQuYw0KPj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBk
cml2ZXJzL3VzYi9jZG5zMy9nYWRnZXQuaA0KPj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJz
L3VzYi9jZG5zMy9ob3N0LWV4cG9ydC5oDQo+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMv
dXNiL2NkbnMzL2hvc3QuYw0KPj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3VzYi9jZG5z
My90cmFjZS5jDQo+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdXNiL2NkbnMzL3RyYWNl
LmgNCj4+DQo+DQo+PHNuaXA+DQo+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvY2RuczMv
Z2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9jZG5zMy9nYWRnZXQuYw0KPj4gbmV3IGZpbGUgbW9kZSAx
MDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uMjkxZjA4YmU1NmZlDQo+PiAtLS0gL2Rldi9u
dWxsDQo+PiArKysgYi9kcml2ZXJzL3VzYi9jZG5zMy9nYWRnZXQuYw0KPj4gQEAgLTAsMCArMSwy
MzM4IEBADQo+PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4+ICsvKg0K
Pj4gKyAqIENhZGVuY2UgVVNCU1MgRFJEIERyaXZlciAtIGdhZGdldCBzaWRlLg0KPj4gKyAqDQo+
PiArICogQ29weXJpZ2h0IChDKSAyMDE4LTIwMTkgQ2FkZW5jZSBEZXNpZ24gU3lzdGVtcy4NCj4+
ICsgKiBDb3B5cmlnaHQgKEMpIDIwMTctMjAxOCBOWFANCj4+ICsgKg0KPj4gKyAqIEF1dGhvcnM6
IFBhd2VsIEpleiA8cGplekBjYWRlbmNlLmNvbT4sDQo+PiArICogICAgICAgICAgUGF3ZWwgTGFz
emN6YWsgPHBhd2VsbEBjYWRlbmNlLmNvbT4NCj4+ICsgKiAgICAgICAgICBQZXRlciBDaGVuIDxw
ZXRlci5jaGVuQG54cC5jb20+DQo+PiArICovDQo+PiArDQo+DQo+PHNuaXA+DQo+DQo+PiArDQo+
PiArc3RhdGljIHZvaWQgY2RuczNfZ2FkZ2V0X2NvbmZpZyhzdHJ1Y3QgY2RuczNfZGV2aWNlICpw
cml2X2RldikNCj4+ICt7DQo+PiArCXN0cnVjdCBjZG5zM191c2JfcmVncyBfX2lvbWVtICpyZWdz
ID0gcHJpdl9kZXYtPnJlZ3M7DQo+PiArCXUzMiByZWc7DQo+PiArDQo+PiArCWNkbnMzX2VwMF9j
b25maWcocHJpdl9kZXYpOw0KPj4gKw0KPj4gKwkvKiBlbmFibGUgaW50ZXJydXB0cyBmb3IgZW5k
cG9pbnQgMCAoaW4gYW5kIG91dCkgKi8NCj4+ICsJd3JpdGVsKEVQX0lFTl9FUF9PVVQwIHwgRVBf
SUVOX0VQX0lOMCwgJnJlZ3MtPmVwX2llbik7DQo+PiArDQo+PiArCS8qDQo+PiArCSAqIERyaXZl
ciBuZWVkcyB0byBtb2RpZnkgTEZQUyBtaW5pbWFsIFUxIEV4aXQgdGltZSBmb3IgREVWX1ZFUl9U
SV9WMQ0KPj4gKwkgKiByZXZpc2lvbiBvZiBjb250cm9sbGVyLg0KPj4gKwkgKi8NCj4+ICsJaWYg
KHByaXZfZGV2LT5kZXZfdmVyID09IERFVl9WRVJfVElfVjEpIHsNCj4+ICsJCXJlZyA9IHJlYWRs
KCZyZWdzLT5kYmdfbGluazEpOw0KPj4gKw0KPj4gKwkJcmVnICY9IH5EQkdfTElOSzFfTEZQU19N
SU5fR0VOX1UxX0VYSVRfTUFTSzsNCj4+ICsJCXJlZyB8PSBEQkdfTElOSzFfTEZQU19NSU5fR0VO
X1UxX0VYSVQoMHg1NSkgfA0KPj4gKwkJICAgICAgIERCR19MSU5LMV9MRlBTX01JTl9HRU5fVTFf
RVhJVF9TRVQ7DQo+PiArCQl3cml0ZWwocmVnLCAmcmVncy0+ZGJnX2xpbmsxKTsNCj4+ICsJfQ0K
Pj4gKw0KPj4gKwkvKg0KPj4gKwkgKiBCeSBkZWZhdWx0IHNvbWUgcGxhdGZvcm1zIGhhcyBzZXQg
cHJvdGVjdGVkIGFjY2VzcyB0byBtZW1vcnkuDQo+PiArCSAqIFRoaXMgY2F1c2UgcHJvYmxlbSB3
aXRoIGNhY2hlLCBzbyBkcml2ZXIgcmVzdG9yZSBub24tc2VjdXJlDQo+PiArCSAqIGFjY2VzcyB0
byBtZW1vcnkuDQo+PiArCSAqLw0KPj4gKwlyZWcgPSByZWFkbCgmcmVncy0+ZG1hX2F4aV9jdHJs
KTsNCj4NCj5XaHkgcmVhZCB0aGUgcmVnIGF0IGFsbCBpZiB5b3UgYXJlIGp1c3Qgb3ZlcndyaXRp
bmcgaXQgYmVsb3c/DQo+DQo+PiArCXJlZyA9IERNQV9BWElfQ1RSTF9NQVJQUk9UKERNQV9BWElf
Q1RSTF9OT05fU0VDVVJFKSB8DQo+PiArCSAgICAgIERNQV9BWElfQ1RSTF9NQVdQUk9UKERNQV9B
WElfQ1RSTF9OT05fU0VDVVJFKTsNCj4NCj4NCj5PdGhlcndpc2UgeW91IG5lZWQgdG8gcmVhZCBt
b2RpZnkgb25seSBuZWNlc3NhcnkgYml0cyBhbmQgdGhlbiB3cml0ZS4NCg0KWWVzLCB3ZSBhbHNv
IGhhcyBmb3VuZCB0aGlzIGJ1Zy4gDQpJdCdzIHdpbGwgYmUgY29ycmVjdGVkIGluIG5leHQgdmVy
c2lvbi4NCg0KPmkuZS4NCj4JI2RlZmluZSBETUFfQVhJX0NUUkxfTUFQUk9UX01BU0sgMHgzDQo+
CXJlZyAmPSB+KERNQV9BWElfQ1RSTF9NQVJQUk9UKERNQV9BWElfQ1RSTF9NQVBST1RfTUFTSykg
fA0KPgkJIERNQV9BWElfQ1RSTF9NQVJQUk9UKERNQV9BWElfQ1RSTF9NQVBST1RfTUFTSykpDQo+
CXJlZyB8PSBETUFfQVhJX0NUUkxfTUFSUFJPVChETUFfQVhJX0NUUkxfTk9OX1NFQ1VSRSkgfA0K
PgkgICAgICAgRE1BX0FYSV9DVFJMX01BV1BST1QoRE1BX0FYSV9DVFJMX05PTl9TRUNVUkUpOw0K
Pg0KPj4gKwl3cml0ZWwocmVnLCAmcmVncy0+ZG1hX2F4aV9jdHJsKTsNCj4+ICsNCj4+ICsJLyog
ZW5hYmxlIGdlbmVyaWMgaW50ZXJydXB0Ki8NCj4+ICsJd3JpdGVsKFVTQl9JRU5fSU5JVCwgJnJl
Z3MtPnVzYl9pZW4pOw0KPj4gKwl3cml0ZWwoVVNCX0NPTkZfQ0xLMk9GRkRTIHwgVVNCX0NPTkZf
TDFEUywgJnJlZ3MtPnVzYl9jb25mKTsNCj4+ICsNCj4+ICsJY2RuczNfY29uZmlndXJlX2RtdWx0
KHByaXZfZGV2LCBOVUxMKTsNCj4+ICsNCj4+ICsJY2RuczNfZ2FkZ2V0X3B1bGx1cCgmcHJpdl9k
ZXYtPmdhZGdldCwgMSk7DQo+PiArfQ0KPj4gKw0KPg0KPjxzbmlwPg0KPg0KDQpDaGVlcnMsDQpQ
YXdlbGwNCg==
