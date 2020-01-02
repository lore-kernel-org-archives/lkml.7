Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D54CC2D0DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 05:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3DCA20848
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 05:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VrgzzEsR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgABFDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 00:03:23 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:1511 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725788AbgABFDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 00:03:23 -0500
X-UUID: 85a4205535a8485fa0f63cd14d3ab35f-20200102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=B9oImeZ40IpDKQMsA5+OevUOG/21QHxukfJzn2BEkvI=;
        b=VrgzzEsR2xl8GEGgdAkOcQ3gEXP1Z/QNx0BMgrR0TGXAbYuf0OcLtP+cr3vhKVlrOKsGyNrCtEmKpKLkONBweRF2J6CP6GUhTcP8DIR/LPlV7reqIEj2rYUZbWZeHLDroEaM5CVdQHnPGibwrGyaiNAVePw4OhhjgQhVV7kSY5k=;
X-UUID: 85a4205535a8485fa0f63cd14d3ab35f-20200102
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2111093749; Thu, 02 Jan 2020 13:03:11 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 2 Jan 2020 13:02:02 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 2 Jan 2020 13:02:28 +0800
Message-ID: <1577941388.24650.2.camel@mtksdaap41>
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
Date:   Thu, 2 Jan 2020 13:03:08 +0800
In-Reply-To: <1577937624-14313-3-git-send-email-yongqiang.niu@mediatek.com>
References: <1577937624-14313-1-git-send-email-yongqiang.niu@mediatek.com>
         <1577937624-14313-3-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: C9B08F994A7286C74E48B5B525F960C34C42DFAE9C3B659B0BFDC3F25B28B5952000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFlvbmdxaWFuZzoNCg0KT24gVGh1LCAyMDIwLTAxLTAyIGF0IDEyOjAwICswODAwLCBZb25n
cWlhbmcgTml1IHdyb3RlOg0KPiBtb3ZlIGRzaS9kcGkgc2VsZWN0IGlucHV0IGludG8gbXRrX2Rk
cF9zZWxfaW4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFlvbmdxaWFuZyBOaXUgPHlvbmdxaWFuZy5u
aXVAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2RkcC5jIHwgMTAgKysrKysrLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RybV9kZHAuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJt
X2RkcC5jDQo+IGluZGV4IDM5NzAwYjkuLjkxYzliMTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHJtX2RkcC5jDQo+IEBAIC0zNzYsNiArMzc2LDEyIEBAIHN0YXRpYyB1bnNp
Z25lZCBpbnQgbXRrX2RkcF9zZWxfaW4oZW51bSBtdGtfZGRwX2NvbXBfaWQgY3VyLA0KPiAgCX0g
ZWxzZSBpZiAoY3VyID09IEREUF9DT01QT05FTlRfQkxTICYmIG5leHQgPT0gRERQX0NPTVBPTkVO
VF9EU0kwKSB7DQo+ICAJCSphZGRyID0gRElTUF9SRUdfQ09ORklHX0RTSV9TRUw7DQo+ICAJCXZh
bHVlID0gRFNJX1NFTF9JTl9CTFM7DQo+ICsJfSBlbHNlIGlmIChjdXIgPT0gRERQX0NPTVBPTkVO
VF9SRE1BMSAmJiBuZXh0ID09IEREUF9DT01QT05FTlRfRFNJMCkgew0KPiArCQkqYWRkciA9IERJ
U1BfUkVHX0NPTkZJR19EU0lfU0VMOw0KPiArCQl2YWx1ZSA9IERTSV9TRUxfSU5fUkRNQTsNCg0K
SW4gb3JpZ2luYWwgY29kZSwgdGhpcyBpcyBzZXQgd2hlbiBjdXIgPT0gRERQX0NPTVBPTkVOVF9C
TFMgYW5kIG5leHQgPT0NCkREUF9DT01QT05FTlRfRFBJMC4gV2h5IGRvIHlvdSBjaGFuZ2UgdGhl
IGNvbmRpdGlvbj8NCg0KUmVnYXJkcywNCkNLDQoNCj4gKwl9IGVsc2UgaWYgKGN1ciA9PSBERFBf
Q09NUE9ORU5UX0JMUyAmJiBuZXh0ID09IEREUF9DT01QT05FTlRfRFBJMCkgew0KPiArCQkqYWRk
ciA9IERJU1BfUkVHX0NPTkZJR19EUElfU0VMOw0KPiArCQl2YWx1ZSA9IERQSV9TRUxfSU5fQkxT
Ow0KPiAgCX0gZWxzZSB7DQo+ICAJCXZhbHVlID0gMDsNCj4gIAl9DQo+IEBAIC0zOTMsMTAgKzM5
OSw2IEBAIHN0YXRpYyB2b2lkIG10a19kZHBfc291dF9zZWwoc3RydWN0IHJlZ21hcCAqY29uZmln
X3JlZ3MsDQo+ICAJfSBlbHNlIGlmIChjdXIgPT0gRERQX0NPTVBPTkVOVF9CTFMgJiYgbmV4dCA9
PSBERFBfQ09NUE9ORU5UX0RQSTApIHsNCj4gIAkJcmVnbWFwX3dyaXRlKGNvbmZpZ19yZWdzLCBE
SVNQX1JFR19DT05GSUdfT1VUX1NFTCwNCj4gIAkJCQlCTFNfVE9fRFBJX1JETUExX1RPX0RTSSk7
DQo+IC0JCXJlZ21hcF93cml0ZShjb25maWdfcmVncywgRElTUF9SRUdfQ09ORklHX0RTSV9TRUws
DQo+IC0JCQkJRFNJX1NFTF9JTl9SRE1BKTsNCj4gLQkJcmVnbWFwX3dyaXRlKGNvbmZpZ19yZWdz
LCBESVNQX1JFR19DT05GSUdfRFBJX1NFTCwNCj4gLQkJCQlEUElfU0VMX0lOX0JMUyk7DQo+ICAJ
fQ0KPiAgfQ0KPiAgDQoNCg==

