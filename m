Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD3BC00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 06:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F30E24656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 06:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qNhRiucI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgAHGll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 01:41:41 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:55915 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726363AbgAHGlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 01:41:40 -0500
X-UUID: 00b877da1b914559a485678c772bbdd3-20200108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Z3p+k5fRT+BgS94lsRRnQ42u+9SyIJjnxvp8DEGY2wI=;
        b=qNhRiucICqlBx+Y+59ESLxCc2e5aZgsvS+l/pGrJDnitBxwZ2WZ+NnVNP3lrXBtaK0gKM4jcD5+zJB8Kyearpdxq+s8js8y7SqxgWvBwyu0avqq033KZLg0yXHJbnk73/jXdKjz6XsPBFrGCYmByf7DtxJYJGHZsCvwVmwlO288=;
X-UUID: 00b877da1b914559a485678c772bbdd3-20200108
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ming-fan.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2092648211; Wed, 08 Jan 2020 14:41:33 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 8 Jan 2020 14:41:05 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 8 Jan 2020 14:39:59 +0800
From:   Ming-Fan Chen <ming-fan.chen@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Yong Wu <yong.wu@mediatek.com>, Evan Green <evgreen@chromium.org>,
        Joerg Roedel <jroedel@suse.de>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Ming-Fan Chen <ming-fan.chen@mediatek.com>
Subject: [PATCH v3 2/3] memory: mtk-smi: Add basic support for MT6779
Date:   Wed, 8 Jan 2020 14:41:30 +0800
Message-ID: <1578465691-30692-4-git-send-email-ming-fan.chen@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1578465691-30692-1-git-send-email-ming-fan.chen@mediatek.com>
References: <1578465691-30692-1-git-send-email-ming-fan.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHNtaS1sYXJiIGFuZCBzbWktY29tbW9uIG5vZGVzIGFuZCBjb25maWdfcG9ydCBmb3IgTVQ2
Nzc5Lg0KDQpjaGFuZ2Vsb2cgc2luY2UgdjI6DQpTcGxpdCBiYXNpYyBub2RlcyBhbmQgY29uZmln
X3BvcnQgc3VwcG9ydCBmcm9tIGluaXRpYWwgZ29sZGVuIHNldHRpbmcgcGF0Y2gNCg0KU2lnbmVk
LW9mZi1ieTogTWluZy1GYW4gQ2hlbiA8bWluZy1mYW4uY2hlbkBtZWRpYXRlay5jb20+DQotLS0N
CiBkcml2ZXJzL21lbW9yeS9tdGstc21pLmMgfCAgIDIyICsrKysrKysrKysrKysrKysrKysrKysN
CiAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9tZW1vcnkvbXRrLXNtaS5jIGIvZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jDQppbmRleCA0Mzlk
N2Q4Li5kMGI3NDdhIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jDQorKysg
Yi9kcml2ZXJzL21lbW9yeS9tdGstc21pLmMNCkBAIC0yMzksNiArMjM5LDEzIEBAIHN0YXRpYyB2
b2lkIG10a19zbWlfbGFyYl9jb25maWdfcG9ydF9nZW4xKHN0cnVjdCBkZXZpY2UgKmRldikNCiAJ
LmxhcmJfZGlyZWN0X3RvX2NvbW1vbl9tYXNrID0gQklUKDgpIHwgQklUKDkpLCAgICAgIC8qIGJk
cHN5cyAqLw0KIH07DQogDQorc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfc21pX2xhcmJfZ2VuIG10
a19zbWlfbGFyYl9tdDY3NzkgPSB7DQorCS5jb25maWdfcG9ydCAgPSBtdGtfc21pX2xhcmJfY29u
ZmlnX3BvcnRfZ2VuMl9nZW5lcmFsLA0KKwkubGFyYl9kaXJlY3RfdG9fY29tbW9uX21hc2sgPQ0K
KwkJQklUKDQpIHwgQklUKDYpIHwgQklUKDExKSB8IEJJVCgxMikgfCBCSVQoMTMpLA0KKwkJLyog
RFVNTVkgfCBJUFUwIHwgSVBVMSB8IENDVSB8IE1ETEEgKi8NCit9Ow0KKw0KIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgbXRrX3NtaV9sYXJiX2dlbiBtdGtfc21pX2xhcmJfbXQ4MTgzID0gew0KIAkuaGFz
X2dhbHMgICAgICAgICAgICAgICAgICAgPSB0cnVlLA0KIAkuY29uZmlnX3BvcnQgICAgICAgICAg
ICAgICAgPSBtdGtfc21pX2xhcmJfY29uZmlnX3BvcnRfZ2VuMl9nZW5lcmFsLA0KQEAgLTI2MCw2
ICsyNjcsMTAgQEAgc3RhdGljIHZvaWQgbXRrX3NtaV9sYXJiX2NvbmZpZ19wb3J0X2dlbjEoc3Ry
dWN0IGRldmljZSAqZGV2KQ0KIAkJLmRhdGEgPSAmbXRrX3NtaV9sYXJiX210MjcxMg0KIAl9LA0K
IAl7DQorCQkuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDY3Nzktc21pLWxhcmIiLA0KKwkJLmRh
dGEgPSAmbXRrX3NtaV9sYXJiX210Njc3OQ0KKwl9LA0KKwl7DQogCQkuY29tcGF0aWJsZSA9ICJt
ZWRpYXRlayxtdDgxODMtc21pLWxhcmIiLA0KIAkJLmRhdGEgPSAmbXRrX3NtaV9sYXJiX210ODE4
Mw0KIAl9LA0KQEAgLTM4Niw2ICszOTcsMTMgQEAgc3RhdGljIGludCBfX21heWJlX3VudXNlZCBt
dGtfc21pX2xhcmJfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQogCS5nZW4gPSBNVEtfU01J
X0dFTjIsDQogfTsNCiANCitzdGF0aWMgY29uc3Qgc3RydWN0IG10a19zbWlfY29tbW9uX3BsYXQg
bXRrX3NtaV9jb21tb25fbXQ2Nzc5ID0gew0KKwkuZ2VuCQk9IE1US19TTUlfR0VOMiwNCisJLmhh
c19nYWxzCT0gdHJ1ZSwNCisJLmJ1c19zZWwJPSBGX01NVTFfTEFSQigxKSB8IEZfTU1VMV9MQVJC
KDIpIHwgRl9NTVUxX0xBUkIoNCkgfA0KKwkJCSAgRl9NTVUxX0xBUkIoNSkgfCBGX01NVTFfTEFS
Qig2KSB8IEZfTU1VMV9MQVJCKDcpLA0KK307DQorDQogc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtf
c21pX2NvbW1vbl9wbGF0IG10a19zbWlfY29tbW9uX210ODE4MyA9IHsNCiAJLmdlbiAgICAgID0g
TVRLX1NNSV9HRU4yLA0KIAkuaGFzX2dhbHMgPSB0cnVlLA0KQEAgLTQwNyw2ICs0MjUsMTAgQEAg
c3RhdGljIGludCBfX21heWJlX3VudXNlZCBtdGtfc21pX2xhcmJfc3VzcGVuZChzdHJ1Y3QgZGV2
aWNlICpkZXYpDQogCQkuZGF0YSA9ICZtdGtfc21pX2NvbW1vbl9nZW4yLA0KIAl9LA0KIAl7DQor
CQkuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDY3Nzktc21pLWNvbW1vbiIsDQorCQkuZGF0YSA9
ICZtdGtfc21pX2NvbW1vbl9tdDY3NzksDQorCX0sDQorCXsNCiAJCS5jb21wYXRpYmxlID0gIm1l
ZGlhdGVrLG10ODE4My1zbWktY29tbW9uIiwNCiAJCS5kYXRhID0gJm10a19zbWlfY29tbW9uX210
ODE4MywNCiAJfSwNCi0tIA0KMS43LjkuNQ0K

