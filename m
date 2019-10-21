Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E348CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D42921721
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571646515;
	bh=FIUvS515BRyZWWsbgjwGzMabdeFOcPuhq53HL6bR4Bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0kNMGXHlchmc54ArLDHPUot37Qmy1B8euUGO2hVOcJBQ9oydx+UuZNZupzvIHHwX1
	 EwZTB94gyNfFGQQW2E/JQiMaM94YJ6zc8F7DhKbQSOkMQ8m9ASUG+3QCpkSBF3JBa0
	 H6p3WsJIqmgk4CbBAfmpPs8I20B80/T3y58rZNTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfJUI2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 04:28:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727731AbfJUI2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 04:28:33 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 123D82064A;
        Mon, 21 Oct 2019 08:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571646512;
        bh=FIUvS515BRyZWWsbgjwGzMabdeFOcPuhq53HL6bR4Bk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OSeTWBPV7ypd+9HnmaeOdnzJVqJ+IIjjor3H0jTzS8NvBbww+bMKQMmTMYxHaos5Y
         1xhKoiwEDk/U7N4cqUuxEi4bRjsw//LDW9M/4p3Bp7GuGy/GPDerlsSIwHbHpUW6PL
         IlO0tqmpG6oI9nDozdoQBUpqTtXuyxn9dKdko934=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        jaswinder.singh@linaro.org, Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: [BUGFIX PATCH v2 3/5] selftests: net: Use size_t and ssize_t for counting file size
Date:   Mon, 21 Oct 2019 17:28:27 +0900
Message-Id: <157164650777.17692.4048211617331943317.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157164647813.17692.3834082082658965225.stgit@devnote2>
References: <157164647813.17692.3834082082658965225.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use size_t and ssize_t correctly for counting send file size
instead of unsigned long and long, because long is 32bit on
32bit arch, which is not enough for counting long file size (>4GB).

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: David S. Miller <davem@davemloft.net>
---
 tools/testing/selftests/net/tcp_mmap.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_mmap.c b/tools/testing/selftests/net/tcp_mmap.c
index 31ced79f4f25..33035d1b3f6d 100644
--- a/tools/testing/selftests/net/tcp_mmap.c
+++ b/tools/testing/selftests/net/tcp_mmap.c
@@ -71,7 +71,7 @@
 #define MSG_ZEROCOPY    0x4000000
 #endif
 
-#define FILE_SZ (1UL << 35)
+#define FILE_SZ (1ULL << 35)
 static int cfg_family = AF_INET6;
 static socklen_t cfg_alen = sizeof(struct sockaddr_in6);
 static int cfg_port = 8787;
@@ -155,7 +155,7 @@ void *child_thread(void *arg)
 			socklen_t zc_len = sizeof(zc);
 			int res;
 
-			zc.address = (__u64)addr;
+			zc.address = (__u64)((unsigned long)addr);
 			zc.length = chunk_size;
 			zc.recv_skip_hint = 0;
 			res = getsockopt(fd, IPPROTO_TCP, TCP_ZEROCOPY_RECEIVE,
@@ -302,7 +302,7 @@ int main(int argc, char *argv[])
 {
 	struct sockaddr_storage listenaddr, addr;
 	unsigned int max_pacing_rate = 0;
-	unsigned long total = 0;
+	size_t total = 0;
 	char *host = NULL;
 	int fd, c, on = 1;
 	char *buffer;
@@ -417,7 +417,7 @@ int main(int argc, char *argv[])
 		zflg = 0;
 	}
 	while (total < FILE_SZ) {
-		long wr = FILE_SZ - total;
+		ssize_t wr = FILE_SZ - total;
 
 		if (wr > chunk_size)
 			wr = chunk_size;

