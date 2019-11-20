Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4513CC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 06:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E12F206D8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 06:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CW/Z+rLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfKTGnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 01:43:35 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:39429 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725854AbfKTGne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 01:43:34 -0500
X-UUID: 1382161130ac402e84bec778131b952a-20191120
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Bf0H4NjN87Eyxjtkpl/ipYmRPL+ArIku0qP3VxKPEJk=;
        b=CW/Z+rLH7yh0KtlkqNa8gXmqCBJm2VfPuoEHk7LWs2Q49rtSS1Tyyny6qiU0Bz1ofy9O2xhnw2NgccaT8pbrga68Ni/FFWh4Q02wH2ba0ULMbAp4uyMaXA4tqsFcWQ41+U4cVI+6VFy53hOrAXVGEFkqJ0Kk2tLW6DOtT7Yv7fU=;
X-UUID: 1382161130ac402e84bec778131b952a-20191120
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 264360212; Wed, 20 Nov 2019 14:43:22 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 20 Nov 2019 14:42:31 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 20 Nov 2019 14:43:00 +0800
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
Subject: [RESEND PATCH v3 3/3] usb: gadget: udc: gr_udc: create debugfs directory under usb root
Date:   Wed, 20 Nov 2019 14:43:03 +0800
Message-ID: <1574232183-5760-3-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1574232183-5760-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1574232183-5760-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 13A396944ECAEF168D722F1FF46B51809385C180D0D671363AF7CA160F0B07A82000:8
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
Yl9kZWJ1Z19yb290DQotLS0NCiBkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2dyX3VkYy5jIHwgMyAr
Ky0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2dyX3VkYy5jIGIvZHJpdmVycy91c2Iv
Z2FkZ2V0L3VkYy9ncl91ZGMuYw0KaW5kZXggN2EwZTlhNThjMmQ4Li41ZDVhMGJjNzk3NTcgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2dyX3VkYy5jDQorKysgYi9kcml2ZXJz
L3VzYi9nYWRnZXQvdWRjL2dyX3VkYy5jDQpAQCAtMjksNiArMjksNyBAQA0KICNpbmNsdWRlIDxs
aW51eC9saXN0Lmg+DQogI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPg0KICNpbmNsdWRlIDxs
aW51eC9kZXZpY2UuaD4NCisjaW5jbHVkZSA8bGludXgvdXNiLmg+DQogI2luY2x1ZGUgPGxpbnV4
L3VzYi9jaDkuaD4NCiAjaW5jbHVkZSA8bGludXgvdXNiL2dhZGdldC5oPg0KICNpbmNsdWRlIDxs
aW51eC9kbWEtbWFwcGluZy5oPg0KQEAgLTIwOCw3ICsyMDksNyBAQCBzdGF0aWMgdm9pZCBncl9k
ZnNfY3JlYXRlKHN0cnVjdCBncl91ZGMgKmRldikNCiB7DQogCWNvbnN0IGNoYXIgKm5hbWUgPSAi
Z3JfdWRjX3N0YXRlIjsNCiANCi0JZGV2LT5kZnNfcm9vdCA9IGRlYnVnZnNfY3JlYXRlX2Rpcihk
ZXZfbmFtZShkZXYtPmRldiksIE5VTEwpOw0KKwlkZXYtPmRmc19yb290ID0gZGVidWdmc19jcmVh
dGVfZGlyKGRldl9uYW1lKGRldi0+ZGV2KSwgdXNiX2RlYnVnX3Jvb3QpOw0KIAlkZWJ1Z2ZzX2Ny
ZWF0ZV9maWxlKG5hbWUsIDA0NDQsIGRldi0+ZGZzX3Jvb3QsIGRldiwgJmdyX2Rmc19mb3BzKTsN
CiB9DQogDQotLSANCjIuMjMuMA0K

