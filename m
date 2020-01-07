Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E33C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 00:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5AC2072E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 00:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgAGAKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 19:10:50 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:54997 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726858AbgAGAKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 19:10:50 -0500
Received: from dread.disaster.area (pa49-180-68-255.pa.nsw.optusnet.com.au [49.180.68.255])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id D944A3A2B05;
        Tue,  7 Jan 2020 11:10:45 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iocSG-0006iB-01; Tue, 07 Jan 2020 11:10:40 +1100
Date:   Tue, 7 Jan 2020 11:10:39 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-mm@kvack.org, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 2/2] tmpfs: Support 64-bit inums per-sb
Message-ID: <20200107001039.GM23195@dread.disaster.area>
References: <cover.1578225806.git.chris@chrisdown.name>
 <ae9306ab10ce3d794c13b1836f5473e89562b98c.1578225806.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae9306ab10ce3d794c13b1836f5473e89562b98c.1578225806.git.chris@chrisdown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=sbdTpStuSq8iNQE8viVliQ==:117 a=sbdTpStuSq8iNQE8viVliQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=7-415B0cAAAA:8 a=bVpIlPjQrN2W4rbB-h8A:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22 a=pHzHmUro8NiASowvMSCR:22
        a=6VlIyEUom7LUIeUMNQJH:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 05, 2020 at 12:06:05PM +0000, Chris Down wrote:
> The default is still set to inode32 for backwards compatibility, but
> system administrators can opt in to the new 64-bit inode numbers by
> either:
> 
> 1. Passing inode64 on the command line when mounting, or
> 2. Configuring the kernel with CONFIG_TMPFS_INODE64=y
> 
> The inode64 and inode32 names are used based on existing precedent from
> XFS.

Please don't copy this misfeature of XFS.

The inode32/inode64 XFS options were a horrible hack made more than
20 years ago when NFSv2 was still in use and 64 bit inodes could
not be used for NFSv2 exports. It was then continued to be used
because 32bit NFSv3 clients were unable to handle 64 bit inodes.

It took 15 years for us to be able to essentially deprecate
inode32 (inode64 is the default behaviour), and we were very happy
to get that albatross off our necks.  In reality, almost everything
out there in the world handles 64 bit inodes correctly
including 32 bit machines and 32bit binaries on 64 bit machines.
And, IMNSHO, there no excuse these days for 32 bit binaries that
don't using the *64() syscall variants directly and hence support
64 bit inodes correctlyi out of the box on all platforms.

I don't think we should be repeating past mistakes by trying to
cater for broken 32 bit applications on 64 bit machines in this day
and age.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
