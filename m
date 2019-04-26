Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A69C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89662077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="SqKdPtxK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfDZMaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 08:30:18 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:33430 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725901AbfDZMaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 08:30:17 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3QCR6O9031997;
        Fri, 26 Apr 2019 14:29:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=tPxqPwmtx8kmWQ/NUchgXchHiEdmalZdkxterIt5hog=;
 b=SqKdPtxK00/rmeW42icMmjObKFmCoh5NmhzbYCgl0Zc+scJefF8rkAnzzZXuIEtgaiOA
 oyaVBs6zCVWrrBrQXDEa+veJ7vR9/crNBlXLhBV+iw4xisk1WxDUvUSbumArnEaWvUhE
 WjDWA1XgkGktXoB3TbEZGjde6jbEUnIEO5bF7nyjBli1kAwvhPWs904ZQQs9aY/26tgz
 qMkAAE6Z9dcV7wrVz2Iea3t98Vgu8Hr1xiuicTp7XhyEOkUdwGtpisEmhcqgSf7s9b5o
 Px8yxL3FoWg8yEvbmACHDivi9uwmfX/bJu5YIQR6ZkZLCZOsBJWnIrLbwFDvSj0sk0B1 Zg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rytadmby3-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 26 Apr 2019 14:29:57 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6B5BF38;
        Fri, 26 Apr 2019 12:29:56 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DFC8A2541;
        Fri, 26 Apr 2019 12:29:55 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 26 Apr
 2019 14:29:55 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Fri, 26 Apr 2019 14:29:55 +0200
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
Subject: Re: [PATCH 1/2] drm/stm: ltdc: manage the get_irq probe defer case
Thread-Topic: [PATCH 1/2] drm/stm: ltdc: manage the get_irq probe defer case
Thread-Index: AQHU+qZ/0GajSU5jHEGAEY+CrycsCaZOQKwA
Date:   Fri, 26 Apr 2019 12:29:55 +0000
Message-ID: <c445397b-36a7-3511-603a-e94ae6ddcf12@st.com>
References: <1556114601-30936-1-git-send-email-fabien.dessenne@st.com>
 <1556114601-30936-2-git-send-email-fabien.dessenne@st.com>
In-Reply-To: <1556114601-30936-2-git-send-email-fabien.dessenne@st.com>
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
Content-ID: <2FCD238DAB07044BAB090319C5932379@st.com>
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
biA0LzI0LzE5IDQ6MDMgUE0sIEZhYmllbiBEZXNzZW5uZSB3cm90ZToNCj4gTWFuYWdlIHRoZSAt
RVBST0JFX0RFRkVSIGVycm9yIGNhc2UgZm9yIHRoZSBsdGRjIElSUS4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEZhYmllbiBEZXNzZW5uZSA8ZmFiaWVuLmRlc3Nlbm5lQHN0LmNvbT4NCj4gLS0tDQo+
ICAgZHJpdmVycy9ncHUvZHJtL3N0bS9sdGRjLmMgfCAzICsrKw0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vc3Rt
L2x0ZGMuYyBiL2RyaXZlcnMvZ3B1L2RybS9zdG0vbHRkYy5jDQo+IGluZGV4IDU2NmIwZDguLjUy
MWJhODMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9zdG0vbHRkYy5jDQo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9zdG0vbHRkYy5jDQo+IEBAIC0xMTc0LDYgKzExNzQsOSBAQCBpbnQg
bHRkY19sb2FkKHN0cnVjdCBkcm1fZGV2aWNlICpkZGV2KQ0KPiAgIA0KPiAgIAlmb3IgKGkgPSAw
OyBpIDwgTUFYX0lSUTsgaSsrKSB7DQo+ICAgCQlpcnEgPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYs
IGkpOw0KPiArCQlpZiAoaXJxID09IC1FUFJPQkVfREVGRVIpDQo+ICsJCQlnb3RvIGVycjsNCj4g
Kw0KPiAgIAkJaWYgKGlycSA8IDApDQo+ICAgCQkJY29udGludWU7DQo+ICAgDQo+IA0K
