Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00D1C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 02:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7EEC2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 02:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nrIaNHV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfLQCuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 21:50:55 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:25223 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726616AbfLQCuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 21:50:55 -0500
X-UUID: d03b831c095c4d30afbbd12e2b0bcea0-20191217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=LX30lj8mLQVTtpAKiV/zXtanwXXaFbc1xBxLxcZmnMQ=;
        b=nrIaNHV2yuAOhrQ9+Ghww+UVVXb5yvtWfuGMafMjUxEYhNf/Vb+/ZPwIF7LvutddoqIHvD66wo3YAWEVxBEP2Tj7AxyOvaTrTKRp6YUJyKEj421IwFXFTIHn4NNQ7yFZ7H1hlCzjNENgMHxu+RNApAy2HOdRADS2Q1nxa82GjTc=;
X-UUID: d03b831c095c4d30afbbd12e2b0bcea0-20191217
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1851522241; Tue, 17 Dec 2019 10:50:50 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 17 Dec 2019 10:50:13 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 17 Dec 2019 10:49:57 +0800
Message-ID: <1576551044.14035.18.camel@mtksdaap41>
Subject: Re: [PATCH v9 3/9] soc: mediatek: Add basic_clk_id to scp_power_data
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>
Date:   Tue, 17 Dec 2019 10:50:44 +0800
In-Reply-To: <CANMq1KC4Qz8yKNTqfjYb335RCY8t5pdRa09Bvroo_BNXv19hWQ@mail.gmail.com>
References: <1575960413-6900-1-git-send-email-weiyi.lu@mediatek.com>
         <1575960413-6900-4-git-send-email-weiyi.lu@mediatek.com>
         <CANMq1KC4Qz8yKNTqfjYb335RCY8t5pdRa09Bvroo_BNXv19hWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 642B78DF808E55FC0C5C4E033F841D60DDCD4CB0A219E378767E8FE960F53DE02000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTEyLTE2IGF0IDE1OjAxICswODAwLCBOaWNvbGFzIEJvaWNoYXQgd3JvdGU6
DQo+IE9uIFR1ZSwgRGVjIDEwLCAyMDE5IGF0IDI6NDcgUE0gV2VpeWkgTHUgPHdlaXlpLmx1QG1l
ZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBUcnkgdG8gc3RvcCBleHRlbmRpbmcgdGhlIGNs
a19pZCBvciBjbGtfbmFtZXMgaWYgdGhlcmUgYXJlDQo+ID4gbW9yZSBhbmQgbW9yZSBuZXcgQkFT
SUMgY2xvY2tzLiBUbyBnZXQgaXRzIG93biBjbG9ja3MgYnkgdGhlDQo+ID4gYmFzaWNfY2xrX2lk
IG9mIGVhY2ggcG93ZXIgZG9tYWluLg0KPiANCj4gTG9va2luZyBhdCB0aGlzIGEgYml0IG1vcmUs
IEknbSBub3Qgc3VyZSB3aHkgd2UgbWFrZSB0aGlzIGFuIG9wdGlvbi4uLg0KPiANCj4gVGhlIGVh
c2llc3Qgd2F5IHRvIG1ha2UgdGhpcyBjb25zaXN0ZW50IHdpdGggbm9uLU1UODE4MyBzY3BzeXMg
ZHJpdmVycw0KPiBpcyB0byBhZGQgeW91ciBtaXNzaW5nIGNsb2NrcyB0byAiZW51bSBjbGtfaWQi
IGFuZCBjbGtfbmFtZXMsIGJ1dCBJDQo+IHVuZGVyc3RhbmQgaXQncyBub3QgZGVzaXJlZCAobnVt
YmVyIG9mIGNsb2NrcyB3b3VsZCBibG93IHVwKS4NCj4gDQo+IENhbiB3ZSwgaW5zdGVhZCwgY29u
dmVydCBhbGwgZXhpc3Rpbmcgc2Nwc3lzIGRyaXZlcnMgdG8gdXNlICJjaGFyICoiDQo+IGNsb2Nr
IG5hbWVzIGluc3RlYWQ/DQo+IEkgbWFkZSBhbiBhdHRlbXB0IGhlcmUgYW5kIGl0IHNlZW1zIHNp
bXBsZSBlbm91Z2g6DQo+IGh0dHBzOi8vY2hyb21pdW0tcmV2aWV3Lmdvb2dsZXNvdXJjZS5jb20v
Yy9jaHJvbWl1bW9zL3RoaXJkX3BhcnR5L2tlcm5lbC8rLzE5NjkxMDMNCj4gDQoNClRoYXQncyB3
aGF0IHdlJ2QgbGlrZSB0byBkbyBpbiB0aGUgZnV0dXJlLiBCdXQgeW91J3JlIHJpZ2h0ISBJIHNo
b3VsZA0KY29tcGxldGUgaXQgYXQgb25lIGdvLg0KDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBX
ZWl5aSBMdSA8d2VpeWkubHVAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3Nv
Yy9tZWRpYXRlay9tdGstc2Nwc3lzLmMgfCAyOSArKysrKysrKysrKysrKysrKysrKystLS0tLS0t
LQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmMg
Yi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmMNCj4gPiBpbmRleCBmNjY5ZDM3Li45
MTVkNjM1IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1zY3BzeXMu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1zY3BzeXMuYw0KPiA+IEBAIC0x
MTcsNiArMTE3LDggQEAgZW51bSBjbGtfaWQgew0KPiA+ICAgKiBAc3JhbV9wZG5fYWNrX2JpdHM6
IFRoZSBtYXNrIGZvciBzcmFtIHBvd2VyIGNvbnRyb2wgYWNrZWQgYml0cy4NCj4gPiAgICogQGJ1
c19wcm90X21hc2s6IFRoZSBtYXNrIGZvciBzaW5nbGUgc3RlcCBidXMgcHJvdGVjdGlvbi4NCj4g
PiAgICogQGNsa19pZDogVGhlIGJhc2ljIGNsb2NrcyByZXF1aXJlZCBieSB0aGlzIHBvd2VyIGRv
bWFpbi4NCj4gPiArICogQGJhc2ljX2Nsa19pZDogcHJvdmlkZSB0aGUgc2FtZSBwdXJwb3NlIHdp
dGggZmllbGQgImNsa19pZCINCj4gPiArICogICAgICAgICAgICAgICAgYnkgZGVjbGFyaW5nIGJh
c2ljIGNsb2NrIHByZWZpeCBuYW1lIHJhdGhlciB0aGFuIGNsa19pZC4NCj4gDQo+IEFjdHVhbGx5
LCBJIHByZWZlciB0aGUgbmFtZSBjbGtfbmFtZSwgbm90IHN1cmUgd2h5IEkgcHVzaGVkIHlvdSBp
bg0KPiB0aGF0IGRpcmVjdGlvbi4uLg0KPiANCg0KT0ssIEknbGwgZml4IGl0IGluIG5leHQgdmVy
c2lvbi4gQnV0IEknZCBsaWtlIHRvIHVzZSAiYmFzaWNfY2xrX25hbWUiDQpiZWNhdXNlIHdlIHdp
bGwgYWRkICJzdWJzeXNfY2xrX3ByZWZpeCIgaW4gZm9sbG93aW5nIHBhdGNoLg0KDQo+ID4gICAq
IEBjYXBzOiBUaGUgZmxhZyBmb3IgYWN0aXZlIHdha2UtdXAgYWN0aW9uLg0KPiA+ICAgKi8NCj4g
PiAgc3RydWN0IHNjcF9kb21haW5fZGF0YSB7DQo+ID4gQEAgLTEyNyw2ICsxMjksNyBAQCBzdHJ1
Y3Qgc2NwX2RvbWFpbl9kYXRhIHsNCj4gPiAgICAgICAgIHUzMiBzcmFtX3Bkbl9hY2tfYml0czsN
Cj4gPiAgICAgICAgIHUzMiBidXNfcHJvdF9tYXNrOw0KPiA+ICAgICAgICAgZW51bSBjbGtfaWQg
Y2xrX2lkW01BWF9DTEtTXTsNCj4gPiArICAgICAgIGNvbnN0IGNoYXIgKmJhc2ljX2Nsa19pZFtN
QVhfQ0xLU107DQo+ID4gICAgICAgICB1OCBjYXBzOw0KPiA+ICB9Ow0KPiA+DQo+ID4gQEAgLTQ5
MywxNiArNDk2LDI2IEBAIHN0YXRpYyBzdHJ1Y3Qgc2NwICppbml0X3NjcChzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2LA0KPiA+DQo+ID4gICAgICAgICAgICAgICAgIHNjcGQtPmRhdGEgPSBk
YXRhOw0KPiA+DQo+ID4gLSAgICAgICAgICAgICAgIGZvciAoaiA9IDA7IGogPCBNQVhfQ0xLUyAm
JiBkYXRhLT5jbGtfaWRbal07IGorKykgew0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIHN0
cnVjdCBjbGsgKmMgPSBjbGtbZGF0YS0+Y2xrX2lkW2pdXTsNCj4gPiArICAgICAgICAgICAgICAg
aWYgKGRhdGEtPmNsa19pZFswXSkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIFdBUk5f
T04oZGF0YS0+YmFzaWNfY2xrX2lkWzBdKTsNCj4gPg0KPiA+IC0gICAgICAgICAgICAgICAgICAg
ICAgIGlmIChJU19FUlIoYykpIHsNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGRldl9lcnIoJnBkZXYtPmRldiwgIiVzOiBjbGsgdW5hdmFpbGFibGVcbiIsDQo+ID4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRhdGEtPm5hbWUpOw0KPiA+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIEVSUl9DQVNUKGMpOw0KPiA+IC0gICAg
ICAgICAgICAgICAgICAgICAgIH0NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBmb3IgKGog
PSAwOyBqIDwgTUFYX0NMS1MgJiYgZGF0YS0+Y2xrX2lkW2pdOyBqKyspIHsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBjbGsgKmMgPSBjbGtbZGF0YS0+Y2xrX2lk
W2pdXTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoSVNf
RVJSKGMpKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRl
dl9lcnIoJnBkZXYtPmRldiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAiJXM6IGNsayB1bmF2YWlsYWJsZVxuIiwNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkYXRhLT5uYW1lKTsNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIEVSUl9DQVNUKGMpOw0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiA+DQo+ID4gLSAgICAgICAg
ICAgICAgICAgICAgICAgc2NwZC0+Y2xrW2pdID0gYzsNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHNjcGQtPmNsa1tqXSA9IGM7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgfQ0KPiA+ICsgICAgICAgICAgICAgICB9IGVsc2UgaWYgKGRhdGEtPmJhc2ljX2Nsa19pZFsw
XSkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGZvciAoaiA9IDA7IGogPCBNQVhfQ0xL
UyAmJg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkYXRhLT5i
YXNpY19jbGtfaWRbal07IGorKykNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHNjcGQtPmNsa1tqXSA9IGRldm1fY2xrX2dldCgmcGRldi0+ZGV2LA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRhdGEtPmJhc2ljX2Nsa19pZFtq
XSk7DQo+ID4gICAgICAgICAgICAgICAgIH0NCj4gPg0KPiA+ICAgICAgICAgICAgICAgICBnZW5w
ZC0+bmFtZSA9IGRhdGEtPm5hbWU7DQo+ID4gLS0NCj4gPiAxLjguMS4xLmRpcnR5DQoNCg==

