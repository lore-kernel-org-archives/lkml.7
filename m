Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB74C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 20:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA55220657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 20:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564776416;
	bh=He3bdCzqQoKlD0TpQPofzyJUftmHAq7stoumrRQiJ5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MX8Ztxv9dII9em4kqaNRXhe294Mr3JtdKJhhcwBgU1fWRpNvglV7wqvQX+5MTWL/o
	 HzPKt6RgHnmFCKIr1ngoeEKbEb9wyvIWNtkHfwcrsQweTqWb1/SrxoiAFmExeLsuBI
	 rt2KpThpzEIRXOOKZG7sOpFamSVeF1g99Fh2qcRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436511AbfHBUGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 16:06:54 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44758 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732050AbfHBUGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 16:06:54 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so36583524pgl.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 13:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0InaR80EjxBNmI3fwV/hvkwnwwTJdhOgE1ctQVb1Bpk=;
        b=P+nLxp71Ax6nF6Brzs8hAeO3lW81Nfn2pWE1wtjIrOnu0vAApKb+Ac0BIGkxNNixgl
         vvgSMEVd3hGcf+8pgQeCPPocX/qobEbmsb/raokvZUYpkUvWexGrDBLMoOpOzky+iQx1
         yvdR0PwbAGkJYzI+w5LUPtBCOEVrmfCkuzewmWpZ30NXyiMIjXEK79AJmvri+yiRHlHR
         3sVN/VDyt8xGfcC7j6k9VREgnun7p2yTzDHAj9ffoTRTS9skxG116Kd8RpKdBd1qdcnZ
         TImFNjbcq81sZfvkgbGCUKe8k2UnozWLhF0Zpt1rAk0XvRvdEsaDhQ6cpMzP8RjPxpdQ
         Jpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0InaR80EjxBNmI3fwV/hvkwnwwTJdhOgE1ctQVb1Bpk=;
        b=bra5wRQ8+W9cScaOSYwVY+qpjd4Ais/0C10bptYX40Ix7/xCf/jSciLYJEijyp9QUb
         v2mS47CqtLoxe8MAzyYixUzGohD1/SzI6RFM5V4JVS5GrL5qieBEHMJ5X/IPdPJiLlHN
         LvKRMAtHZvoOs48eZJNPe3aqN3PFJlRFuHlE+T2MfoXJ66Hx80SXCSx/UJUn5+yOPq5M
         JmsK9yhfSNGlpiY2JaNF3LR0ej46zajHVrE66gcwErOXUlzOTILBdMnH4RS6xuSMLpLs
         yCJ4e4KkBGI0HxDRmeW6ig7Mj/iDwyj6GRonCAizLhFzSGJ/rwTdJqEYPyNKvmT0xQ8T
         y9SA==
X-Gm-Message-State: APjAAAWmhuFcoG3lW0lKaUzOOF0XxlXgglGSr+Dz074Bvb7w16hDNJcD
        KxN5d/Wpm48tqASlDifIMGA=
X-Google-Smtp-Source: APXvYqwL/2NXpEk4DSAtI/faL3gFN8waWWvvjCoZ3AbSupWJxwUfwu+Rw/I3REplZCbRF7+KcU/kpw==
X-Received: by 2002:a63:6206:: with SMTP id w6mr9781484pgb.428.1564776413328;
        Fri, 02 Aug 2019 13:06:53 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id g92sm13788643pje.11.2019.08.02.13.06.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 13:06:51 -0700 (PDT)
Date:   Sat, 3 Aug 2019 05:06:43 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     syzbot <syzbot+8e6326965378936537c3@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, chris@chrisdown.name, chris@zankel.net,
        dancol@google.com, dave.hansen@intel.com, hannes@cmpxchg.org,
        hdanton@sina.com, james.bottomley@hansenpartnership.com,
        kirill.shutemov@linux.intel.com, ktkhai@virtuozzo.com,
        laoar.shao@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@techsingularity.net, mhocko@kernel.org,
        mhocko@suse.com, oleksandr@redhat.com, ralf@linux-mips.org,
        rth@twiddle.net, sfr@canb.auug.org.au, shakeelb@google.com,
        sonnyrao@google.com, surenb@google.com,
        syzkaller-bugs@googlegroups.com, timmurray@google.com,
        yang.shi@linux.alibaba.com
Subject: Re: kernel BUG at mm/vmscan.c:LINE! (2)
Message-ID: <20190802200643.GA181880@google.com>
References: <000000000000a9694d058f261963@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000a9694d058f261963@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 10:58:05AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    0d8b3265 Add linux-next specific files for 20190729
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1663c7d0600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ae96f3b8a7e885f7
> dashboard link: https://syzkaller.appspot.com/bug?extid=8e6326965378936537c3
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133c437c600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15645854600000
> 
> The bug was bisected to:
> 
> commit 06a833a1167e9cbb43a9a4317ec24585c6ec85cb
> Author: Minchan Kim <minchan@kernel.org>
> Date:   Sat Jul 27 05:12:38 2019 +0000
> 
>     mm: introduce MADV_PAGEOUT
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1545f764600000
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=1745f764600000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1345f764600000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+8e6326965378936537c3@syzkaller.appspotmail.com
> Fixes: 06a833a1167e ("mm: introduce MADV_PAGEOUT")
> 
> raw: 01fffc0000090025 dead000000000100 dead000000000122 ffff88809c49f741
> raw: 0000000000020000 0000000000000000 00000002ffffffff ffff88821b6eaac0
> page dumped because: VM_BUG_ON_PAGE(PageActive(page))
> page->mem_cgroup:ffff88821b6eaac0
> ------------[ cut here ]------------
> kernel BUG at mm/vmscan.c:1156!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 9846 Comm: syz-executor110 Not tainted 5.3.0-rc2-next-20190729
> #54
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:shrink_page_list+0x2872/0x5430 mm/vmscan.c:1156

My old version had PG_active flag clear but it seems to lose it with revising
patchsets. Thanks, Sizbot!

From 66d64988619ef7e86b0002b2fc20fdf5b84ad49c Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Sat, 3 Aug 2019 04:54:02 +0900
Subject: [PATCH] mm: Clear PG_active on MADV_PAGEOUT

shrink_page_list expects every pages as argument should be no active
LRU pages so we need to clear PG_active.

Reported-by: syzbot+8e6326965378936537c3@syzkaller.appspotmail.com
Fixes: 06a833a1167e ("mm: introduce MADV_PAGEOUT")
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/vmscan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 47aa2158cfac2..e2a8d3f5bbe48 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2181,6 +2181,7 @@ unsigned long reclaim_pages(struct list_head *page_list)
 		}
 
 		if (nid == page_to_nid(page)) {
+			ClearPageActive(page);
 			list_move(&page->lru, &node_page_list);
 			continue;
 		}
-- 
2.22.0.770.g0f2c4a37fd-goog
