Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD6CC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F59206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbfGaUd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 16:33:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:56414 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727872AbfGaUd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 16:33:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B764AAF84;
        Wed, 31 Jul 2019 20:33:26 +0000 (UTC)
Date:   Wed, 31 Jul 2019 15:33:24 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Cc:     linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org,
        darrick.wong@oracle.com, linux-kernel@vger.kernel.org,
        gujx@cn.fujitsu.com, david@fromorbit.com, qi.fuli@fujitsu.com,
        caoj.fnst@cn.fujitsu.com
Subject: Re: [RFC PATCH 0/7] xfs: add reflink & dedupe support for fsdax.
Message-ID: <20190731203324.7vjwlejmwpghpvqi@fiona>
References: <20190731114935.11030-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731114935.11030-1-ruansy.fnst@cn.fujitsu.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19:49 31/07, Shiyang Ruan wrote:
> This patchset aims to take care of this issue to make reflink and dedupe
> work correctly in XFS.
> 
> It is based on Goldwyn's patchsets: "v4 Btrfs dax support" and "Btrfs
> iomap".  I picked up some patches related and made a few fix to make it
> basically works fine.
> 
> For dax framework: 
>   1. adapt to the latest change in iomap.
> 
> For XFS:
>   1. report the source address and set IOMAP_COW type for those write
>      operations that need COW.
>   2. update extent list at the end.
>   3. add file contents comparison function based on dax framework.
>   4. use xfs_break_layouts() to support dax.

Shiyang,

I think you used the older patches which does not contain the iomap changes
which would call iomap_begin() with two iomaps. I have it in the btrfs-iomap
branch and plan to update it today. It is built on v5.3-rcX, so it should
contain the changes which moves the iomap code to the different directory.
I will build the dax patches on top of that.
However, we are making a big dependency chain here :(

-- 
Goldwyn

> 
> 
> Goldwyn Rodrigues (3):
>   dax: replace mmap entry in case of CoW
>   fs: dedup file range to use a compare function
>   dax: memcpy before zeroing range
> 
> Shiyang Ruan (4):
>   dax: Introduce dax_copy_edges() for COW.
>   dax: copy data before write.
>   xfs: Add COW handle for fsdax.
>   xfs: Add dedupe support for fsdax.
> 
>  fs/btrfs/ioctl.c      |  11 ++-
>  fs/dax.c              | 203 ++++++++++++++++++++++++++++++++++++++----
>  fs/iomap.c            |   9 +-
>  fs/ocfs2/file.c       |   2 +-
>  fs/read_write.c       |  11 +--
>  fs/xfs/xfs_iomap.c    |  42 +++++----
>  fs/xfs/xfs_reflink.c  |  84 +++++++++--------
>  include/linux/dax.h   |  15 ++--
>  include/linux/fs.h    |   8 +-
>  include/linux/iomap.h |   6 ++
>  10 files changed, 294 insertions(+), 97 deletions(-)
> 
> -- 
> 2.17.0
> 
> 
> 

-- 
Goldwyn
