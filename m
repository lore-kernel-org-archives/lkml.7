Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94714C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66FFB2067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="fzR8DeWw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387650AbgAIQ32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:29:28 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:18266 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728840AbgAIQ32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:29:28 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 009GNlAk029839;
        Thu, 9 Jan 2020 17:29:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=mj3oomnaQW1aTuCmeUXBmrLNWIkFfCe+0/ymmE7PGmQ=;
 b=fzR8DeWwvOYwQjHl2pSjOiOcAojj/0/cY/aKba0cQI8lV53aV/g3GMWrVgqT5uuAIURe
 HX/XZodLN+vs4Iz3MvFxlLT7deKPSUtE7zGDv2rQqssijq+enX6PhlMhjYFnsnZqt9/D
 lj+LCT8JDSI+qx9jTwWMy12Mh0CVh8+XTPygL0LzPi1Okrk1YsvuuOerepA7wznxdvjt
 rQ2KFBLTAmmTw38cCua52fQ1jUacA7jJ1LWa54K9QrNJmHp1qhkd/K0IRTT9Exxz1Vjb
 teJgL3+B1Yl/z3LKWYIu5BBcOVfK7bNBbaSsMpFHQAwWCyDtGg+lD9JyEY/p/XOtb10d VQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xakur2pjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jan 2020 17:29:11 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7DE54100034;
        Thu,  9 Jan 2020 17:29:10 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6DF65221FD3;
        Thu,  9 Jan 2020 17:29:10 +0100 (CET)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 9 Jan
 2020 17:29:10 +0100
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Thu, 9 Jan 2020 17:29:10 +0100
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
CC:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/fb-cma-helpers: Fix include issue
Thread-Topic: [PATCH] drm/fb-cma-helpers: Fix include issue
Thread-Index: AQHVnsgyaldclqcEK0uZPEQpOdu6i6eopPeAgDogi4A=
Date:   Thu, 9 Jan 2020 16:29:09 +0000
Message-ID: <17fdbb6a-493d-d47c-9acf-3c79032359b0@st.com>
References: <20191119105753.32363-1-benjamin.gaignard@st.com>
 <CA+M3ks7C+_B+4Jxy+55bFoWct7j=WseoPKxxh7KLOZ0LhEUL7Q@mail.gmail.com>
In-Reply-To: <CA+M3ks7C+_B+4Jxy+55bFoWct7j=WseoPKxxh7KLOZ0LhEUL7Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DD87B409577024EAC9ACC88B972DAB7@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_03:2020-01-09,2020-01-09 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMi8zLzE5IDU6NDkgUE0sIEJlbmphbWluIEdhaWduYXJkIHdyb3RlOg0KPiBMZSBtZXIu
IDIwIG5vdi4gMjAxOSDDoCAwMDoyOCwgQmVuamFtaW4gR2FpZ25hcmQNCj4gPGJlbmphbWluLmdh
aWduYXJkQHN0LmNvbT4gYSDDqWNyaXQgOg0KPj4gRXhwb3J0ZWQgZnVuY3Rpb25zIHByb3RvdHlw
ZXMgYXJlIG1pc3NpbmcgaW4gZHJtX2ZiX2NtYV9oZWxwZXIuYw0KPj4gSW5jbHVkZSBkcm1fZmJf
Y21hX2hlbHBlciB0byBmaXggdGhhdCBpc3N1ZS4NCj4+DQo+IEdlbnRsZSBwaW5nIHRvIHJldmll
d2Vycy4NCj4gVGhhbmtzLA0KPiBCZW5qYW1pbg0KDQpJIGtub3cgdGhhdCByZW1vdmluZyB3YXJu
aW5ncyBpcyBub3QgYSBzZXh5IHRhc2ssIGJ1dCByZXZpZXdlcnMgYXJlIHdlbGNvbWUuDQoNClRo
YW5rcywNCg0KQmVuamFtaW4NCg0KPg0KPj4gU2lnbmVkLW9mZi1ieTogQmVuamFtaW4gR2FpZ25h
cmQgPGJlbmphbWluLmdhaWduYXJkQHN0LmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL2dwdS9k
cm0vZHJtX2ZiX2NtYV9oZWxwZXIuYyB8IDEgKw0KPj4gICBpbmNsdWRlL2RybS9kcm1fZmJfY21h
X2hlbHBlci5oICAgICB8IDIgKysNCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2RybV9mYl9jbWFfaGVscGVy
LmMgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2ZiX2NtYV9oZWxwZXIuYw0KPj4gaW5kZXggYzBiMGY2
MDNhZjYzLi45ODAxYzAzMzNlY2EgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vZHJt
X2ZiX2NtYV9oZWxwZXIuYw0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2RybV9mYl9jbWFfaGVs
cGVyLmMNCj4+IEBAIC05LDYgKzksNyBAQA0KPj4gICAgKiAgQ29weXJpZ2h0IChDKSAyMDEyIFJl
ZCBIYXQNCj4+ICAgICovDQo+Pg0KPj4gKyNpbmNsdWRlIDxkcm0vZHJtX2ZiX2NtYV9oZWxwZXIu
aD4NCj4+ICAgI2luY2x1ZGUgPGRybS9kcm1fZm91cmNjLmg+DQo+PiAgICNpbmNsdWRlIDxkcm0v
ZHJtX2ZyYW1lYnVmZmVyLmg+DQo+PiAgICNpbmNsdWRlIDxkcm0vZHJtX2dlbV9jbWFfaGVscGVy
Lmg+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kcm0vZHJtX2ZiX2NtYV9oZWxwZXIuaCBiL2lu
Y2x1ZGUvZHJtL2RybV9mYl9jbWFfaGVscGVyLmgNCj4+IGluZGV4IDRiZWNiMDk5NzVhNC4uNzk1
YWVhMWQwYTI1IDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9kcm0vZHJtX2ZiX2NtYV9oZWxwZXIu
aA0KPj4gKysrIGIvaW5jbHVkZS9kcm0vZHJtX2ZiX2NtYV9oZWxwZXIuaA0KPj4gQEAgLTIsNiAr
Miw4IEBADQo+PiAgICNpZm5kZWYgX19EUk1fRkJfQ01BX0hFTFBFUl9IX18NCj4+ICAgI2RlZmlu
ZSBfX0RSTV9GQl9DTUFfSEVMUEVSX0hfXw0KPj4NCj4+ICsjaW5jbHVkZSA8bGludXgvdHlwZXMu
aD4NCj4+ICsNCj4+ICAgc3RydWN0IGRybV9mcmFtZWJ1ZmZlcjsNCj4+ICAgc3RydWN0IGRybV9w
bGFuZV9zdGF0ZTsNCj4+DQo+PiAtLQ0KPj4gMi4xNS4wDQo+Pg0KPj4gX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4+IGRyaS1kZXZlbCBtYWlsaW5nIGxp
c3QNCj4+IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4+IGh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
