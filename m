Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1A9C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B9A23400
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbfIBN4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 09:56:15 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3551 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730207AbfIBN4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:56:14 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 483E9D60EC475B9922D5;
        Mon,  2 Sep 2019 21:56:12 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 2 Sep 2019 21:56:11 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 2 Sep 2019 21:56:11 +0800
Date:   Mon, 2 Sep 2019 21:55:20 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     <dsterba@suse.cz>
CC:     Gao Xiang <hsiangkao@aol.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Jan Kara" <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <devel@driverdev.osuosl.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-erofs@lists.ozlabs.org>
Subject: Re: [PATCH v6 05/24] erofs: add inode operations
Message-ID: <20190902135519.GD2664@architecture4>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-6-gaoxiang25@huawei.com>
 <20190829102426.GE20598@infradead.org>
 <20190901093326.GA6267@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190902134329.GU2752@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190902134329.GU2752@twin.jikos.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Mon, Sep 02, 2019 at 03:43:29PM +0200, David Sterba wrote:
> On Sun, Sep 01, 2019 at 05:34:00PM +0800, Gao Xiang wrote:
> > > > +static int read_inode(struct inode *inode, void *data)
> > > > +{
> > > > +	struct erofs_vnode *vi = EROFS_V(inode);
> > > > +	struct erofs_inode_v1 *v1 = data;
> > > > +	const unsigned int advise = le16_to_cpu(v1->i_advise);
> > > > +	erofs_blk_t nblks = 0;
> > > > +
> > > > +	vi->datamode = __inode_data_mapping(advise);
> > > 
> > > What is the deal with these magic underscores here and various
> > > other similar helpers?
> > 
> > Fixed in
> > https://lore.kernel.org/linux-fsdevel/20190901055130.30572-17-hsiangkao@aol.com/
> > 
> > underscores means 'internal' in my thought, it seems somewhat
> > some common practice of Linux kernel, or some recent discussions
> > about it?... I didn't notice these discussions...
> 
> I know about a few valid uses of the underscores:
> 
> * pattern where the __underscored version does not do locking, while the other
>   does
> * similarly for atomic and non-atomic version
> * macro that needs to manipulate the argument name (like glue some
>   prefix, so the macro does not have underscores and is supposed to be
>   used instead of the function with underscores that needs the full name
>   of a variable/constant/..
> * underscore function takes a few more parameters to further tune the
>   behaviour, but most users are fine with the defaults and that is
>   provided as a function without underscores
> * in case you have just one function of the kind, don't use the underscores
> 
> I can lookup examples if you're interested or if the brief description
> is not sufficient. The list covers what I've seen and used, but the list
> may be incomplete.

Thanks, I learn a lot from the above. [thumb]

Thanks,
Gao Xiang

