Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C59DC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3CC021721
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Mly4puGQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfJGMLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:11:48 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37028 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfJGMLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:11:47 -0400
Received: by mail-qt1-f196.google.com with SMTP id e15so3875547qtr.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 05:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RCF5WUeL70KwWiVqKG9GXvJo08D5Og4u1QhPAnWKSTE=;
        b=Mly4puGQiwAzIQFVLbvbJS16Fqlnueytn3BTgmS2t6Yt0TNZ1kqJp2O9CqYzOYNJnm
         XvFZ8L5fTRG2nRBRo6EPp8qR11cgsmN4FEFSzyTZf6h7l90MtEGLbfZL2FFRZsBaICjM
         9GuQbhrukWwvpw+OnjGAvjjWuJ1Y866SLgmddcHTci8yAR7aspVx4cOfr4MUyXTBz2kg
         rlx838O0Qcoh1Ivti0cWgcyXhk47Jo9JEGIdy58bixvp5k7sR1z9RfUBP9eYnQab2vhU
         h0CsWlHYdmpJSZnIoXRJz5MiT79IwFxlIsm3NNAQLkAowCyhThXrgKyKpUxTphMKyDwk
         XeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RCF5WUeL70KwWiVqKG9GXvJo08D5Og4u1QhPAnWKSTE=;
        b=qbvb8L503lBtxXfWLcT1imfr5z92Yf6x0Ai+9/s/bn1y8OGpt1IJ3Bt2r92807UJrt
         ReF2HH/e//eZ1ET2xGCY+wwPPL9zgS/SgXRlMyRWSSV3ywfWprjaxLZHBuOyiLGsxQkL
         TpzgV7JHvPqL6jJWE/4Kr8JlmYmfDTnmpSNNOe2+hm/5RvaPKT0/Ieb67hUItlbpX5fk
         ZTLp7v4/aZH5Q08DMrbGhjvc8+1mI7MRD5hM8ULDfvfVFUuQ1LdlQIWdU9PoQDRlA2oI
         /5PtzFnDQtStXGGlfdDambEUNsAe8gPQi0qmFigFdn1QuHosZNwDL43I6uWB1pl8arGw
         /7Zg==
X-Gm-Message-State: APjAAAWhaVyQTIU4dcK1hOwZOoep0XLPOHfpINE3wB7dX9QjPmxUm5Qr
        Lxj3vNZDnsgGUFP5ksohs/DsiA==
X-Google-Smtp-Source: APXvYqwhz6utGVR1K40YpnZd/19bixSstd/3DbwthdFT0Sg9j9Mt4BrCwcl4EGAQOlPgdk5Z8Olhhg==
X-Received: by 2002:ac8:7513:: with SMTP id u19mr29936591qtq.111.1570450306463;
        Mon, 07 Oct 2019 05:11:46 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q49sm10571235qta.60.2019.10.07.05.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 05:11:45 -0700 (PDT)
Message-ID: <1570450304.5576.283.camel@lca.pw>
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
From:   Qian Cai <cai@lca.pw>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, sergey.senozhatsky.work@gmail.com,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        david@redhat.com, john.ogness@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 07 Oct 2019 08:11:44 -0400
In-Reply-To: <20191007113710.GH2381@dhcp22.suse.cz>
References: <20191007080742.GD2381@dhcp22.suse.cz>
         <FB72D947-A0F9-43E7-80D9-D7ACE33849C7@lca.pw>
         <20191007113710.GH2381@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-10-07 at 13:37 +0200, Michal Hocko wrote:
> On Mon 07-10-19 07:04:00, Qian Cai wrote:
> > 
> > 
> > > On Oct 7, 2019, at 4:07 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > > 
> > > I do not think that removing the printk is the right long term solution.
> > > While I do agree that removing the debugging printk __offline_isolated_pages
> > > does make sense because it is essentially of a very limited use, this
> > > doesn't really solve the underlying problem.  There are likely other
> > > printks from zone->lock. It would be much more saner to actually
> > > disallow consoles to allocate any memory while printk is called from an
> > > atomic context.
> > 
> > No, there is only a handful of places called printk() from
> > zone->lock. It is normal that the callers will quietly process
> > “struct zone” modification in a short section with zone->lock
> > held.
> 
> It is extremely error prone to have any zone->lock vs. printk
> dependency. I do not want to play an endless whack a mole.
> 
> > No, it is not about “allocate any memory while printk is called from an
> > atomic context”. It is opposite lock chain  from different processors which has the same effect. For example,
> > 
> > CPU0:                 CPU1:         CPU2:
> > console_owner
> >                             sclp_lock
> > sclp_lock                                 zone_lock
> >                             zone_lock
> >                                                  console_owner
> 
> Why would sclp_lock ever take a zone->lock (apart from an allocation).
> So really if sclp_lock is a lock that might be taken from many contexts
> and generate very subtle lock dependencies then it should better be
> really careful what it is calling into.
> 
> In other words you are trying to fix a wrong end of the problem. Fix the
> console to not allocate or depend on MM by other means.

It looks there are way too many places that could generate those indirect lock
chains that are hard to eliminate them all. Here is anther example, where it
has,

console_owner -> port_lock
port_lock -> zone_lock

[  297.425922] -> #3 (&(&zone->lock)->rlock){-.-.}:
[  297.425925]        __lock_acquire+0x5b3/0xb40
[  297.425925]        lock_acquire+0x126/0x280
[  297.425926]        _raw_spin_lock+0x2f/0x40
[  297.425927]        rmqueue_bulk.constprop.21+0xb6/0x1160
[  297.425928]        get_page_from_freelist+0x898/0x22c0
[  297.425928]        __alloc_pages_nodemask+0x2f3/0x1cd0
[  297.425929]        alloc_pages_current+0x9c/0x110
[  297.425930]        allocate_slab+0x4c6/0x19c0
[  297.425931]        new_slab+0x46/0x70
[  297.425931]        ___slab_alloc+0x58b/0x960
[  297.425932]        __slab_alloc+0x43/0x70
[  297.425933]        __kmalloc+0x3ad/0x4b0
[  297.425933]        __tty_buffer_request_room+0x100/0x250
[  297.425934]        tty_insert_flip_string_fixed_flag+0x67/0x110
[  297.425935]        pty_write+0xa2/0xf0
[  297.425936]        n_tty_write+0x36b/0x7b0
[  297.425936]        tty_write+0x284/0x4c0
[  297.425937]        __vfs_write+0x50/0xa0
[  297.425938]        vfs_write+0x105/0x290
[  297.425939]        redirected_tty_write+0x6a/0xc0
[  297.425939]        do_iter_write+0x248/0x2a0
[  297.425940]        vfs_writev+0x106/0x1e0
[  297.425941]        do_writev+0xd4/0x180
[  297.425941]        __x64_sys_writev+0x45/0x50
[  297.425942]        do_syscall_64+0xcc/0x76c
[  297.425943]        entry_SYSCALL_64_after_hwframe+0x49/0xbe

