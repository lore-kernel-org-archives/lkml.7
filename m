Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4117C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 05:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9178E22314
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 05:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bNmoDG2K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgACFgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 00:36:53 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:37987 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725890AbgACFgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 00:36:53 -0500
X-UUID: 52bd52d058ed4a709500262764d35ca5-20200103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=99ZrQnQ1iPB152bOaNM5TfX+bomBz2uWbjIND87FRX0=;
        b=bNmoDG2KjrRD6lWcKpRTVJg/kt/Yho1u1KWN3Dz5wjOfZ0EIEP7OlCrZAOFcxVdPxHKC1GMPgrbju1gOQNbBLewoFoyun6mtKJETGiXd0LMEZcAyKsjZXPr6VP7k834pxjCVzS3Ft/1Uc5G6+7wo1GZeeGCG37rSrMUUCVSbu+4=;
X-UUID: 52bd52d058ed4a709500262764d35ca5-20200103
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 474371618; Fri, 03 Jan 2020 13:36:37 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 3 Jan 2020 13:36:03 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 3 Jan 2020 13:36:32 +0800
Message-ID: <1578029793.31107.5.camel@mtksdaap41>
Subject: Re: [RESEND PATCH v6 03/17] drm/mediatek: move dsi/dpi select input
 into mtk_ddp_sel_in
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
Date:   Fri, 3 Jan 2020 13:36:33 +0800
In-Reply-To: <1578021148-32413-4-git-send-email-yongqiang.niu@mediatek.com>
References: <1578021148-32413-1-git-send-email-yongqiang.niu@mediatek.com>
         <1578021148-32413-4-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: DCF20F9DAAF3DBA7A01483A62A5004296DD1B8FCF4A251B8896B0FB66EF4AA542000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFlvbmdxaWFuZzoNCg0KT24gRnJpLCAyMDIwLTAxLTAzIGF0IDExOjEyICswODAwLCBZb25n
cWlhbmcgTml1IHdyb3RlOg0KPiBtb3ZlIGRzaS9kcGkgc2VsZWN0IGlucHV0IGludG8gbXRrX2Rk
cF9zZWxfaW4NCj4gRFBJX1NFTF9JTl9CTFMgaXMgemVybywgaXQgaXMgc2FtZSB3aXRoIGhhcmR3
YXJlIGRlZmF1bHQgc2V0dGluZywNCj4gRElTUF9SRUdfQ09ORklHX0RQSV9TRUwgbm8gbmVlZCBz
ZXQgd2hlbiBibHMgY29ubmVjdCB3aXRoDQo+IGRwaTANCg0KSSB0aGluayB5b3UgaGF2ZSBkb25l
IHR3byB0aGluZ3MgaW4gdGhpcyBwYXRjaC4gT25lIGlzIHJlbW92ZQ0KRElTUF9SRUdfQ09ORklH
X0RQSV9TRUwgc2V0dGluZywgYW5kIHRoZSBvdGhlciBpcyBtb3ZlDQpESVNQX1JFR19DT05GSUdf
RFNJX1NFTCBmcm9tIG10a19kZHBfc291dF9zZWwoKSB0byBtdGtfZGRwX3NlbF9pbigpLiBTbw0K
c2VwYXJhdGUgdGhpcyBpbnRvIHR3byBwYXRjaGVzLg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogWW9uZ3FpYW5nIE5pdSA8eW9uZ3FpYW5nLm5pdUBtZWRpYXRlay5jb20+
DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwLmMgfCA3ICsr
Ky0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRw
LmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHAuYw0KPiBpbmRleCAzOTcw
MGI5Li5kNjZjZTMxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RybV9kZHAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHAu
Yw0KPiBAQCAtMzc2LDYgKzM3Niw5IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgbXRrX2RkcF9zZWxf
aW4oZW51bSBtdGtfZGRwX2NvbXBfaWQgY3VyLA0KPiAgCX0gZWxzZSBpZiAoY3VyID09IEREUF9D
T01QT05FTlRfQkxTICYmIG5leHQgPT0gRERQX0NPTVBPTkVOVF9EU0kwKSB7DQo+ICAJCSphZGRy
ID0gRElTUF9SRUdfQ09ORklHX0RTSV9TRUw7DQo+ICAJCXZhbHVlID0gRFNJX1NFTF9JTl9CTFM7
DQo+ICsJfSBlbHNlIGlmIChjdXIgPT0gRERQX0NPTVBPTkVOVF9CTFMgJiYgbmV4dCA9PSBERFBf
Q09NUE9ORU5UX0RQSTApIHsNCj4gKwkJKmFkZHIgPSBESVNQX1JFR19DT05GSUdfRFNJX1NFTDsN
Cj4gKwkJdmFsdWUgPSBEU0lfU0VMX0lOX1JETUE7DQo+ICAJfSBlbHNlIHsNCj4gIAkJdmFsdWUg
PSAwOw0KPiAgCX0NCj4gQEAgLTM5MywxMCArMzk2LDYgQEAgc3RhdGljIHZvaWQgbXRrX2RkcF9z
b3V0X3NlbChzdHJ1Y3QgcmVnbWFwICpjb25maWdfcmVncywNCj4gIAl9IGVsc2UgaWYgKGN1ciA9
PSBERFBfQ09NUE9ORU5UX0JMUyAmJiBuZXh0ID09IEREUF9DT01QT05FTlRfRFBJMCkgew0KPiAg
CQlyZWdtYXBfd3JpdGUoY29uZmlnX3JlZ3MsIERJU1BfUkVHX0NPTkZJR19PVVRfU0VMLA0KPiAg
CQkJCUJMU19UT19EUElfUkRNQTFfVE9fRFNJKTsNCj4gLQkJcmVnbWFwX3dyaXRlKGNvbmZpZ19y
ZWdzLCBESVNQX1JFR19DT05GSUdfRFNJX1NFTCwNCj4gLQkJCQlEU0lfU0VMX0lOX1JETUEpOw0K
PiAtCQlyZWdtYXBfd3JpdGUoY29uZmlnX3JlZ3MsIERJU1BfUkVHX0NPTkZJR19EUElfU0VMLA0K
PiAtCQkJCURQSV9TRUxfSU5fQkxTKTsNCj4gIAl9DQo+ICB9DQo+ICANCg0K

