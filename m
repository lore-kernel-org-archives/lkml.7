Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F18C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD1B2071C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZYdSy9Nm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfKUJNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 04:13:52 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:53690 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726747AbfKUJNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 04:13:39 -0500
X-UUID: 632f0b4f8fe04e958e1282c20d14b424-20191121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=3GH17FM+/rme/xLe3lNPvYf1Y2puYtNawmkpQEhHNA0=;
        b=ZYdSy9NmRYXnPs3J3wUJkcVXrNYCHUhioEkAD8Iikv4ecg1pvUXrnmRdpIq65060OyVWsFrifTeJmXt1pTGZjd8UqNtjh5BxYzXizn1JqzjNcwudD+pC+d6JZZUUg2b46UDkgMbpQlPfZHZb6+dQXFQRykVpv1jqZFLt6iQXnmw=;
X-UUID: 632f0b4f8fe04e958e1282c20d14b424-20191121
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 101814094; Thu, 21 Nov 2019 17:13:27 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 21 Nov 2019 17:13:23 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Nov 2019 17:13:29 +0800
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
Subject: [PATCH v1 08/12] soc: mediatek: cmdq: add read_s function
Date:   Thu, 21 Nov 2019 17:12:28 +0800
Message-ID: <1574327552-11806-9-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1574327552-11806-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1574327552-11806-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHJlYWRfcyBmdW5jdGlvbiBpbiBjbWRxIGhlbHBlciBmdW5jdGlvbnMgd2hpY2ggc3VwcG9y
dCByZWFkIHZhbHVlIGZyb20NCnJlZ2lzdGVyIG9yIGRtYSBwaHlzaWNhbCBhZGRyZXNzIGludG8g
Z2NlIGludGVybmFsIHJlZ2lzdGVyLg0KDQpTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMgSHNpZWgg
PGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3NvYy9tZWRpYXRl
ay9tdGstY21kcS1oZWxwZXIuYyAgIHwgICAyNCArKysrKysrKysrKysrKysrKysrKysrKysNCiBp
bmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIHwgICAgMSArDQogaW5jbHVk
ZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCAgICB8ICAgMTAgKysrKysrKysrKw0KIDMg
ZmlsZXMgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9z
b2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGst
Y21kcS1oZWxwZXIuYw0KaW5kZXggMWIwNzRhOS4uNGM5MGZlZCAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQorKysgYi9kcml2ZXJzL3NvYy9tZWRp
YXRlay9tdGstY21kcS1oZWxwZXIuYw0KQEAgLTIzLDYgKzIzLDEwIEBAIHN0cnVjdCBjbWRxX2lu
c3RydWN0aW9uIHsNCiAJdW5pb24gew0KIAkJdTMyIHZhbHVlOw0KIAkJdTMyIG1hc2s7DQorCQlz
dHJ1Y3Qgew0KKwkJCXUxNiBhcmdfYzsNCisJCQl1MTYgYXJnX2I7DQorCQl9Ow0KIAl9Ow0KIAl1
bmlvbiB7DQogCQl1MTYgb2Zmc2V0Ow0KQEAgLTIyNyw2ICsyMzEsMjYgQEAgaW50IGNtZHFfcGt0
X3dyaXRlX21hc2soc3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4IHN1YnN5cywNCiB9DQogRVhQT1JU
X1NZTUJPTChjbWRxX3BrdF93cml0ZV9tYXNrKTsNCiANCitpbnQgY21kcV9wa3RfcmVhZF9zKHN0
cnVjdCBjbWRxX3BrdCAqcGt0LCBwaHlzX2FkZHJfdCBhZGRyLCB1MTYgcmVnX2lkeCkNCit7DQor
CXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0KKwlpbnQgZXJyOw0KKwlj
b25zdCB1MTYgc3JjX3JlZ19pZHggPSBDTURRX1NQUl9URU1QOw0KKw0KKwllcnIgPSBjbWRxX3Br
dF9hc3NpZ24ocGt0LCBzcmNfcmVnX2lkeCwgQ01EUV9BRERSX0hJR0goYWRkcikpOw0KKwlpZiAo
ZXJyIDwgMCkNCisJCXJldHVybiBlcnI7DQorDQorCWluc3Qub3AgPSBDTURRX0NPREVfUkVBRF9T
Ow0KKwlpbnN0LmFyZ19hX3QgPSBDTURRX1JFR19UWVBFOw0KKwlpbnN0LnNvcCA9IHNyY19yZWdf
aWR4Ow0KKwlpbnN0LnJlZ19kc3QgPSByZWdfaWR4Ow0KKwlpbnN0LmFyZ19iID0gQ01EUV9BRERS
X0xPVyhhZGRyKTsNCisNCisJcmV0dXJuIGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5z
dCk7DQorfQ0KK0VYUE9SVF9TWU1CT0woY21kcV9wa3RfcmVhZF9zKTsNCisNCiBpbnQgY21kcV9w
a3Rfd3JpdGVfcyhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgZG1hX2FkZHJfdCBhZGRyLA0KIAkJICAg
ICB1MzIgdmFsdWUsIHUzMiBtYXNrKQ0KIHsNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21h
aWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIGIvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRx
LW1haWxib3guaA0KaW5kZXggOGVmODdlMS4uM2Y2YmMwZCAxMDA2NDQNCi0tLSBhL2luY2x1ZGUv
bGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCisrKyBiL2luY2x1ZGUvbGludXgvbWFp
bGJveC9tdGstY21kcS1tYWlsYm94LmgNCkBAIC01OSw2ICs1OSw3IEBAIGVudW0gY21kcV9jb2Rl
IHsNCiAJQ01EUV9DT0RFX0pVTVAgPSAweDEwLA0KIAlDTURRX0NPREVfV0ZFID0gMHgyMCwNCiAJ
Q01EUV9DT0RFX0VPQyA9IDB4NDAsDQorCUNNRFFfQ09ERV9SRUFEX1MgPSAweDgwLA0KIAlDTURR
X0NPREVfV1JJVEVfUyA9IDB4OTAsDQogCUNNRFFfQ09ERV9XUklURV9TX01BU0sgPSAweDkxLA0K
IAlDTURRX0NPREVfTE9HSUMgPSAweGEwLA0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc29j
L21lZGlhdGVrL210ay1jbWRxLmggYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21k
cS5oDQppbmRleCA4ZGJkMDQ2Li5mYjQ4ZDNjIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9z
b2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KKysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsv
bXRrLWNtZHEuaA0KQEAgLTEwNCw2ICsxMDQsMTYgQEAgaW50IGNtZHFfcGt0X3dyaXRlX21hc2so
c3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4IHN1YnN5cywNCiAJCQl1MTYgb2Zmc2V0LCB1MzIgdmFs
dWUsIHUzMiBtYXNrKTsNCiANCiAvKioNCisgKiBjbWRxX3BrdF9yZWFkX3MoKSAtIGFwcGVuZCBy
ZWFkX3MgY29tbWFuZCB0byB0aGUgQ01EUSBwYWNrZXQNCisgKiBAcGt0Ogl0aGUgQ01EUSBwYWNr
ZXQNCisgKiBAYWRkcjoJdGhlIHBoeXNpY2FsIGFkZHJlc3Mgb2YgcmVnaXN0ZXIgb3IgZG1hIHRv
IHJlYWQNCisgKiBAcmVnX2lkeDoJdGhlIENNRFEgaW50ZXJuYWwgcmVnaXN0ZXIgSUQgdG8gY2Fj
aGUgcmVhZCBkYXRhDQorICoNCisgKiBSZXR1cm46IDAgZm9yIHN1Y2Nlc3M7IGVsc2UgdGhlIGVy
cm9yIGNvZGUgaXMgcmV0dXJuZWQNCisgKi8NCitpbnQgY21kcV9wa3RfcmVhZF9zKHN0cnVjdCBj
bWRxX3BrdCAqcGt0LCBwaHlzX2FkZHJfdCBhZGRyLCB1MTYgcmVnX2lkeCk7DQorDQorLyoqDQog
ICogY21kcV9wa3Rfd3JpdGVfcygpIC0gYXBwZW5kIHdyaXRlX3MgY29tbWFuZCB3aXRoIG1hc2sg
dG8gdGhlIENNRFEgcGFja2V0DQogICogQHBrdDoJdGhlIENNRFEgcGFja2V0DQogICogQGFkZHI6
CXRoZSBwaHlzaWNhbCBhZGRyZXNzIG9mIHJlZ2lzdGVyIG9yIGRtYQ0KLS0gDQoxLjcuOS41DQo=

