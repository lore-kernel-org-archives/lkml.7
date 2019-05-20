Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A449C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00EC205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Q2ZvmjGT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfETTA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 15:00:28 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41347 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfETTA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 15:00:27 -0400
Received: by mail-ot1-f66.google.com with SMTP id l25so5635932otp.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 12:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wT81sA73prwjBsqvneE0nbb4zGsqTgjv/ErvD6Lkzzw=;
        b=Q2ZvmjGTacUUOs5fbuhnrA6Wr2XUFQFnYsPj9j7PrBl7WzFcR9qhhhOoKQh++mdR0f
         0YNT8dqvY9XRrep6/Gl5xt8G/DrBDRRbA0YTIz7mGP8WG2+qWdjmPdWZsTGyB7RUKOPx
         h/gjeBGv9LnFBL98Caa3RLNhkAwG8yksaRRdTioQnoUhhLLf7/tqKprIoHFiVMFZcWJH
         x81dNJsAF33+dyWCE9HotSRfO+nnkWl5h/rp4iyupAobkJoMCbKyOI5J46AcPdwaXIt8
         +SDgrX9kJf8yDczFvjxsCjhkU2OlicK02qE7WywQBzvK/RLwIOhzUlCMPY/VwNDpoSbB
         4XLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wT81sA73prwjBsqvneE0nbb4zGsqTgjv/ErvD6Lkzzw=;
        b=U6uYG9hBGYa7xx2ULKcTHDsgo5cEUGer41E0qBaq/qT6aAgm5vY6gU9J3+iGYSEK+K
         Sq/m3Z6Lxv6tasqbq7LLD7dLa5dZZQxKsEvSwvA99vX2t6+asevR9OzxAkHADY/EhgYr
         Ozce0YTbfwfJ8RB0oS5VqTDniUIeqn+aY0qghY7FWuMFb2IqNL8+ojO3MJ8rsCvM94JM
         POkGOJxGKmAE8klSRXICSQWdOs8wKP2qqWVw7YGICjolc0seGA5ddZgCVVuEAg8Gje+w
         eMyg4vvk2x5KHy+Ye6e+bkiB2R9OBU88nUJwsLOd/UJiGVSDlZC7i5umoc5zA+DOpclj
         zQIA==
X-Gm-Message-State: APjAAAW+rMM0SxKVqbSkWF7ip5wm93n00EGUlz8VPdCnOOrCzSzQt/fx
        QXvVsBgVRij9xEijlYvQaeefE3orPAravyxun+RWTA==
X-Google-Smtp-Source: APXvYqxY1aZ42ZhklyO4YSGancB5WqzPtQVKG8B6/X5MmZ+sCMgjK7BOHJprDezZUAhy6RWai7+JrGPqPs3PTdKdkp8=
X-Received: by 2002:a05:6830:1182:: with SMTP id u2mr34775429otq.71.1558378827193;
 Mon, 20 May 2019 12:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <1558089514-25067-1-git-send-email-anshuman.khandual@arm.com>
 <20190517145050.2b6b0afdaab5c3c69a4b153e@linux-foundation.org> <cb8cbd57-9220-aba9-7579-dbcf35f02672@arm.com>
In-Reply-To: <cb8cbd57-9220-aba9-7579-dbcf35f02672@arm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 20 May 2019 12:00:16 -0700
Message-ID: <CAPcyv4iSTxmnORJY_UwXqeP2kiWc55j5h1Z+HgC8orRSaxTgfA@mail.gmail.com>
Subject: Re: [PATCH] mm/dev_pfn: Exclude MEMORY_DEVICE_PRIVATE while computing
 virtual address
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 19, 2019 at 10:37 PM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> On 05/18/2019 03:20 AM, Andrew Morton wrote:
> > On Fri, 17 May 2019 16:08:34 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> >
> >> The presence of struct page does not guarantee linear mapping for the pfn
> >> physical range. Device private memory which is non-coherent is excluded
> >> from linear mapping during devm_memremap_pages() though they will still
> >> have struct page coverage. Just check for device private memory before
> >> giving out virtual address for a given pfn.
> >
> > I was going to give my standard "what are the user-visible runtime
> > effects of this change?", but...
> >
> >> All these helper functions are all pfn_t related but could not figure out
> >> another way of determining a private pfn without looking into it's struct
> >> page. pfn_t_to_virt() is not getting used any where in mainline kernel.Is
> >> it used by out of tree drivers ? Should we then drop it completely ?
> >
> > Yeah, let's kill it.

+1 to killing it, since there has been a paucity of 'unsigned long
pfn' code path conversions to 'pfn_t', and it continues to go unused.

> > But first, let's fix it so that if someone brings it back, they bring
> > back a non-buggy version.

Not sure this can be solved without a rethink of who owns the virtual
address space corresponding to MEMORY_DEVICE_PRIVATE, and clawing back
some of the special-ness of HMM.

>
> Makes sense.
>
> >
> > So...  what (would be) the user-visible runtime effects of this change?
>
> I am not very well aware about the user interaction with the drivers which
> hotplug and manage ZONE_DEVICE memory in general. Hence will not be able to
> comment on it's user visible runtime impact. I just figured this out from
> code audit while testing ZONE_DEVICE on arm64 platform. But the fix makes
> the function bit more expensive as it now involve some additional memory
> references.

MEMORY_DEVICE_PRIVATE semantics were part of the package of the
initial HMM submission that landed in the kernel without an upstream
user. While pfn_t_to_virt() also does not have an upstream user it was
at least modeled after the existing pfn_to_virt() api to allow for
future 'unsigned long pfn' to 'pfn_t' conversions. As for what a fix
might look like, it seems to me that we should try to unify 'pfn_t'
and 'hmm_pfn's. I don't see why 'hmm_pfn's need to exist as their own
concept vs trying consume more flag space out of pfn_t. That would at
least allow the pfn_t_has_page() helper to detect the HMM case.
