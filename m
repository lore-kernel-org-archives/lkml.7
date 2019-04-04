Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D277C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2059A20657
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369815;
	bh=0JpbzZ5OZTi7bBMMQPRUaN0JZRBYkIRJJpyGlawl5KA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nrYs8Ats3TMNsTRpVw1hLXaFb5OH5G4mAfX1jmvxYw55ChG8Yb/QIelen6lMlrmYQ
	 EL89aDLQXjVQ3ftByn4xCrB03qdi85S/aSz/1VKSbL4+8RYfumkKDIND6vW5NXFxY6
	 NX21S7tolYSYlGC40EaZ8iMz2J7K4a1e/ynEvbBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387842AbfDDJPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:15:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387832AbfDDJPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:15:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E35C2054F;
        Thu,  4 Apr 2019 09:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369310;
        bh=0JpbzZ5OZTi7bBMMQPRUaN0JZRBYkIRJJpyGlawl5KA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HBuCQ2MaDk2OGRY3R+YWU1VGjCahl/I1cSNxtNUoN5wpg/JAbttrGSxmG7SAxO0un
         g2ZXjJKQBEl4naWhWuSbN5o/LR8zO/z1sUCZX0IM50kGM8n6xekWvoxi33sQ6xec1a
         qehymRIPfjbgCSWkRpBmpOPtygsFuqKxdXeGfNQs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Breno Leitao <leitao@debian.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 162/246] bpf: test_maps: fix possible out of bound access warning
Date:   Thu,  4 Apr 2019 10:47:42 +0200
Message-Id: <20190404084624.842889958@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

[ Upstream commit dd9cef43c222df7c0d76d34451808e789952379d ]

When compiling test_maps selftest with GCC-8, it warns that an array
might be indexed with a negative value, which could cause a negative
out of bound access, depending on parameters of the function. This
is the GCC-8 warning:

	gcc -Wall -O2 -I../../../include/uapi -I../../../lib -I../../../lib/bpf -I../../../../include/generated -DHAVE_GENHDR -I../../../include    test_maps.c /home/breno/Devel/linux/tools/testing/selftests/bpf/libbpf.a -lcap -lelf -lrt -lpthread -o /home/breno/Devel/linux/tools/testing/selftests/bpf/test_maps
	In file included from test_maps.c:16:
	test_maps.c: In function ‘run_all_tests’:
	test_maps.c:1079:10: warning: array subscript -1 is below array bounds of ‘pid_t[<Ube20> + 1]’ [-Warray-bounds]
	   assert(waitpid(pid[i], &status, 0) == pid[i]);
		  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
	test_maps.c:1059:6: warning: array subscript -1 is below array bounds of ‘pid_t[<Ube20> + 1]’ [-Warray-bounds]
	   pid[i] = fork();
	   ~~~^~~

This patch simply guarantees that the task(s) variables are unsigned,
thus, they could never be a negative number (which they are not in
current code anyway), hence avoiding an out of bound access warning.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/test_maps.c | 27 +++++++++++++------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index e2b9eee37187..6e05a22b346c 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -43,7 +43,7 @@ static int map_flags;
 	}								\
 })
 
-static void test_hashmap(int task, void *data)
+static void test_hashmap(unsigned int task, void *data)
 {
 	long long key, next_key, first_key, value;
 	int fd;
@@ -133,7 +133,7 @@ static void test_hashmap(int task, void *data)
 	close(fd);
 }
 
-static void test_hashmap_sizes(int task, void *data)
+static void test_hashmap_sizes(unsigned int task, void *data)
 {
 	int fd, i, j;
 
@@ -153,7 +153,7 @@ static void test_hashmap_sizes(int task, void *data)
 		}
 }
 
-static void test_hashmap_percpu(int task, void *data)
+static void test_hashmap_percpu(unsigned int task, void *data)
 {
 	unsigned int nr_cpus = bpf_num_possible_cpus();
 	BPF_DECLARE_PERCPU(long, value);
@@ -280,7 +280,7 @@ static int helper_fill_hashmap(int max_entries)
 	return fd;
 }
 
-static void test_hashmap_walk(int task, void *data)
+static void test_hashmap_walk(unsigned int task, void *data)
 {
 	int fd, i, max_entries = 1000;
 	long long key, value, next_key;
@@ -351,7 +351,7 @@ static void test_hashmap_zero_seed(void)
 	close(second);
 }
 
-static void test_arraymap(int task, void *data)
+static void test_arraymap(unsigned int task, void *data)
 {
 	int key, next_key, fd;
 	long long value;
@@ -406,7 +406,7 @@ static void test_arraymap(int task, void *data)
 	close(fd);
 }
 
-static void test_arraymap_percpu(int task, void *data)
+static void test_arraymap_percpu(unsigned int task, void *data)
 {
 	unsigned int nr_cpus = bpf_num_possible_cpus();
 	BPF_DECLARE_PERCPU(long, values);
@@ -502,7 +502,7 @@ static void test_arraymap_percpu_many_keys(void)
 	close(fd);
 }
 
-static void test_devmap(int task, void *data)
+static void test_devmap(unsigned int task, void *data)
 {
 	int fd;
 	__u32 key, value;
@@ -517,7 +517,7 @@ static void test_devmap(int task, void *data)
 	close(fd);
 }
 
-static void test_queuemap(int task, void *data)
+static void test_queuemap(unsigned int task, void *data)
 {
 	const int MAP_SIZE = 32;
 	__u32 vals[MAP_SIZE + MAP_SIZE/2], val;
@@ -575,7 +575,7 @@ static void test_queuemap(int task, void *data)
 	close(fd);
 }
 
-static void test_stackmap(int task, void *data)
+static void test_stackmap(unsigned int task, void *data)
 {
 	const int MAP_SIZE = 32;
 	__u32 vals[MAP_SIZE + MAP_SIZE/2], val;
@@ -641,7 +641,7 @@ static void test_stackmap(int task, void *data)
 #define SOCKMAP_PARSE_PROG "./sockmap_parse_prog.o"
 #define SOCKMAP_VERDICT_PROG "./sockmap_verdict_prog.o"
 #define SOCKMAP_TCP_MSG_PROG "./sockmap_tcp_msg_prog.o"
-static void test_sockmap(int tasks, void *data)
+static void test_sockmap(unsigned int tasks, void *data)
 {
 	struct bpf_map *bpf_map_rx, *bpf_map_tx, *bpf_map_msg, *bpf_map_break;
 	int map_fd_msg = 0, map_fd_rx = 0, map_fd_tx = 0, map_fd_break;
@@ -1258,10 +1258,11 @@ static void test_map_large(void)
 }
 
 #define run_parallel(N, FN, DATA) \
-	printf("Fork %d tasks to '" #FN "'\n", N); \
+	printf("Fork %u tasks to '" #FN "'\n", N); \
 	__run_parallel(N, FN, DATA)
 
-static void __run_parallel(int tasks, void (*fn)(int task, void *data),
+static void __run_parallel(unsigned int tasks,
+			   void (*fn)(unsigned int task, void *data),
 			   void *data)
 {
 	pid_t pid[tasks];
@@ -1302,7 +1303,7 @@ static void test_map_stress(void)
 #define DO_UPDATE 1
 #define DO_DELETE 0
 
-static void test_update_delete(int fn, void *data)
+static void test_update_delete(unsigned int fn, void *data)
 {
 	int do_update = ((int *)data)[1];
 	int fd = ((int *)data)[0];
-- 
2.19.1



