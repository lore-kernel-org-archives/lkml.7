Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B9FC2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 07:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A6224656
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 07:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="e4sWrFmr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfLMHru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 02:47:50 -0500
Received: from mailgw02.mediatek.com ([216.200.240.185]:58585 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfLMHrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 02:47:49 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Dec 2019 02:47:49 EST
X-UUID: 615e2bc96af143bcb9cd16e227fd3c29-20191212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=hE/LFR4VgS3BbRyTDvhyusFCTOwqCXLwuzkWfS0Tpg4=;
        b=e4sWrFmrq05KGo5WU2lyaYyGm83EjoHyp3F69sczTgkl/xkZpJHFi7FqtXfMRwSd8P0Wj3k+6UNYxajLR4+zc75lOk8emhMvvcKDI3m2tN5UJNDcrukoUExwgiwcxuuYFIbxRimw0w5ULFBWES3ShG3xBnv/4jPW1MUYjPuXnyM=;
X-UUID: 615e2bc96af143bcb9cd16e227fd3c29-20191212
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1002112206; Thu, 12 Dec 2019 23:42:44 -0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 13 Dec 2019 15:28:32 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 13 Dec 2019 15:28:23 +0800
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
Subject: [PATCH v2, 0/2] drm/mediatek: Add ctm property support
Date:   Fri, 13 Dec 2019 15:28:50 +0800
Message-ID: <1576222132-31586-1-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB2MToNCi1zZXBhcmF0ZSBnYW1tYSBwYXRjaA0KLXJlbW92ZSBjbWRxIHN1
cHBvcnQgZm9yIGN0bSBzZXR0aW5nDQoNCg0KWW9uZ3FpYW5nIE5pdSAoMik6DQogIGRybS9tZWRp
YXRlazogRml4IGdhbW1hIGNvcnJlY3Rpb24gaXNzdWUNCiAgZHJtL21lZGlhdGVrOiBBZGQgY3Rt
IHByb3BlcnR5IHN1cHBvcnQNCg0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Ny
dGMuYyAgICAgfCAxOCArKysrKysrLS0NCiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Ry
bV9kZHBfY29tcC5jIHwgNjIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCiBkcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5oIHwgIDkgKysrKysNCiAzIGZpbGVz
IGNoYW5nZWQsIDg1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCi0tIA0KMS44LjEu
MS5kaXJ0eQ0K

