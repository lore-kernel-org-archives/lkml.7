Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14131C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 19:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D57E6218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 19:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555098421;
	bh=WHdNZD8SFTlar+YeQLvAISzTis7csPuXZZcC132Rqro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0GEX4BSEHENOt7NTSaotzsQt7ob/wrcFzJDetOt3Nglqa/ynRxUNayTZHsSBW0Td9
	 Bgqos3BViOuuzfTv52bD//9wfqATi8Xtlbk9URRlvihNNRfu7/lMpDS02oPCPe7Rj8
	 Bk60vweRfzMqF+tg8pnK+J7BVOMqjTGAGEAJVKq4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfDLTrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 15:47:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbfDLTrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 15:47:00 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1F682171F;
        Fri, 12 Apr 2019 19:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555098419;
        bh=WHdNZD8SFTlar+YeQLvAISzTis7csPuXZZcC132Rqro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x52ueQlljQXO2vmSkQqH+FI8HMS5dUnTo09OFyChcU+QqspLrOqkfL13hYJM9R3Dx
         hHc8tXHAExcQXb7HNjkU9aPu0UOueqf3h5nD9jqi3IFHPhBqLyCn05kQPUDDZxeLlP
         O6WN5/bwssy93TnzHdUqI+l2UMDXWiWuG7fLzDp4=
Date:   Fri, 12 Apr 2019 12:46:57 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        syzbot <syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: kernel BUG at fs/inode.c:LINE!
Message-ID: <20190412194656.GA8045@gmail.com>
References: <CACT4Y+YurDDxvvd2MbOf8pGyA0B+W_EFB34oVAcHXyv-ApKC7Q@mail.gmail.com>
 <eb223b47641df91a56fd200188a65d2c0ca4abe1.camel@themaw.net>
 <CACT4Y+YdaDdDbRvQZzvqbPofMD6F9cPtGFzcW+db-etJayfaJw@mail.gmail.com>
 <5c581e6eadc946b965e3138c9daffda75b1fba56.camel@themaw.net>
 <1f1d3b95189b6b8acfdf61dd05a804744791d313.camel@themaw.net>
 <20190410121159.GY2217@ZenIV.linux.org.uk>
 <CACT4Y+bc=A=djKChMkJGwXYbZ7UXuxmRu5Z0Y1BEXAFH1-Z6Kw@mail.gmail.com>
 <ed84e67c9cb55e91daf0d090152b3a9e2e06fe0b.camel@themaw.net>
 <20190411022257.GB2217@ZenIV.linux.org.uk>
 <CACT4Y+ZYyAYuy_dB1jx1MW7S1RowbLhd0s-OJjkRCo0UG7_BEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZYyAYuy_dB1jx1MW7S1RowbLhd0s-OJjkRCo0UG7_BEA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Fri, Apr 12, 2019 at 01:04:27PM +0200, 'Dmitry Vyukov' via syzkaller-bugs wrote:
> On Thu, Apr 11, 2019 at 4:23 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Thu, Apr 11, 2019 at 08:50:17AM +0800, Ian Kent wrote:
> > > On Wed, 2019-04-10 at 14:41 +0200, Dmitry Vyukov wrote:
> > > > On Wed, Apr 10, 2019 at 2:12 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > > >
> > > > > On Wed, Apr 10, 2019 at 08:07:15PM +0800, Ian Kent wrote:
> > > > >
> > > > > > > I'm unable to find a branch matching the line numbers.
> > > > > > >
> > > > > > > Given that, on the face of it, the scenario is impossible I'm
> > > > > > > seeking clarification on what linux-next to look at for the
> > > > > > > sake of accuracy.
> > > > > > >
> > > > > > > So I'm wondering if this testing done using the master branch
> > > > > > > or one of the daily branches one would use to check for conflicts
> > > > > > > before posting?
> > > > > >
> > > > > > Sorry those are tags not branches.
> > > > >
> > > > > FWIW, that's next-20181214; it is what master had been in mid-December
> > > > > and master is rebased every day.  Can it be reproduced with the current
> > > > > tree?
> > > >
> > > > From the info on the dashboard we know that it happened only once on
> > > > d14b746c (the second one is result of reproducing the first one). So
> > > > it was either fixed or just hard to trigger.
> > >
> > > Looking at the source of tag next-20181214 in linux-next-history I see
> > > this is mistake I made due to incorrect error handling which I fixed
> > > soon after (there was in fact a double iput()).
> >
> > Right - "autofs: fix possible inode leak in autofs_fill_super()" had been
> > broken (and completely pointless), leading to double iput() in that failure
> > case.  And yes, double iput() can trigger that BUG_ON(), and with non-zero
> > odds do so with that stack trace.
> >
> > As far as I'm concerned, case closed - bug had been in a misguided "fix"
> > for inexistent leak (coming from misreading the calling conventions for
> > d_make_root()), introduced in -next at next-20181130 and kicked out of
> > there in next-20181219.  Dropped by Ian's request in
> > Message-ID: <66d497c00cffb3e4109ca0d5287c8277954d7132.camel@themaw.net>
> > which has fixed that crap.  Moreover, that posting had been in reply to
> > that very syzcaller report, AFAICS.
> >
> > I don't know how to tell the bot to STFU and close the report in this
> > situation; up to you, folks.
> 
> 
> Please see the following for this:
> 
> > syzbot will keep track of this bug report. See:
> > https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  syzbot.
> 
> There are just 3 operations: mark as fixed by a commit, mark as
> invalid, mark as duplicate.
> I won't be always around. Tracking statuses of bug reports is in the
> interests of kernel quality.
> 

As I suggested before, syzbot should automatically invalidate old bug reports,
especially on linux-next, that are unlikely to still be real problems.

And, syzbot should send remainders about bugs that are still occurring.

Instead, currently developers have to waste time debugging bugs caused by
patches that were in linux-next for a few days/weeks and then dropped months
ago, and have to argue with you every time about how to tell syzbot to close the
bug when it never made it into git history.  And meanwhile, no one is looking
into the bugs that are being hit on mainline every hour or even every 10 minutes
for the past year.

That's not a great strategy to actually get bugs fixed.

- Eric
