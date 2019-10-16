Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3837FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC012168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GVaH1QP9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391288AbfJPPnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 11:43:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34363 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbfJPPnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:43:09 -0400
Received: by mail-lj1-f195.google.com with SMTP id j19so24558369lja.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 08:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QeqGb38nou+CUua7H0tNVsw7j00ya/FpEqqjOhe3ueE=;
        b=GVaH1QP9UOoOYeUbamoHn42dSMeY6iwWUPIzPWGWMtBv+Dz4nvrI9E3mETBnAni+FU
         Izf2uj7TozLnDGFsViAzRH5E5P9lRykxkWZQxW4jNbamOx8Pwj0nhzog9wEMwwf7h3+1
         TAVixD/gVp4y+zhTqAZ2kCc70Y+hG1Vcf05E5xrBV7rxLcVGDNLnedYxOnlVXY4AFvFp
         HPjjoKVRNRPJTlLxMCr9sfIG/pBbDtAoFajV0bcDAmh0DkSu7ZgbNySCWdk9+XUPs8Om
         EinmHfDMTwgyD83GTK/OCBHdWw4FS4RANsM/37w2QgaHo74SkGBgSacUT5xcjcsqkNue
         Mjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QeqGb38nou+CUua7H0tNVsw7j00ya/FpEqqjOhe3ueE=;
        b=QxgJkeVqhnNnaGHYZJNmTnAb5DqUZDsunimj64JKmTeCb/JGfKTd+3L4aNCqpbttbu
         0kLoi0zyU0qCRZfrHgwAM9bNjt+nRHE4EkUz+3TnJfWzuM3jxtR+K3pkxMTX55CEzhzv
         bUXd6xwISYPhrVJn91IXXU5EVWKtAnhwRqjrO29Pxv1XVPAhRimfoQDMn10TexDcqaNU
         BZqh6VSXXFwudFVhg2yssJq9az5V2gavunWcKBQmDykt8qBpxLt57kbdntUdzx77B9IU
         CbBXKpb6MWAqlrY+g17kEETc1+N4kgh7dkN92OgdNqBdxQkRRPLlUWZPJL2OnT0rK4tK
         kFug==
X-Gm-Message-State: APjAAAUaVrmd03Y5Fur7zbyrfpYlb59/1My9dk7ByL8GS86kTGXP4K8c
        2UtfTUo7pxTQv3V+OUTd4EMLznRmIabCc4R41x632g==
X-Google-Smtp-Source: APXvYqwfVkyBVf9Gcz5SLet11Xgcyz7eXQvQnjb1yZRklRq/5kKYUDGlrdEABoVnDojKHa0a21jdyHcz+Yf3yZkM3Lc=
X-Received: by 2002:a2e:9b02:: with SMTP id u2mr26382578lji.18.1571240586761;
 Wed, 16 Oct 2019 08:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <20191016150119.154756-1-jannh@google.com>
In-Reply-To: <20191016150119.154756-1-jannh@google.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Wed, 16 Oct 2019 08:42:55 -0700
Message-ID: <CAHRSSEwGqM84KA-V-V384RNQFRJbj2SHMy_8-D9mnO9=8noZ3Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] binder: Don't modify VMA bounds in ->mmap handler
To:     Jann Horn <jannh@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 8:01 AM Jann Horn <jannh@google.com> wrote:
>
> binder_mmap() tries to prevent the creation of overly big binder mappings
> by silently truncating the size of the VMA to 4MiB. However, this violates
> the API contract of mmap(). If userspace attempts to create a large binder
> VMA, and later attempts to unmap that VMA, it will call munmap() on a range
> beyond the end of the VMA, which may have been allocated to another VMA in
> the meantime. This can lead to userspace memory corruption.
>
> The following sequence of calls leads to a segfault without this commit:
>
> int main(void) {
>   int binder_fd = open("/dev/binder", O_RDWR);
>   if (binder_fd == -1) err(1, "open binder");
>   void *binder_mapping = mmap(NULL, 0x800000UL, PROT_READ, MAP_SHARED,
>                               binder_fd, 0);
>   if (binder_mapping == MAP_FAILED) err(1, "mmap binder");
>   void *data_mapping = mmap(NULL, 0x400000UL, PROT_READ|PROT_WRITE,
>                             MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
>   if (data_mapping == MAP_FAILED) err(1, "mmap data");
>   munmap(binder_mapping, 0x800000UL);
>   *(char*)data_mapping = 1;
>   return 0;
> }
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder.c       | 7 -------
>  drivers/android/binder_alloc.c | 6 ++++--
>  2 files changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 5b9ac2122e89..265d9dd46a5e 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -97,10 +97,6 @@ DEFINE_SHOW_ATTRIBUTE(proc);
>  #define SZ_1K                               0x400
>  #endif
>
> -#ifndef SZ_4M
> -#define SZ_4M                               0x400000
> -#endif
> -
>  #define FORBIDDEN_MMAP_FLAGS                (VM_WRITE)
>
>  enum {
> @@ -5177,9 +5173,6 @@ static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
>         if (proc->tsk != current->group_leader)
>                 return -EINVAL;
>
> -       if ((vma->vm_end - vma->vm_start) > SZ_4M)
> -               vma->vm_end = vma->vm_start + SZ_4M;
> -
>         binder_debug(BINDER_DEBUG_OPEN_CLOSE,
>                      "%s: %d %lx-%lx (%ld K) vma %lx pagep %lx\n",
>                      __func__, proc->pid, vma->vm_start, vma->vm_end,
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index d42a8b2f636a..eb76a823fbb2 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -22,6 +22,7 @@
>  #include <asm/cacheflush.h>
>  #include <linux/uaccess.h>
>  #include <linux/highmem.h>
> +#include <linux/sizes.h>
>  #include "binder_alloc.h"
>  #include "binder_trace.h"
>
> @@ -689,7 +690,9 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
>         alloc->buffer = (void __user *)vma->vm_start;
>         mutex_unlock(&binder_alloc_mmap_lock);
>
> -       alloc->pages = kcalloc((vma->vm_end - vma->vm_start) / PAGE_SIZE,
> +       alloc->buffer_size = min_t(unsigned long, vma->vm_end - vma->vm_start,
> +                                  SZ_4M);
> +       alloc->pages = kcalloc(alloc->buffer_size / PAGE_SIZE,
>                                sizeof(alloc->pages[0]),
>                                GFP_KERNEL);
>         if (alloc->pages == NULL) {
> @@ -697,7 +700,6 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
>                 failure_string = "alloc page array";
>                 goto err_alloc_pages_failed;
>         }
> -       alloc->buffer_size = vma->vm_end - vma->vm_start;
>
>         buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
>         if (!buffer) {
> --
> 2.23.0.700.g56cf767bdb-goog
>
