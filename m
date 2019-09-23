Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16C1C432C2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 23:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8901721D56
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 23:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569282561;
	bh=jL+W7CvZH4IgiJNH4Ta0EhwbKZYehXX/NJi8o1uDX1k=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=rubFTho21krROBWq7c6Bbfu22aqyUAEwfHlVpf7WsneOaqscTFvPEb67Mx7yhE4al
	 1kHDzSQHRMy2kNcdY2dXlRnzim4CVV+TKJ4WNO6e3EVPHCpeiu6WsQBNoRzHMwuojq
	 ER8vgLv4LOnWYkSkUjQByZGpk0YjnCdZj1G65i/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391199AbfIWXtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 19:49:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729276AbfIWXtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 19:49:20 -0400
Received: from paulmck-ThinkPad-P72 (unknown [170.225.9.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96F8D21A4C;
        Mon, 23 Sep 2019 23:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569282559;
        bh=jL+W7CvZH4IgiJNH4Ta0EhwbKZYehXX/NJi8o1uDX1k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UeC4Jud0+mJMm5/0QRXUluKExkV2v4Bm5v3jzNKZ9VsWLHJzNJkLgrWRdKSERFccH
         8oYzNCEwjAUNxdFdfT1TRHetfT/Jo2kgOTSq4CCw9PHx7lOo3OYcfgv0VhyOlEL546
         wNPDBQXOMW5lCPjtrIITjD0QwQxNeORyEsBQ2H8A=
Date:   Mon, 23 Sep 2019 16:49:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, byungchul.park@lge.com,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 -rcu dev 0/5] kfree_rcu() additions for -rcu
Message-ID: <20190923234916.GF7828@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20190830163633.104099-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830163633.104099-1-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 12:36:28PM -0400, Joel Fernandes (Google) wrote:
> Hi,
> 
> This is a series on top of the patch "rcu/tree: Add basic support for kfree_rcu() batching".
> 
> It adds performance tests, some clean ups and removal of "lazy" RCU callbacks.
> 
> Now that kfree_rcu() is handled separately from call_rcu(), we also get rid of
> kfree "lazy" handling from tree RCU as suggested by Paul which will be unused.
> 
> Based on patch:
> Link: http://lore.kernel.org/r/20190814160411.58591-1-joel@joelfernandes.org
> 
> 
> v1 series:
> 	https://lkml.org/lkml/2019/8/27/1315
> 	https://lore.kernel.org/patchwork/project/lkml/list/?series=408218
> 
> Joel Fernandes (Google) (5):
> rcu/rcuperf: Add kfree_rcu() performance Tests
> rcu/tree: Add multiple in-flight batches of kfree_rcu work
> rcu/tree: Add support for debug_objects debugging for kfree_rcu()
> rcu: Remove kfree_rcu() special casing and lazy handling
> rcu: Remove kfree_call_rcu_nobatch()

Hello, Joel,

I have reworked these as we discussed.  Please see below for a preliminary
series on -rcu.  I say "preliminary" because most (if not all) of my
patchlets should be merged with one or another of yours.  I split them
out to make it easier for you to review my changes.  Also, I need to
swap your first two commits, if I am not mistaken -- they are switched
for ease of testing.

Thoughts?

						Thanx, Paul

------------------------------------------------------------------------

b2674c7 rcuperf: Add kfree_rcu() performance Tests
ff8db00 rcu: Make batched kfree_rcu() work during early boot
0784b59 rcu: Add crude self-test for early boot kfree_rcu()
196c1d9 rcu: Kick kfree_rcu() state machine for early boot calls
52a10e8 rcu: Use docbook header comment for struct kfree_rcu_cpu
099f53b rcu: Rework comments, indentation, and line breaks for kfree_rcu()
7ab6387 rcu EXP: Non-atomic ->monitor_todo, step 1
4a908098 rcu EXP: Non-atomic ->monitor_todo, step 2
783f00d rcu EXP: Non-atomic ->monitor_todo, step 3
4fe2018 rcu EXP: Non-atomic ->monitor_todo, step 4
b389141 rcu EXP: Non-atomic ->monitor_todo, step 5
8889da8 rcu EXP: Non-atomic ->monitor_todo, step 6
149b93e rcu EXP: Non-atomic ->monitor_todo, step 7
733e6a7 rcu: Add multiple in-flight batches of kfree_rcu() work
3acdea0 rcu: Add support for debug_objects debugging for kfree_rcu()
463db53 rcu: Remove kfree_rcu() special casing and lazy-callback handling
49e601b rcu: Remove kfree_call_rcu_nobatch()
