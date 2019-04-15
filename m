Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3047CC282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 23:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B332075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 23:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfDOXyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 19:54:39 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43588 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbfDOXyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 19:54:38 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGBQi-0004gX-T3; Mon, 15 Apr 2019 23:54:28 +0000
Date:   Tue, 16 Apr 2019 00:54:28 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Khazhismel Kumykov <khazhy@google.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+2b74da47f048a5046135@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs@vger.kernel.org
Subject: Re: WARNING in notify_change
Message-ID: <20190415235428.GS2217@ZenIV.linux.org.uk>
References: <94eb2c0ce3aa7551d30569658325@google.com>
 <96c750b3-fcb0-3d7f-45eb-45459078ef83@I-love.SAKURA.ne.jp>
 <CACGdZYLPLF40cUK+-aZ6O4vOR1YLvHzLJ70SFneKJ7KOXwBOug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGdZYLPLF40cUK+-aZ6O4vOR1YLvHzLJ70SFneKJ7KOXwBOug@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 04:20:17PM -0700, Khazhismel Kumykov wrote:
> I was able to reproduce this by setting security.capability xattr on a
> blockdev file, then writing to it - when writing to the blockdev we
> never lock the inode, so when we clear the capability we hit this
> lockdep warning.
> 
> Is the issue here that we can set this xattr in the first place so we
> have to clear it at all? Or should we really be locking the inode for
> blockdevs after all? I'm not too familiar, but my gut says former

More interesting question is, WTF do we even touch that thing for
bdev?  The thing is, mknod will cheerfully create any number of
different filesystem objects, all giving access to the same block
device.  Which of them should have that xattr removed?  It makes
no sense whatsoever; moreover, who *cares* about caps for block
device in the first place?

And if we did, what of another way to modify the block device?
You know, mount it read-write...
