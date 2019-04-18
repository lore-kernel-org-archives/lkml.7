Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD3CC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96F1217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555602594;
	bh=/9JYmhNTBw+Amu0F5QEheoMcJUgPvURXfq/pRkCAKd4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Kd5uGVcPNcNAEeWt7GP0/3Pyt8b6gRz1Pro9myqBrXGfkP6RJA4afcP1zY5eGWOCP
	 tK7RaYkjMDXtOUoj5KQ+oyjnqZANQe/yOGfVdeeVRgSQxXC0I45ZsbaYZ+cJzqkAnX
	 VujLDZ8ia7pbYFwRDe5rsPWyatX/EuqTM1uv1UMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389568AbfDRPtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:49:53 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40725 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387519AbfDRPtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:49:52 -0400
Received: by mail-lj1-f196.google.com with SMTP id q66so2337602ljq.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 08:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q3aXbW/8DQW79hhHpCT8m/hV2hycpbj+kUy1/X2/AUI=;
        b=b+i+BhJe93MaypvGfbqiHpFPfPoYO2L3LME38H627HLcuvOmeR8rABcBpC8sFzqKvJ
         TBvEYbogeiTQzUd7M3b+pFIWQ9sh7J5DZi3hLAu44P+IW/8nZSj57OAXzNk0yxYc0qWu
         3h3eqnLHWJHX9GL+hJS44OY8Mw7n4RA9Rqa/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q3aXbW/8DQW79hhHpCT8m/hV2hycpbj+kUy1/X2/AUI=;
        b=ryYbGLovskGz5vrAGjru3LLGi3bUkjj71q66oJj+EzV4hCfj4KnqcPL6damy4nLUl3
         8HsEdcFKd7KedrxYhWjQxcpR15wG9A1qurUzcAUY2Sf5I/OJKMafnnWNhh0y1qaMJTsW
         IGmok6GjG7vbLbz0JzZj3EjEUbk4NCN1iog0AichE+QBfZGIWs9T+IJTUoXfeeL40C5d
         E6TeeGK0ALpWq/jHIC8jryVTgijn+kSTKYlB19SV0Y/YglTKDecBOVIp1vt8nMLZT35S
         XwUD1yDwLeNs4TpxB5dFcXHCsWNgo3cxM+lxodaJC6nEzFxZMo1od0zZOdhrBT20e1ug
         qHLg==
X-Gm-Message-State: APjAAAUR/le7bHw9Q6NAranYcaE2E+Lbx6MGubju0xxKKuV/nVcs+uc9
        u3Nu5O82DdGlIP4oqjL/afnqxAJ8BJE=
X-Google-Smtp-Source: APXvYqyH+97pcCIC160uxUivokSSbpqvZvLru4delWp+74LvMrFEJpSGIhcQVlHPPilbYCWiePsZjQ==
X-Received: by 2002:a2e:8149:: with SMTP id t9mr54253482ljg.2.1555602590147;
        Thu, 18 Apr 2019 08:49:50 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id f15sm519321lfa.89.2019.04.18.08.49.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 08:49:49 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id t11so1982541lfl.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 08:49:49 -0700 (PDT)
X-Received: by 2002:ac2:547a:: with SMTP id e26mr11547187lfn.148.1555602588563;
 Thu, 18 Apr 2019 08:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
 <20190415051919.GA31481@infradead.org> <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
 <20190416110906.6c773aff@mschwideX1> <20190416140658.2cb73a3f@mschwideX1>
 <CAHk-=wjKi5C+Onhp5Vs5BQxHbaBud9M3cTS-S6Tr9yDY4dS-Sw@mail.gmail.com>
 <CAHk-=wj2SW0Zno0Yn=S9wrsmHOKV0FiFPiPS4TM=Gn8yjfYXAg@mail.gmail.com>
 <20190417094637.51ad4c67@mschwideX1> <20190417100244.42e29736@mschwideX1>
 <CAHk-=wj5j-zMo7hVNxiw3+5L2d1WQVm3x4fbpg=OXLzDh8FhYg@mail.gmail.com> <20190418100218.0a4afd51@mschwideX1>
In-Reply-To: <20190418100218.0a4afd51@mschwideX1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 18 Apr 2019 08:49:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=whajv8Fw2VcBqZUs0hfx1Dq4fYj3TEEx4yfR3E8+rLS1A@mail.gmail.com>
Message-ID: <CAHk-=whajv8Fw2VcBqZUs0hfx1Dq4fYj3TEEx4yfR3E8+rLS1A@mail.gmail.com>
Subject: Re: Linux 5.1-rc5
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 1:02 AM Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
>
> The problematic lines in the generic gup code are these three:
>
> 1845:   pmdp = pmd_offset(&pud, addr);
> 1888:   pudp = pud_offset(&p4d, addr);
> 1916:   p4dp = p4d_offset(&pgd, addr);
>
> Passing the pointer of a *copy* of a page table entry to pxd_offset() does
> not work with the page table folding on s390.

Hmm. I wonder why. x86 too does the folding thing for the p4d and pud case.

The folding works with the local copy just the same way it works with
the orignal value.

But I see that s390 does some other kind of folding and does that
addition of the p*d_index() unconditionally.

I guess that does mean that s390 will just have to have its own walker.

For the issue of the page refcount overflow it really isn't a huge
deal. Adding the refcount checking is simple (see the example patch I
gave for powerpc - you'll just have a couple of extra cases since you
do it all, rather than just the special hugetlb cases).

Obviously in general it would have been nicer to share as much code as
possible, but let's not make things unnecessarily complex if s390 is
just fundamentally different..

                   Linus
