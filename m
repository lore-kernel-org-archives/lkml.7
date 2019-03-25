Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1129DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E088D20645
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbfCYUpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:45:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50594 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbfCYUpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:45:49 -0400
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <christian.brauner@canonical.com>)
        id 1h8WTa-0002OI-OO
        for linux-kernel@vger.kernel.org; Mon, 25 Mar 2019 20:45:46 +0000
Received: by mail-wr1-f70.google.com with SMTP id z9so5253570wrn.21
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 13:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZfYWktENAW+kI/Voulf51S1RT5ubuNG6eEsN4U97xkY=;
        b=uVFUaSDDqQt4HzzEGzldMk1QX4mv8Yp4lW92SYHfUHlhq6PraTLCZA4NaXzoj+sAz+
         io43ZdA+rRPpOtMwtlwUv4BeRwLhIUPe2Dz8BuFWMJSpw/USvnBdeJC7B+r/UK8Z0vrQ
         Rh1J0iRc1En1eY49LM1673NYlOKNqTxw/F1zS4Is5HcbEHKS2QcqYDHtqpUiUS2jNV6T
         m9YejzYnTsGu/wOynbsGC2S0UMdHTNHewKkFiJdJP4tGlTWuWa/7F+/EKml1j7xkV59S
         7sCBFufgSZb0E7jBz4xE7lPkpEOJUylZutHxbZhpcjwJ9R3//emNAZtRjkmZXlNK12Y2
         e/Ig==
X-Gm-Message-State: APjAAAXzuPsl61YxXo7UMg2NZQsC5jIIDKD3HegqQok1V98FYTN2aSLy
        odAFtPg3nlS/gic/mgNhSM1ioerlKYJopfJl5MxnWmmaYf5ESCz1b0uBYeCQQPCgtb+77Z1Tq3Q
        VvugGEX5j7uw4Mg+faR7MUmPPEcsJ04LkD8fG2BvEdg==
X-Received: by 2002:adf:f88c:: with SMTP id u12mr15487358wrp.235.1553546746443;
        Mon, 25 Mar 2019 13:45:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzuKRepDQOhbJ2yNfMyFSy3FBawWdvdk3pcRC7FoSlOq7ZowgY9p4ZWzXvNLXF8AL6ZsZN9Jg==
X-Received: by 2002:adf:f88c:: with SMTP id u12mr15487339wrp.235.1553546746123;
        Mon, 25 Mar 2019 13:45:46 -0700 (PDT)
Received: from gmail.com (p200300EA6F14663DB13635B07C8C280A.dip0.t-ipconnect.de. [2003:ea:6f14:663d:b136:35b0:7c8c:280a])
        by smtp.gmail.com with ESMTPSA id v13sm15422602wmj.43.2019.03.25.13.45.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Mar 2019 13:45:45 -0700 (PDT)
From:   Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian@brauner.io>
Date:   Mon, 25 Mar 2019 21:45:44 +0100
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Tirado <mtirado418@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: pidfd design
Message-ID: <20190325204543.rfpy2cbcfnmd5hst@gmail.com>
References: <20190320200702.GA27111@avx2>
 <CAMkWEXPsikD8uvMSxQH=RUx-qPHO1UBtKgXsg=p9hY_bD2u2ow@mail.gmail.com>
 <CAHk-=wgmKZm-fESEiLq_W37sKpqCY89nQkPNfWhvF_CQ1ANgcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgmKZm-fESEiLq_W37sKpqCY89nQkPNfWhvF_CQ1ANgcw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 10:45:29AM -0700, Linus Torvalds wrote:
> On Fri, Mar 22, 2019 at 11:34 AM Michael Tirado <mtirado418@gmail.com> wrote:
> >
> > On Wed, Mar 20, 2019 at 8:08 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > >
> > > pidfd code should be backed out immediately. Forget about /proc.
> >
> > Seems like Torvalds just merges this sort of "stuff" without reading
> > it now, or there's something that auto accepted pull request to RC tree?
> 
> There is no auto-accept.
> 
> But there also didn't seem to be any valid arguments against it, and
> the android people had arguments for it.
> 
> Arguing against it based on "I don't like /proc" is pointless. The
> fact is, /proc is our system interface for a lot of things.
> 
> Arguing against it based on "I worry about the _other_
> non-signal-sending things that could be done with this" is also
> pointless. What other things? The only thing that got merged was the
> signalling.

To back Linus defense up with a glimpse into the future.

We will not be to rely on dirfds from proc to do general process
management. That is even in the commit message for the pidfd_send_signal
syscall, that we intend to decouple this from procfs, i.e. decouple
process management from process metadata reading.
We have an ongoing discussion and what a lot of people agree upon is
that pidfds will be anon inode file descriptors that stash a reference
to struct pid in their private_data member. They can be pollable if ever
need be and they are just conceptually cleaner and way simpler and
mirror what will happen in the new mount api as well.
The idea is to translate these pidfds e.g. via a simple ioctl()
interface that takes a pidfd and gives back - with standard permissions
applied as are today - a corresponding /proc/<pid> fd that can be used
to read metadata of a process (see the suggestion by Andy and Jann [1]).
The advantage is that this means that pidfd_clone() or something similar
can simply return a pidfd and does not need to care about what procfs
the process is supposed to be located in/reference and is in general way
safer.

But there is absolutely nothing wrong with allowing users to use
/proc/<pid> to signal processes. One of the reasons why I did this is
that it is so intuitive to users that non-kernel people have requested
this be possible over and over.
As mentioned in the orignal patchset the future was always to decouple
this from procfs (see the references in there) and this is what the new
pidctl() syscall is for that transparently translates between the
pid-based api and the pidfd-based api.

[1]: https://lore.kernel.org/lkml/CAG48ez3VMjLJBC_F3BxC2sc2s-28NdsrUduR=jX66XH0w2O-Qg@mail.gmail.com/ 

> 
> Now, arguing that signalling should use the open-time credentials
> might make sense, but this isn't read/write. You can't fool some suid
> program to do magic randon system calls for you, and if you can, then
> arguing about pidfd is kind of pointless.
> 
> So the model of using a file descriptor instead of a 'pid' for signal
> handling is actually very unix-like. Maybe that's how pid's should
> have worked to begin with. Remember that whole "everything is a file"
> thing?
> 
> Now, the fact that fork() and clone() return a pid obviously means
> that pidfd isn't the primary model (not to decades of just history),
> but that doesn't make pidfd wrong.
> 
> And namespace issues etc are all also kind of irrelevant. If you open
> random files in /proc and randomly do pidfd_send_signal() on those,
> you get random results. If that worries you, then DON'T DO THAT THEN,
> for chrissake! That's not a sane model to begin with, but it's not the
> usage model for this, so it's another completely specious argument.
> 
> So yes, I thought about the pidfd pull (which was why it happened at
> the very end of the merge window), and I found the arguments against
> it bad.
> 
>                 Linus
