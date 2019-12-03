Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5C2C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4AB320684
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="G1OOjciX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfLCK33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 05:29:29 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:32582 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725848AbfLCK32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 05:29:28 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB3ARHDg017607;
        Tue, 3 Dec 2019 11:29:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=bM3pWSeqkB5UkxAbD3228fZVFkK6OfNc9gF3Gi65CVw=;
 b=G1OOjciXP9KiviJUFCAZxsXwXh36wmMOGLYwq4FXtqGmaQ9svtqwZr0sUXX33xn450wF
 DOjeC9fxgDochVQXjOuHpGv7vzzbVKZ97/mAkGlaJUfJmflbfz0JzKs2p8kyAuwLbIks
 VlFr/wZyaGX4BQqlS7EKC1GQwJGPN7iE6ROBoCD4jiMYSEDJL1xnD4kvg1TXkJ4Yegrd
 xv0dXTS3S1F6XqAw736j/NNtiaKN6agD7HAdjHxM8GlX/FtKWqq93MGooh+XSG5NkQW4
 lMhyu/EXL5LgBSng1HbUUp1kav23948sMj6bL4+IX/jZCURNsAugkOSDA3ZIHR+yKIHV FQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2wkee9xybr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Dec 2019 11:29:15 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E559510003A;
        Tue,  3 Dec 2019 11:29:14 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B24E02AFD24;
        Tue,  3 Dec 2019 11:29:14 +0100 (CET)
Received: from SFHDAG5NODE3.st.com (10.75.127.15) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Dec
 2019 11:29:14 +0100
Received: from SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47]) by
 SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47%20]) with mapi id
 15.00.1473.003; Tue, 3 Dec 2019 11:29:14 +0100
From:   Fabien DESSENNE <fabien.dessenne@st.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] irqchip/stm32-exti: Use the
 hwspin_lock_timeout_in_atomic() API
Thread-Topic: [PATCH] irqchip/stm32-exti: Use the
 hwspin_lock_timeout_in_atomic() API
Thread-Index: AQHVb8Qw0weioX7Mt0ih3xTUpVlZr6eomLeA
Date:   Tue, 3 Dec 2019 10:29:14 +0000
Message-ID: <c279603f-7ba6-6e47-5f1f-43e95a0b2fea@st.com>
References: <1568991643-7549-1-git-send-email-fabien.dessenne@st.com>
In-Reply-To: <1568991643-7549-1-git-send-email-fabien.dessenne@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB6069AC1532F74CBDB0DBE0646F9FA7@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-03_02:2019-11-29,2019-12-03 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkNCg0KDQpJdCBsb29rcyBsaWtlIHRoaXMgcGF0Y2ggZ290IGxvc3QuIENhbiBhbnlvbmUgaGF2
ZSBhIGxvb2sgYXQgaXQ/DQoNCkJSDQoNCkZhYmllbg0KDQoNCk9uIDIwLzA5LzIwMTkgNTowMCBQ
TSwgRmFiaWVuIERlc3Nlbm5lIHdyb3RlOg0KPiBOb3cgdGhhdCB0aGUgaHdzcGluX2xvY2tfdGlt
ZW91dF9pbl9hdG9taWMoKSBBUEkgaXMgYXZhaWxhYmxlIHVzZSBpdC4NCj4NCj4gU2lnbmVkLW9m
Zi1ieTogRmFiaWVuIERlc3Nlbm5lIDxmYWJpZW4uZGVzc2VubmVAc3QuY29tPg0KPiAtLS0NCj4g
ICBkcml2ZXJzL2lycWNoaXAvaXJxLXN0bTMyLWV4dGkuYyB8IDY1ICsrKysrKysrKysrKystLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9u
cygrKSwgNDUgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lycWNoaXAv
aXJxLXN0bTMyLWV4dGkuYyBiL2RyaXZlcnMvaXJxY2hpcC9pcnEtc3RtMzItZXh0aS5jDQo+IGlu
ZGV4IGUwMGYyZmEuLjdmYzBkMWYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaXJxY2hpcC9pcnEt
c3RtMzItZXh0aS5jDQo+ICsrKyBiL2RyaXZlcnMvaXJxY2hpcC9pcnEtc3RtMzItZXh0aS5jDQo+
IEBAIC0yNSw3ICsyNSw2IEBADQo+ICAgI2RlZmluZSBJUlFTX1BFUl9CQU5LIDMyDQo+ICAgDQo+
ICAgI2RlZmluZSBIV1NQTkxDS19USU1FT1VUCTEwMDAgLyogdXNlYyAqLw0KPiAtI2RlZmluZSBI
V1NQTkxDS19SRVRSWV9ERUxBWQkxMDAgIC8qIHVzZWMgKi8NCj4gICANCj4gICBzdHJ1Y3Qgc3Rt
MzJfZXh0aV9iYW5rIHsNCj4gICAJdTMyIGltcl9vZnN0Ow0KPiBAQCAtMjc3LDU1ICsyNzYsMjQg
QEAgc3RhdGljIGludCBzdG0zMl9leHRpX3NldF90eXBlKHN0cnVjdCBpcnFfZGF0YSAqZCwNCj4g
ICAJcmV0dXJuIDA7DQo+ICAgfQ0KPiAgIA0KPiAtc3RhdGljIGludCBzdG0zMl9leHRpX2h3c3Bp
bl9sb2NrKHN0cnVjdCBzdG0zMl9leHRpX2NoaXBfZGF0YSAqY2hpcF9kYXRhKQ0KPiAtew0KPiAt
CWludCByZXQsIHRpbWVvdXQgPSAwOw0KPiAtDQo+IC0JaWYgKCFjaGlwX2RhdGEtPmhvc3RfZGF0
YS0+aHdsb2NrKQ0KPiAtCQlyZXR1cm4gMDsNCj4gLQ0KPiAtCS8qDQo+IC0JICogVXNlIHRoZSB4
X3JhdyBBUEkgc2luY2Ugd2UgYXJlIHVuZGVyIHNwaW5fbG9jayBwcm90ZWN0aW9uLg0KPiAtCSAq
IERvIG5vdCB1c2UgdGhlIHhfdGltZW91dCBBUEkgYmVjYXVzZSB3ZSBhcmUgdW5kZXIgaXJxX2Rp
c2FibGUNCj4gLQkgKiBtb2RlIChzZWUgX19zZXR1cF9pcnEoKSkNCj4gLQkgKi8NCj4gLQlkbyB7
DQo+IC0JCXJldCA9IGh3c3Bpbl90cnlsb2NrX3JhdyhjaGlwX2RhdGEtPmhvc3RfZGF0YS0+aHds
b2NrKTsNCj4gLQkJaWYgKCFyZXQpDQo+IC0JCQlyZXR1cm4gMDsNCj4gLQ0KPiAtCQl1ZGVsYXko
SFdTUE5MQ0tfUkVUUllfREVMQVkpOw0KPiAtCQl0aW1lb3V0ICs9IEhXU1BOTENLX1JFVFJZX0RF
TEFZOw0KPiAtCX0gd2hpbGUgKHRpbWVvdXQgPCBIV1NQTkxDS19USU1FT1VUKTsNCj4gLQ0KPiAt
CWlmIChyZXQgPT0gLUVCVVNZKQ0KPiAtCQlyZXQgPSAtRVRJTUVET1VUOw0KPiAtDQo+IC0JaWYg
KHJldCkNCj4gLQkJcHJfZXJyKCIlcyBjYW4ndCBnZXQgaHdzcGlubG9jayAoJWQpXG4iLCBfX2Z1
bmNfXywgcmV0KTsNCj4gLQ0KPiAtCXJldHVybiByZXQ7DQo+IC19DQo+IC0NCj4gLXN0YXRpYyB2
b2lkIHN0bTMyX2V4dGlfaHdzcGluX3VubG9jayhzdHJ1Y3Qgc3RtMzJfZXh0aV9jaGlwX2RhdGEg
KmNoaXBfZGF0YSkNCj4gLXsNCj4gLQlpZiAoY2hpcF9kYXRhLT5ob3N0X2RhdGEtPmh3bG9jaykN
Cj4gLQkJaHdzcGluX3VubG9ja19yYXcoY2hpcF9kYXRhLT5ob3N0X2RhdGEtPmh3bG9jayk7DQo+
IC19DQo+IC0NCj4gICBzdGF0aWMgaW50IHN0bTMyX2lycV9zZXRfdHlwZShzdHJ1Y3QgaXJxX2Rh
dGEgKmQsIHVuc2lnbmVkIGludCB0eXBlKQ0KPiAgIHsNCj4gICAJc3RydWN0IGlycV9jaGlwX2dl
bmVyaWMgKmdjID0gaXJxX2RhdGFfZ2V0X2lycV9jaGlwX2RhdGEoZCk7DQo+ICAgCXN0cnVjdCBz
dG0zMl9leHRpX2NoaXBfZGF0YSAqY2hpcF9kYXRhID0gZ2MtPnByaXZhdGU7DQo+ICAgCWNvbnN0
IHN0cnVjdCBzdG0zMl9leHRpX2JhbmsgKnN0bTMyX2JhbmsgPSBjaGlwX2RhdGEtPnJlZ19iYW5r
Ow0KPiArCXN0cnVjdCBod3NwaW5sb2NrICpod2xvY2sgPSBjaGlwX2RhdGEtPmhvc3RfZGF0YS0+
aHdsb2NrOw0KPiAgIAl1MzIgcnRzciwgZnRzcjsNCj4gICAJaW50IGVycjsNCj4gICANCj4gICAJ
aXJxX2djX2xvY2soZ2MpOw0KPiAgIA0KPiAtCWVyciA9IHN0bTMyX2V4dGlfaHdzcGluX2xvY2so
Y2hpcF9kYXRhKTsNCj4gLQlpZiAoZXJyKQ0KPiAtCQlnb3RvIHVubG9jazsNCj4gKwlpZiAoaHds
b2NrKSB7DQo+ICsJCWVyciA9IGh3c3Bpbl9sb2NrX3RpbWVvdXRfaW5fYXRvbWljKGh3bG9jaywg
SFdTUE5MQ0tfVElNRU9VVCk7DQo+ICsJCWlmIChlcnIpIHsNCj4gKwkJCXByX2VycigiJXMgY2Fu
J3QgZ2V0IGh3c3BpbmxvY2sgKCVkKVxuIiwgX19mdW5jX18sIGVycik7DQo+ICsJCQlnb3RvIHVu
bG9jazsNCj4gKwkJfQ0KPiArCX0NCj4gICANCj4gICAJcnRzciA9IGlycV9yZWdfcmVhZGwoZ2Ms
IHN0bTMyX2JhbmstPnJ0c3Jfb2ZzdCk7DQo+ICAgCWZ0c3IgPSBpcnFfcmVnX3JlYWRsKGdjLCBz
dG0zMl9iYW5rLT5mdHNyX29mc3QpOw0KPiBAQCAtMzM4LDcgKzMwNiw4IEBAIHN0YXRpYyBpbnQg
c3RtMzJfaXJxX3NldF90eXBlKHN0cnVjdCBpcnFfZGF0YSAqZCwgdW5zaWduZWQgaW50IHR5cGUp
DQo+ICAgCWlycV9yZWdfd3JpdGVsKGdjLCBmdHNyLCBzdG0zMl9iYW5rLT5mdHNyX29mc3QpOw0K
PiAgIA0KPiAgIHVuc3BpbmxvY2s6DQo+IC0Jc3RtMzJfZXh0aV9od3NwaW5fdW5sb2NrKGNoaXBf
ZGF0YSk7DQo+ICsJaWYgKGh3bG9jaykNCj4gKwkJaHdzcGluX3VubG9ja19pbl9hdG9taWMoaHds
b2NrKTsNCj4gICB1bmxvY2s6DQo+ICAgCWlycV9nY191bmxvY2soZ2MpOw0KPiAgIA0KPiBAQCAt
NTA0LDE1ICs0NzMsMjAgQEAgc3RhdGljIGludCBzdG0zMl9leHRpX2hfc2V0X3R5cGUoc3RydWN0
IGlycV9kYXRhICpkLCB1bnNpZ25lZCBpbnQgdHlwZSkNCj4gICB7DQo+ICAgCXN0cnVjdCBzdG0z
Ml9leHRpX2NoaXBfZGF0YSAqY2hpcF9kYXRhID0gaXJxX2RhdGFfZ2V0X2lycV9jaGlwX2RhdGEo
ZCk7DQo+ICAgCWNvbnN0IHN0cnVjdCBzdG0zMl9leHRpX2JhbmsgKnN0bTMyX2JhbmsgPSBjaGlw
X2RhdGEtPnJlZ19iYW5rOw0KPiArCXN0cnVjdCBod3NwaW5sb2NrICpod2xvY2sgPSBjaGlwX2Rh
dGEtPmhvc3RfZGF0YS0+aHdsb2NrOw0KPiAgIAl2b2lkIF9faW9tZW0gKmJhc2UgPSBjaGlwX2Rh
dGEtPmhvc3RfZGF0YS0+YmFzZTsNCj4gICAJdTMyIHJ0c3IsIGZ0c3I7DQo+ICAgCWludCBlcnI7
DQo+ICAgDQo+ICAgCXJhd19zcGluX2xvY2soJmNoaXBfZGF0YS0+cmxvY2spOw0KPiAgIA0KPiAt
CWVyciA9IHN0bTMyX2V4dGlfaHdzcGluX2xvY2soY2hpcF9kYXRhKTsNCj4gLQlpZiAoZXJyKQ0K
PiAtCQlnb3RvIHVubG9jazsNCj4gKwlpZiAoaHdsb2NrKSB7DQo+ICsJCWVyciA9IGh3c3Bpbl9s
b2NrX3RpbWVvdXRfaW5fYXRvbWljKGh3bG9jaywgSFdTUE5MQ0tfVElNRU9VVCk7DQo+ICsJCWlm
IChlcnIpIHsNCj4gKwkJCXByX2VycigiJXMgY2FuJ3QgZ2V0IGh3c3BpbmxvY2sgKCVkKVxuIiwg
X19mdW5jX18sIGVycik7DQo+ICsJCQlnb3RvIHVubG9jazsNCj4gKwkJfQ0KPiArCX0NCj4gICAN
Cj4gICAJcnRzciA9IHJlYWRsX3JlbGF4ZWQoYmFzZSArIHN0bTMyX2JhbmstPnJ0c3Jfb2ZzdCk7
DQo+ICAgCWZ0c3IgPSByZWFkbF9yZWxheGVkKGJhc2UgKyBzdG0zMl9iYW5rLT5mdHNyX29mc3Qp
Ow0KPiBAQCAtNTI1LDcgKzQ5OSw4IEBAIHN0YXRpYyBpbnQgc3RtMzJfZXh0aV9oX3NldF90eXBl
KHN0cnVjdCBpcnFfZGF0YSAqZCwgdW5zaWduZWQgaW50IHR5cGUpDQo+ICAgCXdyaXRlbF9yZWxh
eGVkKGZ0c3IsIGJhc2UgKyBzdG0zMl9iYW5rLT5mdHNyX29mc3QpOw0KPiAgIA0KPiAgIHVuc3Bp
bmxvY2s6DQo+IC0Jc3RtMzJfZXh0aV9od3NwaW5fdW5sb2NrKGNoaXBfZGF0YSk7DQo+ICsJaWYg
KGh3bG9jaykNCj4gKwkJaHdzcGluX3VubG9ja19pbl9hdG9taWMoaHdsb2NrKTsNCj4gICB1bmxv
Y2s6DQo+ICAgCXJhd19zcGluX3VubG9jaygmY2hpcF9kYXRhLT5ybG9jayk7DQo+ICAg
