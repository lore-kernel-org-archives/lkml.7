Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99492C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60BF120842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551802336;
	bh=VyxlFOHWEBGp50g+Djc6qvIaA6Xp+Rsq6/BLXFESN9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=1NpMY/RG3bLPhhTH43Wp4PH0NnF/1et+FnHSt54OJ0IZjRtSATgyauAph+QhsCm/t
	 bhKQiBLiieD+tRIaUGMuLE3mhf6e1E6EQ30qchvRUZfM0vE1JHnyw3pgzYYWYIEExQ
	 zja6sJjHm5yB0EYwERmdyLzeFnfLWVv9HAKD7XGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfCEQMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 11:12:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:40308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbfCEQMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 11:12:08 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D24A2087C;
        Tue,  5 Mar 2019 16:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551802327;
        bh=VyxlFOHWEBGp50g+Djc6qvIaA6Xp+Rsq6/BLXFESN9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=HtxrFjOD0+lGMQZfhobLo7ctdPlJ6xxz5k1obUurGcPmJj60flLG4oG+4rVm9eKXG
         OiHAijy0dXBrqfQvidjGgeDf2kDW0QkrdJkYpgm1U/xGbW04t9N25JB89WQkvOffYX
         5wO9lkjIlUL588mEWk7CzLXje3XS7lMlvzlh2pa0=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] tracing: Use strncpy instead of memcpy when copying comm for hist triggers
Date:   Tue,  5 Mar 2019 10:11:59 -0600
Message-Id: <1eb9f096a8086c3c82c7fc087c900005143cec54.1551802084.git.tom.zanussi@linux.intel.com>
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
---
 kernel/trace/trace_events_hist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index c7774fa119a7..ca46339f3009 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2141,7 +2141,7 @@ static inline void save_comm(char *comm, struct task_struct *task)
 		return;
 	}
 
-	memcpy(comm, task->comm, TASK_COMM_LEN);
+	strncpy(comm, task->comm, TASK_COMM_LEN);
 }
 
 static void hist_elt_data_free(struct hist_elt_data *elt_data)
@@ -3557,7 +3557,7 @@ static bool cond_snapshot_update(struct trace_array *tr, void *cond_data)
 	elt_data = context->elt->private_data;
 	track_elt_data = track_data->elt.private_data;
 	if (elt_data->comm)
-		memcpy(track_elt_data->comm, elt_data->comm, TASK_COMM_LEN);
+		strncpy(track_elt_data->comm, elt_data->comm, TASK_COMM_LEN);
 
 	track_data->updated = true;
 
-- 
2.14.1

