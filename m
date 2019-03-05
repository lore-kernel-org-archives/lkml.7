Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3F7C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A5A208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551802334;
	bh=kMyvZn/EeojJXgkRvBvUeq4iRMH9ghlPFbl/FskKIIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=ot03XrDuuu43rBXjBUgE1p4yPKcFPKg+weHw/QJCx9t/lK+VucLk9yO4u0xv19XX0
	 mkm3jhm7xdL4J60R7kl7yQ6ajZtp5rV3D5pebKcwi+Hss2VT5xku7Pv4HTtguUV9vA
	 BqEFILEmdEUzIcuNzZWsa0W2ZwifrfNm1NktRJWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfCEQMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 11:12:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:40382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbfCEQMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 11:12:09 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0349D2171F;
        Tue,  5 Mar 2019 16:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551802329;
        bh=kMyvZn/EeojJXgkRvBvUeq4iRMH9ghlPFbl/FskKIIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=EObyEvXWQrEWaTF5kGTaly7COdu/ra7o60ix+Y0kjw+gCST6jOTMZZv4CLSdtdET+
         mBhbg3B1x6gdnJ8MEoXQ5zbrrrjFoqWIEbTY/appWiA1QSJbKOsZMX4sRQrpTXZf9u
         jBrgwCsiLf63QNMeSK2r7YLpqNOO66mEV8+2d1Bc=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] tracing: Use strncpy instead of memcpy when copying comm in trace.c
Date:   Tue,  5 Mar 2019 10:12:00 -0600
Message-Id: <1d6ebac26570c2a29ce9fb575379f17ef5c8b81b.1551802084.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1551802084.git.tom.zanussi@linux.intel.com>
References: <cover.1551802084.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1551802084.git.tom.zanussi@linux.intel.com>
References: <cover.1551802084.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Because there may be random garbage beyond a string's null terminator,
code that might use the entire comm array e.g. histogram keys, can
give unexpected results if that garbage is copied in too, so avoid
that possibility by using strncpy instead of memcpy.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 3835f7ed3293..e9cc47e59d25 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1497,7 +1497,7 @@ __update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
 	max_data->critical_start = data->critical_start;
 	max_data->critical_end = data->critical_end;
 
-	memcpy(max_data->comm, tsk->comm, TASK_COMM_LEN);
+	strncpy(max_data->comm, tsk->comm, TASK_COMM_LEN);
 	max_data->pid = tsk->pid;
 	/*
 	 * If tsk == current, then use current_uid(), as that does not use
@@ -1923,7 +1923,7 @@ static inline char *get_saved_cmdlines(int idx)
 
 static inline void set_cmdline(int idx, const char *cmdline)
 {
-	memcpy(get_saved_cmdlines(idx), cmdline, TASK_COMM_LEN);
+	strncpy(get_saved_cmdlines(idx), cmdline, TASK_COMM_LEN);
 }
 
 static int allocate_cmdlines_buffer(unsigned int val,
-- 
2.14.1

