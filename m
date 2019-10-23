Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EABECA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 04:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2545221920
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 04:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571806693;
	bh=84/HqT9rjw/ELPe/YzzmH2eHPW0t/8HjIohY6R+znnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mjSFpahBFI0RwEDnROOXrFkgDuGgSvkf620A67dlfVE+24hnnm3DF2YXAW7h2qucZ
	 y5rpjWqHlYn3q61hL6jNFy7N2jp4mNdB+qlFWid8X48r0xx1Gk0vk4oqCRNZRhYX5Y
	 30E9pqZFfoexD/TUTGwAVWOO4HxbcFWsJOHyVHxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388815AbfJWE6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 00:58:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731908AbfJWE6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 00:58:11 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C862421906;
        Wed, 23 Oct 2019 04:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571806690;
        bh=84/HqT9rjw/ELPe/YzzmH2eHPW0t/8HjIohY6R+znnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ASP9CX0TD3l1KfGzBHrNI6gFvGaDEe3CVNIgGcf+YLsPA5gnzZsff6heK1yV2ByPS
         qO9DBFmk5jd1b55txsNUhIMI1oJPnA/VQDv4MVti3dngYs3s/xyq3GU963b8W+R73/
         BEG4qFgCb3mcqPJB3wSvSuC1r0IVk0doe2SjQ2gE=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        jaswinder.singh@linaro.org, Willem de Bruijn <willemb@google.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: [BUGFIX PATCH v3 4/5] selftests: net: Fix printf format warnings on arm
Date:   Wed, 23 Oct 2019 13:58:07 +0900
Message-Id: <157180668734.17298.5861111176598936.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157180665007.17298.907392422924029261.stgit@devnote2>
References: <157180665007.17298.907392422924029261.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix printf format warnings on arm (and other 32bit arch).

 - udpgso.c and udpgso_bench_tx use %lu for size_t but it
   should be unsigned long long on 32bit arch.

 - so_txtime.c uses %ld for int64_t, but it should be
   unsigned long long on 32bit arch.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>
Cc: David S. Miller <davem@davemloft.net>
---
 tools/testing/selftests/net/so_txtime.c       |    4 ++--
 tools/testing/selftests/net/udpgso.c          |    3 ++-
 tools/testing/selftests/net/udpgso_bench_tx.c |    3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/so_txtime.c b/tools/testing/selftests/net/so_txtime.c
index 53f598f06647..34df4c8882af 100644
--- a/tools/testing/selftests/net/so_txtime.c
+++ b/tools/testing/selftests/net/so_txtime.c
@@ -105,8 +105,8 @@ static void do_recv_one(int fdr, struct timed_send *ts)
 	tstop = (gettime_ns() - glob_tstart) / 1000;
 	texpect = ts->delay_us >= 0 ? ts->delay_us : 0;
 
-	fprintf(stderr, "payload:%c delay:%ld expected:%ld (us)\n",
-			rbuf[0], tstop, texpect);
+	fprintf(stderr, "payload:%c delay:%lld expected:%lld (us)\n",
+			rbuf[0], (long long)tstop, (long long)texpect);
 
 	if (rbuf[0] != ts->data)
 		error(1, 0, "payload mismatch. expected %c", ts->data);
diff --git a/tools/testing/selftests/net/udpgso.c b/tools/testing/selftests/net/udpgso.c
index b8265ee9923f..cab334e51ac1 100644
--- a/tools/testing/selftests/net/udpgso.c
+++ b/tools/testing/selftests/net/udpgso.c
@@ -448,7 +448,8 @@ static bool __send_one(int fd, struct msghdr *msg, int flags)
 	if (ret == -1)
 		error(1, errno, "sendmsg");
 	if (ret != msg->msg_iov->iov_len)
-		error(1, 0, "sendto: %d != %lu", ret, msg->msg_iov->iov_len);
+		error(1, 0, "sendto: %d != %llu", ret,
+			(unsigned long long)msg->msg_iov->iov_len);
 	if (msg->msg_flags)
 		error(1, 0, "sendmsg: return flags 0x%x\n", msg->msg_flags);
 
diff --git a/tools/testing/selftests/net/udpgso_bench_tx.c b/tools/testing/selftests/net/udpgso_bench_tx.c
index ada99496634a..17512a43885e 100644
--- a/tools/testing/selftests/net/udpgso_bench_tx.c
+++ b/tools/testing/selftests/net/udpgso_bench_tx.c
@@ -405,7 +405,8 @@ static int send_udp_segment(int fd, char *data)
 	if (ret == -1)
 		error(1, errno, "sendmsg");
 	if (ret != iov.iov_len)
-		error(1, 0, "sendmsg: %u != %lu\n", ret, iov.iov_len);
+		error(1, 0, "sendmsg: %u != %llu\n", ret,
+			(unsigned long long)iov.iov_len);
 
 	return 1;
 }

