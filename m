Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8569C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D6C2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FYHNVgOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfKUByU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 20:54:20 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:64075 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726333AbfKUByT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 20:54:19 -0500
X-UUID: 06fe7ee67b14466e94102e6c54f3f065-20191121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=WMvocRkPUNIcq86Bbk5K92lkihWDnPyFTYn6UTaIqJo=;
        b=FYHNVgOLAXbXGYcdN/s5BQm29k5fyN2wHI4zMQsGWB3mRKkVp142AHUxeWGmcDg2d2kFpo+JXI/Sc+6uMagUj6wImD400oTuhDdhBjAhzX7UJuUQW52+U5ODbJBV5oA0igw83EqOnoOAPN+zsPd+g+PzebeWMIN2ZhD6gi6Ukh4=;
X-UUID: 06fe7ee67b14466e94102e6c54f3f065-20191121
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1503155607; Thu, 21 Nov 2019 09:54:13 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 21 Nov 2019 09:53:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Nov 2019 09:54:17 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, CK HU <ck.hu@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: [PATCH v17 5/6] soc: mediatek: cmdq: add cmdq_dev_get_client_reg function
Date:   Thu, 21 Nov 2019 09:54:09 +0800
Message-ID: <20191121015410.18852-6-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191121015410.18852-1-bibby.hsieh@mediatek.com>
References: <20191121015410.18852-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R0NFIGNhbm5vdCBrbm93IHRoZSByZWdpc3RlciBiYXNlIGFkZHJlc3MsIHRoaXMgZnVuY3Rpb24N
CmNhbiBoZWxwIGNtZHEgY2xpZW50IHRvIGdldCB0aGUgY21kcV9jbGllbnRfcmVnIHN0cnVjdHVy
ZS4NCg0KU2lnbmVkLW9mZi1ieTogQmliYnkgSHNpZWggPGJpYmJ5LmhzaWVoQG1lZGlhdGVrLmNv
bT4NClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KUmV2aWV3ZWQtYnk6
IEhvdWxvbmcgV2VpIDxob3Vsb25nLndlaUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3Nv
Yy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyB8IDI5ICsrKysrKysrKysrKysrKysrKysrKysr
KysrDQogaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCAgfCAyMSArKysrKysr
KysrKysrKysrKysrDQogMiBmaWxlcyBjaGFuZ2VkLCA1MCBpbnNlcnRpb25zKCspDQoNCmRpZmYg
LS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyBiL2RyaXZlcnMv
c29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQppbmRleCA5MDk0ZmRhNWE4ZmUuLjlhZGQw
ZmQ1ZmE2YyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBl
ci5jDQorKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KQEAgLTI4
LDYgKzI4LDM1IEBAIHN0cnVjdCBjbWRxX2luc3RydWN0aW9uIHsNCiAJdTggb3A7DQogfTsNCiAN
CitpbnQgY21kcV9kZXZfZ2V0X2NsaWVudF9yZWcoc3RydWN0IGRldmljZSAqZGV2LA0KKwkJCSAg
ICBzdHJ1Y3QgY21kcV9jbGllbnRfcmVnICpjbGllbnRfcmVnLCBpbnQgaWR4KQ0KK3sNCisJc3Ry
dWN0IG9mX3BoYW5kbGVfYXJncyBzcGVjOw0KKwlpbnQgZXJyOw0KKw0KKwlpZiAoIWNsaWVudF9y
ZWcpDQorCQlyZXR1cm4gLUVOT0VOVDsNCisNCisJZXJyID0gb2ZfcGFyc2VfcGhhbmRsZV93aXRo
X2ZpeGVkX2FyZ3MoZGV2LT5vZl9ub2RlLA0KKwkJCQkJICAgICAgICJtZWRpYXRlayxnY2UtY2xp
ZW50LXJlZyIsDQorCQkJCQkgICAgICAgMywgaWR4LCAmc3BlYyk7DQorCWlmIChlcnIgPCAwKSB7
DQorCQlkZXZfZXJyKGRldiwNCisJCQkiZXJyb3IgJWQgY2FuJ3QgcGFyc2UgZ2NlLWNsaWVudC1y
ZWcgcHJvcGVydHkgKCVkKSIsDQorCQkJZXJyLCBpZHgpOw0KKw0KKwkJcmV0dXJuIGVycjsNCisJ
fQ0KKw0KKwljbGllbnRfcmVnLT5zdWJzeXMgPSAodTgpc3BlYy5hcmdzWzBdOw0KKwljbGllbnRf
cmVnLT5vZmZzZXQgPSAodTE2KXNwZWMuYXJnc1sxXTsNCisJY2xpZW50X3JlZy0+c2l6ZSA9ICh1
MTYpc3BlYy5hcmdzWzJdOw0KKwlvZl9ub2RlX3B1dChzcGVjLm5wKTsNCisNCisJcmV0dXJuIDA7
DQorfQ0KK0VYUE9SVF9TWU1CT0woY21kcV9kZXZfZ2V0X2NsaWVudF9yZWcpOw0KKw0KIHN0YXRp
YyB2b2lkIGNtZHFfY2xpZW50X3RpbWVvdXQoc3RydWN0IHRpbWVyX2xpc3QgKnQpDQogew0KIAlz
dHJ1Y3QgY21kcV9jbGllbnQgKmNsaWVudCA9IGZyb21fdGltZXIoY2xpZW50LCB0LCB0aW1lcik7
DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCBiL2lu
Y2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCmluZGV4IDkyYmQ1YjVjNjM0MS4u
YTc0YzFkNWFjZGYzIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRr
LWNtZHEuaA0KKysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KQEAg
LTE1LDYgKzE1LDEyIEBADQogDQogc3RydWN0IGNtZHFfcGt0Ow0KIA0KK3N0cnVjdCBjbWRxX2Ns
aWVudF9yZWcgew0KKwl1OCBzdWJzeXM7DQorCXUxNiBvZmZzZXQ7DQorCXUxNiBzaXplOw0KK307
DQorDQogc3RydWN0IGNtZHFfY2xpZW50IHsNCiAJc3BpbmxvY2tfdCBsb2NrOw0KIAl1MzIgcGt0
X2NudDsNCkBAIC0yNCw2ICszMCwyMSBAQCBzdHJ1Y3QgY21kcV9jbGllbnQgew0KIAl1MzIgdGlt
ZW91dF9tczsgLyogaW4gdW5pdCBvZiBtaWNyb3NlY29uZCAqLw0KIH07DQogDQorLyoqDQorICog
Y21kcV9kZXZfZ2V0X2NsaWVudF9yZWcoKSAtIHBhcnNlIGNtZHEgY2xpZW50IHJlZyBmcm9tIHRo
ZSBkZXZpY2UNCisgKgkJCSAgICAgICBub2RlIG9mIENNRFEgY2xpZW50DQorICogQGRldjoJZGV2
aWNlIG9mIENNRFEgbWFpbGJveCBjbGllbnQNCisgKiBAY2xpZW50X3JlZzogQ01EUSBjbGllbnQg
cmVnIHBvaW50ZXINCisgKiBAaWR4Ogl0aGUgaW5kZXggb2YgZGVzaXJlZCByZWcNCisgKg0KKyAq
IFJldHVybjogMCBmb3Igc3VjY2VzczsgZWxzZSB0aGUgZXJyb3IgY29kZSBpcyByZXR1cm5lZA0K
KyAqDQorICogSGVscCBDTURRIGNsaWVudCBwYXJzaW5nIHRoZSBjbWRxIGNsaWVudCByZWcNCisg
KiBmcm9tIHRoZSBkZXZpY2Ugbm9kZSBvZiBDTURRIGNsaWVudC4NCisgKi8NCitpbnQgY21kcV9k
ZXZfZ2V0X2NsaWVudF9yZWcoc3RydWN0IGRldmljZSAqZGV2LA0KKwkJCSAgICBzdHJ1Y3QgY21k
cV9jbGllbnRfcmVnICpjbGllbnRfcmVnLCBpbnQgaWR4KTsNCisNCiAvKioNCiAgKiBjbWRxX21i
b3hfY3JlYXRlKCkgLSBjcmVhdGUgQ01EUSBtYWlsYm94IGNsaWVudCBhbmQgY2hhbm5lbA0KICAq
IEBkZXY6CWRldmljZSBvZiBDTURRIG1haWxib3ggY2xpZW50DQotLSANCjIuMTguMA0K

