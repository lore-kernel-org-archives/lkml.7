Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A782C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC0D2071C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="thgu8LQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfKUJNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 04:13:33 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:53690 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726695AbfKUJNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 04:13:31 -0500
X-UUID: 8cb7a475156749e4aeac792acdd208bd-20191121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=z1evitQJPyeiEI/V0SBkkReklkkebIVSw5JGTAaBmCI=;
        b=thgu8LQyNHKxzMckBdRbZI3sSp9Mcs412/Q6G+PEMZ429MxUzcCPCM77d9wudhHrOVYze4nMNKztevaZ3RyjeSGgSjznMZ0idBXVKafCEGPjQdzcAD7CKHEAjXDEFF8Yk32ubrAGf2Rp4nV1DRonYOBccQ2HIsGFLPmGSoREYUs=;
X-UUID: 8cb7a475156749e4aeac792acdd208bd-20191121
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1053850104; Thu, 21 Nov 2019 17:13:26 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 21 Nov 2019 17:13:06 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Nov 2019 17:13:30 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v1 09/12] soc: mediatek: cmdq: add mem move function
Date:   Thu, 21 Nov 2019 17:12:29 +0800
Message-ID: <1574327552-11806-10-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1574327552-11806-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1574327552-11806-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIG1lbW9yeSBtb3ZlIGZ1bmN0aW9uIGluIGNtZHEgaGVscGVyIGZ1bmN0aW9ucyB3aGljaCBo
ZWxwcyBjb3B5IHZhbHVlDQpiZXR3ZWVuIHBoeXNpY2FsIGFkZHJlc3MuDQoNClNpZ25lZC1vZmYt
Ynk6IERlbm5pcyBZQyBIc2llaCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4NCi0tLQ0K
IGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIHwgICAyNiArKysrKysrKysr
KysrKysrKysrKysrKysrKw0KIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgg
IHwgICAxMyArKysrKysrKysrKysrDQogMiBmaWxlcyBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCsp
DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyBi
L2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQppbmRleCA0YzkwZmVkLi40
MjM1Y2Y4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVy
LmMNCisrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQpAQCAtMjgy
LDYgKzI4MiwzMiBAQCBpbnQgY21kcV9wa3Rfd3JpdGVfcyhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwg
ZG1hX2FkZHJfdCBhZGRyLA0KIH0NCiBFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X3dyaXRlX3MpOw0K
IA0KK2ludCBjbWRxX3BrdF9tZW1fbW92ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgcGh5c19hZGRy
X3Qgc3JjX2FkZHIsDQorCQkgICAgICBwaHlzX2FkZHJfdCBkc3RfYWRkcikNCit7DQorCXN0cnVj
dCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0KKwljb25zdCB1MTYgZHN0X3JlZ19p
ZHggPSBDTURRX1NQUl9URU1QOw0KKwljb25zdCB1MTYgc3dhcF9yZWdfaWR4ID0gQ01EUV9TUFIx
Ow0KKwlpbnQgZXJyOw0KKw0KKwllcnIgPSBjbWRxX3BrdF9yZWFkX3MocGt0LCBzcmNfYWRkciwg
c3dhcF9yZWdfaWR4KTsNCisJaWYgKGVyciA8IDApDQorCQlyZXR1cm4gZXJyOw0KKw0KKwllcnIg
PSBjbWRxX3BrdF9hc3NpZ24ocGt0LCBkc3RfcmVnX2lkeCwgQ01EUV9BRERSX0hJR0goZHN0X2Fk
ZHIpKTsNCisJaWYgKGVyciA8IDApDQorCQlyZXR1cm4gZXJyOw0KKw0KKwlpbnN0Lm9wID0gQ01E
UV9DT0RFX1dSSVRFX1M7DQorCWluc3QuYXJnX2JfdCA9IENNRFFfUkVHX1RZUEU7DQorCWluc3Qu
c29wID0gZHN0X3JlZ19pZHg7DQorCWluc3Qub2Zmc2V0ID0gQ01EUV9BRERSX0xPVyhkc3RfYWRk
cik7DQorCWluc3QuYXJnX2IgPSBzd2FwX3JlZ19pZHg7DQorDQorCXJldHVybiBjbWRxX3BrdF9h
cHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0KK30NCitFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X21l
bV9tb3ZlKTsNCisNCiBpbnQgY21kcV9wa3Rfd2ZlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYg
ZXZlbnQpDQogew0KIAlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsNCmRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oIGIvaW5jbHVk
ZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KaW5kZXggZmI0OGQzYy4uYjM0NzRmMiAx
MDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCisrKyBi
L2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCkBAIC0xMyw2ICsxMyw3IEBA
DQogDQogI2RlZmluZSBDTURRX05PX1RJTUVPVVQJCTB4ZmZmZmZmZmZ1DQogI2RlZmluZSBDTURR
X1NQUl9URU1QCQkwDQorI2RlZmluZSBDTURRX1NQUjEJCTENCiANCiBzdHJ1Y3QgY21kcV9wa3Q7
DQogDQpAQCAtMTI2LDYgKzEyNywxOCBAQCBpbnQgY21kcV9wa3Rfd3JpdGVfcyhzdHJ1Y3QgY21k
cV9wa3QgKnBrdCwgZG1hX2FkZHJfdCBhZGRyLA0KIAkJICAgICB1MzIgdmFsdWUsIHUzMiBtYXNr
KTsNCiANCiAvKioNCisgKiBjbWRxX3BrdF9tZW1fbW92ZSgpIC0gYXBwZW5kIHJlYWQgYW5kIHdy
aXRlIGNvbW1hbmRzIHRvIGNvcHkgZGF0YSBmcm9tDQorICoJCQkgc291cmNlIGFkZHJlc3MgdG8g
ZGVzdGluYXRpb24gYWRkcmVzcy4NCisgKiBAcGt0Ogl0aGUgQ01EUSBwYWNrZXQNCisgKiBAc3Jj
X2FkZHI6CXRoZSBzb3VyY2UgcGh5c2ljYWwgYWRkcmVzcw0KKyAqIEBkc3RfYWRkcjoJdGhlIGRl
c3RpbmF0aW9uIHBoeXNpY2FsIGFkZHJlc3MNCisgKg0KKyAqIFJldHVybjogMCBmb3Igc3VjY2Vz
czsgZWxzZSB0aGUgZXJyb3IgY29kZSBpcyByZXR1cm5lZA0KKyAqLw0KK2ludCBjbWRxX3BrdF9t
ZW1fbW92ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgcGh5c19hZGRyX3Qgc3JjX2FkZHIsDQorCQkg
ICAgICBwaHlzX2FkZHJfdCBkc3RfYWRkcik7DQorDQorLyoqDQogICogY21kcV9wa3Rfd2ZlKCkg
LSBhcHBlbmQgd2FpdCBmb3IgZXZlbnQgY29tbWFuZCB0byB0aGUgQ01EUSBwYWNrZXQNCiAgKiBA
cGt0Ogl0aGUgQ01EUSBwYWNrZXQNCiAgKiBAZXZlbnQ6CXRoZSBkZXNpcmVkIGV2ZW50IHR5cGUg
dG8gIndhaXQgYW5kIENMRUFSIg0KLS0gDQoxLjcuOS41DQo=

