Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9510C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACEA92173E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="CIM3oU33"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbfIBIpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:45:40 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:8214 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730310AbfIBIpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:45:40 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x828f0wk004309;
        Mon, 2 Sep 2019 10:45:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=GS6p14phASWxCZ4PtGrDKAo6LRyf7Ljc9Xi7ApKfmMg=;
 b=CIM3oU33MmbYDaWi6BsVinIjyzgVO+pktbhR6/MQP88YQWV+BP4IHIldpKif6i47v0Yw
 tdfzE5ss4NObBkcafR88tYGO/KbeKj7DgzFyr5bpeE2O7YX5mpyJosPiZtfU8XIOV0PZ
 oLHZ1djsu9XcnFnxIejLmj/OdKaIakCoSPLt9y1wUlroStPWaUATBNw9t61nM6QZZLsv
 dSQimWmzWRGjYciu5+cDQtqSaI9KeMKVwl1+3Wzec/zxenjKgtbCHCu+6tvPDd/x86ws
 zn24DK+NxBJrBoDF1pSMqrAhLs90i4cow7ZYyBnOmRUKTg7DuqTSzT4T8K7GIb5Iya5v 7A== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx07-00178001.pphosted.com with ESMTP id 2uqenuudhf-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 02 Sep 2019 10:45:23 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7DB8955;
        Mon,  2 Sep 2019 08:45:19 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C232E2C38B9;
        Mon,  2 Sep 2019 10:45:18 +0200 (CEST)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE3.st.com
 (10.75.127.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 2 Sep
 2019 10:45:18 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1473.003; Mon, 2 Sep 2019 10:45:18 +0200
From:   Philippe CORNU <philippe.cornu@st.com>
To:     Yannick FERTRE <yannick.fertre@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Fabrice GASNIER <fabrice.gasnier@st.com>
Subject: Re: [PATCH] ARM: dts: stm32: move ltdc pinctrl on stm32mp157a dk1
 board
Thread-Topic: [PATCH] ARM: dts: stm32: move ltdc pinctrl on stm32mp157a dk1
 board
Thread-Index: AQHVSTvVGIXip1PqEkulX36vwruXGKcYIXgA
Date:   Mon, 2 Sep 2019 08:45:18 +0000
Message-ID: <50695b37-df51-08d6-a11e-99f9349aa481@st.com>
References: <1564754931-13861-1-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1564754931-13861-1-git-send-email-yannick.fertre@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EEAD06A52162824F94647D53ADBE7BB7@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-02_03:2019-08-29,2019-09-02 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgWWFubmljaywNCg0KT24gOC8yLzE5IDQ6MDggUE0sIFlhbm5pY2sgRmVydHLDqSB3cm90ZToN
Cj4gVGhlIGx0ZGMgcGluY3RybCBtdXN0IGJlIGluIHRoZSBkaXNwbGF5IGNvbnRyb2xsZXIgbm9k
ZSBhbmQNCj4gbm90IGluIHRoZSBwZXJpcGhlcmFsIG5vZGUgKGhkbWkgYnJpZGdlKS4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IFlhbm5pY2sgRmVydHLDqSA8eWFubmljay5mZXJ0cmVAc3QuY29tPg0K
PiAtLS0NCj4gICBhcmNoL2FybS9ib290L2R0cy9zdG0zMm1wMTU3YS1kazEuZHRzIHwgNiArKyst
LS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3N0bTMybXAxNTdhLWRrMS5kdHMg
Yi9hcmNoL2FybS9ib290L2R0cy9zdG0zMm1wMTU3YS1kazEuZHRzDQo+IGluZGV4IGYzZjBlMzcu
LjEyODVjZmMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL3N0bTMybXAxNTdhLWRr
MS5kdHMNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvc3RtMzJtcDE1N2EtZGsxLmR0cw0KPiBA
QCAtOTksOSArOTksNiBAQA0KPiAgIAkJcmVzZXQtZ3Bpb3MgPSA8JmdwaW9hIDEwIEdQSU9fQUNU
SVZFX0xPVz47DQo+ICAgCQlpbnRlcnJ1cHRzID0gPDEgSVJRX1RZUEVfRURHRV9GQUxMSU5HPjsN
Cj4gICAJCWludGVycnVwdC1wYXJlbnQgPSA8JmdwaW9nPjsNCj4gLQkJcGluY3RybC1uYW1lcyA9
ICJkZWZhdWx0IiwgInNsZWVwIjsNCj4gLQkJcGluY3RybC0wID0gPCZsdGRjX3BpbnNfYT47DQo+
IC0JCXBpbmN0cmwtMSA9IDwmbHRkY19waW5zX3NsZWVwX2E+Ow0KPiAgIAkJc3RhdHVzID0gIm9r
YXkiOw0KPiAgIA0KPiAgIAkJcG9ydHMgew0KPiBAQCAtMjc2LDYgKzI3Myw5IEBADQo+ICAgfTsN
Cj4gICANCj4gICAmbHRkYyB7DQo+ICsJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IiwgInNsZWVw
IjsNCj4gKwlwaW5jdHJsLTAgPSA8Jmx0ZGNfcGluc19hPjsNCj4gKwlwaW5jdHJsLTEgPSA8Jmx0
ZGNfcGluc19zbGVlcF9hPjsNCg0KUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIENvcm51IDxwaGlsaXBw
ZS5jb3JudUBzdC5jb20+DQoNClRoYW5rcw0KUGhpbGlwcGUgOikNCg0KPiAgIAlzdGF0dXMgPSAi
b2theSI7DQo+ICAgDQo+ICAgCXBvcnQgew0KPiA=
