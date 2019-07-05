Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFCEC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3553D218C9
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="NEVk99+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbfGEMhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 08:37:42 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:49134 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725601AbfGEMhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 08:37:41 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x65CWUBO015894;
        Fri, 5 Jul 2019 14:36:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=nuMS6p+p3kSwZitSa3B2HZ8uP0JDZ2NWsyUgLamNnd0=;
 b=NEVk99+KVuuwQZPkG0kmtuAaoM+1yQYeq2y07wKKVR5WjnQccS0/1HiOmmHp73HOR9N5
 14Gq/eo3rYJLA6vGhwt0M0pufNUc3aE6mpbN8pZfVkbKPNWLoFx5Ym+pjNbBVmUDgUFz
 gchrebzYFkXdBgiX5AVCz3bEW5mCajFgor1PLMi960cttvIjiX/2ZCM6hzqrN0f66p3G
 mOAUyy30RfXCWGaVmAJLuUYcWKweyTVnWHc9ya1pxJutg7ydvnPwlRrHNkXybc01Qbiw
 znhM9q4rEBN9AylBWAWk9SpdUZ6y6woQN1iqTJ39KqDWhiNLO9ENi24xJvCTGXaF3Mfi Tg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2tdxvjjgj1-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 05 Jul 2019 14:36:13 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7C90531;
        Fri,  5 Jul 2019 12:36:12 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4862E2C7F;
        Fri,  5 Jul 2019 12:36:12 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 5 Jul
 2019 14:36:11 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1473.003; Fri, 5 Jul 2019 14:36:11 +0200
From:   Philippe CORNU <philippe.cornu@st.com>
To:     Olivier MOYSAN <olivier.moysan@st.com>,
        "a.hajda@samsung.com" <a.hajda@samsung.com>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "jonas@kwiboo.se" <jonas@kwiboo.se>,
        "jernej.skrabec@siol.net" <jernej.skrabec@siol.net>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "jsarha@ti.com" <jsarha@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 3/3] drm/bridge: sii902x: make audio mclk optional
Thread-Topic: [PATCH 3/3] drm/bridge: sii902x: make audio mclk optional
Thread-Index: AQHVMO2M8CUkPHajiUCKtjETQ0unPqa72RGA
Date:   Fri, 5 Jul 2019 12:36:11 +0000
Message-ID: <2828a8ca-6d25-fe49-f97a-cfd86e5d5fac@st.com>
References: <1562082426-14876-1-git-send-email-olivier.moysan@st.com>
 <1562082426-14876-4-git-send-email-olivier.moysan@st.com>
In-Reply-To: <1562082426-14876-4-git-send-email-olivier.moysan@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <94B1862D7883AE44876E6AC9CEA4D8CD@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-05_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgT2xpdmllciwNCmFuZCBtYW55IHRoYW5rcyBmb3IgeW91ciBwYXRjaC4NCg0KUmV2aWV3ZWQt
Ynk6IFBoaWxpcHBlIENvcm51IDxwaGlsaXBwZS5jb3JudUBzdC5jb20+DQpQaGlsaXBwZSA6LSkN
Cg0KT24gNy8yLzE5IDU6NDcgUE0sIE9saXZpZXIgTW95c2FuIHdyb3RlOg0KPiBUaGUgbWFzdGVy
IGNsb2NrIG9uIGkycyBidXMgaXMgbm90IG1hbmRhdG9yeSwNCj4gYXMgc2lpOTAyWCBpbnRlcm5h
bCBQTEwgY2FuIGJlIHVzZWQgaW5zdGVhZC4NCj4gTWFrZSB1c2Ugb2YgbWNsayBvcHRpb25hbC4N
Cj4gDQo+IEZpeGVzOiBmZjU3ODE2MzRjNDEgKCJkcm0vYnJpZGdlOiBzaWk5MDJ4OiBJbXBsZW1l
bnQgSERNSSBhdWRpbyBzdXBwb3J0IikNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE9saXZpZXIgTW95
c2FuIDxvbGl2aWVyLm1veXNhbkBzdC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9i
cmlkZ2Uvc2lpOTAyeC5jIHwgMzkgKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0t
LS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9icmlkZ2Uvc2lpOTAyeC5jIGIv
ZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9zaWk5MDJ4LmMNCj4gaW5kZXggMzZhY2MyNTZlNjdlLi5h
MDhiZDlmZGMwNDYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9icmlkZ2Uvc2lpOTAy
eC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9icmlkZ2Uvc2lpOTAyeC5jDQo+IEBAIC01NjIs
MTkgKzU2MiwyMSBAQCBzdGF0aWMgaW50IHNpaTkwMnhfYXVkaW9faHdfcGFyYW1zKHN0cnVjdCBk
ZXZpY2UgKmRldiwgdm9pZCAqZGF0YSwNCj4gICAJCX0NCj4gICAJfQ0KPiAgIA0KPiAtCXJldCA9
IGNsa19wcmVwYXJlX2VuYWJsZShzaWk5MDJ4LT5hdWRpby5tY2xrKTsNCj4gLQlpZiAocmV0KSB7
DQo+IC0JCWRldl9lcnIoZGV2LCAiRW5hYmxpbmcgbWNsayBmYWlsZWQ6ICVkXG4iLCByZXQpOw0K
PiAtCQlyZXR1cm4gcmV0Ow0KPiAtCX0NCj4gKwlpZiAoc2lpOTAyeC0+YXVkaW8ubWNsaykgew0K
PiArCQlyZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUoc2lpOTAyeC0+YXVkaW8ubWNsayk7DQo+ICsJ
CWlmIChyZXQpIHsNCj4gKwkJCWRldl9lcnIoZGV2LCAiRW5hYmxpbmcgbWNsayBmYWlsZWQ6ICVk
XG4iLCByZXQpOw0KPiArCQkJcmV0dXJuIHJldDsNCj4gKwkJfQ0KPiAgIA0KPiAtCW1jbGtfcmF0
ZSA9IGNsa19nZXRfcmF0ZShzaWk5MDJ4LT5hdWRpby5tY2xrKTsNCj4gKwkJbWNsa19yYXRlID0g
Y2xrX2dldF9yYXRlKHNpaTkwMngtPmF1ZGlvLm1jbGspOw0KPiAgIA0KPiAtCXJldCA9IHNpaTkw
Mnhfc2VsZWN0X21jbGtfZGl2KCZpMnNfY29uZmlnX3JlZywgcGFyYW1zLT5zYW1wbGVfcmF0ZSwN
Cj4gLQkJCQkgICAgICBtY2xrX3JhdGUpOw0KPiAtCWlmIChtY2xrX3JhdGUgIT0gcmV0ICogcGFy
YW1zLT5zYW1wbGVfcmF0ZSkNCj4gLQkJZGV2X2RiZyhkZXYsICJJbmFjY3VyYXRlIHJlZmVyZW5j
ZSBjbG9jayAoJWxkLyVkICE9ICV1KVxuIiwNCj4gLQkJCW1jbGtfcmF0ZSwgcmV0LCBwYXJhbXMt
PnNhbXBsZV9yYXRlKTsNCj4gKwkJcmV0ID0gc2lpOTAyeF9zZWxlY3RfbWNsa19kaXYoJmkyc19j
b25maWdfcmVnLA0KPiArCQkJCQkgICAgICBwYXJhbXMtPnNhbXBsZV9yYXRlLCBtY2xrX3JhdGUp
Ow0KPiArCQlpZiAobWNsa19yYXRlICE9IHJldCAqIHBhcmFtcy0+c2FtcGxlX3JhdGUpDQo+ICsJ
CQlkZXZfZGJnKGRldiwgIkluYWNjdXJhdGUgcmVmZXJlbmNlIGNsb2NrICglbGQvJWQgIT0gJXUp
XG4iLA0KPiArCQkJCW1jbGtfcmF0ZSwgcmV0LCBwYXJhbXMtPnNhbXBsZV9yYXRlKTsNCj4gKwl9
DQo+ICAgDQo+ICAgCW11dGV4X2xvY2soJnNpaTkwMngtPm11dGV4KTsNCj4gICANCj4gQEAgLTY0
MCw3ICs2NDIsOCBAQCBzdGF0aWMgaW50IHNpaTkwMnhfYXVkaW9faHdfcGFyYW1zKHN0cnVjdCBk
ZXZpY2UgKmRldiwgdm9pZCAqZGF0YSwNCj4gICAJbXV0ZXhfdW5sb2NrKCZzaWk5MDJ4LT5tdXRl
eCk7DQo+ICAgDQo+ICAgCWlmIChyZXQpIHsNCj4gLQkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKHNp
aTkwMngtPmF1ZGlvLm1jbGspOw0KPiArCQlpZiAoc2lpOTAyeC0+YXVkaW8ubWNsaykNCj4gKwkJ
CWNsa19kaXNhYmxlX3VucHJlcGFyZShzaWk5MDJ4LT5hdWRpby5tY2xrKTsNCj4gICAJCWRldl9l
cnIoZGV2LCAiJXM6IGhkbWkgYXVkaW8gZW5hYmxlIGZhaWxlZDogJWRcbiIsIF9fZnVuY19fLA0K
PiAgIAkJCXJldCk7DQo+ICAgCX0NCj4gQEAgLTY1OSw3ICs2NjIsOCBAQCBzdGF0aWMgdm9pZCBz
aWk5MDJ4X2F1ZGlvX3NodXRkb3duKHN0cnVjdCBkZXZpY2UgKmRldiwgdm9pZCAqZGF0YSkNCj4g
ICANCj4gICAJbXV0ZXhfdW5sb2NrKCZzaWk5MDJ4LT5tdXRleCk7DQo+ICAgDQo+IC0JY2xrX2Rp
c2FibGVfdW5wcmVwYXJlKHNpaTkwMngtPmF1ZGlvLm1jbGspOw0KPiArCWlmIChzaWk5MDJ4LT5h
dWRpby5tY2xrKQ0KPiArCQljbGtfZGlzYWJsZV91bnByZXBhcmUoc2lpOTAyeC0+YXVkaW8ubWNs
ayk7DQo+ICAgfQ0KPiAgIA0KPiAgIGludCBzaWk5MDJ4X2F1ZGlvX2RpZ2l0YWxfbXV0ZShzdHJ1
Y3QgZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEsIGJvb2wgZW5hYmxlKQ0KPiBAQCAtNzUyLDkgKzc1
NiwxMiBAQCBzdGF0aWMgaW50IHNpaTkwMnhfYXVkaW9fY29kZWNfaW5pdChzdHJ1Y3Qgc2lpOTAy
eCAqc2lpOTAyeCwNCj4gICANCj4gICAJc2lpOTAyeC0+YXVkaW8ubWNsayA9IGRldm1fY2xrX2dl
dChkZXYsICJtY2xrIik7DQo+ICAgCWlmIChJU19FUlIoc2lpOTAyeC0+YXVkaW8ubWNsaykpIHsN
Cj4gLQkJZGV2X2VycihkZXYsICIlczogTm8gY2xvY2sgKGF1ZGlvIG1jbGspIGZvdW5kOiAlbGRc
biIsDQo+IC0JCQlfX2Z1bmNfXywgUFRSX0VSUihzaWk5MDJ4LT5hdWRpby5tY2xrKSk7DQo+IC0J
CXJldHVybiAwOw0KPiArCQlpZiAoUFRSX0VSUihzaWk5MDJ4LT5hdWRpby5tY2xrKSAhPSAtRU5P
RU5UKSB7DQo+ICsJCQlkZXZfZXJyKGRldiwgIiVzOiBObyBjbG9jayAoYXVkaW8gbWNsaykgZm91
bmQ6ICVsZFxuIiwNCj4gKwkJCQlfX2Z1bmNfXywgUFRSX0VSUihzaWk5MDJ4LT5hdWRpby5tY2xr
KSk7DQo+ICsJCQlyZXR1cm4gUFRSX0VSUihzaWk5MDJ4LT5hdWRpby5tY2xrKTsNCj4gKwkJfQ0K
PiArCQlzaWk5MDJ4LT5hdWRpby5tY2xrID0gTlVMTDsNCj4gICAJfQ0KPiAgIA0KPiAgIAlzaWk5
MDJ4LT5hdWRpby5wZGV2ID0gcGxhdGZvcm1fZGV2aWNlX3JlZ2lzdGVyX2RhdGEoDQo+IA==
