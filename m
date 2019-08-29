Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554FBC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3606921726
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfH2Q70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 12:59:26 -0400
Received: from smtprelay0040.hostedemail.com ([216.40.44.40]:48847 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726893AbfH2Q70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 12:59:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 6D17A182251B3;
        Thu, 29 Aug 2019 16:59:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pen83_8c14c4bdf600f
X-Filterd-Recvd-Size: 3280
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Thu, 29 Aug 2019 16:59:22 +0000 (UTC)
Message-ID: <74c4784319b40deabfbaea92468f7e3ef44f1c96.camel@perches.com>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
From:   Joe Perches <joe@perches.com>
To:     Gao Xiang <gaoxiang25@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Valdis =?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date:   Thu, 29 Aug 2019 09:59:21 -0700
In-Reply-To: <20190829164442.GA203852@architecture4>
References: <20190828170022.GA7873@kroah.com>
         <20190829062340.GB3047@infradead.org> <20190829063955.GA30193@kroah.com>
         <20190829094136.GA28643@infradead.org> <20190829095019.GA13557@kroah.com>
         <20190829103749.GA13661@infradead.org> <20190829111810.GA23393@kroah.com>
         <20190829151144.GJ23584@kadam> <20190829152757.GA125003@architecture4>
         <20190829154346.GK23584@kadam> <20190829164442.GA203852@architecture4>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-30 at 00:44 +0800, Gao Xiang wrote:
> Hi Dan,
> 
> On Thu, Aug 29, 2019 at 11:43:46PM +0800, Dan Carpenter wrote:
> > > p.s. There are 2947 (un)likely places in fs/ directory.
> > 
> > I was complaining about you adding new pointless ones, not existing
> > ones.  The likely/unlikely annotations are supposed to be functional and
> > not decorative.  I explained this very clearly.
> > 
> > Probably most of the annotations in fs/ are wrong but they are also
> > harmless except for the slight messiness.  However there are definitely
> > some which are important so removing them all isn't a good idea.
> > 
> > > If you like, I will delete them all.
> > 
> > But for erofs, I don't think that any of the likely/unlikely calls have
> > been thought about so I'm fine with removing all of them in one go.
> 
> Anyway, I have removed them all in
> https://lore.kernel.org/r/20190829163827.203274-1-gaoxiang25@huawei.com/
> 
> Does it look good to you?

Unrelated bikeshed from a trivial look:

There's a block there that looks like:

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
[]
@@ -70,7 +70,7 @@ struct page *__erofs_get_meta_page(struct super_block *sb,
 		}
 
 		err = bio_add_page(bio, page, PAGE_SIZE, 0);
-		if (unlikely(err != PAGE_SIZE)) {
+		if (err != PAGE_SIZE) {
 			err = -EFAULT;
 			goto err_out;
 		}

The initial assignment to err is odd as it's not
actually an error value -E<FOO> but a int size
from a unsigned int len.

Here the return is either 0 or PAGE_SIZE.

This would be more legible to me as:

		if (bio_add_page(bio, page, PAGE_SIZE, 0) != PAGE_SIZE) {
			err = -EFAULT;
			goto err_out;
		}


