Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E041CC10F09
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 07:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7352081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 07:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfCHHjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 02:39:55 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37248 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfCHHjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 02:39:54 -0500
Received: from mail-wm1-f71.google.com ([209.85.128.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <andrea.righi@canonical.com>)
        id 1h2A6j-000348-3L
        for linux-kernel@vger.kernel.org; Fri, 08 Mar 2019 07:39:53 +0000
Received: by mail-wm1-f71.google.com with SMTP id t133so3866279wmg.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 23:39:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JJc0aaYe86uBtyFNHwS97nDpP6ya73K7Xpte85VT6jM=;
        b=eBHEeMRX4Gbtv0wWS60Vd+tNQRJ+Ud7r+Ka0tOz8SNeHcQ++UhAgFBkyh1VUDZD874
         jpQuaz12eNFjXNd6w7tnKhdUxP4bxcHdgee59We/pY0/xEd5XvMWRQocZlfQ62YfWu4G
         RnrI/mtKg1K6P3YZxfuJArr51pIJsXzuF3sFXQm3/buBaFTq4bnSi5WZLeIZ+44pjruT
         i+wWugNJkwbDoa8L0cyZkZijzvAM/4WcdtjmICiokb4HcqKLkuJTccsCd9gRTXsyOb7G
         /e6an35rPXGAMCn0PgmNYQSDDGhZbvgDYAcsedc5BsS11d7kyesmr55A3nnVnY8ev5Ea
         QJ2g==
X-Gm-Message-State: APjAAAWf3KVRJk74yGs18ekpdXY1eG+OgwbBxL5zyddHnlJEMZns3X5f
        yagenD/kQSdJTqK5E4vCFHJ14l+S5FhF58vxb5alQQFsVZcK5WgtWzrPT12QApPVfJ2YwQ/obXC
        z1RO5dvXeOFhaTbYDoPU/x4jYGJZX5WqV4heRSqfJFg==
X-Received: by 2002:a05:600c:246:: with SMTP id 6mr8339779wmj.150.1552030792771;
        Thu, 07 Mar 2019 23:39:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqxJhtFa3TTCopJb45myQ4DWUFsV96LbrjHMyJoQO2As2bT5zJaG08zR0ITdQNu4XGAgQgp7YA==
X-Received: by 2002:a05:600c:246:: with SMTP id 6mr8339760wmj.150.1552030792587;
        Thu, 07 Mar 2019 23:39:52 -0800 (PST)
Received: from localhost (host22-124-dynamic.46-79-r.retail.telecomitalia.it. [79.46.124.22])
        by smtp.gmail.com with ESMTPSA id 203sm9224529wme.30.2019.03.07.23.39.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 23:39:52 -0800 (PST)
Date:   Fri, 8 Mar 2019 08:39:50 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jens Axboe <axboe@kernel.dk>, Vivek Goyal <vgoyal@redhat.com>,
        Dennis Zhou <dennis@kernel.org>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] blkcg: implement sync() isolation
Message-ID: <20190308073950.GA6087@xps-13>
References: <20190307180834.22008-1-andrea.righi@canonical.com>
 <20190307180834.22008-4-andrea.righi@canonical.com>
 <20190307220659.5qmye2pxmto7nlei@macbook-pro-91.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307220659.5qmye2pxmto7nlei@macbook-pro-91.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 05:07:01PM -0500, Josef Bacik wrote:
> On Thu, Mar 07, 2019 at 07:08:34PM +0100, Andrea Righi wrote:
> > Keep track of the inodes that have been dirtied by each blkcg cgroup and
> > make sure that a blkcg issuing a sync() can trigger the writeback + wait
> > of only those pages that belong to the cgroup itself.
> > 
> > This behavior is applied only when io.sync_isolation is enabled in the
> > cgroup, otherwise the old behavior is applied: sync() triggers the
> > writeback of any dirty page.
> > 
> > Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> > ---
> >  block/blk-cgroup.c         | 47 ++++++++++++++++++++++++++++++++++
> >  fs/fs-writeback.c          | 52 +++++++++++++++++++++++++++++++++++---
> >  fs/inode.c                 |  1 +
> >  include/linux/blk-cgroup.h | 22 ++++++++++++++++
> >  include/linux/fs.h         |  4 +++
> >  mm/page-writeback.c        |  1 +
> >  6 files changed, 124 insertions(+), 3 deletions(-)
> > 
> > diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> > index 4305e78d1bb2..7d3b26ba4575 100644
> > --- a/block/blk-cgroup.c
> > +++ b/block/blk-cgroup.c
> > @@ -1480,6 +1480,53 @@ void blkcg_stop_wb_wait_on_bdi(struct backing_dev_info *bdi)
> >  	spin_unlock(&blkcg_wb_sleeper_lock);
> >  	rcu_read_unlock();
> >  }
> > +
> > +/**
> > + * blkcg_set_mapping_dirty - set owner of a dirty mapping
> > + * @mapping: target address space
> > + *
> > + * Set the current blkcg as the owner of the address space @mapping (the first
> > + * blkcg that dirties @mapping becomes the owner).
> > + */
> > +void blkcg_set_mapping_dirty(struct address_space *mapping)
> > +{
> > +	struct blkcg *curr_blkcg, *blkcg;
> > +
> > +	if (mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK) ||
> > +	    mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
> > +		return;
> > +
> > +	rcu_read_lock();
> > +	curr_blkcg = blkcg_from_current();
> > +	blkcg = blkcg_from_mapping(mapping);
> > +	if (curr_blkcg != blkcg) {
> > +		if (blkcg)
> > +			css_put(&blkcg->css);
> > +		css_get(&curr_blkcg->css);
> > +		rcu_assign_pointer(mapping->i_blkcg, curr_blkcg);
> > +	}
> > +	rcu_read_unlock();
> > +}
> > +
> > +/**
> > + * blkcg_set_mapping_clean - clear the owner of a dirty mapping
> > + * @mapping: target address space
> > + *
> > + * Unset the owner of @mapping when it becomes clean.
> > + */
> > +
> > +void blkcg_set_mapping_clean(struct address_space *mapping)
> > +{
> > +	struct blkcg *blkcg;
> > +
> > +	rcu_read_lock();
> > +	blkcg = rcu_dereference(mapping->i_blkcg);
> > +	if (blkcg) {
> > +		css_put(&blkcg->css);
> > +		RCU_INIT_POINTER(mapping->i_blkcg, NULL);
> > +	}
> > +	rcu_read_unlock();
> > +}
> >  #endif
> >  
> 
> Why do we need this?  We already have the inode_attach_wb(), which has the
> blkcg_css embedded in it for whoever dirtied the inode first.  Can we not just
> use that?  Thanks,
> 
> Josef

I'm realizing only now that inode_attach_wb() also has blkcg embedded
in addition to the memcg. I think I can use that and drop these
blkcg_set_mapping_dirty/clean()..

Thanks,
-Andrea
