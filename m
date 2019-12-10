Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B64BC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 06:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBCC206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 06:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sJZrI6zH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfLJGrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 01:47:18 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:11717 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727024AbfLJGrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 01:47:17 -0500
X-UUID: 855c82a3196849a0a7aae2ccc33bb042-20191210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=AM4klYb7yCh8DLgLsvXyxgJHtcik12wFYLAScG39BXg=;
        b=sJZrI6zHq3uGC5o0cpJZOsOAVfofL45pgCN6lDarGXhHtbOp9FXQQJlXqksaTE4y2pPYfa2ouivUCspB6FHRc8vDhErdMk43qHNZTCGRh4T4CXMBjGTpCi8dKcaYfRU5z5oAfAJ7jwu3MEfUI/XUlpPMoH1yw0BP8LSvk8SFMaQ=;
X-UUID: 855c82a3196849a0a7aae2ccc33bb042-20191210
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1817536322; Tue, 10 Dec 2019 14:47:13 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 10 Dec 2019 14:47:05 +0800
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
Subject: [PATCH v9 6/9] soc: mediatek: Add extra sram control
Date:   Tue, 10 Dec 2019 14:46:50 +0800
Message-ID: <1575960413-6900-7-git-send-email-weiyi.lu@mediatek.com>
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

Rm9yIHNvbWUgcG93ZXIgZG9tYWlucyBsaWtlIHZwdV9jb3JlIG9uIE1UODE4MyB3aG9zZSBzcmFt
IG5lZWQgdG8NCmRvIGNsb2NrIGFuZCBpbnRlcm5hbCBpc29sYXRpb24gd2hpbGUgcG93ZXIgb24v
b2ZmIHNyYW0uDQpXZSBhZGQgYSBmbGFnICJzcmFtX2lzb19jdHJsIiBpbiBzY3BfZG9tYWluX2Rh
dGEgdG8ganVkZ2UgaWYgd2UNCm5lZWQgdG8gZG8gdGhlIGV4dHJhIHNyYW0gaXNvbGF0aW9uIGNv
bnRyb2wgb3Igbm90Lg0KDQpTaWduZWQtb2ZmLWJ5OiBXZWl5aSBMdSA8d2VpeWkubHVAbWVkaWF0
ZWsuY29tPg0KLS0tDQogZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXNjcHN5cy5jIHwgMjUgKysr
KysrKysrKysrKysrKysrKysrKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRr
LXNjcHN5cy5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXNjcHN5cy5jDQppbmRleCAyYmJm
OTA3Li4wNjc2YjQ2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXNjcHN5
cy5jDQorKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmMNCkBAIC01Nyw2ICs1
Nyw4IEBADQogI2RlZmluZSBQV1JfT05fQklUCQkJQklUKDIpDQogI2RlZmluZSBQV1JfT05fMk5E
X0JJVAkJCUJJVCgzKQ0KICNkZWZpbmUgUFdSX0NMS19ESVNfQklUCQkJQklUKDQpDQorI2RlZmlu
ZSBQV1JfU1JBTV9DTEtJU09fQklUCQlCSVQoNSkNCisjZGVmaW5lIFBXUl9TUkFNX0lTT0lOVF9C
X0JJVAkJQklUKDYpDQogDQogI2RlZmluZSBQV1JfU1RBVFVTX0NPTk4JCQlCSVQoMSkNCiAjZGVm
aW5lIFBXUl9TVEFUVVNfRElTUAkJCUJJVCgzKQ0KQEAgLTExNSw2ICsxMTcsOCBAQCBlbnVtIGNs
a19pZCB7DQogICogQG5hbWU6IFRoZSBkb21haW4gbmFtZS4NCiAgKiBAc3RhX21hc2s6IFRoZSBt
YXNrIGZvciBwb3dlciBvbi9vZmYgc3RhdHVzIGJpdC4NCiAgKiBAY3RsX29mZnM6IFRoZSBvZmZz
ZXQgZm9yIG1haW4gcG93ZXIgY29udHJvbCByZWdpc3Rlci4NCisgKiBAc3JhbV9pc29fY3RybDog
VGhlIGZsYWcgdG8ganVkZ2UgaWYgdGhlIHBvd2VyIGRvbWFpbiBuZWVkIHRvIGRvDQorICogICAg
ICAgICAgICAgICAgIHRoZSBleHRyYSBzcmFtIGlzb2xhdGlvbiBjb250cm9sLg0KICAqIEBzcmFt
X3Bkbl9iaXRzOiBUaGUgbWFzayBmb3Igc3JhbSBwb3dlciBjb250cm9sIGJpdHMuDQogICogQHNy
YW1fcGRuX2Fja19iaXRzOiBUaGUgbWFzayBmb3Igc3JhbSBwb3dlciBjb250cm9sIGFja2VkIGJp
dHMuDQogICogQGJ1c19wcm90X21hc2s6IFRoZSBtYXNrIGZvciBzaW5nbGUgc3RlcCBidXMgcHJv
dGVjdGlvbi4NCkBAIC0xMzAsNiArMTM0LDcgQEAgc3RydWN0IHNjcF9kb21haW5fZGF0YSB7DQog
CWNvbnN0IGNoYXIgKm5hbWU7DQogCXUzMiBzdGFfbWFzazsNCiAJaW50IGN0bF9vZmZzOw0KKwli
b29sIHNyYW1faXNvX2N0cmw7DQogCXUzMiBzcmFtX3Bkbl9iaXRzOw0KIAl1MzIgc3JhbV9wZG5f
YWNrX2JpdHM7DQogCXUzMiBidXNfcHJvdF9tYXNrOw0KQEAgLTI2OSw2ICsyNzQsMTQgQEAgc3Rh
dGljIGludCBzY3BzeXNfc3JhbV9lbmFibGUoc3RydWN0IHNjcF9kb21haW4gKnNjcGQsIHZvaWQg
X19pb21lbSAqY3RsX2FkZHIpDQogCQkJcmV0dXJuIHJldDsNCiAJfQ0KIA0KKwlpZiAoc2NwZC0+
ZGF0YS0+c3JhbV9pc29fY3RybCkJew0KKwkJdmFsID0gcmVhZGwoY3RsX2FkZHIpIHwgUFdSX1NS
QU1fSVNPSU5UX0JfQklUOw0KKwkJd3JpdGVsKHZhbCwgY3RsX2FkZHIpOw0KKwkJdWRlbGF5KDEp
Ow0KKwkJdmFsICY9IH5QV1JfU1JBTV9DTEtJU09fQklUOw0KKwkJd3JpdGVsKHZhbCwgY3RsX2Fk
ZHIpOw0KKwl9DQorDQogCXJldHVybiAwOw0KIH0NCiANCkBAIC0yNzgsOCArMjkxLDE2IEBAIHN0
YXRpYyBpbnQgc2Nwc3lzX3NyYW1fZGlzYWJsZShzdHJ1Y3Qgc2NwX2RvbWFpbiAqc2NwZCwgdm9p
ZCBfX2lvbWVtICpjdGxfYWRkcikNCiAJdTMyIHBkbl9hY2sgPSBzY3BkLT5kYXRhLT5zcmFtX3Bk
bl9hY2tfYml0czsNCiAJaW50IHRtcDsNCiANCi0JdmFsID0gcmVhZGwoY3RsX2FkZHIpOw0KLQl2
YWwgfD0gc2NwZC0+ZGF0YS0+c3JhbV9wZG5fYml0czsNCisJaWYgKHNjcGQtPmRhdGEtPnNyYW1f
aXNvX2N0cmwpCXsNCisJCXZhbCA9IHJlYWRsKGN0bF9hZGRyKTsNCisJCXZhbCB8PSBQV1JfU1JB
TV9DTEtJU09fQklUOw0KKwkJd3JpdGVsKHZhbCwgY3RsX2FkZHIpOw0KKwkJdmFsICY9IH5QV1Jf
U1JBTV9JU09JTlRfQl9CSVQ7DQorCQl3cml0ZWwodmFsLCBjdGxfYWRkcik7DQorCQl1ZGVsYXko
MSk7DQorCX0NCisNCisJdmFsID0gcmVhZGwoY3RsX2FkZHIpIHwgc2NwZC0+ZGF0YS0+c3JhbV9w
ZG5fYml0czsNCiAJd3JpdGVsKHZhbCwgY3RsX2FkZHIpOw0KIA0KIAkvKiBFaXRoZXIgd2FpdCB1
bnRpbCBTUkFNX1BETl9BQ0sgYWxsIDEgb3IgMCAqLw0KLS0gDQoxLjguMS4xLmRpcnR5DQo=

