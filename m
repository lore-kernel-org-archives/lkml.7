Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E3EC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2593C2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="AsSRTuOs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfE0Mf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 08:35:26 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:49944 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726071AbfE0MfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:35:25 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4RCVt5j027663;
        Mon, 27 May 2019 14:35:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=fKfX2KVDIS1uJzzD4iw6of6U2XShNVpd8rTuvx0oIDA=;
 b=AsSRTuOs6JOiTMu+NPeqGAWQW13YPOk/Rpu26Ig6e71du8IaslChveCq0mwquvaDECV3
 LPJkgqpfBdqP4YTltsgsUrixL5V5+1vkVc/TaOo5dSeaK40pbkckpyruduLnWycHDHdi
 if3H/V9Dap/bVSb1myYsD30U1dIfo8OQtLUNlu04mEKgLZEfQDjvc/QYrnX5lrQ3QbdB
 Tk/QEG8dwb+wltOquxiPxhT9tb6amKO427itYpogiNrvaeuGW7rzv/s783geD57DrEFY
 KYyv4/faskRBulbvMFCeRCYJHJZnasdrWllxtBed0oQ/U8IkgfUl/cQKbtuAYn72xttL mQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2spu602yxf-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 27 May 2019 14:35:17 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F22063A;
        Mon, 27 May 2019 12:35:15 +0000 (GMT)
Received: from Webmail-eu.st.com (gpxdag3node4.st.com [10.75.127.71])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A83B7161E;
        Mon, 27 May 2019 12:35:15 +0000 (GMT)
Received: from GPXDAG6NODE6.st.com (10.75.127.82) by GPXDAG3NODE4.st.com
 (10.75.127.71) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 27 May
 2019 14:35:14 +0200
Received: from GPXDAG6NODE6.st.com ([fe80::57f:5f53:243f:cb11]) by
 GPXDAG6NODE6.st.com ([fe80::57f:5f53:243f:cb11%19]) with mapi id
 15.00.1473.003; Mon, 27 May 2019 14:35:14 +0200
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
Subject: Re: [PATCH] drm/stm: ltdc: No message if probe
Thread-Topic: [PATCH] drm/stm: ltdc: No message if probe
Thread-Index: AQHVFHUOAd2ylTGCYUyXoJC5UGt+V6Z+xtGA
Date:   Mon, 27 May 2019 12:35:14 +0000
Message-ID: <961fa8ce-8094-5a39-eab1-cdb46cf76b92@st.com>
References: <1558952075-14883-1-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1558952075-14883-1-git-send-email-yannick.fertre@st.com>
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
Content-ID: <D824B6F181B08846A8E655B1873E2A39@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-27_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgWWFubmljaywNCg0KVGhhbmsgeW91IGZvciB5b3VyIHBhdGNoDQoNCkFja2VkLWJ5OiBQaGls
aXBwZSBDb3JudSA8cGhpbGlwcGUuY29ybnVAc3QuY29tPg0KDQpQaGlsaXBwZSA6LSkNCg0KT24g
NS8yNy8xOSAxMjoxNCBQTSwgWWFubmljayBGZXJ0csOpIHdyb3RlOg0KPiBQcmludCBkaXNwbGF5
IGNvbnRyb2xsZXIgaGFyZHdhcmUgdmVyc2lvbiBpbiBkZWJ1ZyBtb2RlIG9ubHkuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBZYW5uaWNrIEZlcnRyw6kgPHlhbm5pY2suZmVydHJlQHN0LmNvbT4NCj4g
LS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL3N0bS9sdGRjLmMgfCAyICstDQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL3N0bS9sdGRjLmMgYi9kcml2ZXJzL2dwdS9kcm0vc3RtL2x0ZGMuYw0K
PiBpbmRleCBkMjRmZmMyLi4xNmIxMTAzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
c3RtL2x0ZGMuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vc3RtL2x0ZGMuYw0KPiBAQCAtMTIx
MSw3ICsxMjExLDcgQEAgaW50IGx0ZGNfbG9hZChzdHJ1Y3QgZHJtX2RldmljZSAqZGRldikNCj4g
ICAJCWdvdG8gZXJyOw0KPiAgIAl9DQo+ICAgDQo+IC0JRFJNX0lORk8oImx0ZGMgaHcgdmVyc2lv
biAweCUwOHggLSByZWFkeVxuIiwgbGRldi0+Y2Fwcy5od192ZXJzaW9uKTsNCj4gKwlEUk1fREVC
VUdfRFJJVkVSKCJsdGRjIGh3IHZlcnNpb24gMHglMDh4XG4iLCBsZGV2LT5jYXBzLmh3X3ZlcnNp
b24pOw0KPiAgIA0KPiAgIAkvKiBBZGQgZW5kcG9pbnRzIHBhbmVscyBvciBicmlkZ2VzIGlmIGFu
eSAqLw0KPiAgIAlmb3IgKGkgPSAwOyBpIDwgTUFYX0VORFBPSU5UUzsgaSsrKSB7DQo+IA==
