Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563FAC32771
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 05:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2508B22314
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 05:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cP8R7jr7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgACFou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 00:44:50 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:36531 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725916AbgACFou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 00:44:50 -0500
X-UUID: dde1e5cc19b14967838bffa1eb3987d4-20200103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=iAyHZ4cFlXp1ARnIl3ujSzsZWrgcDzAuYJCkSJsgRYA=;
        b=cP8R7jr7VH73u3FQ9ai1JIBbBTCRsAflsRV7fV4qCySvLGTsuAzJcs9BxNp15steQrxoP1AL3n5XPWQGqiXeKFJKt+fwo1vqeS2DA3PNwqbPCFSi93PG91AFSXxTqsA4NAarNZeCR9FZTNNhJkL8pXQg8LgYPHfoI8yfgZ/+QA8=;
X-UUID: dde1e5cc19b14967838bffa1eb3987d4-20200103
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1025520777; Fri, 03 Jan 2020 13:44:45 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 3 Jan 2020 13:43:27 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 3 Jan 2020 13:44:38 +0800
Message-ID: <1578030279.31107.6.camel@mtksdaap41>
Subject: Re: [RESEND PATCH v6 04/17] drm/mediatek: make sout select function
 format same with select input
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
Date:   Fri, 3 Jan 2020 13:44:39 +0800
In-Reply-To: <1578021148-32413-5-git-send-email-yongqiang.niu@mediatek.com>
References: <1578021148-32413-1-git-send-email-yongqiang.niu@mediatek.com>
         <1578021148-32413-5-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 1848600F3CEC16E3DFB594BA8C709B4E788EBFB65D29CB182A8A734332A829032000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFlvbmdxaWFuZzoNCg0KT24gRnJpLCAyMDIwLTAxLTAzIGF0IDExOjEyICswODAwLCBZb25n
cWlhbmcgTml1IHdyb3RlOg0KPiB0aGVyZSB3aWxsIGJlIG1vcmUgc291dCBjYXNlIGluIHRoZSBm
dXR1cmUsDQo+IG1ha2UgdGhlIHNvdXQgZnVuY3Rpb24gZm9ybWF0IHNhbWUgbXRrX2RkcF9zZWxf
aW4NCj4gDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IFNp
Z25lZC1vZmYtYnk6IFlvbmdxaWFuZyBOaXUgPHlvbmdxaWFuZy5uaXVAbWVkaWF0ZWsuY29tPg0K
PiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcC5jIHwgMjQgKysr
KysrKysrKysrKysrKy0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygr
KSwgOCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RybV9kZHAuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rk
cC5jDQo+IGluZGV4IGQ2NmNlMzEuLmFlMDhmYzQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHJtX2RkcC5jDQo+IEBAIC0zODYsMTcgKzM4NiwyMyBAQCBzdGF0aWMgdW5zaWdu
ZWQgaW50IG10a19kZHBfc2VsX2luKGVudW0gbXRrX2RkcF9jb21wX2lkIGN1ciwNCj4gIAlyZXR1
cm4gdmFsdWU7DQo+ICB9DQo+ICANCj4gLXN0YXRpYyB2b2lkIG10a19kZHBfc291dF9zZWwoc3Ry
dWN0IHJlZ21hcCAqY29uZmlnX3JlZ3MsDQo+IC0JCQkgICAgIGVudW0gbXRrX2RkcF9jb21wX2lk
IGN1ciwNCj4gLQkJCSAgICAgZW51bSBtdGtfZGRwX2NvbXBfaWQgbmV4dCkNCj4gK3N0YXRpYyB1
bnNpZ25lZCBpbnQgbXRrX2RkcF9zb3V0X3NlbChlbnVtIG10a19kZHBfY29tcF9pZCBjdXIsDQo+
ICsJCQkJICAgICBlbnVtIG10a19kZHBfY29tcF9pZCBuZXh0LA0KPiArCQkJCSAgICAgdW5zaWdu
ZWQgaW50ICphZGRyKQ0KPiAgew0KPiArCXVuc2lnbmVkIGludCB2YWx1ZTsNCj4gKw0KPiAgCWlm
IChjdXIgPT0gRERQX0NPTVBPTkVOVF9CTFMgJiYgbmV4dCA9PSBERFBfQ09NUE9ORU5UX0RTSTAp
IHsNCj4gLQkJcmVnbWFwX3dyaXRlKGNvbmZpZ19yZWdzLCBESVNQX1JFR19DT05GSUdfT1VUX1NF
TCwNCj4gLQkJCQlCTFNfVE9fRFNJX1JETUExX1RPX0RQSTEpOw0KPiArCQkqYWRkciA9IERJU1Bf
UkVHX0NPTkZJR19PVVRfU0VMOw0KPiArCQl2YWx1ZSA9IEJMU19UT19EU0lfUkRNQTFfVE9fRFBJ
MTsNCj4gIAl9IGVsc2UgaWYgKGN1ciA9PSBERFBfQ09NUE9ORU5UX0JMUyAmJiBuZXh0ID09IERE
UF9DT01QT05FTlRfRFBJMCkgew0KPiAtCQlyZWdtYXBfd3JpdGUoY29uZmlnX3JlZ3MsIERJU1Bf
UkVHX0NPTkZJR19PVVRfU0VMLA0KPiAtCQkJCUJMU19UT19EUElfUkRNQTFfVE9fRFNJKTsNCj4g
KwkJKmFkZHIgPSBESVNQX1JFR19DT05GSUdfT1VUX1NFTDsNCj4gKwkJdmFsdWUgPSBCTFNfVE9f
RFBJX1JETUExX1RPX0RTSTsNCj4gKwl9IGVsc2Ugew0KPiArCQl2YWx1ZSA9IDA7DQo+ICAJfQ0K
PiArDQo+ICsJcmV0dXJuIHZhbHVlOw0KPiAgfQ0KPiAgDQo+ICB2b2lkIG10a19kZHBfYWRkX2Nv
bXBfdG9fcGF0aChzdHJ1Y3QgcmVnbWFwICpjb25maWdfcmVncywNCj4gQEAgLTQwOSw3ICs0MTUs
OSBAQCB2b2lkIG10a19kZHBfYWRkX2NvbXBfdG9fcGF0aChzdHJ1Y3QgcmVnbWFwICpjb25maWdf
cmVncywNCj4gIAlpZiAodmFsdWUpDQo+ICAJCXJlZ21hcF91cGRhdGVfYml0cyhjb25maWdfcmVn
cywgYWRkciwgdmFsdWUsIHZhbHVlKTsNCj4gIA0KPiAtCW10a19kZHBfc291dF9zZWwoY29uZmln
X3JlZ3MsIGN1ciwgbmV4dCk7DQo+ICsJdmFsdWUgPSBtdGtfZGRwX3NvdXRfc2VsKGN1ciwgbmV4
dCwgJmFkZHIpOw0KPiArCWlmICh2YWx1ZSkNCj4gKwkJcmVnbWFwX3VwZGF0ZV9iaXRzKGNvbmZp
Z19yZWdzLCBhZGRyLCB2YWx1ZSwgdmFsdWUpOw0KPiAgDQo+ICAJdmFsdWUgPSBtdGtfZGRwX3Nl
bF9pbihjdXIsIG5leHQsICZhZGRyKTsNCj4gIAlpZiAodmFsdWUpDQoNCg==

