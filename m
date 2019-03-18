Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D18AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 00:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E856620872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 00:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbfCRAEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 20:04:20 -0400
Received: from nautica.notk.org ([91.121.71.147]:56412 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727535AbfCRAEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 20:04:20 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 777D4C009; Mon, 18 Mar 2019 01:04:17 +0100 (CET)
Date:   Mon, 18 Mar 2019 01:04:02 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     v9fs-developer@lists.sourceforge.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Subject: Re: [GIT PULL] 9p updates for 5.1
Message-ID: <20190318000402.GA24768@nautica>
References: <20190317142524.GA5136@nautica>
 <CAHk-=wgywWzGP-UszbL4csXpk4_h0w5PbkZYdaTpBzue82btfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgywWzGP-UszbL4csXpk4_h0w5PbkZYdaTpBzue82btfQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote on Sun, Mar 17, 2019:
> Hmm. I wonder what makes it valid to have concurrent updates to
> i_size? Yes, yes, you added that spinlock to make the update itself
> atomic on 32-bit, but it sounds a bit odd in the first place to have
> two things possibly changing the size of a file at the same time...

If the inode attributes are currently invalid (for example after
v9fs_invalidate_inode_attr()) then two concurrent user getattr requests
for the same inode will send two network requests which can both update
the i_size.

With cache=fscache or loose a write could also be concurrent with such
an update.


I plan on improving the first case with some "being revalidated" logic
now this pattern got reported but I don't think the second one can be
avoided, so that fix is still necessary in the long run afaict.


Thanks,
-- 
Dominique
