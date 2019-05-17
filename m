Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9B2C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 13:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640BB2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 13:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfEQNsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 09:48:53 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46198 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbfEQNsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 09:48:53 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hRdEA-0001Yb-Ey; Fri, 17 May 2019 13:48:50 +0000
Date:   Fri, 17 May 2019 14:48:50 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     syzbot <syzbot+73c7fe4f77776505299b@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sabin.rapan@gmail.com, syzkaller-bugs@googlegroups.com
Subject: Re: BUG: unable to handle kernel paging request in do_mount
Message-ID: <20190517134850.GG17978@ZenIV.linux.org.uk>
References: <00000000000014285d05765bf72a@google.com>
 <0000000000000eaf23058912af14@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000000eaf23058912af14@google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 03:17:02AM -0700, syzbot wrote:
> This bug is marked as fixed by commit:
> vfs: namespace: error pointer dereference in do_remount()
> But I can't find it in any tested tree for more than 90 days.
> Is it a correct commit? Please update it by replying:
> #syz fix: exact-commit-title
> Until then the bug is still considered open and
> new crashes with the same signature are ignored.

Could somebody explain how the following situation is supposed to
be handled:

1) branch B1 with commits  C1, C2, C3, C4 is pushed out
2) C2 turns out to have a bug, which gets caught and fixed
3) fix is folded in and branch B2 with C1, C2', C3', C4' is
pushed out.  The bug is not in it anymore.
4) B1 is left mouldering (or is entirely removed); B2 is
eventually merged into other trees.

This is normal and it appears to be problematic for syzbot.
How to deal with that?  One thing I will *NOT* do in such
situations is giving up on folding the fixes in.  Bisection
hazards alone make that a bad idea.
