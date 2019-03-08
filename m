Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C77C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AFBD20857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n18p3TZo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfCHSnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:43:12 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34099 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfCHSnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:43:12 -0500
Received: by mail-pg1-f196.google.com with SMTP id i130so14816733pgd.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 10:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fCT/q+rh5tHWQqsygMsSNNwuHai0Tft4vTsyO7L17Pk=;
        b=n18p3TZo9bG3bEKWoESloAOmw4Y7aAy/1P6y1jZMXmrraF0lb3ITQRqz5r8e8I68ok
         TkMvkpv6vcZgmpCN7wQsfuludbOW6xJfTG236+tu+oDovXfZgdwYNsbcR9w8MKUlkx2w
         mtLmWaej0lm+i21i7FuExxNS4ExdSSxKvfHWhPNaJWvfqxMsnaJD62rhpFOvVbBIjLb4
         vM8Zc+Pv4LWwbrqYZw0i3/duewiaB5UH2Y7bD8tbBKZyYFgwbW/WF9OkZm6309RUBf6v
         W9xBaKpGr0g8Gc7RjSKDaVFc4OD6gxbM2Qt6bXO1wp5SxHBW0fyFos0fX+fNG8KCCpun
         Y7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fCT/q+rh5tHWQqsygMsSNNwuHai0Tft4vTsyO7L17Pk=;
        b=ZpnD+uh3Zc0ateW13k5v8pRssmQK2AkJRF7LHu/OewFvnv2wkfvQcNDqymv/+Zrz/5
         fSgWkAo6x00ZqGNatMYTPYm6SrPXzqCdFetV4Emz0jJkmPoRYNre5z3ktgQKWa0fb0L2
         lWyd+p1yyu7tAP+Wz+COWf2lp/Z1g+97ZtOIA16ZjK2w7xTayKQ/GB2Zz6Kv1x3u9PzX
         YnUiuQbdrWDE8DBAas8JukBwBgHnsZKlFaXtb46fp62sAPVUBbrFf16gMv7LHLv6+m+W
         gJwQmLVEizbB7f4CUAM4y7H+1aOv3aOIAt7rRRTWob1U4R/hvyTVGSXTJm8O/okfAz24
         aSZA==
X-Gm-Message-State: APjAAAXE3aroYPL8o840zXi+hb8P3P7Kdo3FgAsVtLro+g2RRgp6hfv1
        50e1t2neqysTOmC2NqwhnuCXhwnOTIskQ+TmINnqgg==
X-Google-Smtp-Source: APXvYqwFQUq4LYo5DTpFOxBonknM2ojh1ikoAZNllQMx4/NFwHkKh/MYS/rMZpBjyGdxI1WX7ckWqr7BQ7CSM9QXQuY=
X-Received: by 2002:a62:2b88:: with SMTP id r130mr19841925pfr.93.1552070590790;
 Fri, 08 Mar 2019 10:43:10 -0800 (PST)
MIME-Version: 1.0
References: <20190308161308.GC4676@magnolia> <CAKwvOdn0=1svhDUBEP+391NvUXhm8bkzBzNMgNphML8kRzrRJQ@mail.gmail.com>
 <20190308183830.GC20533@magnolia>
In-Reply-To: <20190308183830.GC20533@magnolia>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 8 Mar 2019 10:42:59 -0800
Message-ID: <CAKwvOdnpfQ_v3Hx0Y0ZjzQEet9DH+39RzMeG6rFqp6nw0ha7GQ@mail.gmail.com>
Subject: Re: [PATCH] xfs: clean up xfs_dir2_leafn_add
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 10:38 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Fri, Mar 08, 2019 at 10:12:33AM -0800, Nick Desaulniers wrote:
> > On Fri, Mar 8, 2019 at 8:13 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > >
> > > From: Darrick J. Wong <darrick.wong@oracle.com>
> > >
> > > Remove typedefs and consolidate local variable initialization.
> > >
> > > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> > > ---
> > >  fs/xfs/libxfs/xfs_dir2_node.c |   20 ++++++++------------
> > >  1 file changed, 8 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/fs/xfs/libxfs/xfs_dir2_node.c b/fs/xfs/libxfs/xfs_dir2_node.c
> > > index de46f26c5292..16731d2d684b 100644
> > > --- a/fs/xfs/libxfs/xfs_dir2_node.c
> > > +++ b/fs/xfs/libxfs/xfs_dir2_node.c
> > > @@ -426,26 +426,22 @@ xfs_dir2_leaf_to_node(
> > >  static int                                     /* error */
> > >  xfs_dir2_leafn_add(
> > >         struct xfs_buf          *bp,            /* leaf buffer */
> > > -       xfs_da_args_t           *args,          /* operation arguments */
> > > +       struct xfs_da_args      *args,          /* operation arguments */
> > >         int                     index)          /* insertion pt for new entry */
> > >  {
> > > +       struct xfs_dir3_icleaf_hdr leafhdr;
> > > +       struct xfs_inode        *dp = args->dp;
> > > +       struct xfs_dir2_leaf    *leaf = bp->b_addr;
> > > +       struct xfs_dir2_leaf_entry *lep;
> > > +       struct xfs_dir2_leaf_entry *ents;
> > >         int                     compact;        /* compacting stale leaves */
> > > -       xfs_inode_t             *dp;            /* incore directory inode */
> > > -       int                     highstale;      /* next stale entry */
> > > -       xfs_dir2_leaf_t         *leaf;          /* leaf structure */
> > > -       xfs_dir2_leaf_entry_t   *lep;           /* leaf entry */
> > > +       int                     highstale = 0;  /* next stale entry */
> > >         int                     lfloghigh;      /* high leaf entry logging */
> > >         int                     lfloglow;       /* low leaf entry logging */
> > > -       int                     lowstale;       /* previous stale entry */
> > > -       struct xfs_dir3_icleaf_hdr leafhdr;
> > > -       struct xfs_dir2_leaf_entry *ents;
> > > +       int                     lowstale = 0;   /* previous stale entry */
> > >
> > >         trace_xfs_dir2_leafn_add(args, index);
> > >
> > > -       dp = args->dp;
> > > -       leaf = bp->b_addr;
> > > -       highstale = 0;
> > > -       lowstale = 0;
> > >         dp->d_ops->leaf_hdr_from_disk(&leafhdr, leaf);
> > >         ents = dp->d_ops->leaf_ents_p(leaf);
> >
> > What about moving the initialization of `ents` above? (Or would that
> > be over the line limit?)
>
> It might be over the line limit, but more importantly I prefer to have
> the tracepoint fire before we start interpreting the on-disk metadata.
> That way, ftrace data will show exactly where we were in the kernel
> if any corruption warnings are emitted during that interpretation.
>
> I don't think either of those two functions do that today, but I don't
> want to leave a logic bomb in case they ever start doing that.

Makes sense, ents is initialized to the results of function call.
Thanks for the additional info, for accepting the earlier patch, and
this additional cleanup.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
