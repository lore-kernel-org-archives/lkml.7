Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC88C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 06:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D99206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 06:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="K/85qNAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfLJGrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 01:47:41 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:5886 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727370AbfLJGr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 01:47:26 -0500
X-UUID: 49dd00b415b14cd5b018863f2d05ef92-20191210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=in7Y5b66xLTUNL/z1DPJEMQwq3nkM02rQJiwoMm9JDM=;
        b=K/85qNAD/T0PGlPkJEj6vNtcP0wndNazq5G0UaVkFL4xRBVszABJZ+dveNCBKSF1wxaVpeIYb3L4sTkQOsvYuP6fSo7EuwP/ahPKv0iW3FqsefOYjAKXnfRlgkRpu+TFDR3NKqnA39bVVEbzNLkATaS1YQIKV3R90Ae2jZeYt4Y=;
X-UUID: 49dd00b415b14cd5b018863f2d05ef92-20191210
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 257667490; Tue, 10 Dec 2019 14:47:16 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 10 Dec 2019 14:46:48 +0800
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
Subject: [PATCH v9 5/9] soc: mediatek: Add subsys clock control for bus protection
Date:   Tue, 10 Dec 2019 14:46:49 +0800
Message-ID: <1575960413-6900-6-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1575960413-6900-1-git-send-email-weiyi.lu@mediatek.com>
References: <1575960413-6900-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 1BBD55928583D5DDB6E38E71781926C209F97AED79BFEBF7DEC76C276F0DEC212000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHN1YnN5cyBDRyBjb250cm9sIGZsb3cgYmVmb3JlL2FmdGVyIHRoZSBidXMgcHJvdGVjdCBj
b250cm9sDQpkdWUgdG8gYnVzIHByb3RlY3Rpb24gbmVlZCBTTUkgYnVzIHJlbGF0aXZlIENHcyBl
bmFibGVkIHRvIGZlZWRiYWNrDQppdHMgYWNrLg0KDQpTaWduZWQtb2ZmLWJ5OiBXZWl5aSBMdSA8
d2VpeWkubHVAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXNj
cHN5cy5jIHwgNzIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQogMSBm
aWxlIGNoYW5nZWQsIDcwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmMgYi9kcml2ZXJzL3NvYy9tZWRp
YXRlay9tdGstc2Nwc3lzLmMNCmluZGV4IDQ2NmJiNzQ5Li4yYmJmOTA3IDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXNjcHN5cy5jDQorKysgYi9kcml2ZXJzL3NvYy9tZWRp
YXRlay9tdGstc2Nwc3lzLmMNCkBAIC0xMDgsNiArMTA4LDcgQEAgZW51bSBjbGtfaWQgew0KIH07
DQogDQogI2RlZmluZSBNQVhfQ0xLUwkzDQorI2RlZmluZSBNQVhfU1VCU1lTX0NMS1MgMTANCiAN
CiAvKioNCiAgKiBzdHJ1Y3Qgc2NwX2RvbWFpbl9kYXRhIC0gc2NwIGRvbWFpbiBkYXRhIGZvciBw
b3dlciBvbi9vZmYgZmxvdw0KQEAgLTEyMCw2ICsxMjEsOCBAQCBlbnVtIGNsa19pZCB7DQogICog
QGNsa19pZDogVGhlIGJhc2ljIGNsb2NrcyByZXF1aXJlZCBieSB0aGlzIHBvd2VyIGRvbWFpbi4N
CiAgKiBAYmFzaWNfY2xrX2lkOiBwcm92aWRlIHRoZSBzYW1lIHB1cnBvc2Ugd2l0aCBmaWVsZCAi
Y2xrX2lkIg0KICAqICAgICAgICAgICAgICAgIGJ5IGRlY2xhcmluZyBiYXNpYyBjbG9jayBwcmVm
aXggbmFtZSByYXRoZXIgdGhhbiBjbGtfaWQuDQorICogQHN1YnN5c19jbGtfcHJlZml4OiBUaGUg
cHJlZml4IG5hbWUgb2YgdGhlIGNsb2NrcyBuZWVkIHRvIGJlIGVuYWJsZWQNCisgKiAgICAgICAg
ICAgICAgICAgICAgIGJlZm9yZSByZWxlYXNpbmcgYnVzIHByb3RlY3Rpb24uDQogICogQGNhcHM6
IFRoZSBmbGFnIGZvciBhY3RpdmUgd2FrZS11cCBhY3Rpb24uDQogICogQGJwX3RhYmxlOiBUaGUg
bWFzayB0YWJsZSBmb3IgbXVsdGlwbGUgc3RlcCBidXMgcHJvdGVjdGlvbi4NCiAgKi8NCkBAIC0x
MzIsNiArMTM1LDcgQEAgc3RydWN0IHNjcF9kb21haW5fZGF0YSB7DQogCXUzMiBidXNfcHJvdF9t
YXNrOw0KIAllbnVtIGNsa19pZCBjbGtfaWRbTUFYX0NMS1NdOw0KIAljb25zdCBjaGFyICpiYXNp
Y19jbGtfaWRbTUFYX0NMS1NdOw0KKwljb25zdCBjaGFyICpzdWJzeXNfY2xrX3ByZWZpeDsNCiAJ
dTggY2FwczsNCiAJc3RydWN0IGJ1c19wcm90IGJwX3RhYmxlW01BWF9TVEVQU107DQogfTsNCkBA
IC0xNDIsNiArMTQ2LDcgQEAgc3RydWN0IHNjcF9kb21haW4gew0KIAlzdHJ1Y3QgZ2VuZXJpY19w
bV9kb21haW4gZ2VucGQ7DQogCXN0cnVjdCBzY3AgKnNjcDsNCiAJc3RydWN0IGNsayAqY2xrW01B
WF9DTEtTXTsNCisJc3RydWN0IGNsayAqc3Vic3lzX2Nsa1tNQVhfU1VCU1lTX0NMS1NdOw0KIAlj
b25zdCBzdHJ1Y3Qgc2NwX2RvbWFpbl9kYXRhICpkYXRhOw0KIAlzdHJ1Y3QgcmVndWxhdG9yICpz
dXBwbHk7DQogfTsNCkBAIC0zNDksMTYgKzM1NCwyMiBAQCBzdGF0aWMgaW50IHNjcHN5c19wb3dl
cl9vbihzdHJ1Y3QgZ2VuZXJpY19wbV9kb21haW4gKmdlbnBkKQ0KIAl2YWwgfD0gUFdSX1JTVF9C
X0JJVDsNCiAJd3JpdGVsKHZhbCwgY3RsX2FkZHIpOw0KIA0KLQlyZXQgPSBzY3BzeXNfc3JhbV9l
bmFibGUoc2NwZCwgY3RsX2FkZHIpOw0KKwlyZXQgPSBzY3BzeXNfY2xrX2VuYWJsZShzY3BkLT5z
dWJzeXNfY2xrLCBNQVhfU1VCU1lTX0NMS1MpOw0KIAlpZiAocmV0IDwgMCkNCiAJCWdvdG8gZXJy
X3B3cl9hY2s7DQogDQorCXJldCA9IHNjcHN5c19zcmFtX2VuYWJsZShzY3BkLCBjdGxfYWRkcik7
DQorCWlmIChyZXQgPCAwKQ0KKwkJZ290byBlcnJfc3JhbTsNCisNCiAJcmV0ID0gc2Nwc3lzX2J1
c19wcm90ZWN0X2Rpc2FibGUoc2NwZCk7DQogCWlmIChyZXQgPCAwKQ0KLQkJZ290byBlcnJfcHdy
X2FjazsNCisJCWdvdG8gZXJyX3NyYW07DQogDQogCXJldHVybiAwOw0KIA0KK2Vycl9zcmFtOg0K
KwlzY3BzeXNfY2xrX2Rpc2FibGUoc2NwZC0+c3Vic3lzX2NsaywgTUFYX1NVQlNZU19DTEtTKTsN
CiBlcnJfcHdyX2FjazoNCiAJc2Nwc3lzX2Nsa19kaXNhYmxlKHNjcGQtPmNsaywgTUFYX0NMS1Mp
Ow0KIGVycl9jbGs6DQpAQCAtMzg1LDYgKzM5Niw4IEBAIHN0YXRpYyBpbnQgc2Nwc3lzX3Bvd2Vy
X29mZihzdHJ1Y3QgZ2VuZXJpY19wbV9kb21haW4gKmdlbnBkKQ0KIAlpZiAocmV0IDwgMCkNCiAJ
CWdvdG8gb3V0Ow0KIA0KKwlzY3BzeXNfY2xrX2Rpc2FibGUoc2NwZC0+c3Vic3lzX2NsaywgTUFY
X1NVQlNZU19DTEtTKTsNCisNCiAJLyogc3Vic3lzIHBvd2VyIG9mZiAqLw0KIAl2YWwgPSByZWFk
bChjdGxfYWRkcik7DQogCXZhbCB8PSBQV1JfSVNPX0JJVDsNCkBAIC00MjIsNiArNDM1LDQ4IEBA
IHN0YXRpYyBpbnQgc2Nwc3lzX3Bvd2VyX29mZihzdHJ1Y3QgZ2VuZXJpY19wbV9kb21haW4gKmdl
bnBkKQ0KIAlyZXR1cm4gcmV0Ow0KIH0NCiANCitzdGF0aWMgaW50IGluaXRfc3Vic3lzX2Nsa3Mo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCisJCWNvbnN0IGNoYXIgKnByZWZpeCwgc3Ry
dWN0IGNsayAqKmNsaykNCit7DQorCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZSA9IHBkZXYtPmRl
di5vZl9ub2RlOw0KKwl1MzIgcHJlZml4X2xlbiwgc3ViX2Nsa19jbnQgPSAwOw0KKwlzdHJ1Y3Qg
cHJvcGVydHkgKnByb3A7DQorCWNvbnN0IGNoYXIgKmNsa19uYW1lOw0KKw0KKwlpZiAoIW5vZGUp
IHsNCisJCWRldl9lcnIoJnBkZXYtPmRldiwgIkNhbm5vdCBmaW5kIHNjcHN5cyBub2RlOiAlbGRc
biIsDQorCQkJUFRSX0VSUihub2RlKSk7DQorCQlyZXR1cm4gUFRSX0VSUihub2RlKTsNCisJfQ0K
Kw0KKwlwcmVmaXhfbGVuID0gc3RybGVuKHByZWZpeCk7DQorDQorCW9mX3Byb3BlcnR5X2Zvcl9l
YWNoX3N0cmluZyhub2RlLCAiY2xvY2stbmFtZXMiLCBwcm9wLCBjbGtfbmFtZSkgew0KKwkJaWYg
KCFzdHJuY21wKGNsa19uYW1lLCBwcmVmaXgsIHByZWZpeF9sZW4pICYmDQorCQkJCShjbGtfbmFt
ZVtwcmVmaXhfbGVuXSA9PSAnLScpKSB7DQorCQkJaWYgKHN1Yl9jbGtfY250ID49IE1BWF9TVUJT
WVNfQ0xLUykgew0KKwkJCQlkZXZfZXJyKCZwZGV2LT5kZXYsDQorCQkJCQkic3Vic3lzIGNsayBv
dXQgb2YgcmFuZ2UgJWRcbiIsDQorCQkJCQlzdWJfY2xrX2NudCk7DQorCQkJCXJldHVybiAtRU5P
TUVNOw0KKwkJCX0NCisNCisJCQljbGtbc3ViX2Nsa19jbnRdID0gZGV2bV9jbGtfZ2V0KCZwZGV2
LT5kZXYsDQorCQkJCQkJY2xrX25hbWUpOw0KKw0KKwkJCWlmIChJU19FUlIoY2xrW3N1Yl9jbGtf
Y250XSkpIHsNCisJCQkJZGV2X2VycigmcGRldi0+ZGV2LA0KKwkJCQkJIlN1YnN5cyBjbGsgZ2V0
IGZhaWwgJWxkXG4iLA0KKwkJCQkJUFRSX0VSUihjbGtbc3ViX2Nsa19jbnRdKSk7DQorCQkJCXJl
dHVybiBQVFJfRVJSKGNsa1tzdWJfY2xrX2NudF0pOw0KKwkJCX0NCisJCQlzdWJfY2xrX2NudCsr
Ow0KKwkJfQ0KKwl9DQorDQorCXJldHVybiBzdWJfY2xrX2NudDsNCit9DQorDQogc3RhdGljIHZv
aWQgaW5pdF9jbGtzKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsIHN0cnVjdCBjbGsgKipj
bGspDQogew0KIAlpbnQgaTsNCkBAIC01MDksNiArNTY0LDcgQEAgc3RhdGljIHN0cnVjdCBzY3Ag
KmluaXRfc2NwKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsDQogCQlzdHJ1Y3Qgc2NwX2Rv
bWFpbiAqc2NwZCA9ICZzY3AtPmRvbWFpbnNbaV07DQogCQlzdHJ1Y3QgZ2VuZXJpY19wbV9kb21h
aW4gKmdlbnBkID0gJnNjcGQtPmdlbnBkOw0KIAkJY29uc3Qgc3RydWN0IHNjcF9kb21haW5fZGF0
YSAqZGF0YSA9ICZzY3BfZG9tYWluX2RhdGFbaV07DQorCQlpbnQgY2xrX2NudDsNCiANCiAJCXBk
X2RhdGEtPmRvbWFpbnNbaV0gPSBnZW5wZDsNCiAJCXNjcGQtPnNjcCA9IHNjcDsNCkBAIC01Mzcs
NiArNTkzLDE4IEBAIHN0YXRpYyBzdHJ1Y3Qgc2NwICppbml0X3NjcChzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2LA0KIAkJCQkJCWRhdGEtPmJhc2ljX2Nsa19pZFtqXSk7DQogCQl9DQogDQor
CQlpZiAoZGF0YS0+c3Vic3lzX2Nsa19wcmVmaXgpIHsNCisJCQljbGtfY250ID0gaW5pdF9zdWJz
eXNfY2xrcyhwZGV2LA0KKwkJCQkJZGF0YS0+c3Vic3lzX2Nsa19wcmVmaXgsDQorCQkJCQlzY3Bk
LT5zdWJzeXNfY2xrKTsNCisJCQlpZiAoY2xrX2NudCA8IDApIHsNCisJCQkJZGV2X2VycigmcGRl
di0+ZGV2LA0KKwkJCQkJIiVzOiBzdWJzeXMgY2xrIHVuYXZhaWxhYmxlXG4iLA0KKwkJCQkJZGF0
YS0+bmFtZSk7DQorCQkJCXJldHVybiBFUlJfUFRSKGNsa19jbnQpOw0KKwkJCX0NCisJCX0NCisN
CiAJCWdlbnBkLT5uYW1lID0gZGF0YS0+bmFtZTsNCiAJCWdlbnBkLT5wb3dlcl9vZmYgPSBzY3Bz
eXNfcG93ZXJfb2ZmOw0KIAkJZ2VucGQtPnBvd2VyX29uID0gc2Nwc3lzX3Bvd2VyX29uOw0KLS0g
DQoxLjguMS4xLmRpcnR5DQo=

