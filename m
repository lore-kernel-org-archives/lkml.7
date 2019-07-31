Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959DCC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 23:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677A9208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 23:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZTsUJ+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbfGaX4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 19:56:01 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43517 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfGaX4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 19:56:00 -0400
Received: by mail-lj1-f196.google.com with SMTP id y17so42875067ljk.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 16:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C5QOeLk7yQQUtN6RiDUd1CkiFI0D44hl2RjrJZE5DIs=;
        b=XZTsUJ+D/jGUZ1cRRjm0rRM3/PwYaYhuJT5ThMenGwFPaUBiyxu/3O4MyCMZTok4gt
         XyyFl8PuN3ykZhan4tXfp9xUs1CP95/tBPnqInO9RTBMJyUjORUWntlkt3Hy1TRBdG4f
         EamlLG7kquBdyW4/URc31FNX+aodEJrRhTsiYSe0vJVjYUVeITOgeYVFA3neDUovNBj9
         1NEmlwL9YGHCVFvC3/HhaQcOsWgHvjHQXOOiAjUksi3QOdY/RimFZcha/Ll0hLKF/KlT
         pll0Kfdpy5qjxvOQF5ka+DB+vJhn/PdWznPjvOrRLY9i48rMRTYfPMAJ7IL+lVzoBWkY
         pHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C5QOeLk7yQQUtN6RiDUd1CkiFI0D44hl2RjrJZE5DIs=;
        b=eQpCgoA6ZsBmFfE8zMe6nFrn65n824CbNAnq9b4fp+arjQwzk7i21VVDfz9p20mYw0
         yjB3MEZQJ5V/JP35X70ML35cxSFC1NeLjZfS6S/OdDWojHJfh+foUHnr1fB8+Y7UQ4Bl
         veks9+JhT1LJ2mQeYu528xKXETlKn9t3BAMx46Mrpr52Lw45Cd9wOCoK0g29c7EWIBgE
         7I/6NjRfW9ybdTIaO1dK1KhJyyx2BrnRlDz0v5JceAgwJUld+j/6R4A33uFoJlKHKXLt
         d9nkVG+BuGzjVQGqH+IWHO22cA1SiBhqv+/1x5KmuhqJAvFKPXKlfVov/g4Q871izQ8T
         WueQ==
X-Gm-Message-State: APjAAAXECvftHyRMXvwepV8YYGkmwoasrIp4VhrQhkhSIwuceilL4rd8
        5ncuSbqK0qqNQ8w40HGmHinGElkC/XpjDoqQsXY=
X-Google-Smtp-Source: APXvYqxUsnSF5n5IUFJrMAXD6SRIkdb4Z3PuQ+Z1JGT9J4eBL3pXc37pNGpxy/1SB5IkzPzu0kbg3DtC8cDwgL+qxPs=
X-Received: by 2002:a2e:8741:: with SMTP id q1mr13422620ljj.144.1564617358799;
 Wed, 31 Jul 2019 16:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com>
 <1d2830aadbe9d8151728a7df5b88528fc72a0095.1564549413.git.joe@perches.com>
 <20190731171429.GA24222@amd> <ccc7fa72d0f83ddd62067092b105bd801479004b.camel@perches.com>
 <765E740C-4259-4835-A58D-432006628BAC@zytor.com> <20190731184832.GZ31381@hirez.programming.kicks-ass.net>
 <F1AB2846-CA91-41ED-B8E7-3799895DCF06@zytor.com>
In-Reply-To: <F1AB2846-CA91-41ED-B8E7-3799895DCF06@zytor.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 1 Aug 2019 01:55:47 +0200
Message-ID: <CANiq72=s1nu9=R9ypFwL+J4NGT_yUkwahpgOOOXzezvNfDrx5g@mail.gmail.com>
Subject: Re: [RFC PATCH] compiler_attributes.h: Add 'fallthrough' pseudo
 keyword for switch/case use
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 11:01 PM <hpa@zytor.com> wrote:
>
> The standard is moving toward adding this as an attribute with the [[fallthrough]] syntax; it is in C++17, not sure when it will be in C be if it isn't already.

Not yet, but it seems to be coming:

  http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2268.pdf

However, even if C2x gets it, it will be quite a while until the GCC
minimum version gets bumped up to that, so...

Cheers,
Miguel
