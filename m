Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BCCC432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 10:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E9321655
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 10:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569322440;
	bh=TKkEZXgQ6QrHyhUZpGQvpt1dC+CcQNzfSneNFogv0oA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xOQgkEUdF2sPq282FvcsXS0u9LVwKP+5hrDyyd2sl3EkLod7YAJxrmjKGbFGz/Dsx
	 7Pk+TCbf7AWfr2C+lbzZFX19bjQ1bMsOUuSYlenO/Gio1jHOcxpbCePh+DTD0XMZQZ
	 7ekmRKmey0gzAcsIgp9S260sL3X5gDq7mS0EaAq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440768AbfIXKyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 06:54:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:33116 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2438809AbfIXKx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 06:53:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D7807ACA0;
        Tue, 24 Sep 2019 10:53:56 +0000 (UTC)
Date:   Tue, 24 Sep 2019 12:53:55 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Thomas Lindroth <thomas.lindroth@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH] memcg, kmem: do not fail __GFP_NOFAIL charges
Message-ID: <20190924105355.GA28904@dhcp22.suse.cz>
References: <31131c2d-a936-8bbf-e58d-a3baaa457340@gmail.com>
 <20190906125608.32129-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906125608.32129-1-mhocko@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, do you plan to send this patch to Linus as ell?

On Fri 06-09-19 14:56:08, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> Thomas has noticed the following NULL ptr dereference when using cgroup
> v1 kmem limit:
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
> PGD 0
> P4D 0
> Oops: 0000 [#1] PREEMPT SMP PTI
> CPU: 3 PID: 16923 Comm: gtk-update-icon Not tainted 4.19.51 #42
> Hardware name: Gigabyte Technology Co., Ltd. Z97X-Gaming G1/Z97X-Gaming G1, BIOS F9 07/31/2015
> RIP: 0010:create_empty_buffers+0x24/0x100
> Code: cd 0f 1f 44 00 00 0f 1f 44 00 00 41 54 49 89 d4 ba 01 00 00 00 55 53 48 89 fb e8 97 fe ff ff 48 89 c5 48 89 c2 eb 03 48 89 ca <48> 8b 4a 08 4c 09 22 48 85 c9 75 f1 48 89 6a 08 48 8b 43 18 48 8d
> RSP: 0018:ffff927ac1b37bf8 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: fffff2d4429fd740 RCX: 0000000100097149
> RDX: 0000000000000000 RSI: 0000000000000082 RDI: ffff9075a99fbe00
> RBP: 0000000000000000 R08: fffff2d440949cc8 R09: 00000000000960c0
> R10: 0000000000000002 R11: 0000000000000000 R12: 0000000000000000
> R13: ffff907601f18360 R14: 0000000000002000 R15: 0000000000001000
> FS:  00007fb55b288bc0(0000) GS:ffff90761f8c0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000008 CR3: 000000007aebc002 CR4: 00000000001606e0
> Call Trace:
>  create_page_buffers+0x4d/0x60
>  __block_write_begin_int+0x8e/0x5a0
>  ? ext4_inode_attach_jinode.part.82+0xb0/0xb0
>  ? jbd2__journal_start+0xd7/0x1f0
>  ext4_da_write_begin+0x112/0x3d0
>  generic_perform_write+0xf1/0x1b0
>  ? file_update_time+0x70/0x140
>  __generic_file_write_iter+0x141/0x1a0
>  ext4_file_write_iter+0xef/0x3b0
>  __vfs_write+0x17e/0x1e0
>  vfs_write+0xa5/0x1a0
>  ksys_write+0x57/0xd0
>  do_syscall_64+0x55/0x160
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
>  Tetsuo then noticed that this is because the __memcg_kmem_charge_memcg
>  fails __GFP_NOFAIL charge when the kmem limit is reached. This is a
>  wrong behavior because nofail allocations are not allowed to fail.
>  Normal charge path simply forces the charge even if that means to cross
>  the limit. Kmem accounting should be doing the same.
> 
> Reported-by: Thomas Lindroth <thomas.lindroth@gmail.com>
> Debugged-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Cc: stable
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/memcontrol.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 9ec5e12486a7..e18108b2b786 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2821,6 +2821,16 @@ int __memcg_kmem_charge_memcg(struct page *page, gfp_t gfp, int order,
>  
>  	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) &&
>  	    !page_counter_try_charge(&memcg->kmem, nr_pages, &counter)) {
> +
> +		/*
> +		 * Enforce __GFP_NOFAIL allocation because callers are not
> +		 * prepared to see failures and likely do not have any failure
> +		 * handling code.
> +		 */
> +		if (gfp & __GFP_NOFAIL) {
> +			page_counter_charge(&memcg->kmem, nr_pages);
> +			return 0;
> +		}
>  		cancel_charge(memcg, nr_pages);
>  		return -ENOMEM;
>  	}
> -- 
> 2.20.1

-- 
Michal Hocko
SUSE Labs
