Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2499DC43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 12:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021F320665
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 12:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfFWMF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 08:05:59 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:40476 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726535AbfFWMF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 08:05:59 -0400
Received: from faui03f.informatik.uni-erlangen.de (faui03f.informatik.uni-erlangen.de [131.188.30.118])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 1FB07241393;
        Sun, 23 Jun 2019 14:05:56 +0200 (CEST)
Received: by faui03f.informatik.uni-erlangen.de (Postfix, from userid 30501)
        id 117BD341CD4; Sun, 23 Jun 2019 14:05:56 +0200 (CEST)
Date:   Sun, 23 Jun 2019 14:05:55 +0200
From:   Thomas Preisner <linux@tpreisner.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Preisner <linux@tpreisner.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: add simple oneshot function tracer
Message-ID: <20190623120555.nka2357agpqovxla@stud.informatik.uni-erlangen.de>
References: <20190529104552.146fa97c@oasis.local.home>
 <20190612212935.4xq6dyua5d5vrrvj@stud.informatik.uni-erlangen.de>
 <20190617201627.647547c7@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617201627.647547c7@gandalf.local.home>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 08:16:27PM -0400, Steven Rostedt wrote:
> On Wed, 12 Jun 2019 23:29:35 +0200
> Thomas Preisner <linux@tpreisner.de> wrote:
> 
> Hi Thomas,
> 
> BTW, what email client do you use, because your replies seem to confuse
> my email client (claws-mail) and it doesn't thread them at all.
> Although they do look fine on mutt (when I view my LKML folder). Looks
> like it doesn't create a "References:" header.
> 
> > On Tue, 11 Jun 2019 17:52:37 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > What do you mean? The function profile has its own file to enable it:
> > > 
> > >  echo 1 > /sys/kernel/tracing/function_profile_enabled
> > >  
> > >  And disable it:
> > >  
> > >   echo 0 > /sys/kernel/tracing/function_profile_enabled
> > >   
> > >   -- Steve  
> > 
> > Yes, I am aware of the function profiler providing a file operation for
> > enabling and disabling itself. However, my oneshot profiler as of [PATCH
> > v2] is a separate tracer/profiler without this file operation.
> > 
> > As this oneshot profiler is intended to be used for coverage/usage
> > reports I want it to be able to record functions as soon as possible
> > during bootup. Therefore, I just permanently activated the oneshot
> > profiler since as of now there is no means to activate it or the
> > function profiler via kernel commandline just like the normal tracers.
> > 
> > Still, if you want to I can add the file operation for
> > enabling/disabling this new profiler together with a new kernel
> > commandline argument for this profiler?
> > 
> > Or what would be your prefered way?
> > 
> 
> Hmm, I guess I still need to think about exactly what this is for.
> Perhaps we could add a "oneshot" option to the function tracer, and
> when set it will only trace a function once? Is there a strong reason
> to add a new event type "oneshot_entry"? It may be useful to record the
> parent of the function that triggered the first instance as well.
> 
> I'm still trying to get a grip around exactly what use cases this would
> be good for. Especially when adding new functionality like this.
> 
> -- Steve
> 

I've created this tracer with kernel tailoring in mind since the
tailoring process of e.g. undertaker heavily benefits from a more
precise set of input data.

A "oneshot" option for the function tracer would be a viable
possibility. However, this may add a lot of overhead (performance wise)
in comparison to my current approach? After all, the use case of my
tracer would be some sort of kernel activity monitoring during "normal
usage" in order to get a grasp of (hopefully) all required kernel
functions.

Also, there is no strong reason to add a new event type,
this was just a means of reducing the collected data (which may as well
be omitted since there is no real benefit).

My "oneshot tracer" actually collects and outputs every parent in order
to get a more thorough view on used kernel code. Therefore, I would
suggest to keep this functionality and maybe make it configurable
instead?

Yours sincerely,
Thomas
