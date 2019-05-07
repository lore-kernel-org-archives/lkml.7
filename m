Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B28C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 11:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1179320989
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 11:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557227366;
	bh=lH6zDECW23fQQmezy1wEZakHblsm5N0Cv80tHjWVNCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pVn1TkJz2EY/T2i6oge5T+JKfZICV53foZFZD1Ir4am1jfmj+Zw3KmGMjdEckqNPc
	 0vIPfMBDXNTPc2sjJb1E9ydviAUVJ+h8tJ9ui3lOsx0xhBxc9mP02VBj5a09VA804V
	 s4z8+YaJTglKlH2reeEUwsEAw2ingfjFFJKFrWIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfEGLJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 07:09:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfEGLJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 07:09:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0C2420825;
        Tue,  7 May 2019 11:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557227363;
        bh=lH6zDECW23fQQmezy1wEZakHblsm5N0Cv80tHjWVNCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sOR88QRttf7cjAkI3eaLJvcyuSDmHQ1qjgDydZzWSVyPd9M9JC19/WtjAWBZWLubr
         f+UE6Pt1H11AOiDsTKtWprMz1kZ3IkqTZNIcPGlWUmF6tRAMSgJ9qZUBzgkZWyiER3
         Rk2qbQJj3O1NasgjA5/lculWTtaWpGs1D1JA91xo=
Date:   Tue, 7 May 2019 13:09:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Daniel Colascione <dancol@google.com>,
        Todd Kjos <tkjos@android.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Martijn Coenen <maco@android.com>,
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
        kernel-team <kernel-team@android.com>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
Message-ID: <20190507110921.GA32210@kroah.com>
References: <20190318235052.GA65315@google.com>
 <20190319221415.baov7x6zoz7hvsno@brauner.io>
 <CAKOZuessqcjrZ4rfGLgrnOhrLnsVYiVJzOj4Aa=o3ZuZ013d0g@mail.gmail.com>
 <20190319231020.tdcttojlbmx57gke@brauner.io>
 <20190320015249.GC129907@google.com>
 <20190507021622.GA27300@sultan-box.localdomain>
 <20190507070430.GA24150@kroah.com>
 <20190507072721.GA4364@sultan-box.localdomain>
 <20190507074334.GB26478@kroah.com>
 <20190507081236.GA1531@sultan-box.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507081236.GA1531@sultan-box.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 01:12:36AM -0700, Sultan Alsawaf wrote:
> On Tue, May 07, 2019 at 09:43:34AM +0200, Greg Kroah-Hartman wrote:
> > Given that any "new" android device that gets shipped "soon" should be
> > using 4.9.y or newer, is this a real issue?
> 
> It's certainly a real issue for those who can't buy brand new Android devices
> without software bugs every six months :)

Heh.

But, your "new code" isn't going to be going into any existing device,
or any device that will come out this year.  The soonest it would be
would be next year, and by then, 4.9.y is fine.

> > And if it is, I'm sure that asking for those patches to be backported to
> > 4.4.y would be just fine, have you asked?
> >
> > Note that I know of Android Go devices, running 3.18.y kernels, do NOT
> > use the in-kernel memory killer, but instead use the userspace solution
> > today.  So trying to get another in-kernel memory killer solution added
> > anywhere seems quite odd.
> 
> It's even more odd that although a userspace solution is touted as the proper
> way to go on LKML, almost no Android OEMs are using it, and even in that commit
> I linked in the previous message, Google made a rather large set of
> modifications to the supposedly-defunct lowmemorykiller.c not one month ago.
> What's going on?

"almost no"?  Again, Android Go is doing that, right?

And yes, there is still some 4.4 android-common work happening in this
area, see this patch that just got merged:
	https://android-review.googlesource.com/c/kernel/common/+/953354

So, for 4.4.y based devices, that should be enough, right?

> Qualcomm still uses lowmemorykiller.c [1] on the Snapdragon 845.

Qualcomm should never be used as an example of a company that has any
idea of what to do in their kernel :)

> If PSI were backported to 4.4, or even 3.18, would it really be used?

Why wouldn't it, if it worked properly?

> I don't really understand the aversion to an in-kernel memory killer
> on LKML despite the rest of the industry's attraction to it. Perhaps
> there's some inherently great cost in using the userspace solution
> that I'm unaware of?

Please see the work that went into PSI and the patches around it.
There's also a lwn.net article last week about the further work ongoing
in this area.  With all of that, you should see how in-kernel memory
killers are NOT the way to go.

> Regardless, even if PSI were backported, a full-fledged LMKD using it has yet to
> be made, so it wouldn't be of much use now.

"LMKD"?  Again, PSI is in the 4.9.y android-common tree, so the
userspace side should be in AOSP, right?

thanks,

greg k-h
