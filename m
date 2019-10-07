Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FB5ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972522070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570461053;
	bh=FIUvS515BRyZWWsbgjwGzMabdeFOcPuhq53HL6bR4Bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nIMWNvvE5VOODiVFq1YBSN/126+YKTLk42Tr+Hl5fyBubmDuQdQ6vwaEpFTsakD4F
	 +l1rFuqHSgvSl1y/jLygBxDXuE+sXRDUgnBhxXQw57KJRxgwGi5UjrbOhod8PtKIdh
	 7QCu47tRbGgbGos4yT3TZyB+LhJg1E2w4ZrbuJSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbfJGPKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:10:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbfJGPKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:10:51 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B72ED2070B;
        Mon,  7 Oct 2019 15:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570461050;
        bh=FIUvS515BRyZWWsbgjwGzMabdeFOcPuhq53HL6bR4Bk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FRmNryRQEJ7cqOuMLYqnj3fakuyXTQjkXrRFklSczVw8sNMLx6mTpun3s+zPhdmZG
         y4wmcn+OMIqE5RHl6X/ENa+uU/zcy34t9AYLy8QNlRSQLCaF3bHSGax7N1TX8gJUoj
         CZI7bcVSjH74fw3VabpUlilxjtXfasRrH+na6gdc=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        jaswinder.singh@linaro.org, Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: [BUGFIX PATCH 3/5] selftests: net: Use size_t and ssize_t for counting file size
Date:   Tue,  8 Oct 2019 00:10:45 +0900
Message-Id: <157046104535.20724.6659308145965966926.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157046101671.20724.9561877942986463668.stgit@devnote2>
References: <157046101671.20724.9561877942986463668.stgit@devnote2>
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

