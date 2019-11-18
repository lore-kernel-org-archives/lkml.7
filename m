Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F4FC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 04:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0EC120730
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 04:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Tl3P6zE7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfKRE6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 23:58:10 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:65157 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726314AbfKRE6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 23:58:09 -0500
X-UUID: b7c37ce00bbe402385036e8847275c20-20191118
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=PwooS7+c3Hefvuj7Qg4f+8puNQ2YZcWGbv3SCO5cba8=;
        b=Tl3P6zE7XQ9/Lg/1O7R+1jSOnq5JmZKpOKHXR4LLhNDiW8wHTITPkFBj6OEGH35qXt4ME88QSLnE3GC7aJkDJV4CZpLLXcALYpAln4VaI00feriQR6CNR/ySpPDF2MYhuzDw1w4iDLOHN46ERtuNn4z2C6BtVq20nEMnOT5SqE8=;
X-UUID: b7c37ce00bbe402385036e8847275c20-20191118
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <luhua.xu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2003779404; Mon, 18 Nov 2019 12:57:44 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 18 Nov 2019 12:57:48 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 18 Nov 2019 12:57:32 +0800
From:   Luhua Xu <luhua.xu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Leilk Liu <leilk.liu@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] spi CS customization support 
Date:   Mon, 18 Nov 2019 12:57:15 +0800
Message-ID: <1574053037-26721-1-git-send-email-luhua.xu@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 4574C02A88C4CD2230000881FE3CDDB52C40828BB2C0D6FEC0BC95FEF95C37BA2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlc2UgcGF0Y2ggc2VyaWVzIGFkZCBTUEkgQ1MgcG9sYXJpdHkgYW5kIENTIHNldHVwL2hvbGQv
aWRsZQ0KdGltZSBjdXN0b21pemF0aW9uIHN1cHBvcnQuDQoNCkx1aHVhIFh1ICgyKToNCiAgc3Bp
OiBtZWRpYXRlazogYWRkIFNQSV9DU19ISUdIIHN1cHBvcnQNCiAgc3BpOiBtZWRpYXRlazogYWRk
IGNzIHRpbWluZyBjb25maWd1cmF0aW9uIHN1cHBvcnQNCg0KIGRyaXZlcnMvc3BpL3NwaS1tdDY1
eHguYyAgICAgICAgICAgICAgICAgfCA1MyArKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LQ0KIGluY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9zcGktbXQ2NXh4LmggfCAgNiArKystDQog
MiBmaWxlcyBjaGFuZ2VkLCA0NyBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCg0KDQo=

