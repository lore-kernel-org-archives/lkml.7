Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECBAC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA4320661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q+lIYvzL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfCHSMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:12:45 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44683 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbfCHSMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:12:45 -0500
Received: by mail-pf1-f193.google.com with SMTP id a3so14699633pff.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 10:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uASqtyhskBuyetjtRVvXKTeWM1LpQ5vZLTX/Se1yo+o=;
        b=q+lIYvzLWjXaU1LpEkwRX86FUU2Vul0SPdu03tw9bNvfMIJfnruTk3g+y/omuWOgs7
         2dtxCZyzoA/PtjKfsRBavNx1OIpqlYllCU3C4i2EPgg4fRDJ3kQu8Do6AEg3PGp2uYtf
         yfuQcV44isGs/4yY36tzI90mQ+cgRM0dK0+IItD/hziKdVl87DLy5tA+smChonT9DED9
         7l7glRvIGHTR84zr8/TCyevn+n1IVEYlBprplBwIWF30ZCK4HTmMWvTwFkTI5xeBVTbA
         1GAyayeM6oJsHuign3MU9gmPWTSb51uIhn0QD++0Y91kymxdKFuDnCm973IraibZdSQJ
         te4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uASqtyhskBuyetjtRVvXKTeWM1LpQ5vZLTX/Se1yo+o=;
        b=t5XwKyAmrdgI5DtPqeDtzhXZQbPf2zmpXBnyHYhjvjpxSxHZ3bDieAfptGwUuTnWrn
         7DpZ+Hlf51eM8oKleBNjKmmlXGO3Ez3F/VCOOYII1Ru47qjGTCRSasb3xuf9XynBismf
         9OpNm6//SNlanwKVqhXLJ5HAwc6rWc6lU09YC65hMmVOW7HDVtkW4uXY1Fm/P2FZS0cO
         e4N+sgzi44hzItSaLh/Sj3l14XzkYEznWPuodBXmt/JBt07hQ+0dea+PGYsjfZY4yIVP
         SUqACFP+H/+b5qtiORJKY27hnY8idDZxzWWRHhPFT/TZvaMCt0KouZ0EnXeW9kpBbXRX
         HrvA==
X-Gm-Message-State: APjAAAW2/Phd+PvHMdROrg8I2YltXyQ6ac7oyLR7ve3SvOvHDH251iJI
        9rHsFkaQsvkPIXYKF25Ikte/gwUJqRwL0O+5MLb1Xw==
X-Google-Smtp-Source: APXvYqylJYokuEjx9n40AVgT4cMQ0uPCb3wfIvT5gorz5nEXQbS0JgRkdWstW/kYsbHnDNufQgvSlmBSzoEFAlsKGw0=
X-Received: by 2002:a62:a113:: with SMTP id b19mr19565898pff.227.1552068764438;
 Fri, 08 Mar 2019 10:12:44 -0800 (PST)
MIME-Version: 1.0
References: <20190308161308.GC4676@magnolia>
In-Reply-To: <20190308161308.GC4676@magnolia>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 8 Mar 2019 10:12:33 -0800
Message-ID: <CAKwvOdn0=1svhDUBEP+391NvUXhm8bkzBzNMgNphML8kRzrRJQ@mail.gmail.com>
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

On Fri, Mar 8, 2019 at 8:13 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> From: Darrick J. Wong <darrick.wong@oracle.com>
>
> Remove typedefs and consolidate local variable initialization.
>
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
>  fs/xfs/libxfs/xfs_dir2_node.c |   20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/fs/xfs/libxfs/xfs_dir2_node.c b/fs/xfs/libxfs/xfs_dir2_node.c
> index de46f26c5292..16731d2d684b 100644
> --- a/fs/xfs/libxfs/xfs_dir2_node.c
> +++ b/fs/xfs/libxfs/xfs_dir2_node.c
> @@ -426,26 +426,22 @@ xfs_dir2_leaf_to_node(
>  static int                                     /* error */
>  xfs_dir2_leafn_add(
>         struct xfs_buf          *bp,            /* leaf buffer */
> -       xfs_da_args_t           *args,          /* operation arguments */
> +       struct xfs_da_args      *args,          /* operation arguments */
>         int                     index)          /* insertion pt for new entry */
>  {
> +       struct xfs_dir3_icleaf_hdr leafhdr;
> +       struct xfs_inode        *dp = args->dp;
> +       struct xfs_dir2_leaf    *leaf = bp->b_addr;
> +       struct xfs_dir2_leaf_entry *lep;
> +       struct xfs_dir2_leaf_entry *ents;
>         int                     compact;        /* compacting stale leaves */
> -       xfs_inode_t             *dp;            /* incore directory inode */
> -       int                     highstale;      /* next stale entry */
> -       xfs_dir2_leaf_t         *leaf;          /* leaf structure */
> -       xfs_dir2_leaf_entry_t   *lep;           /* leaf entry */
> +       int                     highstale = 0;  /* next stale entry */
>         int                     lfloghigh;      /* high leaf entry logging */
>         int                     lfloglow;       /* low leaf entry logging */
> -       int                     lowstale;       /* previous stale entry */
> -       struct xfs_dir3_icleaf_hdr leafhdr;
> -       struct xfs_dir2_leaf_entry *ents;
> +       int                     lowstale = 0;   /* previous stale entry */
>
>         trace_xfs_dir2_leafn_add(args, index);
>
> -       dp = args->dp;
> -       leaf = bp->b_addr;
> -       highstale = 0;
> -       lowstale = 0;
>         dp->d_ops->leaf_hdr_from_disk(&leafhdr, leaf);
>         ents = dp->d_ops->leaf_ents_p(leaf);

What about moving the initialization of `ents` above? (Or would that
be over the line limit?)

In general, I like this change (I considered asking Nathan to do the
consolidation of declaration and initialization as you've done).  The
additional part of converting from _t to struct * is less interesting
(but still ok).  It's better to be consistent within the function
scope, but this translation unit is still a mismatch of styles.  If
the goal is to avoid typedefs, consider removing them from existence
and the required work to consistently not use them throughout this
code.

-- 
Thanks,
~Nick Desaulniers
