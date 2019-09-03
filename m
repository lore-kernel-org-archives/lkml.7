Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3246BC3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 03:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84CED207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 03:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="kSOMsA2z";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="niBPYPAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfICDaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 23:30:00 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:11916 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725848AbfICDaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 23:30:00 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x833TH6r001032;
        Mon, 2 Sep 2019 20:29:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=AayugZor2bloa/ubIcAhROb+YzDWi4cstUeG9E+GXac=;
 b=kSOMsA2zj6fVTFPwrU9TbqpFVW0TRCKEdjOEJlJL+oGUxYSt5jOMZP5PvhLI74Etthly
 zhZdHzTClaPvl2geosJHej9+JyRi6t7SXw34Umhfp6/E+ehAgDGtlsPZCQWjCO/f35u5
 VmZusOk+OcrKH/iL/BTEBPb7YDGm6E2jPqRMujKlD6+BEhvyIrVSYI5fUCo2qEbvvkKS
 YguQdO0q+AqI8Apbc5jCLK3u6oIELpjQb3AvApstKnLjJy6OTyWEOeOID5rU+aqSh0hj
 SNUd/OKRRBMnfh2EKbr6RJM+D+A1s+8EEcy4ARDF9ESo3rbGJB0NaoeSU0dzWayoT3bw EA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2055.outbound.protection.outlook.com [104.47.38.55])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2uqmfvhjeg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 02 Sep 2019 20:29:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjeVwmyB9uk0a03TXoFNXfk2REL8xW7xDgJ2GsfHlPX9wOCJ3UyOaDVCwKBtzkFNeJTB+44+dd8FtSPDA64K007ccgHrF3oHtwp+IKxfkmdKU5fcKFa1DqcNBsjdiQNfZydgZtIYhKVq6BgFmc2KvyuyO72cTGbv6m8yGV8vB9yYxihRyzy2d8Xv1zJUS2UKuG+PJjcz3WrxHuTjkUd1JNqC2bmvkouS2dQELOvpxZdC6r2rscbt0d2PfpVW2ZQUbnwqnuDgBsb5tV4kVBWQ2HJ2m1gxtoJeOdCUr9PsqUuaThQud9pYH/QHZW3pEnD/Uc9pr5ySoQWMjdKcEaRYWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AayugZor2bloa/ubIcAhROb+YzDWi4cstUeG9E+GXac=;
 b=FcRKGl3It/xxgJ/Tph+nMoDU7WMDyZhVlu9JQ3kQ6GYdmS526MtiUUbJw+tALBnStBUflfxHQR8DVmJZVybi/pTfCmW2hfUrmm5Zy+G50jb/aBia8ee4pLAVFtjJ1ksx6zhxCSmhv7nkM7WVRyYU9MiiVJ4O9a5NUMPRpCWYombsg7U1PVXDYQgqyvpNk2EJvNL3rU+RkJBvQuFGdPmBabzUA9Xgo1jLRO7TCC+r/S33Hjw9JgNpCGDg3tIHs53EKCoqhqTbLGDKHLJ4UtgKUoEudoKbC2Wu0gV8mUEyDQDGfSeuDQWOVeSQbdC3yxREwe7PYwwd/wo2KNcvydYYLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AayugZor2bloa/ubIcAhROb+YzDWi4cstUeG9E+GXac=;
 b=niBPYPAUT0R6COSIpR5Ce+Qk+iWodNFvaA6Om3QYy2LbEAo9NJhoy1WsOwsmJ0TTb0EgSU9WLLtSQOC2tXd+z/+SbJbgYcuk4BXjxUcRxW96VUJsb17Lf4tH43d+JOyPKYqAoleBWgz9RH3yPwvJZeJNd4OHw1TA6utZXPc8ua0=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5687.namprd07.prod.outlook.com (20.178.0.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.21; Tue, 3 Sep 2019 03:29:50 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::98f2:1592:6dff:63e]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::98f2:1592:6dff:63e%7]) with mapi id 15.20.2220.013; Tue, 3 Sep 2019
 03:29:50 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][usb-next] usb: cdns3: fix missing assignment of ret
 before error check on ret
Thread-Topic: [PATCH][usb-next] usb: cdns3: fix missing assignment of ret
 before error check on ret
Thread-Index: AQHVYZ3KnTofVq3/tkKV7S4WfQAkHqcYgYMAgADJvCA=
Date:   Tue, 3 Sep 2019 03:29:50 +0000
Message-ID: <BYAPR07MB470927CBDF6CC2345DD350E6DDB90@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <20190902145035.18200-1-colin.king@canonical.com>
 <BYAPR07MB4709DF377BFBD54FD6BF88B3DDBE0@BYAPR07MB4709.namprd07.prod.outlook.com>
In-Reply-To: <BYAPR07MB4709DF377BFBD54FD6BF88B3DDBE0@BYAPR07MB4709.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 560fa123-529f-4213-0bf4-08d7301efa68
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB5687;
x-ms-traffictypediagnostic: BYAPR07MB5687:
x-microsoft-antispam-prvs: <BYAPR07MB56874CF080FA546806D73379DDB90@BYAPR07MB5687.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(36092001)(199004)(189003)(74316002)(229853002)(7736002)(53936002)(25786009)(26005)(14444005)(446003)(86362001)(6116002)(3846002)(5660300002)(9686003)(256004)(55016002)(102836004)(6246003)(99286004)(110136005)(11346002)(54906003)(476003)(52536014)(486006)(4326008)(186003)(6436002)(33656002)(2501003)(66066001)(71200400001)(81156014)(8676002)(305945005)(81166006)(6506007)(76176011)(8936002)(76116006)(66476007)(478600001)(64756008)(66556008)(66446008)(66946007)(14454004)(2906002)(316002)(7696005)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5687;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iv0q1WqEp6RPUOlMNe+TMFSBN8Sbf8bZTlC2ZFuJWSzYt0FeTTvHEXrkrz9UmRWD7SWRTVP8fBZA8tm7MGakQ45BvRcu/pERKLMQ3l4G9HD79boVtLSWJff92Zc9BhFsSySOBcjR6jL+ssIGEO/k6oJvtBn0vKc3V8MPnT/XBtQhQ0OSDky968fHI0j0bW095X8vs12eKYsQLbHE/AXG/CKuXnZ8jtqh2PUfgFthYj5+m62KNlt/45P5+8WfxfdtUlTWyZZk5mTwYVxu8jQz19tYdFdeHXXxTkWqTaTDzXnpgxw38b3Nqk1O3JaOycOAg+moSvyeEP/408C6juJUL+bBr9T3NfMcOGC8NoFZZzs8hCX9YywlBNv5LppTbt4e2Wfj73oA6RvpofCK+WcigT0Vw3GQB4flPgvDKbFalmk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 560fa123-529f-4213-0bf4-08d7301efa68
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 03:29:50.3410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y7g0TOQO/7389o0DKQM+aRV9J953ErT5AoyvUejfv/7vfFxfiG47138zeVW4RS1gyXYVAYBDwhjtP6fV1rtaSzIciP71gFhXVpWtliCTi7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5687
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-02_10:2019-08-29,2019-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909030036
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ29saW4NCg0KPkhpIENvbGluDQo+DQo+Pg0KPj5Gcm9tOiBDb2xpbiBJYW4gS2luZyA8Y29s
aW4ua2luZ0BjYW5vbmljYWwuY29tPg0KPj4NCj4+Q3VycmVudGx5IHRoZSBjaGVjayBvbiBhIG5v
bi16ZXJvIHJldHVybiBjb2RlIGluIHJldCBpcyBmYWxzZSBiZWNhdXNlDQo+PnJldCBoYXMgYmVl
biBpbml0aWFsaXplZCB0byB6ZXJvLiAgSSBiZWxpZXZlIHRoYXQgcmV0IHNob3VsZCBiZSBhc3Np
Z25lZA0KPj50byB0aGUgcmV0dXJuIGZyb20gdGhlIGNhbGwgdG8gcmVhZGxfcG9sbF90aW1lb3V0
X2F0b21pYyBiZWZvcmUgdGhlDQo+PmNoZWNrIG9uIHJldC4gIFNpbmNlIHJldCBpcyBiZWluZyBy
ZS1hc3NpbmdlZCB0aGUgb3JpZ2luYWwgaW5pdGlhbGl6YXRpb24NCj4+b2YgcmV0IHRvIHplcm8g
Y2FuIGJlIHJlbW92ZWQuDQo+DQo+VGhhbmtzIHlvdSBmb3IgbGV0dGluZyBtZSBrbm93Lg0KPkZv
cnR1bmF0ZWx5IHRoYXQncyBub3QgYSBjcml0aWNhbCBidWcgYW5kIGhhcyBubyBpbXBhY3QgZm9y
IGRyaXZlci4NCj5JIHdpbGwgY29ycmVjdCBpdC4NCj4NCj5DaGVlcnMNCj5QYXdlbGwNCj4NCj4+
DQo+PkFkZHJlc3Nlcy1Db3Zlcml0eTogKCInQ29uc3RhbnQnIHZhcmlhYmxlIGd1YXJkcyBkZWFk
IGNvZGUiKQ0KPj5GaXhlczogNzczM2Y2YzMyZTM2ICgidXNiOiBjZG5zMzogQWRkIENhZGVuY2Ug
VVNCMyBEUkQgRHJpdmVyIikNCj4+U2lnbmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGlu
LmtpbmdAY2Fub25pY2FsLmNvbT4NCj4+LS0tDQo+PiBkcml2ZXJzL3VzYi9jZG5zMy9nYWRnZXQu
YyB8IDYgKysrLS0tDQo+PiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQ0KPj4NCj4+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2NkbnMzL2dhZGdldC5jIGIv
ZHJpdmVycy91c2IvY2RuczMvZ2FkZ2V0LmMNCj4+aW5kZXggMzA5NGFkNjVmZmM5Li4wZWIzMDIy
ODM4ZDYgMTAwNjQ0DQo+Pi0tLSBhL2RyaXZlcnMvdXNiL2NkbnMzL2dhZGdldC5jDQo+PisrKyBi
L2RyaXZlcnMvdXNiL2NkbnMzL2dhZGdldC5jDQo+PkBAIC0yMTU0LDcgKzIxNTQsNyBAQCBpbnQg
X19jZG5zM19nYWRnZXRfZXBfY2xlYXJfaGFsdChzdHJ1Y3QgY2RuczNfZW5kcG9pbnQgKnByaXZf
ZXApDQo+PiB7DQo+PiAJc3RydWN0IGNkbnMzX2RldmljZSAqcHJpdl9kZXYgPSBwcml2X2VwLT5j
ZG5zM19kZXY7DQo+PiAJc3RydWN0IHVzYl9yZXF1ZXN0ICpyZXF1ZXN0Ow0KPj4tCWludCByZXQg
PSAwOw0KPj4rCWludCByZXQ7DQo+PiAJaW50IHZhbDsNCj4+DQo+PiAJdHJhY2VfY2RuczNfaGFs
dChwcml2X2VwLCAwLCAwKTsNCj4+QEAgLTIxNjIsOCArMjE2Miw4IEBAIGludCBfX2NkbnMzX2dh
ZGdldF9lcF9jbGVhcl9oYWx0KHN0cnVjdCBjZG5zM19lbmRwb2ludCAqcHJpdl9lcCkNCj4+IAl3
cml0ZWwoRVBfQ01EX0NTVEFMTCB8IEVQX0NNRF9FUFJTVCwgJnByaXZfZGV2LT5yZWdzLT5lcF9j
bWQpOw0KPj4NCj4+IAkvKiB3YWl0IGZvciBFUFJTVCBjbGVhcmVkICovDQo+Pi0JcmVhZGxfcG9s
bF90aW1lb3V0X2F0b21pYygmcHJpdl9kZXYtPnJlZ3MtPmVwX2NtZCwgdmFsLA0KPj4tCQkJCSAg
ISh2YWwgJiBFUF9DTURfRVBSU1QpLCAxLCAxMDApOw0KPj4rCXJldCA9IHJlYWRsX3BvbGxfdGlt
ZW91dF9hdG9taWMoJnByaXZfZGV2LT5yZWdzLT5lcF9jbWQsIHZhbCwNCj4+KwkJCQkJISh2YWwg
JiBFUF9DTURfRVBSU1QpLCAxLCAxMDApOw0KPj4gCWlmIChyZXQpDQo+PiAJCXJldHVybiAtRUlO
VkFMOw0KDQpXaGF0IGFib3V0IHN1Y2ggY29uZGl0aW9uOg0KCWlmICh1bmxpa2VseShyZXQpKSB7
DQoJCWRldl9lcnIocHJpdl9kZXYtPmRldiwgIkZhaWxlZCB0byBjbGVhciBoYWx0ICVzICh0aW1l
b3V0KS4iLA0KCQkJcHJpdl9lcC0+bmFtZSk7DQoJCXJldHVybiByZXQ7DQoJfQ0KDQpJbnZhbGlk
IHJldHVybiB2YWx1ZSBpbiB0aGlzIHBsYWNlIGlzIHJhdGhlciBpbXBvc3NpYmxlIGNhc2UuIElm
IGl0IG9jY3VycyANCnRoZW4gaXQgc2hvdWxkIGJlIHRyZWF0ZWQgYXMgY3JpdGljYWwgZXJyb3Is
IHNvIGl0IGNvdWxkIGJlIGdvb2QgdG8gaGF2ZSANCmluZm9ybWF0aW9uIGFib3V0IGl0Lg0KDQpD
aGVlcnMsDQpQYXdlbA0KDQo+Pg0KPg0KPj4tLQ0KPj4yLjIwLjENCg0K
