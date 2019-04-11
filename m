Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBF9C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 02:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA04F2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 02:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfDKCXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 22:23:08 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47234 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfDKCXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 22:23:08 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hEPMf-0002Fx-8f; Thu, 11 Apr 2019 02:22:57 +0000
Date:   Thu, 11 Apr 2019 03:22:57 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ian Kent <raven@themaw.net>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: kernel BUG at fs/inode.c:LINE!
Message-ID: <20190411022257.GB2217@ZenIV.linux.org.uk>
References: <00000000000036a4a9058619dff3@google.com>
 <20190410002603.GS2217@ZenIV.linux.org.uk>
 <CACT4Y+YurDDxvvd2MbOf8pGyA0B+W_EFB34oVAcHXyv-ApKC7Q@mail.gmail.com>
 <eb223b47641df91a56fd200188a65d2c0ca4abe1.camel@themaw.net>
 <CACT4Y+YdaDdDbRvQZzvqbPofMD6F9cPtGFzcW+db-etJayfaJw@mail.gmail.com>
 <5c581e6eadc946b965e3138c9daffda75b1fba56.camel@themaw.net>
 <1f1d3b95189b6b8acfdf61dd05a804744791d313.camel@themaw.net>
 <20190410121159.GY2217@ZenIV.linux.org.uk>
 <CACT4Y+bc=A=djKChMkJGwXYbZ7UXuxmRu5Z0Y1BEXAFH1-Z6Kw@mail.gmail.com>
 <ed84e67c9cb55e91daf0d090152b3a9e2e06fe0b.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed84e67c9cb55e91daf0d090152b3a9e2e06fe0b.camel@themaw.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 08:50:17AM +0800, Ian Kent wrote:
> On Wed, 2019-04-10 at 14:41 +0200, Dmitry Vyukov wrote:
> > On Wed, Apr 10, 2019 at 2:12 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > 
> > > On Wed, Apr 10, 2019 at 08:07:15PM +0800, Ian Kent wrote:
> > > 
> > > > > I'm unable to find a branch matching the line numbers.
> > > > > 
> > > > > Given that, on the face of it, the scenario is impossible I'm
> > > > > seeking clarification on what linux-next to look at for the
> > > > > sake of accuracy.
> > > > > 
> > > > > So I'm wondering if this testing done using the master branch
> > > > > or one of the daily branches one would use to check for conflicts
> > > > > before posting?
> > > > 
> > > > Sorry those are tags not branches.
> > > 
> > > FWIW, that's next-20181214; it is what master had been in mid-December
> > > and master is rebased every day.  Can it be reproduced with the current
> > > tree?
> > 
> > From the info on the dashboard we know that it happened only once on
> > d14b746c (the second one is result of reproducing the first one). So
> > it was either fixed or just hard to trigger.
> 
> Looking at the source of tag next-20181214 in linux-next-history I see
> this is mistake I made due to incorrect error handling which I fixed
> soon after (there was in fact a double iput()).

Right - "autofs: fix possible inode leak in autofs_fill_super()" had been
broken (and completely pointless), leading to double iput() in that failure
case.  And yes, double iput() can trigger that BUG_ON(), and with non-zero
odds do so with that stack trace.

As far as I'm concerned, case closed - bug had been in a misguided "fix"
for inexistent leak (coming from misreading the calling conventions for
d_make_root()), introduced in -next at next-20181130 and kicked out of
there in next-20181219.  Dropped by Ian's request in 
Message-ID: <66d497c00cffb3e4109ca0d5287c8277954d7132.camel@themaw.net>
which has fixed that crap.  Moreover, that posting had been in reply to
that very syzcaller report, AFAICS.

I don't know how to tell the bot to STFU and close the report in this
situation; up to you, folks.

As an aside, the cause of that bug is that d_make_root() calling conventions
are insufficiently documented.  All we have is

||[mandatory]
||        d_alloc_root() is gone, along with a lot of bugs caused by code
||misusing it.  Replacement: d_make_root(inode).  The difference is,
||d_make_root() drops the reference to inode if dentry allocation fails.

in Documentation/filesystems/porting, and that's not good enough.  Anyone
willing to take a shot at that?  FWIW, the calling conventions are:

	d_make_root(inode) normally allocates and returns a new dentry.
On failure NULL is returned.  A reference to inode is consumed in all
cases (on success it is transferred to new dentry, on failure it is
dropped), so failure handling does not need anything done to inode.
d_make_root(NULL) quietly returns NULL, which further simplifies the
error handling in typical caller.  Usually it's something like
	inode = foofs_new_inode(....);
	s->s_root = d_make_inode(inode);
	if (!s->s_root)
		bugger off, no need to undo inode allocation
	success
We do not need to check if foofs_new_inode() has returned NULL and we
do not need any special cleanups in case of failure - not for the
undoing the inode allocation.

If anyone cares to convert that into coherent (and printable) documentation,
patches are welcome...
