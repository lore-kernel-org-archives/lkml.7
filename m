Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B34FC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C2AB207FA
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389537AbfKGOdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 09:33:03 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:40285 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731082AbfKGOdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:33:02 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=shile.zhang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0ThQoCKT_1573137161;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:shile.zhang@linux.alibaba.com fp:SMTPD_---0ThQoCKT_1573137161)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 07 Nov 2019 22:32:55 +0800
From:   shile.zhang@linux.alibaba.com
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        Shile Zhang <shile.zhang@linux.alibaba.com>
Subject: [RFC PATCH 2/4] kbuild: Sort ORC unwind tables in vmlinux link process
Date:   Thu,  7 Nov 2019 22:32:03 +0800
Message-Id: <20191107143205.206606-3-shile.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.0.rc2
In-Reply-To: <20191107143205.206606-1-shile.zhang@linux.alibaba.com>
References: <20191107143205.206606-1-shile.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shile Zhang <shile.zhang@linux.alibaba.com>

To sort the ORC unwind tables in vmlinux link process, controlled
by configure BUILDTIME_ORCTABLE_SORT.

Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
---
 scripts/link-vmlinux.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 06495379fcd8..43fe8c151c8d 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -183,6 +183,11 @@ sortextable()
 	${objtree}/scripts/sortextable ${1}
 }
 
+sortorctable()
+{
+	${objtree}/scripts/sortorctable ${1}
+}
+
 # Delete output files in case of error
 cleanup()
 {
@@ -303,6 +308,11 @@ if [ -n "${CONFIG_BUILDTIME_EXTABLE_SORT}" ]; then
 	sortextable vmlinux
 fi
 
+if [ -n "${CONFIG_BUILDTIME_ORCTABLE_SORT}" ]; then
+	info SORTORC vmlinux
+	sortorctable vmlinux
+fi
+
 info SYSMAP System.map
 mksysmap vmlinux System.map
 
-- 
2.24.0.rc2

