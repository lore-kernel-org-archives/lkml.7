Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF914C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF6120878
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Nbi7PHGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfKUByk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 20:54:40 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:11922 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726293AbfKUByU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 20:54:20 -0500
X-UUID: b6a39ab60daf4169a738125c289d3738-20191121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=9C42Vx05VdO04QxiofJ2GEOv6CpVo7b4QPAbTBdhpLo=;
        b=Nbi7PHGzTIKd/k/HTDCS4TVY8xW0tFpRcOvLNVyrb5TgrGFJJDjVWCVD5Fdp4WQOPTWFJvmAKlM6sz8lS7gXq5GkKMlnbAeX1b40qCMEDxkS+2m0PFRl/0Q7HHob7yUrnnWalZeHGDJjQoWvLnnB8gfJmJZwPhiKcAzhtk4iFiI=;
X-UUID: b6a39ab60daf4169a738125c289d3738-20191121
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 51600419; Thu, 21 Nov 2019 09:54:13 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 21 Nov 2019 09:54:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Nov 2019 09:54:16 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, CK HU <ck.hu@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: [PATCH v17 1/6] soc: mediatek: cmdq: fixup wrong input order of write api
Date:   Thu, 21 Nov 2019 09:54:05 +0800
Message-ID: <20191121015410.18852-2-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191121015410.18852-1-bibby.hsieh@mediatek.com>
References: <20191121015410.18852-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4dXAgYSBpc3N1ZSB3YXMgY2F1c2VkIGJ5IHRoZSBwcmV2aW91cyBmaXh1cCBwYXRjaC4NCg0K
Rml4ZXM6IDFhOTJmOTg5MTI2ZSAoInNvYzogbWVkaWF0ZWs6IGNtZHE6IHJlb3JkZXIgdGhlIHBh
cmFtZXRlciIpDQoNClNpZ25lZC1vZmYtYnk6IEJpYmJ5IEhzaWVoIDxiaWJieS5oc2llaEBtZWRp
YXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyB8
IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIGIvZHJp
dmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCmluZGV4IDdhYTA1MTdmZjJmMy4u
M2M4MmRlNWY5NDE3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEt
aGVscGVyLmMNCisrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQpA
QCAtMTU1LDcgKzE1NSw3IEBAIGludCBjbWRxX3BrdF93cml0ZV9tYXNrKHN0cnVjdCBjbWRxX3Br
dCAqcGt0LCB1OCBzdWJzeXMsDQogCQllcnIgPSBjbWRxX3BrdF9hcHBlbmRfY29tbWFuZChwa3Qs
IENNRFFfQ09ERV9NQVNLLCAwLCB+bWFzayk7DQogCQlvZmZzZXRfbWFzayB8PSBDTURRX1dSSVRF
X0VOQUJMRV9NQVNLOw0KIAl9DQotCWVyciB8PSBjbWRxX3BrdF93cml0ZShwa3QsIHZhbHVlLCBz
dWJzeXMsIG9mZnNldF9tYXNrKTsNCisJZXJyIHw9IGNtZHFfcGt0X3dyaXRlKHBrdCwgc3Vic3lz
LCBvZmZzZXRfbWFzaywgdmFsdWUpOw0KIA0KIAlyZXR1cm4gZXJyOw0KIH0NCi0tIA0KMi4xOC4w
DQo=

