Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B92FC6194
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 07:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6305521D82
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 07:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbfKHHLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 02:11:30 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:50807 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728513AbfKHHL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 02:11:26 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=shile.zhang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0ThU5MwV_1573197070;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:shile.zhang@linux.alibaba.com fp:SMTPD_---0ThU5MwV_1573197070)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 08 Nov 2019 15:11:21 +0800
From:   shile.zhang@linux.alibaba.com
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        Shile Zhang <shile.zhang@linux.alibaba.com>
Subject: [RFC PATCH v2 2/3] kbuild: Sort ORC unwind tables in vmlinux link phase
Date:   Fri,  8 Nov 2019 15:11:07 +0800
Message-Id: <20191108071108.72132-3-shile.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.0.rc2
In-Reply-To: <20191108071108.72132-1-shile.zhang@linux.alibaba.com>
References: <20191108071108.72132-1-shile.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shile Zhang <shile.zhang@linux.alibaba.com>

Sort the ORC unwind tables in vmlinux link phase, only for ORC unwinder.

Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
---
 scripts/link-vmlinux.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 06495379fcd8..dea7797fcbdc 100755
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
@@ -303,6 +308,15 @@ if [ -n "${CONFIG_BUILDTIME_EXTABLE_SORT}" ]; then
 	sortextable vmlinux
 fi
 
+if [ -n "${CONFIG_UNWINDER_ORC}" ]; then
+	info SORTORC vmlinux
+	if ! sortorctable vmlinux; then
+		echo >&2 Failed to sort ORC unwind tables
+		echo >&2 Check what is wrong and try again
+		exit 1
+	fi
+fi
+
 info SYSMAP System.map
 mksysmap vmlinux System.map
 
-- 
2.24.0.rc2

