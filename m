Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA74C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F732071E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="grzPbgtO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfK0BSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 20:18:08 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:36225 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725851AbfK0BSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 20:18:08 -0500
X-UUID: b1d2e2b438744ddd84fe632dc4d218cf-20191127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ukDKw46dJ6kUKB8fK1XW/KSDkxflYgyotMjPJ393R3U=;
        b=grzPbgtOoaYuYOJcAIbOpqz1hVI4MKTPAvxuH57zO63yI/7B33G/kWWwgPTRKaJ860f+kFp6kEWJvM+2wxeSzPwgZuSl6V2Lt6BxV0sWUsHdF/HMTj15L4HMD9E3FYsGkZ4Ygwvu9wOYWFWKar8+H52dmls1CanI5jwjN3ghRoc=;
X-UUID: b1d2e2b438744ddd84fe632dc4d218cf-20191127
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 450978565; Wed, 27 Nov 2019 09:18:03 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Nov 2019 09:17:49 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Nov 2019 09:17:10 +0800
From:   <yongqiang.niu@mediatek.com>
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
Subject: [PATCH v1, 1/2] drm/mediatek: Fixup external display black screen issue
Date:   Wed, 27 Nov 2019 09:17:54 +0800
Message-ID: <1574817475-22378-2-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1574817475-22378-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1574817475-22378-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWW9uZ3FpYW5nIE5pdSA8eW9uZ3FpYW5nLm5pdUBtZWRpYXRlay5jb20+DQoNClByb2Js
ZW06DQpvdmVybGF5IGhhbmd1cCB3aGVuIGV4dGVybmFsIGRpc3BsYXkgaG90cGx1dCB0ZXN0DQoN
CkZpeDoNCmRpc2FibGUgb3ZlcmxheSB3aGVuIGNydGMgZGlzYWJsZQ0KDQpTaWduZWQtb2ZmLWJ5
OiBZb25ncWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyB8IDM5ICsrKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCAxNCBk
ZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2NydGMuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KaW5k
ZXggNGZiMzQ2Yy4uN2VjYTAyZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHJtX2NydGMuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
Y3J0Yy5jDQpAQCAtMzY5LDYgKzM2OSwyMCBAQCBzdGF0aWMgaW50IG10a19jcnRjX2RkcF9od19p
bml0KHN0cnVjdCBtdGtfZHJtX2NydGMgKm10a19jcnRjKQ0KIAltdGtfZGlzcF9tdXRleF9hZGRf
Y29tcChtdGtfY3J0Yy0+bXV0ZXgsIG10a19jcnRjLT5kZHBfY29tcFtpXS0+aWQpOw0KIAltdGtf
ZGlzcF9tdXRleF9lbmFibGUobXRrX2NydGMtPm11dGV4KTsNCiANCisJLyogSW5pdGlhbGx5IGNv
bmZpZ3VyZSBhbGwgcGxhbmVzICovDQorCWZvciAoaSA9IDA7IGkgPCBtdGtfY3J0Yy0+bGF5ZXJf
bnI7IGkrKykgew0KKwkJc3RydWN0IGRybV9wbGFuZSAqcGxhbmUgPSAmbXRrX2NydGMtPnBsYW5l
c1tpXTsNCisJCXN0cnVjdCBtdGtfcGxhbmVfc3RhdGUgKnBsYW5lX3N0YXRlOw0KKwkJc3RydWN0
IG10a19kZHBfY29tcCAqY29tcDsNCisJCXVuc2lnbmVkIGludCBsb2NhbF9sYXllcjsNCisNCisJ
CXBsYW5lX3N0YXRlID0gdG9fbXRrX3BsYW5lX3N0YXRlKHBsYW5lLT5zdGF0ZSk7DQorCQljb21w
ID0gbXRrX2RybV9kZHBfY29tcF9mb3JfcGxhbmUoY3J0YywgcGxhbmUsICZsb2NhbF9sYXllcik7
DQorCQlpZiAoY29tcCkNCisJCQltdGtfZGRwX2NvbXBfbGF5ZXJfY29uZmlnKGNvbXAsIGxvY2Fs
X2xheWVyLA0KKwkJCQkJCSAgcGxhbmVfc3RhdGUsIE5VTEwpOw0KKwl9DQorDQogCWZvciAoaSA9
IDA7IGkgPCBtdGtfY3J0Yy0+ZGRwX2NvbXBfbnI7IGkrKykgew0KIAkJc3RydWN0IG10a19kZHBf
Y29tcCAqY29tcCA9IG10a19jcnRjLT5kZHBfY29tcFtpXTsNCiAJCWVudW0gbXRrX2RkcF9jb21w
X2lkIHByZXY7DQpAQCAtMzg1LDIwICszOTksNiBAQCBzdGF0aWMgaW50IG10a19jcnRjX2RkcF9o
d19pbml0KHN0cnVjdCBtdGtfZHJtX2NydGMgKm10a19jcnRjKQ0KIAkJbXRrX2RkcF9jb21wX3N0
YXJ0KGNvbXApOw0KIAl9DQogDQotCS8qIEluaXRpYWxseSBjb25maWd1cmUgYWxsIHBsYW5lcyAq
Lw0KLQlmb3IgKGkgPSAwOyBpIDwgbXRrX2NydGMtPmxheWVyX25yOyBpKyspIHsNCi0JCXN0cnVj
dCBkcm1fcGxhbmUgKnBsYW5lID0gJm10a19jcnRjLT5wbGFuZXNbaV07DQotCQlzdHJ1Y3QgbXRr
X3BsYW5lX3N0YXRlICpwbGFuZV9zdGF0ZTsNCi0JCXN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXA7
DQotCQl1bnNpZ25lZCBpbnQgbG9jYWxfbGF5ZXI7DQotDQotCQlwbGFuZV9zdGF0ZSA9IHRvX210
a19wbGFuZV9zdGF0ZShwbGFuZS0+c3RhdGUpOw0KLQkJY29tcCA9IG10a19kcm1fZGRwX2NvbXBf
Zm9yX3BsYW5lKGNydGMsIHBsYW5lLCAmbG9jYWxfbGF5ZXIpOw0KLQkJaWYgKGNvbXApDQotCQkJ
bXRrX2RkcF9jb21wX2xheWVyX2NvbmZpZyhjb21wLCBsb2NhbF9sYXllciwNCi0JCQkJCQkgIHBs
YW5lX3N0YXRlLCBOVUxMKTsNCi0JfQ0KLQ0KIAlyZXR1cm4gMDsNCiANCiBlcnJfbXV0ZXhfdW5w
cmVwYXJlOg0KQEAgLTYwNywxMCArNjA3LDIxIEBAIHN0YXRpYyB2b2lkIG10a19kcm1fY3J0Y19h
dG9taWNfZGlzYWJsZShzdHJ1Y3QgZHJtX2NydGMgKmNydGMsDQogCWZvciAoaSA9IDA7IGkgPCBt
dGtfY3J0Yy0+bGF5ZXJfbnI7IGkrKykgew0KIAkJc3RydWN0IGRybV9wbGFuZSAqcGxhbmUgPSAm
bXRrX2NydGMtPnBsYW5lc1tpXTsNCiAJCXN0cnVjdCBtdGtfcGxhbmVfc3RhdGUgKnBsYW5lX3N0
YXRlOw0KKwkJc3RydWN0IG10a19kZHBfY29tcCAqY29tcCA9IG10a19jcnRjLT5kZHBfY29tcFsw
XTsNCisJCXVuc2lnbmVkIGludCBjb21wX2xheWVyX25yID0gbXRrX2RkcF9jb21wX2xheWVyX25y
KGNvbXApOw0KKwkJdW5zaWduZWQgaW50IGxvY2FsX2xheWVyOw0KIA0KIAkJcGxhbmVfc3RhdGUg
PSB0b19tdGtfcGxhbmVfc3RhdGUocGxhbmUtPnN0YXRlKTsNCiAJCXBsYW5lX3N0YXRlLT5wZW5k
aW5nLmVuYWJsZSA9IGZhbHNlOw0KIAkJcGxhbmVfc3RhdGUtPnBlbmRpbmcuY29uZmlnID0gdHJ1
ZTsNCisNCisJCWlmIChpID49IGNvbXBfbGF5ZXJfbnIpIHsNCisJCQljb21wID0gbXRrX2NydGMt
PmRkcF9jb21wWzFdOw0KKwkJCWxvY2FsX2xheWVyID0gaSAtIGNvbXBfbGF5ZXJfbnI7DQorCQl9
IGVsc2UNCisJCQlsb2NhbF9sYXllciA9IGk7DQorCQltdGtfZGRwX2NvbXBfbGF5ZXJfY29uZmln
KGNvbXAsIGxvY2FsX2xheWVyLA0KKwkJCQkJICBwbGFuZV9zdGF0ZSwgTlVMTCk7DQogCX0NCiAJ
bXRrX2NydGMtPnBlbmRpbmdfcGxhbmVzID0gdHJ1ZTsNCiANCi0tIA0KMS44LjEuMS5kaXJ0eQ0K

