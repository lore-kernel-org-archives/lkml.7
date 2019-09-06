Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC01C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 06:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9777E206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 06:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388912AbfIFGBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 02:01:52 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:5647 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726080AbfIFGBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 02:01:52 -0400
X-UUID: fceac7b8c77f4dd78fb93eda6adf6708-20190906
X-UUID: fceac7b8c77f4dd78fb93eda6adf6708-20190906
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1335698442; Fri, 06 Sep 2019 14:01:44 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 6 Sep 2019 14:01:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 6 Sep 2019 14:01:31 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        YJ Chiang <yj.chiang@mediatek.com>,
        Alix Wu <alix.wu@mediatek.com>
Subject: [PATCH] perf/hw_breakpoint: Fix arch_hw_breakpoint use-before-initialization
Date:   Fri, 6 Sep 2019 14:01:16 +0800
Message-ID: <20190906060115.9460-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we disable the compiler's auto-initialization feature
(-fplugin-arg-structleak_plugin-byref or -ftrivial-auto-var-init=pattern)
is disabled, arch_hw_breakpoint may be used before initialization after
the change 9a4903dde2c86.
(perf/hw_breakpoint: Split attribute parse and commit)

On our arm platform, the struct step_ctrl in arch_hw_breakpoint, which
used to be zero-initialized by kzalloc, may be used in
arch_install_hw_breakpoint without initialization.

Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc: YJ Chiang <yj.chiang@mediatek.com>
Cc: Alix Wu <alix.wu@mediatek.com>
---
 kernel/events/hw_breakpoint.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index c5cd852fe86b..8fb842394924 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -413,7 +413,7 @@ static int hw_breakpoint_parse(struct perf_event *bp,

 int register_perf_hw_breakpoint(struct perf_event *bp)
 {
-	struct arch_hw_breakpoint hw;
+	struct arch_hw_breakpoint hw = {0};
 	int err;

 	err = reserve_bp_slot(bp);
@@ -461,7 +461,7 @@ int
 modify_user_hw_breakpoint_check(struct perf_event *bp, struct perf_event_attr *attr,
 			        bool check)
 {
-	struct arch_hw_breakpoint hw;
+	struct arch_hw_breakpoint hw = {0};
 	int err;

 	err = hw_breakpoint_parse(bp, attr, &hw);
--
2.18.0

