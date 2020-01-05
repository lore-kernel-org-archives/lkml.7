Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4103EC33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 10:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F6220866
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 10:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NgzwXGSU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgAEKqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 05:46:52 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:24609 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725930AbgAEKqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 05:46:50 -0500
X-UUID: c2f5aa567355470faab561220865aac1-20200105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=O7bsaDAzWJe4pXQR0EOb47U3pYGGOvWkg6UdghMGuqI=;
        b=NgzwXGSUIuYaHdOflxFpJ0ywcaxNQdGNdi0jBhjyyFYDBYiIJ9MhSaGBZJyL620f2MYIa9Pd8P7vHuc0qoOZbRVoMGaYpyV0C1/PPzhF2ELMhugCJmH4RuG0xW3SaFKqmAoVjz8r0UCt+YulWNetVDiHqOwUJI8aPB3H+qSH2Sk=;
X-UUID: c2f5aa567355470faab561220865aac1-20200105
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 745381954; Sun, 05 Jan 2020 18:46:45 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 5 Jan 2020 18:46:18 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 5 Jan 2020 18:45:15 +0800
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
Subject: [PATCH v2 06/19] iommu/mediatek: Add new flow to get SUB_COMMON ID in translation fault
Date:   Sun, 5 Jan 2020 18:45:10 +0800
Message-ID: <20200105104523.31006-7-chao.hao@mediatek.com>
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

V2hlbiB0aGUgbnVtYmVyIG9mIHNtaV9sYXJiIGlzIG1vcmUgdGhhbiBzZXZlbiwgc21pX2xhcmIg
aWQNCndpbGwgYmUgZGl2aWRlZCBpbnRvIENPTU1PTl9JRChoaWdoIHRocmVlIGJpdHMsIGJpdFsx
MTo5XSkgYW5kDQpTVUJfQ09NTU9OX0lEKGxvdyB0d28gYml0cyxiaXRbODo3XSkuIFNvIHdlIGNh
biBhbmFseXNlIHRyYW5zbGF0aW9uDQpmYXVsdCBpZCBieSBTVUJfQ09NTU9OX0lEIGFuZCBDT01N
T05fSUQuIFdlIGNhbiBkaXN0aW5ndWlzaCBpZg0KaGFzIFNVQl9DT01NT05fSUQgYW5kIFNVQl9D
T01NT05fSUQgYnkgaGFzX3N1Yl9jb21tIHZhcmlhYmxlLg0KDQpTaWduZWQtb2ZmLWJ5OiBDaGFv
IEhhbyA8Y2hhby5oYW9AbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9pb21tdS9tdGtfaW9t
bXUuYyB8IDE2ICsrKysrKysrKysrKy0tLS0NCiBkcml2ZXJzL2lvbW11L210a19pb21tdS5oIHwg
IDEgKw0KIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkN
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgYi9kcml2ZXJzL2lvbW11
L210a19pb21tdS5jDQppbmRleCBiNjE3ODVhODc3NjQuLjVkZTEzYWIxMDk0ZSAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCisrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lv
bW11LmMNCkBAIC04OSw2ICs4OSw4IEBADQogI2RlZmluZSBSRUdfTU1VMV9JTlZMRF9QQQkJCTB4
MTQ4DQogI2RlZmluZSBSRUdfTU1VMF9JTlRfSUQJCQkJMHgxNTANCiAjZGVmaW5lIFJFR19NTVUx
X0lOVF9JRAkJCQkweDE1NA0KKyNkZWZpbmUgRl9NTVVfSU5UX0lEX0NPTU1fSUQoYSkJCQkoKChh
KSA+PiA5KSAmIDB4NykNCisjZGVmaW5lIEZfTU1VX0lOVF9JRF9TVUJfQ09NTV9JRChhKQkJKCgo
YSkgPj4gNykgJiAweDMpDQogI2RlZmluZSBGX01NVV9JTlRfSURfTEFSQl9JRChhKQkJCSgoKGEp
ID4+IDcpICYgMHg3KQ0KICNkZWZpbmUgRl9NTVVfSU5UX0lEX1BPUlRfSUQoYSkJCQkoKChhKSA+
PiAyKSAmIDB4MWYpDQogDQpAQCAtMjI3LDcgKzIyOSw3IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBt
dGtfaW9tbXVfaXNyKGludCBpcnEsIHZvaWQgKmRldl9pZCkNCiAJc3RydWN0IG10a19pb21tdV9k
YXRhICpkYXRhID0gZGV2X2lkOw0KIAlzdHJ1Y3QgbXRrX2lvbW11X2RvbWFpbiAqZG9tID0gZGF0
YS0+bTR1X2RvbTsNCiAJdTMyIGludF9zdGF0ZSwgcmVndmFsLCBmYXVsdF9pb3ZhLCBmYXVsdF9w
YTsNCi0JdW5zaWduZWQgaW50IGZhdWx0X2xhcmIsIGZhdWx0X3BvcnQ7DQorCXVuc2lnbmVkIGlu
dCBmYXVsdF9sYXJiLCBmYXVsdF9wb3J0LCBzdWJfY29tbSA9IDA7DQogCWJvb2wgbGF5ZXIsIHdy
aXRlOw0KIA0KIAkvKiBSZWFkIGVycm9yIGluZm8gZnJvbSByZWdpc3RlcnMgKi8NCkBAIC0yNDMs
OCArMjQ1LDEzIEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBtdGtfaW9tbXVfaXNyKGludCBpcnEsIHZv
aWQgKmRldl9pZCkNCiAJfQ0KIAlsYXllciA9IGZhdWx0X2lvdmEgJiBGX01NVV9GQVVMVF9WQV9M
QVlFUl9CSVQ7DQogCXdyaXRlID0gZmF1bHRfaW92YSAmIEZfTU1VX0ZBVUxUX1ZBX1dSSVRFX0JJ
VDsNCi0JZmF1bHRfbGFyYiA9IEZfTU1VX0lOVF9JRF9MQVJCX0lEKHJlZ3ZhbCk7DQogCWZhdWx0
X3BvcnQgPSBGX01NVV9JTlRfSURfUE9SVF9JRChyZWd2YWwpOw0KKwlpZiAoZGF0YS0+cGxhdF9k
YXRhLT5oYXNfc3ViX2NvbW1bZGF0YS0+bTR1X2lkXSkgew0KKwkJZmF1bHRfbGFyYiA9IEZfTU1V
X0lOVF9JRF9DT01NX0lEKHJlZ3ZhbCk7DQorCQlzdWJfY29tbSA9IEZfTU1VX0lOVF9JRF9TVUJf
Q09NTV9JRChyZWd2YWwpOw0KKwl9IGVsc2Ugew0KKwkJZmF1bHRfbGFyYiA9IEZfTU1VX0lOVF9J
RF9MQVJCX0lEKHJlZ3ZhbCk7DQorCX0NCiANCiAJZmF1bHRfbGFyYiA9IGRhdGEtPnBsYXRfZGF0
YS0+bGFyYmlkX3JlbWFwW2RhdGEtPm00dV9pZF1bZmF1bHRfbGFyYl07DQogDQpAQCAtMjUyLDgg
KzI1OSw5IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBtdGtfaW9tbXVfaXNyKGludCBpcnEsIHZvaWQg
KmRldl9pZCkNCiAJCQkgICAgICAgd3JpdGUgPyBJT01NVV9GQVVMVF9XUklURSA6IElPTU1VX0ZB
VUxUX1JFQUQpKSB7DQogCQlkZXZfZXJyX3JhdGVsaW1pdGVkKA0KIAkJCWRhdGEtPmRldiwNCi0J
CQkiZmF1bHQgdHlwZT0weCV4IGlvdmE9MHgleCBwYT0weCV4IGxhcmI9JWQgcG9ydD0lZCBsYXll
cj0lZCAlc1xuIiwNCi0JCQlpbnRfc3RhdGUsIGZhdWx0X2lvdmEsIGZhdWx0X3BhLCBmYXVsdF9s
YXJiLCBmYXVsdF9wb3J0LA0KKwkJCSJmYXVsdCB0eXBlPTB4JXggaW92YT0weCV4IHBhPTB4JXgg
bGFyYj0lZCBzdWJfY29tbT0lZCBwb3J0PSVkIHJlZ3ZhbD0weCV4IGxheWVyPSVkICVzXG4iLA0K
KwkJCWludF9zdGF0ZSwgZmF1bHRfaW92YSwgZmF1bHRfcGEsIGZhdWx0X2xhcmIsDQorCQkJc3Vi
X2NvbW0sIGZhdWx0X3BvcnQsIHJlZ3ZhbCwNCiAJCQlsYXllciwgd3JpdGUgPyAid3JpdGUiIDog
InJlYWQiKTsNCiAJfQ0KIA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11Lmgg
Yi9kcml2ZXJzL2lvbW11L210a19pb21tdS5oDQppbmRleCBlYzMwMTFhNTA3MjguLmQ0NDk1MjMw
YzZlNyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCisrKyBiL2RyaXZl
cnMvaW9tbXUvbXRrX2lvbW11LmgNCkBAIC00MCw2ICs0MCw3IEBAIHN0cnVjdCBtdGtfaW9tbXVf
cGxhdF9kYXRhIHsNCiANCiAJLyogSFcgd2lsbCB1c2UgdGhlIEVNSSBjbG9jayBpZiB0aGVyZSBp
c24ndCB0aGUgImJjbGsiLiAqLw0KIAlib29sICAgICAgICAgICAgICAgIGhhc19iY2xrOw0KKwli
b29sICAgICAgICAgICAgICAgIGhhc19zdWJfY29tbVsyXTsNCiAJYm9vbCAgICAgICAgICAgICAg
ICBoYXNfdmxkX3BhX3JuZzsNCiAJYm9vbCAgICAgICAgICAgICAgICByZXNldF9heGk7DQogCXUz
MiAgICAgICAgICAgICAgICAgbTR1MV9tYXNrOw0KLS0gDQoyLjE4LjANCg==

