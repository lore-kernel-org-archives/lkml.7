Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DATE_IN_PAST_03_06,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B9FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA5A20645
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mY/PhDgP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbfCYUom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:44:42 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36581 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729761AbfCYUom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:44:42 -0400
Received: by mail-ot1-f66.google.com with SMTP id o74so9399798ota.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 13:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JeZojxslx7gvup/G5yckHSix5U36utO7nTs9ax9VodI=;
        b=mY/PhDgPNeo69+cgQ+SxHL8hqOHdD5JS+j5ZcjjNM33PjE5YCNKxzX80VaVRmDZyy6
         RCcBy8QRgCEaOcSpuFvKMYfXqSitscWDi45PbOsSLSPSvPi7SZAIsu4Uh/o9/cqhgQ5e
         F7iVaZV90D7ci7ln+sMWFpH6wsI0GtHzbDveadizJLlEvzgZkIQQduy4ZmSCtafoNEP9
         M3ZQ9d3MTLYAQ0ztxgMs2PvuOeLILUbsoKFdH10yTWle/REXaf9/2eARUm7XtnfHf2GW
         IdTNmaq8Og5C+UzEJ9N/WvWWk4Nh4WmUOcpmOi1deJG5U0t2cV65BmBdKxTiyD8e7paC
         GXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JeZojxslx7gvup/G5yckHSix5U36utO7nTs9ax9VodI=;
        b=qafiGtwX6H7iEDhjoE262iFp891Y3FViXXPPng7YLH3S3CZpWzWPIHudLH7Tt2ZhQ4
         i+WF/qo8sypPfWT8cUTXm70Grc4Ef6704t6IKmGIy2vSbphuCOaqb7jZoIZ2jd1f/j9I
         vcB7tlwdlkRWOdPT592FTJkFZE/jxs0FsD7cPni+TAnkolSlejMvGXhqBaj2uWkKsANP
         TOrcsU65+f36LLgYnz9AI2NdsOEJUQff7G5a45FmDHadGMhab0xx8gRHRR7mZ2++eDQ/
         R+9QudRzxZuVvHRzyfX3+OWkpl437CO4etKUAI85q+R2ajEA3jJbKgyDsrVjlKJ62yUJ
         +VwA==
X-Gm-Message-State: APjAAAXsxKC431Kgy1PXpssMekPsg8xP2YDoggWXxrU9sUbEpJIB9PIk
        eHFA8kh29E1ts9MecLi330kstcGMQ3GQ49vsfeg=
X-Google-Smtp-Source: APXvYqzibX7yCJ3JCBY0Do74Wlr5R65ke5Q/4ifVaWA+DJgUsSt0tLITL0kX69F18/a1HXT0CM0WxzutmKJ1m7ILY5U=
X-Received: by 2002:a9d:7dd6:: with SMTP id k22mr19175741otn.31.1553546681477;
 Mon, 25 Mar 2019 13:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190320200702.GA27111@avx2> <CAMkWEXPsikD8uvMSxQH=RUx-qPHO1UBtKgXsg=p9hY_bD2u2ow@mail.gmail.com>
 <CAHk-=wgmKZm-fESEiLq_W37sKpqCY89nQkPNfWhvF_CQ1ANgcw@mail.gmail.com>
In-Reply-To: <CAHk-=wgmKZm-fESEiLq_W37sKpqCY89nQkPNfWhvF_CQ1ANgcw@mail.gmail.com>
From:   Michael Tirado <mtirado418@gmail.com>
Date:   Mon, 25 Mar 2019 16:14:56 +0000
Message-ID: <CAMkWEXO38Yfeuc9ZO6ibJVc=3HuTyK8kfT_6-Ajr_Mq2gROuTQ@mail.gmail.com>
Subject: Re: pidfd design
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>, christian@brauner.io
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 5:45 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
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

Isn't Google working on their own C++ kernel now, I bet they would want
to make a smooth transition to that at some point? Hopefully they don't
screw up Linux in the process.


> Arguing against it based on "I don't like /proc" is pointless. The
> fact is, /proc is our system interface for a lot of things.
>

The argument was valid to me, at least the design is not set in
stone just yet and there is still hope. I have an option in my
namespace sandbox called "noproc", it works for many things, but
if devs start relying on /proc ALWAYS being available I begin to
have issues. You are all aware of the horrors of /proc, I hope.
I don't want /proc so deeply entrenched in the ecosystem that I
can no longer use "noproc". These sort of bold new core features
need to be designed with extreme caution and awareness of the full
spectra of affects. Just because something like procfs exists and
can be used doesn't mean it is wise to go all-in.


> Arguing against it based on "I worry about the _other_
> non-signal-sending things that could be done with this" is also
> pointless. What other things? The only thing that got merged was the
> signalling.
>

There have been "future changes" hinted through the patches lifecycle,
it leads me to believe it's a gateway patch, and the pid wrapping is a
minor bugfix bridge to some other undisclosed features. How could anyone
know the design is right without knowing what these changes might be?

pidctl/translate_pid?
I am against any new systemcall that crosses namespaces by design to
accomplish something that is already plummable. Seems like they want
to use pidfd's as some sort of token to perform these cross namespace
operations, can't wait to see how devs end up abusing this one.


> So the model of using a file descriptor instead of a 'pid' for signal
> handling is actually very unix-like. Maybe that's how pid's should
> have worked to begin with. Remember that whole "everything is a file"
> thing?
>

Perhaps it could be called an improvement if yall get it right because
AFAIK the only way to handle wrapping today is to directly clone the PID
you're worried about and deal with it immediately when the process exits
before wrap can happen. But I really wonder why PID wrapping matters SO
much, I bet some people are doing dangerously stupid things like using
PID as a credential even though everyone knows it wraps.

Maybe this can make signalling less racey somehow?
At the very least you could learn the process has exited instead of
blindly acting on a potentially recycled number. I recognize the value
in that specifically.
However, using pidfd as a token to do cross-namespace activities that
are already plummable is just plain weird to me, but maybe I'm too used
to doing things "the hard way".
