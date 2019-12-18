Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE78C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 08:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB6D227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 08:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CCxXhGGA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfLRIbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 03:31:02 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:22872 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725797AbfLRIbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 03:31:01 -0500
X-UUID: b5898738e7c04e579f47dde2d5742359-20191218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=qhKN5WCrE6NondREBgkOsegHHegoC/CoETvPSlY37GI=;
        b=CCxXhGGAGuM3uwJKst/0naiJFxMMErRmfPoDpSOfDvhPSBrBpA2cFjCaCXo8nPiQzQVHljAplOmm9crNhGzHDooCagQ1npOdBWfYEIQuYh3NKk0WdbBloavSbd7BjUpIHRQOwAQIhYLAgILLDKEiF6N+58LCFU3WyWTFqYhyN0Q=;
X-UUID: b5898738e7c04e579f47dde2d5742359-20191218
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1337671125; Wed, 18 Dec 2019 16:30:59 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 18 Dec 2019 16:30:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 18 Dec 2019 16:30:30 +0800
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
Subject: [PATCH v10 09/12] soc: mediatek: Add extra sram control
Date:   Wed, 18 Dec 2019 16:30:45 +0800
Message-ID: <1576657848-14711-10-git-send-email-weiyi.lu@mediatek.com>
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

Rm9yIHNvbWUgcG93ZXIgZG9tYWlucyBsaWtlIHZwdV9jb3JlIG9uIE1UODE4MyB3aG9zZSBzcmFt
IG5lZWQgdG8NCmRvIGNsb2NrIGFuZCBpbnRlcm5hbCBpc29sYXRpb24gd2hpbGUgcG93ZXIgb24v
b2ZmIHNyYW0uDQpXZSBhZGQgYSBmbGFnICJzcmFtX2lzb19jdHJsIiBpbiBzY3BfZG9tYWluX2Rh
dGEgdG8ganVkZ2UgaWYgd2UNCm5lZWQgdG8gZG8gdGhlIGV4dHJhIHNyYW0gaXNvbGF0aW9uIGNv
bnRyb2wgb3Igbm90Lg0KDQpTaWduZWQtb2ZmLWJ5OiBXZWl5aSBMdSA8d2VpeWkubHVAbWVkaWF0
ZWsuY29tPg0KLS0tDQogZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXNjcHN5cy5jIHwgMjQgKysr
KysrKysrKysrKysrKysrKysrKy0tDQogMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGst
c2Nwc3lzLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmMNCmluZGV4IDlmMDZm
MTcuLmUwMTBmYjMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lz
LmMNCisrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1zY3BzeXMuYw0KQEAgLTU2LDYgKzU2
LDggQEANCiAjZGVmaW5lIFBXUl9PTl9CSVQJCQlCSVQoMikNCiAjZGVmaW5lIFBXUl9PTl8yTkRf
QklUCQkJQklUKDMpDQogI2RlZmluZSBQV1JfQ0xLX0RJU19CSVQJCQlCSVQoNCkNCisjZGVmaW5l
IFBXUl9TUkFNX0NMS0lTT19CSVQJCUJJVCg1KQ0KKyNkZWZpbmUgUFdSX1NSQU1fSVNPSU5UX0Jf
QklUCQlCSVQoNikNCiANCiAjZGVmaW5lIFBXUl9TVEFUVVNfQ09OTgkJCUJJVCgxKQ0KICNkZWZp
bmUgUFdSX1NUQVRVU19ESVNQCQkJQklUKDMpDQpAQCAtODYsNiArODgsOCBAQA0KICAqIEBuYW1l
OiBUaGUgZG9tYWluIG5hbWUuDQogICogQHN0YV9tYXNrOiBUaGUgbWFzayBmb3IgcG93ZXIgb24v
b2ZmIHN0YXR1cyBiaXQuDQogICogQGN0bF9vZmZzOiBUaGUgb2Zmc2V0IGZvciBtYWluIHBvd2Vy
IGNvbnRyb2wgcmVnaXN0ZXIuDQorICogQHNyYW1faXNvX2N0cmw6IFRoZSBmbGFnIHRvIGp1ZGdl
IGlmIHRoZSBwb3dlciBkb21haW4gbmVlZCB0byBkbw0KKyAqICAgICAgICAgICAgICAgICB0aGUg
ZXh0cmEgc3JhbSBpc29sYXRpb24gY29udHJvbC4NCiAgKiBAc3JhbV9wZG5fYml0czogVGhlIG1h
c2sgZm9yIHNyYW0gcG93ZXIgY29udHJvbCBiaXRzLg0KICAqIEBzcmFtX3Bkbl9hY2tfYml0czog
VGhlIG1hc2sgZm9yIHNyYW0gcG93ZXIgY29udHJvbCBhY2tlZCBiaXRzLg0KICAqIEBiYXNpY19j
bGtfbmFtZTogVGhlIGJhc2ljIGNsb2NrcyByZXF1aXJlZCBieSB0aGlzIHBvd2VyIGRvbWFpbi4N
CkBAIC05OCw2ICsxMDIsNyBAQCBzdHJ1Y3Qgc2NwX2RvbWFpbl9kYXRhIHsNCiAJY29uc3QgY2hh
ciAqbmFtZTsNCiAJdTMyIHN0YV9tYXNrOw0KIAlpbnQgY3RsX29mZnM7DQorCWJvb2wgc3JhbV9p
c29fY3RybDsNCiAJdTMyIHNyYW1fcGRuX2JpdHM7DQogCXUzMiBzcmFtX3Bkbl9hY2tfYml0czsN
CiAJY29uc3QgY2hhciAqYmFzaWNfY2xrX25hbWVbTUFYX0NMS1NdOw0KQEAgLTIzMyw2ICsyMzgs
MTQgQEAgc3RhdGljIGludCBzY3BzeXNfc3JhbV9lbmFibGUoc3RydWN0IHNjcF9kb21haW4gKnNj
cGQsIHZvaWQgX19pb21lbSAqY3RsX2FkZHIpDQogCQkJcmV0dXJuIHJldDsNCiAJfQ0KIA0KKwlp
ZiAoc2NwZC0+ZGF0YS0+c3JhbV9pc29fY3RybCkJew0KKwkJdmFsID0gcmVhZGwoY3RsX2FkZHIp
IHwgUFdSX1NSQU1fSVNPSU5UX0JfQklUOw0KKwkJd3JpdGVsKHZhbCwgY3RsX2FkZHIpOw0KKwkJ
dWRlbGF5KDEpOw0KKwkJdmFsICY9IH5QV1JfU1JBTV9DTEtJU09fQklUOw0KKwkJd3JpdGVsKHZh
bCwgY3RsX2FkZHIpOw0KKwl9DQorDQogCXJldHVybiAwOw0KIH0NCiANCkBAIC0yNDIsOCArMjU1
LDE1IEBAIHN0YXRpYyBpbnQgc2Nwc3lzX3NyYW1fZGlzYWJsZShzdHJ1Y3Qgc2NwX2RvbWFpbiAq
c2NwZCwgdm9pZCBfX2lvbWVtICpjdGxfYWRkcikNCiAJdTMyIHBkbl9hY2sgPSBzY3BkLT5kYXRh
LT5zcmFtX3Bkbl9hY2tfYml0czsNCiAJaW50IHRtcDsNCiANCi0JdmFsID0gcmVhZGwoY3RsX2Fk
ZHIpOw0KLQl2YWwgfD0gc2NwZC0+ZGF0YS0+c3JhbV9wZG5fYml0czsNCisJaWYgKHNjcGQtPmRh
dGEtPnNyYW1faXNvX2N0cmwpCXsNCisJCXZhbCA9IHJlYWRsKGN0bF9hZGRyKSB8IFBXUl9TUkFN
X0NMS0lTT19CSVQ7DQorCQl3cml0ZWwodmFsLCBjdGxfYWRkcik7DQorCQl2YWwgJj0gflBXUl9T
UkFNX0lTT0lOVF9CX0JJVDsNCisJCXdyaXRlbCh2YWwsIGN0bF9hZGRyKTsNCisJCXVkZWxheSgx
KTsNCisJfQ0KKw0KKwl2YWwgPSByZWFkbChjdGxfYWRkcikgfCBzY3BkLT5kYXRhLT5zcmFtX3Bk
bl9iaXRzOw0KIAl3cml0ZWwodmFsLCBjdGxfYWRkcik7DQogDQogCS8qIEVpdGhlciB3YWl0IHVu
dGlsIFNSQU1fUEROX0FDSyBhbGwgMSBvciAwICovDQotLSANCjEuOC4xLjEuZGlydHkNCg==

