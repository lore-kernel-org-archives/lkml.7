Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DA8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29852086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfDAJXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 05:23:04 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:18146 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725821AbfDAJXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 05:23:04 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x319LEIs016235;
        Mon, 1 Apr 2019 11:22:53 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rhy3x9p2x-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 01 Apr 2019 11:22:53 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8BF1631;
        Mon,  1 Apr 2019 09:22:52 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 66E8D2406;
        Mon,  1 Apr 2019 09:22:52 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 1 Apr
 2019 11:22:52 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Mon, 1 Apr 2019 11:22:52 +0200
From:   Philippe CORNU <philippe.cornu@st.com>
To:     Yannick FERTRE <yannick.fertre@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre TORGUE" <alexandre.torgue@st.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/stm: ltdc: update planes at next vblank to avoid
 partial refresh
Thread-Topic: [PATCH] drm/stm: ltdc: update planes at next vblank to avoid
 partial refresh
Thread-Index: AQHU6FwBDlF3Vgj9nUmy7q9cRVGHLqYm5rIA
Date:   Mon, 1 Apr 2019 09:22:51 +0000
Message-ID: <7ff86999-02e5-ef48-221c-a5e0e61eb2fd@st.com>
References: <1554103457-29595-1-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1554103457-29595-1-git-send-email-yannick.fertre@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="utf-8"
Content-ID: <144A6A0135F1E44F81A04777654484BE@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-01_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBZYW5uaWNrLA0KVGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLCB3b3JrcyBmaW5lLA0KDQpB
Y2tlZC1ieTogUGhpbGlwcGUgQ29ybnUgPHBoaWxpcHBlLmNvcm51QHN0LmNvbT4NCg0KUGhpbGlw
cGUgOi0pDQoNCk9uIDQvMS8xOSA5OjI0IEFNLCBZYW5uaWNrIEZlcnRyw6kgd3JvdGU6DQo+IFBs
YW5lIHVwZGF0ZXMgbXVzdCBiZSBzeW5jaHJvbml6ZWQgb24gdmJsYW5rIHdpdGggdGhlIHNoYWRv
dyByZWdpc3RlciBtZWNoYW5pc20NCj4gdG8gYXZvaWQgcGFydGlhbCByZWZyZXNoIG9uIHNjcmVl
bi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFlhbm5pY2sgRmVydHLDqSA8eWFubmljay5mZXJ0cmVA
c3QuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vc3RtL2x0ZGMuYyB8IDQgKystLQ0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3N0bS9sdGRjLmMgYi9kcml2ZXJzL2dwdS9k
cm0vc3RtL2x0ZGMuYw0KPiBpbmRleCBiMTc0MWE5Li5jMmQwODAwIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vc3RtL2x0ZGMuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vc3RtL2x0
ZGMuYw0KPiBAQCAtNDI2LDggKzQyNiw4IEBAIHN0YXRpYyB2b2lkIGx0ZGNfY3J0Y19hdG9taWNf
ZW5hYmxlKHN0cnVjdCBkcm1fY3J0YyAqY3J0YywNCj4gICAJLyogRW5hYmxlIElSUSAqLw0KPiAg
IAlyZWdfc2V0KGxkZXYtPnJlZ3MsIExURENfSUVSLCBJRVJfUlJJRSB8IElFUl9GVUlFIHwgSUVS
X1RFUlJJRSk7DQo+ICAgDQo+IC0JLyogSW1tZWRpYXRlbHkgY29tbWl0IHRoZSBwbGFuZXMgKi8N
Cj4gLQlyZWdfc2V0KGxkZXYtPnJlZ3MsIExURENfU1JDUiwgU1JDUl9JTVIpOw0KPiArCS8qIENv
bW1pdCBzaGFkb3cgcmVnaXN0ZXJzID0gdXBkYXRlIHBsYW5lcyBhdCBuZXh0IHZibGFuayAqLw0K
PiArCXJlZ19zZXQobGRldi0+cmVncywgTFREQ19TUkNSLCBTUkNSX1ZCUik7DQo+ICAgDQo+ICAg
CS8qIEVuYWJsZSBMVERDICovDQo+ICAgCXJlZ19zZXQobGRldi0+cmVncywgTFREQ19HQ1IsIEdD
Ul9MVERDRU4pOw0KPiA=
