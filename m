Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8707C04AB4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D32206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="bL/ofrGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfEMJHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:07:43 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:63598 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728495AbfEMJHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:07:41 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4D92ULC008574;
        Mon, 13 May 2019 11:07:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=6oiqA8T+mnKQvbNWYLWPTsV6nFYs+iYkXtXuj8wduJA=;
 b=bL/ofrGYbBQtinEd3E54RDqD7WMSd65lpyuYYdXN4Ot6jm+kb7RsnFesDdxg44x7WUu4
 JK0WxLoa6DvV4nt9YtWkZDyo+4efixHV1/vC/VF5kaM/LaD9DhKoyri13JoJ/JcDyZKj
 m0RFC+hGHq0iSGauddBUnxDJfaxk/8kEUl3Rc9Ww3igGdzoEnMENKMo9FDknNkZg0tv2
 eFkbvB7jwsch7UMecRBr6lZjiXJMHuKKKoIiQ3bCMYjdg4loKti/n9Ra9BcPmuYihPyl
 zLWp15Cv8kA9AVS7QN0fAzFsgSpDUruWXoDbHLxjq9pR8TqqzA664I6Ms7nWBbxdcJK8 2w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2sdkuyhyt8-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 13 May 2019 11:07:29 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0B64A31;
        Mon, 13 May 2019 09:07:29 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D78911623;
        Mon, 13 May 2019 09:07:28 +0000 (GMT)
Received: from SFHDAG5NODE3.st.com (10.75.127.15) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 13 May
 2019 11:07:28 +0200
Received: from SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47]) by
 SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47%20]) with mapi id
 15.00.1347.000; Mon, 13 May 2019 11:07:28 +0200
From:   Fabien DESSENNE <fabien.dessenne@st.com>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Fabien DESSENNE <fabien.dessenne@st.com>
Subject: Re: [PATCH] hwspinlock: stm32: implement the relax() ops
Thread-Topic: [PATCH] hwspinlock: stm32: implement the relax() ops
Thread-Index: AQHU1PxebOxSL1urhkiJOta3IjoEXqYBnh0AgGds9YA=
Date:   Mon, 13 May 2019 09:07:28 +0000
Message-ID: <b05fff00-2dd7-75d7-e8fe-de004b0f20da@st.com>
References: <1551973336-23048-1-git-send-email-fabien.dessenne@st.com>
 <CA+M3ks6r_OWvit3OK0yqDDgfnVyyxPoo5aO2n9tRhhoS4=u4XQ@mail.gmail.com>
In-Reply-To: <CA+M3ks6r_OWvit3OK0yqDDgfnVyyxPoo5aO2n9tRhhoS4=u4XQ@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3014D1D5A3EB094197DF17DF3BAA24C2@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-13_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkNCg0KDQpBbnkgZnVydGhlciBjb21tZW50cz8NCg0KDQpGYWJpZW4NCg0KT24gMDgvMDMvMjAx
OSAxOjQyIFBNLCBCZW5qYW1pbiBHYWlnbmFyZCB3cm90ZToNCj4gTGUgamV1LiA3IG1hcnMgMjAx
OSDDoCAxNjo0MiwgRmFiaWVuIERlc3Nlbm5lIDxmYWJpZW4uZGVzc2VubmVAc3QuY29tPiBhIMOp
Y3JpdCA6DQo+PiBJbXBsZW1lbnQgdGhpcyBvcHRpb25hbCBvcHMsIGNhbGxlZCBieSBod3NwaW5s
b2NrIGNvcmUgd2hpbGUgc3Bpbm5pbmcgb24NCj4+IGEgbG9jaywgYmV0d2VlbiB0d28gc3VjY2Vz
c2l2ZSBpbnZvY2F0aW9ucyBvZiB0cnlsb2NrKCkuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogRmFi
aWVuIERlc3Nlbm5lIDxmYWJpZW4uZGVzc2VubmVAc3QuY29tPg0KPiBSZXZpZXdlZC1ieTogQmVu
amFtaW4gR2FpZ25hcmQgPGJlbmphbWluLmdhaWduYXJkQHN0LmNvbT4NCj4NCj4+IC0tLQ0KPj4g
ICBkcml2ZXJzL2h3c3BpbmxvY2svc3RtMzJfaHdzcGlubG9jay5jIHwgNyArKysrKysrDQo+PiAg
IDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9od3NwaW5sb2NrL3N0bTMyX2h3c3BpbmxvY2suYyBiL2RyaXZlcnMvaHdzcGlubG9jay9z
dG0zMl9od3NwaW5sb2NrLmMNCj4+IGluZGV4IDQ0MTgzOTIuLmM4ZWFjZjQgMTAwNjQ0DQo+PiAt
LS0gYS9kcml2ZXJzL2h3c3BpbmxvY2svc3RtMzJfaHdzcGlubG9jay5jDQo+PiArKysgYi9kcml2
ZXJzL2h3c3BpbmxvY2svc3RtMzJfaHdzcGlubG9jay5jDQo+PiBAQCAtNSw2ICs1LDcgQEANCj4+
ICAgICovDQo+Pg0KPj4gICAjaW5jbHVkZSA8bGludXgvY2xrLmg+DQo+PiArI2luY2x1ZGUgPGxp
bnV4L2RlbGF5Lmg+DQo+PiAgICNpbmNsdWRlIDxsaW51eC9od3NwaW5sb2NrLmg+DQo+PiAgICNp
bmNsdWRlIDxsaW51eC9pby5oPg0KPj4gICAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+DQo+PiBA
QCAtNDIsOSArNDMsMTUgQEAgc3RhdGljIHZvaWQgc3RtMzJfaHdzcGlubG9ja191bmxvY2soc3Ry
dWN0IGh3c3BpbmxvY2sgKmxvY2spDQo+PiAgICAgICAgICB3cml0ZWwoU1RNMzJfTVVURVhfQ09S
RUlELCBsb2NrX2FkZHIpOw0KPj4gICB9DQo+Pg0KPj4gK3N0YXRpYyB2b2lkIHN0bTMyX2h3c3Bp
bmxvY2tfcmVsYXgoc3RydWN0IGh3c3BpbmxvY2sgKmxvY2spDQo+PiArew0KPj4gKyAgICAgICBu
ZGVsYXkoNTApOw0KPj4gK30NCj4+ICsNCj4+ICAgc3RhdGljIGNvbnN0IHN0cnVjdCBod3NwaW5s
b2NrX29wcyBzdG0zMl9od3NwaW5sb2NrX29wcyA9IHsNCj4+ICAgICAgICAgIC50cnlsb2NrICAg
ICAgICA9IHN0bTMyX2h3c3BpbmxvY2tfdHJ5bG9jaywNCj4+ICAgICAgICAgIC51bmxvY2sgICAg
ICAgICA9IHN0bTMyX2h3c3BpbmxvY2tfdW5sb2NrLA0KPj4gKyAgICAgICAucmVsYXggICAgICAg
ICAgPSBzdG0zMl9od3NwaW5sb2NrX3JlbGF4LA0KPj4gICB9Ow0KPj4NCj4+ICAgc3RhdGljIGlu
dCBzdG0zMl9od3NwaW5sb2NrX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
PiAtLQ0KPj4gMi43LjQNCj4+DQo+Pg0KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18NCj4+IGxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0DQo+PiBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4+IGh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbA0KPg0KPg==
