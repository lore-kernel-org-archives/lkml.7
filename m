Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB7CC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D540C2071C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="d6zeW8uA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfKUJNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 04:13:35 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:45026 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726574AbfKUJNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 04:13:32 -0500
X-UUID: 3861f1e60fd14421a968ebbfe705f6a8-20191121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=VqkAt8rgN3zVcjynrIl0FW+8LhE3QB8tyJbsUpCHPIA=;
        b=d6zeW8uAFApCk2+xL8nkvsnceaDu84aXDWu62+MEvq/mVNkBqJBl1fIEWt51d8vvf75x0EmiwKCaQ7fIRLaSvvFXnWgINgXd43tXWZynfiglT9kxY3rJGPFyTlS6p/AfJNyJ7Qit+lyYLWsgcUv1P8UcxgyH15+xqNijnEhbXms=;
X-UUID: 3861f1e60fd14421a968ebbfe705f6a8-20191121
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2037561247; Thu, 21 Nov 2019 17:13:27 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 21 Nov 2019 17:13:19 +0800
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
        "Dennis YC Hsieh" <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v1 12/12] soc: mediatek: cmdq: add set event function
Date:   Thu, 21 Nov 2019 17:12:32 +0800
Message-ID: <1574327552-11806-13-git-send-email-dennis-yc.hsieh@mediatek.com>
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

QWRkIHNldCBldmVudCBmdW5jdGlvbiBpbiBjbWRxIGhlbHBlciBmdW5jdGlvbnMgdG8gc2V0IHNw
ZWNpZmljIGV2ZW50Lg0KDQpTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMgSHNpZWggPGRlbm5pcy15
Yy5oc2llaEBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21k
cS1oZWxwZXIuYyAgIHwgICAxNSArKysrKysrKysrKysrKysNCiBpbmNsdWRlL2xpbnV4L21haWxi
b3gvbXRrLWNtZHEtbWFpbGJveC5oIHwgICAgMSArDQogaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0
ZWsvbXRrLWNtZHEuaCAgICB8ICAgIDkgKysrKysrKysrDQogMyBmaWxlcyBjaGFuZ2VkLCAyNSBp
bnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21k
cS1oZWxwZXIuYyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQppbmRl
eCA3ZjFlMzMyLi5kZDI5OTY4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRr
LWNtZHEtaGVscGVyLmMNCisrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBl
ci5jDQpAQCAtMzUzLDYgKzM1MywyMSBAQCBpbnQgY21kcV9wa3RfY2xlYXJfZXZlbnQoc3RydWN0
IGNtZHFfcGt0ICpwa3QsIHUxNiBldmVudCkNCiB9DQogRVhQT1JUX1NZTUJPTChjbWRxX3BrdF9j
bGVhcl9ldmVudCk7DQogDQoraW50IGNtZHFfcGt0X3NldF9ldmVudChzdHJ1Y3QgY21kcV9wa3Qg
KnBrdCwgdTE2IGV2ZW50KQ0KK3sNCisJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHsg
ezB9IH07DQorDQorCWlmIChldmVudCA+PSBDTURRX01BWF9FVkVOVCkNCisJCXJldHVybiAtRUlO
VkFMOw0KKw0KKwlpbnN0Lm9wID0gQ01EUV9DT0RFX1dGRTsNCisJaW5zdC52YWx1ZSA9IENNRFFf
V0ZFX1VQREFURSB8IENNRFFfV0ZFX1VQREFURV9WQUxVRTsNCisJaW5zdC5ldmVudCA9IGV2ZW50
Ow0KKw0KKwlyZXR1cm4gY21kcV9wa3RfYXBwZW5kX2NvbW1hbmQocGt0LCBpbnN0KTsNCit9DQor
RVhQT1JUX1NZTUJPTChjbWRxX3BrdF9zZXRfZXZlbnQpOw0KKw0KIGludCBjbWRxX3BrdF9wb2xs
KHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBzdWJzeXMsDQogCQkgIHUxNiBvZmZzZXQsIHUzMiB2
YWx1ZSkNCiB7DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1h
aWxib3guaCBiL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCmluZGV4
IDNmNmJjMGQuLmRiZWRkYTYgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRr
LWNtZHEtbWFpbGJveC5oDQorKysgYi9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFp
bGJveC5oDQpAQCAtMTcsNiArMTcsNyBAQA0KICNkZWZpbmUgQ01EUV9KVU1QX1BBU1MJCQlDTURR
X0lOU1RfU0laRQ0KIA0KICNkZWZpbmUgQ01EUV9XRkVfVVBEQVRFCQkJQklUKDMxKQ0KKyNkZWZp
bmUgQ01EUV9XRkVfVVBEQVRFX1ZBTFVFCQlCSVQoMTYpDQogI2RlZmluZSBDTURRX1dGRV9XQUlU
CQkJQklUKDE1KQ0KICNkZWZpbmUgQ01EUV9XRkVfV0FJVF9WQUxVRQkJMHgxDQogDQpkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCBiL2luY2x1ZGUvbGlu
dXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCmluZGV4IDUyMTE4MjcuLjg0ZGJmMGUgMTAwNjQ0
DQotLS0gYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQorKysgYi9pbmNs
dWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQpAQCAtMTY3LDYgKzE2NywxNSBAQCBp
bnQgY21kcV9wa3RfbWVtX21vdmUoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHBoeXNfYWRkcl90IHNy
Y19hZGRyLA0KIGludCBjbWRxX3BrdF9jbGVhcl9ldmVudChzdHJ1Y3QgY21kcV9wa3QgKnBrdCwg
dTE2IGV2ZW50KTsNCiANCiAvKioNCisgKiBjbWRxX3BrdF9zZXRfZXZlbnQoKSAtIGFwcGVuZCBz
ZXQgZXZlbnQgY29tbWFuZCB0byB0aGUgQ01EUSBwYWNrZXQNCisgKiBAcGt0Ogl0aGUgQ01EUSBw
YWNrZXQNCisgKiBAZXZlbnQ6CXRoZSBkZXNpcmVkIGV2ZW50IHRvIGJlIHNldA0KKyAqDQorICog
UmV0dXJuOiAwIGZvciBzdWNjZXNzOyBlbHNlIHRoZSBlcnJvciBjb2RlIGlzIHJldHVybmVkDQor
ICovDQoraW50IGNtZHFfcGt0X3NldF9ldmVudChzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGV2
ZW50KTsNCisNCisvKioNCiAgKiBjbWRxX3BrdF9wb2xsKCkgLSBBcHBlbmQgcG9sbGluZyBjb21t
YW5kIHRvIHRoZSBDTURRIHBhY2tldCwgYXNrIEdDRSB0bw0KICAqCQkgICAgIGV4ZWN1dGUgYW4g
aW5zdHJ1Y3Rpb24gdGhhdCB3YWl0IGZvciBhIHNwZWNpZmllZA0KICAqCQkgICAgIGhhcmR3YXJl
IHJlZ2lzdGVyIHRvIGNoZWNrIGZvciB0aGUgdmFsdWUgdy9vIG1hc2suDQotLSANCjEuNy45LjUN
Cg==

