Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF82C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5C420657
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbfDDSoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:44:54 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52316 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729456AbfDDSoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:44:54 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hC7M0-0004An-VA; Thu, 04 Apr 2019 18:44:49 +0000
Date:   Thu, 4 Apr 2019 19:44:48 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v2] acct: fix possible deadlock in acct_pin_kill
Message-ID: <20190404184448.GC2217@ZenIV.linux.org.uk>
References: <20190404105255.12189-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404105255.12189-1-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 01:52:55PM +0300, Amir Goldstein wrote:
> This looks like an old bug, pre-dating the "Fixes" commit, but the
> "Fixes" commit did not handle it properly.
> 
> The bug recently surfaced as a lockdep possible deadlock warning
> with commit d1d04ef8572b ("ovl: stack file ops").
> 
> When acct_on() replaces one acct file with another, it takes sb_writers
> lock on new file sb and calls acct_pin_kill(old) before releasing the
> sb_writers lock.
>
> If new file is on the same fs as old file, acct_pin_kill(old) fail to
> file_start_write_trylock() and skip writing the old file, because
> sb_writers (of new) is already taken by acct_on().
> 
> If new file is not on same fs as old file, this ordering violation
> creates an unneeded dependency between new sb_writers and old sb_writers,
> which may later be reported as possible deadlock.
> 
> This could result in an actual deadlock if acct file is replaced from
> an old file in overlayfs over "real fs" to a new file in "real fs".
> acct_on() takes freeze protection on "real fs" and tries to write to
> overlayfs file. overlayfs is not freeze protected so do_acct_process()
> can carry on with __kernel_write() to overlayfs file, which would
> try to take freeze protection on "real fs" and deadlock.

Huh?  sb_writers is taken when we *open* the new file.  Then we replace
its ->path.mnt with a clone and transfer the write count from the original
to new one.  And close the old file while we are at it.

From sb_writers POV mainline has
	sb_start_write(new_sb)	// in open
	sb_start_write(new_sb)	// mnt_want_write() on clone
	last write to old_sb, then sb_end_write(old_sb) // acct_pin_kill()
	sb_end_write(new_sb)	// mnt_drop_write(mnt)
and you flip the order of the last two lines.

Could you explain how exactly does your patch help whatever
problem overlayfs has?
