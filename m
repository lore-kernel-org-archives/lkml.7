Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE730C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 08:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A55520855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 08:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SJt/F7Sy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfKUINV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 03:13:21 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:44455 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726170AbfKUINV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 03:13:21 -0500
X-UUID: e9cbf3732efd46189b4a8c5819da145b-20191121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=U97mKHK8idOeQxpJETaSEs2XLJJYwjnYHMcOchdEF+g=;
        b=SJt/F7SyKCEqREcvs+FW59AwJMxgQkTUFhIt0sEmSuDcXpPD5l3fzGFmLcZBEpJbM4Trh7w+PYETKFwOw8wbuKTU7BKbZncbOnTgCkFciHAFgkcp61lrP1gxhXdRLOFuWoqX69NpwIZ5MsmekvZlLXRvmC/rPoDhyXD8QRvcHW0=;
X-UUID: e9cbf3732efd46189b4a8c5819da145b-20191121
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <yt.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2107909423; Thu, 21 Nov 2019 16:13:17 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 21 Nov 2019 16:13:13 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Nov 2019 16:13:37 +0800
From:   YT Chang <yt.chang@mediatek.com>
To:     YT Chang <yt.chang@mediatek.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <wsd_upstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/1] sched: panic, when call schedule with preemption disable
Date:   Thu, 21 Nov 2019 16:13:05 +0800
Message-ID: <1574323985-24193-1-git-send-email-yt.chang@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2hlbiBwcmVlbXB0aW9uIGlzIGRpc2FibGUsIGNhbGwgc2NoZWR1bGUoKSBpcyBpbmNvcnJlY3Qg
YmVoYXZpb3IuDQpTdWdnZXN0IHRvIHBhbmljIGRpcmVjdGx5IHJhdGhlciB0aGFuIGRlcGVuZCBv
biBwYW5pY19vbl93YXJuLg0KDQpTaWduZWQtb2ZmLWJ5OiBZVCBDaGFuZyA8eXQuY2hhbmdAbWVk
aWF0ZWsuY29tPg0KLS0tDQoga2VybmVsL3NjaGVkL2NvcmUuYyB8IDMgKy0tDQogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEva2Vy
bmVsL3NjaGVkL2NvcmUuYyBiL2tlcm5lbC9zY2hlZC9jb3JlLmMNCmluZGV4IDc4ODBmNGYuLjIx
NGU4ZDggMTAwNjQ0DQotLS0gYS9rZXJuZWwvc2NoZWQvY29yZS5jDQorKysgYi9rZXJuZWwvc2No
ZWQvY29yZS5jDQpAQCAtMzg2MSw5ICszODYxLDggQEAgc3RhdGljIG5vaW5saW5lIHZvaWQgX19z
Y2hlZHVsZV9idWcoc3RydWN0IHRhc2tfc3RydWN0ICpwcmV2KQ0KIAkJcHJpbnRfaXBfc3ltKHBy
ZWVtcHRfZGlzYWJsZV9pcCk7DQogCQlwcl9jb250KCJcbiIpOw0KIAl9DQotCWlmIChwYW5pY19v
bl93YXJuKQ0KLQkJcGFuaWMoInNjaGVkdWxpbmcgd2hpbGUgYXRvbWljXG4iKTsNCiANCisJcGFu
aWMoInNjaGVkdWxpbmcgd2hpbGUgYXRvbWljXG4iKTsNCiAJZHVtcF9zdGFjaygpOw0KIAlhZGRf
dGFpbnQoVEFJTlRfV0FSTiwgTE9DS0RFUF9TVElMTF9PSyk7DQogfQ0KLS0gDQoxLjkuMQ0K

