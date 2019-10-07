Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06097ECE58B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 01:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDDD520867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 01:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570411591;
	bh=dUotA+P87ysoK24x7r6omXg7VFgeTiHhAGJxMxkb8LY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=g5BWXAjQBhTC43r9wSyPHXEyzr+tEIR+qhA6eFhrIFJSs575QXQEhb4zFYEMCP9cz
	 7OMl2qBiwO+WPFGEp7SRDkWyf7EbfzLFj1PSdD0OkDexcR3LTzeaSehFMPRPoHdP+0
	 BjP0ds7BWIcW+7lZUfDLUqSt2U5oyDSPoMCi7vAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfJGB0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 21:26:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbfJGB0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 21:26:30 -0400
Received: from paulmck-ThinkPad-P72 (unknown [12.12.162.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4852220862;
        Mon,  7 Oct 2019 01:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570411589;
        bh=dUotA+P87ysoK24x7r6omXg7VFgeTiHhAGJxMxkb8LY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IS+CKxcup5jzrqDy8WvOw5ZNz5Y5+Tz2020qvv7Ik5LowgDsB0+zWhV4JnPOWvhgC
         3lPVh1//OpIZ92x6WWwsd7ADOrYZRAT8MwjPYbKbA1Q7jM5DcrKQpF01d3TDMadTzC
         7iSxg7EFiM0xtqcbq1N5ECr77O47CYiGEWi7GFnI=
Date:   Sun, 6 Oct 2019 18:26:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stefan Reiter <stefan@pimaker.at>
Cc:     rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/nocb: Fix dump_tree hierarchy print always active
Message-ID: <20191007012625.GA23446@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191004194854.11352-1-stefan@pimaker.at>
 <20191004222402.GQ2689@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004222402.GQ2689@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 03:24:02PM -0700, Paul E. McKenney wrote:
> On Fri, Oct 04, 2019 at 07:49:10PM +0000, Stefan Reiter wrote:
> > Commit 18cd8c93e69e ("rcu/nocb: Print gp/cb kthread hierarchy if
> > dump_tree") added print statements to rcu_organize_nocb_kthreads for
> > debugging, but incorrectly guarded them, causing the function to always
> > spew out its message.
> > 
> > This patch fixes it by guarding both pr_alert statements with dump_tree,
> > while also changing the second pr_alert to a pr_cont, to print the
> > hierarchy in a single line (assuming that's how it was supposed to
> > work).
> > 
> > Fixes: 18cd8c93e69e ("rcu/nocb: Print gp/cb kthread hierarchy if dump_tree")
> > Signed-off-by: Stefan Reiter <stefan@pimaker.at>
> 
> Queued for testing and review, thank you!

And here is an updated version to make the special case of a nocb GP
kthread having no other nocb CB kthreads look less strange.  Does this
work for you?

							Thanx, Paul

------------------------------------------------------------------------

commit e6223b0705369750990c32ddc80251942e61be30
Author: Stefan Reiter <stefan@pimaker.at>
Date:   Fri Oct 4 19:49:10 2019 +0000

    rcu/nocb: Fix dump_tree hierarchy print always active
    
    Commit 18cd8c93e69e ("rcu/nocb: Print gp/cb kthread hierarchy if
    dump_tree") added print statements to rcu_organize_nocb_kthreads for
    debugging, but incorrectly guarded them, causing the function to always
    spew out its message.
    
    This patch fixes it by guarding both pr_alert statements with dump_tree,
    while also changing the second pr_alert to a pr_cont, to print the
    hierarchy in a single line (assuming that's how it was supposed to
    work).
    
    Fixes: 18cd8c93e69e ("rcu/nocb: Print gp/cb kthread hierarchy if dump_tree")
    Signed-off-by: Stefan Reiter <stefan@pimaker.at>
    [ paulmck: Make single-nocbs-CPU GP kthreads look less erroneous. ]
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index d5334e4..d43f4e0 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2295,6 +2295,8 @@ static void __init rcu_organize_nocb_kthreads(void)
 {
 	int cpu;
 	bool firsttime = true;
+	bool gotnocbs = false;
+	bool gotnocbscbs = true;
 	int ls = rcu_nocb_gp_stride;
 	int nl = 0;  /* Next GP kthread. */
 	struct rcu_data *rdp;
@@ -2317,21 +2319,31 @@ static void __init rcu_organize_nocb_kthreads(void)
 		rdp = per_cpu_ptr(&rcu_data, cpu);
 		if (rdp->cpu >= nl) {
 			/* New GP kthread, set up for CBs & next GP. */
+			gotnocbs = true;
 			nl = DIV_ROUND_UP(rdp->cpu + 1, ls) * ls;
 			rdp->nocb_gp_rdp = rdp;
 			rdp_gp = rdp;
-			if (!firsttime && dump_tree)
-				pr_cont("\n");
-			firsttime = false;
-			pr_alert("%s: No-CB GP kthread CPU %d:", __func__, cpu);
+			if (dump_tree) {
+				if (!firsttime)
+					pr_cont("%s\n", gotnocbscbs
+							? "" : " (self only)");
+				gotnocbscbs = false;
+				firsttime = false;
+				pr_alert("%s: No-CB GP kthread CPU %d:",
+					 __func__, cpu);
+			}
 		} else {
 			/* Another CB kthread, link to previous GP kthread. */
+			gotnocbscbs = true;
 			rdp->nocb_gp_rdp = rdp_gp;
 			rdp_prev->nocb_next_cb_rdp = rdp;
-			pr_alert(" %d", cpu);
+			if (dump_tree)
+				pr_cont(" %d", cpu);
 		}
 		rdp_prev = rdp;
 	}
+	if (gotnocbs && dump_tree)
+		pr_cont("%s\n", gotnocbscbs ? "" : " (self only)");
 }
 
 /*
