Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C89CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8CA2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413097;
	bh=fCpb523PH5ze2vmTXgxOeONnOMTgzT1g5WAb2NGe/3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LgAMuk2pR8kFQkHetAbRpbAnHlQ6Tk1hwpdSY1FbmUnHa6C6RL3QLKoP2yLGQfPdN
	 aUQweB2eCLfppCYCItW8UN47xnea27WQ16ipFqT3vWD1v8fKMjYNz9PdS1SUcERrRM
	 UOASGA7e3qWLPuVV44iLkreCwGrygtu5bPM9hPcg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbfCLRvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:51:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728399AbfCLROd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:14:33 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E75E21741;
        Tue, 12 Mar 2019 17:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410872;
        bh=fCpb523PH5ze2vmTXgxOeONnOMTgzT1g5WAb2NGe/3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lf0DVKoz5sQ+J8T3u8T6KFyGXPBAES90sevn3sJ9CcGZVqvv6cXsc9urZ4QZpwNar
         /vDcq9pNJtSLCSS9+5Nu6rpP5frgFTBZvE6ZUyKVt4kJYNEkpYG1t9JFJy5jezdjEh
         ihaHaoYljqVxIJZoLKc6WPRy7gMnwpbGzlYO59Nw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lance Digby <ldigby@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 074/149] bpftool: Fix prog dump by tag
Date:   Tue, 12 Mar 2019 10:08:12 -0700
Message-Id: <20190312170355.818860573@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 0de024a6cc2b..bbba0d61570f 100644
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



