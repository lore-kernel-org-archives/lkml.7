Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF18AC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F6C218C3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="gyYVWNrM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfDLI6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:58:55 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:45896 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727859AbfDLI6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:58:52 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3C8s5jg023816;
        Fri, 12 Apr 2019 10:58:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=FLypQh1vwDkAkn3+xUsvhtGOY+mccLHxajoz6YWhozw=;
 b=gyYVWNrMzhIRvS4K0YvTtSttqc5uoolfDqNlIXQxmKFG749QCnpp9yhF2yXJl20rCliN
 iV8gPw0UPfgZS8XYePI/Fb9OfZeG2xBgaXnZfBmLQ0xwUeF+mS/Hb9UljF3qMSrgToON
 4QiGBvsuSTbgfg6t72Djla81M4SMTLDiOgHwwKhTxZFIGfBsX3xu5ZsOdQoMN/hVsYCL
 RleAzzFxAbFM78/GTmgUQ+5fzFGuvzLzOqgMgkksD/Z1MOiTOYceIA324/D197Fnr3jd
 kjjZz7AX4e7nVg15t0wULKN2fOOFxrn9GIcYYJ2eU16hF26V+/oAKdtSVFs7o2woI+Uu Xg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rpr7x40aw-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 12 Apr 2019 10:58:43 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 90D4B14D;
        Fri, 12 Apr 2019 08:57:04 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 644D11464;
        Fri, 12 Apr 2019 08:57:04 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 12 Apr
 2019 10:57:04 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Fri, 12 Apr 2019 10:57:04 +0200
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     Wen Yang <wen.yang99@zte.com.cn>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "wang.yi59@zte.com.cn" <wang.yi59@zte.com.cn>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH 3/5] pinctrl: st: fix leaked of_node references
Thread-Topic: [PATCH 3/5] pinctrl: st: fix leaked of_node references
Thread-Index: AQHU8PUz9mCJWHkZl0Kqzp1bHR0BiqY4F/IA
Date:   Fri, 12 Apr 2019 08:57:03 +0000
Message-ID: <09d160d1-fb0a-1cdb-77af-aeeebfaa69a7@st.com>
References: <1555048943-39589-1-git-send-email-wen.yang99@zte.com.cn>
 <1555048943-39589-4-git-send-email-wen.yang99@zte.com.cn>
In-Reply-To: <1555048943-39589-4-git-send-email-wen.yang99@zte.com.cn>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D58A39C5252A4A43B53B1953D988B8BF@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-12_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgV2VuDQoNCk9uIDQvMTIvMTkgODowMiBBTSwgV2VuIFlhbmcgd3JvdGU6DQo+IFRoZSBjYWxs
IHRvIG9mX2dldF9jaGlsZF9ieV9uYW1lIHJldHVybnMgYSBub2RlIHBvaW50ZXIgd2l0aCByZWZj
b3VudA0KPiBpbmNyZW1lbnRlZCB0aHVzIGl0IG11c3QgYmUgZXhwbGljaXRseSBkZWNyZW1lbnRl
ZCBhZnRlciB0aGUgbGFzdA0KPiB1c2FnZS4NCj4gDQo+IERldGVjdGVkIGJ5IGNvY2NpbmVsbGUg
d2l0aCB0aGUgZm9sbG93aW5nIHdhcm5pbmdzOg0KPiAuL2RyaXZlcnMvcGluY3RybC9waW5jdHJs
LXN0LmM6MTE4ODozLTk6IEVSUk9SOiBtaXNzaW5nIG9mX25vZGVfcHV0OyBhY3F1aXJlZCBhIG5v
ZGUgcG9pbnRlciB3aXRoIHJlZmNvdW50IGluY3JlbWVudGVkIG9uIGxpbmUgMTE3NSwgYnV0IHdp
dGhvdXQgYSBjb3JyZXNwb25kaW5nIG9iamVjdCByZWxlYXNlIHdpdGhpbiB0aGlzIGZ1bmN0aW9u
Lg0KPiAuL2RyaXZlcnMvcGluY3RybC9waW5jdHJsLXN0LmM6MTE4ODozLTk6IEVSUk9SOiBtaXNz
aW5nIG9mX25vZGVfcHV0OyBhY3F1aXJlZCBhIG5vZGUgcG9pbnRlciB3aXRoIHJlZmNvdW50IGlu
Y3JlbWVudGVkIG9uIGxpbmUgMTE3NSwgYnV0IHdpdGhvdXQgYSBjb3JyZXNwb25kaW5nIG9iamVj
dCByZWxlYXNlIHdpdGhpbiB0aGlzIGZ1bmN0aW9uLg0KPiAuL2RyaXZlcnMvcGluY3RybC9waW5j
dHJsLXN0LmM6MTE5OToyLTg6IEVSUk9SOiBtaXNzaW5nIG9mX25vZGVfcHV0OyBhY3F1aXJlZCBh
IG5vZGUgcG9pbnRlciB3aXRoIHJlZmNvdW50IGluY3JlbWVudGVkIG9uIGxpbmUgMTE3NSwgYnV0
IHdpdGhvdXQgYSBjb3JyZXNwb25kaW5nIG9iamVjdCByZWxlYXNlIHdpdGhpbiB0aGlzIGZ1bmN0
aW9uLg0KPiAuL2RyaXZlcnMvcGluY3RybC9waW5jdHJsLXN0LmM6MTE5OToyLTg6IEVSUk9SOiBt
aXNzaW5nIG9mX25vZGVfcHV0OyBhY3F1aXJlZCBhIG5vZGUgcG9pbnRlciB3aXRoIHJlZmNvdW50
IGluY3JlbWVudGVkIG9uIGxpbmUgMTE3NSwgYnV0IHdpdGhvdXQgYSBjb3JyZXNwb25kaW5nIG9i
amVjdCByZWxlYXNlIHdpdGhpbiB0aGlzIGZ1bmN0aW9uLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
V2VuIFlhbmcgPHdlbi55YW5nOTlAenRlLmNvbS5jbj4NCj4gQ2M6IFBhdHJpY2UgQ2hvdGFyZCA8
cGF0cmljZS5jaG90YXJkQHN0LmNvbT4NCj4gQ2M6IExpbnVzIFdhbGxlaWogPGxpbnVzLndhbGxl
aWpAbGluYXJvLm9yZz4NCj4gQ2M6IGxpbnV4LWdwaW9Admdlci5rZXJuZWwub3JnDQo+IENjOiBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIChvcGVuIGxpc3QpDQo+IC0tLQ0KPiAgZHJpdmVy
cy9waW5jdHJsL3BpbmN0cmwtc3QuYyB8IDE1ICsrKysrKysrKystLS0tLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9waW5jdHJsL3BpbmN0cmwtc3QuYyBiL2RyaXZlcnMvcGluY3RybC9waW5jdHJs
LXN0LmMNCj4gaW5kZXggZTY2YWY5My4uMTk1YjQ0MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9w
aW5jdHJsL3BpbmN0cmwtc3QuYw0KPiArKysgYi9kcml2ZXJzL3BpbmN0cmwvcGluY3RybC1zdC5j
DQo+IEBAIC0xMTcwLDcgKzExNzAsNyBAQCBzdGF0aWMgaW50IHN0X3BjdGxfZHRfcGFyc2VfZ3Jv
dXBzKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAsDQo+ICAJc3RydWN0IHByb3BlcnR5ICpwcDsNCj4g
IAlzdHJ1Y3Qgc3RfcGluY29uZiAqY29uZjsNCj4gIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKnBpbnM7
DQo+IC0JaW50IGkgPSAwLCBucGlucyA9IDAsIG5yX3Byb3BzOw0KPiArCWludCBpID0gMCwgbnBp
bnMgPSAwLCBucl9wcm9wcywgcmV0ID0gMDsNCj4gIA0KPiAgCXBpbnMgPSBvZl9nZXRfY2hpbGRf
YnlfbmFtZShucCwgInN0LHBpbnMiKTsNCj4gIAlpZiAoIXBpbnMpDQo+IEBAIC0xMTg1LDcgKzEx
ODUsOCBAQCBzdGF0aWMgaW50IHN0X3BjdGxfZHRfcGFyc2VfZ3JvdXBzKHN0cnVjdCBkZXZpY2Vf
bm9kZSAqbnAsDQo+ICAJCQlucGlucysrOw0KPiAgCQl9IGVsc2Ugew0KPiAgCQkJcHJfd2Fybigi
SW52YWxpZCBzdCxwaW5zIGluICVwT0ZuIG5vZGVcbiIsIG5wKTsNCj4gLQkJCXJldHVybiAtRUlO
VkFMOw0KPiArCQkJcmV0ID0gLUVJTlZBTDsNCj4gKwkJCWdvdG8gb3V0X3B1dF9ub2RlOw0KPiAg
CQl9DQo+ICAJfQ0KPiAgDQo+IEBAIC0xMTk1LDggKzExOTYsMTAgQEAgc3RhdGljIGludCBzdF9w
Y3RsX2R0X3BhcnNlX2dyb3VwcyhzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wLA0KPiAgCWdycC0+cGlu
X2NvbmYgPSBkZXZtX2tjYWxsb2MoaW5mby0+ZGV2LA0KPiAgCQkJCQlucGlucywgc2l6ZW9mKCpj
b25mKSwgR0ZQX0tFUk5FTCk7DQo+ICANCj4gLQlpZiAoIWdycC0+cGlucyB8fCAhZ3JwLT5waW5f
Y29uZikNCj4gLQkJcmV0dXJuIC1FTk9NRU07DQo+ICsJaWYgKCFncnAtPnBpbnMgfHwgIWdycC0+
cGluX2NvbmYpIHsNCj4gKwkJcmV0ID0gLUVOT01FTTsNCj4gKwkJZ290byBvdXRfcHV0X25vZGU7
DQo+ICsJfQ0KPiAgDQo+ICAJLyogPGJhbmsgb2Zmc2V0IG11eCBkaXJlY3Rpb24gcnRfdHlwZSBy
dF9kZWxheSBydF9jbGs+ICovDQo+ICAJZm9yX2VhY2hfcHJvcGVydHlfb2Zfbm9kZShwaW5zLCBw
cCkgew0KPiBAQCAtMTIyOSw5ICsxMjMyLDExIEBAIHN0YXRpYyBpbnQgc3RfcGN0bF9kdF9wYXJz
ZV9ncm91cHMoc3RydWN0IGRldmljZV9ub2RlICpucCwNCj4gIAkJfQ0KPiAgCQlpKys7DQo+ICAJ
fQ0KPiArDQo+ICtvdXRfcHV0X25vZGU6DQo+ICAJb2Zfbm9kZV9wdXQocGlucyk7DQo+ICANCj4g
LQlyZXR1cm4gMDsNCj4gKwlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgaW50IHN0
X3BjdGxfcGFyc2VfZnVuY3Rpb25zKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAsDQo+IA0KDQpSZXZp
ZXdlZC1ieTogUGF0cmljZSBDaG90YXJkIDxwYXRyaWNlLmNob3RhcmRAc3QuY29tPg0KDQpUaGFu
a3M=
