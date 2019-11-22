Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72353C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4889F20714
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="LemNwUSK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfKVRUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 12:20:51 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43340 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfKVRUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 12:20:50 -0500
Received: by mail-oi1-f196.google.com with SMTP id l20so7130024oie.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 09:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fN9Q7xWO0FbuGOg0ZLM+ialJgn3N+fh3qmMRWr4AQ6U=;
        b=LemNwUSKL4Zq/wre+tl5MbDnUNuFV8wVTA/PzNJt4iFC1YfvZzAWiNNG2hmkKZsyVk
         Ux0I9Hv8eN3hO/xU/RkQa//cWiL99jSy8YQpwI9kXWbGUA5uIuTb8mgjlJ4U+zXNTbl9
         FbCDtaokZgJu9yVGkDkDj0hC8g6O4gN4AJ87hdzrvps3ENE4IFRcF7ppAFebtWnSDyZV
         TgYPhansYSrM2FKPG2oiKnKP/uaBzJjiJWHHGsHNCce2uGWUekNod7gNDEYxS7lEiABy
         ciYc+BEo447C39/mxTGF12eKz6OdAdPNvEdZKod+fnIs2gaKY3mBzxZn4TlNmB42luUc
         rQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fN9Q7xWO0FbuGOg0ZLM+ialJgn3N+fh3qmMRWr4AQ6U=;
        b=CvStQmrbyyCYF0MimPc7lhOpVXEUjwccTu4ziMkTjgLDq/VxGPPmXOUGtBwCDScfwJ
         ayoCrVomIx3UjYBPlJtFgANjPgtladKEPqFtwaEl9dPHbYYtWoxz4Lqt7WjOTz//pn+d
         yY7U8eRKT0vpVUg3kXrookqhGFv5MLv/sZKmP5fR+dEMl7GcUubUZAvtb7WWx+Xn7Hay
         NOoawKfzfI/OJHG15XULnSOCkuwwdoIKxwLyy9zqOfrWl9m8xr7BEarheKI4WH+FFBa8
         7ebTZ6e6JW5huENAm8nJPNOSosYSPw6cvsk+a6lDrt21maWDi7x5uCxthcEZYWF6WDzT
         XPKw==
X-Gm-Message-State: APjAAAXNRZqKmpN7ZHMQEw1FRfw9qlKprIBKRG1klLL3qmEfsKCp+dnM
        CUnqAzjfXjxVfO4Ke2gFgMa022uIPz7jgsq2mDBeqA==
X-Google-Smtp-Source: APXvYqwhIC9vQ8yjpEDPT9U3Y2BSJTtNQkNiL/hHwJTZOR5pP0KAc6amfY2OBoTPfD1k9znhgvRcAOCxr3xuGAnF1I8=
X-Received: by 2002:aca:3c1:: with SMTP id 184mr12377716oid.70.1574443250004;
 Fri, 22 Nov 2019 09:20:50 -0800 (PST)
MIME-Version: 1.0
References: <157428480574.36836.14057238306923901253.stgit@djiang5-desk3.ch.intel.com>
 <157428502934.36836.8119026517510193201.stgit@djiang5-desk3.ch.intel.com>
 <20191120215338.GN2634@zn.tnic> <247008b5-6d33-a51b-0caa-7f1991a94dbd@intel.com>
 <20191121105913.GB6540@zn.tnic> <ef6bc4a4-b307-9bc4-f3be-f7ab7232d303@intel.com>
 <20191122085953.GA6289@zn.tnic>
In-Reply-To: <20191122085953.GA6289@zn.tnic>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 22 Nov 2019 09:20:39 -0800
Message-ID: <CAPcyv4isyT3FOPARBc8cSANbRWjhAsJrZTkT-fYivPZZJzF=tw@mail.gmail.com>
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

On Fri, Nov 22, 2019 at 1:00 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Nov 21, 2019 at 09:52:19AM -0700, Dave Jiang wrote:
> > No what I mean was those primitives are missing the checks and we should
> > probably address that at some point.
>
> Oh, patches are always welcome! :)
>
> > How would I detect that? Add a size (in bytes) parameter for the total
> > source data?
>
> Sure.
>
> So, here's the deal: the more I look at this thing, the more I think
> this iosubmit_cmds512() function should not be in a generic header but
> in an intel-/driver-specific one. Why?
>
> Well, movdir64b is Intel-only for now, you don't have a fallback
> option for the platforms which do not support that insn and it is more
> preferential for you to do the feature check once at driver init and
> then call the function because you *know* you have movdir64b support
> and not have any feature check in the function itself, not even a fast
> static_cpu_has() one.
>
> And this way you can do away with alignment and size checks because you
> control what your driver does.
>
> If it turns out that this function needs to be shared with other
> platforms, then we can consider lifting it into a generic header and
> making it more generic.
>
> Ok?

I do agree that iosubmit_cmds512() can live in a driver specific
header, and it was my fault for advising Dave to make it generic. The
long story of how that came to pass below, but the short story is yes,
lets just make this one driver specific.

The long story is that there is already line of sight for a need for
other generic movdir64b() helpers as mentioned in the changelog, and
iosubmit_cmds512() got wrapped up in that momentum.

For those cases the thought would be to have memset512() for case1 and
__iowrite512_copy() for case3. Where memset512() writes a
non-incrementing source to an incrementing destination, and
__iowrite512_copy() copies an incrementing source to an incrementing
destination. Those 2 helpers *would* have fallbacks, but with the
option to use something like cpu_has_write512() to check in advance
whether those routines will fallback, or not.

That can be a discussion for a future patchset when those users arrive.
