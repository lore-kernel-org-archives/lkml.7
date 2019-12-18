Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CE5C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 08:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2CF920717
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 08:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pKdmXfGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfLRIbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 03:31:19 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:9891 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726756AbfLRIbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 03:31:11 -0500
X-UUID: 4c5cd72a24894d94973932ff14ee86d8-20191218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=L0E1r9L0K/BbvQN8uwQYPArtgYpiqPSnwzJeOXZJ3ZI=;
        b=pKdmXfGOdWz/Mfc3iGi22PdULqHIz2Kt9u8CvjCC3ZQmdBleKHVpL2X4/ytXUDUFu2OIB5QF9kKIR3TfXsWZKt089m1x0OnxHDQSVjfu3vd0sMltD1dnsKNnkVRcx2vZNmNCucu6qVxgTvrjM5K+/Lv1EwezFY+M1kBcjyhbcL8=;
X-UUID: 4c5cd72a24894d94973932ff14ee86d8-20191218
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1067388180; Wed, 18 Dec 2019 16:30:59 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 18 Dec 2019 16:30:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 18 Dec 2019 16:30:29 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v10 03/12] soc: mediatek: Add basic_clk_name to scp_power_data
Date:   Wed, 18 Dec 2019 16:30:39 +0800
Message-ID: <1576657848-14711-4-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1576657848-14711-1-git-send-email-weiyi.lu@mediatek.com>
References: <1576657848-14711-1-git-send-email-weiyi.lu@mediatek.com>
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
YnkgdGhlDQpiYXNpY19jbGtfbmFtZSBvZiBlYWNoIHBvd2VyIGRvbWFpbi4NCg0KU2lnbmVkLW9m
Zi1ieTogV2VpeWkgTHUgPHdlaXlpLmx1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvc29j
L21lZGlhdGVrL210ay1zY3BzeXMuYyB8IDI5ICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
DQogMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmMgYi9kcml2ZXJzL3Nv
Yy9tZWRpYXRlay9tdGstc2Nwc3lzLmMNCmluZGV4IGY2NjlkMzcuLjkzNDMyNzcgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmMNCisrKyBiL2RyaXZlcnMvc29j
L21lZGlhdGVrL210ay1zY3BzeXMuYw0KQEAgLTExNyw2ICsxMTcsOCBAQCBlbnVtIGNsa19pZCB7
DQogICogQHNyYW1fcGRuX2Fja19iaXRzOiBUaGUgbWFzayBmb3Igc3JhbSBwb3dlciBjb250cm9s
IGFja2VkIGJpdHMuDQogICogQGJ1c19wcm90X21hc2s6IFRoZSBtYXNrIGZvciBzaW5nbGUgc3Rl
cCBidXMgcHJvdGVjdGlvbi4NCiAgKiBAY2xrX2lkOiBUaGUgYmFzaWMgY2xvY2tzIHJlcXVpcmVk
IGJ5IHRoaXMgcG93ZXIgZG9tYWluLg0KKyAqIEBiYXNpY19jbGtfbmFtZTogcHJvdmlkZSB0aGUg
c2FtZSBwdXJwb3NlIHdpdGggZmllbGQgImNsa19pZCINCisgKiAgICAgICAgICAgICAgICBieSBk
ZWNsYXJpbmcgYmFzaWMgY2xvY2sgcHJlZml4IG5hbWUgcmF0aGVyIHRoYW4gY2xrX2lkLg0KICAq
IEBjYXBzOiBUaGUgZmxhZyBmb3IgYWN0aXZlIHdha2UtdXAgYWN0aW9uLg0KICAqLw0KIHN0cnVj
dCBzY3BfZG9tYWluX2RhdGEgew0KQEAgLTEyNyw2ICsxMjksNyBAQCBzdHJ1Y3Qgc2NwX2RvbWFp
bl9kYXRhIHsNCiAJdTMyIHNyYW1fcGRuX2Fja19iaXRzOw0KIAl1MzIgYnVzX3Byb3RfbWFzazsN
CiAJZW51bSBjbGtfaWQgY2xrX2lkW01BWF9DTEtTXTsNCisJY29uc3QgY2hhciAqYmFzaWNfY2xr
X25hbWVbTUFYX0NMS1NdOw0KIAl1OCBjYXBzOw0KIH07DQogDQpAQCAtNDkzLDE2ICs0OTYsMjYg
QEAgc3RhdGljIHN0cnVjdCBzY3AgKmluaXRfc2NwKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYsDQogDQogCQlzY3BkLT5kYXRhID0gZGF0YTsNCiANCi0JCWZvciAoaiA9IDA7IGogPCBNQVhf
Q0xLUyAmJiBkYXRhLT5jbGtfaWRbal07IGorKykgew0KLQkJCXN0cnVjdCBjbGsgKmMgPSBjbGtb
ZGF0YS0+Y2xrX2lkW2pdXTsNCisJCWlmIChkYXRhLT5jbGtfaWRbMF0pIHsNCisJCQlXQVJOX09O
KGRhdGEtPmJhc2ljX2Nsa19uYW1lWzBdKTsNCiANCi0JCQlpZiAoSVNfRVJSKGMpKSB7DQotCQkJ
CWRldl9lcnIoJnBkZXYtPmRldiwgIiVzOiBjbGsgdW5hdmFpbGFibGVcbiIsDQotCQkJCQlkYXRh
LT5uYW1lKTsNCi0JCQkJcmV0dXJuIEVSUl9DQVNUKGMpOw0KLQkJCX0NCisJCQlmb3IgKGogPSAw
OyBqIDwgTUFYX0NMS1MgJiYgZGF0YS0+Y2xrX2lkW2pdOyBqKyspIHsNCisJCQkJc3RydWN0IGNs
ayAqYyA9IGNsa1tkYXRhLT5jbGtfaWRbal1dOw0KKw0KKwkJCQlpZiAoSVNfRVJSKGMpKSB7DQor
CQkJCQlkZXZfZXJyKCZwZGV2LT5kZXYsDQorCQkJCQkJIiVzOiBjbGsgdW5hdmFpbGFibGVcbiIs
DQorCQkJCQkJZGF0YS0+bmFtZSk7DQorCQkJCQlyZXR1cm4gRVJSX0NBU1QoYyk7DQorCQkJCX0N
CiANCi0JCQlzY3BkLT5jbGtbal0gPSBjOw0KKwkJCQlzY3BkLT5jbGtbal0gPSBjOw0KKwkJCX0N
CisJCX0gZWxzZSBpZiAoZGF0YS0+YmFzaWNfY2xrX25hbWVbMF0pIHsNCisJCQlmb3IgKGogPSAw
OyBqIDwgTUFYX0NMS1MgJiYNCisJCQkJCWRhdGEtPmJhc2ljX2Nsa19uYW1lW2pdOyBqKyspDQor
CQkJCXNjcGQtPmNsa1tqXSA9IGRldm1fY2xrX2dldCgmcGRldi0+ZGV2LA0KKwkJCQkJCWRhdGEt
PmJhc2ljX2Nsa19uYW1lW2pdKTsNCiAJCX0NCiANCiAJCWdlbnBkLT5uYW1lID0gZGF0YS0+bmFt
ZTsNCi0tIA0KMS44LjEuMS5kaXJ0eQ0K

