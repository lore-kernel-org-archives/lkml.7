Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED993C2D0C6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 02:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B94EC208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 02:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YfzqF2gB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfLLCUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 21:20:33 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:44367 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727592AbfLLCUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 21:20:32 -0500
X-UUID: 54fa3d0fbbb844c7b2cebbf20008eb2f-20191212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=9c+CKJCw7ds62qe6zhspsMPOjl/4Hp7ooomuS+RoEEI=;
        b=YfzqF2gBK9cOf3P5+RyjdFs2uoFb9Bzn0jlneCtjpAaRPkqAU+238zimE7sJYgpLtNzYIf8AqphROllQ0il8eJEu+OgkH0YYFBy/wziUGpGE4FmhXkygG0dh1hTAIpkVm2ExDxRGT0um+URS5a9BZYn/hnl18fkE4MF/5c0Hmp4=;
X-UUID: 54fa3d0fbbb844c7b2cebbf20008eb2f-20191212
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 546727836; Thu, 12 Dec 2019 10:20:27 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 12 Dec 2019 10:20:06 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 12 Dec 2019 10:19:58 +0800
Message-ID: <1576117225.21687.6.camel@mtkswgap22>
Subject: Re: [PATCH v2 04/14] mailbox: mediatek: cmdq: clear task in channel
 before shutdown
From:   Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 12 Dec 2019 10:20:25 +0800
In-Reply-To: <1576116202.16444.4.camel@mtksdaap41>
References: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1574819937-6246-6-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1575946181.16676.4.camel@mtksdaap41> <1576113221.17653.6.camel@mtkswgap22>
         <1576114297.11762.1.camel@mtksdaap41>
         <1576115494.17653.21.camel@mtkswgap22>
         <1576116202.16444.4.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNCk9uIFRodSwgMjAxOS0xMi0xMiBhdCAxMDowMyArMDgwMCwgQ0sgSHUgd3JvdGU6
DQo+IEhpLCBEZW5uaXM6DQo+IA0KPiBPbiBUaHUsIDIwMTktMTItMTIgYXQgMDk6NTEgKzA4MDAs
IERlbm5pcy1ZQyBIc2llaCB3cm90ZToNCj4gPiBIaSBDSywNCj4gPiANCj4gPiBPbiBUaHUsIDIw
MTktMTItMTIgYXQgMDk6MzEgKzA4MDAsIENLIEh1IHdyb3RlOg0KPiA+ID4gSGksIERlbm5pczoN
Cj4gPiA+IA0KPiA+ID4gT24gVGh1LCAyMDE5LTEyLTEyIGF0IDA5OjEzICswODAwLCBEZW5uaXMt
WUMgSHNpZWggd3JvdGU6DQo+ID4gPiA+IEhpIENLLA0KPiA+ID4gPiANCj4gPiA+ID4gT24gVHVl
LCAyMDE5LTEyLTEwIGF0IDEwOjQ5ICswODAwLCBDSyBIdSB3cm90ZToNCj4gPiA+ID4gPiBIaSwg
RGVubmlzOg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IE9uIFdlZCwgMjAxOS0xMS0yNyBhdCAwOTo1
OCArMDgwMCwgRGVubmlzIFlDIEhzaWVoIHdyb3RlOg0KPiA+ID4gPiA+ID4gRG8gc3VjY2VzcyBj
YWxsYmFjayBpbiBjaGFubmVsIHdoZW4gc2h1dGRvd24uIEZvciB0aG9zZSB0YXNrIG5vdCBmaW5p
c2gsDQo+ID4gPiA+ID4gPiBjYWxsYmFjayB3aXRoIGVycm9yIGNvZGUgdGh1cyBjbGllbnQgaGFz
IGNoYW5jZSB0byBjbGVhbnVwIG9yIHJlc2V0Lg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMgSHNpZWggPGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5j
b20+DQo+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+ICBkcml2ZXJzL21haWxib3gvbXRrLWNt
ZHEtbWFpbGJveC5jIHwgMjYgKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+ID4gPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYyBiL2Ry
aXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4gPiA+ID4gPiA+IGluZGV4IGZkNTE5
YjZmNTE4Yi4uYzEyYTc2OGQxMTc1IDEwMDY0NA0KPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9t
YWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiA+ID4gPiA+ID4gKysrIGIvZHJpdmVycy9tYWls
Ym94L210ay1jbWRxLW1haWxib3guYw0KPiA+ID4gPiA+ID4gQEAgLTQ1MCw2ICs0NTAsMzIgQEAg
c3RhdGljIGludCBjbWRxX21ib3hfc3RhcnR1cChzdHJ1Y3QgbWJveF9jaGFuICpjaGFuKQ0KPiA+
ID4gPiA+ID4gIA0KPiA+ID4gPiA+ID4gIHN0YXRpYyB2b2lkIGNtZHFfbWJveF9zaHV0ZG93bihz
dHJ1Y3QgbWJveF9jaGFuICpjaGFuKQ0KPiA+ID4gPiA+ID4gIHsNCj4gPiA+ID4gPiA+ICsJc3Ry
dWN0IGNtZHFfdGhyZWFkICp0aHJlYWQgPSAoc3RydWN0IGNtZHFfdGhyZWFkICopY2hhbi0+Y29u
X3ByaXY7DQo+ID4gPiA+ID4gPiArCXN0cnVjdCBjbWRxICpjbWRxID0gZGV2X2dldF9kcnZkYXRh
KGNoYW4tPm1ib3gtPmRldik7DQo+ID4gPiA+ID4gPiArCXN0cnVjdCBjbWRxX3Rhc2sgKnRhc2ss
ICp0bXA7DQo+ID4gPiA+ID4gPiArCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ID4gPiA+ID4gPiAr
DQo+ID4gPiA+ID4gPiArCXNwaW5fbG9ja19pcnFzYXZlKCZ0aHJlYWQtPmNoYW4tPmxvY2ssIGZs
YWdzKTsNCj4gPiA+ID4gPiA+ICsJaWYgKGxpc3RfZW1wdHkoJnRocmVhZC0+dGFza19idXN5X2xp
c3QpKQ0KPiA+ID4gPiA+ID4gKwkJZ290byBkb25lOw0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+
ID4gKwlXQVJOX09OKGNtZHFfdGhyZWFkX3N1c3BlbmQoY21kcSwgdGhyZWFkKSA8IDApOw0KPiA+
ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gKwkvKiBtYWtlIHN1cmUgZXhlY3V0ZWQgdGFza3MgaGF2
ZSBzdWNjZXNzIGNhbGxiYWNrICovDQo+ID4gPiA+ID4gPiArCWNtZHFfdGhyZWFkX2lycV9oYW5k
bGVyKGNtZHEsIHRocmVhZCk7DQo+ID4gPiA+ID4gPiArCWlmIChsaXN0X2VtcHR5KCZ0aHJlYWQt
PnRhc2tfYnVzeV9saXN0KSkNCj4gPiA+ID4gPiA+ICsJCWdvdG8gZG9uZTsNCj4gPiA+ID4gPiA+
ICsNCj4gPiA+ID4gPiA+ICsJbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKHRhc2ssIHRtcCwgJnRo
cmVhZC0+dGFza19idXN5X2xpc3QsDQo+ID4gPiA+ID4gPiArCQkJCSBsaXN0X2VudHJ5KSB7DQo+
ID4gPiA+ID4gPiArCQljbWRxX3Rhc2tfZXhlY19kb25lKHRhc2ssIC1FQ09OTkFCT1JURUQpOw0K
PiA+ID4gPiA+ID4gKwkJa2ZyZWUodGFzayk7DQo+ID4gPiA+ID4gPiArCX0NCj4gPiA+ID4gPiA+
ICsNCj4gPiA+ID4gPiA+ICsJY21kcV90aHJlYWRfZGlzYWJsZShjbWRxLCB0aHJlYWQpOw0KPiA+
ID4gPiA+ID4gKwljbGtfZGlzYWJsZShjbWRxLT5jbG9jayk7DQo+ID4gPiA+ID4gPiArZG9uZToN
Cj4gPiA+ID4gPiANCj4gPiA+ID4gPiBjbWRxX3RocmVhZF9yZXN1bWUodGhyZWFkKTsNCj4gPiA+
ID4gPiANCj4gPiA+ID4gPiBSZWdhcmRzLA0KPiA+ID4gPiA+IENLDQo+ID4gPiA+ID4gDQo+ID4g
PiA+IA0KPiA+ID4gPiBDYWxsIHJlc3VtZSBoZXJlIHdpbGwgY2F1c2UgdmlvbGF0aW9uLiBUaGUg
dGhyZWFkLT50YXNrX2J1c3lfbGlzdCBlbXB0eQ0KPiA+ID4gPiBtZWFucyBubyB0YXNrIHdvcmsg
aW4gZ2NlIGFuZCB0aHJlYWQgc3RhdGUgc2hvdWxkIGFscmVhZHkgZGlzYWJsZQ0KPiA+ID4gPiB3
aXRob3V0IGNsb2NrLCB3aGljaCBpcyB3aGF0IHdlIHdhbnQgc2luY2UgY2xpZW50IHRyeSB0byBz
aHV0IGRvd24gdGhpcw0KPiA+ID4gPiBtYm94IGNoYW5uZWwuIFNvIEkgdGhpbmsgd2UgZG9uJ3Qg
bmVlZCByZXN1bWUgaGVyZS4NCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IE9LLiBXaGVuIGNsaWVu
dCBmcmVlIGNoYW5uZWwsIHRocmVhZCBpcyBzdXNwZW5kZWQuIFRoZW4gY2xpZW50IHJlcXVlc3QN
Cj4gPiA+IGNoYW5uZWwsIHdoZXJlIGRvIHlvdSByZXN1bWUgdGhyZWFkPw0KPiA+ID4gDQo+ID4g
DQo+ID4gd2hlbiBjbGllbnQgc2VuZCBuZXcgcGt0IHRvIG5ldyBjaGFubmVsLCBjbWRxX21ib3hf
c2VuZF9kYXRhKCkgd2lsbA0KPiA+IGVuYWJsZSB0aHJlYWQuDQo+IA0KPiBpbiBjbWRxX21ib3hf
c2VuZF9kYXRhKCksIGl0IHdvdWxkIHJ1biBiZWxvdyBjb21tYW5kOg0KPiANCj4gV0FSTl9PTihj
bGtfZW5hYmxlKGNtZHEtPmNsb2NrKSA8IDApOw0KPiBXQVJOX09OKGNtZHFfdGhyZWFkX3Jlc2V0
KGNtZHEsIHRocmVhZCkgPCAwKTsNCj4gDQo+IHdyaXRlbCh0YXNrLT5wYV9iYXNlLCB0aHJlYWQt
PmJhc2UgKyBDTURRX1RIUl9DVVJSX0FERFIpOw0KPiB3cml0ZWwodGFzay0+cGFfYmFzZSArIHBr
dC0+Y21kX2J1Zl9zaXplLA0KPiAgICAgICAgdGhyZWFkLT5iYXNlICsgQ01EUV9USFJfRU5EX0FE
RFIpOw0KPiB3cml0ZWwodGhyZWFkLT5wcmlvcml0eSwgdGhyZWFkLT5iYXNlICsgQ01EUV9USFJf
UFJJT1JJVFkpOw0KPiB3cml0ZWwoQ01EUV9USFJfSVJRX0VOLCB0aHJlYWQtPmJhc2UgKyBDTURR
X1RIUl9JUlFfRU5BQkxFKTsNCj4gd3JpdGVsKENNRFFfVEhSX0VOQUJMRUQsIHRocmVhZC0+YmFz
ZSArIENNRFFfVEhSX0VOQUJMRV9UQVNLKTsNCj4gDQo+IERvIHlvdSBtZWFuIENNRFFfVEhSX0VO
QUJMRV9UQVNLIGlzIHNldCB0byBDTURRX1RIUl9FTkFCTEVELCB0aGVuDQo+IENNRFFfVEhSX1NV
U1BFTkRfVEFTSyB3b3VsZCBiZSBhdXRvbWF0aWNhbGx5IHNldCB0byBDTURRX1RIUl9SRVNVTUU/
IElmDQo+IHRoaXMgaGFyZHdhcmUgd29yayBpbiBzbyBzcGVjaWFsIGJlaGF2aW9yLCBwbGVhc2Ug
YWRkIGNvbW1lbnQgZm9yIHRoaXMuDQo+IA0KPiBSZWdhcmRzLA0KPiBDSw0KPiANCg0Kc29ycnkg
Zm9yIG5vdCBjbGVhcmx5IGV4cGxhaW4gYmVmb3JlDQoNCmNhbGwgdG8gY21kcV90aHJlYWRfcmVz
ZXQoKSB3aWxsIHJlc2V0IHRocmVhZCBzdGF0dXMsIHdoaWNoIGluY2x1ZGUNCnN1c3BlbmQgc3Rh
dGUuIHRoZSBDTURRX1RIUl9TVVNQRU5EX1RBU0sgd2lsbCBiZSBjbGVhciBhZnRlciByZXNldCwg
dGh1cw0Kd2UgY2FuIHNpbXBseSBzZXQgQ01EUV9USFJfRU5BQkxFX1RBU0sgdG8gQ01EUV9USFJf
RU5BQkxFRCBhbmQgdGhlbg0KdGhyZWFkIHJ1bm5pbmcgYWdhaW4uDQoNCkkgd2lsbCBhZGQgY29t
bWVudCBpbiBib3RoIGNtZHFfbWJveF9zZW5kX2RhdGEoKSBhbmQNCmNtZHFfbWJveF9zaHV0ZG93
bigpIHRvIGNsYXJpZnkgdGhpcyBoYXJkd2FyZSBiZWhhdmlvci4NCg0KDQpSZWdhcmRzLA0KRGVu
bmlzDQoNCj4gPiANCj4gPiANCj4gPiBSZWdhcmRzLA0KPiA+IERlbm5pcw0KPiA+IA0KPiA+ID4g
UmVnYXJkcywNCj4gPiA+IENLDQo+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IFJlZ2FyZHMsDQo+
ID4gPiA+IERlbm5pcw0KPiA+ID4gPiANCj4gPiA+ID4gPiA+ICsJc3Bpbl91bmxvY2tfaXJxcmVz
dG9yZSgmdGhyZWFkLT5jaGFuLT5sb2NrLCBmbGFncyk7DQo+ID4gPiA+ID4gPiAgfQ0KPiA+ID4g
PiA+ID4gIA0KPiA+ID4gPiA+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbWJveF9jaGFuX29wcyBj
bWRxX21ib3hfY2hhbl9vcHMgPSB7DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+IA0K
PiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gDQo+ID4gDQo+ID4gDQo+IA0KPiANCg0K

