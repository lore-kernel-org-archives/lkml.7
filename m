Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E15C47404
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 12:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29BA320CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 12:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ia+4efYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731822AbfILMzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 08:55:53 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45167 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731772AbfILMzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 08:55:53 -0400
Received: by mail-ot1-f68.google.com with SMTP id 41so22145451oti.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 05:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SA0xfHEl73cVGX1MjM/Dabo3xEg0AEW/0qWop8uz9YA=;
        b=ia+4efYainSNrLpJUrjMkW2nhrtb1w38p7/2I8Z7ekhZ9xbj34LdSP2wbQGECbPMM5
         D0AkTeRCyu7XhvDmCIH6QD7IJeTdLcXnatUH9H/V+kVJtYEHRKia2M+lfabN6httRtLR
         85oh+qLSjBiLok65jR8Lz60s3fPNzX0/PFmbJe0MwKdHPvqdqPjbX4W58k7WQ/OrlrA+
         kFdq3ZMfIwxaEvezTusWsefwBQDBMp+uspllUusUHOQS4n9dDz8S2mgTzCFSysZQmxne
         JY/erJdWEeUxArIUyMDiss1WmHUOj0l7PXGo/scJW+nkcFRVGW3cwBXWHT+y9K05Sew6
         DPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SA0xfHEl73cVGX1MjM/Dabo3xEg0AEW/0qWop8uz9YA=;
        b=KGGTO5s2Am3hv9H8wWztjQki2NNJBz1UqMjEO1xeaCt930mVLkPbD5zGKPCTxvxFqi
         /iFN348RrVgFS2L74bRYORwasSCDJoMXySm5ViacMSgR6GEwXQ5kuBWOiqzJFUv0mINs
         t7TWynATr2fYYHQbd/Iam2qKvHOnau2PIu100fgA+jOLiaZL+WC6+ZJw+60MntTDSJp9
         zC33bgSPGf7+B0cH3DvfZEw69nIW/pX2x+fmt8uE/VVSd/zsqHHZlf3/Q9g0bwhl+x9U
         cAUw3d3TkelGmgQQlhUTvkqfKIYq1kSUH0ZroLH1S6V5osExB3EJVlvqRFV5mh4fOZnL
         2tnQ==
X-Gm-Message-State: APjAAAUAVi3NO3GhJgV3PAypFWyMhuOJAfWUoeRoVWw8niosJ11APdfq
        rfGgJJ6PuTQ8L6e6GLm6bDOphn7fBUZNfTTw9tbhfA==
X-Google-Smtp-Source: APXvYqw621UBw4+uvQuQwVPgXEvBYaeM/FknFgeEhHnSJsaXx1aWbvzcH5iQylhNeKeowodBUDo39MW5LWQIfUdGPJM=
X-Received: by 2002:a9d:7e93:: with SMTP id m19mr8167394otp.283.1568292951564;
 Thu, 12 Sep 2019 05:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190912083649.4688-1-chunguo.feng@amlogic.com>
 <CAHUa44EEnBp5iaxWPzYyJyN0yuYFvmB44khtbz_Pi5F4P1_ufg@mail.gmail.com>
 <2019091218485411709620@amlogic.com> <CAHUa44GrtV6X5nct69cYD=Py2iOmhbTvzv-b2to18tPkpzKE+A@mail.gmail.com>
 <2019091219193038140730@amlogic.com>
In-Reply-To: <2019091219193038140730@amlogic.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 12 Sep 2019 14:55:40 +0200
Message-ID: <CAHUa44FQMW_pKduCwSWb9FrUh0qpvHna5j7R0RAbuAEZf95Mrw@mail.gmail.com>
Subject: Re: Re: [PATCH] tee: fix kasan check slab-out-of-bounds error.
To:     "chunguo.feng@amlogic.com" <chunguo.feng@amlogic.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gary,

On Thu, Sep 12, 2019 at 1:18 PM chunguo.feng@amlogic.com
<chunguo.feng@amlogic.com> wrote:
>
> Hi  Jens,
> Thanks for your reminder
>
> This issue can be reproduced easily. I have exectued tee_preload_fw, it was occured.  If not , it was not reporduced.
>
> Other, the place of slab-out-of-bounds was unchangeably when offs was set 0.

I'm sorry, I can't make sense of your patch. If it fixes the problem
for you it must be by pure chance. I'm pretty it will break a lot of
other cases.

Cheers,
Jens

>
> Thanks,
>
> BRs,
> Gary
>
>
> From: Jens Wiklander
> Date: 2019-09-12 19:01
> To: chunguo.feng@amlogic.com
> CC: linux-kernel@vger.kernel.org
> Subject: Re: Re: [PATCH] tee: fix kasan check slab-out-of-bounds error.
> On Thu, Sep 12, 2019 at 12:48 PM chunguo.feng@amlogic.com
> <chunguo.feng@amlogic.com> wrote:
> >
> > Hi Jens,
> >
> > Thanks for your comment.
> >
> > Refer to the current solution,   PC point was from optee_handle_rpc->tee_shm_get_pa.
> >
> > If offs was set 0,  pa was located other memory again, could you please kindly offer the better way?
>
> The entire range one piece of shared memory should be usable, so if
> kasan is upset then I guess that the shm has been corrupted in some
> way. I'm a bit puzzled because I can't see any access using the
> calculated physical address around this. Perhaps the problem occurred
> earlier and was just noticed now?
>
> >
> > In my options, offs should be set other location, other was offs of value set other limitiation?
>
> I'm sorry I don't understand. Offs is normally 0 to be able to access
> the shared memory from the start of the range.
>
> Cheers,
> Jens
>
> >
> > Thanks,
> >
> > BRs,
> > Gary.
> >
> >
> > From: Jens Wiklander
> > Date: 2019-09-12 18:04
> > To: chunguo feng
> > CC: Linux Kernel Mailing List
> > Subject: Re: [PATCH] tee: fix kasan check slab-out-of-bounds error.
> > Hi Chunguo,
> >
> > On Thu, Sep 12, 2019 at 10:36 AM chunguo feng <chunguo.feng@amlogic.com> wrote:
> > >
> > > From: fengchunguo <chunguo.feng@amlogic.com>
> > >
> > > Physical address should be set one shifting, but not cover shm struct data.
> > > If offs was set 0, it cause KASAN error.
> > >
> > > Log:
> > > [22.345259@0] BUG: KASAN: slab-out-of-bounds in optee_handle_rpc+0x644/0x858
> > > [22.352221@0] Read of size 4 at addr ffffffc0445485dc by task tee_preload_fw/2505
> > > [22.361280@0] CPU: 0 PID: 2505 Comm: tee_preload_fw Tainted: G    B   W  O
> > >                 4.19.53-01721-g11b1db7-dirty #417
> > > [22.376617@0] Call trace:
> > > [22.379220@0]  dump_backtrace+0x0/0x1b4
> > > [22.383003@0]  show_stack+0x20/0x28
> > > [22.386459@0]  dump_stack+0x8c/0xb4
> > > [22.389909@0]  print_address_description+0x10c/0x274
> > > [22.394819@0]  kasan_report+0x224/0x370
> > > [22.398616@0]  __asan_load4+0x6c/0x84
> > > [22.402238@0]  optee_handle_rpc+0x644/0x858
> > > [22.406375@0]  optee_do_call_with_arg+0x148/0x160
> > > [22.411033@0]  optee_open_session+0x1b0/0x340
> > > [22.415352@0]  tee_ioctl_open_session+0x28c/0x784
> > > [22.420006@0]  tee_ioctl+0x210/0x800
> > > [22.423546@0]  do_vfs_ioctl+0x104/0xe7c
> > > [22.427337@0]  __arm64_sys_ioctl+0xac/0xc0
> > > [22.431393@0]  invoke_syscall+0xd4/0xf4
> > > [22.435187@0]  el0_svc_common+0x88/0x128
> > > [22.439066@0]  el0_svc_handler+0x40/0x84
> > > [22.442947@0]  el0_svc+0x8/0xc
> > > [22.445962@0]
> > > [22.447602@0] Allocated by task 2508:
> > > [22.451231@0]  kasan_kmalloc.part.5+0x50/0x124
> > > [22.455627@0]  kasan_kmalloc+0xc4/0xe4
> > > [22.459334@0]  kmem_cache_alloc_trace+0x154/0x2bc
> > > [22.463994@0]  tee_shm_alloc+0xa0/0x340
> > > [22.467788@0]  tee_ioctl+0x39c/0x800
> > > [22.471324@0]  do_vfs_ioctl+0x104/0xe7c
> > > [22.475119@0]  __arm64_sys_ioctl+0xac/0xc0
> > > [22.479172@0]  invoke_syscall+0xd4/0xf4
> > > [22.482967@0]  el0_svc_common+0x88/0x128
> > > [22.486849@0]  el0_svc_handler+0x40/0x84
> > > [22.490728@0]  el0_svc+0x8/0xc
> > > [22.493743@0]
> > > [22.495384@0] Freed by task 0:
> > > [22.498408@0]  __kasan_slab_free+0x11c/0x21c
> > > [22.502631@0]  kasan_slab_free+0x10/0x18
> > > [22.506511@0]  kfree+0x8c/0x284
> > > [22.509625@0]  selinux_cred_free+0x48/0x64
> > > [22.513672@0]  security_cred_free+0x48/0x64
> > > [22.517817@0]  put_cred_rcu+0x3c/0x108
> > > [22.521523@0]  rcu_process_callbacks+0x308/0x7ac
> > > [22.526092@0]  __do_softirq+0x1c8/0x5c8
> > > [22.529882@0]
> > > [22.531527@0] The buggy address belongs to the object at ffffffc044548580
> > > [22.531527@0]  which belongs to the cache kmalloc-128 of size 128
> > > [22.544291@0] The buggy address is located 92 bytes inside of
> > > [22.544291@0]  128-byte region [ffffffc044548580, ffffffc044548600)
> > > [22.556190@0] The buggy address belongs to the page:
> > > [22.561110@0] page:ffffffbf01115200 count:1 mapcount:0 mapping:ffffffc04540c400 index:0x0 compound_mapcount: 0
> > > [22.571029@0] flags: 0x20094e4b00010200(slab|head)
> > > [22.575780@0] raw: 20094e4b00010200 ffffffbf01113408 ffffffbf01119508 ffffffc04540c400
> > > [22.583622@0] raw: 0000000000000000 0000000000190019 00000001ffffffff 0000000000000000
> > > [22.591466@0] page dumped because: kasan: bad access detected
> > > [22.597157@0]
> > > [22.598797@0] Memory state around the buggy address:
> > > [22.603719@0]  ffffffc044548480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > > [22.611048@0]  ffffffc044548500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > > [22.618379@0] >ffffffc044548580: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
> > > [22.625707@0]                                                     ^
> > > [22.631920@0]  ffffffc044548600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > > [22.639251@0]  ffffffc044548680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > > [22.646580@0] ==================================================================
> > >
> > > Test:
> > > 1. Set offs range,then test tee_preload successfully.
> > > / # tee_preload_fw
> > > use default tee_preload_fw pathfw_path=/lib/firmware/video/video_ucode.bin
> > > tee preload video fw ok
> > > / # echo $?
> > > 0
> > >
> > > Signed-off-by: fengchunguo <chunguo.feng@amlogic.com>
> > > ---
> > >  drivers/tee/tee_shm.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > > index 0b9ab1d0dd45..585361cd8dd9 100644
> > > --- a/drivers/tee/tee_shm.c
> > > +++ b/drivers/tee/tee_shm.c
> > > @@ -461,7 +461,7 @@ int tee_shm_get_pa(struct tee_shm *shm, size_t offs, phys_addr_t *pa)
> > >         if (offs >= shm->size)
> > >                 return -EINVAL;
> > >         if (pa)
> > > -               *pa = shm->paddr + offs;
> > > +               *pa = shm->paddr + shm->size;
> >
> > This can't be right, "offs" is used to calculate the physical address
> > from the start of a shared memory range.
> > With this you're ignoring "offs" and always return past the end of the
> > region. I don't see how that can help.
> >
> > Cheers,
> > Jens
> >
> > >         return 0;
> > >  }
> > >  EXPORT_SYMBOL_GPL(tee_shm_get_pa);
> > > --
> > > 2.22.0
> > >
> >
>
