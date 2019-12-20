Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50808C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 03:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ACEE24688
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 03:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="e/HnjBMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfLTDqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 22:46:47 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:40750 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727024AbfLTDqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 22:46:16 -0500
X-UUID: c184a00e992e4a688619ee8619bd097c-20191220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=w8agqSkABPe2gpBFFdaj1Yu7esFJCdenNL3aq1JoRvw=;
        b=e/HnjBMBLGpgHL5pXlaaJJWFGo5cLW22hLuwwSY7mhcI8qlxXQY/Tx1YTKnHdz6t4L3e3mQbzaBwxAOwhl0qZ8M1RR4YswJzmXEncX7vk8g97NyHgF0CCyOm/emKPJjGGcjXzymz4nPBWf8tKHQB2EnDDr3+LKj5LIWKt4lbTqs=;
X-UUID: c184a00e992e4a688619ee8619bd097c-20191220
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1585691683; Fri, 20 Dec 2019 11:46:09 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 20 Dec 2019 11:45:50 +0800
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
Subject: [PATCH v11 06/10] soc: mediatek: Add subsys clock control for bus protection
Date:   Fri, 20 Dec 2019 11:46:00 +0800
Message-ID: <1576813564-23927-7-git-send-email-weiyi.lu@mediatek.com>
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

QWRkIHN1YnN5cyBDRyBjb250cm9sIGZsb3cgYmVmb3JlL2FmdGVyIHRoZSBidXMgcHJvdGVjdCBj
b250cm9sDQpkdWUgdG8gYnVzIHByb3RlY3Rpb24gbmVlZCBTTUkgYnVzIHJlbGF0aXZlIENHcyBl
bmFibGVkIHRvIGZlZWRiYWNrDQppdHMgYWNrLg0KDQpTaWduZWQtb2ZmLWJ5OiBXZWl5aSBMdSA8
d2VpeWkubHVAbWVkaWF0ZWsuY29tPg0KUmV2aWV3ZWQtYnk6IE5pY29sYXMgQm9pY2hhdCA8ZHJp
bmtjYXRAY2hyb21pdW0ub3JnPg0KLS0tDQogZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXNjcHN5
cy5jIHwgNzIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQogMSBmaWxl
IGNoYW5nZWQsIDcwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRl
ay9tdGstc2Nwc3lzLmMNCmluZGV4IDc2M2NhNTguLjMyYmU0YjMgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmMNCisrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVr
L210ay1zY3BzeXMuYw0KQEAgLTc5LDYgKzc5LDcgQEANCiAjZGVmaW5lIFBXUl9TVEFUVVNfV0IJ
CQlCSVQoMjcpCS8qIE1UNzYyMiAqLw0KIA0KICNkZWZpbmUgTUFYX0NMS1MJMw0KKyNkZWZpbmUg
TUFYX1NVQlNZU19DTEtTIDEwDQogDQogLyoqDQogICogc3RydWN0IHNjcF9kb21haW5fZGF0YSAt
IHNjcCBkb21haW4gZGF0YSBmb3IgcG93ZXIgb24vb2ZmIGZsb3cNCkBAIC04OCw2ICs4OSw4IEBA
DQogICogQHNyYW1fcGRuX2JpdHM6IFRoZSBtYXNrIGZvciBzcmFtIHBvd2VyIGNvbnRyb2wgYml0
cy4NCiAgKiBAc3JhbV9wZG5fYWNrX2JpdHM6IFRoZSBtYXNrIGZvciBzcmFtIHBvd2VyIGNvbnRy
b2wgYWNrZWQgYml0cy4NCiAgKiBAYmFzaWNfY2xrX25hbWU6IFRoZSBiYXNpYyBjbG9ja3MgcmVx
dWlyZWQgYnkgdGhpcyBwb3dlciBkb21haW4uDQorICogQHN1YnN5c19jbGtfcHJlZml4OiBUaGUg
cHJlZml4IG5hbWUgb2YgdGhlIGNsb2NrcyBuZWVkIHRvIGJlIGVuYWJsZWQNCisgKiAgICAgICAg
ICAgICAgICAgICAgIGJlZm9yZSByZWxlYXNpbmcgYnVzIHByb3RlY3Rpb24uDQogICogQGNhcHM6
IFRoZSBmbGFnIGZvciBhY3RpdmUgd2FrZS11cCBhY3Rpb24uDQogICogQGJwX3RhYmxlOiBUaGUg
bWFzayB0YWJsZSBmb3IgbXVsdGlwbGUgc3RlcCBidXMgcHJvdGVjdGlvbi4NCiAgKi8NCkBAIC05
OCw2ICsxMDEsNyBAQCBzdHJ1Y3Qgc2NwX2RvbWFpbl9kYXRhIHsNCiAJdTMyIHNyYW1fcGRuX2Jp
dHM7DQogCXUzMiBzcmFtX3Bkbl9hY2tfYml0czsNCiAJY29uc3QgY2hhciAqYmFzaWNfY2xrX25h
bWVbTUFYX0NMS1NdOw0KKwljb25zdCBjaGFyICpzdWJzeXNfY2xrX3ByZWZpeDsNCiAJdTggY2Fw
czsNCiAJc3RydWN0IGJ1c19wcm90IGJwX3RhYmxlW01BWF9TVEVQU107DQogfTsNCkBAIC0xMDgs
NiArMTEyLDcgQEAgc3RydWN0IHNjcF9kb21haW4gew0KIAlzdHJ1Y3QgZ2VuZXJpY19wbV9kb21h
aW4gZ2VucGQ7DQogCXN0cnVjdCBzY3AgKnNjcDsNCiAJc3RydWN0IGNsayAqY2xrW01BWF9DTEtT
XTsNCisJc3RydWN0IGNsayAqc3Vic3lzX2Nsa1tNQVhfU1VCU1lTX0NMS1NdOw0KIAljb25zdCBz
dHJ1Y3Qgc2NwX2RvbWFpbl9kYXRhICpkYXRhOw0KIAlzdHJ1Y3QgcmVndWxhdG9yICpzdXBwbHk7
DQogfTsNCkBAIC0zMDEsMTYgKzMwNiwyMiBAQCBzdGF0aWMgaW50IHNjcHN5c19wb3dlcl9vbihz
dHJ1Y3QgZ2VuZXJpY19wbV9kb21haW4gKmdlbnBkKQ0KIAl2YWwgfD0gUFdSX1JTVF9CX0JJVDsN
CiAJd3JpdGVsKHZhbCwgY3RsX2FkZHIpOw0KIA0KLQlyZXQgPSBzY3BzeXNfc3JhbV9lbmFibGUo
c2NwZCwgY3RsX2FkZHIpOw0KKwlyZXQgPSBzY3BzeXNfY2xrX2VuYWJsZShzY3BkLT5zdWJzeXNf
Y2xrLCBNQVhfU1VCU1lTX0NMS1MpOw0KIAlpZiAocmV0IDwgMCkNCiAJCWdvdG8gZXJyX3B3cl9h
Y2s7DQogDQorCXJldCA9IHNjcHN5c19zcmFtX2VuYWJsZShzY3BkLCBjdGxfYWRkcik7DQorCWlm
IChyZXQgPCAwKQ0KKwkJZ290byBlcnJfc3JhbTsNCisNCiAJcmV0ID0gc2Nwc3lzX2J1c19wcm90
ZWN0X2Rpc2FibGUoc2NwZCk7DQogCWlmIChyZXQgPCAwKQ0KLQkJZ290byBlcnJfcHdyX2FjazsN
CisJCWdvdG8gZXJyX3NyYW07DQogDQogCXJldHVybiAwOw0KIA0KK2Vycl9zcmFtOg0KKwlzY3Bz
eXNfY2xrX2Rpc2FibGUoc2NwZC0+c3Vic3lzX2NsaywgTUFYX1NVQlNZU19DTEtTKTsNCiBlcnJf
cHdyX2FjazoNCiAJc2Nwc3lzX2Nsa19kaXNhYmxlKHNjcGQtPmNsaywgTUFYX0NMS1MpOw0KIGVy
cl9jbGs6DQpAQCAtMzM3LDYgKzM0OCw4IEBAIHN0YXRpYyBpbnQgc2Nwc3lzX3Bvd2VyX29mZihz
dHJ1Y3QgZ2VuZXJpY19wbV9kb21haW4gKmdlbnBkKQ0KIAlpZiAocmV0IDwgMCkNCiAJCWdvdG8g
b3V0Ow0KIA0KKwlzY3BzeXNfY2xrX2Rpc2FibGUoc2NwZC0+c3Vic3lzX2NsaywgTUFYX1NVQlNZ
U19DTEtTKTsNCisNCiAJLyogc3Vic3lzIHBvd2VyIG9mZiAqLw0KIAl2YWwgPSByZWFkbChjdGxf
YWRkcik7DQogCXZhbCB8PSBQV1JfSVNPX0JJVDsNCkBAIC0zNzQsNiArMzg3LDQ4IEBAIHN0YXRp
YyBpbnQgc2Nwc3lzX3Bvd2VyX29mZihzdHJ1Y3QgZ2VuZXJpY19wbV9kb21haW4gKmdlbnBkKQ0K
IAlyZXR1cm4gcmV0Ow0KIH0NCiANCitzdGF0aWMgaW50IGluaXRfc3Vic3lzX2Nsa3Moc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCisJCWNvbnN0IGNoYXIgKnByZWZpeCwgc3RydWN0IGNs
ayAqKmNsaykNCit7DQorCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZSA9IHBkZXYtPmRldi5vZl9u
b2RlOw0KKwl1MzIgcHJlZml4X2xlbiwgc3ViX2Nsa19jbnQgPSAwOw0KKwlzdHJ1Y3QgcHJvcGVy
dHkgKnByb3A7DQorCWNvbnN0IGNoYXIgKmNsa19uYW1lOw0KKw0KKwlpZiAoIW5vZGUpIHsNCisJ
CWRldl9lcnIoJnBkZXYtPmRldiwgIkNhbm5vdCBmaW5kIHNjcHN5cyBub2RlOiAlbGRcbiIsDQor
CQkJUFRSX0VSUihub2RlKSk7DQorCQlyZXR1cm4gUFRSX0VSUihub2RlKTsNCisJfQ0KKw0KKwlw
cmVmaXhfbGVuID0gc3RybGVuKHByZWZpeCk7DQorDQorCW9mX3Byb3BlcnR5X2Zvcl9lYWNoX3N0
cmluZyhub2RlLCAiY2xvY2stbmFtZXMiLCBwcm9wLCBjbGtfbmFtZSkgew0KKwkJaWYgKCFzdHJu
Y21wKGNsa19uYW1lLCBwcmVmaXgsIHByZWZpeF9sZW4pICYmDQorCQkJCShjbGtfbmFtZVtwcmVm
aXhfbGVuXSA9PSAnLScpKSB7DQorCQkJaWYgKHN1Yl9jbGtfY250ID49IE1BWF9TVUJTWVNfQ0xL
Uykgew0KKwkJCQlkZXZfZXJyKCZwZGV2LT5kZXYsDQorCQkJCQkic3Vic3lzIGNsayBvdXQgb2Yg
cmFuZ2UgJWRcbiIsDQorCQkJCQlzdWJfY2xrX2NudCk7DQorCQkJCXJldHVybiAtRU5PTUVNOw0K
KwkJCX0NCisNCisJCQljbGtbc3ViX2Nsa19jbnRdID0gZGV2bV9jbGtfZ2V0KCZwZGV2LT5kZXYs
DQorCQkJCQkJY2xrX25hbWUpOw0KKw0KKwkJCWlmIChJU19FUlIoY2xrW3N1Yl9jbGtfY250XSkp
IHsNCisJCQkJZGV2X2VycigmcGRldi0+ZGV2LA0KKwkJCQkJIlN1YnN5cyBjbGsgZ2V0IGZhaWwg
JWxkXG4iLA0KKwkJCQkJUFRSX0VSUihjbGtbc3ViX2Nsa19jbnRdKSk7DQorCQkJCXJldHVybiBQ
VFJfRVJSKGNsa1tzdWJfY2xrX2NudF0pOw0KKwkJCX0NCisJCQlzdWJfY2xrX2NudCsrOw0KKwkJ
fQ0KKwl9DQorDQorCXJldHVybiBzdWJfY2xrX2NudDsNCit9DQorDQogc3RhdGljIGludCBpbml0
X2Jhc2ljX2Nsa3Moc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwgc3RydWN0IGNsayAqKmNs
aywNCiAJCQljb25zdCBjaGFyICogY29uc3QgKm5hbWUpDQogew0KQEAgLTQ2Niw2ICs1MjEsNyBA
QCBzdGF0aWMgc3RydWN0IHNjcCAqaW5pdF9zY3Aoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
diwNCiAJCXN0cnVjdCBzY3BfZG9tYWluICpzY3BkID0gJnNjcC0+ZG9tYWluc1tpXTsNCiAJCXN0
cnVjdCBnZW5lcmljX3BtX2RvbWFpbiAqZ2VucGQgPSAmc2NwZC0+Z2VucGQ7DQogCQljb25zdCBz
dHJ1Y3Qgc2NwX2RvbWFpbl9kYXRhICpkYXRhID0gJnNjcF9kb21haW5fZGF0YVtpXTsNCisJCWlu
dCBjbGtfY250Ow0KIA0KIAkJcGRfZGF0YS0+ZG9tYWluc1tpXSA9IGdlbnBkOw0KIAkJc2NwZC0+
c2NwID0gc2NwOw0KQEAgLTQ3Niw2ICs1MzIsMTggQEAgc3RhdGljIHN0cnVjdCBzY3AgKmluaXRf
c2NwKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsDQogCQlpZiAocmV0KQ0KIAkJCXJldHVy
biBFUlJfUFRSKHJldCk7DQogDQorCQlpZiAoZGF0YS0+c3Vic3lzX2Nsa19wcmVmaXgpIHsNCisJ
CQljbGtfY250ID0gaW5pdF9zdWJzeXNfY2xrcyhwZGV2LA0KKwkJCQkJZGF0YS0+c3Vic3lzX2Ns
a19wcmVmaXgsDQorCQkJCQlzY3BkLT5zdWJzeXNfY2xrKTsNCisJCQlpZiAoY2xrX2NudCA8IDAp
IHsNCisJCQkJZGV2X2VycigmcGRldi0+ZGV2LA0KKwkJCQkJIiVzOiBzdWJzeXMgY2xrIHVuYXZh
aWxhYmxlXG4iLA0KKwkJCQkJZGF0YS0+bmFtZSk7DQorCQkJCXJldHVybiBFUlJfUFRSKGNsa19j
bnQpOw0KKwkJCX0NCisJCX0NCisNCiAJCWdlbnBkLT5uYW1lID0gZGF0YS0+bmFtZTsNCiAJCWdl
bnBkLT5wb3dlcl9vZmYgPSBzY3BzeXNfcG93ZXJfb2ZmOw0KIAkJZ2VucGQtPnBvd2VyX29uID0g
c2Nwc3lzX3Bvd2VyX29uOw0KLS0gDQoxLjguMS4xLmRpcnR5DQo=

