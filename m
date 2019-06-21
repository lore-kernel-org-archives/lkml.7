Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE4DC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A9C520652
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZmwoFfL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfFUBkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 21:40:36 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45381 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfFUBkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 21:40:35 -0400
Received: by mail-io1-f65.google.com with SMTP id e3so679458ioc.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 18:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NZnurSBLJdIfkJgx/5dwcZZFf4ycxK72Auy3OJll/TE=;
        b=bZmwoFfLSb6kDiM4V+mKT/zgbkVVryUT3VZqZx3z8LCa30gAcwILhqnVzvCeC1axv2
         2VtrpAu1HntKfcuKnqIcXSlnA95ZJlIaoKqsrHOpUOhk/YcBOmPIT4SEuEXJsNHUGn1r
         ftjM+Ss/P0F6eEsNC5BxEWvXblnx95W7yWgMu+HfjYpeBlxg7zseR5IxmGLOC56SRfDK
         bWfiQZo296uPVmLZAEu8LNERSBpfJYSuUHDLK0wPZPUW7RH5mEf8/B0aSROBH4vD2iGW
         F8pL++I/ISEh1EO8XqmHFxjKc2akJGXrBBgGbAK5moVj+u1hKZm7L1NO5KCpaduBsr8N
         AAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NZnurSBLJdIfkJgx/5dwcZZFf4ycxK72Auy3OJll/TE=;
        b=RL1W7nBkY+KryjIgvjYJXgyUjugOYdSs5rufIbBF+QkI9mRumF3etKci3l/SSb/1AN
         N/AlhRRkBI5gG6BFJQpqwEzKqVjkLOOpjzD9pKLJHx1ZO20SDV630Z4E+G3eV9mg6iny
         pd1ZVeYl46bjim5POwptT6Q4l4HW+Uh4cHX4QSoWzdr/wx7kmNXyRbOIIbmQghaUPvzt
         kcDwCmyDaj0HkU2m1iCI1iDG4o7DaTJo13dWjmb1W6Uxq5dAzWCoL+rW/YD8FyzmwOky
         x3sQvZ/ZYjtyZgzsPAGkbrPdQcNUd8s6RAsXrcxh+7tWZdH4pKBJ43PYMS9dzbCmGrkf
         8YTQ==
X-Gm-Message-State: APjAAAX3fsCYslW4hHx9hM2m2YFzdYY9A93VorCW/UR8wXaLB/cV96U+
        QoeVSG7abLnakyx7ja8gkCHIhX7AKQvn2L89D+M=
X-Google-Smtp-Source: APXvYqxBNFP14Ny1HpEdhqKlp2lSGyXI+MY93zfhyerR6bNQY9PKTsQuKJnzEgpVU9R+988hLPhXLG2Ed/sLtRjwRW0=
X-Received: by 2002:a5e:c70c:: with SMTP id f12mr22982280iop.293.1561081234147;
 Thu, 20 Jun 2019 18:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190523074924.19659-1-hch@lst.de> <20190523074924.19659-5-hch@lst.de>
In-Reply-To: <20190523074924.19659-5-hch@lst.de>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Fri, 21 Jun 2019 11:40:23 +1000
Message-ID: <CAOSf1CE2UgF7-BtQj2SfQSUUsctg2boS_kSL-Cs-ugZe4=6N7Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] powerpc/powernv: remove the unused vas_win_paste_addr
 and vas_win_id functions
To:     Christoph Hellwig <hch@lst.de>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sukadev@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 5:56 PM Christoph Hellwig <hch@lst.de> wrote:
>
> These two function have never been used since they were added to the
> kernel.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/powerpc/include/asm/vas.h              | 10 ----------
>  arch/powerpc/platforms/powernv/vas-window.c | 19 -------------------
>  arch/powerpc/platforms/powernv/vas.h        | 20 --------------------
>  3 files changed, 49 deletions(-)

Sukadev (+cc), what's the reason this is not being used?

IIRC the VAS hardware on P9 had some issues, but I don't know any of
the details.

> diff --git a/arch/powerpc/include/asm/vas.h b/arch/powerpc/include/asm/vas.h
> index 771456227496..9b5b7261df7b 100644
> --- a/arch/powerpc/include/asm/vas.h
> +++ b/arch/powerpc/include/asm/vas.h
> @@ -167,14 +167,4 @@ int vas_copy_crb(void *crb, int offset);
>   */
>  int vas_paste_crb(struct vas_window *win, int offset, bool re);
>
> -/*
> - * Return a system-wide unique id for the VAS window @win.
> - */
> -extern u32 vas_win_id(struct vas_window *win);
> -
> -/*
> - * Return the power bus paste address associated with @win so the caller
> - * can map that address into their address space.
> - */
> -extern u64 vas_win_paste_addr(struct vas_window *win);
>  #endif /* __ASM_POWERPC_VAS_H */
> diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
> index e59e0e60e5b5..e48c44cb3a16 100644
> --- a/arch/powerpc/platforms/powernv/vas-window.c
> +++ b/arch/powerpc/platforms/powernv/vas-window.c
> @@ -44,16 +44,6 @@ static void compute_paste_address(struct vas_window *window, u64 *addr, int *len
>         pr_debug("Txwin #%d: Paste addr 0x%llx\n", winid, *addr);
>  }
>
> -u64 vas_win_paste_addr(struct vas_window *win)
> -{
> -       u64 addr;
> -
> -       compute_paste_address(win, &addr, NULL);
> -
> -       return addr;
> -}
> -EXPORT_SYMBOL(vas_win_paste_addr);
> -
>  static inline void get_hvwc_mmio_bar(struct vas_window *window,
>                         u64 *start, int *len)
>  {
> @@ -1268,12 +1258,3 @@ int vas_win_close(struct vas_window *window)
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(vas_win_close);
> -
> -/*
> - * Return a system-wide unique window id for the window @win.
> - */
> -u32 vas_win_id(struct vas_window *win)
> -{
> -       return encode_pswid(win->vinst->vas_id, win->winid);
> -}
> -EXPORT_SYMBOL_GPL(vas_win_id);
> diff --git a/arch/powerpc/platforms/powernv/vas.h b/arch/powerpc/platforms/powernv/vas.h
> index f5493dbdd7ff..551affaddd59 100644
> --- a/arch/powerpc/platforms/powernv/vas.h
> +++ b/arch/powerpc/platforms/powernv/vas.h
> @@ -448,26 +448,6 @@ static inline u64 read_hvwc_reg(struct vas_window *win,
>         return in_be64(win->hvwc_map+reg);
>  }
>
> -/*
> - * Encode/decode the Partition Send Window ID (PSWID) for a window in
> - * a way that we can uniquely identify any window in the system. i.e.
> - * we should be able to locate the 'struct vas_window' given the PSWID.
> - *
> - *     Bits    Usage
> - *     0:7     VAS id (8 bits)
> - *     8:15    Unused, 0 (3 bits)
> - *     16:31   Window id (16 bits)
> - */
> -static inline u32 encode_pswid(int vasid, int winid)
> -{
> -       u32 pswid = 0;
> -
> -       pswid |= vasid << (31 - 7);
> -       pswid |= winid;
> -
> -       return pswid;
> -}
> -
>  static inline void decode_pswid(u32 pswid, int *vasid, int *winid)
>  {
>         if (vasid)
> --
> 2.20.1
>
