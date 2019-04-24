Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FC1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423FF20811
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="ArXKdqyf";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="JSbNmJXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfDXKJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:09:48 -0400
Received: from mail133-30.atl131.mandrillapp.com ([198.2.133.30]:55347 "EHLO
        mail133-30.atl131.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726165AbfDXKJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:09:48 -0400
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Apr 2019 06:09:47 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=yRMB3pMw4mBukmaUAj505ga+ScMn/6k9BHcKL1FSgWk=;
 b=ArXKdqyfYiOa5/U9PQbH6be588Pz1Cw+UKaoNnxmeuAONEVbKXOk3FhBlKjYN1I7fnrcMVJLy9ee
   dLgxd3ivBApm+C6GDbzixAZ+6GSdT3C4e63KT7+prx51m9w8oFlQ1cW2nrakqBDMEuSCnATQOBOb
   34SNw4zpzonNYEzbjQM=
Received: from pmta02.mandrill.prod.atl01.rsglab.com (127.0.0.1) by mail133-30.atl131.mandrillapp.com id ho0qum1sar8v for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 09:54:46 +0000 (envelope-from <bounce-md_31050260.5cc03266.v1-0f65b88fe6904c1180c2268c83f27589@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1556099686; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=yRMB3pMw4mBukmaUAj505ga+ScMn/6k9BHcKL1FSgWk=; 
 b=JSbNmJXkvwvrwve8EIvkO+bMnu9/dsU8iEf9X7TYVovRyHQndfyA6NXuzoDtf0+WKH3g0G
 M6Oxq6m7DkU7swStlrWtHriohsnjrl9ibKkaiHjOqrOhTTcExK5G+knffOJbxVAY8oyq8JYf
 Y+E5nT39crtkxxBhHCF6aksXPpvvs=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: FUSE workflow=? (Re: [RESEND1, PATCH 1/2] fuse: convert printk -> pr_*)
Received: from [87.98.221.171] by mandrillapp.com id 0f65b88fe6904c1180c2268c83f27589; Wed, 24 Apr 2019 09:54:46 +0000
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Brian Foster <bfoster@redhat.com>,
        Maxim Patlasov <mpatlasov@parallels.com>,
        Anatol Pomozov <anatol.pomozov@gmail.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Andrew Gallagher <andrewjcg@fb.com>,
        "Anand V . Avati" <avati@redhat.com>,
        Alexey Kuznetsov <kuznet@virtuozzo.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Constantine Shulyupin <const@makelinux.com>,
        Chad Austin <chadaustin@fb.com>,
        Dan Schatzberg <dschatzberg@fb.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        lkml <linux-kernel@vger.kernel.org>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Message-Id: <20190424095437.GA26730@deco.navytux.spb.ru>
References: <CAJfpegt9DRmwKksR0QSA7NzQP_=a=yJybdL9mOP1cw5goGkdgw@mail.gmail.com> <20190424083800.GA11722@deco.navytux.spb.ru> <CAOssrKeowGky6cccH0EKXiJkTwnPAU+as_vish=u4kvU=TQsvg@mail.gmail.com>
In-Reply-To: <CAOssrKeowGky6cccH0EKXiJkTwnPAU+as_vish=u4kvU=TQsvg@mail.gmail.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.0f65b88fe6904c1180c2268c83f27589
X-Mandrill-User: md_31050260
Date:   Wed, 24 Apr 2019 09:54:46 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 10:57:35AM +0200, Miklos Szeredi wrote:
> On Wed, Apr 24, 2019 at 10:38 AM Kirill Smelkov <kirr@nexedi.com> wrote:
> >
> > +torvalds
> >
> > On Tue, Apr 23, 2019 at 04:57:58PM +0200, Miklos Szeredi wrote:
> > > On Wed, Mar 27, 2019 at 10:15 AM Kirill Smelkov <kirr@nexedi.com> wrote:
> > > >
> > > > Functions, like pr_err, are a more modern variant of printing compared to
> > > > printk. They could be used to denoise sources by using needed level in
> > > > the print function name, and by automatically inserting per-driver /
> > > > function / ... print prefix as defined by pr_fmt macro. pr_* are also
> > > > said to be used in Documentation/process/coding-style.rst and more
> > > > recent code - for example overlayfs - uses them instead of printk.
> > > >
> > > > Convert CUSE and FUSE to use the new pr_* functions.
> > > >
> > > > CUSE output stays completely unchanged, while FUSE output is amended a
> > > > bit for "trying to steal weird page" warning - the second line now comes
> > > > also with "fuse:" prefix. I hope it is ok.
> > >
> > > Yep.  Applied, thanks.
> >
> > Miklos, thanks for feedback. Could you please clarify where the patch is
> > applied? Here is what linux/MAINTAINERS says
> >
> >         FUSE: FILESYSTEM IN USERSPACE
> >         M:      Miklos Szeredi <miklos@szeredi.hu>
> >         L:      linux-fsdevel@vger.kernel.org
> >         W:      http://fuse.sourceforge.net/
> >         T:      git git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
> >         S:      Maintained
> >         F:      fs/fuse/
> >         F:      include/uapi/linux/fuse.h
> >         F:      Documentation/filesystems/fuse.txt
> >
> > but git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git was
> > not updated for ~ 2 months. I see other "Applied, thanks" replies from
> > you on linux-fsdevel in recent days and it suggests that patches are
> > indeed applied, but where they are integrated is the question.
> 
> My private patch queue.
> 
> > Linux-next also has no post-5.1 fuse patches at all, so I'm really
> > puzzled about what is going on.
> >
> > Is there any reason not to keep for-next fuse branch publicly available?
> > Or am I missing something?
> 
> I usually push to fuse.git#for-next within a day or two of adding it
> to my queue.

Miklos, first of all thanks a lot for feedback.

I see about fuse.git#for-next. I was checking linux-fsdevel and saw one
patch said to be applied ~ one week ago. That timeframe was bigger than
a private queue for in-house testing that I was imagining, and that's
why I asked.

https://lore.kernel.org/linux-fsdevel/CAJfpegsyuNtS7afL3Wqjx7m2ewPUUih9pznRmxtrsHYOKER2Gw@mail.gmail.com/


> > Could you please also have a look at other posted patches? I'm
> > struggling for months sending them to you and not getting feedback. It
> > is kind of frustrating to work in this mode.
> 
> I see.  I'll try to give more frequent feedback on patches.  The
> reason for not replying is not that I intentionally ignore incoming
> patches, but because I'm working on something else and context
> switching between completely different projects is not easy for me.

I see. I understand about context switching difficulty especially that
it is similarly not easy on my side. However big latency on patches
feedback creates uncertainty e.g. whether a patch will be considered at
all or dropped? If it will be considered there are chances that it will
have to be reworked, and if feedback is e.g. once per cycle (~2.5 months)
the reworked patch will have to wait for another cycle which gets it
close to half a year. And with those latencies it starts to be close to
kill the motivation to do the work at all. (a record example - I once
got first reply after 5 _years_ since posting a patch)

We all have limited resources and I'm not talking about getting feedback
(though that would be appreciated) in the days timeframe. Getting
feedback in one or two weeks should be reasonably though. With more
delay, at least for me, it starts to be on the edge and the patch
considered to be lost. It is very appreciated if you could indeed try to
provide feedback more frequently.

I apologize if maybe my email touched some pain points. I asked because
it was not clear what to do with the patches and my filesystem becomes
completely useless without e.g. precise-cache fix. I was just trying to
find what should be the way for my fuse changes into the kernel.
Thanks a lot, once again, for your feedback.

Kirill
