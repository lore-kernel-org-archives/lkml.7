Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E65C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22BF92063F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbfHNQzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 12:55:18 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:47288 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbfHNQzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 12:55:18 -0400
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1hxwY9-0005gO-00; Wed, 14 Aug 2019 16:55:01 +0000
Date:   Wed, 14 Aug 2019 12:55:01 -0400
From:   Rich Felker <dalias@libc.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        libc-alpha@sourceware.org, alistair23@gmail.com,
        ebiederm@xmission.com, arnd@arndb.de,
        torvalds@linux-foundation.org, adhemerval.zanella@linaro.org,
        fweimer@redhat.com, palmer@sifive.com, macro@wdc.com,
        zongbox@gmail.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, hpa@zytor.com
Subject: Re: [PATCH v3 1/1] waitid: Add support for waiting for the current
 process group
Message-ID: <20190814165501.GJ9017@brightrain.aerifal.cx>
References: <CAKmqyKMJPQAOKn11xepzAwXOd4e9dU0Cyz=A0T-uMEgUp5yJjA@mail.gmail.com>
 <20190814154400.6371-1-christian.brauner@ubuntu.com>
 <20190814154400.6371-2-christian.brauner@ubuntu.com>
 <20190814160917.GG11595@redhat.com>
 <20190814161517.ldbn62mulk2pmqo5@wittgenstein>
 <20190814163443.6odsksff4jbta7be@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814163443.6odsksff4jbta7be@wittgenstein>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 06:34:44PM +0200, Christian Brauner wrote:
> On Wed, Aug 14, 2019 at 06:15:17PM +0200, Christian Brauner wrote:
> > On Wed, Aug 14, 2019 at 06:09:17PM +0200, Oleg Nesterov wrote:
> > > On 08/14, Christian Brauner wrote:
> > > >
> > > > and a signal could come in between the system call that
> > > > retrieved the process gorup and the call to waitid that changes the
> > >                         ^^^^^
> > > > current process group.
> > > 
> > > I noticed this typo only because I spent 2 minutes or more trying to
> > > understand this sentence ;) But yes, a signal handler or another thread
> > 
> > I'll try to rewrite it. :)
> 
> Ok, here's what I changed it to:
> 
> It was recently discovered that the linux version of waitid is not a
> superset of the other wait functions because it does not include
> support for waiting for the current process group. This has two
> downsides:
> 1. An extra system call is needed to get the current process group.
> 2. After the current process group is received and before it is passed
>    to waitid a signal could arrive causing the current process group to change.

I don't think "downsides" sufficiently conveys that this is hard
breakage of a requirement for waitpid. How about something like the
following?

"It was recently discovered that the linux version of waitid is not a
superset of the other wait functions because it does not include
support for waiting for the current process group. Userspace cannot
simply emulate this functionality with an additional getpgid syscall
due to inherent race conditions that violate the async-signal safety
requirements for waitpid."

Rich
