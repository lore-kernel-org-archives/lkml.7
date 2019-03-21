Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A79CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431322083D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="tjD8FB2g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbfCUMlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 08:41:25 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34809 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbfCUMlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 08:41:25 -0400
Received: by mail-qt1-f195.google.com with SMTP id k2so6390055qtm.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 05:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M+h1cHoFlrmclSy5GPqKbjxSykhl/ziO9FemlW4hE48=;
        b=tjD8FB2gpvOh0zvxruCXtb1SuTZ2u7+J375pGAJPOx6ryirIxBAuiof8btu2fH2rYP
         np4EYIrfBWebWiBwFe030djHb7AyjH/lrxmXJIdvGTIckP7q4U9z8Vf0+whtfjuKllEB
         XPrdz4ssiNGAb0yC8s9stN8v2+0v+1kDWhUVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M+h1cHoFlrmclSy5GPqKbjxSykhl/ziO9FemlW4hE48=;
        b=VXSDn51o+wfoowOkoh5kCGu6SGanLUkcAvuARm3aNFiiaQQPvGdIeYXc9Kh2MsaeOB
         Hm9GdPretkmeW/uEEFLGftQ714IzQVeO2aA2ASBQ1k7nGGfHqG9mNIvQRVaSITGWTmUy
         62MCrR53FHOlqsovtlxsACDVagus7msf2QiATNEE2xCc7vCqHyq1WWH2O3kymIg7bo7w
         W+yQgs4o9ED2+fi304up7QPSRuo6rspthcL2nhr2PAMWJKZ6BYTwRIz5NZw2WA4TiZcs
         wu2aDKkFDNueSGl0ofd38qB/621BRGNiDNyfef8AcrdSTvG/A7FJIogsx4kjgvAX0VqD
         BLnQ==
X-Gm-Message-State: APjAAAWQ+18+2jJi2tg5AGvEKvk2GxUtB7cGGHJGSBkLB6WzQZaAK3D/
        sl786xE3+vQkArqIml/Dct4a3oyXEUM=
X-Google-Smtp-Source: APXvYqwOXDGWncUQDEOx9myYmhDlSMe67RSZh5pkjzt/Ujp+lNmhaCcelqPZag1tmGXgdo0LYffqtA==
X-Received: by 2002:ac8:148b:: with SMTP id l11mr2652739qtj.290.1553172084309;
        Thu, 21 Mar 2019 05:41:24 -0700 (PDT)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id m6sm2897616qkc.55.2019.03.21.05.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 05:41:22 -0700 (PDT)
Date:   Thu, 21 Mar 2019 08:41:22 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     diamon-discuss@lists.linuxfoundation.org,
        lttng-dev <lttng-dev@lists.lttng.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, rostedt@goodmis.org
Subject: Re: [diamon-discuss] [RELEASE] LTTng-modules 2.9.11, 2.10.8,
 2.11.0-rc2 (Linux kernel tracer)
Message-ID: <20190321124122.GA30542@google.com>
References: <60988959.4070.1541112982406.JavaMail.zimbra@efficios.com>
 <CAJWu+ooEbjOXgVeq+g4MGEve9PTo7p7UUKjYYHhq-Wz6UbUhfg@mail.gmail.com>
 <1199524058.2398.1553016874435.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1199524058.2398.1553016874435.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 01:34:34PM -0400, Mathieu Desnoyers wrote:
> ----- On Nov 1, 2018, at 7:33 PM, Joel Fernandes via diamon-discuss diamon-discuss@lists.linuxfoundation.org wrote:
> 
> > On Thu, Nov 1, 2018 at 3:56 PM Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> >>
> >> Hi,
> >>
> >> This is a set of bugfix releases of the LTTng modules kernel tracer.
> >> It covers the three currently active lttng-modules branches: the
> >> 2.9 and 2.10 stable branches, as well as the 2.11 branch in release
> >> candidate cycle.
> >>
> >> Those releases add support for kernel 4.19.
> >>
> >> One important improvement is to prevent allocation of buffers larger
> >> than the available memory, which can cause the OOM killer to trigger.
> >> Even if the OOM killer end up having to trigger, the current OOM kill
> >> target is set to the current thread while allocating buffers.
> > 
> > This is interesting. Me and Steve were looking at exactly this issue
> > with the ftrace ring buffer a few months ago. Turns out that even
> > setting the OOM kill target may not be enough to prevent all OOMs. I
> > don't remember the reason why not, I'll have to dig out those threads
> > but that's what the -mm folks said at the time. I did remember vaguely
> > that I tested it and the kill target doesn't always get killed.. its
> > possible that something *other* parallel allocation can be victimized
> > AFAIR, even though the culprit is the kill target.
> > 
> 
> Hi Joel,
> 
> Sorry for the late reply. Thanks for your input!

No problem, thanks for the reply :)

> Here is a description of the solution we implemented:
> 
> "   Get an estimate of the number of available pages and return ENOMEM if
>     there are not enough pages to cover the needs of the caller. Also, mark
>     the calling user thread as the first target for the OOM killer in case
>     the estimate of available pages was wrong.
>     
>     This greatly reduces the attack surface of this issue as well as reducing
>     its potential impact.
>     
>     This approach is inspired by the one taken by the Linux kernel
>     trace ring buffer[1]."
> 
> This is implemented in commit 1f0ab1eb040 "Prevent allocation of buffers if exceeding available memory"
> within lttng-modules.
> 
> Are you aware of another way to achieve this that would prevent the incorrect
> OOM victimization scenario you describe above ?

Adding Steve as well.

As far as I can see, lttng does exactly the same thing ftrace does, however
ftrace also does allocations with __GFP_RETRY_MAYFAIL. I think you want to do
that too. That will prevent the ring buffer allocation from being the source
of the OOM trigger. However, if OOM is triggered due to parallel allocations
from other sources, then the ring-buffer allocation will still be killed even
though it is not the only source of the large allocation.  That is the best
we came up with.

Also does it also make sense for lttng ring buffer to use the ftrace code for
ring buffer, or make the ftrace ring buffer better and have lttng use it? Or
is the lttng ring buffer design too radically different?

thanks,

 - Joel

