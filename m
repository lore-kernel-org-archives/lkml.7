Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA740C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A9E208C4
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbgAGRfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 12:35:30 -0500
Received: from fieldses.org ([173.255.197.46]:53664 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728321AbgAGRfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:35:30 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 19CA11C7B; Tue,  7 Jan 2020 12:35:30 -0500 (EST)
Date:   Tue, 7 Jan 2020 12:35:30 -0500
To:     Chris Down <chris@chrisdown.name>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] fs: inode: Reduce volatile inode wraparound risk when
 ino_t is 64 bit
Message-ID: <20200107173530.GC944@fieldses.org>
References: <20191220024936.GA380394@chrisdown.name>
 <20191220213052.GB7476@magnolia>
 <20191221101652.GA494948@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191221101652.GA494948@chrisdown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 21, 2019 at 10:16:52AM +0000, Chris Down wrote:
> Darrick J. Wong writes:
> >On Fri, Dec 20, 2019 at 02:49:36AM +0000, Chris Down wrote:
> >>In general, userspace applications expect that (device, inodenum) should
> >>be enough to be uniquely point to one inode, which seems fair enough.
> >
> >Except that it's not.  (dev, inum, generation) uniquely points to an
> >instance of an inode from creation to the last unlink.

I thought that (dev, inum) was supposed to be unique from creation to
last unlink (and last close), and (dev, inum, generation) was supposed
to be unique for all time.

> I didn't mention generation because, even though it's set on tmpfs
> (to prandom_u32()), it's not possible to evaluate it from userspace
> since `ioctl` returns ENOTTY. We can't ask userspace applications to
> introspect on an inode attribute that they can't even access :-)

Is there any reason not to add IOC_GETVERSION support to tmpfs?

I wonder if statx should return it too?

--b.
