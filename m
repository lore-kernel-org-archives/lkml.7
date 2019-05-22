Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335A1C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29062177E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y8j7WD6z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbfEVUrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 16:47:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33824 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729961AbfEVUrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 16:47:39 -0400
Received: by mail-pl1-f196.google.com with SMTP id w7so1633014plz.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 13:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zy3PazUIRm9Jc9PdJuB2u+ElFTk96lbYpo+oNBJZGCM=;
        b=Y8j7WD6zpcc/2sEpj8EY6NRT1Dc510C1spsir21/hkUeu4mUUaoDDgjLww0pivEwF/
         z6iJ0+f+gBw8re6q5xM6Dar0lLD7YYS2gJO3KPMVbNBtZ3Id3RkPfmb6s3Yr3rdRIcuf
         rTPZw7otg9Z5O5b4Ojw+hEe7n4misMdps/iC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zy3PazUIRm9Jc9PdJuB2u+ElFTk96lbYpo+oNBJZGCM=;
        b=Aib7jRAFnWg7LzENTFkJPN7OGjqAuYZFj4VKyPWx3zMXo/puUZVos5p90L4UYNjCCx
         QZ+LKKFIgfbb//16nytdz5l0hLev14br0xXlsUSSg5Z+upbeXfcXC6jkhAlACACEDr6/
         HwpxlZqaApWJrJJ6FIo7JCN5ZEFTHPqwcCHlL4uxF274hhebcgoLFZWrDsOXTW0VczF7
         nCxT5jHTy0fdjlQHNMv/gUwrby1YromCMD77Mqyxnp7xRJMgzOJhpkQi5Fh682fVByec
         UW+jraPxbFmntk2HaDuv744C6OuU55qe95VX3ArWYm0mbwqcccBhDd/0kImDom2h6aeF
         WhwA==
X-Gm-Message-State: APjAAAWXUHubvDCDQa9I0ouVE0q/sM8i0bTzD/ZmnVwK9EJPB3n4yv/u
        HITYFyCXNJmxYqQNu0n9PDsfPQ==
X-Google-Smtp-Source: APXvYqxzAX+RobICkloaWYce4rx4oMkBv2QD394+NKxfoEao6LHAAvOlkD0rcjglQVK68ClP6ctquQ==
X-Received: by 2002:a17:902:15c5:: with SMTP id a5mr93624265plh.39.1558558058259;
        Wed, 22 May 2019 13:47:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d13sm23312074pfh.113.2019.05.22.13.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 13:47:37 -0700 (PDT)
Date:   Wed, 22 May 2019 13:47:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     enh <enh@google.com>, Evgenii Stepanov <eugenis@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        kvm@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Subject: Re: [PATCH v15 00/17] arm64: untag user pointers passed to the kernel
Message-ID: <201905221316.865581CF@keescook>
References: <cover.1557160186.git.andreyknvl@google.com>
 <20190517144931.GA56186@arrakis.emea.arm.com>
 <CAFKCwrj6JEtp4BzhqO178LFJepmepoMx=G+YdC8sqZ3bcBp3EQ@mail.gmail.com>
 <20190521182932.sm4vxweuwo5ermyd@mbp>
 <201905211633.6C0BF0C2@keescook>
 <20190522101110.m2stmpaj7seezveq@mbp>
 <CAJgzZoosKBwqXRyA6fb8QQSZXFqfHqe9qO9je5TogHhzuoGXJQ@mail.gmail.com>
 <20190522163527.rnnc6t4tll7tk5zw@mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522163527.rnnc6t4tll7tk5zw@mbp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 05:35:27PM +0100, Catalin Marinas wrote:
> The two hard requirements I have for supporting any new hardware feature
> in Linux are (1) a single kernel image binary continues to run on old
> hardware while making use of the new feature if available and (2) old
> user space continues to run on new hardware while new user space can
> take advantage of the new feature.

Agreed! And I think the series meets these requirements, yes?

> For MTE, we just can't enable it by default since there are applications
> who use the top byte of a pointer and expect it to be ignored rather
> than failing with a mismatched tag. Just think of a hwasan compiled
> binary where TBI is expected to work and you try to run it with MTE
> turned on.

Ah! Okay, here's the use-case I wasn't thinking of: the concern is TBI
conflicting with MTE. And anything that starts using TBI suddenly can't
run in the future because it's being interpreted as MTE bits? (Is that
the ABI concern? I feel like we got into the weeds about ioctl()s and
one-off bugs...)

So there needs to be some way to let the kernel know which of three
things it should be doing:
1- leaving userspace addresses as-is (present)
2- wiping the top bits before using (this series)
3- wiping the top bits for most things, but retaining them for MTE as
   needed (the future)

I expect MTE to be the "default" in the future. Once a system's libc has
grown support for it, everything will be trying to use MTE. TBI will be
the special case (but TBI is effectively a prerequisite).

AFAICT, the only difference I see between 2 and 3 will be the tag handling
in usercopy (all other places will continue to ignore the top bits). Is
that accurate?

Is "1" a per-process state we want to keep? (I assume not, but rather it
is available via no TBI/MTE CONFIG or a boot-time option, if at all?)

To choose between "2" and "3", it seems we need a per-process flag to
opt into TBI (and out of MTE). For userspace, how would a future binary
choose TBI over MTE? If it's a library issue, we can't use an ELF bit,
since the choice may be "late" after ELF load (this implies the need
for a prctl().) If it's binary-only ("built with HWKASan") then an ELF
bit seems sufficient. And without the marking, I'd expect the kernel to
enforce MTE when there are high bits.

> I would also expect the C library or dynamic loader to check for the
> presence of a HWCAP_MTE bit before starting to tag memory allocations,
> otherwise it would get SIGILL on the first MTE instruction it tries to
> execute.

I've got the same question as Elliot: aren't MTE instructions just NOP
to older CPUs? I.e. if the CPU (or kernel) don't support it, it just
gets entirely ignored: checking is only needed to satisfy curiosity
or behavioral expectations.

To me, the conflict seems to be using TBI in the face of expecting MTE to
be the default state of the future. (But the internal changes needed
for TBI -- this series -- is a prereq for MTE.)

-- 
Kees Cook
