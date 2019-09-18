Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58771C4CECD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 01:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36283214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 01:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfIRBXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 21:23:13 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51854 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfIRBXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 21:23:13 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iAOgO-00039C-Vh; Wed, 18 Sep 2019 01:23:01 +0000
Date:   Wed, 18 Sep 2019 02:23:00 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     "zhengbin (A)" <zhengbin13@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: c25aa432ff:  aim9.dir_rtns_1.ops_per_sec -24.5% regression
Message-ID: <20190918012300.GI1131@ZenIV.linux.org.uk>
References: <20190918001736.GK15734@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918001736.GK15734@shao2-debian>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 08:17:36AM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -24.5% regression of aim9.dir_rtns_1.ops_per_sec due to commit:
> 
> 
> commit: c25aa432ff56e179bf5414edff3aa430d2b260c0 ("Fix the locking in dcache_readdir() and friends")
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git master

... and that, folks, is ->d_lock on the parent.  I.e. the original reason for
trying to do the damn thing lockless.

I'd really like to do a lockless variant, properly.  First we'd need to sort
the misuses of d_subdirs/d_child, though - there are several outright bugs
in the mainline.  And right now it looks like it wants to grow a series of
cleanups in autofs.  Oh, well...
