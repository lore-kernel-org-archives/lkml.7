Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648F9C10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27FC821B1C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256289;
	bh=M3aQnSW78gUOEVKRzh3QbPXio9NqgoCLjF6GHk/EbLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lf0rwDEv8Xie7Hwi5KKC+n5ZtYyPGX/q2RCT5MSeKalsKSZoRMQfRGLHofYaloRXx
	 VsUqf/T+6rSv9YrzwNpJH6ejchJo1na2FRyT+Yd3l/jp4jL2KniRi3eVWydLIZ3cqr
	 V96Sfr/+IqBDo5MIfm4VyIO0DbMC8BSVUBtG/Tx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388399AbfCVMEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:04:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:43172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388393AbfCVMEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:04:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8776121916;
        Fri, 22 Mar 2019 12:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256285;
        bh=M3aQnSW78gUOEVKRzh3QbPXio9NqgoCLjF6GHk/EbLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aK/QvmUTxMUroOlGRzF6UDh2hcDQPN7zgwfkLmrve7e2etCws6Fb/am/6P3wMINZe
         hK8iZZS9sQB1hXM+RKzvB74XEdPnxkRY+Ai+pl3K8K7bn+Kw6uOv9JTuaQQI5SMBi7
         w7VLOTNqgS9vY2Thm/wlWLPteKSJpVjgLFwUxiq0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "zhangyi (F)" <yi.zhang@huawei.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.19 141/280] tracing: Do not free iter->trace in fail path of tracing_open_pipe()
Date:   Fri, 22 Mar 2019 12:14:54 +0100
Message-Id: <20190322111318.407219168@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: zhangyi (F) <yi.zhang@huawei.com>

commit e7f0c424d0806b05d6f47be9f202b037eb701707 upstream.

Commit d716ff71dd12 ("tracing: Remove taking of trace_types_lock in
pipe files") use the current tracer instead of the copy in
tracing_open_pipe(), but it forget to remove the freeing sentence in
the error path.

There's an error path that can call kfree(iter->trace) after the iter->trace
was assigned to tr->current_trace, which would be bad to free.

Link: http://lkml.kernel.org/r/1550060946-45984-1-git-send-email-yi.zhang@huawei.com

Cc: stable@vger.kernel.org
Fixes: d716ff71dd12 ("tracing: Remove taking of trace_types_lock in pipe files")
Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace.c |    1 -
 1 file changed, 1 deletion(-)

--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5606,7 +5606,6 @@ out:
 	return ret;
 
 fail:
-	kfree(iter->trace);
 	kfree(iter);
 	__trace_array_put(tr);
 	mutex_unlock(&trace_types_lock);


