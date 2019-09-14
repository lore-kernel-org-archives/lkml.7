Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FB5C49ED7
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 03:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A0320678
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 03:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbfINDHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 23:07:43 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:57564 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728720AbfINDHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 23:07:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0TcH.5Hj_1568430451;
Received: from localhost(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0TcH.5Hj_1568430451)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 14 Sep 2019 11:07:36 +0800
From:   Hui Zhu <teawaterz@linux.alibaba.com>
To:     fengguang.wu@intel.com, linux-kernel@vger.kernel.org
Cc:     Hui Zhu <teawaterz@linux.alibaba.com>
Subject: [PATCH for vm-scalability] usemem: Add new option -Z|--read-again
Date:   Sat, 14 Sep 2019 11:07:18 +0800
Message-Id: <1568430438-31372-1-git-send-email-teawaterz@linux.alibaba.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usemem will read memory again after access the memory with this option.
It can help test the speed that load page from swap to memory.

Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
---
 usemem.c | 46 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/usemem.c b/usemem.c
index 264d52a..2d31946 100644
--- a/usemem.c
+++ b/usemem.c
@@ -94,6 +94,7 @@ int opt_sync_rw = 0;
 int opt_sync_free = 0;
 int opt_bind_interval = 0;
 unsigned long opt_delay = 0;
+int opt_read_again = 0;
 int nr_task;
 int nr_thread;
 int nr_cpu;
@@ -151,6 +152,7 @@ void usage(int ok)
 	"    -e|--delay          delay for each page in ns\n"
 	"    -O|--anonymous      mmap with MAP_ANONYMOUS\n"
 	"    -U|--hugetlb        allocate hugetlbfs page\n"
+	"    -Z|--read-again     read memory again after access the memory\n"
 	"    -h|--help           show this message\n"
 	,		ourname);
 
@@ -188,6 +190,7 @@ static const struct option opts[] = {
 	{ "sync-rw"	, 0, NULL, 'y' },
 	{ "delay"	, 1, NULL, 'e' },
 	{ "hugetlb"	, 0, NULL, 'U' },
+	{ "read-again"	, 0, NULL, 'Z' },
 	{ "help"	, 0, NULL, 'h' },
 	{ NULL		, 0, NULL, 0 }
 };
@@ -616,7 +619,7 @@ unsigned long do_unit(unsigned long bytes, struct drand48_data *rand_data,
 	return rw_bytes;
 }
 
-static void output_statistics(unsigned long unit_bytes)
+static void output_statistics(unsigned long unit_bytes, const char *intro)
 {
 	struct timeval stop;
 	char buf[1024];
@@ -629,8 +632,8 @@ static void output_statistics(unsigned long unit_bytes)
 		(stop.tv_usec - start_time.tv_usec);
 	throughput = ((unit_bytes * 1000000ULL) >> 10) / delta_us;
 	len = snprintf(buf, sizeof(buf),
-			"%lu bytes / %lu usecs = %lu KB/s\n",
-			unit_bytes, delta_us, throughput);
+			"%s%lu bytes / %lu usecs = %lu KB/s\n",
+			intro, unit_bytes, delta_us, throughput);
 	fflush(stdout);
 	write(1, buf, len);
 }
@@ -690,7 +693,34 @@ long do_units(void)
 	} while (bytes);
 
 	if (!opt_write_signal_read && unit_bytes)
-		output_statistics(unit_bytes);
+		output_statistics(unit_bytes, "");
+
+	if (opt_read_again && unit_bytes) {
+		unsigned long rw_bytes = 0;
+
+		gettimeofday(&start_time, NULL);
+		for (i = 0; i < nptr; i++) {
+			int rep;
+
+			for (rep = 0; rep < reps; rep++) {
+				if (rep > 0 && !quiet) {
+					printf(".");
+					fflush(stdout);
+				}
+
+				rw_bytes += do_rw_once(ptrs[i], lens[i], &rand_data, 1, &rep, reps);
+
+				if (msync_mode) {
+					if ((msync(ptrs[i], lens[i], msync_mode)) == -1) {
+						fprintf(stderr, "msync failed with error %s \n", strerror(errno));
+						exit(1);
+					}
+				}
+			}
+		}
+
+		output_statistics(rw_bytes, "read again ");
+	}
 
 	if (opt_write_signal_read) {
 		struct sigaction act;
@@ -731,7 +761,7 @@ long do_units(void)
 		sigsuspend(&set);
 		gettimeofday(&start_time, NULL);
 		unit_bytes = do_rw_once(buffer, opt_bytes, &rand_data, 1, NULL, 0);
-		output_statistics(unit_bytes);
+		output_statistics(unit_bytes, "");
 	}
 
 	if (opt_sync_free)
@@ -879,7 +909,7 @@ int main(int argc, char *argv[])
 	pagesize = getpagesize();
 
 	while ((c = getopt_long(argc, argv,
-				"aAB:f:FPp:gqowRMm:n:t:b:ds:T:Sr:u:j:e:EHDNLWyxOUh", opts, NULL)) != -1)
+				"aAB:f:FPp:gqowRMm:n:t:b:ds:T:Sr:u:j:e:EHDNLWyxOUZh", opts, NULL)) != -1)
 		{
 		switch (c) {
 		case 'a':
@@ -1005,6 +1035,10 @@ int main(int argc, char *argv[])
 			map_hugetlb = MAP_HUGETLB | MAP_HUGE_2MB;
 			break;
 
+		case 'Z':
+			opt_read_again = 1;
+			break;
+
 		default:
 			usage(1);
 		}
-- 
2.7.4

