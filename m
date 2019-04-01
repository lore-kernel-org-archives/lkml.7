Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC852C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE83621939
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138718;
	bh=NNHA15Yp2x39Dm5RvBMAdY6liFXRG2p/8DRcwxLU37E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OXKwhsGp37nzPJRC7oLn0Wf0FIKfnanvxc5PSZpD3GPX4IFzuFn5YXuQCEQFUvkyG
	 lgBIp8kjOLI+5TOI/wCs9kDiVQmjs0oG8yq6R75Wpwp5eqhxeiJlNHJ71wROS2o3AH
	 4tQIanEoQLQsNbGGS6inCqOqHmPTQ7Jg7P1Wi3xg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbfDARL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:11:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730268AbfDARLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:11:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BB6E21929;
        Mon,  1 Apr 2019 17:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138709;
        bh=NNHA15Yp2x39Dm5RvBMAdY6liFXRG2p/8DRcwxLU37E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FSXzz/Kus599IytwC2I8p8DYN3uFgbdAdlVQRywERztB+Vdy63io+jqa90U88fa9e
         hFBWuQIqiB67XOBjGB1I/99JCjrDu7iBqhJHPp+y8rol+kfAZeuOhwJTN3nhIS+0x4
         Zt80MHWgjC8M7qDF8VXR81cbrujWJPLV/M9h5a2o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xu Yu <xuyu@linux.alibaba.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 5.0 145/146] bpf: do not restore dst_reg when cur_state is freed
Date:   Mon,  1 Apr 2019 19:02:37 +0200
Message-Id: <20190401170100.264392053@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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
@@ -3187,7 +3187,7 @@ do_sim:
 		*dst_reg = *ptr_reg;
 	}
 	ret = push_stack(env, env->insn_idx + 1, env->insn_idx, true);
-	if (!ptr_is_dst_reg)
+	if (!ptr_is_dst_reg && ret)
 		*dst_reg = tmp;
 	return !ret ? -EFAULT : 0;
 }


