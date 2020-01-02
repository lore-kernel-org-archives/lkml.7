Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E73C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 06:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 402CA215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 06:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mk+aYi7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbgABGkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 01:40:46 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:5824 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725788AbgABGkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 01:40:45 -0500
X-UUID: 41312f93994d4f0c8e3e241188f2b99f-20200102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=XssQnV8CVAKLRbzGIfmtbhpXNMaK0W6w1OOKXrYbbt4=;
        b=mk+aYi7pfPM4JnB5A0sJyUt5MNg1Uq29k6m14BhoG+Qsh5DhftfX00UPBriZVpMByMhLR4X3WQAHU0XBFLNZ2OduIuGyUv1TPW6JBv6/ZD53Zh5k6Bi7vqMEp7WDe64Y9hEVedL7d7bQ3W0Xcqxu7b9WWJ6HuujuDHxkxAlnbbk=;
X-UUID: 41312f93994d4f0c8e3e241188f2b99f-20200102
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 575438286; Thu, 02 Jan 2020 14:40:37 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 2 Jan 2020 14:39:27 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 2 Jan 2020 14:40:37 +0800
Message-ID: <1577947234.4925.2.camel@mtksdaap41>
Subject: Re: [PATCH v6, 02/14] drm/mediatek: move dsi/dpi select input into
 mtk_ddp_sel_in
From:   CK Hu <ck.hu@mediatek.com>
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 2 Jan 2020 14:40:34 +0800
In-Reply-To: <1577946073.15116.8.camel@mhfsdcap03>
References: <1577937624-14313-1-git-send-email-yongqiang.niu@mediatek.com>
         <1577937624-14313-3-git-send-email-yongqiang.niu@mediatek.com>
         <1577941388.24650.2.camel@mtksdaap41> <1577943579.15116.1.camel@mhfsdcap03>
         <1577944949.32066.1.camel@mtksdaap41> <1577946073.15116.8.camel@mhfsdcap03>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 3DAF5B765299B3D8444E42D119D503830C3F8456D6691FBEACE97524642F0F1F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFlvbmdxaWFuZzoNCg0KT24gVGh1LCAyMDIwLTAxLTAyIGF0IDE0OjIxICswODAwLCBZb25n
cWlhbmcgTml1IHdyb3RlOg0KPiBPbiBUaHUsIDIwMjAtMDEtMDIgYXQgMTQ6MDIgKzA4MDAsIENL
IEh1IHdyb3RlOg0KPiA+IEhpLCBZb25ncWlhbmc6DQo+ID4gDQo+ID4gT24gVGh1LCAyMDIwLTAx
LTAyIGF0IDEzOjM5ICswODAwLCBZb25ncWlhbmcgTml1IHdyb3RlOg0KPiA+ID4gT24gVGh1LCAy
MDIwLTAxLTAyIGF0IDEzOjAzICswODAwLCBDSyBIdSB3cm90ZToNCj4gPiA+ID4gSGksIFlvbmdx
aWFuZzoNCj4gPiA+ID4gDQo+ID4gPiA+IE9uIFRodSwgMjAyMC0wMS0wMiBhdCAxMjowMCArMDgw
MCwgWW9uZ3FpYW5nIE5pdSB3cm90ZToNCj4gPiA+ID4gPiBtb3ZlIGRzaS9kcGkgc2VsZWN0IGlu
cHV0IGludG8gbXRrX2RkcF9zZWxfaW4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBZb25ncWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4g
PiAtLS0NCj4gPiA+ID4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwLmMg
fCAxMCArKysrKystLS0tDQo+ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcC5jIGIvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fZGRwLmMNCj4gPiA+ID4gPiBpbmRleCAzOTcwMGI5Li45MWM5YjE5IDEw
MDY0NA0KPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rk
cC5jDQo+ID4gPiA+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRw
LmMNCj4gPiA+ID4gPiBAQCAtMzc2LDYgKzM3NiwxMiBAQCBzdGF0aWMgdW5zaWduZWQgaW50IG10
a19kZHBfc2VsX2luKGVudW0gbXRrX2RkcF9jb21wX2lkIGN1ciwNCj4gPiA+ID4gPiAgCX0gZWxz
ZSBpZiAoY3VyID09IEREUF9DT01QT05FTlRfQkxTICYmIG5leHQgPT0gRERQX0NPTVBPTkVOVF9E
U0kwKSB7DQo+ID4gPiA+ID4gIAkJKmFkZHIgPSBESVNQX1JFR19DT05GSUdfRFNJX1NFTDsNCj4g
PiA+ID4gPiAgCQl2YWx1ZSA9IERTSV9TRUxfSU5fQkxTOw0KPiA+ID4gPiA+ICsJfSBlbHNlIGlm
IChjdXIgPT0gRERQX0NPTVBPTkVOVF9SRE1BMSAmJiBuZXh0ID09IEREUF9DT01QT05FTlRfRFNJ
MCkgew0KPiA+ID4gPiA+ICsJCSphZGRyID0gRElTUF9SRUdfQ09ORklHX0RTSV9TRUw7DQo+ID4g
PiA+ID4gKwkJdmFsdWUgPSBEU0lfU0VMX0lOX1JETUE7DQo+ID4gPiA+IA0KPiA+ID4gPiBJbiBv
cmlnaW5hbCBjb2RlLCB0aGlzIGlzIHNldCB3aGVuIGN1ciA9PSBERFBfQ09NUE9ORU5UX0JMUyBh
bmQgbmV4dCA9PQ0KPiA+ID4gPiBERFBfQ09NUE9ORU5UX0RQSTAuIFdoeSBkbyB5b3UgY2hhbmdl
IHRoZSBjb25kaXRpb24/DQo+ID4gPiA+IA0KPiA+ID4gPiBSZWdhcmRzLA0KPiA+ID4gPiBDSw0K
PiA+ID4gDQo+ID4gPiBpZiBibHMgY29ubmVjdCB3aXRoIGRwaTAsIHJkbWExIHNob3VsZCBjb25u
ZWN0IHdpdGggZHNpMCwgdGhlIGNvbmRpdGlvbg0KPiA+ID4gaXMgc2FtZSB3aXRoIGJlZm9yZS4N
Cj4gPiANCj4gPiBZb3Ugc3VnZ2VzdCB0aGF0IHR3byBjcnRjcyBhcmUgYm90aCBlbmFibGVkLiBJ
ZiBvbmx5IG9uZSBjcnRjIGlzDQo+ID4gZW5hYmxlZCwganVzdCBvbmUgb2YgdGhlc2UgdHdvIHdv
dWxkIGJlIHNldC4NCj4gPiANCj4gPiBSZWdhcmRzLA0KPiA+IENLDQo+IA0KPiBPSywgaSB3aWxs
IG1vZGlmeSBsaWtlIHRoaXMNCj4gZWxzZSBpZiAoY3VyID09IEREUF9DT01QT05FTlRfQkxTICYm
IG5leHQgPT0gRERQX0NPTVBPTkVOVF9EUEkwKSB7DQo+IAkJKmFkZHIgPSBESVNQX1JFR19DT05G
SUdfRFNJX1NFTDsNCj4gCQl2YWx1ZSA9IERQSV9TRUxfSU5fUkRNQTsNCj4gCX0NCj4gaW4gbXRr
X2RkcF9zZWxfaW4uDQo+IA0KPiBkb24ndCBzZXQgRElTUF9SRUdfQ09ORklHX0RQSV9TRUwgdG8g
RFBJX1NFTF9JTl9CTFMgYW55bW9yZSwgYmVjYXVzZQ0KPiBEUElfU0VMX0lOX0JMUyBpcyB6ZXJv
LCBpdCBpcyBzYW1lIHdpdGggaGFyZHdhcmUgZGVmYXVsdCBzZXR0aW5nLg0KDQpJbiBCaWJieSdz
IGNhc2UsIHRoZXJlIGlzIG9ubHkgdGhlIHBhdGggZnJvbSBCTFMgdG8gRFBJMCBhbmQgaGFzIG5v
IHBhdGgNCmZyb20gUkRNQTEgdG8gRFNJMCwgYnV0IGl0IG5lZWQgdG8gc2V0IHRoZXNlIHR3byBy
ZWdpc3Rlci4gTWF5YmUgaXRzDQpzZXR0aW5nIGlzIGp1c3QgZm9yIHNvbWUgU29DLCBzbyB5b3Ug
bWF5IHVzZSB0aGUgY29tcGF0aWJsZSBuYW1lIHRvDQpqdWRnZSBob3cgdG8gc2V0IHRoaXMgdHdv
IHJlZ2lzdGVyLg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gPiAr
CX0gZWxzZSBpZiAoY3VyID09IEREUF9DT01QT05FTlRfQkxTICYmIG5leHQgPT0gRERQX0NPTVBP
TkVOVF9EUEkwKSB7DQo+ID4gPiA+ID4gKwkJKmFkZHIgPSBESVNQX1JFR19DT05GSUdfRFBJX1NF
TDsNCj4gPiA+ID4gPiArCQl2YWx1ZSA9IERQSV9TRUxfSU5fQkxTOw0KPiA+ID4gPiA+ICAJfSBl
bHNlIHsNCj4gPiA+ID4gPiAgCQl2YWx1ZSA9IDA7DQo+ID4gPiA+ID4gIAl9DQo+ID4gPiA+ID4g
QEAgLTM5MywxMCArMzk5LDYgQEAgc3RhdGljIHZvaWQgbXRrX2RkcF9zb3V0X3NlbChzdHJ1Y3Qg
cmVnbWFwICpjb25maWdfcmVncywNCj4gPiA+ID4gPiAgCX0gZWxzZSBpZiAoY3VyID09IEREUF9D
T01QT05FTlRfQkxTICYmIG5leHQgPT0gRERQX0NPTVBPTkVOVF9EUEkwKSB7DQo+ID4gPiA+ID4g
IAkJcmVnbWFwX3dyaXRlKGNvbmZpZ19yZWdzLCBESVNQX1JFR19DT05GSUdfT1VUX1NFTCwNCj4g
PiA+ID4gPiAgCQkJCUJMU19UT19EUElfUkRNQTFfVE9fRFNJKTsNCj4gPiA+ID4gPiAtCQlyZWdt
YXBfd3JpdGUoY29uZmlnX3JlZ3MsIERJU1BfUkVHX0NPTkZJR19EU0lfU0VMLA0KPiA+ID4gPiA+
IC0JCQkJRFNJX1NFTF9JTl9SRE1BKTsNCj4gPiA+ID4gPiAtCQlyZWdtYXBfd3JpdGUoY29uZmln
X3JlZ3MsIERJU1BfUkVHX0NPTkZJR19EUElfU0VMLA0KPiA+ID4gPiA+IC0JCQkJRFBJX1NFTF9J
Tl9CTFMpOw0KPiA+ID4gPiA+ICAJfQ0KPiA+ID4gPiA+ICB9DQo+ID4gPiA+ID4gIA0KPiA+ID4g
PiANCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IA0KPiA+IA0KPiA+IA0KPiANCj4gDQoNCg==

