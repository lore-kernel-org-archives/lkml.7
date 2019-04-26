Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5F4C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBDED206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="Q5i0s4f7";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="AMv8oQLc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfDZHph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 03:45:37 -0400
Received: from mail136-22.atl41.mandrillapp.com ([198.2.136.22]:7834 "EHLO
        mail136-22.atl41.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725921AbfDZHpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 03:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=szoNXHM6Qfos2sAdPtDTuYsSXu3opjDQI6OlZAtJ8FU=;
 b=Q5i0s4f72Rp6dczEkiJynouPJCpT8mdKddrA89JV5cwqbjAK5UqlqqYoZ5JyGDhd09aymAgFkwgv
   gb+c2Kkiug12twP5PoVG1MJAeSVu+kTQn0QJcylwstSpPyIHo0zyZc8ZbEeOEOIkUlUT4mdWU03x
   68nLTfKkCenJG0yFqQY=
Received: from pmta04.mandrill.prod.atl01.rsglab.com (127.0.0.1) by mail136-22.atl41.mandrillapp.com id hoarhu1sb1kk for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 07:45:33 +0000 (envelope-from <bounce-md_31050260.5cc2b71d.v1-7802e6c54a8445f0ace53db90eabefbb@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1556264733; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=szoNXHM6Qfos2sAdPtDTuYsSXu3opjDQI6OlZAtJ8FU=; 
 b=AMv8oQLcCsWhJVtQ3+wB8Ws0lFqM5xMa1gAMgjvn3O9MN47wGsg8m4s1ttEAIH6Kn4bDy4
 3M2VuHEauatT4pcjG5QbzlxGmH6vylF9NpmZgU5dzfXJBGmfrmqJxSIQmBaWQ6hPHjzBHM28
 W7830y4VVpUFPyhR87eHpzhE1TLmM=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH AUTOSEL 5.0 59/66] fs: stream_open - opener for stream-like files so that read and write can run simultaneously without deadlock
Received: from [87.98.221.171] by mandrillapp.com id 7802e6c54a8445f0ace53db90eabefbb; Fri, 26 Apr 2019 07:45:33 +0000
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yongzhi Pan <panyongzhi@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Vrabel <david.vrabel@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>, Tejun Heo <tj@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Nikolaus Rath <Nikolaus@rath.org>,
        Han-Wen Nienhuys <hanwen@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Message-Id: <20190426074522.GA16247@deco.navytux.spb.ru>
References: <20190424143341.27665-1-sashal@kernel.org> <20190424143341.27665-59-sashal@kernel.org> <20190424163415.GB21413@kroah.com> <CAHk-=wjEOyba5As1PEMk6RitNVOJH9oJ_Jbg4y=5B0fcX1iKGw@mail.gmail.com> <20190424171926.GA17719@sasha-vm> <CAHk-=wgh234SyBG810=vB360PCzVkAhQRqGg8aFdATZd+daCFw@mail.gmail.com> <20190424183012.GB3798@deco.navytux.spb.ru> <4d366f81f90442cb9da7ad393680d004@AcuMS.aculab.com>
In-Reply-To: <4d366f81f90442cb9da7ad393680d004@AcuMS.aculab.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.7802e6c54a8445f0ace53db90eabefbb
X-Mandrill-User: md_31050260
Date:   Fri, 26 Apr 2019 07:45:33 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 10:04:34AM +0000, David Laight wrote:
> From: Kirill Smelkov
> > Sent: 24 April 2019 19:30
> > 
> > On Wed, Apr 24, 2019 at 10:26:55AM -0700, Linus Torvalds wrote:
> > > On Wed, Apr 24, 2019 at 10:19 AM Sasha Levin <sashal@kernel.org> wrote:
> > > >
> > > > Hm, I might be confusing something here but I see a bunch of patches
> > > > that convert existing callers mentioned in this patch to use
> > > > stream_open() which was introduced here.
> > >
> > > The only use of stream_open() upstream right now is the xenbus
> > > conversion, and that isn't actually a bugfix, because xenbus used to
> > > manually do that
> > >
> > >         filp->f_mode &= ~FMODE_ATOMIC_POS; /* cdev-style semantics */
> > >
> > > that stream_open() does.
> > >
> > > So no, there isn't "a bunch of patches" anywhere.
> > >
> > > There are *future* cleanups for 5.2 that will happen, and that might
> > > have hit linux-next. And there is at least one FUSE patch (again -
> > > pending, not upstream) that may get marked for stable.
> > >
> > > But I see nothing right now that makes it stable material yet.
> > 
> > Linus, thanks for explaining. Sasha, Greg, there is a FUSE patch that
> > should be stable material that will need this stream_open() thing. That
> > patch has just entered fuse.git#for-next today:
> > 
> > 	https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git/commit/?id=bbd84f33652f
> > 
> > and will hopefully enter 5.2 when merge window opens. I agree we should
> > not blindly backport bulk stream_open conversions as performed by
> > stream_open.cocci, at least unless there is a bug report indicating that
> > it is actually required for a particular driver. On the other hand both
> > Xen and FUSE deadlocks were hit for real which justifies stable
> > propagation for their fixes.
> > 
> > You can read about the deadlock regression and the plan to fix it in
> > original "fs: stream_open - opener for stream-like files so that read
> > and write can run simultaneously without deadlock" patch (the 59/66
> > patch that was send in this thread), or here:
> > 
> > 	https://git.kernel.org/linus/10dce8af3422
> > 
> > 
> > Hope it clarifies things a bit,
> 
> I can also imagine drivers that expect accesses to be done using
> pread() and pwrite() - maybe only if the fd is shared.
> Provided accesses get the correct offset they can be concurrent.
> In fact they only need to update the offset in the file structure
> when they complete - they may do this already.
> 
> I know (I think) uclibc implementing pread() as lseek() + read()
> caused me grief - but that might just have been the extra system
> call overhead rather than any problems with the offset.

I'm not sure I understand your comment completely, but we convert to
stream_open only drivers that actually do _not_ use position at all, and
that were already using nonseekable_open, thus pread and pwrite were
already returning -ESPIPE for them (nonseekable_open clears
FMODE_{PREAD,PWRITE} and ksys_{pread,pwrite}64 check for that flag). We
also convert only drivers that use no_llseek for .llseek, so lseek
on those files is/was always returning -ESPIPE as well.

If a driver uses position in its read and write and has support for
pread/pwrite (FMODE_PREAD and FMODE_PWRITE), pread and pwrite are
already working _without_ file->f_pos locking - because those system
calls do not semantically update file->f_pos at all and thus do not take
file->f_pos_lock - i.e. pread/pwrite can be run simultaneously already.

If libc implements pread as lseek+read it will work for a single
user case  (single thread, or fd not shared between processes), but it
will break because of lseek+read non-atomicity if multiple preads are
simultaneously used from several threads. And also for such emulation
for multiple users case there is a chance for pread vs pwrite deadlock,
since those system calls are using read and write and read and write
take file->f_pos_lock.

Kirill
