Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0E8C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDCB12070E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fyk/xlEa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfKNKm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 05:42:27 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:15707 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726985AbfKNKl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 05:41:58 -0500
X-UUID: 91b1dc569be24d2c8f91207c89249814-20191114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=iMhNXO2FWXFtuXi/Y1IUnxuG3nineMKRmQPD/4NB45k=;
        b=fyk/xlEaKye+BV6m8km8kBzWzL9PsPgfRrSMrcsMdSrVA+Aw3QJArmbGtXjzdMoZrfz6qfw1V6xO1G34/MJQ9yGl3lEiKgajwQ4tkQeM5tdJSQ3OSp63LzC/Ic+7iBLFHiI6gaBZD+A+JtWltw/o9UrAH/yYRNuRGAtmV8BrX/U=;
X-UUID: 91b1dc569be24d2c8f91207c89249814-20191114
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1787701832; Thu, 14 Nov 2019 18:41:52 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 14 Nov 2019 18:41:50 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 14 Nov 2019 18:41:46 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, Bin Liu <b-liu@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Colin Ian King <colin.king@canonical.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v3 09/13] usb: gadget: atmel: create debugfs directory under usb root
Date:   Thu, 14 Nov 2019 18:41:21 +0800
Message-ID: <1573728085-29016-9-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1573728085-29016-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1573728085-29016-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tm93IHRoZSBVU0IgZ2FkZ2V0IHN1YnN5c3RlbSBjYW4gdXNlIHRoZSBVU0IgZGVidWdmcyByb290
IGRpcmVjdG9yeSwNCnNvIG1vdmUgaXQncyBkaXJlY3RvcnkgZnJvbSB0aGUgcm9vdCBvZiB0aGUg
ZGVidWdmcyBmaWxlc3lzdGVtIGludG8NCnRoZSByb290IG9mIHVzYg0KDQpTaWduZWQtb2ZmLWJ5
OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQotLS0NCnYzOg0KICAx
LiBmaXggdXAgYnVpbGQgZXJyb3Igb2YgdW5kZWZpbmVkIHVzYl9kZWJ1Z19yb290DQoNCnYyOg0K
ICAxLiBhYmFuZG9uIG5ldyBBUEkgdXNiX2RlYnVnZnNfY3JlYXRlX2RpcigpLCBhbmQgdXNlIHVz
Yl9kZWJ1Z19yb290DQotLS0NCiBkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2F0bWVsX3VzYmFfdWRj
LmMgfCAzICsrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYXRtZWxfdXNiYV91ZGMu
YyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYXRtZWxfdXNiYV91ZGMuYw0KaW5kZXggODZmZmM4
MzA3ODY0Li40ODAyN2U0ODZlNmIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRj
L2F0bWVsX3VzYmFfdWRjLmMNCisrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYXRtZWxfdXNi
YV91ZGMuYw0KQEAgLTE4LDYgKzE4LDcgQEANCiAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2
aWNlLmg+DQogI2luY2x1ZGUgPGxpbnV4L3JlZ21hcC5oPg0KICNpbmNsdWRlIDxsaW51eC9jdHlw
ZS5oPg0KKyNpbmNsdWRlIDxsaW51eC91c2IuaD4NCiAjaW5jbHVkZSA8bGludXgvdXNiL2NoOS5o
Pg0KICNpbmNsdWRlIDxsaW51eC91c2IvZ2FkZ2V0Lmg+DQogI2luY2x1ZGUgPGxpbnV4L2RlbGF5
Lmg+DQpAQCAtMjI2LDcgKzIyNyw3IEBAIHN0YXRpYyB2b2lkIHVzYmFfaW5pdF9kZWJ1Z2ZzKHN0
cnVjdCB1c2JhX3VkYyAqdWRjKQ0KIAlzdHJ1Y3QgZGVudHJ5ICpyb290Ow0KIAlzdHJ1Y3QgcmVz
b3VyY2UgKnJlZ3NfcmVzb3VyY2U7DQogDQotCXJvb3QgPSBkZWJ1Z2ZzX2NyZWF0ZV9kaXIodWRj
LT5nYWRnZXQubmFtZSwgTlVMTCk7DQorCXJvb3QgPSBkZWJ1Z2ZzX2NyZWF0ZV9kaXIodWRjLT5n
YWRnZXQubmFtZSwgdXNiX2RlYnVnX3Jvb3QpOw0KIAl1ZGMtPmRlYnVnZnNfcm9vdCA9IHJvb3Q7
DQogDQogCXJlZ3NfcmVzb3VyY2UgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UodWRjLT5wZGV2LCBJ
T1JFU09VUkNFX01FTSwNCi0tIA0KMi4yMy4wDQo=

