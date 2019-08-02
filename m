Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73954C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 11:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50476206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 11:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392118AbfHBLC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 07:02:29 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:35463 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729311AbfHBLC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 07:02:28 -0400
Received: from cpe-2606-a000-111b-6140-0-0-0-162e.dyn6.twc.com ([2606:a000:111b:6140::162e] helo=localhost)
        by smtp.tuxdriver.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.63)
        (envelope-from <nhorman@tuxdriver.com>)
        id 1htVJ9-0008J6-Js; Fri, 02 Aug 2019 07:01:19 -0400
Date:   Fri, 2 Aug 2019 07:00:42 -0400
From:   Neil Horman <nhorman@tuxdriver.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joe Perches <joe@perches.com>, Pavel Machek <pavel@ucw.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] compiler_attributes.h: Add 'fallthrough' pseudo
 keyword for switch/case use
Message-ID: <20190802110042.GA6957@hmswarspite.think-freely.org>
References: <20190731171429.GA24222@amd>
 <ccc7fa72d0f83ddd62067092b105bd801479004b.camel@perches.com>
 <765E740C-4259-4835-A58D-432006628BAC@zytor.com>
 <20190731184832.GZ31381@hirez.programming.kicks-ass.net>
 <F1AB2846-CA91-41ED-B8E7-3799895DCF06@zytor.com>
 <CANiq72=s1nu9=R9ypFwL+J4NGT_yUkwahpgOOOXzezvNfDrx5g@mail.gmail.com>
 <F2529DE6-B500-44DC-AE72-45A304AD719B@zytor.com>
 <20190801122429.GY31398@hirez.programming.kicks-ass.net>
 <0BCDEED9-0B72-4412-909F-76C20D54983E@zytor.com>
 <CANiq72kg+duBe_srpcco-P17=3OC2c1ys=rGMVY8Z9FxZ69sdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72kg+duBe_srpcco-P17=3OC2c1ys=rGMVY8Z9FxZ69sdw@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 10:26:29PM +0200, Miguel Ojeda wrote:
> On Thu, Aug 1, 2019 at 10:10 PM <hpa@zytor.com> wrote:
> >
> > I'm not disagreeing... I think using a macro makes sense.
> 
> It is either a macro or waiting for 5+ years (while we keep using the
> comment style) :-)
> 
> In case it helps to make one's mind about whether to go for it or not,
> I summarized the advantages and a few other details in the patch I
> sent in October:
> 
>   https://github.com/ojeda/linux/commit/668f011a2706ea555987e263f609a5deba9c7fc4
> 
> It would be nice, however, to discuss whether we want __fallthrough or
> fallthrough. The former is consistent with the rest of compiler
> attributes and makes it clear it is not a keyword, the latter is
> consistent with "break", "goto" and "return", as Joe's patch explains.
> 
I was having this conversation with Joe, and I agree, I like the idea of
macroing up the fall through attribute, but naming it __fallthrough seems more
consistent to me with the other attribute macros.  I also feel like its more
recognizable as a macro.  Naming it fallthrough just makes it look like someone
forgot to put /**/'s around it to me.

Neil

> Cheers,
> Miguel
> 
