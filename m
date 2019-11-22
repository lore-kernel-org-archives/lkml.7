Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A584BC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 08:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA2620721
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 08:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YBAWnere"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfKVI4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 03:56:45 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:11017 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725999AbfKVI4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 03:56:45 -0500
X-UUID: 3d3d335242b84d54b958f1dddb1c4b78-20191122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=AMnabSznLaiYa+5DKF19iaqOPkdafm0Q3E/3KuPjx64=;
        b=YBAWneretwLCisikVHiaj01mPKaubYi0VwK1ptq7txy0R/yDtimxlSy/67PDlySJCNgIEURnpR1GQCDPoFxL5YxXiJsQRFQ5Dn9d8wv5h25GSB5kgwoh/032X8gK62Cq4AXoUgKuGGDMLe2c4WnSugd6SHrjCLrpQ7IA4C0jKdU=;
X-UUID: 3d3d335242b84d54b958f1dddb1c4b78-20191122
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 461520431; Fri, 22 Nov 2019 16:56:39 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 22 Nov 2019 16:56:15 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 22 Nov 2019 16:56:28 +0800
Message-ID: <1574412997.19450.16.camel@mtksdaap41>
Subject: Re: [PATCH v1 07/12] soc: mediatek: cmdq: add write_s function
From:   CK Hu <ck.hu@mediatek.com>
To:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 22 Nov 2019 16:56:37 +0800
In-Reply-To: <1574327552-11806-8-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1574327552-11806-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1574327552-11806-8-git-send-email-dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERlbm5pczoNCg0KT24gVGh1LCAyMDE5LTExLTIxIGF0IDE3OjEyICswODAwLCBEZW5uaXMg
WUMgSHNpZWggd3JvdGU6DQo+IGFkZCB3cml0ZV9zIGZ1bmN0aW9uIGluIGNtZHEgaGVscGVyIGZ1
bmN0aW9ucyB3aGljaA0KPiBzdXBwb3J0IGxhcmdlIGRtYSBhY2Nlc3MuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBEZW5uaXMgWUMgSHNpZWggPGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+DQo+
IC0tLQ0KPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgICB8ICAgMzQg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICBpbmNsdWRlL2xpbnV4L21haWxib3gv
bXRrLWNtZHEtbWFpbGJveC5oIHwgICAgMiArKw0KPiAgaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0
ZWsvbXRrLWNtZHEuaCAgICB8ICAgMTMgKysrKysrKysrKysrDQo+ICAzIGZpbGVzIGNoYW5nZWQs
IDQ5IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRl
ay9tdGstY21kcS1oZWxwZXIuYyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBl
ci5jDQo+IGluZGV4IGQ0MTllOTkuLjFiMDc0YTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc29j
L21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVr
L210ay1jbWRxLWhlbHBlci5jDQo+IEBAIC0xNSw2ICsxNSw5IEBADQo+ICAjZGVmaW5lIENNRFFf
RU9DX0NNRAkJKCh1NjQpKChDTURRX0NPREVfRU9DIDw8IENNRFFfT1BfQ09ERV9TSElGVCkpIFwN
Cj4gIAkJCQk8PCAzMiB8IENNRFFfRU9DX0lSUV9FTikNCj4gICNkZWZpbmUgQ01EUV9SRUdfVFlQ
RQkJMQ0KPiArI2RlZmluZSBDTURRX0FERFJfSElHSChhZGRyKQkoKHUzMikoKChhZGRyKSA+PiAx
NikgJiBHRU5NQVNLKDMxLCAwKSkpDQo+ICsjZGVmaW5lIENNRFFfQUREUl9MT1dfQklUCUJJVCgx
KQ0KPiArI2RlZmluZSBDTURRX0FERFJfTE9XKGFkZHIpCSgodTE2KShhZGRyKSB8IENNRFFfQURE
Ul9MT1dfQklUKQ0KPiAgDQo+ICBzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiB7DQo+ICAJdW5pb24g
ew0KPiBAQCAtMjI0LDYgKzIyNywzNyBAQCBpbnQgY21kcV9wa3Rfd3JpdGVfbWFzayhzdHJ1Y3Qg
Y21kcV9wa3QgKnBrdCwgdTggc3Vic3lzLA0KPiAgfQ0KPiAgRVhQT1JUX1NZTUJPTChjbWRxX3Br
dF93cml0ZV9tYXNrKTsNCj4gIA0KPiAraW50IGNtZHFfcGt0X3dyaXRlX3Moc3RydWN0IGNtZHFf
cGt0ICpwa3QsIGRtYV9hZGRyX3QgYWRkciwNCj4gKwkJICAgICB1MzIgdmFsdWUsIHUzMiBtYXNr
KQ0KPiArew0KPiArCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0KPiAr
CWludCBlcnI7DQo+ICsJY29uc3QgdTE2IGRzdF9yZWdfaWR4ID0gQ01EUV9TUFJfVEVNUDsNCj4g
Kw0KPiArCWVyciA9IGNtZHFfcGt0X2Fzc2lnbihwa3QsIGRzdF9yZWdfaWR4LCBDTURRX0FERFJf
SElHSChhZGRyKSk7DQo+ICsJaWYgKGVyciA8IDApDQo+ICsJCXJldHVybiBlcnI7DQo+ICsNCj4g
KwlpZiAobWFzayAhPSBVMzJfTUFYKSB7DQo+ICsJCWluc3Qub3AgPSBDTURRX0NPREVfTUFTSzsN
Cj4gKwkJaW5zdC5tYXNrID0gfm1hc2s7DQo+ICsJCWVyciA9IGNtZHFfcGt0X2FwcGVuZF9jb21t
YW5kKHBrdCwgaW5zdCk7DQo+ICsJCWlmIChlcnIgPCAwKQ0KPiArCQkJcmV0dXJuIGVycjsNCj4g
Kw0KPiArCQlpbnN0Lm9wID0gQ01EUV9DT0RFX1dSSVRFX1NfTUFTSzsNCj4gKwl9IGVsc2Ugew0K
PiArCQlpbnN0Lm9wID0gQ01EUV9DT0RFX1dSSVRFX1M7DQo+ICsJfQ0KPiArDQo+ICsJaW5zdC5z
b3AgPSBkc3RfcmVnX2lkeDsNCj4gKwlpbnN0Lm9mZnNldCA9IENNRFFfQUREUl9MT1coYWRkcik7
DQo+ICsJaW5zdC52YWx1ZSA9IHZhbHVlOw0KPiArDQo+ICsJcmV0dXJuIGNtZHFfcGt0X2FwcGVu
ZF9jb21tYW5kKHBrdCwgaW5zdCk7DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X3dy
aXRlX3MpOw0KPiArDQo+ICBpbnQgY21kcV9wa3Rfd2ZlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1
MTYgZXZlbnQpDQo+ICB7DQo+ICAJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHsgezB9
IH07DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJv
eC5oIGIvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0KPiBpbmRleCAx
MjFjM2JiLi44ZWY4N2UxIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRr
LWNtZHEtbWFpbGJveC5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1t
YWlsYm94LmgNCj4gQEAgLTU5LDYgKzU5LDggQEAgZW51bSBjbWRxX2NvZGUgew0KPiAgCUNNRFFf
Q09ERV9KVU1QID0gMHgxMCwNCj4gIAlDTURRX0NPREVfV0ZFID0gMHgyMCwNCj4gIAlDTURRX0NP
REVfRU9DID0gMHg0MCwNCj4gKwlDTURRX0NPREVfV1JJVEVfUyA9IDB4OTAsDQo+ICsJQ01EUV9D
T0RFX1dSSVRFX1NfTUFTSyA9IDB4OTEsDQo+ICAJQ01EUV9DT0RFX0xPR0lDID0gMHhhMCwNCj4g
IH07DQo+ICANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1j
bWRxLmggYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQo+IGluZGV4IDgz
MzQwMjEuLjhkYmQwNDYgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVr
L210ay1jbWRxLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEu
aA0KPiBAQCAtMTIsNiArMTIsNyBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L3RpbWVyLmg+DQo+ICAN
Cj4gICNkZWZpbmUgQ01EUV9OT19USU1FT1VUCQkweGZmZmZmZmZmdQ0KPiArI2RlZmluZSBDTURR
X1NQUl9URU1QCQkwDQo+ICANCj4gIHN0cnVjdCBjbWRxX3BrdDsNCj4gIA0KPiBAQCAtMTAzLDYg
KzEwNCwxOCBAQCBpbnQgY21kcV9wa3Rfd3JpdGVfbWFzayhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwg
dTggc3Vic3lzLA0KPiAgCQkJdTE2IG9mZnNldCwgdTMyIHZhbHVlLCB1MzIgbWFzayk7DQo+ICAN
Cj4gIC8qKg0KPiArICogY21kcV9wa3Rfd3JpdGVfcygpIC0gYXBwZW5kIHdyaXRlX3MgY29tbWFu
ZCB3aXRoIG1hc2sgdG8gdGhlIENNRFEgcGFja2V0DQo+ICsgKiBAcGt0Ogl0aGUgQ01EUSBwYWNr
ZXQNCj4gKyAqIEBhZGRyOgl0aGUgcGh5c2ljYWwgYWRkcmVzcyBvZiByZWdpc3RlciBvciBkbWEN
Cj4gKyAqIEB2YWx1ZToJdGhlIHNwZWNpZmllZCB0YXJnZXQgdmFsdWUNCj4gKyAqIEBtYXNrOgl0
aGUgc3BlY2lmaWVkIHRhcmdldCBtYXNrDQo+ICsgKg0KPiArICogUmV0dXJuOiAwIGZvciBzdWNj
ZXNzOyBlbHNlIHRoZSBlcnJvciBjb2RlIGlzIHJldHVybmVkDQo+ICsgKi8NCj4gK2ludCBjbWRx
X3BrdF93cml0ZV9zKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCBkbWFfYWRkcl90IGFkZHIsDQo+ICsJ
CSAgICAgdTMyIHZhbHVlLCB1MzIgbWFzayk7DQoNCllvdSBoYXZlIGFuIEFQSSBjbWRxX3BrdF9y
ZWFkX3MoKSB3aGljaCByZWFkIGRhdGEgaW50byBnY2UgaW50ZXJuYWwNCnJlZ2lzdGVyLCBzbyBJ
IGV4cGVjdCB0aGF0IGNtZHFfcGt0X3dyaXRlX3MoKSBpcyBhbiBBUEkgd2hpY2ggd3JpdGUgZGF0
YQ0KZnJvbSBnY2UgaW50ZXJuYWwgcmVnaXN0ZXIsIHRoZSBleHBlY3RlZCBwcm90b3R5cGUgaXMN
Cg0KaW50IGNtZHFfcGt0X3dyaXRlX3Moc3RydWN0IGNtZHFfcGt0ICpwa3QsIHBoeXNfYWRkcl90
IGFkZHIsIHUxNg0KcmVnX2lkeCk7DQoNCllvdXIgdmVyc2lvbiB3b3VsZCBjb25mdXNlIHRoZSB1
c2VyIGJlY2F1c2UgeW91IGhpZGUgdGhlIGludGVybmFsDQpyZWdpc3RlciBwYXJhbWV0ZXIuIElm
IHlvdSB3YW50IHRvIHByb3ZpZGUgdGhpcyBzZXJ2aWNlLCBJIHdvdWxkIGxpa2UNCnlvdSB0byBj
aGFuZ2UgdGhlIGZ1bmN0aW9uIG5hbWUgc28gdGhhdCB1c2VyIHdvdWxkIG5vdCBiZSBjb25mdXNl
ZCBhbmQNCmVhc2lseSB0byB1bmRlcnN0YW5kIHdoYXQgeW91IHdhbnQgdG8gZG8gaW4gdGhpcyBm
dW5jdGlvbi4NCg0KQW5vdGhlciBjaG9pY2UgaXM6IGNtZHFfcGt0X3dyaXRlX3MoKSBpcyBpbXBs
ZW1lbnRlZCBpbiBteSBkZWZpbml0aW9uLA0KYW5kIHVzZXIgY291bGQgY2FsbCBjbWRxX3BrdF9h
c3NpZ24oKSBhbmQgY21kcV9wa3Rfd3JpdGVfcygpIHRvIGFjaGlldmUNCnRoaXMgZnVuY3Rpb24u
DQoNClJlZ2FyZHMsDQpDSw0KDQo+ICsNCj4gKy8qKg0KPiAgICogY21kcV9wa3Rfd2ZlKCkgLSBh
cHBlbmQgd2FpdCBmb3IgZXZlbnQgY29tbWFuZCB0byB0aGUgQ01EUSBwYWNrZXQNCj4gICAqIEBw
a3Q6CXRoZSBDTURRIHBhY2tldA0KPiAgICogQGV2ZW50Ogl0aGUgZGVzaXJlZCBldmVudCB0eXBl
IHRvICJ3YWl0IGFuZCBDTEVBUiINCg0K

