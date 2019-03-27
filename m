Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2C9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384902082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="tFwrDLLV";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="B7f5WzQW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbfC0O7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:59:14 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:55798 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728066AbfC0O7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:59:13 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2RErrIa032623;
        Wed, 27 Mar 2019 07:58:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=SE1bleuU6WQ/qfIpS5InPi7h1/XHSW5kqFD03CDpEW8=;
 b=tFwrDLLV3OcNy4jijigxaHxnQ+L9DdbvFd0WDKzxIBM9IHgk07cXiaTum/z3YL7CxHMK
 YNSn+ernHyeFchM2cHDNDVBUQyNVsxMBFRV6BX/BGY8mSf2UrXLDp5pngJBf0bexdb48
 0RGaRgaVIqnhYjeJ9Q7L0+8rNQVit5neG3epZmoKzU69+bZ3WR6aSZQVwCJ5rFr/Amrk
 Ea20lR1UydWwSzzAvHbYpahF2wS4DrAWUZ0izWt9xiClX6Y3oWvklr8D2YfAGM0ob8ZR
 sNp6Kl7XrXrPqBOUmiq6WpOvcmHNptUXF6cp4+N5k+xJI/OoNatZk/XmXcgOFRyKpkOJ qw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=dkos@cadence.com
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2055.outbound.protection.outlook.com [104.47.36.55])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2rfkcvegbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Mar 2019 07:58:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SE1bleuU6WQ/qfIpS5InPi7h1/XHSW5kqFD03CDpEW8=;
 b=B7f5WzQWAaO+bOmUnFahD8zCwhhmRt2+7aivSiRcgoOGt/xUzwfF/BD+VAX1eycyugR2GEClc+yJETcIyKIa0QPD3aHQ/bBwhNxRsn/ejpZHV/NtPATWro6BomfPpLAzFtgq7rp1AdkpTxSvSo+zv+kYKbMK1gy55QNZVQpsMyA=
Received: from BYAPR07MB4311.namprd07.prod.outlook.com (52.135.223.145) by
 BYAPR07MB5606.namprd07.prod.outlook.com (20.177.231.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Wed, 27 Mar 2019 14:58:30 +0000
Received: from BYAPR07MB4311.namprd07.prod.outlook.com
 ([fe80::7803:d05e:b945:8af3]) by BYAPR07MB4311.namprd07.prod.outlook.com
 ([fe80::7803:d05e:b945:8af3%6]) with mapi id 15.20.1730.019; Wed, 27 Mar 2019
 14:58:30 +0000
From:   Damian Kos <dkos@cadence.com>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        Anil Joy Varughese <aniljoy@cadence.com>,
        =?utf-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "quentin.schulz@bootlin.com" <quentin.schulz@bootlin.com>,
        Piotr Sroka <piotrs@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>
Subject: RE: [PATCH v7 0/4] drm: add support for Cadence MHDP DPI/DP bridge.
Thread-Topic: [PATCH v7 0/4] drm: add support for Cadence MHDP DPI/DP bridge.
Thread-Index: AQHUuIuO0gCSkL+q8Um5J8Pm/4nzFaXJSjYAgEtEugCAC1olQA==
Date:   Wed, 27 Mar 2019 14:58:30 +0000
Message-ID: <BYAPR07MB43111E34594899FC375D16BDCD580@BYAPR07MB4311.namprd07.prod.outlook.com>
References: <1548846209-16406-1-git-send-email-dkos@cadence.com>
 <0f11a4d8-d576-5af8-b7f4-afe3ff26678f@ti.com>
 <ce6ed2e6-90d5-fc7a-4d6d-ab27d62c5432@ti.com>
In-Reply-To: <ce6ed2e6-90d5-fc7a-4d6d-ab27d62c5432@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZGtvc1xhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLWM2MGYwOTRlLTUwYTAtMTFlOS04NzRlLWNjMmY3MTZkYzIzZFxhbWUtdGVzdFxjNjBmMDk1MC01MGEwLTExZTktODc0ZS1jYzJmNzE2ZGMyM2Rib2R5LnR4dCIgc3o9Ijg1MjAiIHQ9IjEzMTk4MTcyMzA2OTUzOTg1MSIgaD0iWENxZnZwS3ZiNkNrTi9FdThMUmVYdXhvdWVBPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7cb122d0-ea11-4d07-a1a6-08d6b2c4ad19
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5606;
x-ms-traffictypediagnostic: BYAPR07MB5606:
x-microsoft-antispam-prvs: <BYAPR07MB5606B64041C1B786428DCF29CD580@BYAPR07MB5606.namprd07.prod.outlook.com>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(366004)(39860400002)(396003)(36092001)(189003)(199004)(13464003)(6916009)(5660300002)(102836004)(52536014)(11346002)(86362001)(476003)(486006)(7416002)(74316002)(81156014)(8676002)(7696005)(186003)(229853002)(26005)(305945005)(446003)(66066001)(256004)(105586002)(106356001)(68736007)(6506007)(76176011)(81166006)(53546011)(6436002)(71200400001)(97736004)(71190400001)(8936002)(7736002)(4326008)(25786009)(33656002)(478600001)(14454004)(54906003)(9686003)(53936002)(3846002)(2906002)(6116002)(99286004)(66574012)(6246003)(316002)(55016002)(107886003)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5606;H:BYAPR07MB4311.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fzl6ufLwMw9LKumBLmsok9EoZwdUlE1GJbbE4Sfu1lXQgk+lS1of6D0p/VD5qIodjehkJCXOaYsvOYH1yp4Svd/QGMzbytzyDCW/T44OUJJ0DovmxfNmc8qld1TPABiOroo2LiQTvr9eu5i5RepLoH0aOfxw7/xyWCGoWef4DSaeqJhhkGb96PiUZcLcppTfGcbhoNVSmR74rZKWpninbGhwh/2YWNGrcX7NLME9aXYKR0UiL9e5/vu4I8x9ecCNVllHSN0vtEJASCqeO7OmTZ9e0jdBJH+bCj85KmCc3mNv6tZPHS4KiT9dbeOrVu3dIYYPM9cz2A32l00SvgxqPnH+XA2W9sXbl0dO0HuTF7DTxR8gB3TJ1/xtuutxUXb2nl79I6HRNVM/b/l/7a+kh2kEt9isOJVFI6oiLNKDV0Y=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb122d0-ea11-4d07-a1a6-08d6b2c4ad19
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 14:58:30.5244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5606
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-27_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903270105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PkRhbWlhbiwgcGluZy4NCj4NCj5PbiAzMS8wMS8yMDE5IDE0OjA4LCBUb21pIFZhbGtlaW5lbiB3
cm90ZToNCj4+IEhpLA0KPj4gDQo+PiBPbiAzMC8wMS8yMDE5IDEzOjAzLCBEYW1pYW4gS29zIHdy
b3RlOg0KPj4+IEhlbGxvIQ0KPj4+DQo+Pj4gVGhpcyBpcyB0aGUgc2VyaWVzIG9mIHBhdGNoZXMg
dGhhdCB3aWxsIGFkZCBzdXBwb3J0IGZvciB0aGUgQ2FkZW5jZSdzIERQSS9EUA0KPj4+IGJyaWRn
ZS4gUGxlYXNlIG5vdGUgdGhhdCB0aGlzIGlzIGEgcHJlbGltaW5hcnkgdmVyc2lvbiBvZiB0aGUg
ZHJpdmVyIGFuZCB0aGVyZQ0KPj4+IHdpbGwgYmUgbW9yZSBwYXRjaGVzIGluIHRoZSBmdXR1cmUg
d2l0aCB1cGRhdGVzLCBmaXhlcyBhbmQgaW1wcm92ZW1lbnRzLg0KPj4+IFBsZWFzZSBrZWVwIHRo
YXQgaW4gbWluZCB3aGVuIGxvb2tpbmcgYXQgRklYTUUvVE9ETy9YWFggY29tbWVudHMuDQo+Pj4N
Cj4+PiBJbml0aWFsbHksIE1IRFAgZHJpdmVyIHdhcyBkZXZlbG9wZWQgYXMgYSBEUk0gYnJpZGdl
IGRyaXZlciBhbmQgd2FzIHBsYW5lZCB0bw0KPj4+IGJlIHBsYWNlZCBpbiBkcml2ZXJzL2dwdS9k
cm0vYnJpZGdlL21oZHAuYy4gIEhvd2V2ZXIsIHRoZXJlIHdhcyBhbHJlYWR5DQo+Pj4gYSBkcml2
ZXIgZm9yIENhZGVuY2UncyBEUCBjb250cm9sbGVyIGRldmVsb3BlZCBieSBSb2NrQ2hpcCwgYnV0
IHRoYXQgZHJpdmVyDQo+Pj4gdXNlcyB0aGUgZGlmZmVyZW50IERSTSBmcmFtZXdvcmsgYW5kIGxv
b2tzIGxpa2UgYSBwYXJ0IG9mIGEgYmlnZ2VyIHN5c3RlbS4NCj4+PiBCb3RoIGNvbnRyb2xsZXJz
IChpbmNsdWRpbmcgZmlybXdhcmUpIGFyZSBxdWl0ZSBkaWZmZXJlbnQgaW50ZXJuYWxseQ0KPj4+
IChNU1QvRkVDL0RTQyBzdXBwb3J0LCBsaW5rIHRyYWluaW5nIGRvbmUgYnkgZHJpdmVyLCBhZGRp
dGlvbmFsIGNvbW1hbmRzLCBJUlEncw0KPj4+IGV0Yy4pIGJ1dCB0aGV5IGhhdmUgc2ltaWxhciBy
ZWdpc3RlciBtYXAsIGV4Y2VwdCBmb3IgRnJhbWVyL1N0cmVhbWVyICh3aGljaCBpcw0KPj4+IG5v
dGljZWFibHkgZGlmZmVyZW50KSwgc28gdGhleSBhcHBlYXIgc2ltaWxhci4NCj4+Pg0KPj4+IFRo
ZSBmb2xsb3dpbmcgcGF0Y2hlcyBjb250YWluOg0KPj4+IC0gTW92aW5nIGNvbW1vbiBjb2RlIHRv
IGRyaXZlcnMvZ3B1L2RybS9icmlkZ2UvY2Rucy1taGRwLWNvbW1vbi4qIGFuZA0KPj4+ICAgbW9k
aWZ5aW5nIGl0IGEgYml0IChtb3N0bHkgbmV3IHByZWZpeGVzIGZvciBmdW5jdGlvbnMgYW5kIGRh
dGEgdHlwZXMpIHNvIGl0DQo+Pj4gICBjYW4gYmUgdXNlZCBieSB0d28sIGhpZ2hlciBsZXZlbCwg
ZHJpdmVycy4NCj4+PiAtIE1vZGlmeWluZyBleGlzdGluZyBSb2NrQ2hpcCdzIERQIGRyaXZlciB0
byB1c2UgdGhlIGNvbW1vbiBjb2RlIGFmdGVyIGNoYW5nZXMNCj4+PiAgIG1hZGUgdG8gaXQgKHVz
ZSB0aGUgbmV3IGNkbnNfbWhkcF9kZXZpY2Ugc3RydWN0dXJlIGFuZCBuZXcgZnVuY3Rpb24gbmFt
ZXMpLg0KPj4+IC0gTW9kaWZ5aW5nIERSTSBoZWxwZXJzIGEgYml0LiBTb21lIGFyZSByZXF1aXJl
ZCBmb3IgbmV3IGRyaXZlciwgc29tZSBhcmUNCj4+PiAgIHVwZGF0ZXMgZnJvbSBEUCAxLjIgdG8g
MS4zIG9yIDEuNC4NCj4+PiAtIEFkZGluZyBkb2N1bWVudGF0aW9uIGZvciBkZXZpY2UgdHJlZSBi
aW5kaW5ncy4NCj4+PiAtIEFkZGluZyBwcmVsaW1pbmFyeSBDYWRlbmNlIERQSS9EUCBicmlkZ2Ug
ZHJpdmVyLg0KPj4+DQo+Pj4gU29tZSBvZiB0aGUgdGhpbmdzIHRoYXQgd2lsbCBiZSBhZGRlZCBs
YXRlciBvbiBpbmNsdWRlIChidXQgYXJlIG5vdCBsaW1pdGVkDQo+Pj4gdG8pOg0KPj4+IC0gRFND
IHN1cHBvcnQNCj4+PiAtIEZFQyBzdXBwb3J0DQo+Pj4gLSBIRENQIHN1cHBvcnQNCj4+IA0KPj4g
QSBmZXcgcmFuZG9tIGNvbW1lbnRzL3F1ZXN0aW9ucyBhZnRlciBhIHF1aWNrIGxvb2sgYXQgdGhl
IHBhdGNoZXMuDQo+PiANCj4+IFRoZSBuYW1lcyBvZiB0aGUgc291cmNlIGZpbGVzIGFuZCB0aGUg
a2VybmVsIEtjb25maWcgYXJlIG9ubHkgYWJvdXQNCj4+ICJDYWRlbmNlIERQIi4gQnV0IHRoZSBE
VCBiaW5kaW5ncyBpcyBmb3IgY2RucyxtaGRwODU0NiwgYW5kIHRoZQ0KPj4gcmVzdWx0aW5nIG1v
ZHVsZSBmaWxlIGlzIG1oZHA4NTQ2LmtvLiBJIHRoaW5rIG1vcmUgY29uc2lzdGVuY3kgaGVyZQ0K
Pj4gd291bGQgYmUgZ29vZC4NCj4+IA0KPj4gSSBwcmVzdW1lIHRoZSBwYXJ0IG51bWJlciAob3Ig
ZmFtaWx5PyBhcmUgdGhlcmUgb3RoZXIgc2ltaWxhciBwYXJ0cyB3aXRoDQo+PiBzaW1pbGFyIHBh
cnQgbnVtYmVycz8pIGlzIHJlbGV2YW50LCBzbyBpdCBzaG91bGQgYmUgaW4gdGhlIEtjb25maWcN
Cj4+IG9wdGlvbiBhbmQgaGVscCB0ZXh0LCBhbmQgcHJvYmFibHkgaW4gdGhlIGZpbGUgbmFtZXMg
dG9vLiBUaGUgbW9kdWxlDQo+PiBuYW1lIHNob3VsZCBoYXZlICJjZG5zIiBwcmVmaXggdGhlcmUs
IHNpbWlsYXIgdG8gdGhlIHNvdXJjZSBmaWxlcyBhbmQNCj4+IHRoZSBjZG5zLWRzaS5rby4NCj4+
IA0KPj4gT3IgbWF5YmUgdGhlIHNhbWUgZHJpdmVyIHdpbGwgaGFuZGxlIGFsbCBDYWRlbmNlIERQ
IHBhcnRzLCBpbiB3aGljaCBjYXNlDQo+PiBnZW5lcmljIGZpbGVuYW1lcyBhcmUgZmluZSwgYnV0
IHRoZW4gdGhlIHJlc3VsdGluZyBrZXJuZWwgbW9kdWxlIHNob3VsZA0KPj4gYWxzbyBiZSBqdXN0
ICJjZG5zLW1oZHAua28iLg0KV2Ugd291bGQgYmUgdmVyeSBoYXBweSB0byBoYXZlIGEgc2VwYXJh
dGUgZHJpdmVyIGZvciBtaGRwODU0NiBpbnN0ZWFkIG9mDQptaXhpbmcgaXQgd2l0aCBSb2NrY2hp
cCdzIGRyaXZlci4gVW5mb3J0dW5hdGVseSB3ZSBuZWVkIHRvIGhhdmUgb25lIGRyaXZlcg0KZm9y
IGJvdGggSVAncywgc28gSSdsbCBqdXN0IGNoYW5nZSBtaGRwODU0Ni5rbyB0byBjZG5zLW1oZHAu
a28uIChVbmxlc3MsDQptYWludGFpbmVycyBnaXZlIHVzIGEgZ3JlZW4gbGlnaHQgZm9yIHRoZSBk
ZWRpY2F0ZWQgZHJpdmVyPykNCj4+IA0KPj4gSSBzZWUgc29tZSBhdWRpbyBmdW5jdGlvbnMgaW4g
dGhlIGNvZGUsIGJ1dCBpdCdzIG5vdCBtZW50aW9uZWQgaW4gdGhlIERUDQo+PiBiaW5kaW5ncy4g
SSdtIG5vdCBhbiBhdWRpbyBndXksIGJ1dCB0aGUgZGlzcGxheSBicmlkZ2VzIHdpdGggYXVkaW8N
Cj4+IHN1cHBvcnQgSSBoYXZlIHNlZW4gaGF2ZSBoYWQgRFQgYmluZGluZ3MgZm9yIHRoZSBhdWRp
byBzb3VyY2UgdG9vLiBJcw0KPj4gYXVkaW8gc3VwcG9ydGVkIGluIHRoZSBjdXJyZW50IGRyaXZl
cj8NCj4+IA0KQXMgZmFyIGFzIEkga25vdywgYXVkaW8gaXMgd29ya2luZywgYnV0IEkgY2FuJ3Qg
ZG91YmxlIGNoZWNrIGl0IHJpZ2h0IG5vdw0KZHVlIHRvIGhlYXZ5IGxvYWQgb24gbXkgYmFjayBy
aWdodCBub3cuIEknbGwgdHJ5IHRvIGZpbmQgdGltZSBmb3IgdGhhdCBpbiB0aGUNCm5leHQgd2Vl
ay4gQnV0LCBsaWtlIEkndmUgbWVudGlvbmVkIGVhcmxpZXIgSSBkb24ndCBzZWUgYSByZWFzb24g
d2h5IGF1ZGlvDQpjb2RlICh0aGF0IGV4aXN0cyBpbiB0aGUgbWFpbmxpbmUpIHdvdWxkbid0IHdv
cmsuDQpJJ20gbm90IGFuIGF1ZGlvIGd1eSBteXNlbGYuIFdoZW4gdXBkYXRpbmcgZHQgYmluZGlu
Z3MgSSB0b29rIHRoZSBkdCBiaW5kaW5ncw0KZm9yIG90aGVyIGJyaWRnZXMgYXMgYW4gZXhhbXBs
ZSwgYnV0IEkgZGlkIG5vdCBzZWUgYW55IGJpbmRpbmdzIGZvciBhdWRpbyBpbg0KdGhlbS4gSSBk
aWRuJ3QgY2hlY2sgYWxsIG9mIHRoZW0uIENhbiB5b3UgcGxlYXNlIGxldCBtZSBrbm93IHdoaWNo
IGJyaWRnZXMNCmFyZSB5b3Ugd2VyZSByZWZlcnJpbmcgdG8/IEluIG91ciB0ZXN0IGVudmlyb25t
ZW50IHdlIGRpZG4ndCB1c2UgYW55IGF1ZGlvDQpkcml2ZXIgYXMgYXVkaW8gZ2VuZXJhdG9yIGlz
IHNvIHNpbXBsZSB0aGF0IGl0IGlzIHBhcnQgb2YgdGhlIHJlZ2lzdGVyIHNwYWNlDQpvZiBJUCBh
bmQgd2UgZGlkbid0IGV2ZW4gbmVlZCB0byBpbmNsdWRlIHRoaXMgZGV2aWNlIGluIC5kdHMgZmls
ZS4gQXVkaW8gKGxpa2UNCnRoZSB2aWRlbykgaXMgY29uZmlndXJlZCBhbmQgZW5hYmxlZCBieSBj
b2RlIHRoYXQgaXMgbm90IGluY2x1ZGVkIGluIHRoZSBwYXRjaA0KKGZvciBvYnZpb3VzIHJlYXNv
bnMpLg0KU28sIGluIHNob3J0LCB5ZXMsIGRyaXZlciBzdXBwb3J0cyBhdWRpbyBhbmQgd2Ugd2ls
bCBpbmNsdWRlIGRlc2NyaXB0aW9uIGZvcg0KYXVkaW8gaW5wdXQgcG9ydCBpbiB0aGUgZHQgYmlu
ZGluZ3MuDQo+PiAgVG9taQ0KPj4gDQo+DQo+IC0tIA0KPiBUZXhhcyBJbnN0cnVtZW50cyBGaW5s
YW5kIE95LCBQb3Jra2FsYW5rYXR1IDIyLCAwMDE4MCBIZWxzaW5raS4NCj4gWS10dW5udXMvQnVz
aW5lc3MgSUQ6IDA2MTU1MjEtNC4gS290aXBhaWtrYS9Eb21pY2lsZTogSGVsc2lua2kNCg0KUmVn
YXJkcywNCkRhbWlhbg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogVG9taSBW
YWxrZWluZW4gPHRvbWkudmFsa2VpbmVuQHRpLmNvbT4gDQpTZW50OiBXZWRuZXNkYXksIE1hcmNo
IDIwLCAyMDE5IDEwOjM0DQpUbzogRGFtaWFuIEtvcyA8ZGtvc0BjYWRlbmNlLmNvbT4NCkNjOiBE
YXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+OyBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3
bGwuY2g+OyBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgTWFyayBSdXRsYW5kIDxt
YXJrLnJ1dGxhbmRAYXJtLmNvbT47IEFuZHJ6ZWogSGFqZGEgPGEuaGFqZGFAc2Ftc3VuZy5jb20+
OyBMYXVyZW50IFBpbmNoYXJ0IDxMYXVyZW50LnBpbmNoYXJ0QGlkZWFzb25ib2FyZC5jb20+OyBN
YWFydGVuIExhbmtob3JzdCA8bWFhcnRlbi5sYW5raG9yc3RAbGludXguaW50ZWwuY29tPjsgTWF4
aW1lIFJpcGFyZCA8bWF4aW1lLnJpcGFyZEBib290bGluLmNvbT47IFNlYW4gUGF1bCA8c2VhbkBw
b29ybHkucnVuPjsgU2FuZHkgSHVhbmcgPGhqY0Byb2NrLWNoaXBzLmNvbT47IEhlaWtvIFN0w7xi
bmVyIDxoZWlrb0BzbnRlY2guZGU+OyBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBk
ZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1yb2NrY2hpcEBsaXN0
cy5pbmZyYWRlYWQub3JnOyBqYmVyZ3NhZ2VsQHRpLmNvbTsgcXVlbnRpbi5zY2h1bHpAYm9vdGxp
bi5jb207IFBpb3RyIFNyb2thIDxwaW90cnNAY2FkZW5jZS5jb20+OyBSYWZhbCBDaWVwaWVsYSA8
cmFmYWxjQGNhZGVuY2UuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCB2NyAwLzRdIGRybTogYWRk
IHN1cHBvcnQgZm9yIENhZGVuY2UgTUhEUCBEUEkvRFAgYnJpZGdlLg0KDQpFWFRFUk5BTCBNQUlM
DQoNCg0KRGFtaWFuLCBwaW5nLg0KDQpPbiAzMS8wMS8yMDE5IDE0OjA4LCBUb21pIFZhbGtlaW5l
biB3cm90ZToNCj4gSGksDQo+IA0KPiBPbiAzMC8wMS8yMDE5IDEzOjAzLCBEYW1pYW4gS29zIHdy
b3RlOg0KPj4gSGVsbG8hDQo+Pg0KPj4gVGhpcyBpcyB0aGUgc2VyaWVzIG9mIHBhdGNoZXMgdGhh
dCB3aWxsIGFkZCBzdXBwb3J0IGZvciB0aGUgQ2FkZW5jZSdzIERQSS9EUA0KPj4gYnJpZGdlLiBQ
bGVhc2Ugbm90ZSB0aGF0IHRoaXMgaXMgYSBwcmVsaW1pbmFyeSB2ZXJzaW9uIG9mIHRoZSBkcml2
ZXIgYW5kIHRoZXJlDQo+PiB3aWxsIGJlIG1vcmUgcGF0Y2hlcyBpbiB0aGUgZnV0dXJlIHdpdGgg
dXBkYXRlcywgZml4ZXMgYW5kIGltcHJvdmVtZW50cy4NCj4+IFBsZWFzZSBrZWVwIHRoYXQgaW4g
bWluZCB3aGVuIGxvb2tpbmcgYXQgRklYTUUvVE9ETy9YWFggY29tbWVudHMuDQo+Pg0KPj4gSW5p
dGlhbGx5LCBNSERQIGRyaXZlciB3YXMgZGV2ZWxvcGVkIGFzIGEgRFJNIGJyaWRnZSBkcml2ZXIg
YW5kIHdhcyBwbGFuZWQgdG8NCj4+IGJlIHBsYWNlZCBpbiBkcml2ZXJzL2dwdS9kcm0vYnJpZGdl
L21oZHAuYy4gIEhvd2V2ZXIsIHRoZXJlIHdhcyBhbHJlYWR5DQo+PiBhIGRyaXZlciBmb3IgQ2Fk
ZW5jZSdzIERQIGNvbnRyb2xsZXIgZGV2ZWxvcGVkIGJ5IFJvY2tDaGlwLCBidXQgdGhhdCBkcml2
ZXINCj4+IHVzZXMgdGhlIGRpZmZlcmVudCBEUk0gZnJhbWV3b3JrIGFuZCBsb29rcyBsaWtlIGEg
cGFydCBvZiBhIGJpZ2dlciBzeXN0ZW0uDQo+PiBCb3RoIGNvbnRyb2xsZXJzIChpbmNsdWRpbmcg
ZmlybXdhcmUpIGFyZSBxdWl0ZSBkaWZmZXJlbnQgaW50ZXJuYWxseQ0KPj4gKE1TVC9GRUMvRFND
IHN1cHBvcnQsIGxpbmsgdHJhaW5pbmcgZG9uZSBieSBkcml2ZXIsIGFkZGl0aW9uYWwgY29tbWFu
ZHMsIElSUSdzDQo+PiBldGMuKSBidXQgdGhleSBoYXZlIHNpbWlsYXIgcmVnaXN0ZXIgbWFwLCBl
eGNlcHQgZm9yIEZyYW1lci9TdHJlYW1lciAod2hpY2ggaXMNCj4+IG5vdGljZWFibHkgZGlmZmVy
ZW50KSwgc28gdGhleSBhcHBlYXIgc2ltaWxhci4NCj4+DQo+PiBUaGUgZm9sbG93aW5nIHBhdGNo
ZXMgY29udGFpbjoNCj4+IC0gTW92aW5nIGNvbW1vbiBjb2RlIHRvIGRyaXZlcnMvZ3B1L2RybS9i
cmlkZ2UvY2Rucy1taGRwLWNvbW1vbi4qIGFuZA0KPj4gICBtb2RpZnlpbmcgaXQgYSBiaXQgKG1v
c3RseSBuZXcgcHJlZml4ZXMgZm9yIGZ1bmN0aW9ucyBhbmQgZGF0YSB0eXBlcykgc28gaXQNCj4+
ICAgY2FuIGJlIHVzZWQgYnkgdHdvLCBoaWdoZXIgbGV2ZWwsIGRyaXZlcnMuDQo+PiAtIE1vZGlm
eWluZyBleGlzdGluZyBSb2NrQ2hpcCdzIERQIGRyaXZlciB0byB1c2UgdGhlIGNvbW1vbiBjb2Rl
IGFmdGVyIGNoYW5nZXMNCj4+ICAgbWFkZSB0byBpdCAodXNlIHRoZSBuZXcgY2Ruc19taGRwX2Rl
dmljZSBzdHJ1Y3R1cmUgYW5kIG5ldyBmdW5jdGlvbiBuYW1lcykuDQo+PiAtIE1vZGlmeWluZyBE
Uk0gaGVscGVycyBhIGJpdC4gU29tZSBhcmUgcmVxdWlyZWQgZm9yIG5ldyBkcml2ZXIsIHNvbWUg
YXJlDQo+PiAgIHVwZGF0ZXMgZnJvbSBEUCAxLjIgdG8gMS4zIG9yIDEuNC4NCj4+IC0gQWRkaW5n
IGRvY3VtZW50YXRpb24gZm9yIGRldmljZSB0cmVlIGJpbmRpbmdzLg0KPj4gLSBBZGRpbmcgcHJl
bGltaW5hcnkgQ2FkZW5jZSBEUEkvRFAgYnJpZGdlIGRyaXZlci4NCj4+DQo+PiBTb21lIG9mIHRo
ZSB0aGluZ3MgdGhhdCB3aWxsIGJlIGFkZGVkIGxhdGVyIG9uIGluY2x1ZGUgKGJ1dCBhcmUgbm90
IGxpbWl0ZWQNCj4+IHRvKToNCj4+IC0gRFNDIHN1cHBvcnQNCj4+IC0gRkVDIHN1cHBvcnQNCj4+
IC0gSERDUCBzdXBwb3J0DQo+IA0KPiBBIGZldyByYW5kb20gY29tbWVudHMvcXVlc3Rpb25zIGFm
dGVyIGEgcXVpY2sgbG9vayBhdCB0aGUgcGF0Y2hlcy4NCj4gDQo+IFRoZSBuYW1lcyBvZiB0aGUg
c291cmNlIGZpbGVzIGFuZCB0aGUga2VybmVsIEtjb25maWcgYXJlIG9ubHkgYWJvdXQNCj4gIkNh
ZGVuY2UgRFAiLiBCdXQgdGhlIERUIGJpbmRpbmdzIGlzIGZvciBjZG5zLG1oZHA4NTQ2LCBhbmQg
dGhlDQo+IHJlc3VsdGluZyBtb2R1bGUgZmlsZSBpcyBtaGRwODU0Ni5rby4gSSB0aGluayBtb3Jl
IGNvbnNpc3RlbmN5IGhlcmUNCj4gd291bGQgYmUgZ29vZC4NCj4gDQo+IEkgcHJlc3VtZSB0aGUg
cGFydCBudW1iZXIgKG9yIGZhbWlseT8gYXJlIHRoZXJlIG90aGVyIHNpbWlsYXIgcGFydHMgd2l0
aA0KPiBzaW1pbGFyIHBhcnQgbnVtYmVycz8pIGlzIHJlbGV2YW50LCBzbyBpdCBzaG91bGQgYmUg
aW4gdGhlIEtjb25maWcNCj4gb3B0aW9uIGFuZCBoZWxwIHRleHQsIGFuZCBwcm9iYWJseSBpbiB0
aGUgZmlsZSBuYW1lcyB0b28uIFRoZSBtb2R1bGUNCj4gbmFtZSBzaG91bGQgaGF2ZSAiY2RucyIg
cHJlZml4IHRoZXJlLCBzaW1pbGFyIHRvIHRoZSBzb3VyY2UgZmlsZXMgYW5kDQo+IHRoZSBjZG5z
LWRzaS5rby4NCj4gDQo+IE9yIG1heWJlIHRoZSBzYW1lIGRyaXZlciB3aWxsIGhhbmRsZSBhbGwg
Q2FkZW5jZSBEUCBwYXJ0cywgaW4gd2hpY2ggY2FzZQ0KPiBnZW5lcmljIGZpbGVuYW1lcyBhcmUg
ZmluZSwgYnV0IHRoZW4gdGhlIHJlc3VsdGluZyBrZXJuZWwgbW9kdWxlIHNob3VsZA0KPiBhbHNv
IGJlIGp1c3QgImNkbnMtbWhkcC5rbyIuDQo+IA0KPiBJIHNlZSBzb21lIGF1ZGlvIGZ1bmN0aW9u
cyBpbiB0aGUgY29kZSwgYnV0IGl0J3Mgbm90IG1lbnRpb25lZCBpbiB0aGUgRFQNCj4gYmluZGlu
Z3MuIEknbSBub3QgYW4gYXVkaW8gZ3V5LCBidXQgdGhlIGRpc3BsYXkgYnJpZGdlcyB3aXRoIGF1
ZGlvDQo+IHN1cHBvcnQgSSBoYXZlIHNlZW4gaGF2ZSBoYWQgRFQgYmluZGluZ3MgZm9yIHRoZSBh
dWRpbyBzb3VyY2UgdG9vLiBJcw0KPiBhdWRpbyBzdXBwb3J0ZWQgaW4gdGhlIGN1cnJlbnQgZHJp
dmVyPw0KPiANCj4gIFRvbWkNCj4gDQoNCi0tIA0KVGV4YXMgSW5zdHJ1bWVudHMgRmlubGFuZCBP
eSwgUG9ya2thbGFua2F0dSAyMiwgMDAxODAgSGVsc2lua2kuDQpZLXR1bm51cy9CdXNpbmVzcyBJ
RDogMDYxNTUyMS00LiBLb3RpcGFpa2thL0RvbWljaWxlOiBIZWxzaW5raQ0K
