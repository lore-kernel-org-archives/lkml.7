Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9650AC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 06:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6371920731
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 06:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GnBW0GXY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfKTGnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 01:43:39 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:38623 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725263AbfKTGni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 01:43:38 -0500
X-UUID: 2e485fbe26bd4f209722b36a74f4b267-20191120
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Po3I97gPH5un+YvUqz4HBd2ziZlvEJRiQYNqrIBg6bI=;
        b=GnBW0GXYrUuKbjd3RTHcMK6R3FbEAwxisI/6RgxDa6zyF8nBDbzC9Mf/3BM7FVVDMqTzuLGcMZ475J3YTcOtxhMG6wVfNnUYqnIoMgyonLxPZ74VgvjdpoliyQA7rt6rSbt8lx6KyYKXYRdBKJD813/jh9qIS36GYAYGqCgIDP0=;
X-UUID: 2e485fbe26bd4f209722b36a74f4b267-20191120
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 164379485; Wed, 20 Nov 2019 14:43:19 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 20 Nov 2019 14:43:20 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 20 Nov 2019 14:42:56 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Cristian Birsan <cristian.birsan@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Bin Liu <b-liu@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [RESEND PATCH v3 1/3] usb: musb: create debugfs directory under usb root
Date:   Wed, 20 Nov 2019 14:43:01 +0800
Message-ID: <1574232183-5760-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 01F70002478959B1D1A85763158DDF05B970B212D28ECF207AC1A07659EF2B4C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tm93IHRoZSBVU0IgZ2FkZ2V0IHN1YnN5c3RlbSBjYW4gdXNlIHRoZSBVU0IgZGVidWdmcyByb290
IGRpcmVjdG9yeSwNCnNvIG1vdmUgbXVzYidzIGRpcmVjdG9yeSBmcm9tIHRoZSByb290IG9mIHRo
ZSBkZWJ1Z2ZzIGZpbGVzeXN0ZW0gaW50bw0KdGhlIHJvb3Qgb2YgdXNiDQoNClNpZ25lZC1vZmYt
Ynk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0KdjM6IG5v
IGNoYW5nZXMNCg0KdjI6DQogIDEuIGFiYW5kb24gbmV3IEFQSSB1c2JfZGVidWdmc19jcmVhdGVf
ZGlyKCksIGFuZCB1c2UgdXNiX2RlYnVnX3Jvb3QNCi0tLQ0KIGRyaXZlcnMvdXNiL211c2IvbXVz
Yl9kZWJ1Z2ZzLmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9tdXNiL211c2JfZGVidWdmcy5j
IGIvZHJpdmVycy91c2IvbXVzYi9tdXNiX2RlYnVnZnMuYw0KaW5kZXggZjQyODU4ZTJiNTRjLi43
YjYyODFhYjYyZWQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9tdXNiL211c2JfZGVidWdmcy5j
DQorKysgYi9kcml2ZXJzL3VzYi9tdXNiL211c2JfZGVidWdmcy5jDQpAQCAtMzI1LDcgKzMyNSw3
IEBAIHZvaWQgbXVzYl9pbml0X2RlYnVnZnMoc3RydWN0IG11c2IgKm11c2IpDQogew0KIAlzdHJ1
Y3QgZGVudHJ5ICpyb290Ow0KIA0KLQlyb290ID0gZGVidWdmc19jcmVhdGVfZGlyKGRldl9uYW1l
KG11c2ItPmNvbnRyb2xsZXIpLCBOVUxMKTsNCisJcm9vdCA9IGRlYnVnZnNfY3JlYXRlX2Rpcihk
ZXZfbmFtZShtdXNiLT5jb250cm9sbGVyKSwgdXNiX2RlYnVnX3Jvb3QpOw0KIAltdXNiLT5kZWJ1
Z2ZzX3Jvb3QgPSByb290Ow0KIA0KIAlkZWJ1Z2ZzX2NyZWF0ZV9maWxlKCJyZWdkdW1wIiwgU19J
UlVHTywgcm9vdCwgbXVzYiwgJm11c2JfcmVnZHVtcF9mb3BzKTsNCi0tIA0KMi4yMy4wDQo=

