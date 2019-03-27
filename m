Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7156CC10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4457D2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710053;
	bh=GTA7Ptr39gpWkuCR60H6TJA2ual5e7olQ1OioUopME8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sP3/TQGVGyzZabJC6qXpQnZjzTP0/8qcKhRPbcZUhce3zWbhdXKxCtNVilx6AhnYe
	 tmLbWX+r578H9vUGRV/4cvT+L72/Vzm9hBvxjh6IAZd/K4xX1c+kdZUQuK/s6Qv4Vq
	 8UHRGYXCrodXcCLYwd5af+fbDxaZVNvRGZwPadUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388204AbfC0SHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:07:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388170AbfC0SH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:07:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94D8F21738;
        Wed, 27 Mar 2019 18:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710045;
        bh=GTA7Ptr39gpWkuCR60H6TJA2ual5e7olQ1OioUopME8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fCk4x7mI3aFT6/HOxz8sIyCtuMnEEx0GRPud2gu+sLjQlIj9og3ZsdQU5GIgsrKPG
         PL7wvNTdyx+vJvce+1AHO79jyB6K433QwFOxV6gq4Gr5DwfZbb7U4oB0T2Xo+yp5Ag
         YjmLa0RXyQGGoqw/PvD8znl4a2hP7uED5eTYXXpE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Breno Leitao <leitao@debian.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 172/262] bpf: test_maps: fix possible out of bound access warning
Date:   Wed, 27 Mar 2019 14:00:27 -0400
Message-Id: <20190327180158.10245-172-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Breno Leitao <leitao@debian.org>

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

