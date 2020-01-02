Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D289C3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 07:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF0121655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 07:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YUkiflPG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgABHBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 02:01:40 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:17739 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726078AbgABHBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 02:01:40 -0500
X-UUID: 6d68b873afc64aa59e6a0199438765db-20200102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:Reply-To:From:Subject:Message-ID; bh=In6OwDT/YxJiEkeYl7SpJiR0aYr+OGSpKakTOdvs2lk=;
        b=YUkiflPGEm4wImhJkdA9cRkGXUVtkBJjO+Psmd2HhUHTCR/rlikevJe8w3XQMX3Fh/K8ZvXCq3OmxgFayb5VB9Ih5abwFnmVBPcUoCX3qQycpw4A3CPuo0LqkG3M5j+EOEle4GlpMuMdmEU+bTmtPUfoVh2aTQ9OL7snHXUa3PI=;
X-UUID: 6d68b873afc64aa59e6a0199438765db-20200102
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 296047620; Thu, 02 Jan 2020 15:01:37 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs05n1.mediatek.inc
 (172.21.101.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 2 Jan
 2020 15:01:10 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 2 Jan 2020 15:01:59 +0800
Message-ID: <1577948404.15116.18.camel@mhfsdcap03>
Subject: Re: [PATCH v6, 02/14] drm/mediatek: move dsi/dpi select input into
 mtk_ddp_sel_in
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
Reply-To: Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 2 Jan 2020 15:00:04 +0800
In-Reply-To: <1577947234.4925.2.camel@mtksdaap41>
References: <1577937624-14313-1-git-send-email-yongqiang.niu@mediatek.com>
         <1577937624-14313-3-git-send-email-yongqiang.niu@mediatek.com>
         <1577941388.24650.2.camel@mtksdaap41> <1577943579.15116.1.camel@mhfsdcap03>
         <1577944949.32066.1.camel@mtksdaap41> <1577946073.15116.8.camel@mhfsdcap03>
         <1577947234.4925.2.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTAxLTAyIGF0IDE0OjQwICswODAwLCBDSyBIdSB3cm90ZToNCj4gSGksIFlv
bmdxaWFuZzoNCj4gDQo+IE9uIFRodSwgMjAyMC0wMS0wMiBhdCAxNDoyMSArMDgwMCwgWW9uZ3Fp
YW5nIE5pdSB3cm90ZToNCj4gPiBPbiBUaHUsIDIwMjAtMDEtMDIgYXQgMTQ6MDIgKzA4MDAsIENL
IEh1IHdyb3RlOg0KPiA+ID4gSGksIFlvbmdxaWFuZzoNCj4gPiA+IA0KPiA+ID4gT24gVGh1LCAy
MDIwLTAxLTAyIGF0IDEzOjM5ICswODAwLCBZb25ncWlhbmcgTml1IHdyb3RlOg0KPiA+ID4gPiBP
biBUaHUsIDIwMjAtMDEtMDIgYXQgMTM6MDMgKzA4MDAsIENLIEh1IHdyb3RlOg0KPiA+ID4gPiA+
IEhpLCBZb25ncWlhbmc6DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gT24gVGh1LCAyMDIwLTAxLTAy
IGF0IDEyOjAwICswODAwLCBZb25ncWlhbmcgTml1IHdyb3RlOg0KPiA+ID4gPiA+ID4gbW92ZSBk
c2kvZHBpIHNlbGVjdCBpbnB1dCBpbnRvIG10a19kZHBfc2VsX2luDQo+ID4gPiA+ID4gPiANCj4g
PiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFlvbmdxaWFuZyBOaXUgPHlvbmdxaWFuZy5uaXVAbWVk
aWF0ZWsuY29tPg0KPiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiAgZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcm1fZGRwLmMgfCAxMCArKysrKystLS0tDQo+ID4gPiA+ID4gPiAgMSBm
aWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPiA+ID4gPiA+
IA0KPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2RkcC5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwLmMNCj4gPiA+
ID4gPiA+IGluZGV4IDM5NzAwYjkuLjkxYzliMTkgMTAwNjQ0DQo+ID4gPiA+ID4gPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHAuYw0KPiA+ID4gPiA+ID4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwLmMNCj4gPiA+ID4gPiA+IEBAIC0z
NzYsNiArMzc2LDEyIEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgbXRrX2RkcF9zZWxfaW4oZW51bSBt
dGtfZGRwX2NvbXBfaWQgY3VyLA0KPiA+ID4gPiA+ID4gIAl9IGVsc2UgaWYgKGN1ciA9PSBERFBf
Q09NUE9ORU5UX0JMUyAmJiBuZXh0ID09IEREUF9DT01QT05FTlRfRFNJMCkgew0KPiA+ID4gPiA+
ID4gIAkJKmFkZHIgPSBESVNQX1JFR19DT05GSUdfRFNJX1NFTDsNCj4gPiA+ID4gPiA+ICAJCXZh
bHVlID0gRFNJX1NFTF9JTl9CTFM7DQo+ID4gPiA+ID4gPiArCX0gZWxzZSBpZiAoY3VyID09IERE
UF9DT01QT05FTlRfUkRNQTEgJiYgbmV4dCA9PSBERFBfQ09NUE9ORU5UX0RTSTApIHsNCj4gPiA+
ID4gPiA+ICsJCSphZGRyID0gRElTUF9SRUdfQ09ORklHX0RTSV9TRUw7DQo+ID4gPiA+ID4gPiAr
CQl2YWx1ZSA9IERTSV9TRUxfSU5fUkRNQTsNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJbiBvcmln
aW5hbCBjb2RlLCB0aGlzIGlzIHNldCB3aGVuIGN1ciA9PSBERFBfQ09NUE9ORU5UX0JMUyBhbmQg
bmV4dCA9PQ0KPiA+ID4gPiA+IEREUF9DT01QT05FTlRfRFBJMC4gV2h5IGRvIHlvdSBjaGFuZ2Ug
dGhlIGNvbmRpdGlvbj8NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBSZWdhcmRzLA0KPiA+ID4gPiA+
IENLDQo+ID4gPiA+IA0KPiA+ID4gPiBpZiBibHMgY29ubmVjdCB3aXRoIGRwaTAsIHJkbWExIHNo
b3VsZCBjb25uZWN0IHdpdGggZHNpMCwgdGhlIGNvbmRpdGlvbg0KPiA+ID4gPiBpcyBzYW1lIHdp
dGggYmVmb3JlLg0KPiA+ID4gDQo+ID4gPiBZb3Ugc3VnZ2VzdCB0aGF0IHR3byBjcnRjcyBhcmUg
Ym90aCBlbmFibGVkLiBJZiBvbmx5IG9uZSBjcnRjIGlzDQo+ID4gPiBlbmFibGVkLCBqdXN0IG9u
ZSBvZiB0aGVzZSB0d28gd291bGQgYmUgc2V0Lg0KPiA+ID4gDQo+ID4gPiBSZWdhcmRzLA0KPiA+
ID4gQ0sNCj4gPiANCj4gPiBPSywgaSB3aWxsIG1vZGlmeSBsaWtlIHRoaXMNCj4gPiBlbHNlIGlm
IChjdXIgPT0gRERQX0NPTVBPTkVOVF9CTFMgJiYgbmV4dCA9PSBERFBfQ09NUE9ORU5UX0RQSTAp
IHsNCj4gPiAJCSphZGRyID0gRElTUF9SRUdfQ09ORklHX0RTSV9TRUw7DQo+ID4gCQl2YWx1ZSA9
IERQSV9TRUxfSU5fUkRNQTsNCj4gPiAJfQ0KPiA+IGluIG10a19kZHBfc2VsX2luLg0KPiA+IA0K
PiA+IGRvbid0IHNldCBESVNQX1JFR19DT05GSUdfRFBJX1NFTCB0byBEUElfU0VMX0lOX0JMUyBh
bnltb3JlLCBiZWNhdXNlDQo+ID4gRFBJX1NFTF9JTl9CTFMgaXMgemVybywgaXQgaXMgc2FtZSB3
aXRoIGhhcmR3YXJlIGRlZmF1bHQgc2V0dGluZy4NCj4gDQo+IEluIEJpYmJ5J3MgY2FzZSwgdGhl
cmUgaXMgb25seSB0aGUgcGF0aCBmcm9tIEJMUyB0byBEUEkwIGFuZCBoYXMgbm8gcGF0aA0KPiBm
cm9tIFJETUExIHRvIERTSTAsIGJ1dCBpdCBuZWVkIHRvIHNldCB0aGVzZSB0d28gcmVnaXN0ZXIu
IE1heWJlIGl0cw0KPiBzZXR0aW5nIGlzIGp1c3QgZm9yIHNvbWUgU29DLCBzbyB5b3UgbWF5IHVz
ZSB0aGUgY29tcGF0aWJsZSBuYW1lIHRvDQo+IGp1ZGdlIGhvdyB0byBzZXQgdGhpcyB0d28gcmVn
aXN0ZXIuDQo+IA0KPiBSZWdhcmRzLA0KPiBDSw0KPiANCg0KaXQgdGhlIG9yaWdpbmFsIHVzZSBj
YXNlLCBpZiBibHMtPmRwaTAsIGl0IHNldCAzIHJlZ2lzdGVyLA0KRElTUF9SRUdfQ09ORklHX0RQ
SV9TRUwgc2V0IHRvIERQSV9TRUxfSU5fQkxTICxhbmQgdGhpcyBpcyANCjAsIHNvIHRoaXMgaXMg
dXNlbGVzcyBzZXR0aW5nLg0KDQp0aGVuIGFyZSBvbmx5IDIgdXNlZnVsIHNldHRpbmcuDQppbiB0
aGlzIHBhdGNoIGkgaGF2ZSB1cGxvYWQsIGkga2VlcCBESVNQX1JFR19DT05GSUdfT1VUX1NFTA0K
c3RpbGwgaW4gbXRrX2RkcF9zb3V0X3NlbC4NCmFuZCBvbmx5IG1vdmUgRElTUF9SRUdfQ09ORklH
X0RTSV9TRUwgaW50byBtdGtfZGRwX3NlbF9pbi4NCmkgc3VwcG9zZSB0aGlzIGlzIGVub3VnaCBm
b3IgdGhpcyB1c2UgY2FzZS4NCmFuZCBubyBuZWVkIGNvbXBhdGlibGUgbmFtZSB0byBjb250cm9s
IHRoaXMuDQpwbGVhc2UgZG91YmxlIGNvbmZpcm0uDQoNCmFuZCB0aGVyZSB3aWxsIG1vcmUgYW5k
IG1vcmUgU09DIHVwc3RyZWFtIGluIHRoZSBmdXR1cmUuDQp0aGVzZSBmdW5jdGlvbiB3aWxsIGJl
IG1vcmUgY29tcGxleC4NCnRoZXJlIHNob3VsZCBiZSBjb2Rpbmcgb25lIG1vcmUgc3VpdGFibGUg
ZnVuY3Rpb24gdG8gDQpoYW5kbGUgdGhlc2UgY29ubmVjdGlvbg0KDQo+ID4gPiANCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiA+ICsJfSBlbHNlIGlmIChjdXIgPT0gRERQX0NPTVBPTkVOVF9CTFMgJiYg
bmV4dCA9PSBERFBfQ09NUE9ORU5UX0RQSTApIHsNCj4gPiA+ID4gPiA+ICsJCSphZGRyID0gRElT
UF9SRUdfQ09ORklHX0RQSV9TRUw7DQo+ID4gPiA+ID4gPiArCQl2YWx1ZSA9IERQSV9TRUxfSU5f
QkxTOw0KPiA+ID4gPiA+ID4gIAl9IGVsc2Ugew0KPiA+ID4gPiA+ID4gIAkJdmFsdWUgPSAwOw0K
PiA+ID4gPiA+ID4gIAl9DQo+ID4gPiA+ID4gPiBAQCAtMzkzLDEwICszOTksNiBAQCBzdGF0aWMg
dm9pZCBtdGtfZGRwX3NvdXRfc2VsKHN0cnVjdCByZWdtYXAgKmNvbmZpZ19yZWdzLA0KPiA+ID4g
PiA+ID4gIAl9IGVsc2UgaWYgKGN1ciA9PSBERFBfQ09NUE9ORU5UX0JMUyAmJiBuZXh0ID09IERE
UF9DT01QT05FTlRfRFBJMCkgew0KPiA+ID4gPiA+ID4gIAkJcmVnbWFwX3dyaXRlKGNvbmZpZ19y
ZWdzLCBESVNQX1JFR19DT05GSUdfT1VUX1NFTCwNCj4gPiA+ID4gPiA+ICAJCQkJQkxTX1RPX0RQ
SV9SRE1BMV9UT19EU0kpOw0KPiA+ID4gPiA+ID4gLQkJcmVnbWFwX3dyaXRlKGNvbmZpZ19yZWdz
LCBESVNQX1JFR19DT05GSUdfRFNJX1NFTCwNCj4gPiA+ID4gPiA+IC0JCQkJRFNJX1NFTF9JTl9S
RE1BKTsNCj4gPiA+ID4gPiA+IC0JCXJlZ21hcF93cml0ZShjb25maWdfcmVncywgRElTUF9SRUdf
Q09ORklHX0RQSV9TRUwsDQo+ID4gPiA+ID4gPiAtCQkJCURQSV9TRUxfSU5fQkxTKTsNCj4gPiA+
ID4gPiA+ICAJfQ0KPiA+ID4gPiA+ID4gIH0NCj4gPiA+ID4gPiA+ICANCj4gPiA+ID4gPiANCj4g
PiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiANCj4gPiANCj4gPiAN
Cj4gDQo+IA0KDQo=

