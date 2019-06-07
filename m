Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CBDC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D438B208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="gDXFzXa+";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="hH6+hrIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfFGIB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 04:01:27 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:42424 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726607AbfFGIB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 04:01:26 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x577xQs8027106;
        Fri, 7 Jun 2019 00:59:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=M9TzrYR+QdOFMwfi1VEYiXJ54f3G5B8vmOooIJd97AE=;
 b=gDXFzXa+FTll1MT567+OnuuhQ7dhCMq1rdKZYDTiJhfgt9dIIOAedX2LlzwGmCwF0WNV
 jc6atdQDRYtkRjmErgX3fPWPpzZWcJrYxo943p7ZKAumitH1mTCJYTnrNXGZLzTYRD1n
 0ec8m1M1s7qAa2rfDUZ4J1pR7nxniwtxhTql4ei5ZHpJ54384YzbMKDLc0LokI7XhVMT
 +7azE7y2GqnNuI2/FOsjpUTnpFsxzYty3MtRfUQp1hNtPNUSMuOJhQQr26I2/GDvRzT9
 Xm/3OA4L1VGwe22cetZOBd0ZxxwSA6pQe7ucSfm3fHmMAE3j+/AhZmUTHPSzJcW9pGsw yA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2057.outbound.protection.outlook.com [104.47.49.57])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2sy5dd3qm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 07 Jun 2019 00:59:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9TzrYR+QdOFMwfi1VEYiXJ54f3G5B8vmOooIJd97AE=;
 b=hH6+hrIk9TM+ofYWuEk+Y7bdHrAlwqxLYiaW3cr4tcUaYUH4lW9f+VXzzR5s/mraX4VstiKrewgh5vEQhYHlYxwuGAtj2EjlSFMd764s2ccHkZOPtbFNQDgrlUZEuvIzjRWF3oGytObbEM4ddPx5Qwhq5SN8E+oRxzf9se3cwmA=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5526.namprd07.prod.outlook.com (20.177.231.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Fri, 7 Jun 2019 07:59:39 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::594a:4a73:3ead:457d]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::594a:4a73:3ead:457d%3]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 07:59:39 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Roger Quadros <rogerq@ti.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v7 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Topic: [PATCH v7 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Index: AQHVG4Y4SF7nQPUaCk+2a30suK0doKaOjGAAgAEq5fA=
Date:   Fri, 7 Jun 2019 07:59:38 +0000
Message-ID: <BYAPR07MB4709E1C8B190E5BBC055DC34DD100@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1559729030-16390-1-git-send-email-pawell@cadence.com>
 <1559729030-16390-6-git-send-email-pawell@cadence.com>
 <a6eb0f66-14a7-d235-94a4-a53d291ac2c3@ti.com>
In-Reply-To: <a6eb0f66-14a7-d235-94a4-a53d291ac2c3@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-tag-bcast: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMmZmZTBmOTItODhmYS0xMWU5LTg3NDEtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDJmZmUwZjkzLTg4ZmEtMTFlOS04NzQxLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMzgyMSIgdD0iMTMyMDQzNjc5NzUwNDc4OTQ1IiBoPSI4TWZrcFhGQW1OOHBySHpZZkI4MmM2dGNsMlk9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-paste: 
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f40e35dc-dc17-4e2d-cb72-08d6eb1e1747
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB5526;
x-ms-traffictypediagnostic: BYAPR07MB5526:
x-microsoft-antispam-prvs: <BYAPR07MB552690883C49A873AA51A8F9DD100@BYAPR07MB5526.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(366004)(376002)(396003)(36092001)(51444003)(189003)(199004)(64756008)(66946007)(52536014)(73956011)(76116006)(66446008)(8676002)(486006)(6246003)(11346002)(81166006)(446003)(81156014)(14454004)(66066001)(8936002)(68736007)(9686003)(476003)(2501003)(66476007)(7416002)(86362001)(55016002)(7696005)(6506007)(186003)(256004)(14444005)(66556008)(74316002)(76176011)(25786009)(53936002)(4326008)(99286004)(305945005)(33656002)(7736002)(229853002)(3846002)(26005)(5660300002)(110136005)(2906002)(54906003)(107886003)(316002)(6436002)(102836004)(71190400001)(6116002)(478600001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5526;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Lq5Z1lJgtowc2RUsivSj2IzUvA7qwcO0Mmr1JznVlaIxkIuFnHGR05nGK5X5fSqrYmBezZdyCbNFuzVlmUQSFgrqTKq/CiESEhjfeh//Sln1phT4P/b7z03nCWsTN/J7avxQG+Il4zYTWjjg8k691oqAv2qNetNns37Jp73Z1Q+DGzL1FjAhTQJs6LOxRWSVBpV3O5zbNyyNtCZMGinAXCzJh0WYwNp+kqaSKrBhswXymjiGnkX9cuPgAR3mtS4lyJZUeXqvYve4XyrCfpCywS42dSm7fKUbxKUvV8mzBgjQOoX9RVYhJp/jp3r4Yot+LQmsodSLk50CwkOp/msSwOFiqPvTfXQ5QOKRvyQAdRz4B1+Ev7+cpNjRwdqxqU9XKLhRBQmOnu3KozTNpE5vzFFZfCuXTngGUWmFSg/i/zY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f40e35dc-dc17-4e2d-cb72-08d6eb1e1747
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 07:59:39.0731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5526
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-07_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906070057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pg0KPk9uIDA1LzA2LzIwMTkgMTM6MDMsIFBhd2VsIExhc3pjemFrIHdyb3RlOg0KPj4gVGhpcyBw
YXRjaCBpbnRyb2R1Y2UgbmV3IENhZGVuY2UgVVNCU1MgRFJEIGRyaXZlciB0byBMaW51eCBrZXJu
ZWwuDQo+Pg0KPj4gVGhlIENhZGVuY2UgVVNCU1MgRFJEIERyaXZlciBpcyBhIGhpZ2hseSBjb25m
aWd1cmFibGUgSVAgQ29yZSB3aGljaA0KPj4gY2FuIGJlIGluc3RhbnRpYXRlZCBhcyBEdWFsLVJv
bGUgRGV2aWNlIChEUkQpLCBQZXJpcGhlcmFsIE9ubHkgYW5kDQo+PiBIb3N0IE9ubHkgKFhIQ0kp
Y29uZmlndXJhdGlvbnMuDQo+Pg0KPj4gVGhlIGN1cnJlbnQgZHJpdmVyIGhhcyBiZWVuIHZhbGlk
YXRlZCB3aXRoIEZQR0EgcGxhdGZvcm0uIFdlIGhhdmUNCj4+IHN1cHBvcnQgZm9yIFBDSWUgYnVz
LCB3aGljaCBpcyB1c2VkIG9uIEZQR0EgcHJvdG90eXBpbmcuDQo+Pg0KPj4gVGhlIGhvc3Qgc2lk
ZSBvZiBVU0JTUy1EUkQgY29udHJvbGxlciBpcyBjb21wbGlhbnQgd2l0aCBYSENJDQo+PiBzcGVj
aWZpY2F0aW9uLCBzbyBpdCB3b3JrcyB3aXRoIHN0YW5kYXJkIFhIQ0kgTGludXggZHJpdmVyLg0K
Pj4NCj4+IFNpZ25lZC1vZmYtYnk6IFBhd2VsIExhc3pjemFrIDxwYXdlbGxAY2FkZW5jZS5jb20+
DQo+PiAtLS0NCj4+ICBkcml2ZXJzL3VzYi9LY29uZmlnICAgICAgICAgICAgICAgIHwgICAgMiAr
DQo+PiAgZHJpdmVycy91c2IvTWFrZWZpbGUgICAgICAgICAgICAgICB8ICAgIDIgKw0KPj4gIGRy
aXZlcnMvdXNiL2NkbnMzL0tjb25maWcgICAgICAgICAgfCAgIDQ0ICsNCj4+ICBkcml2ZXJzL3Vz
Yi9jZG5zMy9NYWtlZmlsZSAgICAgICAgIHwgICAxNCArDQo+PiAgZHJpdmVycy91c2IvY2RuczMv
Y2RuczMtcGNpLXdyYXAuYyB8ICAxNTcgKysNCj4+ICBkcml2ZXJzL3VzYi9jZG5zMy9jb3JlLmMg
ICAgICAgICAgIHwgIDUyOSArKysrKysrDQo+PiAgZHJpdmVycy91c2IvY2RuczMvY29yZS5oICAg
ICAgICAgICB8ICAxMjEgKysNCj4+ICBkcml2ZXJzL3VzYi9jZG5zMy9kZWJ1Zy5oICAgICAgICAg
IHwgIDE3MyArKysNCj4+ICBkcml2ZXJzL3VzYi9jZG5zMy9kZWJ1Z2ZzLmMgICAgICAgIHwgIDE3
MyArKysNCj4+ICBkcml2ZXJzL3VzYi9jZG5zMy9kcmQuYyAgICAgICAgICAgIHwgIDM3OSArKysr
Kw0KPj4gIGRyaXZlcnMvdXNiL2NkbnMzL2RyZC5oICAgICAgICAgICAgfCAgMTY2ICsrDQo+PiAg
ZHJpdmVycy91c2IvY2RuczMvZXAwLmMgICAgICAgICAgICB8ICA5MTUgKysrKysrKysrKysNCj4+
ICBkcml2ZXJzL3VzYi9jZG5zMy9nYWRnZXQtZXhwb3J0LmggIHwgICAyOCArDQo+PiAgZHJpdmVy
cy91c2IvY2RuczMvZ2FkZ2V0LmMgICAgICAgICB8IDIyOTAgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKw0KPj4gIGRyaXZlcnMvdXNiL2NkbnMzL2dhZGdldC5oICAgICAgICAgfCAxMzEzICsr
KysrKysrKysrKysrKysNCj4+ICBkcml2ZXJzL3VzYi9jZG5zMy9ob3N0LWV4cG9ydC5oICAgIHwg
ICAyOCArDQo+PiAgZHJpdmVycy91c2IvY2RuczMvaG9zdC5jICAgICAgICAgICB8ICAgNzYgKw0K
Pj4gIGRyaXZlcnMvdXNiL2NkbnMzL3RyYWNlLmMgICAgICAgICAgfCAgIDIzICsNCj4+ICBkcml2
ZXJzL3VzYi9jZG5zMy90cmFjZS5oICAgICAgICAgIHwgIDQ0NyArKysrKysNCj4+ICAxOSBmaWxl
cyBjaGFuZ2VkLCA2ODgwIGluc2VydGlvbnMoKykNCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy91c2IvY2RuczMvS2NvbmZpZw0KPj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3Vz
Yi9jZG5zMy9NYWtlZmlsZQ0KPj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3VzYi9jZG5z
My9jZG5zMy1wY2ktd3JhcC5jDQo+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdXNiL2Nk
bnMzL2NvcmUuYw0KPj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3VzYi9jZG5zMy9jb3Jl
LmgNCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy91c2IvY2RuczMvZGVidWcuaA0KPj4g
IGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3VzYi9jZG5zMy9kZWJ1Z2ZzLmMNCj4+ICBjcmVh
dGUgbW9kZSAxMDA2NDQgZHJpdmVycy91c2IvY2RuczMvZHJkLmMNCj4+ICBjcmVhdGUgbW9kZSAx
MDA2NDQgZHJpdmVycy91c2IvY2RuczMvZHJkLmgNCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy91c2IvY2RuczMvZXAwLmMNCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy91c2Iv
Y2RuczMvZ2FkZ2V0LWV4cG9ydC5oDQo+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdXNi
L2NkbnMzL2dhZGdldC5jDQo+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdXNiL2NkbnMz
L2dhZGdldC5oDQo+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdXNiL2NkbnMzL2hvc3Qt
ZXhwb3J0LmgNCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy91c2IvY2RuczMvaG9zdC5j
DQo+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdXNiL2NkbnMzL3RyYWNlLmMNCj4+ICBj
cmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy91c2IvY2RuczMvdHJhY2UuaA0KPj4NCj4NCj48c25p
cD4NCj4NCj4NCj4+ICsvKioNCj4+ICsgKiBjZG5zM19wcm9iZSAtIHByb2JlIGZvciBjZG5zMyBj
b3JlIGRldmljZQ0KPj4gKyAqIEBwZGV2OiBQb2ludGVyIHRvIGNkbnMzIGNvcmUgcGxhdGZvcm0g
ZGV2aWNlDQo+PiArICoNCj4+ICsgKiBSZXR1cm5zIDAgb24gc3VjY2VzcyBvdGhlcndpc2UgbmVn
YXRpdmUgZXJybm8NCj4+ICsgKi8NCj4+ICtzdGF0aWMgaW50IGNkbnMzX3Byb2JlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+PiArew0KPj4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAm
cGRldi0+ZGV2Ow0KPj4gKwlzdHJ1Y3QgcmVzb3VyY2UJKnJlczsNCj4+ICsJc3RydWN0IGNkbnMz
ICpjZG5zOw0KPj4gKwl2b2lkIF9faW9tZW0gKnJlZ3M7DQo+PiArCWludCByZXQ7DQo+PiArDQo+
PiArCXJldCA9IGRtYV9zZXRfbWFza19hbmRfY29oZXJlbnQoZGV2LCBETUFfQklUX01BU0soMzIp
KTsNCj4NCj5BcmUgYWxsIGNvcmVzIHN1cHBvcnRlZCBieSB0aGlzIGRyaXZlciBsaW1pdGVkIHRv
IDMyLWJpdD8gSWYgbm90IHRoZW4NCj55b3UgbmVlZCB0byBzZXQgdGhlIG1hc2sgYmFzZWQgb24g
Y29tcGF0aWJsZXM/DQoNClR3byB2ZXJzaW9uOiAweDAwMDI0NTA5IGFuZCAweDAwMDI0NTBkIHN1
cHBvcnQgZXh0ZW5kZWQgRE1BIGFkZHJlc3MgdG8gNDggYml0cy4NClRoZSBwcm9ibGVtIGlzIHRo
YXQgdGhlIDE2IG1vc3Qgc2lnbmlmaWNhbnQgYml0IGluZGljYXRlIHRoZSBzZWdtZW50IHRoYXQg
Y2FuIGJlIHNldCANCnBlciBlbmRwb2ludC4gIFdlIGNhbiBhc3N1bWUgdGhhdCBpdCB3aWxsIGJl
IGNvbnN0YW50IHBlciBlbmRwb2ludC4gQWxsIERNQSBtZW1vcnkNCmZvciBkYXRhIGJ1ZmZlcnMg
YW5kIGZvciBUUkJzIG11c3QgYmUgaW4gdGhpcyByYW5nZS4gIA0KDQpJIHRoaW5rIHRoYXQgTGlu
dXgga2VybmVsIChETUEgc3Vic3lzdGVtKSBjYW4ndCBndWFyYW50ZWUgaXQuIA0KDQpVc2luZyBk
bWFfc2V0X21hc2tfYW5kX2NvaGVyZW50KGRldiwgRE1BX0JJVF9NQVNLKDQ4KSkgbm90IGd1YXJh
bnRlZSB0aGF0IHNlZ21lbnQgDQpwYXJ0IHdpbGwgYmUgYWx3YXlzIHRoZSBzYW1lLiAgDQoNClNv
IHRoZSBzYWZlc3Qgd2F5IGlzIHRvIGxpbWl0IERNQSByYW5nZSB0byAzMiBiaXRzLiAgDQoNCg0K
PjxzbmlwPg0KDQpSZWdhcmRzLA0KUGF3ZWwNCg0K
