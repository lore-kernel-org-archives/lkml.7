Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D84C2D0D3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 03:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4731420709
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 03:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bltNlyAc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfLWDLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 22:11:09 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:1861 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726393AbfLWDLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 22:11:08 -0500
X-UUID: 50313d1214cd47cd8d8ff6424397f7d6-20191223
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Date:Content-Type:References:In-Reply-To:CC:To:From:Subject:Message-ID; bh=1gjqBsxQJFzTJYcXv+4xkR26006Bc8pqbfyHt8iDVik=;
        b=bltNlyAcaQK0NROYx4CJosBHds/na0LlyG2rB2vmu2OT42YBTic+cwnHz4E7K6I+LZ1BxQkr6/CTdOiaszTFk05aif+OslcdjvtkCAkyNnHLkrY5XgbCHZcAMjsUGxouo346EPUrzkzbRYiQ/nNU1lR5sfGgsu+bDrvBeX4UFf0=;
X-UUID: 50313d1214cd47cd8d8ff6424397f7d6-20191223
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <hanks.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 956786830; Mon, 23 Dec 2019 11:11:02 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 23 Dec 2019 11:10:59 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 23 Dec 2019 11:11:12 +0800
Message-ID: <1577022724.7468.20.camel@mtkswgap22>
Subject: Re: [PATCH v2 05/11] pinctrl: mediatek: avoid virtual gpio trying
 to set reg
From:   Hanks Chen <hanks.chen@mediatek.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Mars Cheng <mars.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        mtk01761 <wendell.lin@mediatek.com>,
        linux-clk <linux-clk@vger.kernel.org>
In-Reply-To: <CACRpkdZa_sQgvWC3ic0NxrVi9gS1cNTsV-wa-SDpA0e5kutBRw@mail.gmail.com>
References: <1566206502-4347-1-git-send-email-mars.cheng@mediatek.com>
         <1566206502-4347-6-git-send-email-mars.cheng@mediatek.com>
         <CACRpkdZa_sQgvWC3ic0NxrVi9gS1cNTsV-wa-SDpA0e5kutBRw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Sun, 22 Dec 2019 21:52:04 +0800
MIME-Version: 1.0
X-Mailer: Evolution 3.2.3-0ubuntu6 
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTA4LTIzIGF0IDEwOjU3ICswMjAwLCBMaW51cyBXYWxsZWlqIHdyb3RlOg0K
PiBPbiBNb24sIEF1ZyAxOSwgMjAxOSBhdCAxMToyMiBBTSBNYXJzIENoZW5nIDxtYXJzLmNoZW5n
QG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+IA0KPiA+IGZvciB2aXJ0dWFsIGdwaW9zLCB0aGV5IHNo
b3VsZCBub3QgZG8gcmVnIHNldHRpbmcgYW5kDQo+ID4gc2hvdWxkIGJlaGF2ZSBhcyBleHBlY3Rl
ZCBmb3IgZWludCBmdW5jdGlvbi4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hcnMgQ2hlbmcg
PG1hcnMuY2hlbmdAbWVkaWF0ZWsuY29tPg0KPiANCj4gVGhpcyBkb2VzIG5vdCBleHBsYWluIHdo
YXQgYSAidmlydHVhbCBHUElPIiBpcyBpbiB0aGlzDQo+IGNvbnRleHQsIHNvIHBsZWFzZSBlbGFi
b3JhdGUuIFdoYXQgaXMgdGhpcz8gV2h5IGRvZXMNCj4gaXQgZXhpc3Q/IFdoYXQgaXMgaXQgdXNl
ZCBmb3I/DQo+IA0KPiBHUElPIGlzICJnZW5lcmFsIHB1cnBvc2UgaW5wdXQvb3V0cHV0IiBhbmQg
aXQgaXMgYQ0KPiBwcmV0dHkgcnViYmVyeSBjYXRlZ29yeSBhbHJlYWR5IGFzIGl0IGlzLCBzbyB3
ZSBuZWVkDQo+IHRvIGRlZmluZSBvdXIgdGVybXMgcHJldHR5IHN0cmljdGx5Lg0KPiANClZpcnR1
YWwgR1BJTyBvbmx5IHVzZWQgaW5zaWRlIFNPQyBhbmQgbm90IGJlaW5nIGV4cG9ydGVkIHRvIG91
dHNpZGUgU09DDQppbiBNVEsgcGxhdGZvcm0uIFNvbWUgbW9kdWxlcyB1c2UgdmlydHVhbCBHUElP
IGFzIGVpbnQgKGUuZy4gcG1pYyBvcg0KdXNiKS4NCkluIE1USyBwbGF0Zm9ybSwgZXh0ZXJuYWwg
aW50ZXJydXB0IChFSU5UKSBhbmQgR1BJTyBpcyAxLTEgbWFwcGluZyBhbmQNCndlIGNhbiBzZXQg
R1BJTyBhcyBlaW50Lg0KQnV0IHNvbWUgbW9kdWxlcyB1c2Ugc3BlY2lmaWMgZWludCB3aGljaCBk
b2Vzbid0IGhhdmUgcmVhbCBHUElPIHBpbi4NClNvIHdlIHVzZSB2aXJ0dWFsIEdQSU8gdG8gbWFw
IGl0Lg0KDQo+ID4gK2Jvb2wgbXRrX2lzX3ZpcnRfZ3BpbyhzdHJ1Y3QgbXRrX3BpbmN0cmwgKmh3
LCB1bnNpZ25lZCBpbnQgZ3Bpb19uKQ0KPiA+ICt7DQo+ID4gKyAgICAgICBjb25zdCBzdHJ1Y3Qg
bXRrX3Bpbl9kZXNjICpkZXNjOw0KPiA+ICsgICAgICAgYm9vbCB2aXJ0X2dwaW8gPSBmYWxzZTsN
Cj4gPiArDQo+ID4gKyAgICAgICBpZiAoZ3Bpb19uID49IGh3LT5zb2MtPm5waW5zKQ0KPiA+ICsg
ICAgICAgICAgICAgICByZXR1cm4gdmlydF9ncGlvOw0KPiA+ICsNCj4gPiArICAgICAgIGRlc2Mg
PSAoY29uc3Qgc3RydWN0IG10a19waW5fZGVzYyAqKSZody0+c29jLT5waW5zW2dwaW9fbl07DQo+
ID4gKw0KPiA+ICsgICAgICAgaWYgKGRlc2MtPmZ1bmNzICYmDQo+ID4gKyAgICAgICAgICAgZGVz
Yy0+ZnVuY3NbZGVzYy0+ZWludC5laW50X21dLm5hbWUgPT0gMCkNCj4gDQo+IE5VTEwgY2hlY2sg
aXMgZG9uZSBsaWtlIHRoaXM6DQo+IA0KPiBpZiAoZGVzYy0+ZnVuY3MgJiYgIWRlc2MtPmZ1bmNz
W2Rlc2MtPmVpbnQuZWludF9tXS5uYW1lKQ0KPiANCj4gPiArICAgICAgICAgICAgICAgdmlydF9n
cGlvID0gdHJ1ZTsNCj4gDQoNCmdvdCBpdCwgd2lsbCBmaXggaXQgaW4gdjMuIFRoYW5rcyBmb3Ig
cmV2aWV3aW5nLg0KDQo+IFNvIHdoeSBpcyB0aGlzIEdQSU8gInZpcnR1YWwiIGJlY2F1c2UgaXQg
ZG9lcyBub3QgaGF2ZQ0KPiBhIG5hbWUgaW4gdGhlIGZ1bmNzIHRhYmxlPw0KPiANCnllcywgaXQg
ZG9lc24ndCBoYXZlIHJlYWwgR1BJTyBwaW4gYW5kIG5hbWUsIHNvIHdlIHNldCBpdCBhcyB2aXJ0
dWFsIEdQSU8uDQoNCj4gPiBAQCAtMjc4LDYgKzI5NSw5IEBAIHN0YXRpYyBpbnQgbXRrX3h0X3Nl
dF9ncGlvX2FzX2VpbnQodm9pZCAqZGF0YSwgdW5zaWduZWQgbG9uZyBlaW50X24pDQo+ID4gICAg
ICAgICBpZiAoZXJyKQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gZXJyOw0KPiA+DQo+ID4g
KyAgICAgICBpZiAobXRrX2lzX3ZpcnRfZ3BpbyhodywgZ3Bpb19uKSkNCj4gPiArICAgICAgICAg
ICAgICAgcmV0dXJuIDA7DQo+IA0KPiBTbyBkb2VzIHRoaXMgbWVhbiB3ZSBhbHdheXMgc3VjY2Vl
ZCBpbiBzZXR0aW5nIGEgR1BJTyBhcyBlaW50DQo+IGlmIGl0IGlzIHZpcnR1YWw/IFdoeT8gRXhw
bGFuYXRvcnkgY29tbWVudCBpcyBuZWVkZWQuDQo+IA0KeWVzLCB3ZSB1c2UgdmlydHVhbCBHUElP
IHRvIG1hcCBpdC4NCg0KPiA+IEBAIC02OTMsNiArNjkzLDkgQEAgc3RhdGljIGludCBtdGtfZ3Bp
b19nZXRfZGlyZWN0aW9uKHN0cnVjdCBncGlvX2NoaXAgKmNoaXAsIHVuc2lnbmVkIGludCBncGlv
KQ0KPiA+ICAgICAgICAgY29uc3Qgc3RydWN0IG10a19waW5fZGVzYyAqZGVzYzsNCj4gPiAgICAg
ICAgIGludCB2YWx1ZSwgZXJyOw0KPiA+DQo+ID4gKyAgICAgICBpZiAobXRrX2lzX3ZpcnRfZ3Bp
byhodywgZ3BpbykpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAxOw0KPiANCj4gV2h5IGFy
ZSAidmlydHVhbCBHUElPcyIgYWx3YXlzIGlucHV0cz8NCj4gDQpXZSBzZXQgdmlydHVhbCBHUElP
IGFzIGVpbnQuDQpJdCBtZWFuIHZpcnR1YWwgR1BJTyBvbmx5IHVzZWQgaW5zaWRlIFNPQyBhbmQg
bm90IGJlaW5nIGV4cG9ydGVkIHRvDQpvdXRzaWRlIFNPQy4NCg0KPiBZb3VycywNCj4gTGludXMg
V2FsbGVpag0KDQpTb3JyeSBmb3IgdGhlIGxhdGUgcmVwbHkuDQoNCkknbSB0aGUgbmV3IGJzcCBj
b250YWN0IG9mIG10ayBwaG9uZSBwcm9qZWN0Lg0KSSB3aWxsIGJlIHRha2luZyBvdmVyIGZyb20g
TWFycy4NCg0KVGhhbmtzIGZvciByZXZpZXdpbmcuDQo=

