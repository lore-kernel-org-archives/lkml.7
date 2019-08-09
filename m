Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB48C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9221221773
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565363964;
	bh=ojsCh6zH5M2twmcxcR8KTE+bmE0FgFJylCM5lNvG9y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NKivAa6Ob2Xs6AutuyS/Kv5q72oGPOCKI+HUXvXeWCQGThtdxVm2TzP3dMnC1A3Y/
	 /5ppSa6USz7cWFrwkTFPezqZvL6K8v15MzCtCrmCcFaSGnajqZ+Wq5kHnhUzGYduzE
	 h+WijXyh3KyMQ92poY4/XS8XD0+7lex8VizTqHjo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407327AbfHIPTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:19:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:49768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbfHIPTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:19:23 -0400
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23E6B20C01;
        Fri,  9 Aug 2019 15:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565363962;
        bh=ojsCh6zH5M2twmcxcR8KTE+bmE0FgFJylCM5lNvG9y4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eQkgtVaZd8kGl3wiyRnz1ZiLloMvEYAzgu/B/nRewB2f5nWbt0KLJ8ux3Ug+RgcQ0
         dtj4jZB8RGA+nI7u8ofS3Vz/whXXMCXRmwaVeMXUd09or9svX6ZQrd/DkmN+suCfwk
         f9GUannEYdq2cwHGtoaG6CRjiXO7pgSfmhyufL74=
Date:   Fri, 9 Aug 2019 08:19:21 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH v2] f2fs: fix wrong available node count calculation
Message-ID: <20190809151921.GB93481@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190805102725.27834-1-yuchao0@huawei.com>
 <7a47ec24-2352-7438-bed2-493a89d5c576@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a47ec24-2352-7438-bed2-493a89d5c576@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06, Chao Yu wrote:
> On 2019/8/5 18:27, Chao Yu wrote:
> > In mkfs, we have counted quota file's node number in cp.valid_node_count,
> > so we have to avoid wrong substraction of quota node number in
> > .available_nid/.avail_node_count calculation.
> > 
> > f2fs_write_check_point_pack()
> > {
> > ..
> > 	set_cp(valid_node_count, 1 + c.quota_inum + c.lpf_inum);
> > 
> > Fixes: 292c196a3695 ("reserve nid resource for quota sysfile")
> 
> Jaegeuk,
> 
> Could you help to add prefix "f2fs: " into commit tile in your branch, I missed
> to add it. :P

Done. :)

> 
> Thanks,
> 
> > Fixes: 7b63f72f73af ("f2fs: fix to do sanity check on valid node/block count")
> > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > ---
> >  fs/f2fs/node.c  | 2 +-
> >  fs/f2fs/super.c | 6 ++----
> >  2 files changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > index a18b2a895771..d9ba1db2d01e 100644
> > --- a/fs/f2fs/node.c
> > +++ b/fs/f2fs/node.c
> > @@ -2964,7 +2964,7 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
> >  
> >  	/* not used nids: 0, node, meta, (and root counted as valid node) */
> >  	nm_i->available_nids = nm_i->max_nid - sbi->total_valid_node_count -
> > -				sbi->nquota_files - F2FS_RESERVED_NODE_NUM;
> > +						F2FS_RESERVED_NODE_NUM;
> >  	nm_i->nid_cnt[FREE_NID] = 0;
> >  	nm_i->nid_cnt[PREALLOC_NID] = 0;
> >  	nm_i->nat_cnt = 0;
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 6a7f1166d068..118a31f90a37 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -1297,8 +1297,7 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
> >  	else
> >  		buf->f_bavail = 0;
> >  
> > -	avail_node_count = sbi->total_node_count - sbi->nquota_files -
> > -						F2FS_RESERVED_NODE_NUM;
> > +	avail_node_count = sbi->total_node_count - F2FS_RESERVED_NODE_NUM;
> >  
> >  	if (avail_node_count > user_block_count) {
> >  		buf->f_files = user_block_count;
> > @@ -2750,8 +2749,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
> >  	}
> >  
> >  	valid_node_count = le32_to_cpu(ckpt->valid_node_count);
> > -	avail_node_count = sbi->total_node_count - sbi->nquota_files -
> > -						F2FS_RESERVED_NODE_NUM;
> > +	avail_node_count = sbi->total_node_count - F2FS_RESERVED_NODE_NUM;
> >  	if (valid_node_count > avail_node_count) {
> >  		f2fs_err(sbi, "Wrong valid_node_count: %u, avail_node_count: %u",
> >  			 valid_node_count, avail_node_count);
> > 
