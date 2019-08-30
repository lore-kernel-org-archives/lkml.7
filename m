Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F8FC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 20:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83AA323439
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 20:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbfH3UrJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 16:47:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728079AbfH3UrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 16:47:09 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1104523439;
        Fri, 30 Aug 2019 20:47:07 +0000 (UTC)
Date:   Fri, 30 Aug 2019 16:47:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] ftrace: Fix NULL pointer dereference in
 t_probe_next()
Message-ID: <20190830164706.453a119e@gandalf.local.home>
In-Reply-To: <05e021f757625cbbb006fad41380323dbe4e3b43.1562249521.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1562249521.git.naveen.n.rao@linux.vnet.ibm.com>
        <05e021f757625cbbb006fad41380323dbe4e3b43.1562249521.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  4 Jul 2019 20:04:41 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:


>  kernel/trace/ftrace.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 7b037295a1f1..0791eafb693d 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -3093,6 +3093,10 @@ t_probe_next(struct seq_file *m, loff_t *pos)
>  		hnd = &iter->probe_entry->hlist;
>  
>  	hash = iter->probe->ops.func_hash->filter_hash;
> +
> +	if (!hash)
> +		return NULL;
> +
>  	size = 1 << hash->size_bits;
>  
>   retry:

OK, I added this, but I'm also adding this on top:

-- Steve

From 372e0d01da71c84dcecf7028598a33813b0d5256 Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Date: Fri, 30 Aug 2019 16:30:01 -0400
Subject: [PATCH] ftrace: Check for empty hash and comment the race with
 registering probes

The race between adding a function probe and reading the probes that exist
is very subtle. It needs a comment. Also, the issue can also happen if the
probe has has the EMPTY_HASH as its func_hash.

Cc: stable@vger.kernel.org
Fixes: 7b60f3d876156 ("ftrace: Dynamically create the probe ftrace_ops for the trace_array")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 80beed2cf0da..6200a6fe10e3 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3096,7 +3096,11 @@ t_probe_next(struct seq_file *m, loff_t *pos)
 
 	hash = iter->probe->ops.func_hash->filter_hash;
 
-	if (!hash)
+	/*
+	 * A probe being registered may temporarily have an empty hash
+	 * and it's at the end of the func_probes list.
+	 */
+	if (!hash || hash == EMPTY_HASH)
 		return NULL;
 
 	size = 1 << hash->size_bits;
@@ -4324,6 +4328,10 @@ register_ftrace_function_probe(char *glob, struct trace_array *tr,
 
 	mutex_unlock(&ftrace_lock);
 
+	/*
+	 * Note, there's a small window here that the func_hash->filter_hash
+	 * may be NULL or empty. Need to be carefule when reading the loop.
+	 */
 	mutex_lock(&probe->ops.func_hash->regex_lock);
 
 	orig_hash = &probe->ops.func_hash->filter_hash;
-- 
2.20.1

