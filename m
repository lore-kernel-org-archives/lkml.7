Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F718C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD2B9205F4
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556330077;
	bh=s+13NMc7ln81qT16q5QAkC5hwxoGBDU+Ln3Q/xD6+tU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=heN2Z2VNdLU/m9PM6vd8UtU3PFiGEPHecw34eE6QHzN9lzSnyEkSZxoVgTBipuiqx
	 XTO5qz/A05dlL+8frKNbWRphZkwqCC7ksBsBD2XOXJV1FfL3VMbbnk+mWkNxLkx6qu
	 82zSw9pbqSCAnCdTHhVRBV55Vl44Lxeu+YosBqTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbfD0Byg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:54:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727742AbfD0Bjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:39:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4D44214AE;
        Sat, 27 Apr 2019 01:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329186;
        bh=s+13NMc7ln81qT16q5QAkC5hwxoGBDU+Ln3Q/xD6+tU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NJYVb/QkFL7B6dxwc/8/9iNfXA1QpoEhueIAHIIzNZG3WSY6aY5Mzeig8eR0P25bo
         qiC3eeVafZOaEUXFlU+Kf/lHlWYlGWvr42rGPTgSF31cBw/TqVwVcG48biphxy7E36
         G/wgNS8+O2NZ+7DftkgNOMB27tk1ZpDDqCA5q/7o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 43/79] objtool: Add rewind_stack_do_exit() to the noreturn list
Date:   Fri, 26 Apr 2019 21:38:02 -0400
Message-Id: <20190427013838.6596-43-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427013838.6596-1-sashal@kernel.org>
References: <20190427013838.6596-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

[ Upstream commit 4fa5ecda2bf96be7464eb406df8aba9d89260227 ]

This fixes the following warning seen on GCC 7.3:

  arch/x86/kernel/dumpstack.o: warning: objtool: oops_end() falls through to next function show_regs()

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/3418ebf5a5a9f6ed7e80954c741c0b904b67b5dc.1554398240.git.jpoimboe@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/objtool/check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5dde107083c6..479196aeb409 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -165,6 +165,7 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"fortify_panic",
 		"usercopy_abort",
 		"machine_real_restart",
+		"rewind_stack_do_exit",
 	};
 
 	if (func->bind == STB_WEAK)
-- 
2.19.1

