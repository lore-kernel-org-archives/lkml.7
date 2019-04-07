Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE5AC282DD
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 20:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE3320896
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 20:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="Q0H4s6oE";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="h3pJ2Rhg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfDGUTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 16:19:36 -0400
Received: from mail177-10.suw61.mandrillapp.com ([198.2.177.10]:52363 "EHLO
        mail177-10.suw61.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726456AbfDGUTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 16:19:36 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Apr 2019 16:19:34 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=c9odqYKh8VA83uRMWnYw5b/vnYIMu6ToiyLWwrLHG6Y=;
 b=Q0H4s6oE5IAmakxLmN3iqlE93cEQXyq19cJh81SkcDIaIRZ6RL2Hmn2b9HPlwY6Pa6b6N6JaJKdX
   5yk5AefaWsslGzww4OApLPhXYBFIs53f0jIEU551bbPLRQW8FDlk7AV/wmA7QUhJ0gaRMmtJRrMs
   /5xZ1qWzFBWeHCGx14M=
Received: from pmta06.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail177-10.suw61.mandrillapp.com id hl9dlc22rtkb for <linux-kernel@vger.kernel.org>; Sun, 7 Apr 2019 20:04:32 +0000 (envelope-from <bounce-md_31050260.5caa57d0.v1-38462f32aecf452795a2e26032fb1488@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1554667472; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=c9odqYKh8VA83uRMWnYw5b/vnYIMu6ToiyLWwrLHG6Y=; 
 b=h3pJ2RhgfyIDJA0PtsEZvBTye/1Uu6u62yvfidlX3bddvPuTLE/0XYBNyKOLhKiOrjNOIJ
 7yGY5LWhJBOmAkEhwW6dqc038aRrIJmY++B6qvVDzIrzJlQTKnRYdsKLGulNztoxsSrJzE20
 SJ9iwz2BFIObGho+F9jRSgdWXMjBg=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH 1/3] fs: stream_open - opener for stream-like files so that read and write can run simultaneously without deadlock
Received: from [87.98.221.171] by mandrillapp.com id 38462f32aecf452795a2e26032fb1488; Sun, 07 Apr 2019 20:04:32 +0000
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yongzhi Pan <panyongzhi@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Vrabel <david.vrabel@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>, Tejun Heo <tj@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Nikolaus Rath <Nikolaus@rath.org>,
        Han-Wen Nienhuys <hanwen@google.com>
Message-Id: <20190407200423.GA2829@deco.navytux.spb.ru>
References: <c44fcf87d4c9d417b6cdced787091300fd45a3e4.1553637461.git.kirr@nexedi.com> <CAHk-=wgqgN5j1ZWnyVLqqoyU=CCWTYOko3MDyU8L_5e21KvHAg@mail.gmail.com>
In-Reply-To: <CAHk-=wgqgN5j1ZWnyVLqqoyU=CCWTYOko3MDyU8L_5e21KvHAg@mail.gmail.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.38462f32aecf452795a2e26032fb1488
X-Mandrill-User: md_31050260
Date:   Sun, 07 Apr 2019 20:04:32 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 06, 2019 at 07:07:14AM -1000, Linus Torvalds wrote:
> On Tue, Mar 26, 2019 at 12:20 PM Kirill Smelkov <kirr@nexedi.com> wrote:
> >
> > Commit 9c225f2655 (vfs: atomic f_pos accesses as per POSIX) added locking for
> > file.f_pos access and in particular made concurrent read and write not possible
> > [...]
> 
> Ok, I have applied this patch - but this patch only - as a
> well-researched preparatory patch.
> 
> The actual conversion patch looks fine to me too, and I see a few
> acks, but I think I'd like to see it during a merge window just
> because it's large and does significant changes, while this one is
> purely preparatory.
> 
> Al, comments?

Linus, thanks a lot for feedback and for accepting the patch.

I agree that it is better to merge the bulk-conversion at the time of
next merge window. I hope Al will pick that patch up and send to you
when the next merge window time comes.

Could we please clarify one thing: is the general complete plan to deal
with this regression, as outlined in the merged patch, ok? I mean do we
agree to further proceed with fs/fuse/ FOPEN_STREAM (patch 3/3) and
backport it + stream_open to v3.14+ stable kernels? Unfortunately it
requires a bit of cooperation from userspace, but this scheme to fix the
regression is the best I could come up with.

If FUSE bits are ok, how should we go? Are we ok to merge that patch
now, or should we wait for the next merge window? I understand that
generally it should be merge window from one side, but since we are
trying to fix regression here and if the plan for regression fix is
accepted it should be merge now. If we merge now, what should be the way
for that patch to get merged?

Fixing regression on FUSE side is my reason to do this whole work -
that's why I care about it the most and ask.

> One small note: please don't use lkml.org references since they tend
> to be slow and flaky - use lore.kernel.org instead. Also, fix your git
> config to use 12-character git hashes (best done by just removing the
> explicit hash size entirely, and letting modern git shorten hashes
> appropriately automatically).

Thanks for pointing to lore.kernel.org - I'm not very keen to kernel
development and did not knew it exists. I was seeing lkml.org being
referenced here and there and that's why I used it. I will use
lore.kernel.org from now.

Short hashes were not due to git config, but due to me trimming them to
10 characters in vim manually. I will use longer hashes as you ask.

Kirill
