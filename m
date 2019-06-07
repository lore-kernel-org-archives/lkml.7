Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA4DC468BC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C2D2147A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559922254;
	bh=W6xo+delCARrCU+q5zL+cVPpYq5+gW8De2j8AiJ23+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bTH7960wazYsjtU9tYCunjm8wHcykCpNveFgHfDonjkq6R/5v3QZnZQ28cZZOnZDs
	 AicIQHZqS8uhD0aEyqB8KMB5iFD54zQCFe3Esvtr15DnexAS0vYNlvAmlz52scyYHk
	 yEBhCaQT0F0BbljC1vqYWdY8Lc64wJmDJzzdCPvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbfFGPoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:44:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731006AbfFGPoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:44:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DC0E21473;
        Fri,  7 Jun 2019 15:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559922251;
        bh=W6xo+delCARrCU+q5zL+cVPpYq5+gW8De2j8AiJ23+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pfIDAzZ6+0RJ1u1GkAoSpmqT8vGnDFpWvA5aw7RutdpBN9+BVuCJqQOx6lC4YixEJ
         ZLTXN2ZqXD5EIod3FyrV9kNr7/pLOBXbiaFR8klutIvos1YReM6PWIEbXwFDKGfml2
         5Q/uYEF7MNqqRRFgGWPseBwfDmzjMdcCm+feGQJI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+6b8e0fb820e570c59e19@syzkaller.appspotmail.com,
        Tomas Bortoli <tomasbortoli@gmail.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.19 20/73] tracing: Avoid memory leak in predicate_parse()
Date:   Fri,  7 Jun 2019 17:39:07 +0200
Message-Id: <20190607153851.180927639@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607153848.669070800@linuxfoundation.org>
References: <20190607153848.669070800@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomas Bortoli <tomasbortoli@gmail.com>

commit dfb4a6f2191a80c8b790117d0ff592fd712d3296 upstream.

In case of errors, predicate_parse() goes to the out_free label
to free memory and to return an error code.

However, predicate_parse() does not free the predicates of the
temporary prog_stack array, thence leaking them.

Link: http://lkml.kernel.org/r/20190528154338.29976-1-tomasbortoli@gmail.com

Cc: stable@vger.kernel.org
Fixes: 80765597bc587 ("tracing: Rewrite filter logic to be simpler and faster")
Reported-by: syzbot+6b8e0fb820e570c59e19@syzkaller.appspotmail.com
Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
[ Added protection around freeing prog_stack[i].pred ]
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_events_filter.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -427,7 +427,7 @@ predicate_parse(const char *str, int nr_
 	op_stack = kmalloc_array(nr_parens, sizeof(*op_stack), GFP_KERNEL);
 	if (!op_stack)
 		return ERR_PTR(-ENOMEM);
-	prog_stack = kmalloc_array(nr_preds, sizeof(*prog_stack), GFP_KERNEL);
+	prog_stack = kcalloc(nr_preds, sizeof(*prog_stack), GFP_KERNEL);
 	if (!prog_stack) {
 		parse_error(pe, -ENOMEM, 0);
 		goto out_free;
@@ -576,7 +576,11 @@ predicate_parse(const char *str, int nr_
 out_free:
 	kfree(op_stack);
 	kfree(inverts);
-	kfree(prog_stack);
+	if (prog_stack) {
+		for (i = 0; prog_stack[i].pred; i++)
+			kfree(prog_stack[i].pred);
+		kfree(prog_stack);
+	}
 	return ERR_PTR(ret);
 }
 


