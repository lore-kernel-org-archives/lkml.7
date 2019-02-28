Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEACCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD0C218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366526;
	bh=6iG/VbiZpTdhS3dHGwtEBdHHNgkACqy6Z/1mLrJxjYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1S2wxfpX95te9MBkyPLL+vNMNFcdT1iooYvk04PUwXs82UmtAm7uwv3u4XmJ3JfdI
	 IGjjYzPKdzRpzTz39K8GR75m4yeAEMdFpR0Z/XHg0HVNpTNWV6r/Orwhn3DLKlxfQk
	 +QMdRm1F+8ziAMp5hf4v4z4TSEF4/PaJIsZWkoic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733083AbfB1PIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:08:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:40958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733032AbfB1PIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:08:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DF94218AE;
        Thu, 28 Feb 2019 15:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366518;
        bh=6iG/VbiZpTdhS3dHGwtEBdHHNgkACqy6Z/1mLrJxjYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gqS9NHOdFShioEVbVL4gA4iNRQmCOexiluiQRTo4w/XZQZDfuMhoxl/7hnRsqjvaS
         eMfdBqM5JJlo0oQVsP8ZPV6vTZlA8g0gdrpuj9MV4sAfwwyDa5dAMw7eGJlUX5dyli
         1zqx6mdSrmsePag6pQ9o//fJK0Dztx6tcSu5NMlQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 15/81] bpftool: Fix prog dump by tag
Date:   Thu, 28 Feb 2019 10:07:07 -0500
Message-Id: <20190228150813.10256-15-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
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
index 69b01a6158bdd..91b9de5f4e17e 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -130,13 +130,14 @@ static void print_boot_time(__u64 nsecs, char *buf, unsigned int size)
 
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

