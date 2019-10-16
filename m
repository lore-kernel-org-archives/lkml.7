Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1FBFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3F821D7C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571262842;
	bh=XzCMom3IC3SYUResNnRRzR+p0658IoGw/WlSDIjtbrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GY7H+/4LSh3T+/11jrkvxUsuU3KDdRp8oXHkVImgJYbZqROIc2cUJvrRqNGLNwe4S
	 HaAZE1LKbkMMITs/Kuurir4xER1cNSGJNY6QztdWen+61vctlYAZU64Ht9pYdc0784
	 bPzqG8wnGqFXkVOqyxvIc6l9RZkmZkEfpDbTZ4H4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437641AbfJPVyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:54:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437591AbfJPVxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:53:54 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 047A0218DE;
        Wed, 16 Oct 2019 21:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262834;
        bh=XzCMom3IC3SYUResNnRRzR+p0658IoGw/WlSDIjtbrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0PcJ/0cXyoBYt/fznVeFZNdqAlhBmyge0+wIDWmMSO5BZ0mv5ooaoYlO6GjXWz2Lv
         rQ5KCgO6ikCl2NUvvIw4ZzPZR477xGsNdhv/GG+Tx5jhSIDhlVu7tAuvEcZfMvjr46
         ta0cisCyeeKR/Obg0ahfNR825eZ/ggx06CzRmIh0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.4 77/79] tracing: Get trace_array reference for available_tracers files
Date:   Wed, 16 Oct 2019 14:50:52 -0700
Message-Id: <20191016214834.008090257@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214729.758892904@linuxfoundation.org>
References: <20191016214729.758892904@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit 194c2c74f5532e62c218adeb8e2b683119503907 upstream.

As instances may have different tracers available, we need to look at the
trace_array descriptor that shows the list of the available tracers for the
instance. But there's a race between opening the file and an admin
deleting the instance. The trace_array_get() needs to be called before
accessing the trace_array.

Cc: stable@vger.kernel.org
Fixes: 607e2ea167e56 ("tracing: Set up infrastructure to allow tracers for instances")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3370,9 +3370,14 @@ static int show_traces_open(struct inode
 	if (tracing_disabled)
 		return -ENODEV;
 
+	if (trace_array_get(tr) < 0)
+		return -ENODEV;
+
 	ret = seq_open(file, &show_traces_seq_ops);
-	if (ret)
+	if (ret) {
+		trace_array_put(tr);
 		return ret;
+	}
 
 	m = file->private_data;
 	m->private = tr;
@@ -3380,6 +3385,14 @@ static int show_traces_open(struct inode
 	return 0;
 }
 
+static int show_traces_release(struct inode *inode, struct file *file)
+{
+	struct trace_array *tr = inode->i_private;
+
+	trace_array_put(tr);
+	return seq_release(inode, file);
+}
+
 static ssize_t
 tracing_write_stub(struct file *filp, const char __user *ubuf,
 		   size_t count, loff_t *ppos)
@@ -3410,8 +3423,8 @@ static const struct file_operations trac
 static const struct file_operations show_traces_fops = {
 	.open		= show_traces_open,
 	.read		= seq_read,
-	.release	= seq_release,
 	.llseek		= seq_lseek,
+	.release	= show_traces_release,
 };
 
 static ssize_t


