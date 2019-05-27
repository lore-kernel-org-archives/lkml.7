Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0021CC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2492146F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="da8q5f/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfE0M2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 08:28:00 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:25264 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbfE0M17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:27:59 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4RCKsX7019436;
        Mon, 27 May 2019 14:27:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=hK01vThxixP1NwoQSa3cr+03QYzdY/PdiNnc3e3F6Mc=;
 b=da8q5f/hZrKd7eaf/m6ng7ojS7/YMNLZmJZO6NaFRVme9aLxDV6aIXRharB5WHRNMOye
 94r8RGFdV63Ant/ZkQt17zSvUn+1vdPFelhRehynqvK711DieG+8PFBsR77eMLrSXCRY
 vZ0kDVmCqS1jfoGC3ctuiMmwH9izg3tlgnQP1JvotGdx6OuUw9lY6Z1MH8KzvH4iKe5n
 PSO1pY0RQ2qLY5bS4E3uSv4YDIMR2PDl4f9sT3pmqCAK8VsN9pQT+X7cU9lKVHbIy8Zz
 ZzMEbDCeB1CiO+dMxTYoHsTGDwB891xIfBsuqK0mKbN194WtS/FR9Y2m+GPIYNin4lou 4g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2spu602xsw-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 27 May 2019 14:27:45 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C590F38;
        Mon, 27 May 2019 12:27:44 +0000 (GMT)
Received: from Webmail-eu.st.com (gpxdag3node5.st.com [10.75.127.72])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5108A2A63;
        Mon, 27 May 2019 12:27:44 +0000 (GMT)
Received: from GPXDAG6NODE6.st.com (10.75.127.82) by GPXDAG3NODE5.st.com
 (10.75.127.72) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 27 May
 2019 14:27:43 +0200
Received: from GPXDAG6NODE6.st.com ([fe80::57f:5f53:243f:cb11]) by
 GPXDAG6NODE6.st.com ([fe80::57f:5f53:243f:cb11%19]) with mapi id
 15.00.1473.003; Mon, 27 May 2019 14:27:44 +0200
From:   Philippe CORNU <philippe.cornu@st.com>
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Yannick FERTRE <yannick.fertre@st.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Alexandre TORGUE <alexandre.torgue@st.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: Re: [PATCH] drm/stm: ltdc: restore calls to clk_{enable/disable}
Thread-Topic: [PATCH] drm/stm: ltdc: restore calls to clk_{enable/disable}
Thread-Index: AQHVFIODRdknuk/3QUK12OrUD+2oRaZ+xJoA
Date:   Mon, 27 May 2019 12:27:43 +0000
Message-ID: <1e4c4cbf-869e-8b6a-a1d6-cc7dccb2515a@st.com>
References: <20190527115830.15836-1-benjamin.gaignard@st.com>
In-Reply-To: <20190527115830.15836-1-benjamin.gaignard@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CE08C584D2B4941A38EAA7DF3901AFF@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-27_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmVuamFtaW4sDQoNCk1hbnkgdGhhbmtzIGZvciB0aGlzIGZpeCAoYW5kIG1vcmUgZ2VuZXJh
bGx5IGZvciBwdXNoaW5nIFNUTSBwYXRjaGVzIG9uIA0KbWlzYyA6LSkNCg0KQWNrZWQtYnk6IFBo
aWxpcHBlIENvcm51IDxwaGlsaXBwZS5jb3JudUBzdC5jb20+DQoNClBoaWxpcHBlIDotKQ0KDQpP
biA1LzI3LzE5IDE6NTggUE0sIEJlbmphbWluIEdhaWduYXJkIHdyb3RlOg0KPiBGcm9tOiBCZW5q
YW1pbiBHYWlnbmFyZCA8YmVuamFtaW4uZ2FpZ25hcmRAbGluYXJvLm9yZz4NCj4gDQo+IFJlc3Rv
cmUgY2FsbHMgdG8gY2xrX3tlbmFibGUvZGlzYWJsZX0gZGVsZXRlZCBhZnRlciBhcHBseWluZyB0
aGUgd3JvbmcNCj4gdmVyc2lvbiBvZiB0aGUgcGF0Y2gNCj4gDQo+IEZpeGVzOiBmZDY5MDVmY2E0
ZjAgKCJkcm0vc3RtOiBsdGRjOiByZW1vdmUgY2xrX3JvdW5kX3JhdGUgY29tbWVudCIpDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBCZW5qYW1pbiBHYWlnbmFyZCA8YmVuamFtaW4uZ2FpZ25hcmRAbGlu
YXJvLm9yZz4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL3N0bS9sdGRjLmMgfCAyICsrDQo+
ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9zdG0vbHRkYy5jIGIvZHJpdmVycy9ncHUvZHJtL3N0bS9sdGRjLmMNCj4g
aW5kZXggYWUyYWFmMmE2MmVlLi5hYzI5ODkwZWRlYjYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9zdG0vbHRkYy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9zdG0vbHRkYy5jDQo+
IEBAIC01MDcsMTAgKzUwNywxMiBAQCBzdGF0aWMgYm9vbCBsdGRjX2NydGNfbW9kZV9maXh1cChz
dHJ1Y3QgZHJtX2NydGMgKmNydGMsDQo+ICAgCXN0cnVjdCBsdGRjX2RldmljZSAqbGRldiA9IGNy
dGNfdG9fbHRkYyhjcnRjKTsNCj4gICAJaW50IHJhdGUgPSBtb2RlLT5jbG9jayAqIDEwMDA7DQo+
ICAgDQo+ICsJY2xrX2Rpc2FibGUobGRldi0+cGl4ZWxfY2xrKTsNCj4gICAJaWYgKGNsa19zZXRf
cmF0ZShsZGV2LT5waXhlbF9jbGssIHJhdGUpIDwgMCkgew0KPiAgIAkJRFJNX0VSUk9SKCJDYW5u
b3Qgc2V0IHJhdGUgKCVkSHopIGZvciBwaXhlbCBjbGtcbiIsIHJhdGUpOw0KPiAgIAkJcmV0dXJu
IGZhbHNlOw0KPiAgIAl9DQo+ICsJY2xrX2VuYWJsZShsZGV2LT5waXhlbF9jbGspOw0KPiAgIA0K
PiAgIAlhZGp1c3RlZF9tb2RlLT5jbG9jayA9IGNsa19nZXRfcmF0ZShsZGV2LT5waXhlbF9jbGsp
IC8gMTAwMDsNCj4gICANCj4g
