Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C07CC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115CF2339D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567523590;
	bh=dwNhF0XXR1N4lepaoXBpHBBizbErdN2Wb7bUOqqZeb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W535wmyrG8cguUWV8zDZxFDgNtxnLcPHqRqSeJ1CTb9t3/0E/Fbr4krYEJCSkKLST
	 IWCA2qIcsNjDX28uzQ4z3QUuhlXeafd8+x9u2aqhyWu3vdyccGpF3AcxqHTpM+5a0q
	 Je2t9Kw+EQhPyAHBYp6IA4rUxSnSs3R6Zth3CtOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbfICPNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 11:13:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:37158 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727667AbfICPNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:13:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 952CDAFB7;
        Tue,  3 Sep 2019 15:13:07 +0000 (UTC)
Date:   Tue, 3 Sep 2019 17:13:07 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm, oom: disable dump_tasks by default
Message-ID: <20190903151307.GZ14028@dhcp22.suse.cz>
References: <20190903144512.9374-1-mhocko@kernel.org>
 <1567522966.5576.51.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567522966.5576.51.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03-09-19 11:02:46, Qian Cai wrote:
> On Tue, 2019-09-03 at 16:45 +0200, Michal Hocko wrote:
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > dump_tasks has been introduced by quite some time ago fef1bdd68c81
> > ("oom: add sysctl to enable task memory dump"). It's primary purpose is
> > to help analyse oom victim selection decision. This has been certainly
> > useful at times when the heuristic to chose a victim was much more
> > volatile. Since a63d83f427fb ("oom: badness heuristic rewrite")
> > situation became much more stable (mostly because the only selection
> > criterion is the memory usage) and reports about a wrong process to
> > be shot down have become effectively non-existent.
> 
> Well, I still see OOM sometimes kills wrong processes like ssh, systemd
> processes while LTP OOM tests with staight-forward allocation patterns.

Please report those. Most cases I have seen so far just turned out to
work as expected and memory hogs just used oom_score_adj or similar.

> I just
> have not had a chance to debug them fully. The situation could be worse with
> more complex allocations like random stress or fuzzy testing.

Nothing really prevents enabling the sysctl when doing OOM oriented
testing.

> > dump_tasks can generate a lot of output to the kernel log. It is not
> > uncommon that even relative small system has hundreds of tasks running.
> > Generating a lot of output to the kernel log both makes the oom report
> > less convenient to process and also induces a higher load on the printk
> > subsystem which can lead to other problems (e.g. longer stalls to flush
> > all the data to consoles).
> 
> It is only generate output for the victim process where I tested on those large
> NUMA machines and the output is fairly manageable.

The main question here is whether that information is useful by
_default_ because it is certainly not free. It takes both time to crawl
all processes and cpu cycles to get that information to the console
because printk is not free either. So if it more of "nice to have" than
necessary for oom analysis then it should be disabled by default IMHO.

-- 
Michal Hocko
SUSE Labs
