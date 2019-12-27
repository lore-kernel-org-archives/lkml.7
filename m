Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD3BC2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13DC4208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577469299;
	bh=y5ZUJdBGvEd9wU+ozgECUMyVdZfnmtAjppTvIhvO/fw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FpmGYHe1WYeCt6CCJeFPb+FZIiFSVDVLuK1kEaY1+KL9JjDqw7CQEW8qvI/ytHgeG
	 9qL7ZiIZBCy4eqG6iRw6W9wfyqL9ocmzw6jSU/ZS/SDMep8KF+t9HaeGq6fSpOhVGt
	 Jg0LF0HvQ2tG3Ts/ZTCCq5VKbFhMKfu67ZpCIsuM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfL0Ry5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:54:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:39288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727855AbfL0Rm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:42:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6107A21744;
        Fri, 27 Dec 2019 17:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468545;
        bh=y5ZUJdBGvEd9wU+ozgECUMyVdZfnmtAjppTvIhvO/fw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N3fBpGf/2fvLXZ6lFd48wzNgOWP2KFDcOCLe3iFdP2OxblvqmLbtZlm1Mj7cRaQNn
         vSLmJR+SieoMMUa8E7r5x+TQOMaXMVBHKjoQwxIwuYcTAiWrWsam6T1axll6ebGv+h
         0++XeoIjqkJu/FXXX49nfzY1LXe/5CYqfNAnSDZ0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 073/187] bpftool: Don't crash on missing jited insns or ksyms
Date:   Fri, 27 Dec 2019 12:39:01 -0500
Message-Id: <20191227174055.4923-73-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174055.4923-1-sashal@kernel.org>
References: <20191227174055.4923-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

[ Upstream commit 5b79bcdf03628a3a9ee04d9cd5fabcf61a8e20be ]

When the kptr_restrict sysctl is set, the kernel can fail to return
jited_ksyms or jited_prog_insns, but still have positive values in
nr_jited_ksyms and jited_prog_len. This causes bpftool to crash when
trying to dump the program because it only checks the len fields not
the actual pointers to the instructions and ksyms.

Fix this by adding the missing checks.

Fixes: 71bb428fe2c1 ("tools: bpf: add bpftool")
Fixes: f84192ee00b7 ("tools: bpftool: resolve calls without using imm field")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Link: https://lore.kernel.org/bpf/20191210181412.151226-1-toke@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/prog.c          | 2 +-
 tools/bpf/bpftool/xlated_dumper.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 43fdbbfe41bb..ea0bcd58bcb9 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -493,7 +493,7 @@ static int do_dump(int argc, char **argv)
 
 	info = &info_linear->info;
 	if (mode == DUMP_JITED) {
-		if (info->jited_prog_len == 0) {
+		if (info->jited_prog_len == 0 || !info->jited_prog_insns) {
 			p_info("no instructions returned");
 			goto err_free;
 		}
diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
index 494d7ae3614d..5b91ee65a080 100644
--- a/tools/bpf/bpftool/xlated_dumper.c
+++ b/tools/bpf/bpftool/xlated_dumper.c
@@ -174,7 +174,7 @@ static const char *print_call(void *private_data,
 	struct kernel_sym *sym;
 
 	if (insn->src_reg == BPF_PSEUDO_CALL &&
-	    (__u32) insn->imm < dd->nr_jited_ksyms)
+	    (__u32) insn->imm < dd->nr_jited_ksyms && dd->jited_ksyms)
 		address = dd->jited_ksyms[insn->imm];
 
 	sym = kernel_syms_search(dd, address);
-- 
2.20.1

