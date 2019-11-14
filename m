Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76605C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 19:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFE42071F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 19:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfKNTGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 14:06:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:48444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfKNTGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 14:06:06 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A5052071B;
        Thu, 14 Nov 2019 19:06:05 +0000 (UTC)
Date:   Thu, 14 Nov 2019 14:05:59 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 03/10] ftrace: Add register_ftrace_direct()
Message-ID: <20191114140559.5dd40402@gandalf.local.home>
In-Reply-To: <20191114134827.555e9b31@gandalf.local.home>
References: <20191108212834.594904349@goodmis.org>
        <20191108213450.032003836@goodmis.org>
        <20191109022907.6zzo6orhxpt5n2sv@ast-mbp.dhcp.thefacebook.com>
        <20191109073310.6a7a16f2@gandalf.local.home>
        <20191114132942.2adc7aa2@gandalf.local.home>
        <CAADnVQJcwyDBm7no2_wauezjkEFvgJk10FppiqRBU8p_7n0tbw@mail.gmail.com>
        <20191114134827.555e9b31@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2019 13:48:27 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> The main reason, is that then we need to add another arch specific
> change, where as, the solution I suggested doesn't need anything new.
> The less arch specific code we need the better.

Here's the change, to see how easy it is (compiled tested only):

/* still needs comments */

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 82ef8d60a42b..4231571db30f 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5160,6 +5160,59 @@ int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(unregister_ftrace_direct);
+
+static struct ftrace_ops stub_ops = {
+	.func		= ftrace_stub,
+};
+
+int modify_ftrace_direct(unsigned long ip,
+			 unsigned long old_addr, unsigned long new_addr)
+{
+	struct ftrace_func_entry *entry;
+	struct dyn_ftrace *rec;
+	int ret = -ENODEV;
+
+	mutex_lock(&direct_mutex);
+	entry = __ftrace_lookup_ip(direct_functions, ip);
+	if (!entry) {
+		/* OK if it is off by a little */
+		rec = lookup_rec(ip, ip);
+		if (!rec || rec->ip == ip)
+			goto out_unlock;
+
+		entry = __ftrace_lookup_ip(direct_functions, rec->ip);
+		if (!entry)
+			goto out_unlock;
+
+		WARN_ON(!(rec->flags & FTRACE_FL_DIRECT));
+	}
+
+	ret = -EINVAL;
+	if (entry->direct != old_addr)
+		goto out_unlock;
+
+	ret = ftrace_set_filter_ip(&stub_ops, ip, 0, 0);
+	if (ret)
+		goto out_unlock;
+
+	ret = register_ftrace_function(&stub_ops);
+	if (ret) {
+		ftrace_set_filter_ip(&stub_ops, ip, 1, 0);
+		goto out_unlock;
+	}
+
+	entry->direct = new_addr;
+
+	unregister_ftrace_function(&stub_ops);
+	ftrace_set_filter_ip(&stub_ops, ip, 1, 0);
+
+	ret = 0;
+
+ out_unlock:
+	mutex_unlock(&direct_mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(modify_ftrace_direct);
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 /**


-- Steve
