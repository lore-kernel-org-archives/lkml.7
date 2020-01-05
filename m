Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D12EC33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 10:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C66207FD
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 10:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Wt5c9fV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgAEKr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 05:47:29 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:61073 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727200AbgAEKr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 05:47:26 -0500
X-UUID: 6aa44d3c98c74eeb9f0c1e78ab4293ac-20200105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=3mbq9FpjSxSDLEY2w5X2s9Gfj1UKMBPHT8u/FwCDfyk=;
        b=Wt5c9fV25mF/KFJFOc5ImE3zvuehaP/tlV0EzygatHO1BspQwiF2nPZbJLb6Fkf8yLHOT/A4f7ZL8m7Fc2SmEaFcli4OgBqE+G4dSPduxiVx99Hhvmcs6SLNoJhbKdtMiR339KQwiphmQWMBq5J7E3YWZKscjL8LllIn+4aqU2c=;
X-UUID: 6aa44d3c98c74eeb9f0c1e78ab4293ac-20200105
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1127711607; Sun, 05 Jan 2020 18:47:22 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 5 Jan 2020 18:46:54 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 5 Jan 2020 18:45:52 +0800
From:   Chao Hao <chao.hao@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>,
        Jun Yan <jun.yan@mediatek.com>,
        Cui Zhang <zhang.cui@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Anan Sun <anan.sun@mediatek.com>
Subject: [PATCH v2 19/19] iommu/mediatek: Add multiple mtk_iommu_domain support for mt6779
Date:   Sun, 5 Jan 2020 18:45:23 +0800
Message-ID: <20200105104523.31006-20-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200105104523.31006-1-chao.hao@mediatek.com>
References: <20200105104523.31006-1-chao.hao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rm9yIG10Njc3OSwgaXQgbmVlZCB0byBzdXBwb3J0IHRocmVlIG10a19pb21tdV9kb21haW5zLCBl
dmVyeQ0KbXRrX2lvbW11X2RvbWFpbidzIGlvdmEgc3BhY2UgaXMgZGlmZmVyZW50Lg0KVGhyZWUg
bXRrX2lvbW11X2RvbWFpbnMgaXMgYXMgYmVsb3c6DQoxLiBOb3JtYWwgbXRrX2lvbW11X2RvbWFp
biBleGNsdWRlIDB4NDAwMF8wMDAwfjB4NDdmZl9mZmZmIGFuZA0KICAgMHg3ZGEwXzAwMDB+N2Zi
Zl9mZmZmLg0KMi4gQ0NVIG10a19pb21tdV9kb21haW4gaW5jbHVkZSAweDQwMDBfMDAwMH4weDQ3
ZmZfZmZmZi4NCjMuIFZQVSBtdGtfaW9tbXVfZG9tYWluIDB4N2RhMF8wMDAwfjB4N2ZiZl9mZmZm
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBDaGFvIEhhbyA8Y2hhby5oYW9AbWVkaWF0ZWsuY29tPg0KLS0t
DQogZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyB8IDQ1ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0MyBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyBiL2Ry
aXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCmluZGV4IGFiMDlmNDM1ZDQzNy4uZDU2MjU0ODgzNTQx
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KKysrIGIvZHJpdmVycy9p
b21tdS9tdGtfaW9tbXUuYw0KQEAgLTEzNCw2ICsxMzQsMzAgQEAgY29uc3Qgc3RydWN0IG10a19k
b21haW5fZGF0YSBzaW5nbGVfZG9tID0gew0KIAkubWF4X2lvdmEgPSBETUFfQklUX01BU0soMzIp
DQogfTsNCiANCisvKg0KKyAqIHJlbGF0ZWQgZmlsZTogbXQ2Nzc5LWxhcmItcG9ydC5oDQorICov
DQorY29uc3Qgc3RydWN0IG10a19kb21haW5fZGF0YSBtdDY3NzlfbXVsdGlfZG9tW10gPSB7DQor
CS8qIG5vcm1hbCBkb21haW4gKi8NCisJew0KKwkgLm1pbl9pb3ZhID0gMHgwLA0KKwkgLm1heF9p
b3ZhID0gRE1BX0JJVF9NQVNLKDMyKSwNCisJfSwNCisJLyogY2N1IGRvbWFpbiAqLw0KKwl7DQor
CSAubWluX2lvdmEgPSAweDQwMDAwMDAwLA0KKwkgLm1heF9pb3ZhID0gMHg0ODAwMDAwMCAtIDEs
DQorCSAucG9ydF9tYXNrID0ge01US19NNFVfSUQoOSwgMjEpLCBNVEtfTTRVX0lEKDksIDIyKSwN
CisJCSAgICAgICBNVEtfTTRVX0lEKDEyLCAwKSwgTVRLX000VV9JRCgxMiwgMSl9DQorCX0sDQor
CS8qIHZwdSBkb21haW4gKi8NCisJew0KKwkgLm1pbl9pb3ZhID0gMHg3ZGEwMDAwMCwNCisJIC5t
YXhfaW92YSA9IDB4N2ZjMDAwMDAgLSAxLA0KKwkgLnBvcnRfbWFzayA9IHtNVEtfTTRVX0lEKDEz
LCAwKX0NCisJfQ0KK307DQorDQogc3RhdGljIHN0cnVjdCBtdGtfaW9tbXVfcGd0YWJsZSAqc2hh
cmVfcGd0YWJsZTsNCiBzdGF0aWMgY29uc3Qgc3RydWN0IGlvbW11X29wcyBtdGtfaW9tbXVfb3Bz
Ow0KIA0KQEAgLTEwNTAsNiArMTA3NCwyMSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGRldl9wbV9v
cHMgbXRrX2lvbW11X3BtX29wcyA9IHsNCiAJU0VUX05PSVJRX1NZU1RFTV9TTEVFUF9QTV9PUFMo
bXRrX2lvbW11X3N1c3BlbmQsIG10a19pb21tdV9yZXN1bWUpDQogfTsNCiANCitzdGF0aWMgY29u
c3Qgc3RydWN0IG10a19pb21tdV9yZXN2X2lvdmFfcmVnaW9uIG10Njc3OV9pb21tdV9yc3ZfbGlz
dFtdID0gew0KKwl7DQorCQkuZG9tX2lkID0gMCwNCisJCS5pb3ZhX2Jhc2UgPSAweDQwMDAwMDAw
LAkvKiBDQ1UgKi8NCisJCS5pb3ZhX3NpemUgPSAweDgwMDAwMDAsDQorCQkudHlwZSA9IElPTU1V
X1JFU1ZfUkVTRVJWRUQsDQorCX0sDQorCXsNCisJCS5kb21faWQgPSAwLA0KKwkJLmlvdmFfYmFz
ZSA9IDB4N2RhMDAwMDAsCS8qIFZQVS9NRExBICovDQorCQkuaW92YV9zaXplID0gMHgyNzAwMDAw
LA0KKwkJLnR5cGUgPSBJT01NVV9SRVNWX1JFU0VSVkVELA0KKwl9LA0KK307DQorDQogc3RhdGlj
IGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIG10MjcxMl9kYXRhID0gew0KIAkubTR1
X3BsYXQgICAgID0gTTRVX01UMjcxMiwNCiAJLmhhc180Z2JfbW9kZSA9IHRydWUsDQpAQCAtMTA2
Myw4ICsxMTAyLDEwIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSBt
dDI3MTJfZGF0YSA9IHsNCiANCiBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19pb21tdV9wbGF0X2Rh
dGEgbXQ2Nzc5X2RhdGEgPSB7DQogCS5tNHVfcGxhdCA9IE00VV9NVDY3NzksDQotCS5kb21fY250
ID0gMSwNCi0JLmRvbV9kYXRhID0gJnNpbmdsZV9kb20sDQorCS5yZXN2X2NudCAgICAgPSBBUlJB
WV9TSVpFKG10Njc3OV9pb21tdV9yc3ZfbGlzdCksDQorCS5yZXN2X3JlZ2lvbiAgPSBtdDY3Nzlf
aW9tbXVfcnN2X2xpc3QsDQorCS5kb21fY250ID0gQVJSQVlfU0laRShtdDY3NzlfbXVsdGlfZG9t
KSwNCisJLmRvbV9kYXRhID0gbXQ2Nzc5X211bHRpX2RvbSwNCiAJLmxhcmJpZF9yZW1hcFswXSA9
IHswLCAxLCAyLCAzLCA1LCA3LCAxMCwgOX0sDQogCS8qIHZwNmEsIHZwNmIsIG1kbGEvY29yZTIs
IG1kbGEvZWRtYyovDQogCS5sYXJiaWRfcmVtYXBbMV0gPSB7MiwgMCwgMywgMX0sDQotLSANCjIu
MTguMA0K

