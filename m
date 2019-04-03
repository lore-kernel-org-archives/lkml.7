Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47459C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 00:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087CE2084A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 00:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MGvHXLaj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbfDCAbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 20:31:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45132 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfDCAbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 20:31:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id e24so7197167pfi.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 17:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=n2dsX0R8VOBMrOrZi+SHn9nLA+n4Op098PKZvmocm18=;
        b=MGvHXLajEkZYqBMYxvWthMt01ZfIkkSjBONDsK27h6jq47aHe/aBqTtCrR+veegBth
         H0y+KqQnIq4a5iqKaEdeSMJmaUMUOSkPqTdJhMN1x1TH2D3LSOGGcHvRp0zbmqvdhoIP
         M9t0/IUp8bQ6cYop55esJ5jCpbqFy8868tU1QzcgaypajUvOCPxrjRA7tHLHpeoA8ulF
         oS2JU/0MBjxHGcc7BxGOMIq14gxcs2tU3ptoovrmpsGKX0w1UlDk4dNpmuOoNKs696e9
         zMZxCZJfrITdZe9fITvbwRKPFJCtLboKJ8mxasGts7nfK4JgJFOMFG30O83fyVjuKIfs
         XYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=n2dsX0R8VOBMrOrZi+SHn9nLA+n4Op098PKZvmocm18=;
        b=lXkhk+wHRBkO69d2cNx/BMxmBla9d1m/E1RQTlJbWPn8a0ughBxI5cEZ7ASgFpdoMC
         A/Evo8klo3u6vg5JDYV+jLk8JBDWiZHXlbsHfItkq53hdvZBm4Fu0onUwQjhGBOb1kiR
         3gFY1rd0azSjQcmMOeSBFQFcN6uWKJ+pbivzhHrs69mgdHYGsv/H9jVPSA5WEpjBFwbK
         0aG6IZUScJHmGJAkI3m8VESWhifNc0O4Lj24gQ4l/YinllJlMtz4dUdSOcAp6UQaoecY
         e06A0Tzi5YywbI7P4eQhL1Rh8B45AdLDyGgcovMVOAnpRBSAI3SgBXnE/bavJYdlf9Z2
         Ca7w==
X-Gm-Message-State: APjAAAWq8LWNJu0aQonv9OcCHd+nVydb3aotSuXJ7QNPEs1d6aJIpbIb
        99VEsJmpSfTsSXU4r3Q21ZSqVQ==
X-Google-Smtp-Source: APXvYqziX1ApDI+q53pGhP23LTIArTYjM+6R3yWYlQ7UPVMBcBdtueu31ZANVauRmtp+akWGZCDb1w==
X-Received: by 2002:a62:61c2:: with SMTP id v185mr21047988pfb.117.1554251473291;
        Tue, 02 Apr 2019 17:31:13 -0700 (PDT)
Received: from [100.112.89.103] ([104.133.8.103])
        by smtp.gmail.com with ESMTPSA id k14sm15543948pfb.125.2019.04.02.17.31.11
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Apr 2019 17:31:12 -0700 (PDT)
Date:   Tue, 2 Apr 2019 17:30:52 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
cc:     Hugh Dickins <hughd@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Vineeth Pillai <vpillai@digitalocean.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kelley Nielsen <kelleynnn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Rik van Riel <riel@surriel.com>,
        Huang Ying <ying.huang@intel.com>
Subject: Re: shmem_recalc_inode: unable to handle kernel NULL pointer
 dereference
In-Reply-To: <alpine.LSU.2.11.1903311146040.2667@eggly.anvils>
Message-ID: <alpine.LSU.2.11.1904021701270.5045@eggly.anvils>
References: <1553440122.7s759munpm.astroid@alex-desktop.none> <CANaguZB8szw13MkaiT9kcN8Fux6hYZnuD-p6_OPve6n2fOTuoQ@mail.gmail.com> <1554048843.jjmwlalntd.astroid@alex-desktop.none> <alpine.LSU.2.11.1903311146040.2667@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Mar 2019, Hugh Dickins wrote:
> On Sun, 31 Mar 2019, Alex Xu (Hello71) wrote:
> > Excerpts from Vineeth Pillai's message of March 25, 2019 6:08 pm:
> > > On Sun, Mar 24, 2019 at 11:30 AM Alex Xu (Hello71) <alex_y_xu@yahoo.ca> wrote:
> > >>
> > >> I get this BUG in 5.1-rc1 sometimes when powering off the machine. I
> > >> suspect my setup erroneously executes two swapoff+cryptsetup close
> > >> operations simultaneously, so a race condition is triggered.
> > >>
> > >> I am using a single swap on a plain dm-crypt device on a MBR partition
> > >> on a SATA drive.
> > >>
> > >> I think the problem is probably related to
> > >> b56a2d8af9147a4efe4011b60d93779c0461ca97, so CCing the related people.
> > >>
> > > Could you please provide more information on this - stack trace, dmesg etc?
> > > Is it easily reproducible? If yes, please detail the steps so that I
> > > can try it inhouse.
> > > 
> > > Thanks,
> > > Vineeth
> > > 
> > 
> > Some info from the BUG entry (I didn't bother to type it all, 
> > low-quality image available upon request):
> > 
> > BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> > #PF error: [normal kernel read fault]
> > PGD 0 P4D 0
> > Oops: 0000 [#1] SMP
> > CPU: 0 Comm: swapoff Not tainted 5.1.0-rc1+ #2
> > RIP: 0010:shmem_recalc_inode+0x41/0x90
> > 
> > Call Trace:
> > ? shmem_undo_range
> > ? rb_erase_cached
> > ? set_next_entity
> > ? __inode_wait_for_writeback
> > ? shmem_truncate_range
> > ? shmem_evict_inode
> > ? evict
> > ? shmem_unuse
> > ? try_to_unuse
> > ? swapcache_free_entries
> > ? _cond_resched
> > ? __se_sys_swapoff
> > ? do_syscall_64
> > ? entry_SYSCALL_64_after_hwframe
> > 
> > As I said, it only occurs occasionally on shutdown. I think it is a safe 
> > guess that it can only occur when the swap is not empty, but possibly 
> > other conditions are necessary, so I will test further.
> 
> Thanks for the update, Alex. I'm looking into a couple of bugs with the
> 5.1-rc swapoff, but this one doesn't look like anything I know so far.
> shmem_recalc_inode() is a surprising place to crash: it's as if the
> igrab() in shmem_unuse() were not working. 
> 
> Yes, please do send Vineeth and me (or the lists) your low-quality image,
> in case we can extract any more info from it; and also please the
> disassembly of your kernel's shmem_recalc_inode(), so we can be sure of
> exactly what it's crashing on (though I expect that will leave me as
> puzzled as before).
> 
> If you want to experiment with one of my fixes, not yet written up and
> posted, just try changing SWAP_UNUSE_MAX_TRIES in mm/swapfile.c from
> 3 to INT_MAX: I don't see how that issue could manifest as crashing in
> shmem_recalc_inode(), but I may just be too stupid to see it.

Thanks for the image and disassembly you sent: which showed that the
ffffffff81117351:       48 83 3f 00             cmpq   $0x0,(%rdi)
you are crashing on, is the "if (sbinfo->max_blocks)" in the inlined
shmem_inode_unacct_blocks(): inode->i_sb->s_fs_info is NULL, which is
something that shmem_put_super() does.

Eight-year-old memories stirred: I knew when looking at Vineeth's patch,
that I ought to look back through the history of mm/shmem.c, to check
some points that Konstantin Khlebnikov had made years ago, that
surprised me then and were in danger of surprising us again with this
rework. But I failed to do so: thank you Alex, for reporting this bug
and pointing us back there.

igrab() protects from eviction but does not protect from unmounting.
I bet that is what you are hitting, though I've not even read through
2.6.39's 778dd893ae785 ("tmpfs: fix race between umount and swapoff")
again yet, and not begun to think of the fix for it this time around;
but wanted to let you know that this bug is now (probably) identified.

Hugh
