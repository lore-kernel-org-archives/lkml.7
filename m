Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E0FC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 05:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DDF2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 05:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cgpPmvVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbfFYFfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 01:35:38 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41117 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfFYFfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 01:35:38 -0400
Received: by mail-io1-f68.google.com with SMTP id w25so135002ioc.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 22:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nbrV1LsrICHBg5I0Sd+oJcDypLhzrXpy+1fRP2fNOhI=;
        b=cgpPmvVk3uM/MaCFV1GvYmZEjPReeMzO4Ellr8cKhj41skI86jvU2a03AIOaxu590z
         GFiGS6xU1QKhvboUa2PJkux8kmuP8/fSxKoLp5uAzNDosTieUTTCECJ/bGoSLmvuIAqy
         LYxEqYArgIy9Vm6LX4VtSrrWzgnPvJPgLDfg+j5vXWahgAesHeyK/4LqaeCGY4S7EEeT
         wKTWPhqm9AjG8gDzOI49i+wOcPxYiZUq0eWXsKgjH+yHe7zfB2FWqc5wHbTPxOZ7fnTp
         XDM9PVb7hznsTqS58KpkbML2Uo8oI2T63XvDYeOsZkehCfco9m3kKZ2fIis6fRklv8c5
         20RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nbrV1LsrICHBg5I0Sd+oJcDypLhzrXpy+1fRP2fNOhI=;
        b=dOX0cFgQPbBbrkYgMw56DkZSLy7li69RzZGN23h+hto/UIjdzylOnCsvUXmf4SjFku
         KhGUUWoJHRpdVGt1NbZX7G6OamhzDKdS14iOZrhpVWPcreKIo6x+XiCWrdLMFQ4tcpon
         hnwWB5oILw81LwgKYRUmgYFyuq3kRirAH5IfUTjxZ23JlenfTheuZ1AZcIP2E8a/Slmb
         x4itlsXHKIvDjnAO/RENLXpJJKQ968AJki8uv3Q1iQxdTzgOC23Gr8s9Vh2++UVa5OJX
         A6FBWlo+xHZ0syGa1wLjEM1JjLlcXOr2UA4ZGT8WdkZpwlF3zPop2Tp1mUtq1lwwCIN3
         UCpw==
X-Gm-Message-State: APjAAAVIAxS1RxV4GPrcLyp18Vq9bqUkCRn9nqZ6mcxV80z+z5C4Rii1
        PNFIEzyNddR/u0YqlzwL8ojH7wr4+0LRxtSpGDEDAw==
X-Google-Smtp-Source: APXvYqzNqMAyCpk/ZwuO3aIhT4X0bydlQ/vc7MFU0fmy14dTRE34R2zRrbrp6la05wGNP7I3lJzitxysiBb+SujwIFg=
X-Received: by 2002:a5e:c241:: with SMTP id w1mr42931241iop.58.1561440937129;
 Mon, 24 Jun 2019 22:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190612094503.120f699a@lwn.net> <CACT4Y+avfTeZTmhti=7nEadthZZpTnOCTdEuG2S7PovmAMkhZQ@mail.gmail.com>
 <20190614082542.3f8674eb@lwn.net>
In-Reply-To: <20190614082542.3f8674eb@lwn.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 25 Jun 2019 07:35:24 +0200
Message-ID: <CACT4Y+ZrErX2DgG4GPXpuWVSqm4bHnFOvDWyHaX-AGhNT3CRXw@mail.gmail.com>
Subject: Re: [PATCH v3] Add a document on rebasing and merging
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        David Rientjes <rientjes@google.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 4:25 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> On Fri, 14 Jun 2019 11:59:03 +0200
> Dmitry Vyukov <dvyukov@google.com> wrote:
>
> > I will appreciate if you elaborate a bit on this "scale of the
> > project". I wondered about reasons for having the current hierarchy of
> > trees and complex merging for a while, but wasn't able to find any
> > rationale. What exactly scale do you mean? I know a number of projects
> > that are comparable to Linux kernel, with the largest being 2 orders
> > of magnitude larger than kernel both in terms of code size and rate of
> > change, that use single tree and linear history.
>
> I'm not sure what projects you're talking about, so it's hard to compare.
>
> During the 5.2 merge window, Linus did 209 pulls, bringing in just over
> 12,000 changesets, from on the order of 1600 developers.  Even if, at the
> beginning of the window, each of those pulls was set up to be a
> fast-forward, they would no longer be positioned that way once the first
> pull was done.
>
> Are you really saying that subsystem maintainers should be continuously
> rebasing their trees to avoid merges at the top level?  Do you see how
> much work that would take, how badly it would obscure the development
> history, and how many bugs it would introduce?  Or perhaps I misunderstood
> what you're arguing for?


I mean projects like Chromium which seems to be comparable to kernel
in code size/rate of change. LLVM, Android are several times smaller,
but on the other hand has hundreds times less trees (1).  And in
particular large monorepos in companies like Google, Facebook,
Microsoft. E.g. the Google codebase sees the v5.2 number of changesets
in few hours. Although, it's not apples-to-apples with the kernel but
shows that scale per-se is not a requirement for multiple
trees/non-linear history.
So for the kernel it must a combination of scale + something else (in
the process, ownership model, ...). I am trying to understand what is
that something else, how inherent it is and what would degrade if
kernel switches to single tree/linear history. It would obviously
require some adjustments to other parts of the process as well, e.g.
you asked what maintainers do with their trees but if there is a
single tree, they don't have a tree at all. In most other scalable
processes that I am aware of, as much work as possible is pushed down
to individual contributors and they do any required rebasing. The
closest analog of maintainers only do review and approval. The idea is
to remove bottlenecks and distribute process as much as possible to
increase scalability. I heard about "maintainer scalability" in the
context of the kernel process multiple times.
