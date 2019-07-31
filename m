Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19E2C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 07:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7008C218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 07:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="dwXW2TJG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfGaHPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 03:15:44 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:20772 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725913AbfGaHPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 03:15:43 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6V77nIl002302;
        Wed, 31 Jul 2019 09:15:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=jPifBTLgBqCxGV4h1cRoINLa/YtV3LtiY9n5IGSEb0E=;
 b=dwXW2TJGkhxhA+NT+wv22LEUSW8qsl3plVpTSmEnPXa8B9vDFvYqU4llpcU2cBuaatqW
 iZsoKkcktlVw6ls+oXl6qRnHHzzdu7YF0Uznhyu4n5yr4Mhb//s1DsNi4ASuOPQpsQTx
 dbD0MO+U0mfd3rg1idFr1IGzddSfmX3y9U+mYlh3n08l7J74X6z0yPZruYANaoklYmOD
 maVxmc8yuogaO3nu9xYOHfdXDTVl74bvhh6gx1TZOLK7GN+CKe9tgZfvqEyzvyc72wh3
 zGQQoO4ZCArEgYJNiAqmeGtBBFDVTyBm2bW34RtG/tSU2Pc29y31goNl9l0QVZ6+/tYn Fg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2u0ccwpt0x-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 31 Jul 2019 09:15:26 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8E84231;
        Wed, 31 Jul 2019 07:15:25 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6CFEB1313;
        Wed, 31 Jul 2019 07:15:25 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 31 Jul
 2019 09:15:24 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1473.003; Wed, 31 Jul 2019 09:15:25 +0200
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     Olof Johansson <olof@lixom.net>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: ARM: multi_v7_defconfig: Enable SPI_STM32_QSPI support
Thread-Topic: ARM: multi_v7_defconfig: Enable SPI_STM32_QSPI support
Thread-Index: AQHVRhVB0n1KQugbLUyWfFzNn/AIwabjTQKAgADkvQA=
Date:   Wed, 31 Jul 2019 07:15:25 +0000
Message-ID: <fa683cde-04d1-0842-4082-b4b8b102e87a@st.com>
References: <20190729135505.15394-1-patrice.chotard@st.com>
 <CAOesGMg-3xt2qjjZ569pUE+d6tn7nz264AN9ARkBT_Ej4TFC2A@mail.gmail.com>
In-Reply-To: <CAOesGMg-3xt2qjjZ569pUE+d6tn7nz264AN9ARkBT_Ej4TFC2A@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <72C19610F7E9264599FB770633BD4475@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-31_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgT0xvZg0KDQpPbiA3LzMwLzE5IDc6MzYgUE0sIE9sb2YgSm9oYW5zc29uIHdyb3RlOg0KPiBI
aSBQYXRyaWNlLA0KPg0KPiBJZiB5b3UgY2Mgc29jQGtlcm5lbC5vcmcgb24gcGF0Y2hlcyB5b3Ug
d2FudCB1cyB0byBhcHBseSwgeW91J2xsIGdldA0KPiB0aGVtIGF1dG9tYXRpY2FsbHkgdHJhY2tl
ZCBieSBwYXRjaHdvcmsuDQoNClRoYW5rcyBmb3IgdGhlIGluZm9ybWF0aW9uLCBpIHdpbGwgcmVz
dWJtaXQgaXQuDQoNClBhdHJpY2UNCg0KDQo+DQo+DQo+IC1PbG9mDQo+DQo+IE9uIE1vbiwgSnVs
IDI5LCAyMDE5IGF0IDM6NTUgUE0gPHBhdHJpY2UuY2hvdGFyZEBzdC5jb20+IHdyb3RlOg0KPj4g
RnJvbTogUGF0cmljZSBDaG90YXJkIDxwYXRyaWNlLmNob3RhcmRAc3QuY29tPg0KPj4NCj4+IEVu
YWJsZSBzdXBwb3J0IGZvciBRU1BJIGJsb2NrIG9uIFNUTTMyIFNvQ3MuDQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogUGF0cmljZSBDaG90YXJkIDxwYXRyaWNlLmNob3RhcmRAc3QuY29tPg0KPj4gLS0t
DQo+PiAgYXJjaC9hcm0vY29uZmlncy9tdWx0aV92N19kZWZjb25maWcgfCAxICsNCj4+ICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0v
Y29uZmlncy9tdWx0aV92N19kZWZjb25maWcgYi9hcmNoL2FybS9jb25maWdzL211bHRpX3Y3X2Rl
ZmNvbmZpZw0KPj4gaW5kZXggNmE0MGJjMmVmMjcxLi43OGQxZDkzMjk4YWYgMTAwNjQ0DQo+PiAt
LS0gYS9hcmNoL2FybS9jb25maWdzL211bHRpX3Y3X2RlZmNvbmZpZw0KPj4gKysrIGIvYXJjaC9h
cm0vY29uZmlncy9tdWx0aV92N19kZWZjb25maWcNCj4+IEBAIC00MDMsNiArNDAzLDcgQEAgQ09O
RklHX1NQSV9TSF9NU0lPRj1tDQo+PiAgQ09ORklHX1NQSV9TSF9IU1BJPXkNCj4+ICBDT05GSUdf
U1BJX1NJUkY9eQ0KPj4gIENPTkZJR19TUElfU1RNMzI9bQ0KPj4gK0NPTkZJR19TUElfU1RNMzJf
UVNQST1tDQo+PiAgQ09ORklHX1NQSV9TVU40ST15DQo+PiAgQ09ORklHX1NQSV9TVU42ST15DQo+
PiAgQ09ORklHX1NQSV9URUdSQTExND15DQo+PiAtLQ0KPj4gMi4xNy4xDQo+Pg==
