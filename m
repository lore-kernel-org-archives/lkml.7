Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D211C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C33821939
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138503;
	bh=CLKWigXoSZ0T4+GAiGwDnEOp2cp0svHa6Cov/RVhO3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PgRQaE1J47oHVxFeFJlw7Aw3aDNBSrpn/I27rE2gp5/DLVNFKf126u7r/2s9/XchP
	 Hpa8JAFSMWnfesLuNNeS30/lbbE8DC5wgCE1oyt4ZndOnsqEbDfA0u51Ka7MKIg1X/
	 CQnFvEia62yMdOKb/c+OpFRSwka7+0KEXraq72uU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbfDARIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:08:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728678AbfDARIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:08:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E75B221925;
        Mon,  1 Apr 2019 17:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138497;
        bh=CLKWigXoSZ0T4+GAiGwDnEOp2cp0svHa6Cov/RVhO3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dW08LeLzHTK2DSlNJ3/pOlVvzd8BimWmID9Cr+iNEcom+KpdYQAR1+3dOgkQhQlhX
         polEOEZ39bzuLKfCI/VilToS4vSimO6D3vwZzjtTfh3YerARhGizhZYIljmAb/VjvF
         mtmZXNu2L8NUjuGzVtqkcOn4KyT8MJkI7EclnsJQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Frank Rowand <frank.rowand@sony.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 5.0 046/146] tracing: initialize variable in create_dyn_event()
Date:   Mon,  1 Apr 2019 19:00:58 +0200
Message-Id: <20190401170052.468834766@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

From: Frank Rowand <frank.rowand@sony.com>

commit 3dee10da2e9ff220e054a8f158cc296c797fbe81 upstream.

Fix compile warning in create_dyn_event(): 'ret' may be used uninitialized
in this function [-Wuninitialized].

Link: http://lkml.kernel.org/r/1553237900-8555-1-git-send-email-frowand.list@gmail.com

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org
Fixes: 5448d44c3855 ("tracing: Add unified dynamic event framework")
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_dynevent.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -74,7 +74,7 @@ int dyn_event_release(int argc, char **a
 static int create_dyn_event(int argc, char **argv)
 {
 	struct dyn_event_operations *ops;
-	int ret;
+	int ret = -ENODEV;
 
 	if (argv[0][0] == '-' || argv[0][0] == '!')
 		return dyn_event_release(argc, argv, NULL);


