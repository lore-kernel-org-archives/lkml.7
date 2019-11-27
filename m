Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C892C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 02:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D136F207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 02:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="e/cd3KnW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfK0CAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 21:00:05 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:27971 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727179AbfK0B7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 20:59:19 -0500
X-UUID: a8dc599bfab643f78ea09e26e03b1609-20191127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=c04uTlKMAuDikNWMu5PVVMKDbJWfigV3WXc3DE/9nHE=;
        b=e/cd3KnWmFMjTGCNOjIYDsFdCva8BwKjok9CYJdh3ESeruu96HDcWYCPZ2VOLEgtICopxQq26cnZUQZ2tzmh9Wg/bxGYBY19OIQqYcz7iMOnd3Q9qzjEdwnc4BGF4ZFHWm0vzvZl6GXqTYFdeDasfB/T9tSQQCgmDMLs6bMQbG0=;
X-UUID: a8dc599bfab643f78ea09e26e03b1609-20191127
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 697112271; Wed, 27 Nov 2019 09:59:12 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Nov 2019 09:59:02 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Nov 2019 09:58:20 +0800
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
Subject: [PATCH v2 13/14] soc: mediatek: cmdq: add wait no clear event function
Date:   Wed, 27 Nov 2019 09:58:56 +0800
Message-ID: <1574819937-6246-15-git-send-email-dennis-yc.hsieh@mediatek.com>
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

QWRkIHdhaXQgbm8gY2xlYXIgZXZlbnQgZnVuY3Rpb24gaW4gY21kcSBoZWxwZXIgZnVuY3Rpb25z
IHRvIHdhaXQgc3BlY2lmaWMNCmV2ZW50IHdpdGhvdXQgY2xlYXIgdG8gMCBhZnRlciByZWNlaXZl
IGl0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMgSHNpZWggPGRlbm5pcy15Yy5oc2llaEBt
ZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIu
YyB8IDE1ICsrKysrKysrKysrKysrKw0KIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1j
bWRxLmggIHwgMTAgKysrKysrKysrKw0KIDIgZmlsZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygr
KQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMg
Yi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KaW5kZXggMTBhOWI0NDgx
ZTU4Li42ZjI3MGZhZGZiNTAgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGst
Y21kcS1oZWxwZXIuYw0KKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVy
LmMNCkBAIC0zMzAsNiArMzMwLDIxIEBAIGludCBjbWRxX3BrdF93ZmUoc3RydWN0IGNtZHFfcGt0
ICpwa3QsIHUxNiBldmVudCkNCiB9DQogRVhQT1JUX1NZTUJPTChjbWRxX3BrdF93ZmUpOw0KIA0K
K2ludCBjbWRxX3BrdF93YWl0X25vX2NsZWFyKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgZXZl
bnQpDQorew0KKwlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsNCisNCisJ
aWYgKGV2ZW50ID49IENNRFFfTUFYX0VWRU5UKQ0KKwkJcmV0dXJuIC1FSU5WQUw7DQorDQorCWlu
c3Qub3AgPSBDTURRX0NPREVfV0ZFOw0KKwlpbnN0LnZhbHVlID0gQ01EUV9XRkVfV0FJVCB8IENN
RFFfV0ZFX1dBSVRfVkFMVUU7DQorCWluc3QuZXZlbnQgPSBldmVudDsNCisNCisJcmV0dXJuIGNt
ZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQorfQ0KK0VYUE9SVF9TWU1CT0woY21k
cV9wa3Rfd2FpdF9ub19jbGVhcik7DQorDQogaW50IGNtZHFfcGt0X2NsZWFyX2V2ZW50KHN0cnVj
dCBjbWRxX3BrdCAqcGt0LCB1MTYgZXZlbnQpDQogew0KIAlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlv
biBpbnN0ID0geyB7MH0gfTsNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRl
ay9tdGstY21kcS5oIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KaW5k
ZXggZDE1ZDhjOTQxOTkyLi40MGJjNjFhZDhkMzEgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4
L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQorKysgYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRl
ay9tdGstY21kcS5oDQpAQCAtMTQ5LDYgKzE0OSwxNiBAQCBpbnQgY21kcV9wa3Rfd3JpdGVfc192
YWx1ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgZG1hX2FkZHJfdCBhZGRyLA0KICAqLw0KIGludCBj
bWRxX3BrdF93ZmUoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBldmVudCk7DQogDQorLyoqDQor
ICogY21kcV9wa3Rfd2FpdF9ub19jbGVhcigpIC0gQXBwZW5kIHdhaXQgZm9yIGV2ZW50IGNvbW1h
bmQgdG8gdGhlIENNRFEgcGFja2V0LA0KKyAqCQkJICAgICAgd2l0aG91dCB1cGRhdGUgZXZlbnQg
dG8gMCBhZnRlciByZWNlaXZlIGl0Lg0KKyAqIEBwa3Q6CXRoZSBDTURRIHBhY2tldA0KKyAqIEBl
dmVudDoJdGhlIGRlc2lyZWQgZXZlbnQgdHlwZSB0byB3YWl0DQorICoNCisgKiBSZXR1cm46IDAg
Zm9yIHN1Y2Nlc3M7IGVsc2UgdGhlIGVycm9yIGNvZGUgaXMgcmV0dXJuZWQNCisgKi8NCitpbnQg
Y21kcV9wa3Rfd2FpdF9ub19jbGVhcihzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGV2ZW50KTsN
CisNCiAvKioNCiAgKiBjbWRxX3BrdF9jbGVhcl9ldmVudCgpIC0gYXBwZW5kIGNsZWFyIGV2ZW50
IGNvbW1hbmQgdG8gdGhlIENNRFEgcGFja2V0DQogICogQHBrdDoJdGhlIENNRFEgcGFja2V0DQot
LSANCjIuMTguMA0K

