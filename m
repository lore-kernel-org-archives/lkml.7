Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45D7C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3E82083B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfHNQNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 12:13:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43595 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfHNQNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 12:13:55 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1hxvuK-0007OU-J3; Wed, 14 Aug 2019 16:13:52 +0000
Date:   Wed, 14 Aug 2019 18:13:51 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Rich Felker <dalias@libc.org>
Cc:     linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
        oleg@redhat.com, alistair23@gmail.com, ebiederm@xmission.com,
        arnd@arndb.de, torvalds@linux-foundation.org,
        adhemerval.zanella@linaro.org, fweimer@redhat.com,
        palmer@sifive.com, macro@wdc.com, zongbox@gmail.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk, hpa@zytor.com
Subject: Re: [PATCH v3 0/1] waitid: process group enhancement
Message-ID: <20190814161351.4kbphhapeqejkgg7@wittgenstein>
References: <CAKmqyKMJPQAOKn11xepzAwXOd4e9dU0Cyz=A0T-uMEgUp5yJjA@mail.gmail.com>
 <20190814154400.6371-1-christian.brauner@ubuntu.com>
 <20190814155822.GI9017@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190814155822.GI9017@brightrain.aerifal.cx>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 11:58:22AM -0400, Rich Felker wrote:
> On Wed, Aug 14, 2019 at 05:43:59PM +0200, Christian Brauner wrote:
> > Hey everyone,
> > 
> > This patch adds support for waiting on the current process group by
> > specifying waitid(P_PGID, 0, ...) as discussed in [1]. The details why
> > we need to do this are in the commit message of [PATCH 1/1] so I won't
> > repeat them here.
> > 
> > I've picked this up since the thread has gone stale and parts of
> > userspace are actually blocked by this.
> > 
> > Note that the patch has been changed to be more closely aligned with the
> > P_PIDFD changes to waitid() I have sitting in my for-next branch (cf. [2]).
> > This makes the merge conflict a little simpler and picks up on the
> > coding style discussions that guided the P_PIDFD patchset.
> > 
> > There was some desire to get this feature in with 5.3 (cf. [3]).
> > But given that this is a new feature for waitid() and for the sake of
> > avoiding any merge conflicts I would prefer to land this in the 5.4
> > merge window together with the P_PIDFD changes.
> 
> That makes 5.4 (or later, depending on other stuff) the hard minimum
> for RV32 ABI. Is that acceptable? I was under the impression (perhaps
> mistaken) that 5.3 was going to be next LTS series which is why I'd
> like to have the necessary syscalls for a complete working RV32
> userspace in it. If I'm wrong about that please ignore me. :-)

5.3 is not going to be an LTS and we don't do new features after the
merge window is closed anyway. :)

Christian
