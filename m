Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C618AC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 11:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 956AF2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 11:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568028169;
	bh=djir5zIjxtB7vbKGxBqG3x1AAyvfHdo7BAfPDPCNLXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u94Fv7k/yxMus2yO3qMUEQ2jUFz6r0z8Q+nqfnzbZhQU87ifEXFoLo0OdQ2f7P+Q+
	 BFCEMHL8qa2I/vh0oXRk5x4OyDmGWjAQzjnUZPe+ydbUR1EFIe7b+iPR7YM0v7uq5h
	 co2YqAZyfmPmH9WO8pR9A0fHBfKet3c0m1Hy8cfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390201AbfIILWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 07:22:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:44018 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729339AbfIILWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 07:22:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 38CA5ACD8;
        Mon,  9 Sep 2019 11:22:46 +0000 (UTC)
Date:   Mon, 9 Sep 2019 13:22:45 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Thomas Lindroth <thomas.lindroth@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH] memcg, kmem: do not fail __GFP_NOFAIL charges
Message-ID: <20190909112245.GH27159@dhcp22.suse.cz>
References: <31131c2d-a936-8bbf-e58d-a3baaa457340@gmail.com>
 <20190906125608.32129-1-mhocko@kernel.org>
 <CALvZod5w72jH8fJSFRaw7wgQTnzF6nb=+St-sSXVGSiG6Bs3Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5w72jH8fJSFRaw7wgQTnzF6nb=+St-sSXVGSiG6Bs3Lg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 06-09-19 11:24:55, Shakeel Butt wrote:
> On Fri, Sep 6, 2019 at 5:56 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > From: Michal Hocko <mhocko@suse.com>
> >
> > Thomas has noticed the following NULL ptr dereference when using cgroup
> > v1 kmem limit:
> > BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
> > PGD 0
> > P4D 0
> > Oops: 0000 [#1] PREEMPT SMP PTI
> > CPU: 3 PID: 16923 Comm: gtk-update-icon Not tainted 4.19.51 #42
> > Hardware name: Gigabyte Technology Co., Ltd. Z97X-Gaming G1/Z97X-Gaming G1, BIOS F9 07/31/2015
> > RIP: 0010:create_empty_buffers+0x24/0x100
> > Code: cd 0f 1f 44 00 00 0f 1f 44 00 00 41 54 49 89 d4 ba 01 00 00 00 55 53 48 89 fb e8 97 fe ff ff 48 89 c5 48 89 c2 eb 03 48 89 ca <48> 8b 4a 08 4c 09 22 48 85 c9 75 f1 48 89 6a 08 48 8b 43 18 48 8d
> > RSP: 0018:ffff927ac1b37bf8 EFLAGS: 00010286
> > RAX: 0000000000000000 RBX: fffff2d4429fd740 RCX: 0000000100097149
> > RDX: 0000000000000000 RSI: 0000000000000082 RDI: ffff9075a99fbe00
> > RBP: 0000000000000000 R08: fffff2d440949cc8 R09: 00000000000960c0
> > R10: 0000000000000002 R11: 0000000000000000 R12: 0000000000000000
> > R13: ffff907601f18360 R14: 0000000000002000 R15: 0000000000001000
> > FS:  00007fb55b288bc0(0000) GS:ffff90761f8c0000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000000008 CR3: 000000007aebc002 CR4: 00000000001606e0
> > Call Trace:
> >  create_page_buffers+0x4d/0x60
> >  __block_write_begin_int+0x8e/0x5a0
> >  ? ext4_inode_attach_jinode.part.82+0xb0/0xb0
> >  ? jbd2__journal_start+0xd7/0x1f0
> >  ext4_da_write_begin+0x112/0x3d0
> >  generic_perform_write+0xf1/0x1b0
> >  ? file_update_time+0x70/0x140
> >  __generic_file_write_iter+0x141/0x1a0
> >  ext4_file_write_iter+0xef/0x3b0
> >  __vfs_write+0x17e/0x1e0
> >  vfs_write+0xa5/0x1a0
> >  ksys_write+0x57/0xd0
> >  do_syscall_64+0x55/0x160
> >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
> >  Tetsuo then noticed that this is because the __memcg_kmem_charge_memcg
> >  fails __GFP_NOFAIL charge when the kmem limit is reached. This is a
> >  wrong behavior because nofail allocations are not allowed to fail.
> >  Normal charge path simply forces the charge even if that means to cross
> >  the limit. Kmem accounting should be doing the same.
> >
> > Reported-by: Thomas Lindroth <thomas.lindroth@gmail.com>
> > Debugged-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> > Cc: stable
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> 
> I wonder what has changed since
> <http://lkml.kernel.org/r/20180525185501.82098-1-shakeelb@google.com/>.

I have completely forgot about that one. It seems that we have just
repeated the same discussion again. This time we have a poor user who
actually enabled the kmem limit.

I guess there was no real objection to the change back then. The primary
discussion revolved around the fact that the accounting will stay broken
even when this particular part was fixed. Considering this leads to easy
to trigger crash (with the limit enabled) then I guess we should just
make it less broken and backport to stable trees and have a serious
discussion about discontinuing of the limit. Start by simply failing to
set any limit in the current upstream kernels.

-- 
Michal Hocko
SUSE Labs
