Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAA6C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE76720644
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c2sKfjCE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfH0HYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:24:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52366 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfH0HYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:24:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id o4so1903394wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 00:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UdTlWBq67pFf3BFWbVXOJiSHrcyQJ0PaYrdJV+R7zcU=;
        b=c2sKfjCE0fItXLJHeMv+GFYS7uvSIGQkogDsakG8O19i0NlYaODm94EwmQ50o38LQV
         mA1kQOnvXiyJA1mPxiSFVX4Bv3lBUKvphBE7sdggGArrhBMi9oi0IcaEwxEw1XPhn+b1
         0zFEjRx0AmbyZHeENOesuUaV9+5nCkMBca0RiN6su84zLI7dK5FecyQJg+7tP9T07fzZ
         SC1h37BQEd/JC2HWLiDjeC4CBIt2vM2Wkogf/2ZzHjUZ4Zg3maxR2QnfpyVb+EX6Zv06
         tr8TbSn7OTqoWAk9sgTp2GvblzPAqcudIgCUAtfjHhPouWeNAWyZl61dM0JrV4fjmrmW
         RqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UdTlWBq67pFf3BFWbVXOJiSHrcyQJ0PaYrdJV+R7zcU=;
        b=CbbpoHNUOstskjROCmWRcdJJwpgKTmKwD6Jc8yrvItA87vTzLQWNWno1sLbXlMkX8G
         3P10OIbgaNLRSoUL1IyO0lhHLwdknivvCk1RV/IW9NPqQLh/sOMjhWHc0uAkkDct+YZE
         DacbdVG/cvmxJr5m30at+yvbdzM2LpnwcRnwk7R42ORmhJhVZ1nNfTFEVNDPOLcPlnvT
         yCjNDjzEC+n7VzBALdUOXNDXfNGbjIJ4r6NJ1/ShfFaQjg8/OCJN3OQ/ifz2xCm8crV4
         O5lnOVdlN9BI7isr1PEdfJFpiQXy73NXJFK1HQUo4G/o2K0vnyjxA5nnUNWJSmKa4/ym
         WEzA==
X-Gm-Message-State: APjAAAW7YNp5hShZy6FamRbQIXokGBPbmhp2sCEa0ug+z8lL1c1knWDx
        qWl2bucxiSPczDkL4l57TGG4HQ==
X-Google-Smtp-Source: APXvYqxJhTYivRAhMDNxZV3fC6gk7F90Dm33K2rsokvik6IXJCEnJusIOA+DBItODlwcKjJsf469pg==
X-Received: by 2002:a1c:dd82:: with SMTP id u124mr26802396wmg.89.1566890680428;
        Tue, 27 Aug 2019 00:24:40 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id 16sm2352759wmx.45.2019.08.27.00.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 00:24:39 -0700 (PDT)
Date:   Tue, 27 Aug 2019 08:24:38 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2] kdb: Fix stack crawling on 'running' CPUs that aren't
 the master
Message-ID: <20190827072438.fwgggambxp34onid@holly.lan>
References: <20190731183732.178134-1-dianders@chromium.org>
 <CAD=FV=Wh4M_A01gsWYBXSdgs0Gg4LAGDZ8X+5=4j=nuxiJ8kNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=Wh4M_A01gsWYBXSdgs0Gg4LAGDZ8X+5=4j=nuxiJ8kNA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 03:25:43PM -0700, Doug Anderson wrote:
> Jason / Daniel,
> 
> On Wed, Jul 31, 2019 at 11:38 AM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > In kdb when you do 'btc' (back trace on CPU) it doesn't necessarily
> > give you the right info.  Specifically on many architectures
> > (including arm64, where I tested) you can't dump the stack of a
> > "running" process that isn't the process running on the current CPU.
> > This can be seen by this:
> >
> >  echo SOFTLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT
> >  # wait 2 seconds
> >  <sysrq>g
> >
> > Here's what I see now on rk3399-gru-kevin.  I see the stack crawl for
> > the CPU that handled the sysrq but everything else just shows me stuck
> > in __switch_to() which is bogus:
> >
> > ======
> >
> > [0]kdb> btc
> > btc: cpu status: Currently on cpu 0
> > Available cpus: 0, 1-3(I), 4, 5(I)
> > Stack traceback for pid 0
> > 0xffffff801101a9c0        0        0  1    0   R  0xffffff801101b3b0 *swapper/0
> > Call trace:
> >  dump_backtrace+0x0/0x138
> >  ...
> >  kgdb_compiled_brk_fn+0x34/0x44
> >  ...
> >  sysrq_handle_dbg+0x34/0x5c
> > Stack traceback for pid 0
> > 0xffffffc0f175a040        0        0  1    1   I  0xffffffc0f175aa30  swapper/1
> > Call trace:
> >  __switch_to+0x1e4/0x240
> >  0xffffffc0f65616c0
> > Stack traceback for pid 0
> > 0xffffffc0f175d040        0        0  1    2   I  0xffffffc0f175da30  swapper/2
> > Call trace:
> >  __switch_to+0x1e4/0x240
> >  0xffffffc0f65806c0
> > Stack traceback for pid 0
> > 0xffffffc0f175b040        0        0  1    3   I  0xffffffc0f175ba30  swapper/3
> > Call trace:
> >  __switch_to+0x1e4/0x240
> >  0xffffffc0f659f6c0
> > Stack traceback for pid 1474
> > 0xffffffc0dde8b040     1474      727  1    4   R  0xffffffc0dde8ba30  bash
> > Call trace:
> >  __switch_to+0x1e4/0x240
> >  __schedule+0x464/0x618
> >  0xffffffc0dde8b040
> > Stack traceback for pid 0
> > 0xffffffc0f17b0040        0        0  1    5   I  0xffffffc0f17b0a30  swapper/5
> > Call trace:
> >  __switch_to+0x1e4/0x240
> >  0xffffffc0f65dd6c0
> >
> > ===
> >
> > The problem is that 'btc' eventually boils down to
> >   show_stack(task_struct, NULL);
> >
> > ...and show_stack() doesn't work for "running" CPUs because their
> > registers haven't been stashed.
> >
> > On x86 things might work better (I haven't tested) because kdb has a
> > special case for x86 in kdb_show_stack() where it passes the stack
> > pointer to show_stack().  This wouldn't work on arm64 where the stack
> > crawling function seems needs the "fp" and "pc", not the "sp" which is
> > presumably why arm64's show_stack() function totally ignores the "sp"
> > parameter.
> >
> > NOTE: we _can_ get a good stack dump for all the cpus if we manually
> > switch each one to the kdb master and do a back trace.  AKA:
> >   cpu 4
> >   bt
> > ...will give the expected trace.  That's because now arm64's
> > dump_backtrace will now see that "tsk == current" and go through a
> > different path.
> >
> > In this patch I fix the problems by catching a request to stack crawl
> > a task that's running on a CPU and then I ask that CPU to do the stack
> > crawl.
> >
> > NOTE: this will (presumably) change what stack crawls are printed for
> > x86 machines.  Now kdb functions will show up in the stack crawl.
> > Presumably this is OK but if it's not we can go back and add a special
> > case for x86 again.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Totally new approach; now arch agnostic.
> >
> >  kernel/debug/debug_core.c |  5 +++++
> >  kernel/debug/debug_core.h |  1 +
> >  kernel/debug/kdb/kdb_bt.c | 44 ++++++++++++++++++++++++++++++---------
> >  3 files changed, 40 insertions(+), 10 deletions(-)
> 
> Did either of you have thoughts on this patch?

Hi Doug

Sorry about this. It got backlogged during a recent holiday... it's still
on the list.

I took a quick look a week or so ago but at this point I haven't yet
tested out the behaviour on x86 and I wanted to do a closer review to
check I am happy with the barriering.


Daniel.

> 
> -Doug
