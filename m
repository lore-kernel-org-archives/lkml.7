Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7EAC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED8C2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="JU9NHLgo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfDZMaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 08:30:39 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:33546 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725901AbfDZMaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 08:30:39 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3QCR6OM031997;
        Fri, 26 Apr 2019 14:30:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=U3yJZPHT8mmx59d4XUYNQQy7ZNnfUv4UW1Y4ySkmjS8=;
 b=JU9NHLgoI7xN8fmYWlxxDLLiTiSWPXS7nHnKVXEX4I/pU7qSQQof9NhLvc4OuVDh84Jg
 U1zFxZMSoDVIX2Lmf4VEWUeAbN6cHUWVlnB2gBTnhypqFIydV/6o2CKR9Zb4t6105t0o
 FIq7Z/aKH9Xbz0nw54FzD49tDoXK6XxJS1XZE9hCriY2vSI24cn+Dw8Ye8K60clgeyZl
 lJbz6O17qLZU95VlPnDJq/aMHMYMzEbmCMrzBUI5dHYLBmuS8VCBIq3nBzap0oOcA5Dn
 ooYuw/pdIPF7cJIWtGIWSGf3Vfn+zMU/V6Mp+r8AIQhle6jaXs/gRZCoqc4Xb5pZqWM7 wA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rytadmc1e-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 26 Apr 2019 14:30:24 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5E17C3A;
        Fri, 26 Apr 2019 12:30:23 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 34B551598;
        Fri, 26 Apr 2019 12:30:23 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 26 Apr
 2019 14:30:23 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Fri, 26 Apr 2019 14:30:22 +0200
From:   Philippe CORNU <philippe.cornu@st.com>
To:     Fabien DESSENNE <fabien.dessenne@st.com>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] drm/stm: ltdc: return appropriate error code during
 probe
Thread-Topic: [PATCH 2/2] drm/stm: ltdc: return appropriate error code during
 probe
Thread-Index: AQHU+qaAxIfqK65Ja0+o6ATHoSwtO6ZOQM0A
Date:   Fri, 26 Apr 2019 12:30:22 +0000
Message-ID: <03f53dcc-816f-c017-f420-5eacc1fa486d@st.com>
References: <1556114601-30936-1-git-send-email-fabien.dessenne@st.com>
 <1556114601-30936-3-git-send-email-fabien.dessenne@st.com>
In-Reply-To: <1556114601-30936-3-git-send-email-fabien.dessenne@st.com>
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
Content-ID: <D323BF7B5BB5DF49B2B7FCC7A9946663@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-26_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmFiaWVuLA0KYW5kIHRoYW5rIHlvdSBmb3IgeW91ciBwYXRjaCwNCg0KQWNrZWQtYnk6IFBo
aWxpcHBlIENvcm51IDxwaGlsaXBwZS5jb3JudUBzdC5jb20+DQoNClBoaWxpcHBlIDotKQ0KDQpP
biA0LzI0LzE5IDQ6MDMgUE0sIEZhYmllbiBEZXNzZW5uZSB3cm90ZToNCj4gRHVyaW5nIHByb2Jl
LCByZXR1cm4gdGhlICJjbGtfZ2V0IiBlcnJvciB2YWx1ZSBpbnN0ZWFkIG9mIC1FTk9ERVYuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBGYWJpZW4gRGVzc2VubmUgPGZhYmllbi5kZXNzZW5uZUBzdC5j
b20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9zdG0vbHRkYy5jIHwgNSArKystLQ0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3N0bS9sdGRjLmMgYi9kcml2ZXJzL2dwdS9kcm0v
c3RtL2x0ZGMuYw0KPiBpbmRleCA1MjFiYTgzLi45NzkxMmUyIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vc3RtL2x0ZGMuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vc3RtL2x0ZGMu
Yw0KPiBAQCAtMTE0NSw4ICsxMTQ1LDkgQEAgaW50IGx0ZGNfbG9hZChzdHJ1Y3QgZHJtX2Rldmlj
ZSAqZGRldikNCj4gICANCj4gICAJbGRldi0+cGl4ZWxfY2xrID0gZGV2bV9jbGtfZ2V0KGRldiwg
ImxjZCIpOw0KPiAgIAlpZiAoSVNfRVJSKGxkZXYtPnBpeGVsX2NsaykpIHsNCj4gLQkJRFJNX0VS
Uk9SKCJVbmFibGUgdG8gZ2V0IGxjZCBjbG9ja1xuIik7DQo+IC0JCXJldHVybiAtRU5PREVWOw0K
PiArCQlpZiAoUFRSX0VSUihsZGV2LT5waXhlbF9jbGspICE9IC1FUFJPQkVfREVGRVIpDQo+ICsJ
CQlEUk1fRVJST1IoIlVuYWJsZSB0byBnZXQgbGNkIGNsb2NrXG4iKTsNCj4gKwkJcmV0dXJuIFBU
Ul9FUlIobGRldi0+cGl4ZWxfY2xrKTsNCj4gICAJfQ0KPiAgIA0KPiAgIAlpZiAoY2xrX3ByZXBh
cmVfZW5hYmxlKGxkZXYtPnBpeGVsX2NsaykpIHsNCj4g
