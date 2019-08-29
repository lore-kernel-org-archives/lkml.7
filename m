Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A8DC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6ED2080F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfH2Pmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:42:32 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3957 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727118AbfH2Pmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:42:31 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 4648CDBF252A50D01A48;
        Thu, 29 Aug 2019 23:42:25 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 29 Aug 2019 23:42:24 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 29 Aug 2019 23:42:24 +0800
Date:   Thu, 29 Aug 2019 23:41:37 +0800
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
Subject: Re: [PATCH v6 01/24] erofs: add on-disk layout
Message-ID: <20190829154136.GA129582@architecture4>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-2-gaoxiang25@huawei.com>
 <20190829095954.GB20598@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190829095954.GB20598@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme703-chm.china.huawei.com (10.1.199.99) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Thu, Aug 29, 2019 at 02:59:54AM -0700, Christoph Hellwig wrote:

[]

> 
> > +static bool erofs_inode_is_data_compressed(unsigned int datamode)
> > +{
> > +	if (datamode == EROFS_INODE_FLAT_COMPRESSION)
> > +		return true;
> > +	return datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY;
> > +}
> 
> This looks like a really obsfucated way to write:
> 
> 	return datamode == EROFS_INODE_FLAT_COMPRESSION ||
> 		datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY;

Add a word about this, the above approach is not horrible if more
datamode add here and comments, e.g

static bool erofs_inode_is_data_compressed(unsigned int datamode)
{
	/* has z_erofs_map_header */
	if (datamode == EROFS_INODE_FLAT_COMPRESSION)
		return true;
	/* some blablabla */
	if (datamode == (1) )
		return true;
	/* some blablablabla */
	if (datamode == (2) )
		return true;
	/* no z_erofs_map_header */
	return datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY;
}

vs.

static bool erofs_inode_is_data_compressed(unsigned int datamode)
{
	/* has z_erofs_map_header */
	return datamode == EROFS_INODE_FLAT_COMPRESSION ||
		/* some blablabla */
	       datamode == (1) ||
	       	/* some blablablabla */
	       datamode == (2) ||
	        /* no z_erofs_map_header */
	       datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY;
}

I have no idea which one is better.
Anyway, if you still like the form, I will change it.

Thanks,
Gao Xiang
