Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10ECDC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 23:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4069205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 23:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="LrEuuV+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfCAXYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 18:24:11 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43239 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfCAXYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 18:24:10 -0500
Received: by mail-oi1-f195.google.com with SMTP id i8so20896410oib.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 15:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e/UacENV4WbTWn1Wv4mMZSa64/NkU5mKPQz23H0xeho=;
        b=LrEuuV+IJvMczvVVPcuvT5TWXSzjpQ/ZEYOa3ATCb0IGPlZI6PBIoEIhD2d4SaF+6B
         ER4xENxMb5DXuN+04gnHDtjX7ExDvGPsuVvFpMJMyjeRIeGALodtjrGulXXKqcGTMzO+
         ZejNO74xfPy6yS1rGx6ZriPwFoa0Cpw5R1BUdKxm6MugC+Istff/AfN79pWSWddriD5v
         yEwAnelOnso5ntUkTpx5I+jqkZNhQlR7MG55obCnTDDjMEOb7394kwg+WZs7lZL8OSf0
         2oIHnrQK4+Fm1PgC1yStNInxU+VT8HkTBW5Nb9RPWVn7QrSnte0JCEYrQGYp1oRj7EyU
         xQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e/UacENV4WbTWn1Wv4mMZSa64/NkU5mKPQz23H0xeho=;
        b=TF3gj+0NeOocgFUhK05iryrmtdVN85gFDrxH722wEPE5qFtihTSq6tOrvaDFZj+pi9
         F3sIINvRZbdgEEVBxmwuKv/iKI8YNmZ8KklajkOI0WYqBmXChzz2+xYfiXZ2X/9JEDO2
         wQx0IkITsAUjfQC385NkoThapRm6AwAVJzwBWqrRDEcVd76RVPj1btK24OapFnmI8waD
         f0QuPvdBxZAy5Acos9P1y+wmTPlqU6NZOA7D/3vxV9T0YJvBAE1YHC0tgXzjqhkfYahO
         CyrJ2qiCugfQBHY9vdEIyTXKAZ/3sR5kTFMN/FHxEVCtRRufcVn/5m47zXC/RCDM+v+o
         Zg+A==
X-Gm-Message-State: APjAAAUN6nus4hjL4BNUNwI0vXuyc5ton5Pz86Pw7aVeQj8ZnFfRdr2S
        yG0b0kqIUeJ75TD6FErs5mDiWBcJHHVAMIc0gx97VQ==
X-Google-Smtp-Source: APXvYqxYvcFwspRUzJfzOBv3qA35nU7UHDvw0dm0OA2N3TnJ0A6UpkfhFLloJaDEc2+G0X+4yC4DtRjHLHdFvHFwRjE=
X-Received: by 2002:aca:cc0f:: with SMTP id c15mr5285857oig.105.1551482649622;
 Fri, 01 Mar 2019 15:24:09 -0800 (PST)
MIME-Version: 1.0
References: <5c6702da.1c69fb81.12a14.4ece@mx.google.com> <20190215104325.039dbbd9c3bfb35b95f9247b@linux-foundation.org>
 <20190215185151.GG7897@sirena.org.uk> <20190226155948.299aa894a5576e61dda3e5aa@linux-foundation.org>
 <CAPcyv4ivjC8fNkfjdFyaYCAjGh7wtvFQnoPpOcR=VNZ=c6d6Rg@mail.gmail.com>
 <20190228151438.fc44921e66f2f5d393c8d7b4@linux-foundation.org>
 <CAPcyv4hDmmK-L=0txw7L9O8YgvAQxZfVFiSoB4LARRnGQ3UC7Q@mail.gmail.com>
 <026b5082-32f2-e813-5396-e4a148c813ea@collabora.com> <20190301124100.62a02e2f622ff6b5f178a7c3@linux-foundation.org>
 <3fafb552-ae75-6f63-453c-0d0e57d818f3@collabora.com>
In-Reply-To: <3fafb552-ae75-6f63-453c-0d0e57d818f3@collabora.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 1 Mar 2019 15:23:58 -0800
Message-ID: <CAPcyv4hMNiiM11ULjbOnOf=9N=yCABCRsAYLpjXs+98bRoRpCA@mail.gmail.com>
Subject: Re: next/master boot bisection: next-20190215 on beaglebone-black
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Mark Brown <broonie@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Matt Hart <matthew.hart@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, khilman@baylibre.com,
        enric.balletbo@collabora.com, Nicholas Piggin <npiggin@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Adrian Reber <adrian@lisas.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, info@kernelci.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 1, 2019 at 1:05 PM Guillaume Tucker
<guillaume.tucker@collabora.com> wrote:
>
> On 01/03/2019 20:41, Andrew Morton wrote:
> > On Fri, 1 Mar 2019 09:25:24 +0100 Guillaume Tucker <guillaume.tucker@collabora.com> wrote:
> >
> >>>>> Michal had asked if the free space accounting fix up addressed this
> >>>>> boot regression? I was awaiting word on that.
> >>>>
> >>>> hm, does bot@kernelci.org actually read emails?  Let's try info@ as well..
> >>
> >> bot@kernelci.org is not person, it's a send-only account for
> >> automated reports.  So no, it doesn't read emails.
> >>
> >> I guess the tricky point here is that the authors of the commits
> >> found by bisections may not always have the hardware needed to
> >> reproduce the problem.  So it needs to be dealt with on a
> >> case-by-case basis: sometimes they do have the hardware,
> >> sometimes someone else on the list or on CC does, and sometimes
> >> it's better for the people who have access to the test lab which
> >> ran the KernelCI test to deal with it.
> >>
> >> This case seems to fall into the last category.  As I have access
> >> to the Collabora lab, I can do some quick checks to confirm
> >> whether the proposed patch does fix the issue.  I hadn't realised
> >> that someone was waiting for this to happen, especially as the
> >> BeagleBone Black is a very common platform.  Sorry about that,
> >> I'll take a look today.
> >>
> >> It may be a nice feature to be able to give access to the
> >> KernelCI test infrastructure to anyone who wants to debug an
> >> issue reported by KernelCI or verify a fix, so they won't need to
> >> have the hardware locally.  Something to think about for the
> >> future.
> >
> > Thanks, that all sounds good.
> >
> >>>> Is it possible to determine whether this regression is still present in
> >>>> current linux-next?
> >>
> >> I'll try to re-apply the patch that caused the issue, then see if
> >> the suggested change fixes it.  As far as the current linux-next
> >> master branch is concerned, KernelCI boot tests are passing fine
> >> on that platform.
> >
> > They would, because I dropped
> > mm-shuffle-default-enable-all-shuffling.patch, so your tests presumably
> > now have shuffling disabled.
> >
> > Is it possible to add the below to linux-next and try again?
>
> I've actually already done that, and essentially the issue can
> still be reproduced by applying that patch.  See this branch:
>
>   https://gitlab.collabora.com/gtucker/linux/commits/next-20190301-beaglebone-black-debug
>
> next-20190301 boots fine but the head fails, using
> multi_v7_defconfig + SMP=n in both cases and
> SHUFFLE_PAGE_ALLOCATOR=y enabled in the 2nd case as a result
> of the change in the default value.
>
> The change suggested by Michal Hocko on Feb 15th has now been
> applied in linux-next, it's part of this commit but as
> explained above it does not actually resolve the boot failure:
>
>   98cf198ee8ce mm: move buddy list manipulations into helpers
>
> I can send more details on Monday and do a bit of debugging to
> help narrowing down the problem.  Please let me know if
> there's anything in particular that would seem be worth
> trying.
>

Thanks for taking a look!

Some questions when you get a chance:

Is there an early-printk facility that can be turned on to see how far
we get in the boot?

Do any of the QEMU machine types [1] approximate this board? I.e. so I
might be able to independently debug.

Were there any boot *successes* on ARM with shuffling enabled? I.e.
clues about what's different about the specific memory setup for
beagle-bone-black.

Thanks for the help!

[1]: https://wiki.qemu.org/Documentation/Platforms/ARM
