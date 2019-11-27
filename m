Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EC3C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9F42071E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ze3q6IDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfK0BSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 20:18:08 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:47551 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725823AbfK0BSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 20:18:08 -0500
X-UUID: b7f63c0ea3f444df859299f8385c2a96-20191127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=0KnhnC91YWzoMubvDqpW4dGN3q1TdTr1bqtKF7j6sHs=;
        b=Ze3q6IDsVjL7jyl4GaNGizw4ToS7ypxaK92d3NWwCk9H2R/Y2/DvRKCiMJzwz/lGS11OugLHXAzc3lXHbFZALXLIfwNS07llKzbMABAJU563uSP2kbyQ333vekc8v4eFVWHasznsVDgBW8n23t+wGLFh0LQFp8dH8+RfowwPP3M=;
X-UUID: b7f63c0ea3f444df859299f8385c2a96-20191127
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1307537078; Wed, 27 Nov 2019 09:18:02 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Nov 2019 09:17:51 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Nov 2019 09:17:09 +0800
From:   <yongqiang.niu@mediatek.com>
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
Subject: [PATCH v1, 0/2] drm/mediatek: Fix external display issue 
Date:   Wed, 27 Nov 2019 09:17:53 +0800
Message-ID: <1574817475-22378-1-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWW9uZ3FpYW5nIE5pdSA8eW9uZ3FpYW5nLm5pdUBtZWRpYXRlay5jb20+DQoNCkZpeCBl
eHRlcm5hbCBkaXNwbGF5IGlzc3VlDQoNCllvbmdxaWFuZyBOaXUgKDIpOg0KICBkcm0vbWVkaWF0
ZWs6IEZpeHVwIGV4dGVybmFsIGRpc3BsYXkgYmxhY2sgc2NyZWVuIGlzc3VlDQogIGRybS9tZWRp
YXRlazogRml4IGV4dGVybmFsIGRpc3BsYXkgdmJsYW5rIHRpbWVvdXQgaXNzdWUNCg0KIGRyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMgICAgICAgICAgfCAxNCArKysrKy0tLS0NCiBk
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMgICAgIHwgNDUgKysrKysrKysr
KysrKysrKysrKystLS0tLS0tLS0NCiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9k
ZHBfY29tcC5oIHwgMTQgKysrKysrKysrDQogMyBmaWxlcyBjaGFuZ2VkLCA1NCBpbnNlcnRpb25z
KCspLCAxOSBkZWxldGlvbnMoLSkNCg0KLS0gDQoxLjguMS4xLmRpcnR5DQo=

