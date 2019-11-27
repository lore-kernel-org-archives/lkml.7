Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE951C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2A82068E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bXd55jd8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfK0B7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 20:59:31 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:45904 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727121AbfK0B70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 20:59:26 -0500
X-UUID: 8cfeff5c8e92431a81e5f07ea0b2908e-20191127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=8WBe5+aGC7K+W+Z4Y10j5bdbvqHfiXEGyAm4Mr40jXc=;
        b=bXd55jd83KShNph5Og19nTRthKvNszeeucdhdlUwZvQnGrMIOnTB5xAj4ocE85Ilbj3BsY+Tm/EMFJQsIL8jVM2Wg0JkYK/k01fUMrA7osojwqxbYy7Fr6Ui0bzHnUpDvvE8/8K5UX3LNeuqJ2qOg8rgHaSDBVIFEUYtwRCLxhY=;
X-UUID: 8cfeff5c8e92431a81e5f07ea0b2908e-20191127
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2104234710; Wed, 27 Nov 2019 09:59:11 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Nov 2019 09:58:44 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Nov 2019 09:58:19 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v2 10/14] soc: mediatek: cmdq: add write_s value function
Date:   Wed, 27 Nov 2019 09:58:53 +0800
Message-ID: <1574819937-6246-12-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 248A6CF17373214C60CFC52C8E2696CD4B51C89120D42ADB52041CA5A6455D192000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YWRkIHdyaXRlX3MgZnVuY3Rpb24gaW4gY21kcSBoZWxwZXIgZnVuY3Rpb25zIHdoaWNoDQp3cml0
ZXMgYSBjb25zdGFudCB2YWx1ZSB0byBhZGRyZXNzIHdpdGggbGFyZ2UgZG1hDQphY2Nlc3Mgc3Vw
cG9ydC4NCg0KU2lnbmVkLW9mZi1ieTogRGVubmlzIFlDIEhzaWVoIDxkZW5uaXMteWMuaHNpZWhA
bWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVy
LmMgfCAzMSArKysrKysrKysrKysrKysrKysrKysrKysrKw0KIGluY2x1ZGUvbGludXgvc29jL21l
ZGlhdGVrL210ay1jbWRxLmggIHwgMTIgKysrKysrKysrKw0KIDIgZmlsZXMgY2hhbmdlZCwgNDMg
aW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNt
ZHEtaGVscGVyLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KaW5k
ZXggMmNkNjkzZTM0OTgwLi4yNDRiODUyOGViMTYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRr
LWNtZHEtaGVscGVyLmMNCkBAIC0yODQsNiArMjg0LDM3IEBAIGludCBjbWRxX3BrdF93cml0ZV9z
KHN0cnVjdCBjbWRxX3BrdCAqcGt0LCBwaHlzX2FkZHJfdCBhZGRyLCB1MTYgcmVnX2lkeCwNCiB9
DQogRVhQT1JUX1NZTUJPTChjbWRxX3BrdF93cml0ZV9zKTsNCiANCitpbnQgY21kcV9wa3Rfd3Jp
dGVfc192YWx1ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgZG1hX2FkZHJfdCBhZGRyLA0KKwkJCSAg
IHUzMiB2YWx1ZSwgdTMyIG1hc2spDQorew0KKwlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0
ID0geyB7MH0gfTsNCisJaW50IGVycjsNCisJY29uc3QgdTE2IGRzdF9yZWdfaWR4ID0gQ01EUV9T
UFJfVEVNUDsNCisNCisJZXJyID0gY21kcV9wa3RfYXNzaWduKHBrdCwgZHN0X3JlZ19pZHgsIENN
RFFfQUREUl9ISUdIKGFkZHIpKTsNCisJaWYgKGVyciA8IDApDQorCQlyZXR1cm4gZXJyOw0KKw0K
KwlpZiAobWFzayAhPSBVMzJfTUFYKSB7DQorCQlpbnN0Lm9wID0gQ01EUV9DT0RFX01BU0s7DQor
CQlpbnN0Lm1hc2sgPSB+bWFzazsNCisJCWVyciA9IGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBr
dCwgaW5zdCk7DQorCQlpZiAoZXJyIDwgMCkNCisJCQlyZXR1cm4gZXJyOw0KKw0KKwkJaW5zdC5v
cCA9IENNRFFfQ09ERV9XUklURV9TX01BU0s7DQorCX0gZWxzZSB7DQorCQlpbnN0Lm9wID0gQ01E
UV9DT0RFX1dSSVRFX1M7DQorCX0NCisNCisJaW5zdC5zb3AgPSBkc3RfcmVnX2lkeDsNCisJaW5z
dC5vZmZzZXQgPSBDTURRX0FERFJfTE9XKGFkZHIpOw0KKwlpbnN0LnZhbHVlID0gdmFsdWU7DQor
DQorCXJldHVybiBjbWRxX3BrdF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0KK30NCitFWFBP
UlRfU1lNQk9MKGNtZHFfcGt0X3dyaXRlX3NfdmFsdWUpOw0KKw0KIGludCBjbWRxX3BrdF93ZmUo
c3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBldmVudCkNCiB7DQogCXN0cnVjdCBjbWRxX2luc3Ry
dWN0aW9uIGluc3QgPSB7IHswfSB9Ow0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc29jL21l
ZGlhdGVrL210ay1jbWRxLmggYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5o
DQppbmRleCBiYzI4YTQxZDc3ODAuLjRiY2UyNDBkYmI1NiAxMDA2NDQNCi0tLSBhL2luY2x1ZGUv
bGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCisrKyBiL2luY2x1ZGUvbGludXgvc29jL21l
ZGlhdGVrL210ay1jbWRxLmgNCkBAIC0xMjgsNiArMTI4LDE4IEBAIGludCBjbWRxX3BrdF9yZWFk
X3Moc3RydWN0IGNtZHFfcGt0ICpwa3QsIHBoeXNfYWRkcl90IGFkZHIsIHUxNiByZWdfaWR4KTsN
CiBpbnQgY21kcV9wa3Rfd3JpdGVfcyhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgcGh5c19hZGRyX3Qg
YWRkciwgdTE2IHJlZ19pZHgsDQogCQkgICAgIHUzMiBtYXNrKTsNCiANCisvKioNCisgKiBjbWRx
X3BrdF93cml0ZV9zKCkgLSBhcHBlbmQgd3JpdGVfcyBjb21tYW5kIHdpdGggbWFzayB0byB0aGUg
Q01EUSBwYWNrZXQNCisgKiBAcGt0Ogl0aGUgQ01EUSBwYWNrZXQNCisgKiBAYWRkcjoJdGhlIHBo
eXNpY2FsIGFkZHJlc3Mgb2YgcmVnaXN0ZXIgb3IgZG1hDQorICogQHZhbHVlOgl0aGUgc3BlY2lm
aWVkIHRhcmdldCB2YWx1ZQ0KKyAqIEBtYXNrOgl0aGUgc3BlY2lmaWVkIHRhcmdldCBtYXNrDQor
ICoNCisgKiBSZXR1cm46IDAgZm9yIHN1Y2Nlc3M7IGVsc2UgdGhlIGVycm9yIGNvZGUgaXMgcmV0
dXJuZWQNCisgKi8NCitpbnQgY21kcV9wa3Rfd3JpdGVfc192YWx1ZShzdHJ1Y3QgY21kcV9wa3Qg
KnBrdCwgZG1hX2FkZHJfdCBhZGRyLA0KKwkJCSAgIHUzMiB2YWx1ZSwgdTMyIG1hc2spOw0KKw0K
IC8qKg0KICAqIGNtZHFfcGt0X3dmZSgpIC0gYXBwZW5kIHdhaXQgZm9yIGV2ZW50IGNvbW1hbmQg
dG8gdGhlIENNRFEgcGFja2V0DQogICogQHBrdDoJdGhlIENNRFEgcGFja2V0DQotLSANCjIuMTgu
MA0K

