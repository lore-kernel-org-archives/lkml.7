Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1459CC4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 12:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE80E2073F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 12:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfITMyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 08:54:54 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35276 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfITMyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 08:54:53 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iBIQs-0005Yn-1s; Fri, 20 Sep 2019 12:54:42 +0000
Date:   Fri, 20 Sep 2019 13:54:42 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     dwmw2@infradead.org, dilinger@queued.net, richard@nod.at,
        houtao1@huawei.com, bbrezillon@kernel.org, daniel.santos@pobox.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jffs2:freely allocate memory when parameters are invalid
Message-ID: <20190920125442.GA20754@ZenIV.linux.org.uk>
References: <1568962478-126260-1-git-send-email-nixiaoming@huawei.com>
 <20190920114336.GM1131@ZenIV.linux.org.uk>
 <206f8d57-dad9-26c3-6bf6-1d000f5698d4@huawei.com>
 <20190920124532.GN1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920124532.GN1131@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 01:45:33PM +0100, Al Viro wrote:
> On Fri, Sep 20, 2019 at 08:21:53PM +0800, Xiaoming Ni wrote:
> > 
> > 
> > On 2019/9/20 19:43, Al Viro wrote:
> > > On Fri, Sep 20, 2019 at 02:54:38PM +0800, Xiaoming Ni wrote:
> > >> Use kzalloc() to allocate memory in jffs2_fill_super().
> > >> Freeing memory when jffs2_parse_options() fails will cause
> > >> use-after-free and double-free in jffs2_kill_sb()
> > > 
> > > ... so we are not freeing it there.  What's the problem?
> > 
> > No code logic issues, no memory leaks
> > 
> > But there is too much code logic between memory allocation and free,
> > which is difficult to understand.
> 
> Er?  An instance of jffs2 superblock might have a related object
> attached to it; it is created in jffs2 superblock constructor and
> freed in destructor.
> 
> > The modified code is easier to understand.
> 
> You are making the cleanup logics harder to follow.

PS: the whole point of ->kill_sb() is that it's always called on
superblock destruction, whether that instance had been fully set
up of failed halfway through.

In particular, anything like foofs_fill_super() *will* be followed
by ->kill_sb().  Always.  Which allows for simpler logics in
failure exits.  And the main thing about those is that they are
always the bitrot hot spots - they are systematically undertested,
so that's the last place where you want something non-trivial.

As for "too much code between"...  Huh?  We fail jffs2_fill_super()
immediately, which has get_tree_mtd() (or mount_mtd() in slightly
earlier kernels) destroy the superblock there and then...
