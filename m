Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051A8C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 19:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBD320870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 19:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Us8FORhm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731420AbfCaTVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 15:21:38 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43741 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfCaTVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 15:21:37 -0400
Received: by mail-oi1-f196.google.com with SMTP id t81so5505322oig.10
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 12:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=4yDtqtEgAp/LWVi4nPGb0Lvky010NJosRkxeKByHLt8=;
        b=Us8FORhmCR72lg0QlwJAtR8yhm/5UwSNt/znsLErlS+afM+kcangpnQDZnOqrlDPz8
         hdQesJkG3pQvPFeDD4FbkAKKUbomjBhNZ8myzhNdGn66YHrE97YEUBJiKix6l8scVh3w
         TtHECwTMNRvk0MwW1VZYJWIKGVUhxLlBPSFNCF7BZppy0ubCTmxQFOcNpzwxDX41/4bw
         ge4y3o+ha5xaSm/3WHmU8q6ZH+vK1D3hRma/iaz8G4G5sN48eF6CKiDB5YznnmbeUggN
         P89sJwK7HFqb8d8Cy5qMSFD4xIBq0n/k451jK2Ywr3uDCcBTao1hIO7GrAFuhUd9yT20
         WzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=4yDtqtEgAp/LWVi4nPGb0Lvky010NJosRkxeKByHLt8=;
        b=okQcLD9pvl6wGGNuOvRP4Mt7S46g+OAeUkzXUeRu2bIuuFw4qlMGpTgh74I/zdsjr7
         nY1nF2eBou8IC+p0LOKkFvx6f0YkrUXi9pzbDNXW4/7XGVA32n8A34DbXPOXOT4V7x2o
         8ScExLKp0PC1ME7rhcj98yg7i5jNIQRsbv9DdnDe2JZR1FryqqtAxzaxP1Z/uA1ZcUjv
         GXtkpybMdNy1N604nvNiP1dbacexU98vh00+XwjckQ3Vs305BOlCEbmLWzSKJ+SvdsWY
         e2Eb39341mYmxYP0GnRHjg3wZhG4Chrw8bYCQLcGYSSgCmdlysIh9fcaNt08O2QE/Z4X
         8GeQ==
X-Gm-Message-State: APjAAAUuOGl+BRP/QAt4Zj1eUaj4mYOCOA6/6Otr8WTvBRZFWaLZbJfh
        0PZI1jgfgqkxjyW+Dxtjzppk3w==
X-Google-Smtp-Source: APXvYqzXJvQZMUNwegdIOLr2gkKsgtKnU57/PRrJJMa73WSU6Chpwhxlpk8tOgK2cHSakrAurOAvLw==
X-Received: by 2002:a54:4f85:: with SMTP id g5mr10144271oiy.35.1554060096864;
        Sun, 31 Mar 2019 12:21:36 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id q25sm486885otl.60.2019.03.31.12.21.34
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Mar 2019 12:21:35 -0700 (PDT)
Date:   Sun, 31 Mar 2019 12:21:15 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
cc:     Vineeth Pillai <vpillai@digitalocean.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Kelley Nielsen <kelleynnn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Rik van Riel <riel@surriel.com>,
        Huang Ying <ying.huang@intel.com>
Subject: Re: shmem_recalc_inode: unable to handle kernel NULL pointer
 dereference
In-Reply-To: <1554048843.jjmwlalntd.astroid@alex-desktop.none>
Message-ID: <alpine.LSU.2.11.1903311146040.2667@eggly.anvils>
References: <1553440122.7s759munpm.astroid@alex-desktop.none> <CANaguZB8szw13MkaiT9kcN8Fux6hYZnuD-p6_OPve6n2fOTuoQ@mail.gmail.com> <1554048843.jjmwlalntd.astroid@alex-desktop.none>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Mar 2019, Alex Xu (Hello71) wrote:
> Excerpts from Vineeth Pillai's message of March 25, 2019 6:08 pm:
> > On Sun, Mar 24, 2019 at 11:30 AM Alex Xu (Hello71) <alex_y_xu@yahoo.ca> wrote:
> >>
> >> I get this BUG in 5.1-rc1 sometimes when powering off the machine. I
> >> suspect my setup erroneously executes two swapoff+cryptsetup close
> >> operations simultaneously, so a race condition is triggered.
> >>
> >> I am using a single swap on a plain dm-crypt device on a MBR partition
> >> on a SATA drive.
> >>
> >> I think the problem is probably related to
> >> b56a2d8af9147a4efe4011b60d93779c0461ca97, so CCing the related people.
> >>
> > Could you please provide more information on this - stack trace, dmesg etc?
> > Is it easily reproducible? If yes, please detail the steps so that I
> > can try it inhouse.
> > 
> > Thanks,
> > Vineeth
> > 
> 
> Some info from the BUG entry (I didn't bother to type it all, 
> low-quality image available upon request):
> 
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> #PF error: [normal kernel read fault]
> PGD 0 P4D 0
> Oops: 0000 [#1] SMP
> CPU: 0 Comm: swapoff Not tainted 5.1.0-rc1+ #2
> RIP: 0010:shmem_recalc_inode+0x41/0x90
> 
> Call Trace:
> ? shmem_undo_range
> ? rb_erase_cached
> ? set_next_entity
> ? __inode_wait_for_writeback
> ? shmem_truncate_range
> ? shmem_evict_inode
> ? evict
> ? shmem_unuse
> ? try_to_unuse
> ? swapcache_free_entries
> ? _cond_resched
> ? __se_sys_swapoff
> ? do_syscall_64
> ? entry_SYSCALL_64_after_hwframe
> 
> As I said, it only occurs occasionally on shutdown. I think it is a safe 
> guess that it can only occur when the swap is not empty, but possibly 
> other conditions are necessary, so I will test further.

Thanks for the update, Alex. I'm looking into a couple of bugs with the
5.1-rc swapoff, but this one doesn't look like anything I know so far.
shmem_recalc_inode() is a surprising place to crash: it's as if the
igrab() in shmem_unuse() were not working. 

Yes, please do send Vineeth and me (or the lists) your low-quality image,
in case we can extract any more info from it; and also please the
disassembly of your kernel's shmem_recalc_inode(), so we can be sure of
exactly what it's crashing on (though I expect that will leave me as
puzzled as before).

If you want to experiment with one of my fixes, not yet written up and
posted, just try changing SWAP_UNUSE_MAX_TRIES in mm/swapfile.c from
3 to INT_MAX: I don't see how that issue could manifest as crashing in
shmem_recalc_inode(), but I may just be too stupid to see it.

Thanks,
Hugh
