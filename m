Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344EEC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138FA205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfH2P6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:58:25 -0400
Received: from smtprelay0139.hostedemail.com ([216.40.44.139]:39409 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726283AbfH2P6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:58:24 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 22F09182251AF;
        Thu, 29 Aug 2019 15:58:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cub88_2b93c88708b5f
X-Filterd-Recvd-Size: 3480
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Thu, 29 Aug 2019 15:58:19 +0000 (UTC)
Message-ID: <67d6efbbc9ac6db23215660cb970b7ef29dc0c1d.camel@perches.com>
Subject: Re: [PATCH v6 01/24] erofs: add on-disk layout
From:   Joe Perches <joe@perches.com>
To:     Gao Xiang <gaoxiang25@huawei.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
        David Sterba <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Date:   Thu, 29 Aug 2019 08:58:17 -0700
In-Reply-To: <20190829103252.GA64893@architecture4>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
         <20190802125347.166018-2-gaoxiang25@huawei.com>
         <20190829095954.GB20598@infradead.org>
         <20190829103252.GA64893@architecture4>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-29 at 18:32 +0800, Gao Xiang wrote:
> Hi Christoph,
> 
> On Thu, Aug 29, 2019 at 02:59:54AM -0700, Christoph Hellwig wrote:
> > > --- /dev/null
> > > +++ b/fs/erofs/erofs_fs.h
> > > @@ -0,0 +1,316 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only OR Apache-2.0 */
> > > +/*
> > > + * linux/fs/erofs/erofs_fs.h
> > 
> > Please remove the pointless file names in the comment headers.
> 
> Already removed in the latest version.
> 
> > > +struct erofs_super_block {
> > > +/*  0 */__le32 magic;           /* in the little endian */
> > > +/*  4 */__le32 checksum;        /* crc32c(super_block) */
> > > +/*  8 */__le32 features;        /* (aka. feature_compat) */
> > > +/* 12 */__u8 blkszbits;         /* support block_size == PAGE_SIZE only */
> > 
> > Please remove all the byte offset comments.  That is something that can
> > easily be checked with gdb or pahole.
> 
> I have no idea the actual issue here.
> It will help all developpers better add fields or calculate
> these offsets in their mind, and with care.
> 
> Rather than they didn't run "gdb" or "pahole" and change it by mistake.

I think Christoph is not right here.

Using external tools for validation is extra work
when necessary for understanding the code.

The expected offset is somewhat valuable, but
perhaps the form is a bit off given the visual
run-in to the field types.

The extra work with this form is manipulating all
the offsets whenever a structure change occurs.

The comments might be better with a form more like:

struct erofs_super_block {	/* offset description */
	__le32 magic;		/*   0  */
	__le32 checksum;	/*   4  crc32c(super_block) */
	__le32 features;	/*   8  (aka. feature_compat) */
	__u8 blkszbits;		/*  12  support block_size == PAGE_SIZE only */


