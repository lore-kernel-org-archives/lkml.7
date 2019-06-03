Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2395C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832E527FE8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559567089;
	bh=NLlyuoL8659H1E2jNxb1kSF6VtTnVPNy54AwF0w2a18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PD92MdKxThzMPBDSKMUuySc1HXSXLb540IL/OIm+eaITaBkDzu3fKJuXqzisLHG6F
	 ZJ5/sZolUXdYoQG+BCy9ljQIfYDFJ1pgwBTjVmxGin/jogDIT3C610rxpAevcYEEVD
	 R1ivxO6NnaVhwFyOaQ+Ud2U6PmlE4N6nshhZhsNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbfFCNEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:04:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:38356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbfFCNEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:04:48 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9117F27FCE;
        Mon,  3 Jun 2019 13:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559567087;
        bh=NLlyuoL8659H1E2jNxb1kSF6VtTnVPNy54AwF0w2a18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jCglHfcTjyT8PmV+FXdBYjkt9g7gM/46ccpplI93C7bsmvcNDVoAbUyl/Z4xRRkQx
         YwUzMGfmSMw1auhhoWrkcBaEc9bezJ8DQY+7L6SkPkMIaLZ7P8xnUbcjg+fcTu/wJ8
         ErGNAF1+28ifKLsvAvydeLh9uNJpP03D4WVuwtD8=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kprobes: Fix to init kprobes in subsys_initcall
Date:   Mon,  3 Jun 2019 22:04:42 +0900
Message-Id: <155956708268.12228.10363800793132214198.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190603214105.715a4072472ef4946123dc20@kernel.org>
References: <20190603214105.715a4072472ef4946123dc20@kernel.org>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since arm64 kernel initializes breakpoint trap vector in arch_initcall(),
initializing kprobe (and run smoke test) in postcore_initcall() causes
a kernel panic.

To fix this issue, move the kprobe initialization in subsys_initcall()
(which is called right afer the arch_initcall).

In-kernel kprobe users (ftrace and bpf) are using fs_initcall() which is
called after subsys_initcall(), so this shouldn't cause more problem.

Reported-by: Anders Roxell <anders.roxell@linaro.org>
Fixes: b5f8b32c93b2 ("kprobes: Initialize kprobes at postcore_initcall")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 54aaaad00a47..5471efbeb937 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2289,7 +2289,7 @@ static int __init init_kprobes(void)
 		init_test_probes();
 	return err;
 }
-postcore_initcall(init_kprobes);
+subsys_initcall(init_kprobes);
 
 #ifdef CONFIG_DEBUG_FS
 static void report_probe(struct seq_file *pi, struct kprobe *p,

