Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E128C00319
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3073B208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p2Y8hdNn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbfCERrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 12:47:51 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36336 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730075AbfCERrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 12:47:49 -0500
Received: by mail-pg1-f195.google.com with SMTP id r124so6127965pgr.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 09:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gHJM1QM5EJjUOY2FDdaKsqaFOXK3eKenoExJbNcqN4g=;
        b=p2Y8hdNnqthiWdPWaqmFy7b/8k5R5/BmM19TtexhhrWTduZyd1hXY4SAlsKdKjdcPI
         sat72+hX+ZkqOFLb8LdG6frRV2OtpqnIvtHde17vUlUIvR5ceD/KeoyIS1GlzP+N5xK/
         u9EerRuH/goJiFrHsvZzQvnJBSrIj70uKlg5qfpjpHnK+3pQf5iWM67T1SrG4ybBTvVt
         nLxM02ayT0Y0fMLUulujQe30SOR0DSgftsFb1H6mDwY74OgZRJx4phYor6WZSVxbIsDK
         myhDVYqAdqOKhriLkvtPoMwKzAS1kM6d+LD+r4uhhuiNhJStX3Y7uIGJ0qshrYteS8OD
         MDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gHJM1QM5EJjUOY2FDdaKsqaFOXK3eKenoExJbNcqN4g=;
        b=m2pAuc7BWlGIWW6bO4+6khcXFGg/JLfGBg/CjHNhGXWaIBJpibr00aJ9rY/nthDRwh
         rJHWz0A+e1d9ci77kVR8ZsvA/m/NlQXjHtHDTJ5dRpouxSGhZyKgKVDIrm0EpYWCzLQR
         oHSo1GG9PQqHgmwtY95TK8983Lhej9wrHgxWvGHy5ca1rn/hFGV2GutMgbFjah66ovs/
         ynt13c8PxjQm0s7xQHD2Ai3LSQ1KwB/cCKpFfkH8FS/oN0n5yLsirLfGl25qwKS5gd3H
         BBbCFL3FnITdtO3M1nQeYrpyGaU54ZFTS0eWE8wmH+I9/eU2fB89g9N9zJPUab1bklMi
         imRw==
X-Gm-Message-State: APjAAAWl0XPbhA5g8X33BJo2Ol8LfqjHZ3b6k+d1OVIarOJ2z3qqLR69
        kP//v2XX1fNlqQeU+pFrbUpjWIpRsrrDRj7q7Ou3ow==
X-Google-Smtp-Source: APXvYqwDj3NnoGrQ2kCWYrAH9v9f6KsnKIVl5PHMyojxupslR+Vg36DkEhtUHfsEu9xerxBBdBjMih96qnmG5qP52o4=
X-Received: by 2002:a65:6651:: with SMTP id z17mr2299629pgv.95.1551808068440;
 Tue, 05 Mar 2019 09:47:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550839937.git.andreyknvl@google.com> <8343cd77ca301df15839796f3b446b75ce5ffbbf.1550839937.git.andreyknvl@google.com>
 <73f2f3fe-9a66-22a1-5aae-c282779a75f5@intel.com> <CAAeHK+yQU8khtOoyDKqmHterCa16P7oWe9AMiPnrxE+Gyb_7aw@mail.gmail.com>
 <20190301165908.GA130541@arrakis.emea.arm.com> <fb721f0b-fad7-2310-4f17-8bf046413d40@intel.com>
In-Reply-To: <fb721f0b-fad7-2310-4f17-8bf046413d40@intel.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 5 Mar 2019 18:47:37 +0100
Message-ID: <CAAeHK+ydurtkoVtvyoQdfcXuR3ZnZ+=ixoZkXEFRTZARg+GtRQ@mail.gmail.com>
Subject: Re: [PATCH v10 07/12] fs, arm64: untag user pointers in fs/userfaultfd.c
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 1, 2019 at 7:37 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 3/1/19 8:59 AM, Catalin Marinas wrote:
> >>> So, we have to patch all these sites before the tagged values get to the
> >>> point of hitting the vma lookup functions.  Dumb question: Why don't we
> >>> just patch the vma lookup functions themselves instead of all of these
> >>> callers?
> >> That might be a working approach as well. We'll still need to fix up
> >> places where the vma fields are accessed directly. Catalin, what do
> >> you think?
> > Most callers of find_vma*() always follow it by a check of
> > vma->vma_start against some tagged address ('end' in the
> > userfaultfd_(un)register()) case. So it's not sufficient to untag it in
> > find_vma().
>
> If that's truly the common case, sounds like we should have a find_vma()
> that does the vma_end checking as well.  Then at least the common case
> would not have to worry about tagging.

It seems that a lot of find_vma() callers indeed do different kinds of
checking/subtractions of vma->vma_start and a tagged address, which
look hardly unifiable. So untagging the addresses in find_vma()
callers looks like a more suitable solution.
