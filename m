Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4320C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 13:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C9021920
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 13:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568034279;
	bh=8UgCB43O2LFiz4OCXIAM1O+gF9gaFz/HhmBKkjEHV3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M/DbfchxGRIAZher92rHV6i1nw3zl+o5M0mvkqFY4xUDusTUNwYUmS3DkRECbSVKU
	 4BFVe/HNlWCPT2iejmOQUNXVzE/VCBMzft9t37mMp8VYCp5os9JQTKxzkK8SiwfSb2
	 wlSE/7dYfuyATsgozMxWZlzKOXmNn/4E/6cvgGEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbfIINEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 09:04:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:38166 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725897AbfIINEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 09:04:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CA865ABCB;
        Mon,  9 Sep 2019 13:04:35 +0000 (UTC)
Date:   Mon, 9 Sep 2019 15:04:35 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH (resend)] mm,oom: Defer dump_tasks() output.
Message-ID: <20190909130435.GO27159@dhcp22.suse.cz>
References: <1567159493-5232-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <7de2310d-afbd-e616-e83a-d75103b986c6@i-love.sakura.ne.jp>
 <20190909113627.GJ27159@dhcp22.suse.cz>
 <579a27d2-52fb-207e-9278-fc20a2154394@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <579a27d2-52fb-207e-9278-fc20a2154394@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09-09-19 21:40:24, Tetsuo Handa wrote:
> On 2019/09/09 20:36, Michal Hocko wrote:
> > On Sat 07-09-19 19:54:32, Tetsuo Handa wrote:
> >> (Resending to LKML as linux-mm ML dropped my posts.)
> >>
> >> If /proc/sys/vm/oom_dump_tasks != 0, dump_header() can become very slow
> >> because dump_tasks() synchronously reports all OOM victim candidates, and
> >> as a result ratelimit test for dump_header() cannot work as expected.
> >>
> >> This patch defers dump_tasks() output till oom_lock is released. As a
> >> result of this patch, the latency between out_of_memory() is called and
> >> SIGKILL is sent (and the OOM reaper starts reclaiming memory) will be
> >> significantly reduced.
> >>
> >> Since CONFIG_PRINTK_CALLER was introduced, concurrent printk() became less
> >> problematic. But we still need to correlate synchronously printed messages
> >> and asynchronously printed messages if we defer dump_tasks() messages.
> >> Thus, this patch also prefixes OOM killer messages using "OOM[$serial]:"
> >> format. As a result, OOM killer messages would look like below.
> >>
> >>   [   31.935015][   T71] OOM[1]: kworker/4:1 invoked oom-killer: gfp_mask=0xcc0(GFP_KERNEL), order=-1, oom_score_adj=0
> >>   (...snipped....)
> >>   [   32.052635][   T71] OOM[1]: oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),global_oom,task_memcg=/,task=firewalld,pid=737,uid=0
> >>   [   32.056886][   T71] OOM[1]: Out of memory: Killed process 737 (firewalld) total-vm:358672kB, anon-rss:22640kB, file-rss:12328kB, shmem-rss:0kB, UID:0 pgtables:421888kB oom_score_adj:0
> >>   [   32.064291][   T71] OOM[1]: Tasks state (memory values in pages):
> >>   [   32.067807][   T71] OOM[1]: [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
> >>   [   32.070057][   T54] oom_reaper: reaped process 737 (firewalld), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
> >>   [   32.072417][   T71] OOM[1]: [    548]     0   548     9772     1172   110592        0             0 systemd-journal
> >>   (...snipped....)
> >>   [   32.139566][   T71] OOM[1]: [    737]     0   737    89668     8742   421888        0             0 firewalld
> >>   (...snipped....)
> >>   [   32.221990][   T71] OOM[1]: [   1300]    48  1300    63025     1788   532480        0             0 httpd
> >>
> >> This patch might affect panic behavior triggered by panic_on_oom or no
> >> OOM-killable tasks, for dump_header(oc, NULL) will not report OOM victim
> >> candidates if there are not-yet-reported OOM victim candidates from past
> >> rounds of OOM killer invocations. I don't know if that matters.
> >>
> >> For now this patch embeds "struct oom_task_info" into each
> >> "struct task_struct". In order to avoid bloating "struct task_struct",
> >> future patch might detach from "struct task_struct" because one
> >> "struct oom_task_info" for one "struct signal_struct" will be enough.
> > 
> > This is not an improvement. It detaches the oom report and tasks_dump
> > for an arbitrary amount of time because the worder context might be
> > stalled for an arbitrary time. Even long after the oom is resolved.
> 
> A new worker thread is created if all existing worker threads are busy
> because this patch solves OOM situation quickly when a new worker thread
> cannot be created due to OOM situation.
> 
> Also, if a worker thread cannot run due to CPU starvation, the same thing
> applies to dump_tasks(). In other words, dump_tasks() cannot complete due
> to CPU starvation, which results in more costly and serious consequences.
> Being able to send SIGKILL and reclaim memory as soon as possible is
> an improvement.

There might be zillion workers waiting to make a forward progress and
you cannot expect any timing here. Just remember your own experiments
with xfs and low memory conditions.

> > Not to mention that 1:1 (oom to tasks) information dumping is
> > fundamentally broken. Any task might be on an oom list of different
> > OOM contexts in different oom scopes (think of OOM happening in disjunct
> > NUMA sets).
> 
> I can't understand what you are talking about. This patch just defers
> printk() from /proc/sys/vm/oom_dump_tasks != 0. Please look at the patch
> carefully. If you are saying that it is bad that OOM victim candidates for
> OOM domain B, C, D ... cannot be printed if printing of OOM victim candidates
> for OOM domain A has not finished, I can update this patch to print them.

You would have to track each ongoing oom context separately. And not
only those from different oom scopes because as a matter of fact a new
OOM might trigger before the previous dump_tasks managed to be handled.

> > This is just adding more kludges and making the code more complex
> > without trying to address an underlying problems. So
> > Nacked-by: Michal Hocko <mhocko@suse.com>
> 
> Since I'm sure that you are misunderstanding, this Nacked-by is invalid.

Thank you very much for your consideration and evaluation of my review.
It seems that I am only burning my time responding to your emails. As
you seem to know the best, right?
-- 
Michal Hocko
SUSE Labs
