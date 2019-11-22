Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4C8C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 18:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0251020707
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 18:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="wNWvzpq8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfKVSuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 13:50:22 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39478 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfKVSuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 13:50:21 -0500
Received: by mail-oi1-f193.google.com with SMTP id v138so7399775oif.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 10:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NlbK6M2z9ltXCoUKRaVfCXvYkLVUjdiU4+HuMpNbpQg=;
        b=wNWvzpq8RdrJh/AB6vzVJgUewGsTxXi8gR2TG33WhKYr3TzWXA1NyVJH6OPeO6Sanm
         YR765U2kewKlhS4IV5T0ItUvs7SSnzYSTFqoDKch24edp5xBc6l5i1VgR8QA3epPUSZo
         7o82Sc0xvI8kr7+cMe9KQ2E1vqQ7/xyPRc5W9StSudpIpywbIe3pC4uV9Vws7fzCPuym
         w6B8Qnv4OUGFNY6ILB2Socr0F3ePoII0gtlkmN+6cApdXU23F3tnZBBUREsFYKkIcoM8
         88lw/MWTu0xz/q7o5Ho6X5RzWKg8nQPynqE0zYuhMbvtxjBeYpMlS87i1xERjNVU3Iqz
         L/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NlbK6M2z9ltXCoUKRaVfCXvYkLVUjdiU4+HuMpNbpQg=;
        b=PpZofhsexM1IUngCgJWjlYfhrg56dxGqbsQTpNhSisBa+Nl0UlcF016qfRaEmaCm6V
         4o1Zxxww2HbgJnLPQ0JIgv4OoFY0BfvJnEiQ7jD8X1mXF+8h6Og56YKzwLYh0e9OqVFu
         BWzWu1qtUmuOWfopE2nHmPYKsrEqn9ud6LTDzKIoOfVolJVDbBYl9HcEkRm2M0a1ttOY
         KQc7v5y0Jp8YD+pylZG1o1fkl2CZkIBFMX7wK9b6fcB/hRuy296ymqOhdUD0bfgZoDz3
         /XfGyTj4I8n/5eDeWqgMrO2Y/xPGzOinP6zV/t0zAnEG3AozydK/ajR7cHMqKAuVWBEd
         l7WQ==
X-Gm-Message-State: APjAAAU4kLUl7hlsavKY/SukUfjIyGccNZ5ZDo41kxeS0gVr4LJAUQye
        iHn8eIX8Q07SiRal8rm4YWfDi2ROzZ9tp0MmIp17tA==
X-Google-Smtp-Source: APXvYqySehOWsAqojTbu0/A8KW/Rq26HXplYi2MqxivoxYZMqIIThFjA0LBNYoNGJIjvGcmZlQ3Y3/O1RhtUBqAq7dk=
X-Received: by 2002:aca:55c1:: with SMTP id j184mr14267686oib.105.1574448620728;
 Fri, 22 Nov 2019 10:50:20 -0800 (PST)
MIME-Version: 1.0
References: <157428480574.36836.14057238306923901253.stgit@djiang5-desk3.ch.intel.com>
 <157428502934.36836.8119026517510193201.stgit@djiang5-desk3.ch.intel.com>
 <20191120215338.GN2634@zn.tnic> <247008b5-6d33-a51b-0caa-7f1991a94dbd@intel.com>
 <20191121105913.GB6540@zn.tnic> <ef6bc4a4-b307-9bc4-f3be-f7ab7232d303@intel.com>
 <20191122085953.GA6289@zn.tnic> <CAPcyv4isyT3FOPARBc8cSANbRWjhAsJrZTkT-fYivPZZJzF=tw@mail.gmail.com>
 <20191122184435.GK6289@zn.tnic>
In-Reply-To: <20191122184435.GK6289@zn.tnic>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 22 Nov 2019 10:50:09 -0800
Message-ID: <CAPcyv4jsT+FtwR8_fbo4npWvE240uUBtyoi_4ZUZc8gi_Q+SuQ@mail.gmail.com>
Subject: Re: [PATCH RFC 01/14] x86/asm: add iosubmit_cmds512() based on
 movdir64b CPU instruction
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Lin, Jing" <jing.lin@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 10:44 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Nov 22, 2019 at 09:20:39AM -0800, Dan Williams wrote:
> > For those cases the thought would be to have memset512() for case1 and
> > __iowrite512_copy() for case3. Where memset512() writes a
> > non-incrementing source to an incrementing destination, and
> > __iowrite512_copy() copies an incrementing source to an incrementing
> > destination. Those 2 helpers *would* have fallbacks, but with the
> > option to use something like cpu_has_write512() to check in advance
> > whether those routines will fallback, or not.
> >
> > That can be a discussion for a future patchset when those users arrive.
>
> Oh, sure, of course.
>
> My only angle is very simple: if the MOVDIR* et al is only supported on
> upcoming Intel platforms and looking at the use cases:
>
> 1. clear poison/MKTME
> 3. copy iomem in big chunks
>
> I'm going to venture a guess that those two cases are going to be
> happening only on Intel platforms which already support MODVIR*. So
> wouldn't really need to do any generic helpers because those use cases
> are very specific already. Which would make your feature detection a
> one-time, driver-init time thing anyway...
>
> Unless I misunderstand those cases and there really is a use case
> where the thing would fallback and the fallback would really be for an
> "unenlightened" platform without that MOVDIR* hw support...?

At least for something like __iowrite512_copy() it would indeed be
something an unenlightened driver could call. Those drivers would
simply be looking for opportunistic efficiency and could tolerate a
fallback. Just like current __iowrite64_copy() users don't care if
that routine falls back internally.
