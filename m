Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4F7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C772087E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbfCZMwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:52:44 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:17689 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726258AbfCZMwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 08:52:44 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QCkIZi004729;
        Tue, 26 Mar 2019 13:52:37 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rddh7hjbp-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 26 Mar 2019 13:52:37 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 539ED38;
        Tue, 26 Mar 2019 12:52:36 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1DB20585C;
        Tue, 26 Mar 2019 12:52:36 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 26 Mar
 2019 13:52:35 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Tue, 26 Mar 2019 13:52:35 +0100
From:   Philippe CORNU <philippe.cornu@st.com>
To:     Yannick FERTRE <yannick.fertre@st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH] drm/stm: dw_mipi_dsi-stm: add sleep power management
Thread-Topic: [PATCH] drm/stm: dw_mipi_dsi-stm: add sleep power management
Thread-Index: AQHU374TioDRLrU+xUCL3ZXbfkQ7i6Yd1VGA
Date:   Tue, 26 Mar 2019 12:52:35 +0000
Message-ID: <8dc548ed-fc71-dd04-83b9-ee07faeb16ea@st.com>
References: <1553156033-13792-1-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1553156033-13792-1-git-send-email-yannick.fertre@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <085ED1A7A37AE04A84E41EE996E08B69@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBZYW5uaWNrLA0KTWFueSB0aGFua3MgZm9yIHlvdXIgcGF0Y2guDQoNCkFja2VkLWJ5OiBQ
aGlsaXBwZSBDb3JudSA8cGhpbGlwcGUuY29ybnVAc3QuY29tPg0KDQpQaGlsaXBwZSA6LSkNCg0K
DQpPbiAzLzIxLzE5IDk6MTMgQU0sIFlhbm5pY2sgRmVydHLDqSB3cm90ZToNCj4gSW1wbGVtZW50
cyBzeXN0ZW0gc2xlZXAgcG93ZXIgbWFuYWdlbWVudCBvcHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBZYW5uaWNrIEZlcnRyw6kgPHlhbm5pY2suZmVydHJlQHN0LmNvbT4NCj4gLS0tDQo+ICAgZHJp
dmVycy9ncHUvZHJtL3N0bS9kd19taXBpX2RzaS1zdG0uYyB8IDI4ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9zdG0vZHdfbWlwaV9kc2ktc3RtLmMgYi9kcml2
ZXJzL2dwdS9kcm0vc3RtL2R3X21pcGlfZHNpLXN0bS5jDQo+IGluZGV4IGE2NzJiNTkuLjFiZWY3
M2UgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9zdG0vZHdfbWlwaV9kc2ktc3RtLmMN
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3N0bS9kd19taXBpX2RzaS1zdG0uYw0KPiBAQCAtMzU2
LDEyICszNTYsNDAgQEAgc3RhdGljIGludCBkd19taXBpX2RzaV9zdG1fcmVtb3ZlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAgCXJldHVybiAwOw0KPiAgIH0NCj4gICANCj4gK3N0
YXRpYyBpbnQgX19tYXliZV91bnVzZWQgZHdfbWlwaV9kc2lfc3RtX3N1c3BlbmQoc3RydWN0IGRl
dmljZSAqZGV2KQ0KPiArew0KPiArCXN0cnVjdCBkd19taXBpX2RzaV9zdG0gKmRzaSA9IGR3X21p
cGlfZHNpX3N0bV9wbGF0X2RhdGEucHJpdl9kYXRhOw0KPiArDQo+ICsJRFJNX0RFQlVHX0RSSVZF
UigiXG4iKTsNCj4gKw0KPiArCWNsa19kaXNhYmxlX3VucHJlcGFyZShkc2ktPnBsbHJlZl9jbGsp
Ow0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgX19tYXliZV91
bnVzZWQgZHdfbWlwaV9kc2lfc3RtX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICt7DQo+
ICsJc3RydWN0IGR3X21pcGlfZHNpX3N0bSAqZHNpID0gZHdfbWlwaV9kc2lfc3RtX3BsYXRfZGF0
YS5wcml2X2RhdGE7DQo+ICsNCj4gKwlEUk1fREVCVUdfRFJJVkVSKCJcbiIpOw0KPiArDQo+ICsJ
Y2xrX3ByZXBhcmVfZW5hYmxlKGRzaS0+cGxscmVmX2Nsayk7DQo+ICsNCj4gKwlyZXR1cm4gMDsN
Cj4gK30NCj4gKw0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBkZXZfcG1fb3BzIGR3X21pcGlfZHNp
X3N0bV9wbV9vcHMgPSB7DQo+ICsJU0VUX1NZU1RFTV9TTEVFUF9QTV9PUFMoZHdfbWlwaV9kc2lf
c3RtX3N1c3BlbmQsDQo+ICsJCQkJZHdfbWlwaV9kc2lfc3RtX3Jlc3VtZSkNCj4gK307DQo+ICsN
Cj4gICBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBkd19taXBpX2RzaV9zdG1fZHJpdmVy
ID0gew0KPiAgIAkucHJvYmUJCT0gZHdfbWlwaV9kc2lfc3RtX3Byb2JlLA0KPiAgIAkucmVtb3Zl
CQk9IGR3X21pcGlfZHNpX3N0bV9yZW1vdmUsDQo+ICAgCS5kcml2ZXIJCT0gew0KPiAgIAkJLm9m
X21hdGNoX3RhYmxlID0gZHdfbWlwaV9kc2lfc3RtX2R0X2lkcywNCj4gICAJCS5uYW1lCT0gInN0
bTMyLWRpc3BsYXktZHNpIiwNCj4gKwkJLnBtID0gJmR3X21pcGlfZHNpX3N0bV9wbV9vcHMsDQo+
ICAgCX0sDQo+ICAgfTsNCj4gICANCj4g
