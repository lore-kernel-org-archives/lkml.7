Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E76C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581702064A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611801;
	bh=5L7MLfi6prf6oZEelu7lYa931f5zPNtr7ggsATV8zw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=teVQaGeCUJExXstvmpSJrg4MHFxiga8BkiwpDozMpXHsQpzhF7XKUrbOqdKGpJMDt
	 ImfPBG7hSMX7bZqJXPiZz3k3fQdjXDwvkDh3SBac4zTfr9MgSOdFs8QkkaHPYHJgkb
	 rht9GLJwNTX6FZBJe8Ffcw5BzgyBlGkg2SNPi91c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404093AbfDRSXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:23:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390479AbfDRSGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:06:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 566722186A;
        Thu, 18 Apr 2019 18:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610794;
        bh=5L7MLfi6prf6oZEelu7lYa931f5zPNtr7ggsATV8zw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XhUXZMae8P/F8T+NU0vVLnFMQ58xbWzC12puFhBIpFzYMkJzIlXFKdU8xolgaoa2e
         smKWIfY2WxHQG0fOa0PJaH/ZlfhCj/hBgeQcKbRr/wGp3gfgxbmd87YiUhbfPjBzdm
         XeuEgj3JK/cjcS6ktQa1GjqV8rDcJnyj8atfiaJM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xu Yu <xuyu@linux.alibaba.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 4.14 87/92] bpf: do not restore dst_reg when cur_state is freed
Date:   Thu, 18 Apr 2019 19:57:45 +0200
Message-Id: <20190418160438.102407405@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
References: <20190418160430.325165109@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Yu <xuyu@linux.alibaba.com>

commit 0803278b0b4d8eeb2b461fb698785df65a725d9e upstream.

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
if ptr_is_dst_reg is false. However, as member of the cur_state,
dst_reg is also freed, and error occurs when dereferencing dst_reg.
Simply fix it by testing ret of push_stack() before restoring dst_reg.

Fixes: 979d63d50c0c ("bpf: prevent out of bounds speculation on pointer arithmetic")
Signed-off-by: Xu Yu <xuyu@linux.alibaba.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/verifier.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2118,7 +2118,7 @@ do_sim:
 		*dst_reg = *ptr_reg;
 	}
 	ret = push_stack(env, env->insn_idx + 1, env->insn_idx, true);
-	if (!ptr_is_dst_reg)
+	if (!ptr_is_dst_reg && ret)
 		*dst_reg = tmp;
 	return !ret ? -EFAULT : 0;
 }


