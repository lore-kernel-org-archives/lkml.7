Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F83C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A63D217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555509789;
	bh=V0N8zy66D8CvKfkyqjl6fAwZr2CrioTeUkCMWmBOoWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r4g7QFuVKnRQfc0qcQXjXDsZVAeGgJzqGG03+4eJHMdFgv6nyCL09my4vsSUKe6Zb
	 wHuy+QztaskoO+JJlKIDnBRTKc6HA3W+YVq1VCZiW3vg0R0KztH2IBlWL68gudO8eJ
	 rz8k1y4pxC9cv7GVDcvd3w9Jr2aAFnNEuCAktkp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732395AbfDQODI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:03:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731743AbfDQODI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:03:08 -0400
Received: from localhost (unknown [104.132.1.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29431206BA;
        Wed, 17 Apr 2019 14:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555509787;
        bh=V0N8zy66D8CvKfkyqjl6fAwZr2CrioTeUkCMWmBOoWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JsM+1of8Xzd9edYyyHmkECPLynW67kxYIQEzgaf2HzHd4+A2/W+C3KguUe82/m9Ow
         IJXxm7LPQlK6eCYtXXvVjS2zFVZknvp6uaLkJe/cyRfVTfft6spUSs59fmxhbvjDlN
         ikpR8pg2IghKsQwJO2Ta2GU3RWEMBrlROsJMRCzM=
Date:   Wed, 17 Apr 2019 07:03:05 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: build warning after merge of the block tree
Message-ID: <20190417140305.GB23731@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190417123125.3de22f73@canb.auug.org.au>
 <0879e11b-c84c-65b8-581f-bf7adcb5e231@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0879e11b-c84c-65b8-581f-bf7adcb5e231@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2019/4/17 10:31, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the block tree, today's linux-next build (x86_64
> > allmodconfig) produced this warning:
> > 
> > fs/f2fs/node.c: In function 'f2fs_remove_inode_page':
> > fs/f2fs/node.c:1193:47: warning: format '%zu' expects argument of type 'size_t', but argument 5 has type 'blkcnt_t' {aka 'long long unsigned int'} [-Wformat=]
> >     "Inconsistent i_blocks, ino:%lu, iblocks:%zu",
> >                                              ~~^
> >                                              %llu
> >     inode->i_ino, inode->i_blocks);
> >                   ~~~~~~~~~~~~~~~       
> 
> Could you please help to fix that as below in your dev branch directly?
> 
> "Inconsistent i_blocks, ino:%lu, iblocks:%llu",

We can just use "%lu"?

> inode->i_ino, (unsigned long long)inode->i_blocks)
> 
> 
> It looks that we need to fix below commits as well:
> 
> f2fs: fix to avoid panic in dec_valid_block_count()
> f2fs: fix to avoid panic in dec_valid_node_count()
> 
> Thanks,
> 
> > 
> > Introduced by commit
> > 
> >   90ae238d9dac ("f2fs: fix to avoid panic in f2fs_remove_inode_page()")
> > 
> > from the f2fs tree interacting with commit
> > 
> >   72deb455b5ec ("block: remove CONFIG_LBDAF")
> > 
