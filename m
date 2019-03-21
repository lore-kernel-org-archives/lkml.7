Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0116CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1231218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfCUVOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:14:53 -0400
Received: from avasout02.plus.net ([212.159.14.17]:43420 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfCUVOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 17:14:52 -0400
Received: from deneb ([80.229.24.9])
        by smtp with ESMTP
        id 751Wh0gq72SW5751XhKXdr; Thu, 21 Mar 2019 21:14:51 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=NtavjPVJ c=1 sm=1 tr=0
 a=E/9URZZQ5L3bK/voZ0g0HQ==:117 a=E/9URZZQ5L3bK/voZ0g0HQ==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=NTGMnVQrEZIA:10
 a=pGLkceISAAAA:8 a=-An2I_7KAAAA:8 a=CCpqsmhAAAAA:8 a=VwQbUJbxAAAA:8
 a=Dj15SF_IVgmvfMQSUbwA:9 a=CjuIK1q_8ugA:10 a=Sq34B_EcNBM9_nrAYB9S:22
 a=ul9cdbp4aOFLsgKbc677:22 a=AjGcO6oz07-iQ99wixmX:22
Received: from mac by deneb with local (Exim 4.89)
        (envelope-from <mac@mcrowe.com>)
        id 1h751W-0003m7-2n; Thu, 21 Mar 2019 21:14:50 +0000
Date:   Thu, 21 Mar 2019 21:14:50 +0000
From:   Mike Crowe <mac@mcrowe.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kay Sievers <kay@vrfy.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: kmsg: lseek errors confuse glibc's dprintf
Message-ID: <20190321211450.v5kmh35ql2fv2cfj@mcrowe.com>
References: <20150115173132.GA7486@mcrowe.com>
 <20190321104726.3c570c41e5757611a13c23ca@gmail.com>
 <CAK8P3a1gkG6U3zCytY2Ax-DQvExXqG8Z6eGde4W6D7JLa=YwGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1gkG6U3zCytY2Ax-DQvExXqG8Z6eGde4W6D7JLa=YwGg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CMAE-Envelope: MS4wfCkQnjk+EAGqgnuSaV3zLbviblrZDcS/ZOav2a5euEJxdih5SQ3blQqVf1Ty5kgfzP3L0Yr8W3P3fwxcqvo6IPmNMXnXVwVLfW7lC04qS35aGPYYBvmB
 yOkzBTSFdkuVODzDN7aq/uoMcy+ppLnJjDReNl7Tn0L51to1fiLK65T4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 March 2019 at 11:33:33 +0100, Arnd Bergmann wrote:
> On Thu, Mar 21, 2019 at 10:47 AM Alexander Sverdlin
> <alexander.sverdlin@gmail.com> wrote:
> >
> > Hello Mike and all,
> >
> > On Thu, 15 Jan 2015 17:31:32 +0000
> > Mike Crowe <mac@mcrowe.com> wrote:
> >
> > > glibc's dprintf implementation does not work correctly with /dev/kmsg file
> > > descriptors because glibc treats receiving EBADF and EINVAL from lseek when
> > > trying to determine the current file position as errors. See
> > > https://sourceware.org/bugzilla/show_bug.cgi?id=17830
> >
> > we need to conclude on this issue. This is a real bug which is ignored
> > for 4 years now. Mike, would you like to re-send a formal patch?
> > I can do it as well, preserving a link to your original patch/report.
> > In case you'd like to post it yourself, I can be a tester and/or
> > provide a reproducer.
> 
> The patch needs to be rebased because of the changed file
> location. I would also suggest adding a "Cc: stable@kernel.org"
> tag so it will get backported into stable kernels.
> 
> > > >>From what I can tell prior to Kay Sievers printk record commit
> > > e11fea92e13fb91c50bacca799a6131c81929986, calling lseek(fd, 0, SEEK_CUR)
> > > with such a file descriptor would not return an error.
> > >
> > > Prior to Kay's change, Arnd Bergmann's commit
> > > 6038f373a3dc1f1c26496e60b6c40b164716f07e seemed to go to some lengths to
> > > preserve the successful return code rather than returning (the perhaps more
> > > logical) -ESPIPE.
> > >
> > > glibc is happy with either a successful return or -ESPIPE.
> > >
> > > For maximum compatibility it seems that success should be returned but
> > > given Kay's new seek interface perhaps this isn't helpful.
> > >
> > > This patch ensures that such a seek succeeds:
> > >
> > > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > > index 02d6b6d..b3ff6f0 100644
> > > --- a/kernel/printk/printk.c
> > > +++ b/kernel/printk/printk.c
> > > @@ -693,7 +693,7 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
> > >       loff_t ret = 0;
> > >
> > >       if (!user)
> > > -             return -EBADF;
> > > +             return (whence == SEEK_CUR) ? 0 : -EBADF;
> > >       if (offset)
> > >               return -ESPIPE;
> > >
> > > @@ -718,6 +718,11 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
> > >               user->idx = log_next_idx;
> > >               user->seq = log_next_seq;
> > >               break;
> > > +     case SEEK_CUR:
> > > +             /* For compatibility with userspace requesting the
> > > +              * current file position. */
> > > +             ret = 0;
> > > +             break;
> > >       default:
> > >               ret = -EINVAL;
> > >       }
> > >
> > > (although it could be argued that the !user case should return -ESPIPE
> > > rather than EBADF since the file descriptor _is_ valid.)
> 
> I don't think the !user case can ever be hit, I would just leave that
> to return -BADF and not touch it.

I originally wrote the patch for linux-3.8(!) and back then a write-only
kmsg instance had no private data. It looks like this changed with
750afe7babd117daabebf4855da18e4418ea845e in v4.8, so user should now always
be valid.

> > > @@ -718,6 +718,11 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
> > >               user->idx = log_next_idx;
> > >               user->seq = log_next_seq;
> > >               break;
> > > +     case SEEK_CUR:
> > > +             /* For compatibility with userspace expecting SEEK_CUR
> > > +              * to not yield EINVAL. */
> > > +             ret = -ESPIPE;
> > > +             break;
> > >       default:
> > >               ret = -EINVAL;
> > >       }
> > >
> > > Either makes dprintf work, but is either the right solution?
> 
> I'd vote for -ESPIPE, for consistency with the offset!=0 case, but
> etiher one is fine with me here.

It seems that this is the version we've successfully been running in our
kernel since then, so that's good.

Thanks.

Mike.
