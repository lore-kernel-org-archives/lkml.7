Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD620C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 00:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A773421842
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 00:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563325062;
	bh=DqU6d2fKuo9qxkH/mhTsMamm0zYIlWQoFOgjYFyD5gc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=0+LSRoi60HEc3plcdgwpaOlSEVFhDz5RF2be/Ldc6R3+HjmPadHBwTqFO9DV0bV/X
	 8+fdWPsgfcPvs+rouGlt7fY10gnwIv3Xa+UyUzvnIjH2lHn4Mk84fxV5Po6pr8xTNz
	 5gUsSt5w9H77r0xGlRsHdyoCkycQLT1M+MmDptow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388847AbfGQA5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 20:57:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727956AbfGQA5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 20:57:40 -0400
Received: from devnote2 (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C88720818;
        Wed, 17 Jul 2019 00:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563325059;
        bh=DqU6d2fKuo9qxkH/mhTsMamm0zYIlWQoFOgjYFyD5gc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=stHDcLu7UD9XoRbmYX3Ve16eIRWrb4LDq8g38+ydo9jKrGC52IkosJYrfBSVjK19n
         WbRxMJj2qHNSdRCg3rxYqQHzxCry9l/UvJsicYK+0IupJcl34GJTN9ch/Cv7k5TXmA
         /dNI6SeD08BcTis4HyAcqkkh05HvUZSTD0y2O1Qk=
Date:   Wed, 17 Jul 2019 09:57:36 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 00/11] tracing: of: Boot time tracing using
 devicetree
Message-Id: <20190717095736.c53f0368034a11332346d18e@kernel.org>
In-Reply-To: <c01bd567-0c8b-ec32-773b-fb95bfcdcd50@gmail.com>
References: <156113387975.28344.16009584175308192243.stgit@devnote2>
        <f0cee7b6-b83b-b74c-82f5-f43e39bd391a@gmail.com>
        <20190624115223.db1e53549a15c6548bfa1fa1@kernel.org>
        <e5e3f55b-095b-e6fc-8734-d888ba5c87f3@gmail.com>
        <20190625140004.a74443238596b297a558a66f@kernel.org>
        <c01bd567-0c8b-ec32-773b-fb95bfcdcd50@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

On Mon, 15 Jul 2019 06:55:40 -0700
Frank Rowand <frowand.list@gmail.com> wrote:

> > Hmm, it's a kind of communication with the operator of the boot loader, since there
> > is an admin or developer behind it. I think the comminication is to communicate
> > with that human. Then if they intend to trace boot process, that is a kind of
> > communication.
> 
> The quote from the plumbers 2016 devicetree etherpad ("Operating points are OK ...)
> conveniently ignores a sentence just a few lines later:
> 
>    "If firmware is deciding the operating point, then it's OK to convey it via DT."
> 
> The operating points example is clearly communicating boot loader information to
> the kernel.
> 
> Something the admin or developer wants to communicate is not boot loader
> information.

But the cmdline (bootargs) is already supported, I think this is a kind of bootargs.

> > [...]
> >>>>> - Can we use devicetree for configuring kernel dynamically?
> >>>>
> >>>> No.  Sorry.
> >>>>
> >>>> My understanding of this proposal is that it is intended to better
> >>>> support boot time kernel and driver debugging.  As an alternate
> >>>> implementation, could you compile the ftrace configuration information
> >>>> directly into a kernel data structure?  It seems like it would not be
> >>>> very difficult to populate the data structure data via a few macros.
> >>>
> >>> No, that is not what I intended. My intention was to trace boot up
> >>> process "without recompiling kernel", but with a structured data.
> >>
> >> That is debugging.  Or if you want to be pedantic, a complex performance
> >> measurement of the boot process (more than holding a stopwatch in your
> >> hand).
> > 
> > Yeah, that's right.
> > 
> >> Recompiling a single object file (containing the ftrace command data)
> >> and re-linking the kernel is not a big price in that context).
> > 
> > No, if I can use DT, I can choose one of them while boot up.
> > That will be a big difference.
> > (Of course for that purpose, I should work on boot loader to support
> > DT overlay)
> 
> This is debugging kernel drivers.  I do not think that it is a big cost for
> a kernel developer to re-link the kernel.  On any reasonable modern
> development system this should be a matter of seconds, not minutes.

Tracing is not only debugging the kernel drivers, but also measures
performance or behavior and compare with different settings.
Also, in some case, we can not change the binary, like distro kernel.

> Compiling a devicetree source is not significantly less time.  (To be
> fair, you imply that you would have various compiled devicetrees to
> choose from at boot time.  It may be realistic to have a library of
> ftrace commands, or it may be more realistic that someone debugging
> a kernel driver will create a unique ftrace command set for the
> particular case they are debugging.)

Yeah, devicetree build time may not be matter, decoupling from the
kernel image is, I think, the key point.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
