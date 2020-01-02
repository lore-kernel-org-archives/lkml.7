Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC94C3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 05:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C436921655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 05:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OQRpVxnk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgABFlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 00:41:19 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:52191 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725788AbgABFlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 00:41:18 -0500
X-UUID: df0ec7433a0c45419b6ba66a6c6ba05f-20200102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:Reply-To:From:Subject:Message-ID; bh=grGSLMHsu/cpV4RBGH89GKd36Lx7zKXB7OI8Y/1330c=;
        b=OQRpVxnk/C5Ai/83w4xNFWYSHXlSTEeEPHd/+vsYOWr3EopWB948ENM+GfZX02Xn5oGSzjXCUmhwZr13FB3gE9H8betxxqCuApda76lbKT8GBqxtlxwDVs8t4GX67JzuPgg6MU2yygCliYLdLtCAwxfGc86kx4XiNARmDnXkdLI=;
X-UUID: df0ec7433a0c45419b6ba66a6c6ba05f-20200102
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 509224428; Thu, 02 Jan 2020 13:41:12 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs05n1.mediatek.inc
 (172.21.101.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 2 Jan
 2020 13:40:45 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 2 Jan 2020 13:41:35 +0800
Message-ID: <1577943579.15116.1.camel@mhfsdcap03>
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
Date:   Thu, 2 Jan 2020 13:39:39 +0800
In-Reply-To: <1577941388.24650.2.camel@mtksdaap41>
References: <1577937624-14313-1-git-send-email-yongqiang.niu@mediatek.com>
         <1577937624-14313-3-git-send-email-yongqiang.niu@mediatek.com>
         <1577941388.24650.2.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTAxLTAyIGF0IDEzOjAzICswODAwLCBDSyBIdSB3cm90ZToNCj4gSGksIFlv
bmdxaWFuZzoNCj4gDQo+IE9uIFRodSwgMjAyMC0wMS0wMiBhdCAxMjowMCArMDgwMCwgWW9uZ3Fp
YW5nIE5pdSB3cm90ZToNCj4gPiBtb3ZlIGRzaS9kcGkgc2VsZWN0IGlucHV0IGludG8gbXRrX2Rk
cF9zZWxfaW4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBZb25ncWlhbmcgTml1IDx5b25ncWlh
bmcubml1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fZGRwLmMgfCAxMCArKysrKystLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcC5jIGIvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fZGRwLmMNCj4gPiBpbmRleCAzOTcwMGI5Li45MWM5YjE5IDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcC5jDQo+ID4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwLmMNCj4gPiBAQCAtMzc2LDYg
KzM3NiwxMiBAQCBzdGF0aWMgdW5zaWduZWQgaW50IG10a19kZHBfc2VsX2luKGVudW0gbXRrX2Rk
cF9jb21wX2lkIGN1ciwNCj4gPiAgCX0gZWxzZSBpZiAoY3VyID09IEREUF9DT01QT05FTlRfQkxT
ICYmIG5leHQgPT0gRERQX0NPTVBPTkVOVF9EU0kwKSB7DQo+ID4gIAkJKmFkZHIgPSBESVNQX1JF
R19DT05GSUdfRFNJX1NFTDsNCj4gPiAgCQl2YWx1ZSA9IERTSV9TRUxfSU5fQkxTOw0KPiA+ICsJ
fSBlbHNlIGlmIChjdXIgPT0gRERQX0NPTVBPTkVOVF9SRE1BMSAmJiBuZXh0ID09IEREUF9DT01Q
T05FTlRfRFNJMCkgew0KPiA+ICsJCSphZGRyID0gRElTUF9SRUdfQ09ORklHX0RTSV9TRUw7DQo+
ID4gKwkJdmFsdWUgPSBEU0lfU0VMX0lOX1JETUE7DQo+IA0KPiBJbiBvcmlnaW5hbCBjb2RlLCB0
aGlzIGlzIHNldCB3aGVuIGN1ciA9PSBERFBfQ09NUE9ORU5UX0JMUyBhbmQgbmV4dCA9PQ0KPiBE
RFBfQ09NUE9ORU5UX0RQSTAuIFdoeSBkbyB5b3UgY2hhbmdlIHRoZSBjb25kaXRpb24/DQo+IA0K
PiBSZWdhcmRzLA0KPiBDSw0KDQppZiBibHMgY29ubmVjdCB3aXRoIGRwaTAsIHJkbWExIHNob3Vs
ZCBjb25uZWN0IHdpdGggZHNpMCwgdGhlIGNvbmRpdGlvbg0KaXMgc2FtZSB3aXRoIGJlZm9yZS4N
Cj4gDQo+ID4gKwl9IGVsc2UgaWYgKGN1ciA9PSBERFBfQ09NUE9ORU5UX0JMUyAmJiBuZXh0ID09
IEREUF9DT01QT05FTlRfRFBJMCkgew0KPiA+ICsJCSphZGRyID0gRElTUF9SRUdfQ09ORklHX0RQ
SV9TRUw7DQo+ID4gKwkJdmFsdWUgPSBEUElfU0VMX0lOX0JMUzsNCj4gPiAgCX0gZWxzZSB7DQo+
ID4gIAkJdmFsdWUgPSAwOw0KPiA+ICAJfQ0KPiA+IEBAIC0zOTMsMTAgKzM5OSw2IEBAIHN0YXRp
YyB2b2lkIG10a19kZHBfc291dF9zZWwoc3RydWN0IHJlZ21hcCAqY29uZmlnX3JlZ3MsDQo+ID4g
IAl9IGVsc2UgaWYgKGN1ciA9PSBERFBfQ09NUE9ORU5UX0JMUyAmJiBuZXh0ID09IEREUF9DT01Q
T05FTlRfRFBJMCkgew0KPiA+ICAJCXJlZ21hcF93cml0ZShjb25maWdfcmVncywgRElTUF9SRUdf
Q09ORklHX09VVF9TRUwsDQo+ID4gIAkJCQlCTFNfVE9fRFBJX1JETUExX1RPX0RTSSk7DQo+ID4g
LQkJcmVnbWFwX3dyaXRlKGNvbmZpZ19yZWdzLCBESVNQX1JFR19DT05GSUdfRFNJX1NFTCwNCj4g
PiAtCQkJCURTSV9TRUxfSU5fUkRNQSk7DQo+ID4gLQkJcmVnbWFwX3dyaXRlKGNvbmZpZ19yZWdz
LCBESVNQX1JFR19DT05GSUdfRFBJX1NFTCwNCj4gPiAtCQkJCURQSV9TRUxfSU5fQkxTKTsNCj4g
PiAgCX0NCj4gPiAgfQ0KPiA+ICANCj4gDQo+IA0KDQo=

