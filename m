Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BF2C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83CD20880
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="r/5T5aJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgAHL1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 06:27:41 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:29186 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726098AbgAHL1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 06:27:40 -0500
X-UUID: c02c473c9be144d299865735663f90f0-20200108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=1fi/fDDjeP/w31P1XgOwqFMDo56O99pCAi7DUbNxiWw=;
        b=r/5T5aJWB59LTnEkYNHmW6r5/rlvodqYKmJvWZ4DBmfbXvx14YA6w2sXfrmVK8ed2rNBb71n4uE6EsfTWVEcJ6ZQ6QtBU2082sqAjE1Y5YiuVINjsR4frij6u3q7guy1Qqjk/Fzt8kjYs4tqeeDjb9mSGU0a+MZtdBvA+8tYJ64=;
X-UUID: c02c473c9be144d299865735663f90f0-20200108
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <hanks.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1577135201; Wed, 08 Jan 2020 19:27:36 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 8 Jan 2020 19:28:10 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 8 Jan 2020 19:25:57 +0800
Message-ID: <1578482850.7554.18.camel@mtkswgap22>
Subject: Re: [PATCH v2 05/11] pinctrl: mediatek: avoid virtual gpio trying
 to set reg
From:   Hanks Chen <hanks.chen@mediatek.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Rob Herring <robh@kernel.org>, CC Hwang <cc.hwang@mediatek.com>,
        <wsd_upstream@mediatek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        Loda Chou <loda.chou@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Mars Cheng" <mars.cheng@mediatek.com>,
        mtk01761 <wendell.lin@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>
Date:   Wed, 8 Jan 2020 19:27:30 +0800
In-Reply-To: <CACRpkdZUxpQ1tS9mKG9tc_U==M2BL9HwXt3DS1t413GGSEaVTA@mail.gmail.com>
References: <1566206502-4347-1-git-send-email-mars.cheng@mediatek.com>
         <1566206502-4347-6-git-send-email-mars.cheng@mediatek.com>
         <CACRpkdZa_sQgvWC3ic0NxrVi9gS1cNTsV-wa-SDpA0e5kutBRw@mail.gmail.com>
         <1577022724.7468.20.camel@mtkswgap22>
         <CACRpkdZUxpQ1tS9mKG9tc_U==M2BL9HwXt3DS1t413GGSEaVTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTAxLTA3IGF0IDExOjIwICswMTAwLCBMaW51cyBXYWxsZWlqIHdyb3RlOg0K
PiBPbiBNb24sIERlYyAyMywgMjAxOSBhdCA0OjExIEFNIEhhbmtzIENoZW4gPGhhbmtzLmNoZW5A
bWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPiBPbiBGcmksIDIwMTktMDgtMjMgYXQgMTA6NTcgKzAy
MDAsIExpbnVzIFdhbGxlaWogd3JvdGU6DQo+ID4gPiBPbiBNb24sIEF1ZyAxOSwgMjAxOSBhdCAx
MToyMiBBTSBNYXJzIENoZW5nIDxtYXJzLmNoZW5nQG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+IA0K
PiA+ID4gVGhpcyBkb2VzIG5vdCBleHBsYWluIHdoYXQgYSAidmlydHVhbCBHUElPIiBpcyBpbiB0
aGlzDQo+ID4gPiBjb250ZXh0LCBzbyBwbGVhc2UgZWxhYm9yYXRlLiBXaGF0IGlzIHRoaXM/IFdo
eSBkb2VzDQo+ID4gPiBpdCBleGlzdD8gV2hhdCBpcyBpdCB1c2VkIGZvcj8NCj4gPiA+DQo+ID4g
PiBHUElPIGlzICJnZW5lcmFsIHB1cnBvc2UgaW5wdXQvb3V0cHV0IiBhbmQgaXQgaXMgYQ0KPiA+
ID4gcHJldHR5IHJ1YmJlcnkgY2F0ZWdvcnkgYWxyZWFkeSBhcyBpdCBpcywgc28gd2UgbmVlZA0K
PiA+ID4gdG8gZGVmaW5lIG91ciB0ZXJtcyBwcmV0dHkgc3RyaWN0bHkuDQo+ID4gPg0KPiA+IFZp
cnR1YWwgR1BJTyBvbmx5IHVzZWQgaW5zaWRlIFNPQyBhbmQgbm90IGJlaW5nIGV4cG9ydGVkIHRv
IG91dHNpZGUgU09DDQo+ID4gaW4gTVRLIHBsYXRmb3JtLiBTb21lIG1vZHVsZXMgdXNlIHZpcnR1
YWwgR1BJTyBhcyBlaW50IChlLmcuIHBtaWMgb3INCj4gPiB1c2IpLg0KPiANCj4gSSB3b3VsZCBj
YWxsIHRoYXQgaW50ZXJuYWwgR1BJT3MsIHRob3NlIGFyZSB2ZXJ5IHJlYWwgcmFpbHMgaW5zaWRl
DQo+IHRoZSBjaGlwIG1hZGUgd2l0aCBwb2x5c2lsaWNvbmUgc28gdGhlcmUgaXMgbm90aGluZyAi
dmlydHVhbCINCj4gYWJvdXQgdGhlbS4gSWYgdGhlIGRvY3VtZW50YXRpb24gZm9yIHRoZSBjaGlw
IGNhbGxzIHRoZW0gdmlydHVhbA0KPiB0aGVuIGV4cGxhaW4gaW4gdGhlIGRyaXZlciB0aGF0IHRo
ZXNlIGFyZSBTb0MtaW50ZXJuYWwNCj4gbGluZXMgc28gdGhhdCBldmVyeW9uZSB3aWxsIGdldCBp
dC4NCj4gDQoNCkdvdCBpdCwgSSB3aWxsIGFkZCB0aGUgaW5mbyBpbnRvIHRoZSBkcml2ZXIgaW4g
djMgDQoNCj4gSXMgdGhlIFBNSUMgaW5zaWRlIHRoZSBTb0M/IEkgdGhvdWdodCB0aGF0IHdhcyB1
c3VhbGx5IG91dHNpZGUgb2YgaXQNCj4gaW4gaXRzIG93biBjaGlwLg0KPiANCj4gQnV0IEkgc3Vw
cG9zZSB0aGVyZSBjb3VsZCBiZSBzb21lIGludGVyZmFjZSB0byBpdCBpbiB0aGUgU29DIGFuZA0K
PiB0aGVuIHRoYXQgaW50ZXJmYWNlIGhhcyB0aGlzIEVJTlQ/DQo+IA0KDQpUaGF0J3MgcmlnaHQu
IEkgdXNlIGluY29ycmVjdCB3b3JkLg0KZS5nLiBwbWljIGludGVyZmFjZSBpbnNpZGUgdGhlIFNP
QyAoUE1JRiksIG5vdCBwbWljLi4uDQoNCj4gPiBJbiBNVEsgcGxhdGZvcm0sIGV4dGVybmFsIGlu
dGVycnVwdCAoRUlOVCkgYW5kIEdQSU8gaXMgMS0xIG1hcHBpbmcgYW5kDQo+ID4gd2UgY2FuIHNl
dCBHUElPIGFzIGVpbnQuDQo+ID4gQnV0IHNvbWUgbW9kdWxlcyB1c2Ugc3BlY2lmaWMgZWludCB3
aGljaCBkb2Vzbid0IGhhdmUgcmVhbCBHUElPIHBpbi4NCj4gPiBTbyB3ZSB1c2UgdmlydHVhbCBH
UElPIHRvIG1hcCBpdC4NCj4gDQo+IE9LIEkgZ2V0IGl0IEkgdGhpbmsuLi4ganVzdCBwdXQgdGhl
c2UgY29tbWVudHMgaW50byB0aGUgY29kZSBhcyB3ZWxsDQo+IHNvIHdlIHVuZGVyc3RhbmQgd2hl
biByZWFkaW5nIHRoZSBjb2RlIHdoYXQgaXMgZ29pbmcgb24uDQoNCkdvdCBpdCwgd2lsbCBhZGQg
dGhlIGNvbW1lbnRzIGluIHYzLiBUaGFua3MgZm9yIHJldmlld2luZy4NCg0KPiANCj4gPiA+ID4g
KyAgICAgICBpZiAobXRrX2lzX3ZpcnRfZ3BpbyhodywgZ3BpbykpDQo+ID4gPiA+ICsgICAgICAg
ICAgICAgICByZXR1cm4gMTsNCj4gPiA+DQo+ID4gPiBXaHkgYXJlICJ2aXJ0dWFsIEdQSU9zIiBh
bHdheXMgaW5wdXRzPw0KPiA+DQo+ID4gV2Ugc2V0IHZpcnR1YWwgR1BJTyBhcyBlaW50Lg0KPiA+
IEl0IG1lYW4gdmlydHVhbCBHUElPIG9ubHkgdXNlZCBpbnNpZGUgU09DIGFuZCBub3QgYmVpbmcg
ZXhwb3J0ZWQgdG8NCj4gPiBvdXRzaWRlIFNPQy4NCj4gDQo+IEFyZSB5b3Ugc2F5aW5nIHRoYXQ6
DQo+IC0gIlZpcnR1YWwiIEdQSU9zIGFyZSBhbHdheXMgYW5kIG9ubHkgdXNlZCBmb3IgaW50ZXJy
dXB0cw0KPiAtIFNpbmNlIHRoZXkgYXJlIG9ubHkgdXNlZCBmb3IgaW50ZXJydXB0cywgdGhleSBh
cmUgYWx3YXlzIGlucHV0cw0KPiANCj4gVGhlbiB3cml0ZSB0aGF0IGluIGEgY29tbWVudCB0byB0
aGUgYWJvdmUgY2hhbmdlIHNvIHdlIGtub3cNCj4gdGhpcyBjb250ZXh0Lg0KPiANCg0KWWVzLCB2
aXJ0dWFsIEdQSU9zIGFyZSBhbHdheXMgYW5kIG9ubHkgdXNlZCBmb3IgaW50ZXJydXB0cyBpbiBt
dGsNCnBsYXRmb3JtLiBJJ2xsIGFkZCB0aGUgY29tbWVudHMgaW4gdjMuIFRoYW5rcyBmb3IgcmV2
aWV3aW5nDQoNCj4gWW91cnMsDQo+IExpbnVzIFdhbGxlaWoNCj4gDQo+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IExpbnV4LW1lZGlhdGVrIG1haWxp
bmcgbGlzdA0KPiBMaW51eC1tZWRpYXRla0BsaXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbWVkaWF0ZWsNCg0KDQo=

