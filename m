Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF942C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 08:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADCB72146E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 08:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbfIZIAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 04:00:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:43046 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727701AbfIZIAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 04:00:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 026A2AED6;
        Thu, 26 Sep 2019 08:00:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DD2081E481F; Thu, 26 Sep 2019 10:00:31 +0200 (CEST)
Date:   Thu, 26 Sep 2019 10:00:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Jan Kara <jack@suse.com>, emamd001@umn.edu, kjlu@umn.edu,
        smccaman@umn.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udf: prevent memory leak in udf_new_inode
Message-ID: <20190926080031.GB12013@quack2.suse.cz>
References: <20190925213904.12128-1-navid.emamdoost@gmail.com>
 <20190925222408.GN26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925222408.GN26530@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 25-09-19 23:24:08, Al Viro wrote:
> On Wed, Sep 25, 2019 at 04:39:03PM -0500, Navid Emamdoost wrote:
> > In udf_new_inode if either udf_new_block or insert_inode_locked fials
> > the allocated memory for iinfo->i_ext.i_data should be released.
> 
> "... because of such-and-such reasons" part appears to be missing.
> Why should it be released there?
> 
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > ---
> >  fs/udf/ialloc.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/fs/udf/ialloc.c b/fs/udf/ialloc.c
> > index 0adb40718a5d..b8ab3acab6b6 100644
> > --- a/fs/udf/ialloc.c
> > +++ b/fs/udf/ialloc.c
> > @@ -86,6 +86,7 @@ struct inode *udf_new_inode(struct inode *dir, umode_t mode)
> >  			      dinfo->i_location.partitionReferenceNum,
> >  			      start, &err);
> >  	if (err) {
> > +		kfree(iinfo->i_ext.i_data);
> >  		iput(inode);
> >  		return ERR_PTR(err);
> >  	}
> 
> Have you tested that?  Because it has all earmarks of double-free;
> normal eviction pathway ought to free the damn thing.  <greps around
> a bit>
> 
> Mind explaining what's to stop ->evict_inode (== udf_evict_inode) from
> hitting
>         kfree(iinfo->i_ext.i_data);
> considering that this call of kfree() appears to be unconditional there?

Exactly. udf_evict_inode() is responsible for freeing iinfo->i_ext.i_data
so the patch would result in double free.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
