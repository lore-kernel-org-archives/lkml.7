Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CCFC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C29206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pOEUKjHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731872AbfHFHua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 03:50:30 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46171 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbfHFHua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 03:50:30 -0400
Received: by mail-ot1-f65.google.com with SMTP id z23so61917734ote.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 00:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=kWFJ9VXWY9elnW+Cpayl7VN+eLgA38VWzMzPMfOSo/4=;
        b=pOEUKjHZrG9frTrjhAHloZ07xJ3LROaCTkRB9MivU7GBayjsVbeU6wMMDGVhhLdu2P
         ImdbTERwKFKukEw/kJrzyN4wlCnm1R6QN+XHy33VfJzQKySBEx/ibsMY+0xu2ZglMEaJ
         3l/2WR7I8VtuWCjUEJWoPvM1Fmcz4cCWzCaFEafICEUOsKNXop7K8jAwLixrkq6QOJtJ
         c2F3FxbUvarZfm/gKoC98fkt7c2PQpQHNqgri2uGvWagH7CrRLfVy9Zrkn/cCFpElw++
         Ab9wA1mMgC2J08lGAS8gqUkXdhIgAvg/eWTfBX/s9anS7JZq2FeYqcuJq1M61EBREiPN
         fXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=kWFJ9VXWY9elnW+Cpayl7VN+eLgA38VWzMzPMfOSo/4=;
        b=Pwfcdl/1OS5Mo4ytF1tAhNK6NyD5Xxh/YSfwjjY3MkJQ0BJzplJvUtlWZ8BLB06LYr
         ejmuyPLC2UNu2PV9WXXkGDo92WcXhDSiNu1XqOvvGRNjpJo5OZS+r+8kxAZdKWJZsDqK
         U1JbW5hfyQm1VOiVCdJC6D0EQqWlyukrL7IN25M8c2R44sdF8LcJW6MBncg+TPFda2Hu
         8U7ManVi2QghefStQc2Xz2OFpfeNik4ZLVgsSRg6yEodmsGo9G7OMof1nKiUVN4HrRWx
         rA89AstaMxrdzmvgTmeHEbZwOEeIFQoW3X7Ds7PfkcimIpfctlxcsuO8rHx88WykgGqt
         f+aQ==
X-Gm-Message-State: APjAAAUrJBie0ECmdwYo+dHV3K1jYb1MTHBEUNnXM4eTFKKrR1JToy4x
        P2qMYKkedHl6qKl5I66ro52uCQ==
X-Google-Smtp-Source: APXvYqy2hlvgRI1T/Tn9lMwpCjyMQ41DUBhpPKmBl6Yh+3BnU14/PszBmVh19Kd3ubPgWPa1wTIdiQ==
X-Received: by 2002:a9d:5787:: with SMTP id q7mr2061375oth.75.1565077828501;
        Tue, 06 Aug 2019 00:50:28 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g6sm28504405otl.50.2019.08.06.00.50.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Aug 2019 00:50:27 -0700 (PDT)
Date:   Tue, 6 Aug 2019 00:50:10 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Al Viro <viro@zeniv.linux.org.uk>
cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCHv2 2/3] i915: convert to new mount API
In-Reply-To: <20190805182834.GI1131@ZenIV.linux.org.uk>
Message-ID: <alpine.LSU.2.11.1908060007190.1941@eggly.anvils>
References: <20190805160307.5418-1-sergey.senozhatsky@gmail.com> <20190805160307.5418-3-sergey.senozhatsky@gmail.com> <20190805181255.GH1131@ZenIV.linux.org.uk> <20190805182834.GI1131@ZenIV.linux.org.uk>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Aug 2019, Al Viro wrote:
> On Mon, Aug 05, 2019 at 07:12:55PM +0100, Al Viro wrote:
> > On Tue, Aug 06, 2019 at 01:03:06AM +0900, Sergey Senozhatsky wrote:
> > > tmpfs does not set ->remount_fs() anymore and its users need
> > > to be converted to new mount API.
> > 
> > Could you explain why the devil do you bother with remount at all?
> > Why not pass the right options when mounting the damn thing?
> 
> ... and while we are at it, I really wonder what's going on with
> that gemfs thing - among the other things, this is the only
> user of shmem_file_setup_with_mnt().  Sure, you want your own
> options, but that brings another question - is there any reason
> for having the huge=... per-superblock rather than per-file?

Yes: we want a default for how files of that superblock are to
allocate their pages, without people having to fcntl or advise
each of their files.

Setting aside the weirder options (within_size, advise) and emergency/
testing override (shmem_huge), we want files on an ordinary default
tmpfs (huge=never) to be allocated with small pages (so users with
access to that filesystem will not consume, and will not waste time
and space on consuming, the more valuable huge pages); but files on a
huge=always tmpfs to be allocated with huge pages whenever possible.

Or am I missing your point?  Yes, hugeness can certainly be decided
differently per-file, or even per-extent of file.  That is already
made possible through "judicious" use of madvise MADV_HUGEPAGE and
MADV_NOHUGEPAGE on mmaps of the file, carried over from anon THP.

Though personally I'm averse to managing "f"objects through
"m"interfaces, which can get ridiculous (notably, MADV_HUGEPAGE works
on the virtual address of a mapping, but the huge-or-not alignment of
that mapping must have been decided previously).  In Google we do use
fcntls F_HUGEPAGE and F_NOHUGEPAGE to override on a per-file basis -
one day I'll get to upstreaming those.

Hugh

> 
> After all, the readers of ->huge in mm/shmem.c are
> mm/shmem.c:582:     (shmem_huge == SHMEM_HUGE_FORCE || sbinfo->huge) &&
> 	is_huge_enabled(), sbinfo is an explicit argument
> 
> mm/shmem.c:1799:        switch (sbinfo->huge) {
> 	shmem_getpage_gfp(), sbinfo comes from inode
> 
> mm/shmem.c:2113:                if (SHMEM_SB(sb)->huge == SHMEM_HUGE_NEVER)
> 	shmem_get_unmapped_area(), sb comes from file
> 
> mm/shmem.c:3531:        if (sbinfo->huge)
> mm/shmem.c:3532:                seq_printf(seq, ",huge=%s", shmem_format_huge(sbinfo->huge));
> 	->show_options()
> mm/shmem.c:3880:        switch (sbinfo->huge) {
> 	shmem_huge_enabled(), sbinfo comes from an inode
> 
> And the only caller of is_huge_enabled() is shmem_getattr(), with sbinfo
> picked from inode.
> 
> So is there any reason why the hugepage policy can't be per-file, with
> the current being overridable default?
