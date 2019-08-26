Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DA1C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 22:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82072184D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 22:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UtMoWumb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfHZWZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 18:25:56 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45861 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbfHZWZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 18:25:56 -0400
Received: by mail-io1-f66.google.com with SMTP id t3so41304753ioj.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 15:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ygGU8DXWO27Q7hU4Gq61cURNY6ZFP912S21n8nKf1Hs=;
        b=UtMoWumbCJ634fip4dFc90v0ojimVkA6Sm7sxgejzU4PsxHukts3eRWIhXUMFiGfrV
         8sn596xpxuu10d6PAtHfgCUwGei4KF8Trtt/UwFilKk+pYsyGBh0BPkD/AXTvFfhkDRj
         Iu8Vpk9ycW0DyzQMHJFuDaaP7bxxkkTjqzUY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ygGU8DXWO27Q7hU4Gq61cURNY6ZFP912S21n8nKf1Hs=;
        b=Egkms+QD4ciJzloYUdCGHQsvkgMMZwbw5zHtx1ldhP5o22rDedlSA7CubNs695nZtd
         WO871hc9NfYJ+JfgIfd0Ch7qk2nVV4rPN0gXSQhGQRmj5Eq4jU/5HEKOgy9bYec1x0q0
         +dwJUc3NGIQRelcy3qLprgY4YtD0hSqVEjufdGXRdeovmLo2X4/vGaGjZxnubKlZnyoI
         0ZfHzK7NCi/oy9azA7DXqr4X+BzSN67sliumabDqOiAteFy+L26Z4nbi4mag8IAxvhkJ
         G5m1/MMiHItS18w0/yW3kdInWsF706Okm1vdEvpQJDJT1VJggSIo1dVxCRZRMrQYYtH1
         Q3Bg==
X-Gm-Message-State: APjAAAVQXNp45MHJgu+xCowS6RuiqNmGDyvhbr1xr0abuEjfGnYr48l+
        U0MRGcU6Zl+RRqX0aQwn97EujUj2R4Q=
X-Google-Smtp-Source: APXvYqzUBAbzKw/nWDLf2ARR+wKDPsB3lhfxfE8LDA43Dl6Scjv4s+fZawky37XgiS4Wi4IUyKJH5w==
X-Received: by 2002:a02:c00c:: with SMTP id y12mr6447148jai.65.1566858355059;
        Mon, 26 Aug 2019 15:25:55 -0700 (PDT)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id s6sm10669455ioe.6.2019.08.26.15.25.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2019 15:25:53 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id j5so41368610ioj.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 15:25:53 -0700 (PDT)
X-Received: by 2002:a02:8481:: with SMTP id f1mr20019902jai.112.1566858352806;
 Mon, 26 Aug 2019 15:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190731183732.178134-1-dianders@chromium.org>
In-Reply-To: <20190731183732.178134-1-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 26 Aug 2019 15:25:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wh4M_A01gsWYBXSdgs0Gg4LAGDZ8X+5=4j=nuxiJ8kNA@mail.gmail.com>
Message-ID: <CAD=FV=Wh4M_A01gsWYBXSdgs0Gg4LAGDZ8X+5=4j=nuxiJ8kNA@mail.gmail.com>
Subject: Re: [PATCH v2] kdb: Fix stack crawling on 'running' CPUs that aren't
 the master
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason / Daniel,

On Wed, Jul 31, 2019 at 11:38 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> In kdb when you do 'btc' (back trace on CPU) it doesn't necessarily
> give you the right info.  Specifically on many architectures
> (including arm64, where I tested) you can't dump the stack of a
> "running" process that isn't the process running on the current CPU.
> This can be seen by this:
>
>  echo SOFTLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT
>  # wait 2 seconds
>  <sysrq>g
>
> Here's what I see now on rk3399-gru-kevin.  I see the stack crawl for
> the CPU that handled the sysrq but everything else just shows me stuck
> in __switch_to() which is bogus:
>
> ======
>
> [0]kdb> btc
> btc: cpu status: Currently on cpu 0
> Available cpus: 0, 1-3(I), 4, 5(I)
> Stack traceback for pid 0
> 0xffffff801101a9c0        0        0  1    0   R  0xffffff801101b3b0 *swapper/0
> Call trace:
>  dump_backtrace+0x0/0x138
>  ...
>  kgdb_compiled_brk_fn+0x34/0x44
>  ...
>  sysrq_handle_dbg+0x34/0x5c
> Stack traceback for pid 0
> 0xffffffc0f175a040        0        0  1    1   I  0xffffffc0f175aa30  swapper/1
> Call trace:
>  __switch_to+0x1e4/0x240
>  0xffffffc0f65616c0
> Stack traceback for pid 0
> 0xffffffc0f175d040        0        0  1    2   I  0xffffffc0f175da30  swapper/2
> Call trace:
>  __switch_to+0x1e4/0x240
>  0xffffffc0f65806c0
> Stack traceback for pid 0
> 0xffffffc0f175b040        0        0  1    3   I  0xffffffc0f175ba30  swapper/3
> Call trace:
>  __switch_to+0x1e4/0x240
>  0xffffffc0f659f6c0
> Stack traceback for pid 1474
> 0xffffffc0dde8b040     1474      727  1    4   R  0xffffffc0dde8ba30  bash
> Call trace:
>  __switch_to+0x1e4/0x240
>  __schedule+0x464/0x618
>  0xffffffc0dde8b040
> Stack traceback for pid 0
> 0xffffffc0f17b0040        0        0  1    5   I  0xffffffc0f17b0a30  swapper/5
> Call trace:
>  __switch_to+0x1e4/0x240
>  0xffffffc0f65dd6c0
>
> ===
>
> The problem is that 'btc' eventually boils down to
>   show_stack(task_struct, NULL);
>
> ...and show_stack() doesn't work for "running" CPUs because their
> registers haven't been stashed.
>
> On x86 things might work better (I haven't tested) because kdb has a
> special case for x86 in kdb_show_stack() where it passes the stack
> pointer to show_stack().  This wouldn't work on arm64 where the stack
> crawling function seems needs the "fp" and "pc", not the "sp" which is
> presumably why arm64's show_stack() function totally ignores the "sp"
> parameter.
>
> NOTE: we _can_ get a good stack dump for all the cpus if we manually
> switch each one to the kdb master and do a back trace.  AKA:
>   cpu 4
>   bt
> ...will give the expected trace.  That's because now arm64's
> dump_backtrace will now see that "tsk == current" and go through a
> different path.
>
> In this patch I fix the problems by catching a request to stack crawl
> a task that's running on a CPU and then I ask that CPU to do the stack
> crawl.
>
> NOTE: this will (presumably) change what stack crawls are printed for
> x86 machines.  Now kdb functions will show up in the stack crawl.
> Presumably this is OK but if it's not we can go back and add a special
> case for x86 again.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v2:
> - Totally new approach; now arch agnostic.
>
>  kernel/debug/debug_core.c |  5 +++++
>  kernel/debug/debug_core.h |  1 +
>  kernel/debug/kdb/kdb_bt.c | 44 ++++++++++++++++++++++++++++++---------
>  3 files changed, 40 insertions(+), 10 deletions(-)

Did either of you have thoughts on this patch?

-Doug
