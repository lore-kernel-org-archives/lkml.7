Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE173C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7872220674
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="yD+EKeum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbfDPSy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:54:27 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36330 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfDPSy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:54:26 -0400
Received: by mail-ot1-f65.google.com with SMTP id o74so18516755ota.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 11:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EeNUxDh1Z4rgIbmhy0YqlnrE8GEGGuf75X3wDbU1tvQ=;
        b=yD+EKeummZuJ3ulm8hxQNqIv952geApEoWYVLRDROeswjTTEbF2K3l1WdBip8af3UM
         NPU4jzaL9mJM/tVXIXTvxS84bb0PYN2WJm0yhhhrW1C8It4YSTtIJcLmV2aR9gvRQlES
         Vmh6fwAp/TlYOS9LESqWFuNYAusP22lYLbzf1q9oEirXt1+yJCxGG2bNoq9IK1gBPUcg
         nHxzU++uglu/GpJLAkWF3Qvc3tJmyfbVzwIMH/ELYp/eXoVEHwr189RYFR/G+cT0G60d
         IkBlTfJWH5po9JZVLEF3zJFpThfssX+0JjnqKAXeG99djeL3lP6RkZJbkAjyeyRo5eGo
         pXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EeNUxDh1Z4rgIbmhy0YqlnrE8GEGGuf75X3wDbU1tvQ=;
        b=O/tiS1ei32vBqE9Gv5EORcFaLkYjamHXZe8HMjnzaic3KJQNt6jfbfOBcNLwo5AAlO
         ygWF1rUdSDcTyR2rrlBF1LwFy1kiyFBHPpnPsrSxTeMw5t84GzW0jiFDWw2jZgUEWXW8
         pRCqkCN7SSzaGpbwI5dOHp65RjFB8lCnHs4heEo5zrFIADYqxb7KxWWBGDg+0j1bFj9B
         Hbpo9r47wgb+tXGbVsiNxD73JJqMOB6DEp4/waSxCFqcPF1DwI0J7uZYuuhQMbSmherE
         9ltOKC8rXS831kDYtYVgMHbvZsbBClnP5/S4QZ6Ka0w4fLRLexI5tSPuVCDUHFgGVtnm
         3CdQ==
X-Gm-Message-State: APjAAAUkgqdQ96LgKtndR95JjlcsfwSoiv7iYt6fMAgOHhczAmN/78SG
        Jxr2/CGVm092Qnj2j08mqsogCboF4PdFV2jmzpPA/A==
X-Google-Smtp-Source: APXvYqxdmRQ0ZvCP7MGDxhdMGMXmtkdJ6R5e0tpU8HYYWcp0IhZ1Ml7pjyyCljd55voTnY5zNBZluQC99HrPjptTfF4=
X-Received: by 2002:a9d:5c86:: with SMTP id a6mr50230698oti.118.1555440865341;
 Tue, 16 Apr 2019 11:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190215185151.GG7897@sirena.org.uk> <20190226155948.299aa894a5576e61dda3e5aa@linux-foundation.org>
 <CAPcyv4ivjC8fNkfjdFyaYCAjGh7wtvFQnoPpOcR=VNZ=c6d6Rg@mail.gmail.com>
 <20190228151438.fc44921e66f2f5d393c8d7b4@linux-foundation.org>
 <CAPcyv4hDmmK-L=0txw7L9O8YgvAQxZfVFiSoB4LARRnGQ3UC7Q@mail.gmail.com>
 <026b5082-32f2-e813-5396-e4a148c813ea@collabora.com> <20190301124100.62a02e2f622ff6b5f178a7c3@linux-foundation.org>
 <3fafb552-ae75-6f63-453c-0d0e57d818f3@collabora.com> <CAPcyv4hMNiiM11ULjbOnOf=9N=yCABCRsAYLpjXs+98bRoRpCA@mail.gmail.com>
 <36faea07-139c-b97d-3585-f7d6d362abc3@collabora.com> <20190306140529.GG3549@rapoport-lnx>
 <21d138a5-13e4-9e83-d7fe-e0639a8d180a@collabora.com> <CAPcyv4jBjUScKExK09VkL8XKibNcbw11ET4WNUWUWbPXeT9DFQ@mail.gmail.com>
 <CAGXu5jLAPKBE-EdfXkg2AK5P=qZktW6ow4kN5Yzc0WU2rtG8LQ@mail.gmail.com>
 <CABXOdTdVvFn=Nbd_Anhz7zR1H-9QeGByF3HFg4ZFt58R8=H6zA@mail.gmail.com>
 <CAGXu5j+Sw2FyMc8L+8hTpEKbOsySFGrCmFtVP5gt9y2pJhYVUw@mail.gmail.com>
 <CABXOdTcXWf9iReoocaj9rZ7z17zt-62iPDuvQQSrQRtMeeZNiA@mail.gmail.com>
 <CAPcyv4i8xhA6B5e=YBq2Z5kooyUpYZ8Bv9qov-mvqm4Uz=KLWQ@mail.gmail.com> <CABXOdTc5=J7ZFgbiwahVind-SNt7+G_-TVO=v-Y5SBVPLdUFog@mail.gmail.com>
In-Reply-To: <CABXOdTc5=J7ZFgbiwahVind-SNt7+G_-TVO=v-Y5SBVPLdUFog@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 16 Apr 2019 11:54:13 -0700
Message-ID: <CAPcyv4gxk9xbsP3YSKzxu5Yp9FTefyxHc6xC33GwZ3Zf9_eeKA@mail.gmail.com>
Subject: Re: next/master boot bisection: next-20190215 on beaglebone-black
To:     Guenter Roeck <groeck@google.com>
Cc:     Kees Cook <keescook@chromium.org>, kernelci@groups.io,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Mark Brown <broonie@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Matt Hart <matthew.hart@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Kevin Hilman <khilman@baylibre.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
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

On Thu, Apr 11, 2019 at 1:54 PM Guenter Roeck <groeck@google.com> wrote:
[..]
> > > Boot tests report
> > >
> > > Qemu test results:
> > >     total: 345 pass: 345 fail: 0
> > >
> > > This is on top of next-20190410 with CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
> > > and the known crashes fixed.
> >
> > In addition to CONFIG_SHUFFLE_PAGE_ALLOCATOR=y you also need the
> > kernel command line option "page_alloc.shuffle=1"
> >
> > ...so I doubt you are running with shuffling enabled. Another way to
> > double check is:
> >
> >    cat /sys/module/page_alloc/parameters/shuffle
>
> Yes, you are right. Because, with it enabled, I see:
>
> Kernel command line: rdinit=/sbin/init page_alloc.shuffle=1 panic=-1
> console=ttyAMA0,115200 page_alloc.shuffle=1
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 0 at ./include/linux/jump_label.h:303
> page_alloc_shuffle+0x12c/0x1ac
> static_key_enable(): static key 'page_alloc_shuffle_key+0x0/0x4' used
> before call to jump_label_init()

This looks to be specific to ARM never having had to deal with
DEFINE_STATIC_KEY_TRUE in the past.

I am able to avoid this warning by simply not enabling JUMP_LABEL
support in my build.

> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper Not tainted
> 5.1.0-rc4-next-20190410-00003-g3367c36ce744 #1
> Hardware name: ARM Integrator/CP (Device Tree)
> [<c0011c68>] (unwind_backtrace) from [<c000ec48>] (show_stack+0x10/0x18)
> [<c000ec48>] (show_stack) from [<c07e9710>] (dump_stack+0x18/0x24)
> [<c07e9710>] (dump_stack) from [<c001bb1c>] (__warn+0xe0/0x108)
> [<c001bb1c>] (__warn) from [<c001bb88>] (warn_slowpath_fmt+0x44/0x6c)
> [<c001bb88>] (warn_slowpath_fmt) from [<c0b0c4a8>]
> (page_alloc_shuffle+0x12c/0x1ac)
> [<c0b0c4a8>] (page_alloc_shuffle) from [<c0b0c550>] (shuffle_store+0x28/0x48)
> [<c0b0c550>] (shuffle_store) from [<c003e6a0>] (parse_args+0x1f4/0x350)
> [<c003e6a0>] (parse_args) from [<c0ac3c00>] (start_kernel+0x1c0/0x488)
> [<c0ac3c00>] (start_kernel) from [<00000000>] (  (null))
>
> I'll re-run the test, but I suspect it will drown in warnings.

I slogged through getting a Beagle Bone Black up and running with a
Yocto build and it is not failing. I have tried apply the patches on
top of v5.1-rc5 as well as re-testing next-20190215 label, no
reproduction. The shuffle appears to avoid anything sensitive by
default, below are the shuffle actions that were taken relative to
iomem. Can someone with a failure reproduction please send me more
details about their configuration? It would also help to get a failing
boot log with the pr_debug() statements in mm/shuffle.c enabled to see
if the failure is correlated with any unexpected shuffle actions.

80000000-9fffffff : System RAM
  80008000-809fffff : Kernel code
  80b00000-812be523 : Kernel data

[    0.086469] __shuffle_zone: swap: 0x81800 -> 0x99800
[    0.086558] __shuffle_zone: swap: 0x82000 -> 0x88800
[    0.086575] __shuffle_zone: swap: 0x82800 -> 0x89800
[    0.086591] __shuffle_zone: swap: 0x83000 -> 0x89000
[    0.086606] __shuffle_zone: swap: 0x83800 -> 0x8a800
[    0.086621] __shuffle_zone: swap: 0x84000 -> 0x93800
[    0.086636] __shuffle_zone: swap: 0x84800 -> 0x83000
[    0.086651] __shuffle_zone: swap: 0x85000 -> 0x8f000
[    0.086666] __shuffle_zone: swap: 0x85800 -> 0x88000
[    0.086689] __shuffle_zone: swap: 0x86000 -> 0x84000
[    0.086704] __shuffle_zone: swap: 0x86800 -> 0x8c800
[    0.086719] __shuffle_zone: swap: 0x87000 -> 0x93000
[    0.086735] __shuffle_zone: swap: 0x87800 -> 0x94000
[    0.086751] __shuffle_zone: swap: 0x88000 -> 0x90800
[    0.086766] __shuffle_zone: swap: 0x88800 -> 0x9d000
[    0.086781] __shuffle_zone: swap: 0x89000 -> 0x82800
[    0.086796] __shuffle_zone: swap: 0x89800 -> 0x95800
[    0.086811] __shuffle_zone: swap: 0x8a000 -> 0x98000
[    0.086826] __shuffle_zone: swap: 0x8a800 -> 0x89000
[    0.086842] __shuffle_zone: swap: 0x8b000 -> 0x81800
[    0.086857] __shuffle_zone: swap: 0x8b800 -> 0x88800
[    0.086872] __shuffle_zone: swap: 0x8c000 -> 0x8a000
[    0.086891] __shuffle_zone: swap: 0x8c800 -> 0x84800
[    0.086906] __shuffle_zone: swap: 0x8d000 -> 0x95000
[    0.086921] __shuffle_zone: swap: 0x8d800 -> 0x8d000
[    0.086935] __shuffle_zone: swap: 0x8e000 -> 0x8e800
[    0.086950] __shuffle_zone: swap: 0x8e800 -> 0x99000
[    0.086964] __shuffle_zone: swap: 0x8f000 -> 0x8d000
[    0.086979] __shuffle_zone: swap: 0x90000 -> 0x91000
[    0.086994] __shuffle_zone: swap: 0x90800 -> 0x83000
[    0.087009] __shuffle_zone: swap: 0x91000 -> 0x91800
[    0.087025] __shuffle_zone: swap: 0x91800 -> 0x8d800
[    0.087040] __shuffle_zone: swap: 0x92000 -> 0x86800
[    0.087054] __shuffle_zone: swap: 0x92800 -> 0x92000
[    0.087070] __shuffle_zone: swap: 0x93000 -> 0x91000
[    0.087088] __shuffle_zone: swap: 0x93800 -> 0x85000
[    0.087103] __shuffle_zone: swap: 0x94000 -> 0x8b800
[    0.087117] __shuffle_zone: swap: 0x94800 -> 0x96000
[    0.087132] __shuffle_zone: swap: 0x95000 -> 0x91000
[    0.087147] __shuffle_zone: swap: 0x95800 -> 0x8e000
[    0.087161] __shuffle_zone: swap: 0x96000 -> 0x95800
[    0.087179] __shuffle_zone: swap: 0x96800 -> 0x8c800
[    0.087193] __shuffle_zone: swap: 0x97000 -> 0x89000
[    0.087208] __shuffle_zone: swap: 0x97800 -> 0x85000
[    0.087224] __shuffle_zone: swap: 0x98000 -> 0x85000
[    0.087239] __shuffle_zone: swap: 0x98800 -> 0x93000
[    0.087255] __shuffle_zone: swap: 0x99000 -> 0x94800
[    0.087269] __shuffle_zone: swap: 0x99800 -> 0x94000
