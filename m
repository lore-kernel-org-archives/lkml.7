Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A743C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 14:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A52E20656
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 14:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bChcCUJS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfDVOtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 10:49:42 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33549 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfDVOtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 10:49:42 -0400
Received: by mail-lf1-f66.google.com with SMTP id j11so9167492lfm.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 07:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cJLRMY/oIZc38KiECWt7WRN1sjpvQPsGESgz1EIgkGI=;
        b=bChcCUJSbHp0wn7bjv2f3rtedvO2/k7boQbST3NORgZ3Xtz2+gbWV4Z65aSsDXBr8y
         V1sL3ZvatxCU9M7kStI3fSRy5PAm7CIeXV/PPL1EOjxLEy0GKAol1bjdV4s4tV5ozc+/
         7SYRroKoTCJZaMETi3JmkMW7VF3LbYMeuMm3gkBZeglDVZo7EewlvUY4eptmCb0dMfm8
         yLsjGKEc8zOFlUaxsKJwp7u87IYQ7rBjh47d+NgKJ33Q+jvgwpGHrvz77oP68dciBuqE
         dXiaY3gkQMc9wz5dJRU1OuBdZy6BCkqWShUzYC0KrS3QaAEgBgXdwByCZ+1fCoiQrQ+c
         HHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cJLRMY/oIZc38KiECWt7WRN1sjpvQPsGESgz1EIgkGI=;
        b=tGiG0wW1CN4THw4ITu2Mtkp8+voR6vhXFUMlk1yPiPu9FBwTJ+0rQMxaV2KjG2vch5
         Sn1F/L/v1fpWTpQ+z6DTitqVrrdBifGJlhIjNw+t6n/u5eX6iFa2taDZSPcIHqA80WJ9
         nYVh8wfWDNE0XLoEGetfO2Zpgp6jg9rCSYy/QfWMdNLMVcvE0lIAEefhntT8qUfuOBQ1
         JwD+kme4Jxf3apXMZJq/oaEE5al8xMTfoPjURNJnVJ/WqP+EO2pM4wq2AOX3zsg3wgjK
         HX7QEFhnVWr6kbCCQoWiQs5vbQPhdX87mtZFem24kP62nY5J4Xm+XmftczIj301aXuIf
         0/wA==
X-Gm-Message-State: APjAAAV2YCyuojCaJjOQj6mgasOc8dWmw2JZBkRyI2CwwTk51+nhkpm8
        Dyn69meiHV9azNOyt623CX9VeoJTUhPEw9gSypMXCg==
X-Google-Smtp-Source: APXvYqxCcSNezg2tXXk2/tmb1td6+fCll/2dTVwk9xtk9mByMXMRYprY0j6RBnuHwY0+w+PsNXY+UGhfRIanNSCCS8A=
X-Received: by 2002:ac2:5582:: with SMTP id v2mr10341217lfg.19.1555944579370;
 Mon, 22 Apr 2019 07:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <1555106365-26137-1-git-send-email-tyhicks@canonical.com>
In-Reply-To: <1555106365-26137-1-git-send-email-tyhicks@canonical.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Mon, 22 Apr 2019 07:49:28 -0700
Message-ID: <CAHRSSEymaMf1qVJUnTrFT9iujbc44qN8eaQS0TkO639SgNJc8g@mail.gmail.com>
Subject: Re: [PATCH] binder: take read mode of mmap_sem in binder_alloc_free_page()
To:     Tyler Hicks <tyhicks@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Minchan Kim <minchan@kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 2:59 PM Tyler Hicks <tyhicks@canonical.com> wrote:
>
> Restore the behavior of locking mmap_sem for reading in
> binder_alloc_free_page(), as was first done in commit 3013bf62b67a
> ("binder: reduce mmap_sem write-side lock"). That change was
> inadvertently reverted by commit 5cec2d2e5839 ("binder: fix race between
> munmap() and direct reclaim").
>
> In addition, change the name of the label for the error path to
> accurately reflect that we're taking the lock for reading.
>
> Backporting note: This fix is only needed when *both* of the commits
> mentioned above are applied. That's an unlikely situation since they
> both landed during the development of v5.1 but only one of them is
> targeted for stable.
>
> Fixes: 5cec2d2e5839 ("binder: fix race between munmap() and direct reclaim")
> Signed-off-by: Tyler Hicks <tyhicks@canonical.com>


Thanks for fixing this up.

Acked-by: Todd Kjos <tkjos@android.com>

> ---
>
> Hello - I was backporting 5cec2d2e5839 and didn't think it looked quite
> right. The patch description doesn't specifically mention a need to acquire
> mmap_sem for writing and the two commits (5cec2d2e5839 and 3013bf62b67a) landed
> relatively close in time to each other so I have a feeling that a mistake could
> have happened while resolving conflicts.
>
> I also noticed that commit 3013bf62b67a was slightly incomplete because
> it didn't rename the err_down_write_mmap_sem_failed label to
> err_down_read_mmap_sem_failed.
>
> I've tested this change by enabling CONFIG_ANDROID_BINDER_IPC_SELFTEST
> and verified that the binderfs_test selftest passes.
>
> Tyler
>
>  drivers/android/binder_alloc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index 195f120c4e8c..bb929eb87116 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -931,8 +931,8 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
>         mm = alloc->vma_vm_mm;
>         if (!mmget_not_zero(mm))
>                 goto err_mmget;
> -       if (!down_write_trylock(&mm->mmap_sem))
> -               goto err_down_write_mmap_sem_failed;
> +       if (!down_read_trylock(&mm->mmap_sem))
> +               goto err_down_read_mmap_sem_failed;
>         vma = binder_alloc_get_vma(alloc);
>
>         list_lru_isolate(lru, item);
> @@ -945,7 +945,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
>
>                 trace_binder_unmap_user_end(alloc, index);
>         }
> -       up_write(&mm->mmap_sem);
> +       up_read(&mm->mmap_sem);
>         mmput(mm);
>
>         trace_binder_unmap_kernel_start(alloc, index);
> @@ -959,7 +959,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
>         mutex_unlock(&alloc->mutex);
>         return LRU_REMOVED_RETRY;
>
> -err_down_write_mmap_sem_failed:
> +err_down_read_mmap_sem_failed:
>         mmput_async(mm);
>  err_mmget:
>  err_page_already_freed:
> --
> 2.7.4
>
