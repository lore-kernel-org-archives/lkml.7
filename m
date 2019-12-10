Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77201C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 06:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45DEE206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 06:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FFXQvowq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfLJGrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 01:47:21 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:5886 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726950AbfLJGrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 01:47:18 -0500
X-UUID: cc3bf6704016451f8bc3d60938d051ea-20191210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=bjEwZOajHRTsCwlXnYQg/z3J8I+P+Fu/Wqga7go7+kg=;
        b=FFXQvowqVtxKe+s63RiU2f0kzyz/vsdpxcgkKxq7tgFK+35w4bNqsD0v+MEHK8nurpECiHWaFRso1/l8Rd80WS7JjdnmoOETofUhOM6aqiJaHlebVVIYqIlw9B4no3x8mCC91gyOQgMeDgiA5MpKvESjd2OSG8M8gINBnn6loBw=;
X-UUID: cc3bf6704016451f8bc3d60938d051ea-20191210
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1191030409; Tue, 10 Dec 2019 14:47:13 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 10 Dec 2019 14:47:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 10 Dec 2019 14:47:17 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH v9 3/9] soc: mediatek: Add basic_clk_id to scp_power_data
Date:   Tue, 10 Dec 2019 14:46:47 +0800
Message-ID: <1575960413-6900-4-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1575960413-6900-1-git-send-email-weiyi.lu@mediatek.com>
References: <1575960413-6900-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VHJ5IHRvIHN0b3AgZXh0ZW5kaW5nIHRoZSBjbGtfaWQgb3IgY2xrX25hbWVzIGlmIHRoZXJlIGFy
ZQ0KbW9yZSBhbmQgbW9yZSBuZXcgQkFTSUMgY2xvY2tzLiBUbyBnZXQgaXRzIG93biBjbG9ja3Mg
YnkgdGhlDQpiYXNpY19jbGtfaWQgb2YgZWFjaCBwb3dlciBkb21haW4uDQoNClNpZ25lZC1vZmYt
Ynk6IFdlaXlpIEx1IDx3ZWl5aS5sdUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstc2Nwc3lzLmMgfCAyOSArKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQ0K
IDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KDQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXNjcHN5cy5jIGIvZHJpdmVycy9zb2Mv
bWVkaWF0ZWsvbXRrLXNjcHN5cy5jDQppbmRleCBmNjY5ZDM3Li45MTVkNjM1IDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXNjcHN5cy5jDQorKysgYi9kcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstc2Nwc3lzLmMNCkBAIC0xMTcsNiArMTE3LDggQEAgZW51bSBjbGtfaWQgew0K
ICAqIEBzcmFtX3Bkbl9hY2tfYml0czogVGhlIG1hc2sgZm9yIHNyYW0gcG93ZXIgY29udHJvbCBh
Y2tlZCBiaXRzLg0KICAqIEBidXNfcHJvdF9tYXNrOiBUaGUgbWFzayBmb3Igc2luZ2xlIHN0ZXAg
YnVzIHByb3RlY3Rpb24uDQogICogQGNsa19pZDogVGhlIGJhc2ljIGNsb2NrcyByZXF1aXJlZCBi
eSB0aGlzIHBvd2VyIGRvbWFpbi4NCisgKiBAYmFzaWNfY2xrX2lkOiBwcm92aWRlIHRoZSBzYW1l
IHB1cnBvc2Ugd2l0aCBmaWVsZCAiY2xrX2lkIg0KKyAqICAgICAgICAgICAgICAgIGJ5IGRlY2xh
cmluZyBiYXNpYyBjbG9jayBwcmVmaXggbmFtZSByYXRoZXIgdGhhbiBjbGtfaWQuDQogICogQGNh
cHM6IFRoZSBmbGFnIGZvciBhY3RpdmUgd2FrZS11cCBhY3Rpb24uDQogICovDQogc3RydWN0IHNj
cF9kb21haW5fZGF0YSB7DQpAQCAtMTI3LDYgKzEyOSw3IEBAIHN0cnVjdCBzY3BfZG9tYWluX2Rh
dGEgew0KIAl1MzIgc3JhbV9wZG5fYWNrX2JpdHM7DQogCXUzMiBidXNfcHJvdF9tYXNrOw0KIAll
bnVtIGNsa19pZCBjbGtfaWRbTUFYX0NMS1NdOw0KKwljb25zdCBjaGFyICpiYXNpY19jbGtfaWRb
TUFYX0NMS1NdOw0KIAl1OCBjYXBzOw0KIH07DQogDQpAQCAtNDkzLDE2ICs0OTYsMjYgQEAgc3Rh
dGljIHN0cnVjdCBzY3AgKmluaXRfc2NwKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsDQog
DQogCQlzY3BkLT5kYXRhID0gZGF0YTsNCiANCi0JCWZvciAoaiA9IDA7IGogPCBNQVhfQ0xLUyAm
JiBkYXRhLT5jbGtfaWRbal07IGorKykgew0KLQkJCXN0cnVjdCBjbGsgKmMgPSBjbGtbZGF0YS0+
Y2xrX2lkW2pdXTsNCisJCWlmIChkYXRhLT5jbGtfaWRbMF0pIHsNCisJCQlXQVJOX09OKGRhdGEt
PmJhc2ljX2Nsa19pZFswXSk7DQogDQotCQkJaWYgKElTX0VSUihjKSkgew0KLQkJCQlkZXZfZXJy
KCZwZGV2LT5kZXYsICIlczogY2xrIHVuYXZhaWxhYmxlXG4iLA0KLQkJCQkJZGF0YS0+bmFtZSk7
DQotCQkJCXJldHVybiBFUlJfQ0FTVChjKTsNCi0JCQl9DQorCQkJZm9yIChqID0gMDsgaiA8IE1B
WF9DTEtTICYmIGRhdGEtPmNsa19pZFtqXTsgaisrKSB7DQorCQkJCXN0cnVjdCBjbGsgKmMgPSBj
bGtbZGF0YS0+Y2xrX2lkW2pdXTsNCisNCisJCQkJaWYgKElTX0VSUihjKSkgew0KKwkJCQkJZGV2
X2VycigmcGRldi0+ZGV2LA0KKwkJCQkJCSIlczogY2xrIHVuYXZhaWxhYmxlXG4iLA0KKwkJCQkJ
CWRhdGEtPm5hbWUpOw0KKwkJCQkJcmV0dXJuIEVSUl9DQVNUKGMpOw0KKwkJCQl9DQogDQotCQkJ
c2NwZC0+Y2xrW2pdID0gYzsNCisJCQkJc2NwZC0+Y2xrW2pdID0gYzsNCisJCQl9DQorCQl9IGVs
c2UgaWYgKGRhdGEtPmJhc2ljX2Nsa19pZFswXSkgew0KKwkJCWZvciAoaiA9IDA7IGogPCBNQVhf
Q0xLUyAmJg0KKwkJCQkJZGF0YS0+YmFzaWNfY2xrX2lkW2pdOyBqKyspDQorCQkJCXNjcGQtPmNs
a1tqXSA9IGRldm1fY2xrX2dldCgmcGRldi0+ZGV2LA0KKwkJCQkJCWRhdGEtPmJhc2ljX2Nsa19p
ZFtqXSk7DQogCQl9DQogDQogCQlnZW5wZC0+bmFtZSA9IGRhdGEtPm5hbWU7DQotLSANCjEuOC4x
LjEuZGlydHkNCg==

