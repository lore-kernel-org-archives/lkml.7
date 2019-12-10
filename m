Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AD9C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 05:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCE9214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 05:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bQm7WxGl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfLJFFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 00:05:42 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:26161 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726801AbfLJFFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 00:05:37 -0500
X-UUID: 22c3048b42d0496e80cc0623653882cf-20191210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=fxKBYDi4NpsMxr1+Ks/leLDt7/9A7EICvxuGVm5YpcM=;
        b=bQm7WxGlHNtnSLCvzu1ATYzNyoKHED0j4f2SKycjYUisfGhktDHbMa8WfF1CQqzCbXzfZAEinKWVEHeVPolaLZLwVFPBva8Cusw95M1E/kWs53T0G7McRFRO41MYSaS8F0Z46Vh6VprliIxtR3UE/7l1Oo1Pw25yzEkQDTO1czE=;
X-UUID: 22c3048b42d0496e80cc0623653882cf-20191210
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 757791955; Tue, 10 Dec 2019 13:05:29 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 10 Dec 2019 13:05:09 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 10 Dec 2019 13:05:21 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        YT Shen <yt.shen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        CK Hu <ck.hu@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>, <tfiga@chromium.org>,
        <drinkcat@chromium.org>, <linux-kernel@vger.kernel.org>,
        <srv_heupstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: [PATCH v5 1/7] drm/mediatek: use DRM core's atomic commit helper
Date:   Tue, 10 Dec 2019 13:05:20 +0800
Message-ID: <20191210050526.4437-2-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191210050526.4437-1-bibby.hsieh@mediatek.com>
References: <20191210050526.4437-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIERSTSBjb3JlIGF0b21pYyBoZWxwZXIgbm93IHN1cHBvcnRzIGFzeW5jaHJvbm91cyBjb21t
aXRzIG5hdGl2ZWx5Lg0KVGhlIGN1c3RvbSBkcm0gaW1wbGVtZW50YXRpb24gaXNuJ3QgbmVlZGVk
IGFueW1vcmUsIHJlbW92ZSBpdC4NCg0KU2lnbmVkLW9mZi1ieTogQmliYnkgSHNpZWggPGJpYmJ5
LmhzaWVoQG1lZGlhdGVrLmNvbT4NClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsu
Y29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMgfCA4NiAr
Ky0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2Rydi5oIHwgIDcgLS0tDQogMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDg4
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcm1fZHJ2LmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYw0KaW5k
ZXggYzIwMzBjOTJhNzhlLi5lMDA0ZWYzNDI4NDYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcm1fZHJ2LmMNCkBAIC0zNiw4OSArMzYsMTQgQEANCiAjZGVmaW5lIERSSVZFUl9NQUpP
UiAxDQogI2RlZmluZSBEUklWRVJfTUlOT1IgMA0KIA0KLXN0YXRpYyB2b2lkIG10a19hdG9taWNf
c2NoZWR1bGUoc3RydWN0IG10a19kcm1fcHJpdmF0ZSAqcHJpdmF0ZSwNCi0JCQkJc3RydWN0IGRy
bV9hdG9taWNfc3RhdGUgKnN0YXRlKQ0KLXsNCi0JcHJpdmF0ZS0+Y29tbWl0LnN0YXRlID0gc3Rh
dGU7DQotCXNjaGVkdWxlX3dvcmsoJnByaXZhdGUtPmNvbW1pdC53b3JrKTsNCi19DQotDQotc3Rh
dGljIHZvaWQgbXRrX2F0b21pY19jb21wbGV0ZShzdHJ1Y3QgbXRrX2RybV9wcml2YXRlICpwcml2
YXRlLA0KLQkJCQlzdHJ1Y3QgZHJtX2F0b21pY19zdGF0ZSAqc3RhdGUpDQotew0KLQlzdHJ1Y3Qg
ZHJtX2RldmljZSAqZHJtID0gcHJpdmF0ZS0+ZHJtOw0KLQ0KLQlkcm1fYXRvbWljX2hlbHBlcl93
YWl0X2Zvcl9mZW5jZXMoZHJtLCBzdGF0ZSwgZmFsc2UpOw0KLQ0KLQkvKg0KLQkgKiBNZWRpYXRl
ayBkcm0gc3VwcG9ydHMgcnVudGltZSBQTSwgc28gcGxhbmUgcmVnaXN0ZXJzIGNhbm5vdCBiZQ0K
LQkgKiB3cml0dGVuIHdoZW4gdGhlaXIgY3J0YyBpcyBkaXNhYmxlZC4NCi0JICoNCi0JICogVGhl
IGNvbW1lbnQgZm9yIGRybV9hdG9taWNfaGVscGVyX2NvbW1pdCBzdGF0ZXM6DQotCSAqICAgICBG
b3IgZHJpdmVycyBzdXBwb3J0aW5nIHJ1bnRpbWUgUE0gdGhlIHJlY29tbWVuZGVkIHNlcXVlbmNl
IGlzDQotCSAqDQotCSAqICAgICBkcm1fYXRvbWljX2hlbHBlcl9jb21taXRfbW9kZXNldF9kaXNh
YmxlcyhkZXYsIHN0YXRlKTsNCi0JICogICAgIGRybV9hdG9taWNfaGVscGVyX2NvbW1pdF9tb2Rl
c2V0X2VuYWJsZXMoZGV2LCBzdGF0ZSk7DQotCSAqICAgICBkcm1fYXRvbWljX2hlbHBlcl9jb21t
aXRfcGxhbmVzKGRldiwgc3RhdGUsDQotCSAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIERSTV9QTEFORV9DT01NSVRfQUNUSVZFX09OTFkpOw0KLQkgKg0KLQkgKiBTZWUgdGhl
IGtlcm5lbGRvYyBlbnRyaWVzIGZvciB0aGVzZSB0aHJlZSBmdW5jdGlvbnMgZm9yIG1vcmUgZGV0
YWlscy4NCi0JICovDQotCWRybV9hdG9taWNfaGVscGVyX2NvbW1pdF9tb2Rlc2V0X2Rpc2FibGVz
KGRybSwgc3RhdGUpOw0KLQlkcm1fYXRvbWljX2hlbHBlcl9jb21taXRfbW9kZXNldF9lbmFibGVz
KGRybSwgc3RhdGUpOw0KLQlkcm1fYXRvbWljX2hlbHBlcl9jb21taXRfcGxhbmVzKGRybSwgc3Rh
dGUsDQotCQkJCQlEUk1fUExBTkVfQ09NTUlUX0FDVElWRV9PTkxZKTsNCi0NCi0JZHJtX2F0b21p
Y19oZWxwZXJfd2FpdF9mb3JfdmJsYW5rcyhkcm0sIHN0YXRlKTsNCi0NCi0JZHJtX2F0b21pY19o
ZWxwZXJfY2xlYW51cF9wbGFuZXMoZHJtLCBzdGF0ZSk7DQotCWRybV9hdG9taWNfc3RhdGVfcHV0
KHN0YXRlKTsNCi19DQotDQotc3RhdGljIHZvaWQgbXRrX2F0b21pY193b3JrKHN0cnVjdCB3b3Jr
X3N0cnVjdCAqd29yaykNCi17DQotCXN0cnVjdCBtdGtfZHJtX3ByaXZhdGUgKnByaXZhdGUgPSBj
b250YWluZXJfb2Yod29yaywNCi0JCQlzdHJ1Y3QgbXRrX2RybV9wcml2YXRlLCBjb21taXQud29y
ayk7DQotDQotCW10a19hdG9taWNfY29tcGxldGUocHJpdmF0ZSwgcHJpdmF0ZS0+Y29tbWl0LnN0
YXRlKTsNCi19DQotDQotc3RhdGljIGludCBtdGtfYXRvbWljX2NvbW1pdChzdHJ1Y3QgZHJtX2Rl
dmljZSAqZHJtLA0KLQkJCSAgICAgc3RydWN0IGRybV9hdG9taWNfc3RhdGUgKnN0YXRlLA0KLQkJ
CSAgICAgYm9vbCBhc3luYykNCi17DQotCXN0cnVjdCBtdGtfZHJtX3ByaXZhdGUgKnByaXZhdGUg
PSBkcm0tPmRldl9wcml2YXRlOw0KLQlpbnQgcmV0Ow0KLQ0KLQlyZXQgPSBkcm1fYXRvbWljX2hl
bHBlcl9wcmVwYXJlX3BsYW5lcyhkcm0sIHN0YXRlKTsNCi0JaWYgKHJldCkNCi0JCXJldHVybiBy
ZXQ7DQotDQotCW11dGV4X2xvY2soJnByaXZhdGUtPmNvbW1pdC5sb2NrKTsNCi0JZmx1c2hfd29y
aygmcHJpdmF0ZS0+Y29tbWl0LndvcmspOw0KLQ0KLQlyZXQgPSBkcm1fYXRvbWljX2hlbHBlcl9z
d2FwX3N0YXRlKHN0YXRlLCB0cnVlKTsNCi0JaWYgKHJldCkgew0KLQkJbXV0ZXhfdW5sb2NrKCZw
cml2YXRlLT5jb21taXQubG9jayk7DQotCQlkcm1fYXRvbWljX2hlbHBlcl9jbGVhbnVwX3BsYW5l
cyhkcm0sIHN0YXRlKTsNCi0JCXJldHVybiByZXQ7DQotCX0NCi0NCi0JZHJtX2F0b21pY19zdGF0
ZV9nZXQoc3RhdGUpOw0KLQlpZiAoYXN5bmMpDQotCQltdGtfYXRvbWljX3NjaGVkdWxlKHByaXZh
dGUsIHN0YXRlKTsNCi0JZWxzZQ0KLQkJbXRrX2F0b21pY19jb21wbGV0ZShwcml2YXRlLCBzdGF0
ZSk7DQotDQotCW11dGV4X3VubG9jaygmcHJpdmF0ZS0+Y29tbWl0LmxvY2spOw0KLQ0KLQlyZXR1
cm4gMDsNCi19DQorc3RhdGljIGNvbnN0IHN0cnVjdCBkcm1fbW9kZV9jb25maWdfaGVscGVyX2Z1
bmNzIG10a19kcm1fbW9kZV9jb25maWdfaGVscGVycyA9IHsNCisJLmF0b21pY19jb21taXRfdGFp
bCA9IGRybV9hdG9taWNfaGVscGVyX2NvbW1pdF90YWlsX3JwbSwNCit9Ow0KIA0KIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgZHJtX21vZGVfY29uZmlnX2Z1bmNzIG10a19kcm1fbW9kZV9jb25maWdfZnVu
Y3MgPSB7DQogCS5mYl9jcmVhdGUgPSBtdGtfZHJtX21vZGVfZmJfY3JlYXRlLA0KIAkuYXRvbWlj
X2NoZWNrID0gZHJtX2F0b21pY19oZWxwZXJfY2hlY2ssDQotCS5hdG9taWNfY29tbWl0ID0gbXRr
X2F0b21pY19jb21taXQsDQorCS5hdG9taWNfY29tbWl0ID0gZHJtX2F0b21pY19oZWxwZXJfY29t
bWl0LA0KIH07DQogDQogc3RhdGljIGNvbnN0IGVudW0gbXRrX2RkcF9jb21wX2lkIG10MjcwMV9t
dGtfZGRwX21haW5bXSA9IHsNCkBAIC0yNjUsNiArMTkwLDcgQEAgc3RhdGljIGludCBtdGtfZHJt
X2ttc19pbml0KHN0cnVjdCBkcm1fZGV2aWNlICpkcm0pDQogCWRybS0+bW9kZV9jb25maWcubWF4
X3dpZHRoID0gNDA5NjsNCiAJZHJtLT5tb2RlX2NvbmZpZy5tYXhfaGVpZ2h0ID0gNDA5NjsNCiAJ
ZHJtLT5tb2RlX2NvbmZpZy5mdW5jcyA9ICZtdGtfZHJtX21vZGVfY29uZmlnX2Z1bmNzOw0KKwlk
cm0tPm1vZGVfY29uZmlnLmhlbHBlcl9wcml2YXRlID0gJm10a19kcm1fbW9kZV9jb25maWdfaGVs
cGVyczsNCiANCiAJcmV0ID0gY29tcG9uZW50X2JpbmRfYWxsKGRybS0+ZGV2LCBkcm0pOw0KIAlp
ZiAocmV0KQ0KQEAgLTU0MCw4ICs0NjYsNiBAQCBzdGF0aWMgaW50IG10a19kcm1fcHJvYmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJaWYgKCFwcml2YXRlKQ0KIAkJcmV0dXJuIC1F
Tk9NRU07DQogDQotCW11dGV4X2luaXQoJnByaXZhdGUtPmNvbW1pdC5sb2NrKTsNCi0JSU5JVF9X
T1JLKCZwcml2YXRlLT5jb21taXQud29yaywgbXRrX2F0b21pY193b3JrKTsNCiAJcHJpdmF0ZS0+
ZGF0YSA9IG9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YShkZXYpOw0KIA0KIAltZW0gPSBwbGF0Zm9y
bV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5oIGIvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fZHJ2LmgNCmluZGV4IGI2YTgyNzI4ZDU2My4uOWY0Y2U2MDE3NGY2IDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmgNCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5oDQpAQCAtNDYsMTMgKzQ2LDYg
QEAgc3RydWN0IG10a19kcm1fcHJpdmF0ZSB7DQogCXN0cnVjdCBkZXZpY2Vfbm9kZSAqY29tcF9u
b2RlW0REUF9DT01QT05FTlRfSURfTUFYXTsNCiAJc3RydWN0IG10a19kZHBfY29tcCAqZGRwX2Nv
bXBbRERQX0NPTVBPTkVOVF9JRF9NQVhdOw0KIAljb25zdCBzdHJ1Y3QgbXRrX21tc3lzX2RyaXZl
cl9kYXRhICpkYXRhOw0KLQ0KLQlzdHJ1Y3Qgew0KLQkJc3RydWN0IGRybV9hdG9taWNfc3RhdGUg
KnN0YXRlOw0KLQkJc3RydWN0IHdvcmtfc3RydWN0IHdvcms7DQotCQlzdHJ1Y3QgbXV0ZXggbG9j
azsNCi0JfSBjb21taXQ7DQotDQogCXN0cnVjdCBkcm1fYXRvbWljX3N0YXRlICpzdXNwZW5kX3N0
YXRlOw0KIA0KIAlib29sIGRtYV9wYXJtc19hbGxvY2F0ZWQ7DQotLSANCjIuMTguMA0K

