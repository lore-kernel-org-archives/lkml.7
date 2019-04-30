Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF9CC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB4F2177B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556624665;
	bh=BMQhf59ngHxcrEisMnwNzHCcj0mMR5dhpJStGP4pMZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BWIV+2FZmn3CS6NCFtypF4JYPJWlqSRbZW8ShlI2/tdx7prHlUm+7JO60BsOryN0a
	 vpL/KJ5QXukFSiP+WTYgR3ImnwydC5LD8R66QrfEvmq10+SVM7+NBdZSSyL2OIm8xX
	 8Ax0UvrpnZcZQRQpItJOa88ibs4cuy3k0+0CGxwY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbfD3LoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:44:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729236AbfD3LoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:44:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE31F21670;
        Tue, 30 Apr 2019 11:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556624661;
        bh=BMQhf59ngHxcrEisMnwNzHCcj0mMR5dhpJStGP4pMZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o00TzakDtGpny0pQlX7x0t3jjiALEfYnwrAsU/ARytozRwy6eYplF1v4+IDgidAmq
         LOyofKR57jtRdvsxG70iDZzW1klAhfvpHsxl9BbDQf8l+O/VumjSBwaWzNa/t85KV1
         bfZ5o7Is2aytpqXaSTxqOYG7VQR08NrW6eGj7dlA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.19 025/100] tracing: Fix a memory leak by early error exit in trace_pid_write()
Date:   Tue, 30 Apr 2019 13:37:54 +0200
Message-Id: <20190430113610.065292755@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113608.616903219@linuxfoundation.org>
References: <20190430113608.616903219@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wang6495@umn.edu>

commit 91862cc7867bba4ee5c8fcf0ca2f1d30427b6129 upstream.

In trace_pid_write(), the buffer for trace parser is allocated through
kmalloc() in trace_parser_get_init(). Later on, after the buffer is used,
it is then freed through kfree() in trace_parser_put(). However, it is
possible that trace_pid_write() is terminated due to unexpected errors,
e.g., ENOMEM. In that case, the allocated buffer will not be freed, which
is a memory leak bug.

To fix this issue, free the allocated buffer when an error is encountered.

Link: http://lkml.kernel.org/r/1555726979-15633-1-git-send-email-wang6495@umn.edu

Fixes: f4d34a87e9c10 ("tracing: Use pid bitmap instead of a pid array for set_event_pid")
Cc: stable@vger.kernel.org
Signed-off-by: Wenwen Wang <wang6495@umn.edu>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -496,8 +496,10 @@ int trace_pid_write(struct trace_pid_lis
 	 * not modified.
 	 */
 	pid_list = kmalloc(sizeof(*pid_list), GFP_KERNEL);
-	if (!pid_list)
+	if (!pid_list) {
+		trace_parser_put(&parser);
 		return -ENOMEM;
+	}
 
 	pid_list->pid_max = READ_ONCE(pid_max);
 
@@ -507,6 +509,7 @@ int trace_pid_write(struct trace_pid_lis
 
 	pid_list->pids = vzalloc((pid_list->pid_max + 7) >> 3);
 	if (!pid_list->pids) {
+		trace_parser_put(&parser);
 		kfree(pid_list);
 		return -ENOMEM;
 	}


