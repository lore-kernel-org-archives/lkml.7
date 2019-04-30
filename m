Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D5DC04AA6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 03:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C2DD2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 03:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbfD3DLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 23:11:50 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:37734 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729981AbfD3DLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 23:11:50 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hLJBI-00064y-57; Tue, 30 Apr 2019 03:11:44 +0000
Date:   Tue, 30 Apr 2019 04:11:44 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jan Kara <jack@suse.cz>
Cc:     syzbot <syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com>,
        axboe@kernel.dk, dvyukov@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        syzkaller-bugs@googlegroups.com
Subject: Re: INFO: task hung in __get_super
Message-ID: <20190430031144.GG23075@ZenIV.linux.org.uk>
References: <001a113ed5540f411c0568cc8418@google.com>
 <0000000000002cd22305879b22c4@google.com>
 <20190428185109.GD23075@ZenIV.linux.org.uk>
 <20190430025501.GB6740@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430025501.GB6740@quack2.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 04:55:01AM +0200, Jan Kara wrote:

> Yeah, you're right. And if we push the patch a bit further to not take
> loop_ctl_mutex for invalid ioctl number, that would fix the problem. I
> can send a fix.

Huh?  We don't take it until in lo_simple_ioctl(), and that patch doesn't
get to its call on invalid ioctl numbers.  What am I missing here?
