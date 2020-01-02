Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC34CC2D0DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 05:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DE8215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 05:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gUb1sMn7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgABFUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 00:20:50 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:25182 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725837AbgABFUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 00:20:50 -0500
X-UUID: 3dd4fa7883af4e82ba5e339fd024637f-20200102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=DQRcORIL+y+2fbFtjCrmMv7xI1mVBRbKuBSAG37pM1Y=;
        b=gUb1sMn7gQ+j225mIw/ITYAHS89tZrVNqK4ac2jCSXJSdP70i84SFL8CZa2iNS2yaj2EYbeLvxq8SKhHbUeH7I5EMB6SAA88E5bsN9NlrNFD68XLmVVGpbADKP12qpODbcl/nH7xUxJAIG1X3pgIl1xc/dS9xMqppGg+77u/g7E=;
X-UUID: 3dd4fa7883af4e82ba5e339fd024637f-20200102
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1601091587; Thu, 02 Jan 2020 13:20:41 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 2 Jan 2020 13:20:11 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 2 Jan 2020 13:20:44 +0800
Message-ID: <1577942440.24650.5.camel@mtksdaap41>
Subject: Re: [PATCH v6, 13/14] drm/mediatek: add fifo_size into rdma private
 data
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
Date:   Thu, 2 Jan 2020 13:20:40 +0800
In-Reply-To: <1577937624-14313-14-git-send-email-yongqiang.niu@mediatek.com>
References: <1577937624-14313-1-git-send-email-yongqiang.niu@mediatek.com>
         <1577937624-14313-14-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 3B5184720FA311207A262842885CAD4A65345CC110507E138B456F27E95088672000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFlvbmdxaWFuZzoNCg0KT24gVGh1LCAyMDIwLTAxLTAyIGF0IDEyOjAwICswODAwLCBZb25n
cWlhbmcgTml1IHdyb3RlOg0KPiB0aGUgZmlmbyBzaXplIG9mIHJkbWEgaW4gbXQ4MTgzIGlzIGRp
ZmZlcmVudC4NCj4gcmRtYTAgZmlmbyBzaXplIGlzIDVrDQo+IHJkbWExIGZpZm8gc2l6ZSBpcyAy
aw0KPiANCj4gU2lnbmVkLW9mZi1ieTogWW9uZ3FpYW5nIE5pdSA8eW9uZ3FpYW5nLm5pdUBtZWRp
YXRlay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX3Jk
bWEuYyB8IDIxICsrKysrKysrKysrKysrKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIwIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfcmRtYS5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kaXNwX3JkbWEuYw0KPiBpbmRleCA0MDVhZmVmLi42OTE0ODBiIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfcmRtYS5jDQo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9yZG1hLmMNCj4gQEAgLTYyLDYgKzYyLDcgQEAg
c3RydWN0IG10a19kaXNwX3JkbWEgew0KPiAgCXN0cnVjdCBtdGtfZGRwX2NvbXAJCWRkcF9jb21w
Ow0KPiAgCXN0cnVjdCBkcm1fY3J0YwkJCSpjcnRjOw0KPiAgCWNvbnN0IHN0cnVjdCBtdGtfZGlz
cF9yZG1hX2RhdGEJKmRhdGE7DQo+ICsJdTMyCQkJCWZpZm9fc2l6ZTsNCj4gIH07DQo+ICANCj4g
IHN0YXRpYyBpbmxpbmUgc3RydWN0IG10a19kaXNwX3JkbWEgKmNvbXBfdG9fcmRtYShzdHJ1Y3Qg
bXRrX2RkcF9jb21wICpjb21wKQ0KPiBAQCAtMTMwLDEwICsxMzEsMTYgQEAgc3RhdGljIHZvaWQg
bXRrX3JkbWFfY29uZmlnKHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXAsIHVuc2lnbmVkIGludCB3
aWR0aCwNCj4gIAl1bnNpZ25lZCBpbnQgdGhyZXNob2xkOw0KPiAgCXVuc2lnbmVkIGludCByZWc7
DQo+ICAJc3RydWN0IG10a19kaXNwX3JkbWEgKnJkbWEgPSBjb21wX3RvX3JkbWEoY29tcCk7DQo+
ICsJdTMyIHJkbWFfZmlmb19zaXplOw0KPiAgDQo+ICAJcmRtYV91cGRhdGVfYml0cyhjb21wLCBE
SVNQX1JFR19SRE1BX1NJWkVfQ09OXzAsIDB4ZmZmLCB3aWR0aCk7DQo+ICAJcmRtYV91cGRhdGVf
Yml0cyhjb21wLCBESVNQX1JFR19SRE1BX1NJWkVfQ09OXzEsIDB4ZmZmZmYsIGhlaWdodCk7DQo+
ICANCj4gKwlpZiAocmRtYS0+Zmlmb19zaXplKQ0KPiArCQlyZG1hX2ZpZm9fc2l6ZSA9IHJkbWEt
PmZpZm9fc2l6ZTsNCj4gKwllbHNlDQo+ICsJCXJkbWFfZmlmb19zaXplID0gUkRNQV9GSUZPX1NJ
WkUocmRtYSk7DQo+ICsNCj4gIAkvKg0KPiAgCSAqIEVuYWJsZSBGSUZPIHVuZGVyZmxvdyBzaW5j
ZSBEU0kgYW5kIERQSSBjYW4ndCBiZSBibG9ja2VkLg0KPiAgCSAqIEtlZXAgdGhlIEZJRk8gcHNl
dWRvIHNpemUgcmVzZXQgZGVmYXVsdCBvZiA4IEtpQi4gU2V0IHRoZQ0KPiBAQCAtMTQyLDcgKzE0
OSw3IEBAIHN0YXRpYyB2b2lkIG10a19yZG1hX2NvbmZpZyhzdHJ1Y3QgbXRrX2RkcF9jb21wICpj
b21wLCB1bnNpZ25lZCBpbnQgd2lkdGgsDQo+ICAJICovDQo+ICAJdGhyZXNob2xkID0gd2lkdGgg
KiBoZWlnaHQgKiB2cmVmcmVzaCAqIDQgKiA3IC8gMTAwMDAwMDsNCj4gIAlyZWcgPSBSRE1BX0ZJ
Rk9fVU5ERVJGTE9XX0VOIHwNCj4gLQkgICAgICBSRE1BX0ZJRk9fUFNFVURPX1NJWkUoUkRNQV9G
SUZPX1NJWkUocmRtYSkpIHwNCj4gKwkgICAgICBSRE1BX0ZJRk9fUFNFVURPX1NJWkUocmRtYV9m
aWZvX3NpemUpIHwNCj4gIAkgICAgICBSRE1BX09VVFBVVF9WQUxJRF9GSUZPX1RIUkVTSE9MRCh0
aHJlc2hvbGQpOw0KPiAgCXdyaXRlbChyZWcsIGNvbXAtPnJlZ3MgKyBESVNQX1JFR19SRE1BX0ZJ
Rk9fQ09OKTsNCj4gIH0NCj4gQEAgLTI4NCw2ICsyOTEsMTggQEAgc3RhdGljIGludCBtdGtfZGlz
cF9yZG1hX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJCXJldHVybiBj
b21wX2lkOw0KPiAgCX0NCj4gIA0KPiArCWlmIChvZl9maW5kX3Byb3BlcnR5KGRldi0+b2Zfbm9k
ZSwgIm1lZGlhdGVrLHJkbWFfZmlmb19zaXplIiwgJnJldCkpIHsNCg0KIm1lZGlhdGVrLHJkbWFf
Zmlmb19zaXplIiBkb2VzIG5vdCBleGlzdHMgaW4gYmluZGluZyBkb2N1bWVudC4NCg0KPiArCQly
ZXQgPSBvZl9wcm9wZXJ0eV9yZWFkX3UzMihkZXYtPm9mX25vZGUsDQo+ICsJCQkJCSAgICJtZWRp
YXRlayxyZG1hX2ZpZm9fc2l6ZSIsDQo+ICsJCQkJCSAgICZwcml2LT5maWZvX3NpemUpOw0KPiAr
CQlpZiAocmV0KSB7DQo+ICsJCQlkZXZfZXJyKGRldiwgIkZhaWxlZCB0byBnZXQgcmRtYSBmaWZv
IHNpemVcbiIpOw0KPiArCQkJcmV0dXJuIHJldDsNCj4gKwkJfQ0KPiArDQo+ICsJCXByaXYtPmZp
Zm9fc2l6ZSAqPSBTWl8xSzsNCg0KV2h5IG5vdCBkZWZpbmUgZmlmb19zaXplIGluICdieXRlcycg
Pw0KDQpSZWdhcmRzLA0KQ0sNCg0KPiArCX0NCj4gKw0KPiAgCXJldCA9IG10a19kZHBfY29tcF9p
bml0KGRldiwgZGV2LT5vZl9ub2RlLCAmcHJpdi0+ZGRwX2NvbXAsIGNvbXBfaWQsDQo+ICAJCQkJ
Jm10a19kaXNwX3JkbWFfZnVuY3MpOw0KPiAgCWlmIChyZXQpIHsNCg0K

