Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C771C06513
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065042082F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfGBK1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 06:27:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:56538 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726144AbfGBK1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 06:27:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9EDC9B175;
        Tue,  2 Jul 2019 10:27:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 117CBDA8A9; Tue,  2 Jul 2019 12:28:32 +0200 (CEST)
Date:   Tue, 2 Jul 2019 12:28:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: linux-next: build failure after merge of the tip tree
Message-ID: <20190702102832.GP20977@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
References: <20190702153302.28e7948d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702153302.28e7948d@canb.auug.org.au>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 03:33:02PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the tip tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> fs/btrfs/ctree.c: In function '__tree_mod_log_insert':
> fs/btrfs/ctree.c:388:2: error: implicit declaration of function 'lockdep_assert_held_exclusive'; did you mean 'lockdep_assert_held_once'? [-Werror=implicit-function-declaration]
>   lockdep_assert_held_exclusive(&fs_info->tree_mod_log_lock);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   lockdep_assert_held_once
> 
> Caused by commit
> 
>   9ffbe8ac05db ("locking/lockdep: Rename lockdep_assert_held_exclusive() -> lockdep_assert_held_write()")
> 
> interacting with commits
> 
>   84cd7723de7c ("btrfs: assert tree mod log lock in __tree_mod_log_insert")
>   283d2e443505 ("btrfs: assert extent map tree lock in add_extent_mapping")

I can move the patches out of the for-5.3 branch and send them
separately after the rename gets merged, they're merely adding the
assertion and otherwise do not affect the rest of the code.

Fixing that in another way would probably need more synchronization
between the branches but I don't think it's necessary in this case. The
next for-next snapshot branch will fix the compilation issue.
