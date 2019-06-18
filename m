Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D968EC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 00:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C0120861
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 00:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfFRAQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 20:16:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbfFRAQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 20:16:30 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F013920861;
        Tue, 18 Jun 2019 00:16:28 +0000 (UTC)
Date:   Mon, 17 Jun 2019 20:16:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Preisner <linux@tpreisner.de>
Cc:     asdf@asdf.de, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: add simple oneshot function tracer
Message-ID: <20190617201627.647547c7@gandalf.local.home>
In-Reply-To: <20190612212935.4xq6dyua5d5vrrvj@stud.informatik.uni-erlangen.de>
References: <20190529104552.146fa97c@oasis.local.home>
        <20190612212935.4xq6dyua5d5vrrvj@stud.informatik.uni-erlangen.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2019 23:29:35 +0200
Thomas Preisner <linux@tpreisner.de> wrote:

Hi Thomas,

BTW, what email client do you use, because your replies seem to confuse
my email client (claws-mail) and it doesn't thread them at all.
Although they do look fine on mutt (when I view my LKML folder). Looks
like it doesn't create a "References:" header.

> On Tue, 11 Jun 2019 17:52:37 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > What do you mean? The function profile has its own file to enable it:
> > 
> >  echo 1 > /sys/kernel/tracing/function_profile_enabled
> >  
> >  And disable it:
> >  
> >   echo 0 > /sys/kernel/tracing/function_profile_enabled
> >   
> >   -- Steve  
> 
> Yes, I am aware of the function profiler providing a file operation for
> enabling and disabling itself. However, my oneshot profiler as of [PATCH
> v2] is a separate tracer/profiler without this file operation.
> 
> As this oneshot profiler is intended to be used for coverage/usage
> reports I want it to be able to record functions as soon as possible
> during bootup. Therefore, I just permanently activated the oneshot
> profiler since as of now there is no means to activate it or the
> function profiler via kernel commandline just like the normal tracers.
> 
> Still, if you want to I can add the file operation for
> enabling/disabling this new profiler together with a new kernel
> commandline argument for this profiler?
> 
> Or what would be your prefered way?
> 

Hmm, I guess I still need to think about exactly what this is for.
Perhaps we could add a "oneshot" option to the function tracer, and
when set it will only trace a function once? Is there a strong reason
to add a new event type "oneshot_entry"? It may be useful to record the
parent of the function that triggered the first instance as well.

I'm still trying to get a grip around exactly what use cases this would
be good for. Especially when adding new functionality like this.

-- Steve

