Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DA9C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9240021901
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="kcZxSOuc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732097AbfDXP65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:58:57 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:39768 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730620AbfDXP65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:58:57 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OFujSE029809;
        Wed, 24 Apr 2019 17:58:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=pRqbQ5kzHUJ/0yvLG2bV3OcZ9iDTkwRqj2ZQk3oxDic=;
 b=kcZxSOucpbVp7fp0z9Ep19ub906TMiwsUw7CRBLuk6wpXNmlDwx25HZbuRasilh9cDva
 qR5kQNEmWcMeDTiLyg1p1hwXGispM5OZbkvxTbFziuW5GSZdhzGM6cjeFI82QBVYhob+
 GDxaZyc/DAiSaJmUMZXfaebOxyVwLJi+01GNXhNxgcSr/y2BEL+RM1yITV11lAgc04cd
 O2rEbiGr9IwvxGKi4t+Z1/Oq1zVBQf3ZBbLJbwc/cLe47ksYGJ22HZBUt35qGmjDmsvH
 QWjdjKy/WAUUkbqm4bfrS6vu+y6Z2onZ/GpvtpoLkuV4wqUgpj/revY+ySSzPZNQN6yV xg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rytad7jr0-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Apr 2019 17:58:44 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7C05831;
        Wed, 24 Apr 2019 15:58:43 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node1.st.com [10.75.127.13])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5797329BC;
        Wed, 24 Apr 2019 15:58:43 +0000 (GMT)
Received: from SFHDAG5NODE1.st.com (10.75.127.13) by SFHDAG5NODE1.st.com
 (10.75.127.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 24 Apr
 2019 17:58:43 +0200
Received: from SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6]) by
 SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6%20]) with mapi id
 15.00.1347.000; Wed, 24 Apr 2019 17:58:43 +0200
From:   Hugues FRUCHET <hugues.fruchet@st.com>
To:     Fabien DESSENNE <fabien.dessenne@st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre TORGUE" <alexandre.torgue@st.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: stm32-dcmi: return appropriate error codes during
 probe
Thread-Topic: [PATCH] media: stm32-dcmi: return appropriate error codes during
 probe
Thread-Index: AQHU+qE89UdNLcFDykybAMUMc3xQt6ZLVmKA
Date:   Wed, 24 Apr 2019 15:58:42 +0000
Message-ID: <474f02b3-33e9-5df5-7344-91fdb84507b0@st.com>
References: <1556112344-15305-1-git-send-email-fabien.dessenne@st.com>
In-Reply-To: <1556112344-15305-1-git-send-email-fabien.dessenne@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <54592166550C2A4FACC66EE36B62306D@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWNrZWQtYnk6IEh1Z3VlcyBGcnVjaGV0IDxodWd1ZXMuZnJ1Y2hldEBzdC5jb20+DQoNCg0KT24g
NC8yNC8xOSAzOjI1IFBNLCBGYWJpZW4gRGVzc2VubmUgd3JvdGU6DQo+IER1cmluZyBwcm9iZSwg
cmV0dXJuIHRoZSBwcm92aWRlZCBlcnJvcnMgdmFsdWUgaW5zdGVhZCBvZiAtRU5PREVWLg0KPiBU
aGlzIGFsbG93cyB0aGUgZHJpdmVyIHRvIGJlIGRlZmVycmVkIHByb2JlZCBpZiBuZWVkZWQuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBGYWJpZW4gRGVzc2VubmUgPGZhYmllbi5kZXNzZW5uZUBzdC5j
b20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vc3RtMzIvc3RtMzItZGNtaS5j
IHwgMTQgKysrKysrKystLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCsp
LCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvcGxhdGZv
cm0vc3RtMzIvc3RtMzItZGNtaS5jIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9zdG0zMi9zdG0z
Mi1kY21pLmMNCj4gaW5kZXggOTA2ZTcxYi4uYjlkYWQwYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9tZWRpYS9wbGF0Zm9ybS9zdG0zMi9zdG0zMi1kY21pLmMNCj4gKysrIGIvZHJpdmVycy9tZWRp
YS9wbGF0Zm9ybS9zdG0zMi9zdG0zMi1kY21pLmMNCj4gQEAgLTE2NzIsNyArMTY3Miw3IEBAIHN0
YXRpYyBpbnQgZGNtaV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgIAlk
Y21pLT5yc3RjID0gZGV2bV9yZXNldF9jb250cm9sX2dldF9leGNsdXNpdmUoJnBkZXYtPmRldiwg
TlVMTCk7DQo+ICAgCWlmIChJU19FUlIoZGNtaS0+cnN0YykpIHsNCj4gICAJCWRldl9lcnIoJnBk
ZXYtPmRldiwgIkNvdWxkIG5vdCBnZXQgcmVzZXQgY29udHJvbFxuIik7DQo+IC0JCXJldHVybiAt
RU5PREVWOw0KPiArCQlyZXR1cm4gUFRSX0VSUihkY21pLT5yc3RjKTsNCj4gICAJfQ0KPiAgIA0K
PiAgIAkvKiBHZXQgYnVzIGNoYXJhY3RlcmlzdGljcyBmcm9tIGRldmljZXRyZWUgKi8NCj4gQEAg
LTE2ODcsNyArMTY4Nyw3IEBAIHN0YXRpYyBpbnQgZGNtaV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQ0KPiAgIAlvZl9ub2RlX3B1dChucCk7DQo+ICAgCWlmIChyZXQpIHsNCj4g
ICAJCWRldl9lcnIoJnBkZXYtPmRldiwgIkNvdWxkIG5vdCBwYXJzZSB0aGUgZW5kcG9pbnRcbiIp
Ow0KPiAtCQlyZXR1cm4gLUVOT0RFVjsNCj4gKwkJcmV0dXJuIHJldDsNCj4gICAJfQ0KPiAgIA0K
PiAgIAlpZiAoZXAuYnVzX3R5cGUgPT0gVjRMMl9NQlVTX0NTSTJfRFBIWSkgew0KPiBAQCAtMTcw
MCw4ICsxNzAwLDkgQEAgc3RhdGljIGludCBkY21pX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpDQo+ICAgDQo+ICAgCWlycSA9IHBsYXRmb3JtX2dldF9pcnEocGRldiwgMCk7DQo+
ICAgCWlmIChpcnEgPD0gMCkgew0KPiAtCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJDb3VsZCBub3Qg
Z2V0IGlycVxuIik7DQo+IC0JCXJldHVybiAtRU5PREVWOw0KPiArCQlpZiAoaXJxICE9IC1FUFJP
QkVfREVGRVIpDQo+ICsJCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJDb3VsZCBub3QgZ2V0IGlycVxu
Iik7DQo+ICsJCXJldHVybiBpcnE7DQo+ICAgCX0NCj4gICANCj4gICAJZGNtaS0+cmVzID0gcGxh
dGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCj4gQEAgLTE3MjEs
MTIgKzE3MjIsMTMgQEAgc3RhdGljIGludCBkY21pX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpDQo+ICAgCQkJCQlkZXZfbmFtZSgmcGRldi0+ZGV2KSwgZGNtaSk7DQo+ICAgCWlm
IChyZXQpIHsNCj4gICAJCWRldl9lcnIoJnBkZXYtPmRldiwgIlVuYWJsZSB0byByZXF1ZXN0IGly
cSAlZFxuIiwgaXJxKTsNCj4gLQkJcmV0dXJuIC1FTk9ERVY7DQo+ICsJCXJldHVybiByZXQ7DQo+
ICAgCX0NCj4gICANCj4gICAJbWNsayA9IGRldm1fY2xrX2dldCgmcGRldi0+ZGV2LCAibWNsayIp
Ow0KPiAgIAlpZiAoSVNfRVJSKG1jbGspKSB7DQo+IC0JCWRldl9lcnIoJnBkZXYtPmRldiwgIlVu
YWJsZSB0byBnZXQgbWNsa1xuIik7DQo+ICsJCWlmIChQVFJfRVJSKG1jbGspICE9IC1FUFJPQkVf
REVGRVIpDQo+ICsJCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJVbmFibGUgdG8gZ2V0IG1jbGtcbiIp
Ow0KPiAgIAkJcmV0dXJuIFBUUl9FUlIobWNsayk7DQo+ICAgCX0NCj4gICANCj4g
