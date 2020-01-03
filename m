Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D85DC32771
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412D221D7D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="q0fn4pqg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgACDMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 22:12:46 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:17761 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727220AbgACDMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 22:12:44 -0500
X-UUID: 6713f9f1ff8b4680b05f0387b109e23c-20200103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=AZ8/447VJNbbd8DAVi6I6/qkJI1QbjXzazXWfml24wA=;
        b=q0fn4pqgagjxgpBgzihGor5o8A4jr+2KJlA+TX5r7WchdhmIPRz+jVJNSGpN4i09qQCATx9uRMGPCZXcZSHl+mk7keLNRYwK7vggY2OgLMADD21O3fpaO5yU2OrQfk7G7nPu6cX1eAm9CeENOdfnpiE/rEHeX55Xuk58Xp45rHo=;
X-UUID: 6713f9f1ff8b4680b05f0387b109e23c-20200103
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1034473864; Fri, 03 Jan 2020 11:12:40 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 3 Jan 2020 11:12:13 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 3 Jan 2020 11:13:07 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [RESEND PATCH v6 04/17] drm/mediatek: make sout select function format same with select input
Date:   Fri, 3 Jan 2020 11:12:15 +0800
Message-ID: <1578021148-32413-5-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1578021148-32413-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1578021148-32413-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dGhlcmUgd2lsbCBiZSBtb3JlIHNvdXQgY2FzZSBpbiB0aGUgZnV0dXJlLA0KbWFrZSB0aGUgc291
dCBmdW5jdGlvbiBmb3JtYXQgc2FtZSBtdGtfZGRwX3NlbF9pbg0KDQpTaWduZWQtb2ZmLWJ5OiBZ
b25ncWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcC5jIHwgMjQgKysrKysrKysrKysrKysrKy0tLS0t
LS0tDQogMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHAuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcC5jDQppbmRleCBkNjZjZTMxLi5hZTA4
ZmM0IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwLmMN
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcC5jDQpAQCAtMzg2LDE3
ICszODYsMjMgQEAgc3RhdGljIHVuc2lnbmVkIGludCBtdGtfZGRwX3NlbF9pbihlbnVtIG10a19k
ZHBfY29tcF9pZCBjdXIsDQogCXJldHVybiB2YWx1ZTsNCiB9DQogDQotc3RhdGljIHZvaWQgbXRr
X2RkcF9zb3V0X3NlbChzdHJ1Y3QgcmVnbWFwICpjb25maWdfcmVncywNCi0JCQkgICAgIGVudW0g
bXRrX2RkcF9jb21wX2lkIGN1ciwNCi0JCQkgICAgIGVudW0gbXRrX2RkcF9jb21wX2lkIG5leHQp
DQorc3RhdGljIHVuc2lnbmVkIGludCBtdGtfZGRwX3NvdXRfc2VsKGVudW0gbXRrX2RkcF9jb21w
X2lkIGN1ciwNCisJCQkJICAgICBlbnVtIG10a19kZHBfY29tcF9pZCBuZXh0LA0KKwkJCQkgICAg
IHVuc2lnbmVkIGludCAqYWRkcikNCiB7DQorCXVuc2lnbmVkIGludCB2YWx1ZTsNCisNCiAJaWYg
KGN1ciA9PSBERFBfQ09NUE9ORU5UX0JMUyAmJiBuZXh0ID09IEREUF9DT01QT05FTlRfRFNJMCkg
ew0KLQkJcmVnbWFwX3dyaXRlKGNvbmZpZ19yZWdzLCBESVNQX1JFR19DT05GSUdfT1VUX1NFTCwN
Ci0JCQkJQkxTX1RPX0RTSV9SRE1BMV9UT19EUEkxKTsNCisJCSphZGRyID0gRElTUF9SRUdfQ09O
RklHX09VVF9TRUw7DQorCQl2YWx1ZSA9IEJMU19UT19EU0lfUkRNQTFfVE9fRFBJMTsNCiAJfSBl
bHNlIGlmIChjdXIgPT0gRERQX0NPTVBPTkVOVF9CTFMgJiYgbmV4dCA9PSBERFBfQ09NUE9ORU5U
X0RQSTApIHsNCi0JCXJlZ21hcF93cml0ZShjb25maWdfcmVncywgRElTUF9SRUdfQ09ORklHX09V
VF9TRUwsDQotCQkJCUJMU19UT19EUElfUkRNQTFfVE9fRFNJKTsNCisJCSphZGRyID0gRElTUF9S
RUdfQ09ORklHX09VVF9TRUw7DQorCQl2YWx1ZSA9IEJMU19UT19EUElfUkRNQTFfVE9fRFNJOw0K
Kwl9IGVsc2Ugew0KKwkJdmFsdWUgPSAwOw0KIAl9DQorDQorCXJldHVybiB2YWx1ZTsNCiB9DQog
DQogdm9pZCBtdGtfZGRwX2FkZF9jb21wX3RvX3BhdGgoc3RydWN0IHJlZ21hcCAqY29uZmlnX3Jl
Z3MsDQpAQCAtNDA5LDcgKzQxNSw5IEBAIHZvaWQgbXRrX2RkcF9hZGRfY29tcF90b19wYXRoKHN0
cnVjdCByZWdtYXAgKmNvbmZpZ19yZWdzLA0KIAlpZiAodmFsdWUpDQogCQlyZWdtYXBfdXBkYXRl
X2JpdHMoY29uZmlnX3JlZ3MsIGFkZHIsIHZhbHVlLCB2YWx1ZSk7DQogDQotCW10a19kZHBfc291
dF9zZWwoY29uZmlnX3JlZ3MsIGN1ciwgbmV4dCk7DQorCXZhbHVlID0gbXRrX2RkcF9zb3V0X3Nl
bChjdXIsIG5leHQsICZhZGRyKTsNCisJaWYgKHZhbHVlKQ0KKwkJcmVnbWFwX3VwZGF0ZV9iaXRz
KGNvbmZpZ19yZWdzLCBhZGRyLCB2YWx1ZSwgdmFsdWUpOw0KIA0KIAl2YWx1ZSA9IG10a19kZHBf
c2VsX2luKGN1ciwgbmV4dCwgJmFkZHIpOw0KIAlpZiAodmFsdWUpDQotLSANCjEuOC4xLjEuZGly
dHkNCg==

