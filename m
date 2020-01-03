Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A774C3276F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1224D22314
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="l8OwAzzZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgACDNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 22:13:39 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:51303 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727404AbgACDMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 22:12:47 -0500
X-UUID: 7b3c5b98949e4d2084d774c8b415f5b0-20200103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=zLLZC00K/D+nIAyTwOOL8PcRQJSTuzpvNAs2qK6gIqU=;
        b=l8OwAzzZO/MOr9qfK9bEzzmoDZCywzj4mEJErj8o7Liu+Xf7rMRcLzmFcOyzWp0ypY0LWJ7bDs5hXjGVWOS9tZz4Dw/Skwh2K5RC+JcForXu3EA/k8PM/yhEjPuWPhRmn0Lv9q5jQYl80fmEFozLOZ7glhV7wtCu6i9+/pLkWg4=;
X-UUID: 7b3c5b98949e4d2084d774c8b415f5b0-20200103
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 58300790; Fri, 03 Jan 2020 11:12:40 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 3 Jan 2020 11:12:08 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 3 Jan 2020 11:13:06 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [RESEND PATCH v6 03/17] drm/mediatek: move dsi/dpi select input into mtk_ddp_sel_in
Date:   Fri, 3 Jan 2020 11:12:14 +0800
Message-ID: <1578021148-32413-4-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1578021148-32413-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1578021148-32413-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bW92ZSBkc2kvZHBpIHNlbGVjdCBpbnB1dCBpbnRvIG10a19kZHBfc2VsX2luDQpEUElfU0VMX0lO
X0JMUyBpcyB6ZXJvLCBpdCBpcyBzYW1lIHdpdGggaGFyZHdhcmUgZGVmYXVsdCBzZXR0aW5nLA0K
RElTUF9SRUdfQ09ORklHX0RQSV9TRUwgbm8gbmVlZCBzZXQgd2hlbiBibHMgY29ubmVjdCB3aXRo
DQpkcGkwDQoNClNpZ25lZC1vZmYtYnk6IFlvbmdxaWFuZyBOaXUgPHlvbmdxaWFuZy5uaXVAbWVk
aWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwLmMg
fCA3ICsrKy0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9u
cygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRw
LmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHAuYw0KaW5kZXggMzk3MDBi
OS4uZDY2Y2UzMSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJt
X2RkcC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHAuYw0KQEAg
LTM3Niw2ICszNzYsOSBAQCBzdGF0aWMgdW5zaWduZWQgaW50IG10a19kZHBfc2VsX2luKGVudW0g
bXRrX2RkcF9jb21wX2lkIGN1ciwNCiAJfSBlbHNlIGlmIChjdXIgPT0gRERQX0NPTVBPTkVOVF9C
TFMgJiYgbmV4dCA9PSBERFBfQ09NUE9ORU5UX0RTSTApIHsNCiAJCSphZGRyID0gRElTUF9SRUdf
Q09ORklHX0RTSV9TRUw7DQogCQl2YWx1ZSA9IERTSV9TRUxfSU5fQkxTOw0KKwl9IGVsc2UgaWYg
KGN1ciA9PSBERFBfQ09NUE9ORU5UX0JMUyAmJiBuZXh0ID09IEREUF9DT01QT05FTlRfRFBJMCkg
ew0KKwkJKmFkZHIgPSBESVNQX1JFR19DT05GSUdfRFNJX1NFTDsNCisJCXZhbHVlID0gRFNJX1NF
TF9JTl9SRE1BOw0KIAl9IGVsc2Ugew0KIAkJdmFsdWUgPSAwOw0KIAl9DQpAQCAtMzkzLDEwICsz
OTYsNiBAQCBzdGF0aWMgdm9pZCBtdGtfZGRwX3NvdXRfc2VsKHN0cnVjdCByZWdtYXAgKmNvbmZp
Z19yZWdzLA0KIAl9IGVsc2UgaWYgKGN1ciA9PSBERFBfQ09NUE9ORU5UX0JMUyAmJiBuZXh0ID09
IEREUF9DT01QT05FTlRfRFBJMCkgew0KIAkJcmVnbWFwX3dyaXRlKGNvbmZpZ19yZWdzLCBESVNQ
X1JFR19DT05GSUdfT1VUX1NFTCwNCiAJCQkJQkxTX1RPX0RQSV9SRE1BMV9UT19EU0kpOw0KLQkJ
cmVnbWFwX3dyaXRlKGNvbmZpZ19yZWdzLCBESVNQX1JFR19DT05GSUdfRFNJX1NFTCwNCi0JCQkJ
RFNJX1NFTF9JTl9SRE1BKTsNCi0JCXJlZ21hcF93cml0ZShjb25maWdfcmVncywgRElTUF9SRUdf
Q09ORklHX0RQSV9TRUwsDQotCQkJCURQSV9TRUxfSU5fQkxTKTsNCiAJfQ0KIH0NCiANCi0tIA0K
MS44LjEuMS5kaXJ0eQ0K

