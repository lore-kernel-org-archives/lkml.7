Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EA1C282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 17:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A2A2082E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 17:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="LCtGT9r9";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="dpzgtwXb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfDMRJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 13:09:45 -0400
Received: from mail18.wdc04.mandrillapp.com ([205.201.139.18]:10448 "EHLO
        mail18.wdc04.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726973AbfDMRJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 13:09:44 -0400
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Apr 2019 13:09:44 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=0mYe0WUaC4U4BVyHa6SsEEW0jl2qNzSdo7dofhcvRCw=;
 b=LCtGT9r9YE7SulABMNINnnda+vxtOgJClPfdUaI+IUR01QjKTMG2LE41Fh0E/AiuFeKfFkd/8FX+
   u2REb36U/HRom5EbVT3n9dtFRTnRjU5dqh9bXfkiyCaN5NzA/tA+/0TqGq+Uj+KHsF43o9V51Bmy
   isCihr7XMba7D9Nusvw=
Received: from pmta08.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail18.wdc04.mandrillapp.com id hm8btg1jvmg2 for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 16:54:41 +0000 (envelope-from <bounce-md_31050260.5cb21450.v1-96b4b67f04e14df4ae1c5a334cfd9d21@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1555174480; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=0mYe0WUaC4U4BVyHa6SsEEW0jl2qNzSdo7dofhcvRCw=; 
 b=dpzgtwXbAXP7KGhuTSIrr+Tq6EeCcTRQBVZqejdE8tmiBC2u3oZQNL8V76yjFhUeR1T/wX
 OQ0URQxlZeg7PYhsAB6dUAMTDsj5cAkYGqoDGsYK763xig6cgUISGTpK3cseagDt00B4ugBt
 u2zm9ptXK/kd8U7Rq1arb6aK7I92w=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH 1/3] fs: stream_open - opener for stream-like files so that read and write can run simultaneously without deadlock
Received: from [87.98.221.171] by mandrillapp.com id 96b4b67f04e14df4ae1c5a334cfd9d21; Sat, 13 Apr 2019 16:54:40 +0000
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Message-Id: <20190413165116.GB10314@deco.navytux.spb.ru>
References: <c44fcf87d4c9d417b6cdced787091300fd45a3e4.1553637461.git.kirr@nexedi.com> <4c4651e2-167e-bfcc-7b3e-cda118f98a69@rasmusvillemoes.dk> <20190409203807.GA13855@deco.navytux.spb.ru> <d8c23d05-8810-13a2-cc50-7a47ff35e90b@rasmusvillemoes.dk> <20190411123816.GA18309@deco.navytux.spb.ru> <CAHk-=whJtZt52SnhBGrNMnuxFn3GE9X_e02x8BPxtkqrfyZukw@mail.gmail.com> <20190412124144.GA22786@deco.navytux.spb.ru>
In-Reply-To: <20190412124144.GA22786@deco.navytux.spb.ru>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.96b4b67f04e14df4ae1c5a334cfd9d21
X-Mandrill-User: md_31050260
Date:   Sat, 13 Apr 2019 16:54:40 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 03:41:44PM +0300, Kirill Smelkov wrote:
> On Thu, Apr 11, 2019 at 09:22:56AM -0700, Linus Torvalds wrote:
> > On Thu, Apr 11, 2019 at 5:38 AM Kirill Smelkov <kirr@nexedi.com> wrote:
> > >
> > > However file->f_pos writing is still there and it will bug under race
> > > detector, e.g. under KTSAN because read and write can be running
> > > simultaneously. Maybe it is not only race bug, but also a bit of
> > > slowdown as read and write code paths write to the same memory thus
> > > needing inter-cpu synchronization if read and write handlers are on
> > > different cpus. However for this I'm not sure.
> > 
> > I doubt it's noticeable, but it would probably be good to simply not
> > do the write for streams.
> > 
> > That *could* be done somewhat similarly, with just changing th address
> > to be updated, or course.
> > 
> > In fact, we *used* to (long ago) pass in the address of "file->f_pos"
> > itself to the low-level read/write routines. We then changed it to do
> > that indirection through a local copy of pos (and
> > file_pos_read/file_pos_write) because we didn't do the proper locking,
> > so different read/write versions could mess with each other (and with
> > lseek).
> > 
> > But one of the things that commit 9c225f2655e36 ("vfs: atomic f_pos
> > accesses as per POSIX") did was to add the proper locking at least for
> > the cases that we care about deeply, so we *could* say that we have
> > three cases:
> > 
> >  - FMODE_ATOMIC_POS: properly locked,
> >  - FMODE_STREAM: no pos at all
> >  - otherwise a "mostly don't care - don't mix!"
> > 
> > and so we could go back to not copying the pos at all, and instead do
> > something like
> > 
> >         loff_t *ppos = f.file->f_mode & FMODE_STREAM ? NULL : &file->f_pos;
> >         ret = vfs_write(f.file, buf, count, ppos);
> > 
> > and perhaps have a long-term plan to try to get rid of the "don't mix"
> > case entirely (ie "if you use f_pos, then we'll do the proper
> > locking")
> > 
> > (The above is obviously surrounded by the fdget_pos()/fdput_pos() that
> > implements the locking decision).
> 
> Ok Linus, thanks for feedback. Please consider applying or queueing the
> following patches.

Resending those patches one by one in separate emails, if maybe 2
patches inline was problematic to handle...
