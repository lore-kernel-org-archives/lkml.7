Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E29CC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504E721A49
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fA5HHO6+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfKLIhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 03:37:31 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:62222 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725825AbfKLIhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 03:37:07 -0500
X-UUID: 1e06fd5548814ecb91a1dc797236b01c-20191112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=qZMIP14YhOM+OqHM7N4qJMfN6n9YjkUyyA/24m04vpI=;
        b=fA5HHO6+PF4lxw/387J0fswiZN4X+fgsTgj+0z8CbPUpQyT3ydeXxGl59AhYMlNgoim0Kk7p25WbOh2F4XDN7pwMyEFoN2Lpplh0upHs13t8h9+zijxJPloN0B6I2NFjsMXw1sI2LUCknXn9b4k0ZIo48jFriymM29g9WpCgIqM=;
X-UUID: 1e06fd5548814ecb91a1dc797236b01c-20191112
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 689695302; Tue, 12 Nov 2019 16:37:01 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 12 Nov 2019 16:36:59 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 12 Nov 2019 16:36:58 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 07/11] phy: phy-mtk-tphy: add a property for internal resistance
Date:   Tue, 12 Nov 2019 16:36:32 +0800
Message-ID: <1573547796-29566-7-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1573547796-29566-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1573547796-29566-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 0CBCB181C849F7D0F131598CA11DB82B837F064543BC7FC947EA8AC091D4BB6B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyB1c2VkIHRvIHR1bmUgSi1LIHZvbHRhZ2UgYnkgaW50ZXJuYWwgUiAocmVzaXN0YW5j
ZSksIHRoZQ0KcmFuZ2UgaXMgWzAsIDMxXSwgdGhlIHJlc2lzdGFuY2UgdmFsdWUgaXMgYWJvdXQg
Ni45SyBvaG0gZm9yIDAsDQozLjhLIG9obSBmb3IgMzEsIGFuZCB0aGUgc3RlcCBpcyAxSyBvaG0N
Cg0KU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29t
Pg0KLS0tDQp2NDogY2hhbmdlIGNvbW1pdCBsb2cNCg0KdjM6IGNoYW5nZSBjb21taXQgbG9nDQoN
CnYyOiBubyBjaGFuZ2VzDQotLS0NCiBkcml2ZXJzL3BoeS9tZWRpYXRlay9waHktbXRrLXRwaHku
YyB8IDE2ICsrKysrKysrKysrKysrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGh5L21lZGlhdGVrL3Bo
eS1tdGstdHBoeS5jIGIvZHJpdmVycy9waHkvbWVkaWF0ZWsvcGh5LW10ay10cGh5LmMNCmluZGV4
IDVhZmUzMzYyMWRiYy4uNGEyZGM5MmYxMGY1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9waHkvbWVk
aWF0ZWsvcGh5LW10ay10cGh5LmMNCisrKyBiL2RyaXZlcnMvcGh5L21lZGlhdGVrL3BoeS1tdGst
dHBoeS5jDQpAQCAtNDMsNiArNDMsOCBAQA0KICNkZWZpbmUgUEEwX1JHX1VTQjIwX0lOVFJfRU4J
CUJJVCg1KQ0KIA0KICNkZWZpbmUgVTNQX1VTQlBIWUFDUjEJCTB4MDA0DQorI2RlZmluZSBQQTFf
UkdfSU5UUl9DQUwJCUdFTk1BU0soMjMsIDE5KQ0KKyNkZWZpbmUgUEExX1JHX0lOVFJfQ0FMX1ZB
TCh4KQkoKDB4MWYgJiAoeCkpIDw8IDE5KQ0KICNkZWZpbmUgUEExX1JHX1ZSVF9TRUwJCQlHRU5N
QVNLKDE0LCAxMikNCiAjZGVmaW5lIFBBMV9SR19WUlRfU0VMX1ZBTCh4KQkoKDB4NyAmICh4KSkg
PDwgMTIpDQogI2RlZmluZSBQQTFfUkdfVEVSTV9TRUwJCUdFTk1BU0soMTAsIDgpDQpAQCAtMzAy
LDYgKzMwNCw3IEBAIHN0cnVjdCBtdGtfcGh5X2luc3RhbmNlIHsNCiAJaW50IGV5ZV9zcmM7DQog
CWludCBleWVfdnJ0Ow0KIAlpbnQgZXllX3Rlcm07DQorCWludCBpbnRyOw0KIAlpbnQgZGlzY3Ro
Ow0KIAlib29sIGJjMTJfZW47DQogfTsNCkBAIC04NTMsMTIgKzg1NiwxNCBAQCBzdGF0aWMgdm9p
ZCBwaHlfcGFyc2VfcHJvcGVydHkoc3RydWN0IG10a190cGh5ICp0cGh5LA0KIAkJCQkgJmluc3Rh
bmNlLT5leWVfdnJ0KTsNCiAJZGV2aWNlX3Byb3BlcnR5X3JlYWRfdTMyKGRldiwgIm1lZGlhdGVr
LGV5ZS10ZXJtIiwNCiAJCQkJICZpbnN0YW5jZS0+ZXllX3Rlcm0pOw0KKwlkZXZpY2VfcHJvcGVy
dHlfcmVhZF91MzIoZGV2LCAibWVkaWF0ZWssaW50ciIsDQorCQkJCSAmaW5zdGFuY2UtPmludHIp
Ow0KIAlkZXZpY2VfcHJvcGVydHlfcmVhZF91MzIoZGV2LCAibWVkaWF0ZWssZGlzY3RoIiwNCiAJ
CQkJICZpbnN0YW5jZS0+ZGlzY3RoKTsNCi0JZGV2X2RiZyhkZXYsICJiYzEyOiVkLCBzcmM6JWQs
IHZydDolZCwgdGVybTolZCwgZGlzYzolZFxuIiwNCisJZGV2X2RiZyhkZXYsICJiYzEyOiVkLCBz
cmM6JWQsIHZydDolZCwgdGVybTolZCwgaW50cjolZCwgZGlzYzolZFxuIiwNCiAJCWluc3RhbmNl
LT5iYzEyX2VuLCBpbnN0YW5jZS0+ZXllX3NyYywNCiAJCWluc3RhbmNlLT5leWVfdnJ0LCBpbnN0
YW5jZS0+ZXllX3Rlcm0sDQotCQlpbnN0YW5jZS0+ZGlzY3RoKTsNCisJCWluc3RhbmNlLT5pbnRy
LCBpbnN0YW5jZS0+ZGlzY3RoKTsNCiB9DQogDQogc3RhdGljIHZvaWQgdTJfcGh5X3Byb3BzX3Nl
dChzdHJ1Y3QgbXRrX3RwaHkgKnRwaHksDQpAQCAtODk1LDYgKzkwMCwxMyBAQCBzdGF0aWMgdm9p
ZCB1Ml9waHlfcHJvcHNfc2V0KHN0cnVjdCBtdGtfdHBoeSAqdHBoeSwNCiAJCXdyaXRlbCh0bXAs
IGNvbSArIFUzUF9VU0JQSFlBQ1IxKTsNCiAJfQ0KIA0KKwlpZiAoaW5zdGFuY2UtPmludHIpIHsN
CisJCXRtcCA9IHJlYWRsKGNvbSArIFUzUF9VU0JQSFlBQ1IxKTsNCisJCXRtcCAmPSB+UEExX1JH
X0lOVFJfQ0FMOw0KKwkJdG1wIHw9IFBBMV9SR19JTlRSX0NBTF9WQUwoaW5zdGFuY2UtPmludHIp
Ow0KKwkJd3JpdGVsKHRtcCwgY29tICsgVTNQX1VTQlBIWUFDUjEpOw0KKwl9DQorDQogCWlmIChp
bnN0YW5jZS0+ZGlzY3RoKSB7DQogCQl0bXAgPSByZWFkbChjb20gKyBVM1BfVVNCUEhZQUNSNik7
DQogCQl0bXAgJj0gflBBNl9SR19VMl9ESVNDVEg7DQotLSANCjIuMjMuMA0K

