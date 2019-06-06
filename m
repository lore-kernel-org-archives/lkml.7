Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C24DC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 12:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4332320868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 12:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="G2VI2HJG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbfFFM4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 08:56:47 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:40127 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726157AbfFFM4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 08:56:47 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x56CpgJ9024951;
        Thu, 6 Jun 2019 14:56:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=3XRD9FfY9zRJABUqAPerjZxsdeAr2LTW6QMwjpkVYM8=;
 b=G2VI2HJGDpDpawQG1e5DIvMdp1QjJTU5g7y/gfYbtI9wMFVCB2aMQ6w53Kq7zEhk3dUm
 eXNBXb5YP15Fv/gUgwHdm/sRkgXyiMYkUTpc+tIWwkffrdxb8le8meIkJL1WXazwqoUl
 vwv/UvMETCV6PN8gABb3rdJp44+bPm3fixSQyPdmhA5VmAwRPlVtpVOjVZN5qbmm5qj4
 CuPQjcqp/6tV9T3IrlzH6B9Nq3b2UwYrM2Yz6pvZboAbK89YblR2iyHDodSSFnyqxOjb
 7M2YKAURi+IflP2OGlNKDbGC4rViTEtc/4JfcLj8jCa3vAj9eOZPQKZUCuSf1CSk9+M2 pw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2sxqxmubxf-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 06 Jun 2019 14:56:39 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0430D38;
        Thu,  6 Jun 2019 12:56:38 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D65D827D5;
        Thu,  6 Jun 2019 12:56:38 +0000 (GMT)
Received: from SFHDAG3NODE2.st.com (10.75.127.8) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 6 Jun
 2019 14:56:38 +0200
Received: from SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96]) by
 SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96%20]) with mapi id
 15.00.1347.000; Thu, 6 Jun 2019 14:56:38 +0200
From:   Amelie DELAUNAY <amelie.delaunay@st.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH v2] mfd: stmfx: Uninitialized variable in
 stmfx_irq_handler()
Thread-Topic: [PATCH v2] mfd: stmfx: Uninitialized variable in
 stmfx_irq_handler()
Thread-Index: AQHVHGU0uMlMYc9f1UugMwgEk54JpKaOdDoA
Date:   Thu, 6 Jun 2019 12:56:38 +0000
Message-ID: <b1374627-7af2-77cd-c7f2-40166fce5a04@st.com>
References: <20190606124127.GA17082@mwanda>
In-Reply-To: <20190606124127.GA17082@mwanda>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <29AF75230286B44FBCB97240115B5CF5@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-06_10:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi82LzE5IDI6NDEgUE0sIERhbiBDYXJwZW50ZXIgd3JvdGU6DQo+IFRoZSBwcm9ibGVtIGlz
IHRoYXQgb24gNjRiaXQgc3lzdGVtcyB0aGVuIHdlIGRvbid0IGNsZWFyIHRoZSBoaWdoZXINCj4g
Yml0cyBvZiB0aGUgInBlbmRpbmciIHZhcmlhYmxlLiAgU28gd2hlbiB3ZSBkbzoNCj4gDQo+ICAg
ICAgICAgIGFjayA9IHBlbmRpbmcgJiB+QklUKFNUTUZYX1JFR19JUlFfU1JDX0VOX0dQSU8pOw0K
PiAgICAgICAgICBpZiAoYWNrKSB7DQo+IA0KPiB0aGUgaWYgKGFjaykgY29uZGl0aW9uIHJlbGll
cyBvbiB1bmluaXRpYWxpemVkIGRhdGEuICBUaGUgZml4IGl0IHRoYXQNCj4gSSd2ZSBjaGFuZ2Vk
ICJwZW5kaW5nIiBmcm9tIGFuIHVuc2lnbmVkIGxvbmcgdG8gYSB1MzIuICBJIGNoYW5nZWQgIm4i
IGFzDQo+IHdlbGwsIGJlY2F1c2UgdGhhdCdzIGEgbnVtYmVyIGluIHRoZSAwLTEwIHJhbmdlIGFu
ZCBpdCBmaXRzIGVhc2lseQ0KPiBpbnNpZGUgYW4gaW50LiAgV2UgZG8gbmVlZCB0byBhZGQgYSBj
YXN0IHRvICJwZW5kaW5nIiB3aGVuIHdlIHVzZSBpdCBpbg0KPiB0aGUgZm9yX2VhY2hfc2V0X2Jp
dCgpIGxvb3AsIGJ1dCB0aGF0IGRvZXNuJ3QgY2F1c2UgYSBwcm9ibGUsIGl0J3MNCj4gZmluZS4N
Cj4gDQo+IEZpeGVzOiAwNjI1MmFkZTkxNTYgKCJtZmQ6IEFkZCBTVCBNdWx0aS1GdW5jdGlvbiBl
WHBhbmRlciAoU1RNRlgpIGNvcmUgZHJpdmVyIikNCj4gU2lnbmVkLW9mZi1ieTogRGFuIENhcnBl
bnRlciA8ZGFuLmNhcnBlbnRlckBvcmFjbGUuY29tPg0KDQpBY2tlZC1ieTogQW1lbGllIERlbGF1
bmF5IDxhbWVsaWUuZGVsYXVuYXlAc3QuY29tPg0KDQo+IC0tLQ0KPiB2Mjogd2hpdGUgc3BhY2Ug
Y2hhbmdlcw0KPiANCj4gICBkcml2ZXJzL21mZC9zdG1meC5jIHwgMTAgKysrKy0tLS0tLQ0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9tZmQvc3RtZnguYyBiL2RyaXZlcnMvbWZkL3N0bWZ4LmMNCj4g
aW5kZXggZmU4ZWZiYTJkNDVmLi43YzQxOWMwNzg2ODggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
bWZkL3N0bWZ4LmMNCj4gKysrIGIvZHJpdmVycy9tZmQvc3RtZnguYw0KPiBAQCAtMjA0LDEyICsy
MDQsMTAgQEAgc3RhdGljIHN0cnVjdCBpcnFfY2hpcCBzdG1meF9pcnFfY2hpcCA9IHsNCj4gICBz
dGF0aWMgaXJxcmV0dXJuX3Qgc3RtZnhfaXJxX2hhbmRsZXIoaW50IGlycSwgdm9pZCAqZGF0YSkN
Cj4gICB7DQo+ICAgCXN0cnVjdCBzdG1meCAqc3RtZnggPSBkYXRhOw0KPiAtCXVuc2lnbmVkIGxv
bmcgbiwgcGVuZGluZzsNCj4gLQl1MzIgYWNrOw0KPiAtCWludCByZXQ7DQo+ICsJdTMyIHBlbmRp
bmcsIGFjazsNCj4gKwlpbnQgbiwgcmV0Ow0KPiAgIA0KPiAtCXJldCA9IHJlZ21hcF9yZWFkKHN0
bWZ4LT5tYXAsIFNUTUZYX1JFR19JUlFfUEVORElORywNCj4gLQkJCSAgKHUzMiAqKSZwZW5kaW5n
KTsNCj4gKwlyZXQgPSByZWdtYXBfcmVhZChzdG1meC0+bWFwLCBTVE1GWF9SRUdfSVJRX1BFTkRJ
TkcsICZwZW5kaW5nKTsNCj4gICAJaWYgKHJldCkNCj4gICAJCXJldHVybiBJUlFfTk9ORTsNCj4g
ICANCj4gQEAgLTIyNCw3ICsyMjIsNyBAQCBzdGF0aWMgaXJxcmV0dXJuX3Qgc3RtZnhfaXJxX2hh
bmRsZXIoaW50IGlycSwgdm9pZCAqZGF0YSkNCj4gICAJCQlyZXR1cm4gSVJRX05PTkU7DQo+ICAg
CX0NCj4gICANCj4gLQlmb3JfZWFjaF9zZXRfYml0KG4sICZwZW5kaW5nLCBTVE1GWF9SRUdfSVJR
X1NSQ19NQVgpDQo+ICsJZm9yX2VhY2hfc2V0X2JpdChuLCAodW5zaWduZWQgbG9uZyAqKSZwZW5k
aW5nLCBTVE1GWF9SRUdfSVJRX1NSQ19NQVgpDQo+ICAgCQloYW5kbGVfbmVzdGVkX2lycShpcnFf
ZmluZF9tYXBwaW5nKHN0bWZ4LT5pcnFfZG9tYWluLCBuKSk7DQo+ICAgDQo+ICAgCXJldHVybiBJ
UlFfSEFORExFRDsNCj4g
