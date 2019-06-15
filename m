Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E37C31E53
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 13:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEED72184B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 13:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560606601;
	bh=8c4I3wmBlxVBzgJarZkylqdbNGzadu6wrs7S7VmNhUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bH9m20R+QISAKHkx3EPY0NNyIXgo8yDJaPqVp8flhgXyoZg1nSrPAr11/vRD2p/+9
	 Gbhhg1oTs4h2TrCsy/aoYO+vNxwxQkI85GuKDoG1sZ6cr0nhzdNjqUfaJa6Oi0SMYb
	 Cjv0SUk6M1DfFtKaE5kJlvFFy0p5ubV8D2YhD4pA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfFONuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 09:50:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:47182 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726236AbfFONuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 09:50:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E77FAAF90;
        Sat, 15 Jun 2019 13:49:57 +0000 (UTC)
Date:   Sat, 15 Jun 2019 15:49:55 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     syzbot <syzbot+d0fc9d3c166bc5e4a94b@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        yuzhoujian@didichuxing.com
Subject: Re: general protection fault in oom_unkillable_task
Message-ID: <20190615134955.GA28441@dhcp22.suse.cz>
References: <0000000000004143a5058b526503@google.com>
 <CALvZod72=KuBZkSd0ey5orJFGFpwx462XY=cZvO3NOXC0MogFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod72=KuBZkSd0ey5orJFGFpwx462XY=cZvO3NOXC0MogFw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 14-06-19 20:15:31, Shakeel Butt wrote:
> On Fri, Jun 14, 2019 at 6:08 PM syzbot
> <syzbot+d0fc9d3c166bc5e4a94b@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    3f310e51 Add linux-next specific files for 20190607
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15ab8771a00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=5d176e1849bbc45
> > dashboard link: https://syzkaller.appspot.com/bug?extid=d0fc9d3c166bc5e4a94b
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+d0fc9d3c166bc5e4a94b@syzkaller.appspotmail.com
> >
> > kasan: CONFIG_KASAN_INLINE enabled
> > kasan: GPF could be caused by NULL-ptr deref or user memory access
> > general protection fault: 0000 [#1] PREEMPT SMP KASAN
> > CPU: 0 PID: 28426 Comm: syz-executor.5 Not tainted 5.2.0-rc3-next-20190607
> > #11
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > RIP: 0010:__read_once_size include/linux/compiler.h:194 [inline]
> > RIP: 0010:has_intersects_mems_allowed mm/oom_kill.c:84 [inline]
> 
> It seems like oom_unkillable_task() is broken for memcg OOMs. It
> should not be calling has_intersects_mems_allowed() for memcg OOMs.

You are right. It doesn't really make much sense to check for the NUMA
policy/cpusets when the memcg oom is NUMA agnostic. Now that I am
looking at the code then I am really wondering why do we even call
oom_unkillable_task from oom_badness. proc_oom_score shouldn't care
about NUMA either.

In other words the following should fix this unless I am missing
something (task_in_mem_cgroup seems to be a relict from before the group
oom handling). But please note that I am still not fully operation and
laying in the bed.

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 5a58778c91d4..43eb479a5dc7 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -161,8 +161,8 @@ static bool oom_unkillable_task(struct task_struct *p,
 		return true;
 
 	/* When mem_cgroup_out_of_memory() and p is not member of the group */
-	if (memcg && !task_in_mem_cgroup(p, memcg))
-		return true;
+	if (memcg)
+		return false;
 
 	/* p may not have freeable memory in nodemask */
 	if (!has_intersects_mems_allowed(p, nodemask))
@@ -318,7 +318,7 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
 	struct oom_control *oc = arg;
 	unsigned long points;
 
-	if (oom_unkillable_task(task, NULL, oc->nodemask))
+	if (oom_unkillable_task(task, oc->memcg, oc->nodemask))
 		goto next;
 
-- 
Michal Hocko
SUSE Labs
