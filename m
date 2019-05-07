Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD75C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88FB420825
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557250185;
	bh=0aJ6ctT9vRN+sTWk16Y0kR/0wZNkZvMg4FJNEQtB+p4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AS0NXJZIjtjavKGilLfeq/DzBp0vIPAuMBRyZ/LWAs2LGPWqGpFIZFzrOmRHcIP2S
	 uVdABan00s8y2lMhWFK3WAA9W+Y802+I3PIWkt7yAhNENlSeNPQvTPlebvusIKq3Rl
	 MzvBZabMH8HEPc+mjdsDoGXM6ZYDDqyQFPhzvPDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfEGR3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:29:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:39546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbfEGR3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:29:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDFC9205ED;
        Tue,  7 May 2019 17:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557250183;
        bh=0aJ6ctT9vRN+sTWk16Y0kR/0wZNkZvMg4FJNEQtB+p4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X69pWunFdt3abRor30eAi6ii8e0h5YWRT265TXQ35VyTi3237oX/jgxrmWxHMDzrn
         jWcC3oUU67MGkRXnhy+uK/D0yND+RsTKHyAZqgjvh1anuZd8OMCMwHp6Ew+oHmwYRj
         q6lrXTdH17oLXqhF6mYfNJwdkR7vBAeIWptDiI0o=
Date:   Tue, 7 May 2019 19:29:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Christian Brauner <christian@brauner.io>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Daniel Colascione <dancol@google.com>,
        kernel-team <kernel-team@android.com>,
        Todd Kjos <tkjos@android.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-mm <linux-mm@kvack.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Martijn Coenen <maco@android.com>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
Message-ID: <20190507172940.GA6835@kroah.com>
References: <CAKOZuessqcjrZ4rfGLgrnOhrLnsVYiVJzOj4Aa=o3ZuZ013d0g@mail.gmail.com>
 <20190319231020.tdcttojlbmx57gke@brauner.io>
 <20190320015249.GC129907@google.com>
 <20190507021622.GA27300@sultan-box.localdomain>
 <20190507070430.GA24150@kroah.com>
 <20190507072721.GA4364@sultan-box.localdomain>
 <20190507074334.GB26478@kroah.com>
 <20190507081236.GA1531@sultan-box.localdomain>
 <20190507105826.oi6vah6x5brt257h@brauner.io>
 <20190507171711.GB12201@sultan-box.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507171711.GB12201@sultan-box.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 10:17:11AM -0700, Sultan Alsawaf wrote:
> On Tue, May 07, 2019 at 01:09:21PM +0200, Greg Kroah-Hartman wrote:
> > > It's even more odd that although a userspace solution is touted as the proper
> > > way to go on LKML, almost no Android OEMs are using it, and even in that commit
> > > I linked in the previous message, Google made a rather large set of
> > > modifications to the supposedly-defunct lowmemorykiller.c not one month ago.
> > > What's going on?
> > 
> > "almost no"?  Again, Android Go is doing that, right?
> 
> I'd check for myself, but I can't seem to find kernel source for an Android Go
> device...
> 
> This seems more confusing though. Why would the ultra-low-end devices use LMKD
> while other devices use the broken lowmemorykiller driver?

It's probably because the Android Go devices got a lot more "help" from
people at Google than did the other devices you are looking at.  Also,
despite the older kernel version, they are probably running a newer
version of Android userspace, specially tuned just for lower memory
devices.

So those 3.18.y based Android Go devices are newer than the 4.4.y based
"full Android" devices on the market, and even some 4.9.y based devices.

Yes, it is strange :)

> > > Qualcomm still uses lowmemorykiller.c [1] on the Snapdragon 845.
> > 
> > Qualcomm should never be used as an example of a company that has any
> > idea of what to do in their kernel :)
> 
> Agreed, but nearly all OEMs that use Qualcomm chipsets roll with Qualcomm's
> kernel decisions, so Qualcomm has a bit of influence here.

Yes, because almost no OEM wants to mess with their kernel, they just
take QCOM's kernel and run with it.  But don't take that for some sort
of "best design practice" summary at all.

> > > If PSI were backported to 4.4, or even 3.18, would it really be used?
> > 
> > Why wouldn't it, if it worked properly?
> 
> For the same mysterious reason that Qualcomm and others cling to
> lowmemorykiller, I presume. This is part of what's been confusing me for quite
> some time...

QCOM's 4.4.y based kernel work was done 3-4 years ago, if not older.
They didn't know that this was not the "right way" to do things.  The
Google developers have been working for the past few years to do it
correct, but they can not go back in time to change old repos, sorry.

Now that I understand you just want to work on your local device, that
makes more sense.  But I think you will have a better result trying to
do a 4.4 backport of PSI combined with the userspace stuff, than to try
to worry about your driver in 5.2 or newer.

Or you can forward-port your kernel to 4.9, or better yet, 4.14.  That
would probably be a much better thing to do overall as 4.4 is really old
now.

Good luck!

greg k-h
