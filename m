Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F007C04A6B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 02:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B54206BF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 02:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXinLTgK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfEGCWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 22:22:11 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40112 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEGCWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 22:22:10 -0400
Received: by mail-qt1-f193.google.com with SMTP id k24so134754qtq.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 19:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jK6Bics0fYV05jP/8TC1wHKksibXz+N1xS03DvO5n0M=;
        b=aXinLTgKPNcXcliZibkQr+Tp4wlzRVm+grI6Y9DxEMpfTyWa6gXVIri7+kkOUjiDhA
         WNTk8Fb58VDaeuMTDF3pwoFNuYLTzHUkwkwoQvD+sQUhk5Deyf6vswkgb8z0QeUQwcPx
         KKRH4NDWHuBU0fm6SjckVbXZMOzylyftUdtR7Bjq2dupX2ZGvMcL50CMO74hOAh19nem
         KAKiWU1rxNlAE27s7ZUrosQe0J7S5RYBroW8wlCyYzQ0I0xBWLrl0Cq3OL0y1yyvpUBA
         9u2tOFYLhCchnKUIbR7w39gUYNK1h1s24rxfHNt6Eaj0Z7m3TO4JUGzEVyRRRfLjf2mk
         8iXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jK6Bics0fYV05jP/8TC1wHKksibXz+N1xS03DvO5n0M=;
        b=CPut2LwZArFb3xZ/T2TtezSj+mVKhAP8ZoTljsDuevvhfdA7CFcsg7bwkPsz0LuDgA
         j1RcUJiWGlaB2KbjA3sSVMpPEcFe//VTKBMZtolywDKs0nc6fp+jNBu3OoIUOE3G0M8D
         yRyBUG1vmS7h1egDEqacx5gB/w7nC/mVJhMrj5I9sXrsHb8Fpu+jaE+rGp5Sz+VRFieJ
         cyve3niIwfa6zPhQbViOLe/FPv1+BvmKpNCXmSqakOdid33j4VlhricUufc6wsCiBTmB
         Wbt9TvWme5dZuuzqBSZRoVgKEgXAMvJ/xlkK/JaxbqCVpkQtifBDbQkIwQbtqbHZmxpC
         oolQ==
X-Gm-Message-State: APjAAAXtAHF+qGZB7b0DoGxGxjgShdQi/9pgha7aNqfFpSIYMluMsDUm
        IL73x1fW6huipKWx3b22yCG0HzDEJiqE6+AQ91fyoome/OYCRVDF
X-Google-Smtp-Source: APXvYqx8Fnjl3bYZT6WDWHo/fsPeg+oWFyOgvvjtSHCy2S+lcQcUXt58CIY3af2nT1J7bxxAcWQEg+LWhpvwKtBuKjQ=
X-Received: by 2002:a0c:af81:: with SMTP id s1mr24155119qvc.49.1557195729668;
 Mon, 06 May 2019 19:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190424101934.51535-1-duyuyang@gmail.com> <20190424101934.51535-20-duyuyang@gmail.com>
 <20190425193247.GU12232@hirez.programming.kicks-ass.net> <CAHttsrY4jK2cayBE8zNCSJKDAkzLiBb40GVfQHpJi2YK1nEZaQ@mail.gmail.com>
 <20190430121148.GV2623@hirez.programming.kicks-ass.net> <20190507014712.GA14921@lerouge>
In-Reply-To: <20190507014712.GA14921@lerouge>
From:   Yuyang Du <duyuyang@gmail.com>
Date:   Tue, 7 May 2019 10:21:58 +0800
Message-ID: <CAHttsra_jACOSZpwnp0KtuAOFWtXt5AHf+RVWMvEbxWbieVw0w@mail.gmail.com>
Subject: Re: [PATCH 19/28] locking/lockdep: Optimize irq usage check when
 marking lock usage bit
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, will.deacon@arm.com,
        Ingo Molnar <mingo@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>, ming.lei@redhat.com,
        tglx@linutronix.de, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 May 2019 at 09:47, Frederic Weisbecker <frederic@kernel.org> wrote:
> > > But for usage checking, which vectors are does not really matter. So,
> > > the current size of the arrays and bitmaps are good enough. Right?
> >
> > Frederic? My understanding was that he really was going to split the
> > whole thing. The moment you allow masking individual soft vectors, you
> > get per-vector dependency chains.
>
> Right, so in my patchset there is indeed individual soft vectors masked
> so we indeed need per vector checks. For example a lock taken in HRTIMER
> softirq shouldn't be a problem if it is concurrently taken while BLOCK softirq
> is enabled. And for that we expand the usage_mask so that the 4 bits currently
> used for general SOFTIRQ are now multiplied by NR_SOFTIRQ (10) because we need to
> track the USED and ENABLED_IN bits for each of them.
>
> The end result is:
>
> 4 hard irq bits + 4 * 10 softirq bits + LOCK_USED bit = 45 bits.
>
> Not sure that answers the question as I'm a bit lost in the debate...

It was really I was lost: I didn't realize the enabling (or disabling)
is going to be fine-grained as well until I read this changelog:

Disabling the softirqs is currently an all-or-nothing operation: either
all softirqs are enabled or none of them. However we plan to introduce a
per vector granularity of this ability to improve latency response and
make each softirq vector interruptible by the others.

Sorry for the confusion I made :)
