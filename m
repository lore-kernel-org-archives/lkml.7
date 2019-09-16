Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6417DC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 08:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D35206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 08:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbfIPIXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 04:23:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:47230 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727068AbfIPIXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 04:23:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 37F62B664;
        Mon, 16 Sep 2019 08:22:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E309C1E47E5; Mon, 16 Sep 2019 10:23:06 +0200 (CEST)
Date:   Mon, 16 Sep 2019 10:23:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>, chao@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quota: fix wrong condition in is_quota_modification()
Message-ID: <20190916082306.GB2485@quack2.suse.cz>
References: <20190911093650.35329-1-yuchao0@huawei.com>
 <20190912100610.GA14773@quack2.suse.cz>
 <ce4fe030-7ad4-134d-e0c4-77dc2c618b15@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce4fe030-7ad4-134d-e0c4-77dc2c618b15@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 16-09-19 10:53:08, Chao Yu wrote:
> On 2019/9/12 18:06, Jan Kara wrote:
> > On Wed 11-09-19 17:36:50, Chao Yu wrote:
> >> diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
> >> index dc905a4ff8d7..bd30acad3a7f 100644
> >> --- a/include/linux/quotaops.h
> >> +++ b/include/linux/quotaops.h
> >> @@ -22,7 +22,7 @@ static inline struct quota_info *sb_dqopt(struct super_block *sb)
> >>  /* i_mutex must being held */
> >>  static inline bool is_quota_modification(struct inode *inode, struct iattr *ia)
> >>  {
> >> -	return (ia->ia_valid & ATTR_SIZE && ia->ia_size != inode->i_size) ||
> >> +	return (ia->ia_valid & ATTR_SIZE && ia->ia_size <= inode->i_size) ||
> >>  		(ia->ia_valid & ATTR_UID && !uid_eq(ia->ia_uid, inode->i_uid)) ||
> >>  		(ia->ia_valid & ATTR_GID && !gid_eq(ia->ia_gid, inode->i_gid));
> >>  }
> > 
> > OK, but your change makes i_size extension not to be quota modification
> 
> I just try to adapt below rules covered with generic/092, which restrict
> to not trim preallocate blocks beyond i_size, in that case, filesystem
> won't change i_blocks.
> 
> 1) truncate(i_size) will trim all blocks past i_size.
> 2) truncate(x) where x > i_size will not trim all blocks past i_size.

Ah, OK.

> However, I'm okay with your change, because there could be filesystems won't
> follow above rule.

Yes, I'm concerned that some filesystem may change i_blocks in some corner
case when growing inode size (e.g. when it decides to convert inode from
inline format to a normal block based format or something like that). So I
don't think the optimization is really worth the chance for breakage.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
