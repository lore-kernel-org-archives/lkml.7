Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5B8C10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848B9218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256951;
	bh=ZoFHuo80kcKVcIfG03GBxqnJ6ed5B66r/sOGzlpG2iM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d3cap3uXSoEUBQJWN8KSN+MI5VGLrfdvWXLY289Ay+I8nsfdITfl1U/siDV0T1NHz
	 Qau9oAhNaSeoDgb3HfMiR75S1bLoF5UcywQC/teZPgeadCktkiIHhjW0hmNG4UBsWV
	 HSDy7DdSK9TcjiWk6GgsLkPR2KDH1A9hsvpg/4S8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389965AbfCVMPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:15:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390111AbfCVMPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:15:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADAD12082C;
        Fri, 22 Mar 2019 12:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256944;
        bh=ZoFHuo80kcKVcIfG03GBxqnJ6ed5B66r/sOGzlpG2iM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZPQpn42VkNYESwThFQW7X22YbVn1bUSBdsN/9e/mMDNvxAQA5uNOJXLrSG3GCRvQX
         tot/OoaieDUy0xPbX78gdti3dfFBCRkRyGEmllRIh/quw3aCmXtabV2UNSVG6kZinR
         67CxY4SmeZS98k9LcbUWnWSGQEkd/3iPZwdUzC/o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "zhangyi (F)" <yi.zhang@huawei.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 5.0 057/238] tracing: Do not free iter->trace in fail path of tracing_open_pipe()
Date:   Fri, 22 Mar 2019 12:14:36 +0100
Message-Id: <20190322111301.888128581@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5626,7 +5626,6 @@ out:
 	return ret;
 
 fail:
-	kfree(iter->trace);
 	kfree(iter);
 	__trace_array_put(tr);
 	mutex_unlock(&trace_types_lock);


