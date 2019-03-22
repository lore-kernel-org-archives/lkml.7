Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5005C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A541E2192D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256293;
	bh=RgMJnDERoQkrmyDxnu9lN5+W5E0bHSSz56wUoDZ245k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VHX3+tzjgaoCXUZCESo4uov4aD/oeGsPfyTQko6a/L7Ilh02aSz4jil/p5/h37m7D
	 63yenq3f9F0WDpZsjmDXGGctJ/5cXL0DtZiTOq0/gAdK3+YU9Vc2eYM5VwGi7/l9nK
	 SjL4BSxFpqAe+dKZY2mDyrqrL742NHDTbxcq9HAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388727AbfCVMEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:04:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733252AbfCVMEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:04:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86757206C0;
        Fri, 22 Mar 2019 12:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256289;
        bh=RgMJnDERoQkrmyDxnu9lN5+W5E0bHSSz56wUoDZ245k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k8NFNIWFyrWzAvUp29mQm+iCiEr4ZodO+1skpN86Qqs0T6u50QIxebbaLYGwXckQg
         oE+FPHjaaE9AmteYLvbaAPWh6e8he9aZnQe/JDCnj72Z810mSXLzcdvk1MPMV7CcIZ
         89FOv3A03Ev2NOk/gIZuz4Z9c7J/PsApJWapmPOU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Song Liu <songliubraving@fb.com>, Jann Horn <jannh@google.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.19 142/280] tracing/perf: Use strndup_user() instead of buggy open-coded version
Date:   Fri, 22 Mar 2019 12:14:55 +0100
Message-Id: <20190322111318.570881793@linuxfoundation.org>
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

From: Jann Horn <jannh@google.com>

commit 83540fbc8812a580b6ad8f93f4c29e62e417687e upstream.

The first version of this method was missing the check for
`ret == PATH_MAX`; then such a check was added, but it didn't call kfree()
on error, so there was still a small memory leak in the error case.
Fix it by using strndup_user() instead of open-coding it.

Link: http://lkml.kernel.org/r/20190220165443.152385-1-jannh@google.com

Cc: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org
Fixes: 0eadcc7a7bc0 ("perf/core: Fix perf_uprobe_init()")
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_event_perf.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -298,15 +298,13 @@ int perf_uprobe_init(struct perf_event *
 
 	if (!p_event->attr.uprobe_path)
 		return -EINVAL;
-	path = kzalloc(PATH_MAX, GFP_KERNEL);
-	if (!path)
-		return -ENOMEM;
-	ret = strncpy_from_user(
-		path, u64_to_user_ptr(p_event->attr.uprobe_path), PATH_MAX);
-	if (ret == PATH_MAX)
-		return -E2BIG;
-	if (ret < 0)
-		goto out;
+
+	path = strndup_user(u64_to_user_ptr(p_event->attr.uprobe_path),
+			    PATH_MAX);
+	if (IS_ERR(path)) {
+		ret = PTR_ERR(path);
+		return (ret == -EINVAL) ? -E2BIG : ret;
+	}
 	if (path[0] == '\0') {
 		ret = -EINVAL;
 		goto out;


