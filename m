Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE93C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFFE21907
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Bf1FlE4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731919AbfDXOwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:52:24 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:33811 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732935AbfDXOwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:52:20 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OEp2FU025773;
        Wed, 24 Apr 2019 16:51:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=tfOL7RWJLa/sxE6h5yLzc6UH4P7Ysnh2pRkyo0IJWas=;
 b=Bf1FlE4NT7gSotfyZVtKaotdfipcIl7iRL/4kjEGCh0R66fSg3rckCfTTlTnfao7JZ8l
 neX7llzA3569lZnniArmXzVO+E9rXw+opSP6vzGRcQnMNIqiq6Br7MZJ6zs0Z+Zh/n4v
 342RdH4nzZPycWNPeoF0es/+6+C55+cbM07OcCsv2I9njEysK75CCQnXH00FyYKe09Wt
 BBTAdB6ncnxk6kAYeKLC9pgkvKpZMK9KA4iT8oM3gny9MqEHEIyrO7EH46oM4fEYNlRY
 P/boyXWMws+M5zcoYYXK8QetAXweDTnTSbJR4zCgzWDE6IKSsBZpxAvPxU3qAlE7VTZs Mw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rys6rx2y4-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Apr 2019 16:51:59 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CB01B3D;
        Wed, 24 Apr 2019 14:51:58 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A885D2881;
        Wed, 24 Apr 2019 14:51:58 +0000 (GMT)
Received: from SFHDAG3NODE2.st.com (10.75.127.8) by SFHDAG5NODE2.st.com
 (10.75.127.14) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 24 Apr
 2019 16:51:58 +0200
Received: from SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96]) by
 SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96%20]) with mapi id
 15.00.1347.000; Wed, 24 Apr 2019 16:51:58 +0200
From:   Amelie DELAUNAY <amelie.delaunay@st.com>
To:     Fabien DESSENNE <fabien.dessenne@st.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtc: stm32: manage the get_irq probe defer case
Thread-Topic: [PATCH] rtc: stm32: manage the get_irq probe defer case
Thread-Index: AQHU+pkBjK8X5mPnl0utzwbaeBOYTqZLQ86A
Date:   Wed, 24 Apr 2019 14:51:58 +0000
Message-ID: <59a465a2-99c1-caaf-97c0-b63074e38770@st.com>
References: <1556108808-32722-1-git-send-email-fabien.dessenne@st.com>
In-Reply-To: <1556108808-32722-1-git-send-email-fabien.dessenne@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4E0EEA2FE711A42A94F029CE39523C7@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yNC8xOSAyOjI2IFBNLCBGYWJpZW4gRGVzc2VubmUgd3JvdGU6DQo+IE1hbmFnZSB0aGUg
LUVQUk9CRV9ERUZFUiBlcnJvciBjYXNlIGZvciB0aGUgd2FrZSBJUlEuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBGYWJpZW4gRGVzc2VubmUgPGZhYmllbi5kZXNzZW5uZUBzdC5jb20+DQoNCkFja2Vk
LWJ5OiBBbWVsaWUgRGVsYXVuYXkgPGFtZWxpZS5kZWxhdW5heUBzdC5jb20+DQoNCj4gLS0tDQo+
ICAgZHJpdmVycy9ydGMvcnRjLXN0bTMyLmMgfCA5ICsrKysrKy0tLQ0KPiAgIDEgZmlsZSBjaGFu
Z2VkLCA2IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ydGMvcnRjLXN0bTMyLmMgYi9kcml2ZXJzL3J0Yy9ydGMtc3RtMzIuYw0KPiBpbmRl
eCBjNTkwOGNmLi44ZTZjOWIzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3J0Yy9ydGMtc3RtMzIu
Yw0KPiArKysgYi9kcml2ZXJzL3J0Yy9ydGMtc3RtMzIuYw0KPiBAQCAtNzg4LDExICs3ODgsMTQg
QEAgc3RhdGljIGludCBzdG0zMl9ydGNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
dikNCj4gICAJcmV0ID0gZGV2aWNlX2luaXRfd2FrZXVwKCZwZGV2LT5kZXYsIHRydWUpOw0KPiAg
IAlpZiAocnRjLT5kYXRhLT5oYXNfd2FrZWlycSkgew0KPiAgIAkJcnRjLT53YWtlaXJxX2FsYXJt
ID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCAxKTsNCj4gLQkJaWYgKHJ0Yy0+d2FrZWlycV9hbGFy
bSA8PSAwKQ0KPiAtCQkJcmV0ID0gcnRjLT53YWtlaXJxX2FsYXJtOw0KPiAtCQllbHNlDQo+ICsJ
CWlmIChydGMtPndha2VpcnFfYWxhcm0gPiAwKSB7DQo+ICAgCQkJcmV0ID0gZGV2X3BtX3NldF9k
ZWRpY2F0ZWRfd2FrZV9pcnEoJnBkZXYtPmRldiwNCj4gICAJCQkJCQkJICAgIHJ0Yy0+d2FrZWly
cV9hbGFybSk7DQo+ICsJCX0gZWxzZSB7DQo+ICsJCQlyZXQgPSBydGMtPndha2VpcnFfYWxhcm07
DQo+ICsJCQlpZiAocnRjLT53YWtlaXJxX2FsYXJtID09IC1FUFJPQkVfREVGRVIpDQo+ICsJCQkJ
Z290byBlcnI7DQo+ICsJCX0NCj4gICAJfQ0KPiAgIAlpZiAocmV0KQ0KPiAgIAkJZGV2X3dhcm4o
JnBkZXYtPmRldiwgImFsYXJtIGNhbid0IHdha2UgdXAgdGhlIHN5c3RlbTogJWQiLCByZXQpOw0K
PiA=
