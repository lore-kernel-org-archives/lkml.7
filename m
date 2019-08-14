Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C917C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C687208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbfHNRCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:02:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44740 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfHNRCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:02:05 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1hxwew-0001t5-5g; Wed, 14 Aug 2019 17:02:02 +0000
Date:   Wed, 14 Aug 2019 19:02:01 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Rich Felker <dalias@libc.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        libc-alpha@sourceware.org, alistair23@gmail.com,
        ebiederm@xmission.com, arnd@arndb.de,
        torvalds@linux-foundation.org, adhemerval.zanella@linaro.org,
        fweimer@redhat.com, palmer@sifive.com, macro@wdc.com,
        zongbox@gmail.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, hpa@zytor.com
Subject: Re: [PATCH v3 1/1] waitid: Add support for waiting for the current
 process group
Message-ID: <20190814170200.kqkygob7yo5hciau@wittgenstein>
References: <CAKmqyKMJPQAOKn11xepzAwXOd4e9dU0Cyz=A0T-uMEgUp5yJjA@mail.gmail.com>
 <20190814154400.6371-1-christian.brauner@ubuntu.com>
 <20190814154400.6371-2-christian.brauner@ubuntu.com>
 <20190814160917.GG11595@redhat.com>
 <20190814161517.ldbn62mulk2pmqo5@wittgenstein>
 <20190814163443.6odsksff4jbta7be@wittgenstein>
 <20190814165501.GJ9017@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190814165501.GJ9017@brightrain.aerifal.cx>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 12:55:01PM -0400, Rich Felker wrote:
> On Wed, Aug 14, 2019 at 06:34:44PM +0200, Christian Brauner wrote:
> > On Wed, Aug 14, 2019 at 06:15:17PM +0200, Christian Brauner wrote:
> > > On Wed, Aug 14, 2019 at 06:09:17PM +0200, Oleg Nesterov wrote:
> > > > On 08/14, Christian Brauner wrote:
> > > > >
> > > > > and a signal could come in between the system call that
> > > > > retrieved the process gorup and the call to waitid that changes the
> > > >                         ^^^^^
> > > > > current process group.
> > > > 
> > > > I noticed this typo only because I spent 2 minutes or more trying to
> > > > understand this sentence ;) But yes, a signal handler or another thread
> > > 
> > > I'll try to rewrite it. :)
> > 
> > Ok, here's what I changed it to:
> > 
> > It was recently discovered that the linux version of waitid is not a
> > superset of the other wait functions because it does not include
> > support for waiting for the current process group. This has two
> > downsides:
> > 1. An extra system call is needed to get the current process group.
> > 2. After the current process group is received and before it is passed
> >    to waitid a signal could arrive causing the current process group to change.
> 
> I don't think "downsides" sufficiently conveys that this is hard
> breakage of a requirement for waitpid. How about something like the
> following?
> 
> "It was recently discovered that the linux version of waitid is not a
> superset of the other wait functions because it does not include
> support for waiting for the current process group. Userspace cannot
> simply emulate this functionality with an additional getpgid syscall
> due to inherent race conditions that violate the async-signal safety
> requirements for waitpid."

I like the rather specific example in there. How about we add that after
this section like so:

It was recently discovered that the linux version of waitid is not a
superset of the other wait functions because it does not include
support for waiting for the current process group. This has two
downsides:
1. An extra system call is needed to get the current process group.
2. After the current process group is received and before it is passed
   to waitid a signal could arrive causing the current process group to change.

Such inherent race-conditions as mentioned in 2. make it impossible for
userspace to emulate this functionaly and thus violate the async-signal
safety requirements for waitpid.

Christian
