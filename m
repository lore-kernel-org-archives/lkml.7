Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95A2C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF0A20896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QkhZMvI8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438269AbfFLLOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 07:14:43 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41300 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbfFLLOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 07:14:42 -0400
Received: by mail-pl1-f195.google.com with SMTP id s24so6495777plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 04:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ICAcqmNM80YqXGU9u0yKcUq/onm/SsQo2SDs/l3f+hY=;
        b=QkhZMvI8xgho9eMFZ7w6J/3duhWcdGLEkVVUAU2qSaxNfXU+GXLc+PdiUdCpUn61iY
         0xCUxQ9wiA1Jj7ZnvEwSzmljdVe71a10tK0t/VIk6vJ6KuoIESh9plrNP00oJ9EUV9CE
         7ZXKJL/NmCDrLh5D1fRV3U/5XcSqnaFIYrJ7IhnmnWDC1y2ZQhZMwMFDrVZ4wkPjj2PR
         KjnNxVxOeNHsZ1yb6hgnM2H6TbZTzWPz9Cffq6e0f9rEpBuiI2bynmdfsgpQFhae4y5r
         LLRsk0MnIrY8OwbkGOOGkhYBEu+P7mFEBBswTcH9Mhn9r0qq9AEF/SsRyiNTxER5NtY3
         eTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ICAcqmNM80YqXGU9u0yKcUq/onm/SsQo2SDs/l3f+hY=;
        b=ns1IWIW7mvU6310j0bBYe1QefotPWc+vnl2uZZ1Hfi5s/mQPNUlmXVpkQxbNottLqV
         XcpSsubaqIyPyorHTLw0VcU4RG3TY8VbFsJd1bAKOwwurkfZqjBxmb+AdapOjSfFUVwh
         m5sY/JVjT+vdjA3/3p9WZOaOkU6WmwEbkY+RvnQZAe68eqcyVfBvRbu5eiuuvyklnqfg
         rE5vkHSKKHZuMspB33PXQ7NQVBFuA3YSLZ4w0HRmz8X/0OVJagfE3YjD2wS8mbu4Scq3
         eg+fSha/cHMMyixZmSXaKS7yTVTOmeXsgW96+9TpcsYdLkm7vgm7MJRXPYDjg7U+t6on
         x26g==
X-Gm-Message-State: APjAAAUT9aFWzm4MnEJOy6ynEmR165NNNftScSHRYOpHNJkuPILrJcSO
        8yhMOndXHf/S9lvFd77pP0Wc5sUVcT8Ycwj1/hHI81lZiRI=
X-Google-Smtp-Source: APXvYqygEZ27HGfNqszCpdSgojAf7S6ru14/DaT8Or0Syv3FL9sWDfZ+9LXBU0/5Hxbzx8tkSmaHaZjTcL+f/jghf7s=
X-Received: by 2002:a17:902:8609:: with SMTP id f9mr75570344plo.252.1560338081704;
 Wed, 12 Jun 2019 04:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559580831.git.andreyknvl@google.com> <9e1b5998a28f82b16076fc85ab4f88af5381cf74.1559580831.git.andreyknvl@google.com>
 <20190611150122.GB63588@arrakis.emea.arm.com> <CAAeHK+wZrVXxAnDXBjoUy8JK9iG553G2Bp8uPWQ0u1u5gts0vQ@mail.gmail.com>
 <20190611175037.pflr6q6ob67zjj25@mbp>
In-Reply-To: <20190611175037.pflr6q6ob67zjj25@mbp>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 12 Jun 2019 13:14:30 +0200
Message-ID: <CAAeHK+x4sHKfQx31uQ9zSO48oRs3XLATfymY=vgEHQ1FLNmeig@mail.gmail.com>
Subject: Re: [PATCH v16 16/16] selftests, arm64: add a selftest for passing
 tagged pointers to kernel
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
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
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>, enh <enh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 7:50 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, Jun 11, 2019 at 07:18:04PM +0200, Andrey Konovalov wrote:
> > On Tue, Jun 11, 2019 at 5:01 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > static void *tag_ptr(void *ptr)
> > > {
> > >         static int tagged_addr_err = 1;
> > >         unsigned long tag = 0;
> > >
> > >         if (tagged_addr_err == 1)
> > >                 tagged_addr_err = prctl(PR_SET_TAGGED_ADDR_CTRL,
> > >                                         PR_TAGGED_ADDR_ENABLE, 0, 0, 0);
> >
> > I think this requires atomics. malloc() can be called from multiple threads.
>
> It's slightly racy but I assume in a real libc it can be initialised
> earlier than the hook calls while still in single-threaded mode (I had
> a quick attempt with __attribute__((constructor)) but didn't get far).
>
> Even with the race, under normal circumstances calling the prctl() twice
> is not a problem. I think the risk here is that someone disables the ABI
> via sysctl and the ABI is enabled for some of the threads only.

OK, I'll keep the code racy, but add a comment pointing it out. Thanks!

>
> --
> Catalin
