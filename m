Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B99CC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D4F20684
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfHLRGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 13:06:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52383 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfHLRGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 13:06:36 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1hxDkk-0004XM-EI; Mon, 12 Aug 2019 17:05:02 +0000
Date:   Mon, 12 Aug 2019 19:05:01 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Adrian Reber <areber@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Jann Horn <jannh@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v5 1/2] fork: extend clone3() to support CLONE_SET_TID
Message-ID: <20190812170500.37xhv6eute6xujcj@wittgenstein>
References: <20190811203327.5385-1-areber@redhat.com>
 <20190812163710.GC31560@redhat.com>
 <20190812165130.d3b5smm45dpxk6m4@wittgenstein>
 <20190812165733.GD31560@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190812165733.GD31560@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 06:57:34PM +0200, Oleg Nesterov wrote:
> On 08/12, Christian Brauner wrote:
> > On Mon, Aug 12, 2019 at 06:37:10PM +0200, Oleg Nesterov wrote:
> > > On 08/11, Adrian Reber wrote:
> > > >
> > > >  include/linux/pid.h        |  2 +-
> > > >  include/linux/sched/task.h |  1 +
> > > >  include/uapi/linux/sched.h |  1 +
> > > >  kernel/fork.c              | 22 ++++++++++++++++++++--
> > > >  kernel/pid.c               | 36 +++++++++++++++++++++++++++++-------
> > > >  5 files changed, 52 insertions(+), 10 deletions(-)
> > > 
> > > Looks good to me...
> > > 
> > > A couple of nits below, but I won't insist, feel free to ignore.
> > > 
> > > > +/*
> > > > + * Different sizes of struct clone_args
> > > > + */
> > > > +#define CLONE3_ARGS_SIZE_V0 64
> > > 
> > > I don't really understand why do we want the "size < CLONE3_ARGS_SIZE_V0"
> > > check in copy_clone_args_from_user(), but I won't argue.
> > 
> > To make sure a user can't give us a garbage sized struct that is smaller
> > than the initial version of the struct.
> 
> But why do we want to detect this case?

I have to admit I don't understand that question. Because it's a garbage
sized struct that we can't do anything with. Why shouldn't we detect
this case?

> 
> And why CLONE3_ARGS_SIZE_V0 is special?

Hm? Because that is the first-well known struct size. In fact this
pattern is also used for perf and sched:

	if (!access_ok(uattr, PERF_ATTR_SIZE_VER0))
		return -EFAULT;
