Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB53C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 23:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8B720873
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 23:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kO9iPKcd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfENXkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 19:40:24 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33505 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfENXkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 19:40:24 -0400
Received: by mail-qt1-f196.google.com with SMTP id m32so1245041qtf.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 16:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mqlrXy5kwdDrwo0UFJq8GGPqMotywoeM6XVl2pYk4JQ=;
        b=kO9iPKcdYHvq7Sy8SSA7D9MRPKbtN9+us4/EErldh7Q6WJGODf0MesKSC5OhxQ7IN7
         lPxyWzUjq99r96cm2T2CxpIw0l5KV8jnTT5Jg5O4a4n29kjPQQCyfjfxzDkFEw3RrC1C
         Q16I9GbitKoCMSEaV4V6wt7Tt2HupryJBrlm+WwpOv/TYRHgp4VC8IdN0ygNNWTs6JFt
         zDH91eVMgIzDnvEIToaXNoZSbRBcGtPwjJvusEUBxuRhCqb28S75HrSU6QVGvsj4qhOA
         sS3OBF3WfP4GXaT75hzGXjBonIl3CyNpZNaLXN3sNusLlIPjy2g4Poa93CznpOcD5a2Y
         FfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mqlrXy5kwdDrwo0UFJq8GGPqMotywoeM6XVl2pYk4JQ=;
        b=fS3SIqrmaEKcnERB9dKE+S+oC6YK9s1gBuihGzQZzguOMpNUgoO+WG9yNiQKd9rz9b
         WDR4oRF2+lpxl9xhlZWuHJwvPT9d+nSngaa9vusHHMmG/SZcm2SgwrbFcnz5CJ8UDuH5
         dODWlKd6P/JTGPzo/bBaMhZVU1raWtczM1ip3cqezXbOvBzvsSUJUW2Yagx3Jz8dy13S
         LRqg6aiYUrR2gkLlP1nn/D9MrcYtn+CZcYjg5LGGH9Qgb0XPKYJ4cw2MKCo+xZpp0nKj
         w0xh9EFD035914dAID1x2+2UI/Bjj1vt4uDi3k7iRzbgdEIxGbQCDTrAj22B0JbauZTZ
         Fwtw==
X-Gm-Message-State: APjAAAW7x1EhcmOlnSGMykU1SFZCMAmsnqui+xpIP9Rh3oR7x/C4Zra6
        Ing0LHRDCgRIMbf2K2NWF4cYVUPuCbYWdUEB6tY=
X-Google-Smtp-Source: APXvYqzwbNTznSBrD6LoX9VLQYRvaPeKLNqZGrq7TRAldxBbjP7SsrUY2Ndu+OYRW/2V+3p4I5kx8+x21B1wcVBFZZo=
X-Received: by 2002:a0c:aed4:: with SMTP id n20mr30980915qvd.195.1557877223375;
 Tue, 14 May 2019 16:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <1556234531-108228-1-git-send-email-yang.shi@linux.alibaba.com>
In-Reply-To: <1556234531-108228-1-git-send-email-yang.shi@linux.alibaba.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 14 May 2019 16:40:12 -0700
Message-ID: <CAPhsuW5B5twTEk=SZZqZCH9_hjEjJ_KFP_GYq3T6nzv7kRSM0w@mail.gmail.com>
Subject: Re: [PATCH] mm: filemap: correct the comment about VM_FAULT_RETRY
To:     Yang Shi <yang.shi@linux.alibaba.com>, jbacik@fb.com
Cc:     josef@toxicpanda.com, Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 4:22 PM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
> The commit 6b4c9f446981 ("filemap: drop the mmap_sem for all blocking
> operations") changed when mmap_sem is dropped during filemap page fault
> and when returning VM_FAULT_RETRY.
>
> Correct the comment to reflect the change.
>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

Looks good to me!

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  mm/filemap.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index d78f577..f0d6250 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2545,10 +2545,8 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
>   *
>   * vma->vm_mm->mmap_sem must be held on entry.
>   *
> - * If our return value has VM_FAULT_RETRY set, it's because
> - * lock_page_or_retry() returned 0.
> - * The mmap_sem has usually been released in this case.
> - * See __lock_page_or_retry() for the exception.
> + * If our return value has VM_FAULT_RETRY set, it's because the mmap_sem
> + * may be dropped before doing I/O or by lock_page_maybe_drop_mmap().
>   *
>   * If our return value does not have VM_FAULT_RETRY set, the mmap_sem
>   * has not been released.
> --
> 1.8.3.1
>
