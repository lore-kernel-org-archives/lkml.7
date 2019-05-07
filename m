Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43997C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 07:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1321721479
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 07:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557215019;
	bh=MFdZ/EgpyfY0kwMJXZf/qyVBEWcoQTA3dkpraEXQxMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rqsOdysynx1auBw8nVZUjNd+SWr4tt2P4i5RXXy5gUdlwwDVPs8k/MTDjITPO7nsD
	 ghl4HyFdoRkZT5R8A/wAkaC5xn8Z4sCtHaEwA0Gz8ah64xIwAi+d+cDgo1JdaCvuVi
	 iW3ZUx7JcIxQbe1ZwNIaTu3oqrxjauV6qPBC2si8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfEGHni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 03:43:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfEGHnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 03:43:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B243120989;
        Tue,  7 May 2019 07:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557215017;
        bh=MFdZ/EgpyfY0kwMJXZf/qyVBEWcoQTA3dkpraEXQxMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2MVgXQNq38tiYvMcy6xa99VJq5jg23ZnqHpAEu4onk5dmCkIOFH9x1lLwuj6OOiJ2
         sewqDcBYKlyNG65ez+rwXLx6PYzSMdFiHCNVzxgbw++r7k2T6KOScNLiActm7KzU+m
         xAvWpbDF7QlCx3RNDlId5RsJEh+Nfm1FJlhwRxwU=
Date:   Tue, 7 May 2019 09:43:34 +0200
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
Message-ID: <20190507074334.GB26478@kroah.com>
References: <CAKOZuetZPhqQqSgZpyY0cLgy0jroLJRx-B93rkQzcOByL8ih_Q@mail.gmail.com>
 <20190318002949.mqknisgt7cmjmt7n@brauner.io>
 <20190318235052.GA65315@google.com>
 <20190319221415.baov7x6zoz7hvsno@brauner.io>
 <CAKOZuessqcjrZ4rfGLgrnOhrLnsVYiVJzOj4Aa=o3ZuZ013d0g@mail.gmail.com>
 <20190319231020.tdcttojlbmx57gke@brauner.io>
 <20190320015249.GC129907@google.com>
 <20190507021622.GA27300@sultan-box.localdomain>
 <20190507070430.GA24150@kroah.com>
 <20190507072721.GA4364@sultan-box.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507072721.GA4364@sultan-box.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 12:27:21AM -0700, Sultan Alsawaf wrote:
> On Tue, May 07, 2019 at 09:04:30AM +0200, Greg Kroah-Hartman wrote:
> > Um, why can't "all" Android devices take the same patches that the Pixel
> > phones are using today?  They should all be in the public android-common
> > kernel repositories that all Android devices should be syncing with on a
> > weekly/monthly basis anyway, right?
> > 
> > thanks,
> > 
> > greg k-h
> 
> Hi Greg,
> 
> I only see PSI present in the android-common kernels for 4.9 and above. The vast
> majority of Android devices do not run a 4.9+ kernel. It seems unreasonable to
> expect OEMs to toil with backporting PSI themselves to get decent memory
> management.

Given that any "new" android device that gets shipped "soon" should be
using 4.9.y or newer, is this a real issue?

And if it is, I'm sure that asking for those patches to be backported to
4.4.y would be just fine, have you asked?

Note that I know of Android Go devices, running 3.18.y kernels, do NOT
use the in-kernel memory killer, but instead use the userspace solution
today.  So trying to get another in-kernel memory killer solution added
anywhere seems quite odd.

thanks,

greg k-h
