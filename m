Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FA1C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B492173E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564149696;
	bh=1ofDutkPAFgTLkAURQrmdDCTNx3xjwx3nQ0nwzX4mNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vulHWK03e81cTyJnXv11GXl4q0vfF07qmIidtrGdGwXuLrXCZZLHJK6Y1Yq6oA2TH
	 FGS+O8O8klRLXccONQF+a990B0zMgDDym2VZ2wqMPAbppYyKFK3v5gawn+LXSBkhCD
	 3wLRRsGyJ6Br50XxGhK1od2YtZyqWu9SfzIQAgUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388859AbfGZOBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:01:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfGZNjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:39:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FDB122BE8;
        Fri, 26 Jul 2019 13:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148383;
        bh=1ofDutkPAFgTLkAURQrmdDCTNx3xjwx3nQ0nwzX4mNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IatUFmCXoXWxHDjnxh0YG5/K+Q76OhPUSVFI0EytX3SXqsoYzfUrozH71S2DknvBY
         6uQ9OX6nON4LvVL9QySfiyD8O6fhk5fMhaMLcErWTXOxYYx+b9lUbh3G7OrPA31mXe
         gRg7ePPOQabLQ2hobQEXB2MubirQbCKXehluP4YM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Cheng Jian <cj.chengjian@huawei.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 06/85] ftrace: Enable trampoline when rec count returns back to one
Date:   Fri, 26 Jul 2019 09:38:16 -0400
Message-Id: <20190726133936.11177-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726133936.11177-1-sashal@kernel.org>
References: <20190726133936.11177-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cheng Jian <cj.chengjian@huawei.com>

[ Upstream commit a124692b698b00026a58d89831ceda2331b2e1d0 ]

Custom trampolines can only be enabled if there is only a single ops
attached to it. If there's only a single callback registered to a function,
and the ops has a trampoline registered for it, then we can call the
trampoline directly. This is very useful for improving the performance of
ftrace and livepatch.

If more than one callback is registered to a function, the general
trampoline is used, and the custom trampoline is not restored back to the
direct call even if all the other callbacks were unregistered and we are
back to one callback for the function.

To fix this, set FTRACE_FL_TRAMP flag if rec count is decremented
to one, and the ops that left has a trampoline.

Testing After this patch :

insmod livepatch_unshare_files.ko
cat /sys/kernel/debug/tracing/enabled_functions

	unshare_files (1) R I	tramp: 0xffffffffc0000000(klp_ftrace_handler+0x0/0xa0) ->ftrace_ops_assist_func+0x0/0xf0

echo unshare_files > /sys/kernel/debug/tracing/set_ftrace_filter
echo function > /sys/kernel/debug/tracing/current_tracer
cat /sys/kernel/debug/tracing/enabled_functions

	unshare_files (2) R I ->ftrace_ops_list_func+0x0/0x150

echo nop > /sys/kernel/debug/tracing/current_tracer
cat /sys/kernel/debug/tracing/enabled_functions

	unshare_files (1) R I	tramp: 0xffffffffc0000000(klp_ftrace_handler+0x0/0xa0) ->ftrace_ops_assist_func+0x0/0xf0

Link: http://lkml.kernel.org/r/1556969979-111047-1-git-send-email-cj.chengjian@huawei.com

Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ftrace.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 576c41644e77..208220d526e8 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1622,6 +1622,11 @@ static bool test_rec_ops_needs_regs(struct dyn_ftrace *rec)
 	return  keep_regs;
 }
 
+static struct ftrace_ops *
+ftrace_find_tramp_ops_any(struct dyn_ftrace *rec);
+static struct ftrace_ops *
+ftrace_find_tramp_ops_next(struct dyn_ftrace *rec, struct ftrace_ops *ops);
+
 static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
 				     int filter_hash,
 				     bool inc)
@@ -1750,15 +1755,17 @@ static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
 			}
 
 			/*
-			 * If the rec had TRAMP enabled, then it needs to
-			 * be cleared. As TRAMP can only be enabled iff
-			 * there is only a single ops attached to it.
-			 * In otherwords, always disable it on decrementing.
-			 * In the future, we may set it if rec count is
-			 * decremented to one, and the ops that is left
-			 * has a trampoline.
+			 * The TRAMP needs to be set only if rec count
+			 * is decremented to one, and the ops that is
+			 * left has a trampoline. As TRAMP can only be
+			 * enabled if there is only a single ops attached
+			 * to it.
 			 */
-			rec->flags &= ~FTRACE_FL_TRAMP;
+			if (ftrace_rec_count(rec) == 1 &&
+			    ftrace_find_tramp_ops_any(rec))
+				rec->flags |= FTRACE_FL_TRAMP;
+			else
+				rec->flags &= ~FTRACE_FL_TRAMP;
 
 			/*
 			 * flags will be cleared in ftrace_check_record()
@@ -1951,11 +1958,6 @@ static void print_ip_ins(const char *fmt, const unsigned char *p)
 		printk(KERN_CONT "%s%02x", i ? ":" : "", p[i]);
 }
 
-static struct ftrace_ops *
-ftrace_find_tramp_ops_any(struct dyn_ftrace *rec);
-static struct ftrace_ops *
-ftrace_find_tramp_ops_next(struct dyn_ftrace *rec, struct ftrace_ops *ops);
-
 enum ftrace_bug_type ftrace_bug_type;
 const void *ftrace_expected;
 
-- 
2.20.1

