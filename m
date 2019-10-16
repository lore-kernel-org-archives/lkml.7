Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D93FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EAB020872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263363;
	bh=ISLKsaq/FqtvBASq4WxtSQF4p5xLaOZAWFmz4fOgPG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rBnlaGEBPxvC+1zunuf/bxcfXPsaXGOmH8IYIDvtVIaEXvTYg8ek9JUQx3LUQEc8P
	 hCLNqT7+ogXKE52owTSac52RNIjp9/oGw8ISk3hkxmA0PpamKchcoi5VjhsqHoX4PF
	 5D1Zkp/ykwphSVfWymykGmqd4CchzTUykhAuczK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439028AbfJPWCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:02:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438572AbfJPV7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:59:38 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C63121D7E;
        Wed, 16 Oct 2019 21:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263177;
        bh=ISLKsaq/FqtvBASq4WxtSQF4p5xLaOZAWFmz4fOgPG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YWLt+QWCftWkKUxJlwf8PzDyDyMWRCsD2Kb0PsxJ896U7vYC/U4vM5F/prRparhFF
         b+nyY7HzMW+InWwkJOBCzp4xk2Qpb3smUgMkn2kVoLBe+o36Du9Q/jLsHVDyIuJ3Wj
         5gX8gHfxnPqReDamIPezCG9DjENDgk2mZK557yoE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 5.3 105/112] ftrace: Get a reference counter for the trace_array on filter files
Date:   Wed, 16 Oct 2019 14:51:37 -0700
Message-Id: <20191016214907.043942126@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214844.038848564@linuxfoundation.org>
References: <20191016214844.038848564@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit 9ef16693aff8137faa21d16ffe65bb9832d24d71 upstream.

The ftrace set_ftrace_filter and set_ftrace_notrace files are specific for
an instance now. They need to take a reference to the instance otherwise
there could be a race between accessing the files and deleting the instance.

It wasn't until the :mod: caching where these file operations started
referencing the trace_array directly.

Cc: stable@vger.kernel.org
Fixes: 673feb9d76ab3 ("ftrace: Add :mod: caching infrastructure to trace_array")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/ftrace.c |   27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3540,21 +3540,22 @@ ftrace_regex_open(struct ftrace_ops *ops
 	struct ftrace_hash *hash;
 	struct list_head *mod_head;
 	struct trace_array *tr = ops->private;
-	int ret = 0;
+	int ret = -ENOMEM;
 
 	ftrace_ops_init(ops);
 
 	if (unlikely(ftrace_disabled))
 		return -ENODEV;
 
+	if (tr && trace_array_get(tr) < 0)
+		return -ENODEV;
+
 	iter = kzalloc(sizeof(*iter), GFP_KERNEL);
 	if (!iter)
-		return -ENOMEM;
+		goto out;
 
-	if (trace_parser_get_init(&iter->parser, FTRACE_BUFF_MAX)) {
-		kfree(iter);
-		return -ENOMEM;
-	}
+	if (trace_parser_get_init(&iter->parser, FTRACE_BUFF_MAX))
+		goto out;
 
 	iter->ops = ops;
 	iter->flags = flag;
@@ -3584,13 +3585,13 @@ ftrace_regex_open(struct ftrace_ops *ops
 
 		if (!iter->hash) {
 			trace_parser_put(&iter->parser);
-			kfree(iter);
-			ret = -ENOMEM;
 			goto out_unlock;
 		}
 	} else
 		iter->hash = hash;
 
+	ret = 0;
+
 	if (file->f_mode & FMODE_READ) {
 		iter->pg = ftrace_pages_start;
 
@@ -3602,7 +3603,6 @@ ftrace_regex_open(struct ftrace_ops *ops
 			/* Failed */
 			free_ftrace_hash(iter->hash);
 			trace_parser_put(&iter->parser);
-			kfree(iter);
 		}
 	} else
 		file->private_data = iter;
@@ -3610,6 +3610,13 @@ ftrace_regex_open(struct ftrace_ops *ops
  out_unlock:
 	mutex_unlock(&ops->func_hash->regex_lock);
 
+ out:
+	if (ret) {
+		kfree(iter);
+		if (tr)
+			trace_array_put(tr);
+	}
+
 	return ret;
 }
 
@@ -5037,6 +5044,8 @@ int ftrace_regex_release(struct inode *i
 
 	mutex_unlock(&iter->ops->func_hash->regex_lock);
 	free_ftrace_hash(iter->hash);
+	if (iter->tr)
+		trace_array_put(iter->tr);
 	kfree(iter);
 
 	return 0;


