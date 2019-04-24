Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D52EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC0B218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="jwhQig4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733001AbfDXOwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:52:45 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54886 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732972AbfDXOwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:52:32 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OEpfHp014817;
        Wed, 24 Apr 2019 16:52:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=bgQxOGyNh/KQn11Y3ySkJgKTQZZg3JBZGVmCcVIASZk=;
 b=jwhQig4bD+sHIea4YALQAROAOm8Ohu/gKfaUjBzxrieTy4ucqDYODHgSfxIHsUi1nKsY
 bntViK1oRIz/7bpw3Sy7cV3lwH1u7e7SkFbR/87zlTEDAZSp4GgBAH9QfYaMRfBM+Uou
 9OnucmFQOgaDDpx1vvBVV2yvZO6FoZDoydizBqulj/W3H5c5mgEHl4Z1kp30rs94jdJr
 nI5kLbJq/UactpbAaCDodvGmUh5Qz1Jtb+vtXAqKG2lzWIjhPRWA3tIS0myf1pjEptns
 VP2woRq++rqZjA595kWOInFbPSH34WsIJNh949l9rSsHmST8QGNEjOlXakrd0FwTzcpP 5w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rytad7878-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Apr 2019 16:52:16 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1C18F31;
        Wed, 24 Apr 2019 14:52:16 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node1.st.com [10.75.127.13])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EFDFD2881;
        Wed, 24 Apr 2019 14:52:15 +0000 (GMT)
Received: from SFHDAG3NODE2.st.com (10.75.127.8) by SFHDAG5NODE1.st.com
 (10.75.127.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 24 Apr
 2019 16:52:15 +0200
Received: from SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96]) by
 SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96%20]) with mapi id
 15.00.1347.000; Wed, 24 Apr 2019 16:52:16 +0200
From:   Amelie DELAUNAY <amelie.delaunay@st.com>
To:     Fabien DESSENNE <fabien.dessenne@st.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: stm32: return the get_irq error
Thread-Topic: [PATCH] spi: stm32: return the get_irq error
Thread-Index: AQHU+pqvA0yJgg8S5EmBKq89hP7HV6ZLQ+CA
Date:   Wed, 24 Apr 2019 14:52:16 +0000
Message-ID: <6c11793b-bcfc-e069-56db-7e963d22dc6e@st.com>
References: <1556109524-21874-1-git-send-email-fabien.dessenne@st.com>
In-Reply-To: <1556109524-21874-1-git-send-email-fabien.dessenne@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A12641FDC7F83E418048CC3BBE567653@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yNC8xOSAyOjM4IFBNLCBGYWJpZW4gRGVzc2VubmUgd3JvdGU6DQo+IER1cmluZyBwcm9i
ZSwgcmV0dXJuIHRoZSAiZ2V0X2lycSIgZXJyb3IgdmFsdWUgaW5zdGVhZCBvZiAtRU5PRU5ULiBU
aGlzDQo+IGFsbG93cyB0aGUgZHJpdmVyIHRvIGJlIGRlZmVyIHByb2JlZCBpZiBuZWVkZWQuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBGYWJpZW4gRGVzc2VubmUgPGZhYmllbi5kZXNzZW5uZUBzdC5j
b20+DQoNCkFja2VkLWJ5OiBBbWVsaWUgRGVsYXVuYXkgPGFtZWxpZS5kZWxhdW5heUBzdC5jb20+
DQoNCj4gLS0tDQo+ICAgZHJpdmVycy9zcGkvc3BpLXN0bTMyLmMgfCA1ICsrKy0tDQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3NwaS9zcGktc3RtMzIuYyBiL2RyaXZlcnMvc3BpL3NwaS1zdG0zMi5j
DQo+IGluZGV4IDQxODZlZDIuLmIyMjJjZTggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc3BpL3Nw
aS1zdG0zMi5jDQo+ICsrKyBiL2RyaXZlcnMvc3BpL3NwaS1zdG0zMi5jDQo+IEBAIC0xODM5LDgg
KzE4MzksOSBAQCBzdGF0aWMgaW50IHN0bTMyX3NwaV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KPiAgIA0KPiAgIAlzcGktPmlycSA9IHBsYXRmb3JtX2dldF9pcnEocGRldiwg
MCk7DQo+ICAgCWlmIChzcGktPmlycSA8PSAwKSB7DQo+IC0JCWRldl9lcnIoJnBkZXYtPmRldiwg
Im5vIGlycTogJWRcbiIsIHNwaS0+aXJxKTsNCj4gLQkJcmV0ID0gLUVOT0VOVDsNCj4gKwkJcmV0
ID0gc3BpLT5pcnE7DQo+ICsJCWlmIChyZXQgIT0gLUVQUk9CRV9ERUZFUikNCj4gKwkJCWRldl9l
cnIoJnBkZXYtPmRldiwgImZhaWxlZCB0byBnZXQgaXJxOiAlZFxuIiwgcmV0KTsNCj4gICAJCWdv
dG8gZXJyX21hc3Rlcl9wdXQ7DQo+ICAgCX0NCj4gICAJcmV0ID0gZGV2bV9yZXF1ZXN0X3RocmVh
ZGVkX2lycSgmcGRldi0+ZGV2LCBzcGktPmlycSwNCj4g
