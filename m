Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D58C3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 06:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA54421835
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 06:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="l9kaxJk2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgABGWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 01:22:50 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:59331 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725788AbgABGWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 01:22:49 -0500
X-UUID: 477864796f16476da9934ebaeabc9f8f-20200102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:Reply-To:From:Subject:Message-ID; bh=9vypeXyGCV1z946FM6RAns12k9X/Zs6/MFy6RvOrBHY=;
        b=l9kaxJk2VGJjN0UlLZVWN5UfWYQJ2Ku7pc+qrxereJ55FADnQ7KvNwJ0X3OrdEuBX6ecl5jxigGzY1VKtAZd2DmVQpNkewA8XIELc6do12ShEiLDNZ3hdI4q/uNtib4I9QWD8l13FxbUxuvbezJ7/DSRE3SQO64W5/xp1iVHRcc=;
X-UUID: 477864796f16476da9934ebaeabc9f8f-20200102
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 715138884; Thu, 02 Jan 2020 14:22:46 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs05n2.mediatek.inc
 (172.21.101.140) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 2 Jan
 2020 14:22:15 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 2 Jan 2020 14:23:09 +0800
Message-ID: <1577946073.15116.8.camel@mhfsdcap03>
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
Date:   Thu, 2 Jan 2020 14:21:13 +0800
In-Reply-To: <1577944949.32066.1.camel@mtksdaap41>
References: <1577937624-14313-1-git-send-email-yongqiang.niu@mediatek.com>
         <1577937624-14313-3-git-send-email-yongqiang.niu@mediatek.com>
         <1577941388.24650.2.camel@mtksdaap41> <1577943579.15116.1.camel@mhfsdcap03>
         <1577944949.32066.1.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTAxLTAyIGF0IDE0OjAyICswODAwLCBDSyBIdSB3cm90ZToNCj4gSGksIFlv
bmdxaWFuZzoNCj4gDQo+IE9uIFRodSwgMjAyMC0wMS0wMiBhdCAxMzozOSArMDgwMCwgWW9uZ3Fp
YW5nIE5pdSB3cm90ZToNCj4gPiBPbiBUaHUsIDIwMjAtMDEtMDIgYXQgMTM6MDMgKzA4MDAsIENL
IEh1IHdyb3RlOg0KPiA+ID4gSGksIFlvbmdxaWFuZzoNCj4gPiA+IA0KPiA+ID4gT24gVGh1LCAy
MDIwLTAxLTAyIGF0IDEyOjAwICswODAwLCBZb25ncWlhbmcgTml1IHdyb3RlOg0KPiA+ID4gPiBt
b3ZlIGRzaS9kcGkgc2VsZWN0IGlucHV0IGludG8gbXRrX2RkcF9zZWxfaW4NCj4gPiA+ID4gDQo+
ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFlvbmdxaWFuZyBOaXUgPHlvbmdxaWFuZy5uaXVAbWVkaWF0
ZWsuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHJtX2RkcC5jIHwgMTAgKysrKysrLS0tLQ0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDYg
aW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHAuYyBiL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcC5jDQo+ID4gPiA+IGluZGV4IDM5NzAwYjkuLjkxYzli
MTkgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJt
X2RkcC5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rk
cC5jDQo+ID4gPiA+IEBAIC0zNzYsNiArMzc2LDEyIEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgbXRr
X2RkcF9zZWxfaW4oZW51bSBtdGtfZGRwX2NvbXBfaWQgY3VyLA0KPiA+ID4gPiAgCX0gZWxzZSBp
ZiAoY3VyID09IEREUF9DT01QT05FTlRfQkxTICYmIG5leHQgPT0gRERQX0NPTVBPTkVOVF9EU0kw
KSB7DQo+ID4gPiA+ICAJCSphZGRyID0gRElTUF9SRUdfQ09ORklHX0RTSV9TRUw7DQo+ID4gPiA+
ICAJCXZhbHVlID0gRFNJX1NFTF9JTl9CTFM7DQo+ID4gPiA+ICsJfSBlbHNlIGlmIChjdXIgPT0g
RERQX0NPTVBPTkVOVF9SRE1BMSAmJiBuZXh0ID09IEREUF9DT01QT05FTlRfRFNJMCkgew0KPiA+
ID4gPiArCQkqYWRkciA9IERJU1BfUkVHX0NPTkZJR19EU0lfU0VMOw0KPiA+ID4gPiArCQl2YWx1
ZSA9IERTSV9TRUxfSU5fUkRNQTsNCj4gPiA+IA0KPiA+ID4gSW4gb3JpZ2luYWwgY29kZSwgdGhp
cyBpcyBzZXQgd2hlbiBjdXIgPT0gRERQX0NPTVBPTkVOVF9CTFMgYW5kIG5leHQgPT0NCj4gPiA+
IEREUF9DT01QT05FTlRfRFBJMC4gV2h5IGRvIHlvdSBjaGFuZ2UgdGhlIGNvbmRpdGlvbj8NCj4g
PiA+IA0KPiA+ID4gUmVnYXJkcywNCj4gPiA+IENLDQo+ID4gDQo+ID4gaWYgYmxzIGNvbm5lY3Qg
d2l0aCBkcGkwLCByZG1hMSBzaG91bGQgY29ubmVjdCB3aXRoIGRzaTAsIHRoZSBjb25kaXRpb24N
Cj4gPiBpcyBzYW1lIHdpdGggYmVmb3JlLg0KPiANCj4gWW91IHN1Z2dlc3QgdGhhdCB0d28gY3J0
Y3MgYXJlIGJvdGggZW5hYmxlZC4gSWYgb25seSBvbmUgY3J0YyBpcw0KPiBlbmFibGVkLCBqdXN0
IG9uZSBvZiB0aGVzZSB0d28gd291bGQgYmUgc2V0Lg0KPiANCj4gUmVnYXJkcywNCj4gQ0sNCg0K
T0ssIGkgd2lsbCBtb2RpZnkgbGlrZSB0aGlzDQplbHNlIGlmIChjdXIgPT0gRERQX0NPTVBPTkVO
VF9CTFMgJiYgbmV4dCA9PSBERFBfQ09NUE9ORU5UX0RQSTApIHsNCgkJKmFkZHIgPSBESVNQX1JF
R19DT05GSUdfRFNJX1NFTDsNCgkJdmFsdWUgPSBEUElfU0VMX0lOX1JETUE7DQoJfQ0KaW4gbXRr
X2RkcF9zZWxfaW4uDQoNCmRvbid0IHNldCBESVNQX1JFR19DT05GSUdfRFBJX1NFTCB0byBEUElf
U0VMX0lOX0JMUyBhbnltb3JlLCBiZWNhdXNlDQpEUElfU0VMX0lOX0JMUyBpcyB6ZXJvLCBpdCBp
cyBzYW1lIHdpdGggaGFyZHdhcmUgZGVmYXVsdCBzZXR0aW5nLg0KPiANCj4gPiA+IA0KPiA+ID4g
PiArCX0gZWxzZSBpZiAoY3VyID09IEREUF9DT01QT05FTlRfQkxTICYmIG5leHQgPT0gRERQX0NP
TVBPTkVOVF9EUEkwKSB7DQo+ID4gPiA+ICsJCSphZGRyID0gRElTUF9SRUdfQ09ORklHX0RQSV9T
RUw7DQo+ID4gPiA+ICsJCXZhbHVlID0gRFBJX1NFTF9JTl9CTFM7DQo+ID4gPiA+ICAJfSBlbHNl
IHsNCj4gPiA+ID4gIAkJdmFsdWUgPSAwOw0KPiA+ID4gPiAgCX0NCj4gPiA+ID4gQEAgLTM5Mywx
MCArMzk5LDYgQEAgc3RhdGljIHZvaWQgbXRrX2RkcF9zb3V0X3NlbChzdHJ1Y3QgcmVnbWFwICpj
b25maWdfcmVncywNCj4gPiA+ID4gIAl9IGVsc2UgaWYgKGN1ciA9PSBERFBfQ09NUE9ORU5UX0JM
UyAmJiBuZXh0ID09IEREUF9DT01QT05FTlRfRFBJMCkgew0KPiA+ID4gPiAgCQlyZWdtYXBfd3Jp
dGUoY29uZmlnX3JlZ3MsIERJU1BfUkVHX0NPTkZJR19PVVRfU0VMLA0KPiA+ID4gPiAgCQkJCUJM
U19UT19EUElfUkRNQTFfVE9fRFNJKTsNCj4gPiA+ID4gLQkJcmVnbWFwX3dyaXRlKGNvbmZpZ19y
ZWdzLCBESVNQX1JFR19DT05GSUdfRFNJX1NFTCwNCj4gPiA+ID4gLQkJCQlEU0lfU0VMX0lOX1JE
TUEpOw0KPiA+ID4gPiAtCQlyZWdtYXBfd3JpdGUoY29uZmlnX3JlZ3MsIERJU1BfUkVHX0NPTkZJ
R19EUElfU0VMLA0KPiA+ID4gPiAtCQkJCURQSV9TRUxfSU5fQkxTKTsNCj4gPiA+ID4gIAl9DQo+
ID4gPiA+ICB9DQo+ID4gPiA+ICANCj4gPiA+IA0KPiA+ID4gDQo+ID4gDQo+ID4gDQo+IA0KPiAN
Cg0K

