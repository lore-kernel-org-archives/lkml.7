Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B606CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 23:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8401C20851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 23:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mDpYWZou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfCHXLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 18:11:32 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:55972 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfCHXLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 18:11:32 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x28MwoUT065915;
        Fri, 8 Mar 2019 23:11:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Tpp2WsCucOIEpwaR6NmKGEhRxlXqNql9LFmw1igyiFY=;
 b=mDpYWZouIa4wi/8Qn7D4wlZielHyGzT0weY0l3AIghCZ5EJfqFC/QUhAY9OE1jHAlpLm
 tzw2NmPKJ1n1QdcJ5tLvPcVKzVrqTyOGZyUEgwZm/LtVYL7oV60f3u6697anyqxmKpfP
 f0lXnv6zkZjpKZ2QXwHK06FziPb9ViSF0yhSPVbAQler80FBvZxFlerRzY1EFAKEmY2f
 t+tWkPNbB3SxPIqTPn8XzHq1Zh0XBIJrpvZk7yrMX4Qq/ROCNPKzOWeMWX0qThb5OoUt
 RmgtARpD+hvmhld0rm8/O8zUoXC8J93YFO2Rd5y6fU3ZsXnW9wRfOyOEhtkhlBiSZvD/ xw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2qyfbeu6bw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Mar 2019 23:11:25 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x28NBOe2010034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Mar 2019 23:11:25 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x28NBOXn012405;
        Fri, 8 Mar 2019 23:11:24 GMT
Received: from localhost (/10.159.130.184)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Mar 2019 15:11:23 -0800
Date:   Fri, 8 Mar 2019 15:11:14 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-xfs@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] xfs: clean up xfs_dir2_leafn_add
Message-ID: <20190308231114.GD4676@magnolia>
References: <20190308161308.GC4676@magnolia>
 <CAKwvOdn0=1svhDUBEP+391NvUXhm8bkzBzNMgNphML8kRzrRJQ@mail.gmail.com>
 <20190308183830.GC20533@magnolia>
 <CAKwvOdnpfQ_v3Hx0Y0ZjzQEet9DH+39RzMeG6rFqp6nw0ha7GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnpfQ_v3Hx0Y0ZjzQEet9DH+39RzMeG6rFqp6nw0ha7GQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9189 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903080159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 10:42:59AM -0800, Nick Desaulniers wrote:
> On Fri, Mar 8, 2019 at 10:38 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> >
> > On Fri, Mar 08, 2019 at 10:12:33AM -0800, Nick Desaulniers wrote:
> > > On Fri, Mar 8, 2019 at 8:13 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > > >
> > > > From: Darrick J. Wong <darrick.wong@oracle.com>
> > > >
> > > > Remove typedefs and consolidate local variable initialization.
> > > >
> > > > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> > > > ---
> > > >  fs/xfs/libxfs/xfs_dir2_node.c |   20 ++++++++------------
> > > >  1 file changed, 8 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/fs/xfs/libxfs/xfs_dir2_node.c b/fs/xfs/libxfs/xfs_dir2_node.c
> > > > index de46f26c5292..16731d2d684b 100644
> > > > --- a/fs/xfs/libxfs/xfs_dir2_node.c
> > > > +++ b/fs/xfs/libxfs/xfs_dir2_node.c
> > > > @@ -426,26 +426,22 @@ xfs_dir2_leaf_to_node(
> > > >  static int                                     /* error */
> > > >  xfs_dir2_leafn_add(
> > > >         struct xfs_buf          *bp,            /* leaf buffer */
> > > > -       xfs_da_args_t           *args,          /* operation arguments */
> > > > +       struct xfs_da_args      *args,          /* operation arguments */
> > > >         int                     index)          /* insertion pt for new entry */
> > > >  {
> > > > +       struct xfs_dir3_icleaf_hdr leafhdr;
> > > > +       struct xfs_inode        *dp = args->dp;
> > > > +       struct xfs_dir2_leaf    *leaf = bp->b_addr;
> > > > +       struct xfs_dir2_leaf_entry *lep;
> > > > +       struct xfs_dir2_leaf_entry *ents;
> > > >         int                     compact;        /* compacting stale leaves */
> > > > -       xfs_inode_t             *dp;            /* incore directory inode */
> > > > -       int                     highstale;      /* next stale entry */
> > > > -       xfs_dir2_leaf_t         *leaf;          /* leaf structure */
> > > > -       xfs_dir2_leaf_entry_t   *lep;           /* leaf entry */
> > > > +       int                     highstale = 0;  /* next stale entry */
> > > >         int                     lfloghigh;      /* high leaf entry logging */
> > > >         int                     lfloglow;       /* low leaf entry logging */
> > > > -       int                     lowstale;       /* previous stale entry */
> > > > -       struct xfs_dir3_icleaf_hdr leafhdr;
> > > > -       struct xfs_dir2_leaf_entry *ents;
> > > > +       int                     lowstale = 0;   /* previous stale entry */
> > > >
> > > >         trace_xfs_dir2_leafn_add(args, index);
> > > >
> > > > -       dp = args->dp;
> > > > -       leaf = bp->b_addr;
> > > > -       highstale = 0;
> > > > -       lowstale = 0;
> > > >         dp->d_ops->leaf_hdr_from_disk(&leafhdr, leaf);
> > > >         ents = dp->d_ops->leaf_ents_p(leaf);
> > >
> > > What about moving the initialization of `ents` above? (Or would that
> > > be over the line limit?)
> >
> > It might be over the line limit, but more importantly I prefer to have
> > the tracepoint fire before we start interpreting the on-disk metadata.
> > That way, ftrace data will show exactly where we were in the kernel
> > if any corruption warnings are emitted during that interpretation.
> >
> > I don't think either of those two functions do that today, but I don't
> > want to leave a logic bomb in case they ever start doing that.
> 
> Makes sense, ents is initialized to the results of function call.
> Thanks for the additional info, for accepting the earlier patch, and
> this additional cleanup.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks for the review!

By the way, does clang complain about highstale/lowstale in
xfs_dir2_leaf_addname being uninitialized too?  Just wondering since
smatch/sparse do...

--D

> -- 
> Thanks,
> ~Nick Desaulniers
