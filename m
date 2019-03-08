Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC73CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA862085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lBlcJmfe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbfCHSin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:38:43 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59866 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbfCHSin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:38:43 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x28IO8AZ015603;
        Fri, 8 Mar 2019 18:38:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=piNfCy0NjVdE8H8N2yNjFGmLgZLXxCNFuuKqFj63970=;
 b=lBlcJmfeeZmyCYHRBnuVSR51TlS/iF9LrtuhzNaOtHt8l7bGGkpLBmYMnK2EV7paad5v
 tCx+awrdMhWs32VtnYGaTpfjWjEi8qXsXIVWdM+B9aShLn/ofLSchCbaOSj9ZzcfPQdN
 Vo27x3BwfV7pvUVvFmSavgUrAJ5g+rC25KndM8lrezdtOtHXSaRL6usX4W+izvLgV8SW
 efLRgv6uhbeasJN2Mpm8eZe/g8VIPhM2LbIeJtBbI/buVXG3sC954c9BcWYn8DfqBAo/
 yOG15S7j9OEJdd7JRQuHA7o9sndELI0O+VAKSpyfO20sVKyu3Sx9TltoHzzSGIAXgMTY tA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2qyh8usvf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Mar 2019 18:38:37 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x28IcaLq020035
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Mar 2019 18:38:36 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x28Icadt020213;
        Fri, 8 Mar 2019 18:38:36 GMT
Received: from localhost (/10.159.130.184)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Mar 2019 10:38:35 -0800
Date:   Fri, 8 Mar 2019 10:38:30 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-xfs@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] xfs: clean up xfs_dir2_leafn_add
Message-ID: <20190308183830.GC20533@magnolia>
References: <20190308161308.GC4676@magnolia>
 <CAKwvOdn0=1svhDUBEP+391NvUXhm8bkzBzNMgNphML8kRzrRJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdn0=1svhDUBEP+391NvUXhm8bkzBzNMgNphML8kRzrRJQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9189 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903080129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 10:12:33AM -0800, Nick Desaulniers wrote:
> On Fri, Mar 8, 2019 at 8:13 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> >
> > From: Darrick J. Wong <darrick.wong@oracle.com>
> >
> > Remove typedefs and consolidate local variable initialization.
> >
> > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> > ---
> >  fs/xfs/libxfs/xfs_dir2_node.c |   20 ++++++++------------
> >  1 file changed, 8 insertions(+), 12 deletions(-)
> >
> > diff --git a/fs/xfs/libxfs/xfs_dir2_node.c b/fs/xfs/libxfs/xfs_dir2_node.c
> > index de46f26c5292..16731d2d684b 100644
> > --- a/fs/xfs/libxfs/xfs_dir2_node.c
> > +++ b/fs/xfs/libxfs/xfs_dir2_node.c
> > @@ -426,26 +426,22 @@ xfs_dir2_leaf_to_node(
> >  static int                                     /* error */
> >  xfs_dir2_leafn_add(
> >         struct xfs_buf          *bp,            /* leaf buffer */
> > -       xfs_da_args_t           *args,          /* operation arguments */
> > +       struct xfs_da_args      *args,          /* operation arguments */
> >         int                     index)          /* insertion pt for new entry */
> >  {
> > +       struct xfs_dir3_icleaf_hdr leafhdr;
> > +       struct xfs_inode        *dp = args->dp;
> > +       struct xfs_dir2_leaf    *leaf = bp->b_addr;
> > +       struct xfs_dir2_leaf_entry *lep;
> > +       struct xfs_dir2_leaf_entry *ents;
> >         int                     compact;        /* compacting stale leaves */
> > -       xfs_inode_t             *dp;            /* incore directory inode */
> > -       int                     highstale;      /* next stale entry */
> > -       xfs_dir2_leaf_t         *leaf;          /* leaf structure */
> > -       xfs_dir2_leaf_entry_t   *lep;           /* leaf entry */
> > +       int                     highstale = 0;  /* next stale entry */
> >         int                     lfloghigh;      /* high leaf entry logging */
> >         int                     lfloglow;       /* low leaf entry logging */
> > -       int                     lowstale;       /* previous stale entry */
> > -       struct xfs_dir3_icleaf_hdr leafhdr;
> > -       struct xfs_dir2_leaf_entry *ents;
> > +       int                     lowstale = 0;   /* previous stale entry */
> >
> >         trace_xfs_dir2_leafn_add(args, index);
> >
> > -       dp = args->dp;
> > -       leaf = bp->b_addr;
> > -       highstale = 0;
> > -       lowstale = 0;
> >         dp->d_ops->leaf_hdr_from_disk(&leafhdr, leaf);
> >         ents = dp->d_ops->leaf_ents_p(leaf);
> 
> What about moving the initialization of `ents` above? (Or would that
> be over the line limit?)

It might be over the line limit, but more importantly I prefer to have
the tracepoint fire before we start interpreting the on-disk metadata.
That way, ftrace data will show exactly where we were in the kernel
if any corruption warnings are emitted during that interpretation.

I don't think either of those two functions do that today, but I don't
want to leave a logic bomb in case they ever start doing that.

> In general, I like this change (I considered asking Nathan to do the
> consolidation of declaration and initialization as you've done).  The
> additional part of converting from _t to struct * is less interesting
> (but still ok).  It's better to be consistent within the function
> scope, but this translation unit is still a mismatch of styles.  If
> the goal is to avoid typedefs, consider removing them from existence
> and the required work to consistently not use them throughout this
> code.

Yeah, we're slowly converting away from the _t typedefs (and other
IRIXisms) as parts of code get reworked, though of course there's
nothing obvious to suggest that this (slow transition) is in progress
nor that we're ok with the inconsistent formatting in the meantime,
which is why I accepted the original patch and added this one to do the
style conversions.

--D

> -- 
> Thanks,
> ~Nick Desaulniers
