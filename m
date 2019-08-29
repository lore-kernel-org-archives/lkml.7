Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C29DC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 12:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E29D215EA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 12:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfH2MAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 08:00:22 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:34016 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726379AbfH2MAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 08:00:21 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 1F79FF69D7A4173BC632;
        Thu, 29 Aug 2019 20:00:11 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 29 Aug 2019 20:00:10 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 29 Aug 2019 20:00:09 +0800
Date:   Thu, 29 Aug 2019 19:59:22 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>, "Pavel Machek" <pavel@denx.de>,
        David Sterba <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        "Dave Chinner" <david@fromorbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Subject: Re: [PATCH v6 05/24] erofs: add inode operations
Message-ID: <20190829115922.GG64893@architecture4>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-6-gaoxiang25@huawei.com>
 <20190829102426.GE20598@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190829102426.GE20598@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme712-chm.china.huawei.com (10.1.199.108) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 03:24:26AM -0700, Christoph Hellwig wrote:

[]

> 
> > +
> > +		/* fill last page if inline data is available */
> > +		err = fill_inline_data(inode, data, ofs);
> 
> Well, I think you should move the is_inode_flat_inline and
> (S_ISLNK(inode->i_mode) && inode->i_size < PAGE_SIZE) checks from that
> helper here, as otherwise you make everyone wonder why you'd always
> fill out the inline data.

Currently, fill_inline_data() only fills for fast symlink,
later we can fill any tail-end block (such as dir block)
for our requirements.

And I think that is minor.

> 
> > +static inline struct inode *erofs_iget_locked(struct super_block *sb,
> > +					      erofs_nid_t nid)
> > +{
> > +	const unsigned long hashval = erofs_inode_hash(nid);
> > +
> > +#if BITS_PER_LONG >= 64
> > +	/* it is safe to use iget_locked for >= 64-bit platform */
> > +	return iget_locked(sb, hashval);
> > +#else
> > +	return iget5_locked(sb, hashval, erofs_ilookup_test_actor,
> > +		erofs_iget_set_actor, &nid);
> > +#endif
> 
> Just use the slightly more complicated 32-bit version everywhere so that
> you have a single actually tested code path.  And then remove this
> helper.

The consideration is simply because iget_locked performs better
than iget5_locked.

Thanks,
Gao Xiang

