Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB68C06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E0721852
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfGDJkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 05:40:40 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38817 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727269AbfGDJkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 05:40:40 -0400
X-UUID: cc07f368726f42b8b1108f7c792871fb-20190704
X-UUID: cc07f368726f42b8b1108f7c792871fb-20190704
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 570256049; Thu, 04 Jul 2019 17:40:27 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 4 Jul 2019 17:40:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 4 Jul 2019 17:40:25 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>
Subject: [PATCH v2] checkpatch: add several Kconfig default value tests
Date:   Thu, 4 Jul 2019 17:40:24 +0800
Message-ID: <20190704094024.16162-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds 3 Kconfig default value tests:

1. discourage default n cases:
e.g.,
default n

2. discourage default "[ynm]" cases:
e.g.,
arch/powerpc/Kconfig:   default "y" if PPC_POWERNV
arch/powerpc/Kconfig:   default "y" if PPC_POWERNV
arch/powerpc/Kconfig:   default "n"
drivers/auxdisplay/Kconfig:     default "n"
drivers/crypto/Kconfig: default "m"
drivers/rapidio/devices/Kconfig:        default "n"

3. discourage default \!?EXPERT cases:
e.g.,
drivers/hid/Kconfig:    default !EXPERT

tested cases:
default m
default n if ALPHA_EV5 || ALPHA_EV56 || (ALPHA_EV4 && !ALPHA_LCA)
default y if ALPHA_QEMU
default n if PPC_POWERNV
default n
default EXPERT
default !EXPERT
default "m"
default "n"
default "y" if EXPERT
default "y" if PPC_POWERNV

test result:
WARNING: 'default n' is the default value, no need to write it explicitly.
+       default n

WARNING: Avoid default turn on kernel configs by default !?EXPERT
+       default EXPERT

WARNING: Avoid default turn on kernel configs by default !?EXPERT
+       default !EXPERT

WARNING: Use default [ynm] instead of default "[ynm]"
+       default "m"

WARNING: Use default [ynm] instead of default "[ynm]"
+       default "n"

WARNING: Use default [ynm] instead of default "[ynm]"
+       default "y" if EXPERT

WARNING: Use default [ynm] instead of default "[ynm]"
+       default "y" if PPC_POWERNV

Change since v1:
discourage default n$
discourage default "[ynm]"
discourage default \!?EXPERT

Cc: Joe Perches <joe@perches.com>
Cc: Yingjoe Chen <yingjoe.chen@mediatek.com>
Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 scripts/checkpatch.pl | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 342c7c781ba5..c1de50202a18 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3005,6 +3005,27 @@ sub process {
 			     "Use of boolean is deprecated, please use bool instead.\n" . $herecurr);
 		}
 
+# discourage redundant 'default n'
+		if ($realfile =~ /Kconfig/ &&
+		    $line =~ /^\+\s*default n$/) {
+			WARN("DEFAULT_VALUE_STYLE",
+			     "'default n' is the default value, no need to write it explicitly.\n" . $herecurr);
+		}
+
+# discourage quote: use default [ynm], not default "[ynm]"
+		if ($realfile =~ /Kconfig/ &&
+		    $rawline =~ /^\+\s*default\s*"[ynm]"/) {
+			WARN("DEFAULT_VALUE_STYLE",
+			     "Use default [ynm] instead of default \"[ynm]\"\n" . $herecurr);
+		}
+
+# discourage default \!?EXPERT
+		if ($realfile =~ /Kconfig/ &&
+		    $line =~ /^\+\s*default \!?EXPERT/) {
+			WARN("DEFAULT_VALUE_STYLE",
+			     "Avoid default turn on kernel configs by default !?EXPERT\n" . $herecurr);
+		}
+
 		if (($realfile =~ /Makefile.*/ || $realfile =~ /Kbuild.*/) &&
 		    ($line =~ /\+(EXTRA_[A-Z]+FLAGS).*/)) {
 			my $flag = $1;
-- 
2.18.0

