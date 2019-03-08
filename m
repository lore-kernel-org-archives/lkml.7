Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22658C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 23:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01622081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 23:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+1Sm488"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfCHXbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 18:31:36 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42939 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfCHXbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 18:31:36 -0500
Received: by mail-ed1-f65.google.com with SMTP id j89so17667742edb.9;
        Fri, 08 Mar 2019 15:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C3/hDN19vuYvl9X0TTZVxwDKfuP5oNkT4n3FaWujp1s=;
        b=O+1Sm488R71zJDzpvPiKOMbNr4kvuG17pKWUVpW4EV5Qdy2LJiJiD/t4gB6ZQAl5+Z
         cB/TtYsE+sfzg7yZ7JLljmkKoK6ljAc95ROEVNz4uK/B+x64dP0Nhf3zUAC6Yiq3I/8V
         jeA0z2KoZt6BWAvN6TMXgnVP14UE0SuqmmoMSh7IuLHBV6htLGiX+Q2p2NwBLRtzU5xh
         pwtoNPMF9NpyTYpLAzG9K682qhxuKFcNeO5K2dM4NXsA6qZ0RAOtbRAW1Ekub+sAgcJM
         5S7FTpjmXaZY7PdfX0bVY8+5K9i/g36tuscepq/lcoi9N3I9RSZMbHJDXye47MaPxcSM
         kSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C3/hDN19vuYvl9X0TTZVxwDKfuP5oNkT4n3FaWujp1s=;
        b=dAtM+o4sKUqb3WBdeKmIxvv0gFDFCCoWt1bMj+8Nz6SvHN4lwBDkAAcvJDC6eWAViR
         C+5KELODp7QhkCMp5xH8B68xD3W0LLLtcJyzi2bQVBcaOz83R2iTCGS5yZrx3gVahDon
         lYKXlBo25+kLwgP1jxm5xGUpTIlBuQRGv4UnmA3hLXv767GoafBka94ferh8fk2VsIBu
         D170mSCUSBSyvi811HRTL6KQ290LGHUTaTLxScnH5YmI9q2vv2dg9MA7iEEs4jhorOiO
         spYCDnsef1iNjmUIKL8JipNjt7r444qkUdTgv8y2OwR63GcakP+4lcZ2trEkFMvX//Dq
         hl5w==
X-Gm-Message-State: APjAAAWw4W0lFYn3gcO/qH8O5J5zzP5DQc6qzXlNpsBOVdGTBoHPdyda
        6nvDbqAcASzNxFOMlBFF/fM=
X-Google-Smtp-Source: APXvYqxu2CStdRKnRt00BwWOlMq0waEtzNdMCfGnXFHKOhGR0FN9BcrANkXZGxsEGJ+Ecxn+er024A==
X-Received: by 2002:a17:906:3719:: with SMTP id d25mr13159497ejc.142.1552087893118;
        Fri, 08 Mar 2019 15:31:33 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id b24sm2528309ede.93.2019.03.08.15.31.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 08 Mar 2019 15:31:32 -0800 (PST)
Date:   Fri, 8 Mar 2019 16:31:30 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-xfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] xfs: clean up xfs_dir2_leafn_add
Message-ID: <20190308233130.GA13211@archlinux-ryzen>
References: <20190308161308.GC4676@magnolia>
 <CAKwvOdn0=1svhDUBEP+391NvUXhm8bkzBzNMgNphML8kRzrRJQ@mail.gmail.com>
 <20190308183830.GC20533@magnolia>
 <CAKwvOdnpfQ_v3Hx0Y0ZjzQEet9DH+39RzMeG6rFqp6nw0ha7GQ@mail.gmail.com>
 <20190308231114.GD4676@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308231114.GD4676@magnolia>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 03:11:14PM -0800, Darrick J. Wong wrote:
> On Fri, Mar 08, 2019 at 10:42:59AM -0800, Nick Desaulniers wrote:
> > On Fri, Mar 8, 2019 at 10:38 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > >
> > > On Fri, Mar 08, 2019 at 10:12:33AM -0800, Nick Desaulniers wrote:
> > > > On Fri, Mar 8, 2019 at 8:13 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > > > >
> > > > > From: Darrick J. Wong <darrick.wong@oracle.com>
> > > > >
> > > > > Remove typedefs and consolidate local variable initialization.
> > > > >
> > > > > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> > > > > ---
> > > > >  fs/xfs/libxfs/xfs_dir2_node.c |   20 ++++++++------------
> > > > >  1 file changed, 8 insertions(+), 12 deletions(-)
> > > > >
> > > > > diff --git a/fs/xfs/libxfs/xfs_dir2_node.c b/fs/xfs/libxfs/xfs_dir2_node.c
> > > > > index de46f26c5292..16731d2d684b 100644
> > > > > --- a/fs/xfs/libxfs/xfs_dir2_node.c
> > > > > +++ b/fs/xfs/libxfs/xfs_dir2_node.c
> > > > > @@ -426,26 +426,22 @@ xfs_dir2_leaf_to_node(
> > > > >  static int                                     /* error */
> > > > >  xfs_dir2_leafn_add(
> > > > >         struct xfs_buf          *bp,            /* leaf buffer */
> > > > > -       xfs_da_args_t           *args,          /* operation arguments */
> > > > > +       struct xfs_da_args      *args,          /* operation arguments */
> > > > >         int                     index)          /* insertion pt for new entry */
> > > > >  {
> > > > > +       struct xfs_dir3_icleaf_hdr leafhdr;
> > > > > +       struct xfs_inode        *dp = args->dp;
> > > > > +       struct xfs_dir2_leaf    *leaf = bp->b_addr;
> > > > > +       struct xfs_dir2_leaf_entry *lep;
> > > > > +       struct xfs_dir2_leaf_entry *ents;
> > > > >         int                     compact;        /* compacting stale leaves */
> > > > > -       xfs_inode_t             *dp;            /* incore directory inode */
> > > > > -       int                     highstale;      /* next stale entry */
> > > > > -       xfs_dir2_leaf_t         *leaf;          /* leaf structure */
> > > > > -       xfs_dir2_leaf_entry_t   *lep;           /* leaf entry */
> > > > > +       int                     highstale = 0;  /* next stale entry */
> > > > >         int                     lfloghigh;      /* high leaf entry logging */
> > > > >         int                     lfloglow;       /* low leaf entry logging */
> > > > > -       int                     lowstale;       /* previous stale entry */
> > > > > -       struct xfs_dir3_icleaf_hdr leafhdr;
> > > > > -       struct xfs_dir2_leaf_entry *ents;
> > > > > +       int                     lowstale = 0;   /* previous stale entry */
> > > > >
> > > > >         trace_xfs_dir2_leafn_add(args, index);
> > > > >
> > > > > -       dp = args->dp;
> > > > > -       leaf = bp->b_addr;
> > > > > -       highstale = 0;
> > > > > -       lowstale = 0;
> > > > >         dp->d_ops->leaf_hdr_from_disk(&leafhdr, leaf);
> > > > >         ents = dp->d_ops->leaf_ents_p(leaf);
> > > >
> > > > What about moving the initialization of `ents` above? (Or would that
> > > > be over the line limit?)
> > >
> > > It might be over the line limit, but more importantly I prefer to have
> > > the tracepoint fire before we start interpreting the on-disk metadata.
> > > That way, ftrace data will show exactly where we were in the kernel
> > > if any corruption warnings are emitted during that interpretation.
> > >
> > > I don't think either of those two functions do that today, but I don't
> > > want to leave a logic bomb in case they ever start doing that.
> > 
> > Makes sense, ents is initialized to the results of function call.
> > Thanks for the additional info, for accepting the earlier patch, and
> > this additional cleanup.
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> Thanks for the review!
> 
> By the way, does clang complain about highstale/lowstale in
> xfs_dir2_leaf_addname being uninitialized too?  Just wondering since
> smatch/sparse do...
> 

It does not, which is bizarre since it's the exact same pattern.
Definitely something to look into...

Cheers,
Nathan

> --D
> 
> > -- 
> > Thanks,
> > ~Nick Desaulniers
