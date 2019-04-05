Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD51C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF84521738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="TQ7u87Fo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731587AbfDEQbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:31:39 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:36652 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726643AbfDEQbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:31:38 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x35GV07N026580;
        Fri, 5 Apr 2019 18:31:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=7H8RSoRc+Wd1HwbM/O2GBOA3uJJDbwsqU1yW/P2vHgo=;
 b=TQ7u87FolUWF44uvZKTSj2QkdxTAocTyS/WD0tLxtHpYBX5tfej7VU10OP156enHNyKn
 6ktnMFC6nEckeMYUPXrWej6b1xOC/y86ayR8Sve3uoqHvbRj9IhYjPwaJ3YwEa7MT+Wh
 ySEUTZzgtNDGbW7Stql0umkKoSjGqG7+oXrH+YDWbukokF47NQuSKqrPb6+59g2J2k1k
 UCEyMdE2L+8hnsuCYFrR8Nd3BJG6BYfcVxez4/8NDO46QqojBUX44DD2O+8jhcsoYxVC
 NHOSUrb7OnR+cqdi/io7A3o9+F7bb23V+rpxGGoB5TmW0kqAB4HPq4OWeuFouA7eqIjo 1w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rmgmxjjy2-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 05 Apr 2019 18:31:27 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5358D31;
        Fri,  5 Apr 2019 16:31:27 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 31B9E5011;
        Fri,  5 Apr 2019 16:31:27 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 5 Apr
 2019 18:31:26 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Fri, 5 Apr 2019 18:31:26 +0200
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
Subject: Re: [PATCH] drm/stm: ltdc: reset controller to avoid partial refresh
Thread-Topic: [PATCH] drm/stm: ltdc: reset controller to avoid partial refresh
Thread-Index: AQHU6f8DbnBM9pdQZUaNhuooiEJOaaYtpIEA
Date:   Fri, 5 Apr 2019 16:31:26 +0000
Message-ID: <1487ab3d-60f6-4c85-d021-8dec7f1a99c2@st.com>
References: <1554283453-2879-1-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1554283453-2879-1-git-send-email-yannick.fertre@st.com>
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
Content-ID: <FB1759469E65DE4EBE12379B8F616608@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-05_12:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDQvMy8xOSAxMToyNCBBTSwgWWFubmljayBGZXJ0csOpIHdyb3RlOg0KPiBEaXNwbGF5
IGNvbnRyb2xsZXIgcmVzZXQgbXVzdCBiZSBkb25lIGFzIHNvb24gYXMgcG9zc2libGUgYWZ0ZXIg
ZW5hYmxlDQo+IHRoZSBjbG9jayB0byBhdm9pZCBwYXJ0aWFsIHJlZnJlc2ggb24gc2NyZWVuLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogWWFubmljayBGZXJ0csOpIDx5YW5uaWNrLmZlcnRyZUBzdC5j
b20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9zdG0vbHRkYy5jIHwgMTIgKysrKysrLS0t
LS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vc3RtL2x0ZGMuYyBiL2RyaXZlcnMv
Z3B1L2RybS9zdG0vbHRkYy5jDQo+IGluZGV4IDMyZmQ2YTMuLjdiYmU2MWMgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9zdG0vbHRkYy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9z
dG0vbHRkYy5jDQo+IEBAIC0xMTM0LDYgKzExMzQsMTIgQEAgaW50IGx0ZGNfbG9hZChzdHJ1Y3Qg
ZHJtX2RldmljZSAqZGRldikNCj4gICAJCXJldHVybiAtRU5PREVWOw0KPiAgIAl9DQo+ICAgDQo+
ICsJaWYgKCFJU19FUlIocnN0YykpIHsNCj4gKwkJcmVzZXRfY29udHJvbF9hc3NlcnQocnN0Yyk7
DQo+ICsJCXVzbGVlcF9yYW5nZSgxMCwgMjApOw0KPiArCQlyZXNldF9jb250cm9sX2RlYXNzZXJ0
KHJzdGMpOw0KPiArCX0NCj4gKw0KPiAgIAlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRl
diwgSU9SRVNPVVJDRV9NRU0sIDApOw0KPiAgIAlsZGV2LT5yZWdzID0gZGV2bV9pb3JlbWFwX3Jl
c291cmNlKGRldiwgcmVzKTsNCj4gICAJaWYgKElTX0VSUihsZGV2LT5yZWdzKSkgew0KPiBAQCAt
MTE1NiwxMiArMTE2Miw2IEBAIGludCBsdGRjX2xvYWQoc3RydWN0IGRybV9kZXZpY2UgKmRkZXYp
DQo+ICAgCQl9DQo+ICAgCX0NCj4gICANCj4gLQlpZiAoIUlTX0VSUihyc3RjKSkgew0KPiAtCQly
ZXNldF9jb250cm9sX2Fzc2VydChyc3RjKTsNCj4gLQkJdXNsZWVwX3JhbmdlKDEwLCAyMCk7DQo+
IC0JCXJlc2V0X2NvbnRyb2xfZGVhc3NlcnQocnN0Yyk7DQo+IC0JfQ0KPiAtDQoNCkRlYXIgWWFu
bmljaywNClRoYW5rIHlvdSBmb3IgeW91ciBwYXRjaCwNCg0KQWNrZWQtYnk6IFBoaWxpcHBlIENv
cm51IDxwaGlsaXBwZS5jb3JudUBzdC5jb20+DQoNClBoaWxpcHBlIDopDQoNCj4gICAJLyogRGlz
YWJsZSBpbnRlcnJ1cHRzICovDQo+ICAgCXJlZ19jbGVhcihsZGV2LT5yZWdzLCBMVERDX0lFUiwN
Cj4gICAJCSAgSUVSX0xJRSB8IElFUl9SUklFIHwgSUVSX0ZVSUUgfCBJRVJfVEVSUklFKTsNCj4g
