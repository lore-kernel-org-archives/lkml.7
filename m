Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852DFC3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 591B520863
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jp7M8Fml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbgABECZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 23:02:25 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:21283 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727617AbgABECX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 23:02:23 -0500
X-UUID: 39791f4b2e614a41b3bdd965e4ca986c-20200102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=WZibcIXENQqD/QYNVuPSeY7uijgfthNFPSvOXqGUZGw=;
        b=jp7M8FmlNmDz3OW65YDTq0AfPd/VHZP3aSVtHmK9A5iEEhpPUji99/TDydcv+R5uSIP5yqa3MfSc9WPsnkescX/IXcEwyE9BhFjOON22XrGO77PJ5Y+goyBq+Wgws8MHI/vgz5i/Zq2gFAlywrj5iGEqF/mUDR1YK8Q+od1Ltms=;
X-UUID: 39791f4b2e614a41b3bdd965e4ca986c-20200102
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1902967522; Thu, 02 Jan 2020 12:02:17 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 2 Jan 2020 12:01:50 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 2 Jan 2020 12:01:35 +0800
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
Subject: [PATCH v6, 03/14] drm/mediatek: make sout select function  format same with select input
Date:   Thu, 2 Jan 2020 12:00:13 +0800
Message-ID: <1577937624-14313-4-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1577937624-14313-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1577937624-14313-1-git-send-email-yongqiang.niu@mediatek.com>
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
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcC5jDQppbmRleCA5MWM5YjE5Li5mOTlm
ODlhMSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcC5j
DQorKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHAuYw0KQEAgLTM4OSwx
NyArMzg5LDIzIEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgbXRrX2RkcF9zZWxfaW4oZW51bSBtdGtf
ZGRwX2NvbXBfaWQgY3VyLA0KIAlyZXR1cm4gdmFsdWU7DQogfQ0KIA0KLXN0YXRpYyB2b2lkIG10
a19kZHBfc291dF9zZWwoc3RydWN0IHJlZ21hcCAqY29uZmlnX3JlZ3MsDQotCQkJICAgICBlbnVt
IG10a19kZHBfY29tcF9pZCBjdXIsDQotCQkJICAgICBlbnVtIG10a19kZHBfY29tcF9pZCBuZXh0
KQ0KK3N0YXRpYyB1bnNpZ25lZCBpbnQgbXRrX2RkcF9zb3V0X3NlbChlbnVtIG10a19kZHBfY29t
cF9pZCBjdXIsDQorCQkJCSAgICAgZW51bSBtdGtfZGRwX2NvbXBfaWQgbmV4dCwNCisJCQkJICAg
ICB1bnNpZ25lZCBpbnQgKmFkZHIpDQogew0KKwl1bnNpZ25lZCBpbnQgdmFsdWU7DQorDQogCWlm
IChjdXIgPT0gRERQX0NPTVBPTkVOVF9CTFMgJiYgbmV4dCA9PSBERFBfQ09NUE9ORU5UX0RTSTAp
IHsNCi0JCXJlZ21hcF93cml0ZShjb25maWdfcmVncywgRElTUF9SRUdfQ09ORklHX09VVF9TRUws
DQotCQkJCUJMU19UT19EU0lfUkRNQTFfVE9fRFBJMSk7DQorCQkqYWRkciA9IERJU1BfUkVHX0NP
TkZJR19PVVRfU0VMOw0KKwkJdmFsdWUgPSBCTFNfVE9fRFNJX1JETUExX1RPX0RQSTE7DQogCX0g
ZWxzZSBpZiAoY3VyID09IEREUF9DT01QT05FTlRfQkxTICYmIG5leHQgPT0gRERQX0NPTVBPTkVO
VF9EUEkwKSB7DQotCQlyZWdtYXBfd3JpdGUoY29uZmlnX3JlZ3MsIERJU1BfUkVHX0NPTkZJR19P
VVRfU0VMLA0KLQkJCQlCTFNfVE9fRFBJX1JETUExX1RPX0RTSSk7DQorCQkqYWRkciA9IERJU1Bf
UkVHX0NPTkZJR19PVVRfU0VMOw0KKwkJdmFsdWUgPSBCTFNfVE9fRFBJX1JETUExX1RPX0RTSTsN
CisJfSBlbHNlIHsNCisJCXZhbHVlID0gMDsNCiAJfQ0KKw0KKwlyZXR1cm4gdmFsdWU7DQogfQ0K
IA0KIHZvaWQgbXRrX2RkcF9hZGRfY29tcF90b19wYXRoKHN0cnVjdCByZWdtYXAgKmNvbmZpZ19y
ZWdzLA0KQEAgLTQxMiw3ICs0MTgsOSBAQCB2b2lkIG10a19kZHBfYWRkX2NvbXBfdG9fcGF0aChz
dHJ1Y3QgcmVnbWFwICpjb25maWdfcmVncywNCiAJaWYgKHZhbHVlKQ0KIAkJcmVnbWFwX3VwZGF0
ZV9iaXRzKGNvbmZpZ19yZWdzLCBhZGRyLCB2YWx1ZSwgdmFsdWUpOw0KIA0KLQltdGtfZGRwX3Nv
dXRfc2VsKGNvbmZpZ19yZWdzLCBjdXIsIG5leHQpOw0KKwl2YWx1ZSA9IG10a19kZHBfc291dF9z
ZWwoY3VyLCBuZXh0LCAmYWRkcik7DQorCWlmICh2YWx1ZSkNCisJCXJlZ21hcF91cGRhdGVfYml0
cyhjb25maWdfcmVncywgYWRkciwgdmFsdWUsIHZhbHVlKTsNCiANCiAJdmFsdWUgPSBtdGtfZGRw
X3NlbF9pbihjdXIsIG5leHQsICZhZGRyKTsNCiAJaWYgKHZhbHVlKQ0KLS0gDQoxLjguMS4xLmRp
cnR5DQo=

