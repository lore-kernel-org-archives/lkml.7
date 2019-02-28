Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBB1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF14218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366697;
	bh=fn2VglIejKGerKOg1gc9808eDGStI104LvGM0tXePCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DgGR12UcughLrYOR+n0OnYO7NnCkr7xVS0wZK80H6N1SvY6mhv0Mfav6cIyoz//Ac
	 LdOWqpyMUxee1eQYjx12d4CvvIaYFh42aD1raKQWVXd2sX3oiIiAtrw1JNEekFrnS2
	 kpQ/XereLfKqxvN2lPUqLGcIb1kn38LCQYE8YWMA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388020AbfB1PLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:11:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:44676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732726AbfB1PL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:11:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87D89218C3;
        Thu, 28 Feb 2019 15:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366689;
        bh=fn2VglIejKGerKOg1gc9808eDGStI104LvGM0tXePCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=agqDPERkpM5kbS5eDnEo4lx14Me2WE6DdjyahSm7Ldr9kvMa858yoUV46WHPt7WsR
         FCLB9hi5takptiTO5YsFVAabfiez8+Cd8cSbQDzatHWIJNevQ7dgBiZlE1UcGvi4yp
         JZ05bg5ke6IfyZq0pvmSg65HGaYFUYO34Pw8AZH0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 13/64] bpftool: Fix prog dump by tag
Date:   Thu, 28 Feb 2019 10:10:14 -0500
Message-Id: <20190228151105.11277-13-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151105.11277-1-sashal@kernel.org>
References: <20190228151105.11277-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit 752bcf80f5549c9901b2e8bc77b2138de55b1026 ]

Lance reported an issue with bpftool not being able to
dump program if there are more programs loaded and you
want to dump any but the first program, like:

  # bpftool prog
  28: kprobe  name trace_req_start  tag 1dfc28ba8b3dd597  gpl
  	loaded_at 2019-01-18T17:02:40+1100  uid 0
  	xlated 112B  jited 109B  memlock 4096B  map_ids 13
  29: kprobe  name trace_req_compl  tag 5b6a5ecc6030a683  gpl
  	loaded_at 2019-01-18T17:02:40+1100  uid 0
  	xlated 928B  jited 575B  memlock 4096B  map_ids 13,14
  #  bpftool prog dum jited tag 1dfc28ba8b3dd597
   0:	push   %rbp
   1:	mov    %rsp,%rbp
  ...

  #  bpftool prog dum jited tag 5b6a5ecc6030a683
  Error: can't get prog info (29): Bad address

The problem is in the prog_fd_by_tag function not cleaning
the struct bpf_prog_info before another request, so the
previous program length is still in there and kernel assumes
it needs to dump the program, which fails because there's no
user pointer set.

Moving the struct bpf_prog_info declaration into the loop,
so it gets cleaned before each query.

Fixes: 71bb428fe2c1 ("tools: bpf: add bpftool")
Reported-by: Lance Digby <ldigby@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/prog.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 0de024a6cc2be..bbba0d61570fe 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -109,13 +109,14 @@ static void print_boot_time(__u64 nsecs, char *buf, unsigned int size)
 
 static int prog_fd_by_tag(unsigned char *tag)
 {
-	struct bpf_prog_info info = {};
-	__u32 len = sizeof(info);
 	unsigned int id = 0;
 	int err;
 	int fd;
 
 	while (true) {
+		struct bpf_prog_info info = {};
+		__u32 len = sizeof(info);
+
 		err = bpf_prog_get_next_id(id, &id);
 		if (err) {
 			p_err("%s", strerror(errno));
-- 
2.19.1

