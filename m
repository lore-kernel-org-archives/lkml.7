Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FC0C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005DB2071C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UB0m91Vu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfKUJNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 04:13:36 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:45026 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726747AbfKUJNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 04:13:34 -0500
X-UUID: c04b750d1dc0418896f8d8868ce1b5da-20191121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=UJ8CVpRl5qpmELbv5i/7Rub+Aa7T5EcEvIQVudHKMAA=;
        b=UB0m91VuRlsALideSZ8BLurhlBdtU0UK24OQ1eEnE7uVuTly9OD3QjOTnh9XgPZrUfnA/GOt/0vfz7fRpDenAwycTEAq2sMMWWcy7A0zv+MSXupcMvf9TN7/tRxsWNZUjCtQJXEwi2AIWTf8G6z5nbxAcBsQr/hzCN0SSI8N+ks=;
X-UUID: c04b750d1dc0418896f8d8868ce1b5da-20191121
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 684465046; Thu, 21 Nov 2019 17:13:27 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 21 Nov 2019 17:13:21 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Nov 2019 17:13:30 +0800
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
Subject: [PATCH v1 11/12] soc: mediatek: cmdq: add wait no clear event function
Date:   Thu, 21 Nov 2019 17:12:31 +0800
Message-ID: <1574327552-11806-12-git-send-email-dennis-yc.hsieh@mediatek.com>
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

QWRkIHdhaXQgbm8gY2xlYXIgZXZlbnQgZnVuY3Rpb24gaW4gY21kcSBoZWxwZXIgZnVuY3Rpb25z
IHRvIHdhaXQgc3BlY2lmaWMNCmV2ZW50IHdpdGhvdXQgY2xlYXIgdG8gMCBhZnRlciByZWNlaXZl
IGl0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMgSHNpZWggPGRlbm5pcy15Yy5oc2llaEBt
ZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIu
YyB8ICAgMTUgKysrKysrKysrKysrKysrDQogaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRr
LWNtZHEuaCAgfCAgIDEwICsrKysrKysrKysNCiAyIGZpbGVzIGNoYW5nZWQsIDI1IGluc2VydGlv
bnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBl
ci5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCmluZGV4IDNiMTAy
NDEuLjdmMWUzMzIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1o
ZWxwZXIuYw0KKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCkBA
IC0zMjMsNiArMzIzLDIxIEBAIGludCBjbWRxX3BrdF93ZmUoc3RydWN0IGNtZHFfcGt0ICpwa3Qs
IHUxNiBldmVudCkNCiB9DQogRVhQT1JUX1NZTUJPTChjbWRxX3BrdF93ZmUpOw0KIA0KK2ludCBj
bWRxX3BrdF93YWl0X25vX2NsZWFyKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgZXZlbnQpDQor
ew0KKwlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsNCisNCisJaWYgKGV2
ZW50ID49IENNRFFfTUFYX0VWRU5UKQ0KKwkJcmV0dXJuIC1FSU5WQUw7DQorDQorCWluc3Qub3Ag
PSBDTURRX0NPREVfV0ZFOw0KKwlpbnN0LnZhbHVlID0gQ01EUV9XRkVfV0FJVCB8IENNRFFfV0ZF
X1dBSVRfVkFMVUU7DQorCWluc3QuZXZlbnQgPSBldmVudDsNCisNCisJcmV0dXJuIGNtZHFfcGt0
X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQorfQ0KK0VYUE9SVF9TWU1CT0woY21kcV9wa3Rf
d2FpdF9ub19jbGVhcik7DQorDQogaW50IGNtZHFfcGt0X2NsZWFyX2V2ZW50KHN0cnVjdCBjbWRx
X3BrdCAqcGt0LCB1MTYgZXZlbnQpDQogew0KIAlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0
ID0geyB7MH0gfTsNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGst
Y21kcS5oIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KaW5kZXggNzdl
ODk0NC4uNTIxMTgyNyAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210
ay1jbWRxLmgNCisrKyBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCkBA
IC0xNDgsNiArMTQ4LDE2IEBAIGludCBjbWRxX3BrdF9tZW1fbW92ZShzdHJ1Y3QgY21kcV9wa3Qg
KnBrdCwgcGh5c19hZGRyX3Qgc3JjX2FkZHIsDQogaW50IGNtZHFfcGt0X3dmZShzdHJ1Y3QgY21k
cV9wa3QgKnBrdCwgdTE2IGV2ZW50KTsNCiANCiAvKioNCisgKiBjbWRxX3BrdF93YWl0X25vX2Ns
ZWFyKCkgLSBBcHBlbmQgd2FpdCBmb3IgZXZlbnQgY29tbWFuZCB0byB0aGUgQ01EUSBwYWNrZXQs
DQorICoJCQkgICAgICB3aXRob3V0IHVwZGF0ZSBldmVudCB0byAwIGFmdGVyIHJlY2VpdmUgaXQu
DQorICogQHBrdDoJdGhlIENNRFEgcGFja2V0DQorICogQGV2ZW50Ogl0aGUgZGVzaXJlZCBldmVu
dCB0eXBlIHRvIHdhaXQNCisgKg0KKyAqIFJldHVybjogMCBmb3Igc3VjY2VzczsgZWxzZSB0aGUg
ZXJyb3IgY29kZSBpcyByZXR1cm5lZA0KKyAqLw0KK2ludCBjbWRxX3BrdF93YWl0X25vX2NsZWFy
KHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgZXZlbnQpOw0KKw0KKy8qKg0KICAqIGNtZHFfcGt0
X2NsZWFyX2V2ZW50KCkgLSBhcHBlbmQgY2xlYXIgZXZlbnQgY29tbWFuZCB0byB0aGUgQ01EUSBw
YWNrZXQNCiAgKiBAcGt0Ogl0aGUgQ01EUSBwYWNrZXQNCiAgKiBAZXZlbnQ6CXRoZSBkZXNpcmVk
IGV2ZW50IHRvIGJlIGNsZWFyZWQNCi0tIA0KMS43LjkuNQ0K

