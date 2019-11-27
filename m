Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFF9C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E047A207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kG21XOIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfK0B7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 20:59:17 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:8751 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725883AbfK0B7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 20:59:16 -0500
X-UUID: c2c7f94cdc2c464eb1e75a48527d6207-20191127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=FdRT2zy0znueH9kDzJ8afxW0I077oey2yRxx8zkCk4Q=;
        b=kG21XOIs27pTOrs2bdjYa/6ARaUymBILlLM+0EhTYBy0gzeNMmzWLCasC1yA9efX0akCB2nJUWdkmNBp3hHXzh+xP+1PqYp5RsP9dVqgTI0+sWiuko9oT4pKPREHfPr9JMMxL5nEVXMO9Z9+a+Y1kTrozLX0ln3KD75uIWbMs4g=;
X-UUID: c2c7f94cdc2c464eb1e75a48527d6207-20191127
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2094393305; Wed, 27 Nov 2019 09:59:10 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Nov 2019 09:59:00 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Nov 2019 09:58:18 +0800
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
Subject: [PATCH v2 04/14] mailbox: mediatek: cmdq: clear task in channel before shutdown
Date:   Wed, 27 Nov 2019 09:58:47 +0800
Message-ID: <1574819937-6246-6-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RG8gc3VjY2VzcyBjYWxsYmFjayBpbiBjaGFubmVsIHdoZW4gc2h1dGRvd24uIEZvciB0aG9zZSB0
YXNrIG5vdCBmaW5pc2gsDQpjYWxsYmFjayB3aXRoIGVycm9yIGNvZGUgdGh1cyBjbGllbnQgaGFz
IGNoYW5jZSB0byBjbGVhbnVwIG9yIHJlc2V0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMg
SHNpZWggPGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL21haWxi
b3gvbXRrLWNtZHEtbWFpbGJveC5jIHwgMjYgKysrKysrKysrKysrKysrKysrKysrKysrKysNCiAx
IGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
YWlsYm94L210ay1jbWRxLW1haWxib3guYyBiL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWls
Ym94LmMNCmluZGV4IGZkNTE5YjZmNTE4Yi4uYzEyYTc2OGQxMTc1IDEwMDY0NA0KLS0tIGEvZHJp
dmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KKysrIGIvZHJpdmVycy9tYWlsYm94L210
ay1jbWRxLW1haWxib3guYw0KQEAgLTQ1MCw2ICs0NTAsMzIgQEAgc3RhdGljIGludCBjbWRxX21i
b3hfc3RhcnR1cChzdHJ1Y3QgbWJveF9jaGFuICpjaGFuKQ0KIA0KIHN0YXRpYyB2b2lkIGNtZHFf
bWJveF9zaHV0ZG93bihzdHJ1Y3QgbWJveF9jaGFuICpjaGFuKQ0KIHsNCisJc3RydWN0IGNtZHFf
dGhyZWFkICp0aHJlYWQgPSAoc3RydWN0IGNtZHFfdGhyZWFkICopY2hhbi0+Y29uX3ByaXY7DQor
CXN0cnVjdCBjbWRxICpjbWRxID0gZGV2X2dldF9kcnZkYXRhKGNoYW4tPm1ib3gtPmRldik7DQor
CXN0cnVjdCBjbWRxX3Rhc2sgKnRhc2ssICp0bXA7DQorCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQor
DQorCXNwaW5fbG9ja19pcnFzYXZlKCZ0aHJlYWQtPmNoYW4tPmxvY2ssIGZsYWdzKTsNCisJaWYg
KGxpc3RfZW1wdHkoJnRocmVhZC0+dGFza19idXN5X2xpc3QpKQ0KKwkJZ290byBkb25lOw0KKw0K
KwlXQVJOX09OKGNtZHFfdGhyZWFkX3N1c3BlbmQoY21kcSwgdGhyZWFkKSA8IDApOw0KKw0KKwkv
KiBtYWtlIHN1cmUgZXhlY3V0ZWQgdGFza3MgaGF2ZSBzdWNjZXNzIGNhbGxiYWNrICovDQorCWNt
ZHFfdGhyZWFkX2lycV9oYW5kbGVyKGNtZHEsIHRocmVhZCk7DQorCWlmIChsaXN0X2VtcHR5KCZ0
aHJlYWQtPnRhc2tfYnVzeV9saXN0KSkNCisJCWdvdG8gZG9uZTsNCisNCisJbGlzdF9mb3JfZWFj
aF9lbnRyeV9zYWZlKHRhc2ssIHRtcCwgJnRocmVhZC0+dGFza19idXN5X2xpc3QsDQorCQkJCSBs
aXN0X2VudHJ5KSB7DQorCQljbWRxX3Rhc2tfZXhlY19kb25lKHRhc2ssIC1FQ09OTkFCT1JURUQp
Ow0KKwkJa2ZyZWUodGFzayk7DQorCX0NCisNCisJY21kcV90aHJlYWRfZGlzYWJsZShjbWRxLCB0
aHJlYWQpOw0KKwljbGtfZGlzYWJsZShjbWRxLT5jbG9jayk7DQorZG9uZToNCisJc3Bpbl91bmxv
Y2tfaXJxcmVzdG9yZSgmdGhyZWFkLT5jaGFuLT5sb2NrLCBmbGFncyk7DQogfQ0KIA0KIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgbWJveF9jaGFuX29wcyBjbWRxX21ib3hfY2hhbl9vcHMgPSB7DQotLSAN
CjIuMTguMA0K

