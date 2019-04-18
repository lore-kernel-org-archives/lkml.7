Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCDCC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 21:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9BC217F9
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 21:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J7VU+s3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfDRVu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 17:50:27 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39451 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfDRVu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 17:50:27 -0400
Received: by mail-vs1-f67.google.com with SMTP id g127so1972509vsd.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 14:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nbQhWAc0BY/g+vfB6xa1sh2HUvKTewMTrdeRi/83I3s=;
        b=J7VU+s3q1vtlLio0HwJa04cmeNVI3wGJA51FshzjeBfkR+LNiS971Y6NT3X2LsIHWs
         H7WpRavt7xHOkK8GadambVafHv/GrPFhSip8WEDLnnIP1r2CUKRwmn8JReSCCCfdVk0J
         i8Tk4/i4f6TIDSsIgpWDcO9Z/R8nZN/h5aAx/J8+P6uhDbXNn3uSnaaZSP/8XySuyfFK
         X6YYSWieUTmC+4DXLT87jlXg4EF9XCh9UNO01NlRplVXgiGbWYa31AtZfcJT+WGF0kwL
         YpommwWJEKIxUwNrs87OnTv1GEhvwyKnPEduf6PVtXgojppNMQrHrQvlb1U6IY8UL5iV
         rqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nbQhWAc0BY/g+vfB6xa1sh2HUvKTewMTrdeRi/83I3s=;
        b=eEUqkL/c/HEywEwfM4YvzoaTreuPSu9Dq+kJYCYPH5ZLeh1GIRm2cDf50UfqLTbRjN
         oIFelMxIeHGTOF8lnDB8HCP8MhHuV9lYrr1cuhIPShYZkN+uyMmvC7PCdt3CZq7FwKrU
         1YmKKVCzS9edTqS93MOXoGf6UqzFiQMW0+JbUIokiNT8KAEENTLBzSbpdbklg30nXYt/
         X7VZBiTDBBdKC12IiBw/+vvOVPg+TwQVlSuxf4uEqUKvAKSunQ98bdn9xXdiBSf9Ttrs
         mpA1TilFaEkq0SotjPp1pJi/NQVN8EEai5HMZCiC1bEMpq9R5DWFtbr0MuJTz2OZawQ6
         cvKw==
X-Gm-Message-State: APjAAAXmlCrwWGc8G0DkMLGYFA5SA2vpOs3HMGJtRPLxUkowo+njiZiN
        tSLxsBM4DYamrSIl5JPNZCBQbewKZH/CgQXp5bmvDQ==
X-Google-Smtp-Source: APXvYqx9+4Gojcme2I2SOifKTmMYAXhdjBuhgBg/2iLr0cVk3aN6Orrlubhx+vOUL0m722dwpVspY3akT310rQg9Lfc=
X-Received: by 2002:a05:6102:3d5:: with SMTP id n21mr86819vsq.101.1555624225805;
 Thu, 18 Apr 2019 14:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190408173252.37932-3-eranian@google.com> <tip-f447e4eb3ad1e60d173ca997fcb2ef2a66f12574@git.kernel.org>
 <alpine.DEB.2.21.1904161227001.20764@macbook-air> <20190417060625.GB97541@gmail.com>
In-Reply-To: <20190417060625.GB97541@gmail.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Thu, 18 Apr 2019 14:50:14 -0700
Message-ID: <CABPqkBQ=pLuu_Qv5u_7hM+LH8=Ys+ZhTPkcQyVY4zJasVBiqYg@mail.gmail.com>
Subject: Re: [tip:perf/core] perf/x86/intel: Force resched when TFA sysctl is modified
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Vince Weaver <vincent.weaver@maine.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vince

On Tue, Apr 16, 2019 at 11:06 PM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Vince Weaver <vincent.weaver@maine.edu> wrote:
>
> > On Tue, 16 Apr 2019, tip-bot for Stephane Eranian wrote:
> >
> > > Commit-ID:  f447e4eb3ad1e60d173ca997fcb2ef2a66f12574
> > > Gitweb:     https://git.kernel.org/tip/f447e4eb3ad1e60d173ca997fcb2ef2a66f12574
> > > Author:     Stephane Eranian <eranian@google.com>
> > > AuthorDate: Mon, 8 Apr 2019 10:32:52 -0700
> > > Committer:  Ingo Molnar <mingo@kernel.org>
> > > CommitDate: Tue, 16 Apr 2019 12:19:35 +0200
> > >
> > > perf/x86/intel: Force resched when TFA sysctl is modified
> >
> > What's TFA?  Tuna-fish-alarm?
>
> Heh, I wish! :-)
>
Sorry about the confusion. I was just trying to mimic the function
names that Peter used
in the code. Hard to fit the whole sysctl name in the title, anyway.

> > [...] Nowhere in the commit or in the code does it ever say what a TFA
> > is or why we'd want to resched when it is modified.
>
> Yeah, it's the TSX-Force-Abort acronym - Intel has numbed our general
> dislike to random acrynyms ...
>
> Peter and me usually fix such changelog context omissions, but this one
> slipped through. :-/
>
> The commit is too deep down perf/core already to rebase it just for the
> changelog, but if we are going to rebase it for some functional reason
> I'll take care of it next time around.
>
> TFA. (Thanks For your Assistance. :-)
>
>         Ingo
