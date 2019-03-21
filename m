Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA79C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF1E218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbfCUKAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:00:48 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:41844 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728325AbfCUKAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 06:00:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=xuyu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TNGmqso_1553162437;
Received: from localhost(mailfrom:xuyu@linux.alibaba.com fp:SMTPD_---0TNGmqso_1553162437)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 21 Mar 2019 18:00:43 +0800
From:   Xu Yu <xuyu@linux.alibaba.com>
To:     daniel@iogearbox.net, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] bpf: do not restore dst_reg when cur_state is freed
Date:   Thu, 21 Mar 2019 18:00:35 +0800
Message-Id: <ae7834dda12cb2a88dd8471132d6274a7d1ec5f0.1553161998.git.xuyu@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <eec7905a71d207f7612e9d86e1bf59c43efc65a4.1553156792.git.xuyu@linux.alibaba.com>
References: <eec7905a71d207f7612e9d86e1bf59c43efc65a4.1553156792.git.xuyu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzkaller hit 'KASAN: use-after-free Write in sanitize_ptr_alu' bug.
Call trace:
  dump_stack+0xbf/0x12e
  print_address_description+0x6a/0x280
  kasan_report+0x237/0x360
  sanitize_ptr_alu+0x85a/0x8d0
  adjust_ptr_min_max_vals+0x8f2/0x1ca0
  adjust_reg_min_max_vals+0x8ed/0x22e0
  do_check+0x1ca6/0x5d00
  bpf_check+0x9ca/0x2570
  bpf_prog_load+0xc91/0x1030
  __se_sys_bpf+0x61e/0x1f00
  do_syscall_64+0xc8/0x550
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
Fault injection trace:
  kfree+0xea/0x290
  free_func_state+0x4a/0x60
  free_verifier_state+0x61/0xe0
  push_stack+0x216/0x2f0	          <- inject failslab
  sanitize_ptr_alu+0x2b1/0x8d0
  adjust_ptr_min_max_vals+0x8f2/0x1ca0
  adjust_reg_min_max_vals+0x8ed/0x22e0
  do_check+0x1ca6/0x5d00
  bpf_check+0x9ca/0x2570
  bpf_prog_load+0xc91/0x1030
  __se_sys_bpf+0x61e/0x1f00
  do_syscall_64+0xc8/0x550
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

When kzalloc() fails in push_stack(), free_verifier_state() will free
current verifier state. As push_stack() returns, dst_reg was restored
if ptr_is_dst_reg is false. However, as member of the cur_state, dst_reg
is also freed, and error occurs when dereferencing dst_reg.

Simply fix it by testing ret of push_stack() before retoring dst_reg.

Signed-off-by: Xu Yu <xuyu@linux.alibaba.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ce166a0..cb1b874 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3368,7 +3368,7 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
 		*dst_reg = *ptr_reg;
 	}
 	ret = push_stack(env, env->insn_idx + 1, env->insn_idx, true);
-	if (!ptr_is_dst_reg)
+	if (!ptr_is_dst_reg && ret)
 		*dst_reg = tmp;
 	return !ret ? -EFAULT : 0;
 }
-- 
1.8.3.1

