Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7359FC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F4472146F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="TWzHMnhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731524AbfDEQa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:30:29 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:8756 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730554AbfDEQa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:30:28 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x35GLrYt020157;
        Fri, 5 Apr 2019 18:30:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=GoAnCrqJTr9EBQmqKgItPvgC2ok9hovPtQDhGhGC1Fo=;
 b=TWzHMnhXx/iseI33i0TgAgXtrFxinaTPhZQ4uan3Q2Qjho+gG1/NHQhXxaPm4jfv/Gps
 64HRaqz9oeQN7pnu//a5WdDuTWafST1SeP45MVSfwwOMKNjVfhGVvs/LeM+fg5WR2GjS
 h0A6PU8CM74DTUIdLKmdYyixJtBcMw4ZrlzPgoUqu8DMyy8DQOWNfs6xyfUVgfdYIsi+
 2z8uhHqgy6TYxklKBhVQjD1Wo+bAFFiAk/08QNaiIJIGp+TinpFS8b0spR/syG/NZ7+u
 KBwXt4lBGww9484I7EgIRXXo+vbrM+7MLYIjtSR2jTMIY8y1URYRIMTGECX18Uc8cvBW NQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rmgmxjjsv-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 05 Apr 2019 18:30:12 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7500334;
        Fri,  5 Apr 2019 16:30:11 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 373D72948;
        Fri,  5 Apr 2019 16:30:11 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 5 Apr
 2019 18:30:10 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Fri, 5 Apr 2019 18:30:10 +0200
From:   Philippe CORNU <philippe.cornu@st.com>
To:     Yannick FERTRE <yannick.fertre@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/stm: ltdc: limit number of layer to avoid memory
 overflow
Thread-Topic: [PATCH] drm/stm: ltdc: limit number of layer to avoid memory
 overflow
Thread-Index: AQHU6f57Senmzdbf/UOw+qUZxi2PsKYtpCeA
Date:   Fri, 5 Apr 2019 16:30:10 +0000
Message-ID: <51100130-dfe9-ae21-6efb-b1394f607bdd@st.com>
References: <1554283216-2700-1-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1554283216-2700-1-git-send-email-yannick.fertre@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <78FB76E3E78C984BA9F25E5DA1F8A424@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-05_12:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBZYW5uaWNrLA0KVGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLA0KDQpBY2tlZC1ieTogUGhp
bGlwcGUgQ29ybnUgPHBoaWxpcHBlLmNvcm51QHN0LmNvbT4NCg0KUGhpbGlwcGUgOikNCg0KT24g
NC8zLzE5IDExOjIwIEFNLCBZYW5uaWNrIEZlcnRyw6kgd3JvdGU6DQo+IElmIHRoZSBudW1iZXIg
b2YgbGF5ZXIgaXMgZ3JlYXRlciB0aGFuIExURENfTUFYX0xBWUVSLCB3ZSBjYW4gaGF2ZQ0KPiBt
ZW1vcnkgb3ZlcmZsb3cgd2hlbiByZWFkaW5nIHBsYW5lX2Zwc2lbXS4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFlhbm5pY2sgRmVydHLDqSA8eWFubmljay5mZXJ0cmVAc3QuY29tPg0KPiAtLS0NCj4g
ICBkcml2ZXJzL2dwdS9kcm0vc3RtL2x0ZGMuYyB8IDcgKysrKystLQ0KPiAgIDEgZmlsZSBjaGFu
Z2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL3N0bS9sdGRjLmMgYi9kcml2ZXJzL2dwdS9kcm0vc3RtL2x0ZGMuYw0K
PiBpbmRleCAzMmZkNmEzLi4wNWJkNGI2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
c3RtL2x0ZGMuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vc3RtL2x0ZGMuYw0KPiBAQCAtMTAy
MSwxMCArMTAyMSwxMyBAQCBzdGF0aWMgaW50IGx0ZGNfZ2V0X2NhcHMoc3RydWN0IGRybV9kZXZp
Y2UgKmRkZXYpDQo+ICAgCXN0cnVjdCBsdGRjX2RldmljZSAqbGRldiA9IGRkZXYtPmRldl9wcml2
YXRlOw0KPiAgIAl1MzIgYnVzX3dpZHRoX2xvZzIsIGxjciwgZ2MycjsNCj4gICANCj4gLQkvKiBh
dCBsZWFzdCAxIGxheWVyIG11c3QgYmUgbWFuYWdlZCAqLw0KPiArCS8qDQo+ICsJICogYXQgbGVh
c3QgMSBsYXllciBtdXN0IGJlIG1hbmFnZWQgJiB0aGUgbnVtYmVyIG9mIGxheWVycw0KPiArCSAq
IG11c3Qgbm90IGV4Y2VlZCBMVERDX01BWF9MQVlFUg0KPiArCSAqLw0KPiAgIAlsY3IgPSByZWdf
cmVhZChsZGV2LT5yZWdzLCBMVERDX0xDUik7DQo+ICAgDQo+IC0JbGRldi0+Y2Fwcy5uYl9sYXll
cnMgPSBtYXhfdChpbnQsIGxjciwgMSk7DQo+ICsJbGRldi0+Y2Fwcy5uYl9sYXllcnMgPSBjbGFt
cCgoaW50KWxjciwgMSwgTFREQ19NQVhfTEFZRVIpOw0KPiAgIA0KPiAgIAkvKiBzZXQgZGF0YSBi
dXMgd2lkdGggKi8NCj4gICAJZ2MyciA9IHJlZ19yZWFkKGxkZXYtPnJlZ3MsIExURENfR0MyUik7
DQo+IA==
