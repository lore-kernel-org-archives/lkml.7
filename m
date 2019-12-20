Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CC8C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 03:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C092467F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 03:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="aKJK2z4A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfLTDqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 22:46:36 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:40750 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727084AbfLTDqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 22:46:25 -0500
X-UUID: ba0fe60dd1bf4ec88a4d673aa9aeb42b-20191220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=GBfYh0omHP0jJqQxlEbn3Za4MRyi1I+fnL2nqkmg2X0=;
        b=aKJK2z4AfQtC7XOPb5c4hQATtx92LJSJQW5CDEe6oESqOUKfo87cAtmX3+SpnxbU/udZhY8VlJtwHOFi50f7F0zo/gG7k4EYveJD8aMlYk3t7vrNrC/v3CMFZUQUX4Tec2JBttDlWE83xw5HyDU38YZuqY2nI4h3b/QnaIYLI28=;
X-UUID: ba0fe60dd1bf4ec88a4d673aa9aeb42b-20191220
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1198377756; Fri, 20 Dec 2019 11:46:14 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 20 Dec 2019 11:45:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 20 Dec 2019 11:46:07 +0800
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
Subject: [PATCH v11 07/10] soc: mediatek: Add extra sram control
Date:   Fri, 20 Dec 2019 11:46:01 +0800
Message-ID: <1576813564-23927-8-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1576813564-23927-1-git-send-email-weiyi.lu@mediatek.com>
References: <1576813564-23927-1-git-send-email-weiyi.lu@mediatek.com>
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
ZWsuY29tPg0KUmV2aWV3ZWQtYnk6IE5pY29sYXMgQm9pY2hhdCA8ZHJpbmtjYXRAY2hyb21pdW0u
b3JnPg0KLS0tDQogZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXNjcHN5cy5jIHwgMjQgKysrKysr
KysrKysrKysrKysrKysrKy0tDQogMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nw
c3lzLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmMNCmluZGV4IDMyYmU0YjMu
LjE5NzI3MjYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmMN
CisrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1zY3BzeXMuYw0KQEAgLTU2LDYgKzU2LDgg
QEANCiAjZGVmaW5lIFBXUl9PTl9CSVQJCQlCSVQoMikNCiAjZGVmaW5lIFBXUl9PTl8yTkRfQklU
CQkJQklUKDMpDQogI2RlZmluZSBQV1JfQ0xLX0RJU19CSVQJCQlCSVQoNCkNCisjZGVmaW5lIFBX
Ul9TUkFNX0NMS0lTT19CSVQJCUJJVCg1KQ0KKyNkZWZpbmUgUFdSX1NSQU1fSVNPSU5UX0JfQklU
CQlCSVQoNikNCiANCiAjZGVmaW5lIFBXUl9TVEFUVVNfQ09OTgkJCUJJVCgxKQ0KICNkZWZpbmUg
UFdSX1NUQVRVU19ESVNQCQkJQklUKDMpDQpAQCAtODYsNiArODgsOCBAQA0KICAqIEBuYW1lOiBU
aGUgZG9tYWluIG5hbWUuDQogICogQHN0YV9tYXNrOiBUaGUgbWFzayBmb3IgcG93ZXIgb24vb2Zm
IHN0YXR1cyBiaXQuDQogICogQGN0bF9vZmZzOiBUaGUgb2Zmc2V0IGZvciBtYWluIHBvd2VyIGNv
bnRyb2wgcmVnaXN0ZXIuDQorICogQHNyYW1faXNvX2N0cmw6IFRoZSBmbGFnIHRvIGp1ZGdlIGlm
IHRoZSBwb3dlciBkb21haW4gbmVlZCB0byBkbw0KKyAqICAgICAgICAgICAgICAgICB0aGUgZXh0
cmEgc3JhbSBpc29sYXRpb24gY29udHJvbC4NCiAgKiBAc3JhbV9wZG5fYml0czogVGhlIG1hc2sg
Zm9yIHNyYW0gcG93ZXIgY29udHJvbCBiaXRzLg0KICAqIEBzcmFtX3Bkbl9hY2tfYml0czogVGhl
IG1hc2sgZm9yIHNyYW0gcG93ZXIgY29udHJvbCBhY2tlZCBiaXRzLg0KICAqIEBiYXNpY19jbGtf
bmFtZTogVGhlIGJhc2ljIGNsb2NrcyByZXF1aXJlZCBieSB0aGlzIHBvd2VyIGRvbWFpbi4NCkBA
IC05OCw2ICsxMDIsNyBAQCBzdHJ1Y3Qgc2NwX2RvbWFpbl9kYXRhIHsNCiAJY29uc3QgY2hhciAq
bmFtZTsNCiAJdTMyIHN0YV9tYXNrOw0KIAlpbnQgY3RsX29mZnM7DQorCWJvb2wgc3JhbV9pc29f
Y3RybDsNCiAJdTMyIHNyYW1fcGRuX2JpdHM7DQogCXUzMiBzcmFtX3Bkbl9hY2tfYml0czsNCiAJ
Y29uc3QgY2hhciAqYmFzaWNfY2xrX25hbWVbTUFYX0NMS1NdOw0KQEAgLTIzMyw2ICsyMzgsMTQg
QEAgc3RhdGljIGludCBzY3BzeXNfc3JhbV9lbmFibGUoc3RydWN0IHNjcF9kb21haW4gKnNjcGQs
IHZvaWQgX19pb21lbSAqY3RsX2FkZHIpDQogCQkJcmV0dXJuIHJldDsNCiAJfQ0KIA0KKwlpZiAo
c2NwZC0+ZGF0YS0+c3JhbV9pc29fY3RybCkJew0KKwkJdmFsID0gcmVhZGwoY3RsX2FkZHIpIHwg
UFdSX1NSQU1fSVNPSU5UX0JfQklUOw0KKwkJd3JpdGVsKHZhbCwgY3RsX2FkZHIpOw0KKwkJdWRl
bGF5KDEpOw0KKwkJdmFsICY9IH5QV1JfU1JBTV9DTEtJU09fQklUOw0KKwkJd3JpdGVsKHZhbCwg
Y3RsX2FkZHIpOw0KKwl9DQorDQogCXJldHVybiAwOw0KIH0NCiANCkBAIC0yNDIsOCArMjU1LDE1
IEBAIHN0YXRpYyBpbnQgc2Nwc3lzX3NyYW1fZGlzYWJsZShzdHJ1Y3Qgc2NwX2RvbWFpbiAqc2Nw
ZCwgdm9pZCBfX2lvbWVtICpjdGxfYWRkcikNCiAJdTMyIHBkbl9hY2sgPSBzY3BkLT5kYXRhLT5z
cmFtX3Bkbl9hY2tfYml0czsNCiAJaW50IHRtcDsNCiANCi0JdmFsID0gcmVhZGwoY3RsX2FkZHIp
Ow0KLQl2YWwgfD0gc2NwZC0+ZGF0YS0+c3JhbV9wZG5fYml0czsNCisJaWYgKHNjcGQtPmRhdGEt
PnNyYW1faXNvX2N0cmwpCXsNCisJCXZhbCA9IHJlYWRsKGN0bF9hZGRyKSB8IFBXUl9TUkFNX0NM
S0lTT19CSVQ7DQorCQl3cml0ZWwodmFsLCBjdGxfYWRkcik7DQorCQl2YWwgJj0gflBXUl9TUkFN
X0lTT0lOVF9CX0JJVDsNCisJCXdyaXRlbCh2YWwsIGN0bF9hZGRyKTsNCisJCXVkZWxheSgxKTsN
CisJfQ0KKw0KKwl2YWwgPSByZWFkbChjdGxfYWRkcikgfCBzY3BkLT5kYXRhLT5zcmFtX3Bkbl9i
aXRzOw0KIAl3cml0ZWwodmFsLCBjdGxfYWRkcik7DQogDQogCS8qIEVpdGhlciB3YWl0IHVudGls
IFNSQU1fUEROX0FDSyBhbGwgMSBvciAwICovDQotLSANCjEuOC4xLjEuZGlydHkNCg==

