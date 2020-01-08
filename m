Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77CAC33C99
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B6320848
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UN/z2HQe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgAHBws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 20:52:48 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:46630 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726992AbgAHBwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 20:52:39 -0500
X-UUID: 6b8a1a7eab9c44619f53facb8bed77e5-20200108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Tn+ocDgoE7quv83eopc3270X61VLoovrwR+4z9klDjM=;
        b=UN/z2HQeaTRBMtzEN8N2YwZKlg2M08imkkVHjfba9dVlrUBTnaEdEcNhurpc/hwAKGZa6laqSTRPv8pQaB+Ge9SsZvmKQ16OO0lr5RrkR8r5fD8+SPpHfGM2aKFWDeTi/psFjkl+aY++3/spb3zBxr3ci81fS9x96IznyrxOR5M=;
X-UUID: 6b8a1a7eab9c44619f53facb8bed77e5-20200108
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 263404547; Wed, 08 Jan 2020 09:52:34 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 8 Jan 2020 09:51:57 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 8 Jan 2020 09:53:07 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [RESEND PATCH v5 10/11] phy: phy-mtk-tphy: add a new reference clock
Date:   Wed, 8 Jan 2020 09:52:05 +0800
Message-ID: <1578448326-27455-10-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1578448326-27455-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1578448326-27455-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 394569979869DFA0C5D2DE7AD80DFBA25B01A84F9741918F098C6E7299E92AFF2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXN1YWxseSB0aGUgZGlnaXRhbCBhbmQgYW5hbG9nIHBoeXMgdXNlIHRoZSBzYW1lIHJlZmVyZW5j
ZSBjbG9jaywNCmJ1dCBzb21lIHBsYXRmb3JtcyBoYXZlIHR3byBzZXBhcmF0ZSByZWZlcmVuY2Ug
Y2xvY2tzIGZvciBlYWNoIG9mDQp0aGVtLCBzbyBhZGQgYW5vdGhlciBvcHRpb25hbCBjbG9jayB0
byBzdXBwb3J0IHRoZW0uDQpJbiBvcmRlciB0byBrZWVwIHRoZSBjbG9jayBuYW1lcyBjb25zaXN0
ZW50IHdpdGggUEhZIElQJ3MsIGNoYW5nZQ0KdGhlIGRhX3JlZiBmb3IgYW5hbG9nIHBoeSBhbmQg
cmVmIGNsb2NrIGZvciBkaWdpdGFsIHBoeS4NCg0KU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVu
IDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQp2M352NTogbm8gY2hhbmdlcw0KDQp2
MjogZml4IHR5cG8gb2YgYW5hbG9nDQotLS0NCiBkcml2ZXJzL3BoeS9tZWRpYXRlay9waHktbXRr
LXRwaHkuYyB8IDE5ICsrKysrKysrKysrKysrKysrKy0NCiAxIGZpbGUgY2hhbmdlZCwgMTggaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9waHkvbWVk
aWF0ZWsvcGh5LW10ay10cGh5LmMgYi9kcml2ZXJzL3BoeS9tZWRpYXRlay9waHktbXRrLXRwaHku
Yw0KaW5kZXggYzY0MjRmZDJhMDZkLi5jZGJjYzQ5ZjcxMTUgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L3BoeS9tZWRpYXRlay9waHktbXRrLXRwaHkuYw0KKysrIGIvZHJpdmVycy9waHkvbWVkaWF0ZWsv
cGh5LW10ay10cGh5LmMNCkBAIC0yOTgsNyArMjk4LDggQEAgc3RydWN0IG10a19waHlfaW5zdGFu
Y2Ugew0KIAkJc3RydWN0IHUycGh5X2JhbmtzIHUyX2JhbmtzOw0KIAkJc3RydWN0IHUzcGh5X2Jh
bmtzIHUzX2JhbmtzOw0KIAl9Ow0KLQlzdHJ1Y3QgY2xrICpyZWZfY2xrOwkvKiByZWZlcmVuY2Ug
Y2xvY2sgb2YgYW5vbG9nIHBoeSAqLw0KKwlzdHJ1Y3QgY2xrICpyZWZfY2xrOwkvKiByZWZlcmVu
Y2UgY2xvY2sgb2YgKGRpZ2l0YWwpIHBoeSAqLw0KKwlzdHJ1Y3QgY2xrICpkYV9yZWZfY2xrOwkv
KiByZWZlcmVuY2UgY2xvY2sgb2YgYW5hbG9nIHBoeSAqLw0KIAl1MzIgaW5kZXg7DQogCXU4IHR5
cGU7DQogCWludCBleWVfc3JjOw0KQEAgLTkyNSw2ICs5MjYsMTMgQEAgc3RhdGljIGludCBtdGtf
cGh5X2luaXQoc3RydWN0IHBoeSAqcGh5KQ0KIAkJcmV0dXJuIHJldDsNCiAJfQ0KIA0KKwlyZXQg
PSBjbGtfcHJlcGFyZV9lbmFibGUoaW5zdGFuY2UtPmRhX3JlZl9jbGspOw0KKwlpZiAocmV0KSB7
DQorCQlkZXZfZXJyKHRwaHktPmRldiwgImZhaWxlZCB0byBlbmFibGUgZGFfcmVmXG4iKTsNCisJ
CWNsa19kaXNhYmxlX3VucHJlcGFyZShpbnN0YW5jZS0+cmVmX2Nsayk7DQorCQlyZXR1cm4gcmV0
Ow0KKwl9DQorDQogCXN3aXRjaCAoaW5zdGFuY2UtPnR5cGUpIHsNCiAJY2FzZSBQSFlfVFlQRV9V
U0IyOg0KIAkJdTJfcGh5X2luc3RhbmNlX2luaXQodHBoeSwgaW5zdGFuY2UpOw0KQEAgLTk4NCw2
ICs5OTIsNyBAQCBzdGF0aWMgaW50IG10a19waHlfZXhpdChzdHJ1Y3QgcGh5ICpwaHkpDQogCQl1
Ml9waHlfaW5zdGFuY2VfZXhpdCh0cGh5LCBpbnN0YW5jZSk7DQogDQogCWNsa19kaXNhYmxlX3Vu
cHJlcGFyZShpbnN0YW5jZS0+cmVmX2Nsayk7DQorCWNsa19kaXNhYmxlX3VucHJlcGFyZShpbnN0
YW5jZS0+ZGFfcmVmX2Nsayk7DQogCXJldHVybiAwOw0KIH0NCiANCkBAIC0xMTcwLDYgKzExNzks
MTQgQEAgc3RhdGljIGludCBtdGtfdHBoeV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KIAkJCXJldHZhbCA9IFBUUl9FUlIoaW5zdGFuY2UtPnJlZl9jbGspOw0KIAkJCWdvdG8g
cHV0X2NoaWxkOw0KIAkJfQ0KKw0KKwkJaW5zdGFuY2UtPmRhX3JlZl9jbGsgPQ0KKwkJCWRldm1f
Y2xrX2dldF9vcHRpb25hbCgmcGh5LT5kZXYsICJkYV9yZWYiKTsNCisJCWlmIChJU19FUlIoaW5z
dGFuY2UtPmRhX3JlZl9jbGspKSB7DQorCQkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gZ2V0IGRh
X3JlZl9jbGsoaWQtJWQpXG4iLCBwb3J0KTsNCisJCQlyZXR2YWwgPSBQVFJfRVJSKGluc3RhbmNl
LT5kYV9yZWZfY2xrKTsNCisJCQlnb3RvIHB1dF9jaGlsZDsNCisJCX0NCiAJfQ0KIA0KIAlwcm92
aWRlciA9IGRldm1fb2ZfcGh5X3Byb3ZpZGVyX3JlZ2lzdGVyKGRldiwgbXRrX3BoeV94bGF0ZSk7
DQotLSANCjIuMjQuMA0K

