Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42991C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A242084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZBYJ+sJu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfKUByf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 20:54:35 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:64075 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725819AbfKUByW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 20:54:22 -0500
X-UUID: 3c168d6e3ab640d292b1a6c5d92b9a66-20191121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=GFOO0VfzBTO8Ub18854er0mFODXD5SR3N8gKN1ukCcY=;
        b=ZBYJ+sJu9d3ofOr+LDRL33ceKwG+Ndbg4kBtPVNqbSTlYhumU766Aug+xi7VkBNvFW4pvxs1/VCR8VxKf9LMHDypLuvNlm+bEtEpSOXhp5aqU2tco6Cxfv3KGun9r55lwbjmKKFlAWmJd2/2r9TgZLZ9/GolOyjISPQV3eat2nE=;
X-UUID: 3c168d6e3ab640d292b1a6c5d92b9a66-20191121
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 413363131; Thu, 21 Nov 2019 09:54:13 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 21 Nov 2019 09:53:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Nov 2019 09:54:16 +0800
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
Subject: [PATCH v17 2/6] soc: mediatek: cmdq: remove OR opertaion from err return
Date:   Thu, 21 Nov 2019 09:54:06 +0800
Message-ID: <20191121015410.18852-3-bibby.hsieh@mediatek.com>
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

VGhhdCBtYWtlIGRlYnVnZ2luZyBjb25mdXNlaWRseSB3aGVuIHdlIE9SIHR3byBlcnJvciByZXR1
cm4gbnVtYmVyLg0KDQpTaWduZWQtb2ZmLWJ5OiBCaWJieSBIc2llaCA8YmliYnkuaHNpZWhAbWVk
aWF0ZWsuY29tPg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQotLS0N
CiBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyB8IDExICsrKysrKysrLS0t
DQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIGIvZHJpdmVy
cy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCmluZGV4IDNjODJkZTVmOTQxNy4uYzhm
YjY5Nzg3NjQ5IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVs
cGVyLmMNCisrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQpAQCAt
MTQ5LDEzICsxNDksMTYgQEAgaW50IGNtZHFfcGt0X3dyaXRlX21hc2soc3RydWN0IGNtZHFfcGt0
ICpwa3QsIHU4IHN1YnN5cywNCiAJCQl1MTYgb2Zmc2V0LCB1MzIgdmFsdWUsIHUzMiBtYXNrKQ0K
IHsNCiAJdTMyIG9mZnNldF9tYXNrID0gb2Zmc2V0Ow0KLQlpbnQgZXJyID0gMDsNCisJaW50IGVy
cjsNCiANCiAJaWYgKG1hc2sgIT0gMHhmZmZmZmZmZikgew0KIAkJZXJyID0gY21kcV9wa3RfYXBw
ZW5kX2NvbW1hbmQocGt0LCBDTURRX0NPREVfTUFTSywgMCwgfm1hc2spOw0KKwkJaWYgKGVyciA8
IDApDQorCQkJcmV0dXJuIGVycjsNCisNCiAJCW9mZnNldF9tYXNrIHw9IENNRFFfV1JJVEVfRU5B
QkxFX01BU0s7DQogCX0NCi0JZXJyIHw9IGNtZHFfcGt0X3dyaXRlKHBrdCwgc3Vic3lzLCBvZmZz
ZXRfbWFzaywgdmFsdWUpOw0KKwllcnIgPSBjbWRxX3BrdF93cml0ZShwa3QsIHN1YnN5cywgb2Zm
c2V0X21hc2ssIHZhbHVlKTsNCiANCiAJcmV0dXJuIGVycjsNCiB9DQpAQCAtMTk3LDkgKzIwMCwx
MSBAQCBzdGF0aWMgaW50IGNtZHFfcGt0X2ZpbmFsaXplKHN0cnVjdCBjbWRxX3BrdCAqcGt0KQ0K
IA0KIAkvKiBpbnNlcnQgRU9DIGFuZCBnZW5lcmF0ZSBJUlEgZm9yIGVhY2ggY29tbWFuZCBpdGVy
YXRpb24gKi8NCiAJZXJyID0gY21kcV9wa3RfYXBwZW5kX2NvbW1hbmQocGt0LCBDTURRX0NPREVf
RU9DLCAwLCBDTURRX0VPQ19JUlFfRU4pOw0KKwlpZiAoZXJyIDwgMCkNCisJCXJldHVybiBlcnI7
DQogDQogCS8qIEpVTVAgdG8gZW5kICovDQotCWVyciB8PSBjbWRxX3BrdF9hcHBlbmRfY29tbWFu
ZChwa3QsIENNRFFfQ09ERV9KVU1QLCAwLCBDTURRX0pVTVBfUEFTUyk7DQorCWVyciA9IGNtZHFf
cGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgQ01EUV9DT0RFX0pVTVAsIDAsIENNRFFfSlVNUF9QQVNT
KTsNCiANCiAJcmV0dXJuIGVycjsNCiB9DQotLSANCjIuMTguMA0K

