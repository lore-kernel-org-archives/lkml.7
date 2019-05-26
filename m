Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFBDC282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 19:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63D9217D8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 19:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfEZTSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 15:18:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:58724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbfEZTSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 15:18:48 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D05F2171F;
        Sun, 26 May 2019 19:18:47 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hUyfO-0004Y8-Oo; Sun, 26 May 2019 15:18:46 -0400
Message-Id: <20190526191846.657047582@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 26 May 2019 15:18:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: [for-next][PATCH 02/16] x86/ftrace: Make enable parameter bool where applicable
References: <20190526191828.466305460@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The code modification functions have an "enable" parameter that is an "int"
but used as a boolean. Switch its type to "bool" to remove the ambiguity
that "int" causes.

Link: http://lkml.kernel.org/r/e1429923d9eda92a3cf5ee9e33c7eacce539781d.1558115654.git.naveen.n.rao@linux.vnet.ibm.com

Reported-by: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/kernel/ftrace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 0927bb158ffc..ba37bcb7f92b 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -370,7 +370,7 @@ static int add_brk_on_nop(struct dyn_ftrace *rec)
 	return add_break(rec->ip, old);
 }
 
-static int add_breakpoints(struct dyn_ftrace *rec, int enable)
+static int add_breakpoints(struct dyn_ftrace *rec, bool enable)
 {
 	unsigned long ftrace_addr;
 	int ret;
@@ -478,7 +478,7 @@ static int add_update_nop(struct dyn_ftrace *rec)
 	return add_update_code(ip, new);
 }
 
-static int add_update(struct dyn_ftrace *rec, int enable)
+static int add_update(struct dyn_ftrace *rec, bool enable)
 {
 	unsigned long ftrace_addr;
 	int ret;
@@ -524,7 +524,7 @@ static int finish_update_nop(struct dyn_ftrace *rec)
 	return ftrace_write(ip, new, 1);
 }
 
-static int finish_update(struct dyn_ftrace *rec, int enable)
+static int finish_update(struct dyn_ftrace *rec, bool enable)
 {
 	unsigned long ftrace_addr;
 	int ret;
-- 
2.20.1


