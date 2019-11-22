Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3D4C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 22:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5972071F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 22:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SWM/hJn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfKVWNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 17:13:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41702 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfKVWNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 17:13:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HNjTOsYjIKXP47ZunP1SpB9bIgwH2bYkpYUKHNcPIGY=; b=SWM/hJn9CunaaW/5SMStJOizB
        w9rFZWz87gdbW8X6/40V6lF9ZGfPe74T2e2t+WPE9m36JOorBaAShksHPeXzU27KBR5tOiAqkSbsL
        CRpAcMEez+4y4n95Tg386hRo29yFNdTkuYNKI587sh2JZDXA+Y/sHH7c37LuBMj3KJV/QpIPXpS9g
        WyfxmwyuuzXIuousw7nXwqkGGALG74HUrOTE+ET89/voJBoP+X7gtfSz42JDnPvbZJhp4okI4aR5x
        hZM/cXiaR4M26XEZVmS6V+scJ3AzgjboraAljFpNMrbuMPpgCWnJh1KOG2MPmXi6ClFT5PLop7xkC
        tT1PnKjIw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iYHB9-0002B2-OR; Fri, 22 Nov 2019 22:13:27 +0000
Date:   Fri, 22 Nov 2019 14:13:27 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "zhengbin (A)" <zhengbin13@huawei.com>
Cc:     Hugh Dickins <hughd@google.com>, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        houtao1@huawei.com, yi.zhang@huawei.com,
        "J. R. Okajima" <hooanon05g@gmail.com>
Subject: Re: [PATCH] tmpfs: use ida to get inode number
Message-ID: <20191122221327.GW20752@bombadil.infradead.org>
References: <1574259798-144561-1-git-send-email-zhengbin13@huawei.com>
 <20191120154552.GS20752@bombadil.infradead.org>
 <1c64e7c2-6460-49cf-6db0-ec5f5f7e09c4@huawei.com>
 <alpine.LSU.2.11.1911202026040.1825@eggly.anvils>
 <d22bcbcb-d507-7c8c-e946-704ffc499fa6@huawei.com>
 <alpine.LSU.2.11.1911211125190.1697@eggly.anvils>
 <5423a199-eefb-0a02-6e86-1f6210939c11@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5423a199-eefb-0a02-6e86-1f6210939c11@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 09:23:30AM +0800, zhengbin (A) wrote:
> On 2019/11/22 3:53, Hugh Dickins wrote:
> > On Thu, 21 Nov 2019, zhengbin (A) wrote:
> >> On 2019/11/21 12:52, Hugh Dickins wrote:
> >>> Just a rushed FYI without looking at your patch or comments.
> >>>
> >>> Internally (in Google) we do rely on good tmpfs inode numbers more
> >>> than on those of other get_next_ino() filesystems, and carry a patch
> >>> to mm/shmem.c for it to use 64-bit inode numbers (and separate inode
> >>> number space for each superblock) - essentially,
> >>>
> >>> 	ino = sbinfo->next_ino++;
> >>> 	/* Avoid 0 in the low 32 bits: might appear deleted */
> >>> 	if (unlikely((unsigned int)ino == 0))
> >>> 		ino = sbinfo->next_ino++;
> >>>
> >>> Which I think would be faster, and need less memory, than IDA.
> >>> But whether that is of general interest, or of interest to you,
> >>> depends upon how prevalent 32-bit executables built without
> >>> __FILE_OFFSET_BITS=64 still are these days.
> >> So how google think about this? inode number > 32-bit, but 32-bit executables
> >> cat not handle this?
> > Google is free to limit what executables are run on its machines,
> > and how they are built, so little problem here.
> >
> > A general-purpose 32-bit Linux distribution does not have that freedom,
> > does not want to limit what the user runs.  But I thought that by now
> > they (and all serious users of 32-bit systems) were building their own
> > executables with _FILE_OFFSET_BITS=64 (I was too generous with the
> > underscores yesterday); and I thought that defined __USE_FILE_OFFSET64,
> > and that typedef'd ino_t to be __ino64_t.  And the 32-bit kernel would
> > have __ARCH_WANT_STAT64, which delivers st_ino as unsigned long long.
> >
> > So I thought that a modern, professional 32-bit executable would be
> > dealing in 64-bit inode numbers anyway.  But I am not a system builder,
> > so perhaps I'm being naive.  And of course some users may have to support
> > some old userspace, or apps that assign inode numbers to "int" or "long"
> > or whatever.  I have no insight into the extent of that problem.
> 
> So how to solve this problem?
> 
> 1. tmpfs use ida or other data structure
> 
> 2. tmpfs use 64-bit, each superblock a inode number space
> 
> 3. do not do anything, If somebody hits this bug, let them solve for themselves
> 
> 4. (last_ino change to 64-bit)get_next_ino -->other filesystems will be ok, but it was rejected before

5. Extend the sbitmap API to allow for growing the bitmap.  I had a
look at doing that, and it looks hard.  There are a lot of things which
are set up at initialisation and changing them mid-use seems tricky.
Ccing Jens in case he has an opinion.

6. Creating a percpu IDA.  This doesn't seem too hard.  We need a percpu
pointer to an IDA leaf (128 bytes), and a percpu integer which is the
current base for this CPU.  At allocation time, find and set the first
free bit in the leaf, and add on the current base.

If the percpu leaf is full, set the XA_MARK_1 bit on the entry in
the XArray.  Then look for any leaves which have both the XA_MARK_0
and XA_MARK_1 bits set; if there is one, claim it by clearing the
XA_MARK_1 bit.  If not, kzalloc a new one and find a free spot for it
in the underlying XArray.

Freeing an ID is simply ida_free().  That will involve changing the
users of get_next_ino() to call put_ino(), or something.

This should generally result in similar contention between threads as
the current scheme -- accessing a shared resource every 1024 allocations.
Maybe more often as we try to avoid leaving gaps in the data structure,
or maybe less as we reuse IDs.

(I've tried to explain what I want here, but appreciate it may be
inscrutable.  I can try to explain more, or maybe I should just write
the code myself)
