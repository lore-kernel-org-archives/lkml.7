Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FE1C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 05:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FDD621479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 05:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="edeVbOaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731292AbfDRFgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 01:36:01 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37647 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfDRFgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 01:36:00 -0400
Received: by mail-vs1-f67.google.com with SMTP id w13so517276vsc.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 22:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bLtDzKXu09gPBmOTPhLlCKa/1j1gZ8w+6fLRYpgkXVc=;
        b=edeVbOaBMLhN2dBQJXpv+D+6vAjewlRc9kM5lTmzsJMTYvnZuw8u8Y7DqZfh26UEgW
         OHIgnpHVLQHXols38+FJXscMQV6lYZx93+goYy0WamrsRBkh1x83txAmNxUkD0xqfkb/
         5V9w/CLbuOWB3OiL1UReRwHKvROTO3KbTfB1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bLtDzKXu09gPBmOTPhLlCKa/1j1gZ8w+6fLRYpgkXVc=;
        b=igAX0YxApteJcFtelnXpGM2SLm7BFZi/PDrLfl0hGMQfhF/4pKw6Q3DCURenX6MuM6
         fFpuLIaPJYhxO2q+n1yeWH5tvCyzilZvRoEaqgldZiEkP0wllxGhwKD36Y93xCryONmM
         ojohiIjYqPoTZv41jCZ9o6ZPQ6kGUJuIU7+WhY7daCNcduXTAG+JJX3dq89/VOgphl7e
         g8qno9oMmQOFzPURP6tAe8603KL4WXgvcgukY/OuSKEjyB0eVvIUbTF6VNw2ChnKanfK
         4ur7XnLfonc2ODf86VLElm0eklf/Cy/gH3FggFLpOq7YkiSHsp3FitGOR/I9TYEH4WC2
         42lQ==
X-Gm-Message-State: APjAAAU0S08mYYXBCTNB/RGdGSiLNKr3s4Zr8ZiCqiGVpE5sBKY8HTim
        o/fLd/HW1UDI7D73f/bZWkruz4XftPY=
X-Google-Smtp-Source: APXvYqyB0IShDITw33O1kfM4m0YRMnMus6zoTDSkjGUJLn456vE5pAS+E2RoEfStcJ5OPMKJkxQz4A==
X-Received: by 2002:a67:89c7:: with SMTP id l190mr51053294vsd.199.1555565759642;
        Wed, 17 Apr 2019 22:35:59 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id v22sm272371vkv.35.2019.04.17.22.35.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 22:35:59 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id w13so517264vsc.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 22:35:59 -0700 (PDT)
X-Received: by 2002:a67:e881:: with SMTP id x1mr52185580vsn.48.1555565442783;
 Wed, 17 Apr 2019 22:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190417052247.17809-1-alex@ghiti.fr> <20190417052247.17809-9-alex@ghiti.fr>
In-Reply-To: <20190417052247.17809-9-alex@ghiti.fr>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 18 Apr 2019 00:30:31 -0500
X-Gmail-Original-Message-ID: <CAGXu5j+-M5VGsPqZ6JyqH6w=HP9NLK2KEAQqen99ssUg5mC89A@mail.gmail.com>
Message-ID: <CAGXu5j+-M5VGsPqZ6JyqH6w=HP9NLK2KEAQqen99ssUg5mC89A@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] mips: Properly account for stack randomization
 and stack guard gap
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 12:31 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> This commit takes care of stack randomization and stack guard gap when
> computing mmap base address and checks if the task asked for randomization.
> This fixes the problem uncovered and not fixed for mips here:
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1429066.html

same URL change here please...

>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/mips/mm/mmap.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
> index 2f616ebeb7e0..3ff82c6f7e24 100644
> --- a/arch/mips/mm/mmap.c
> +++ b/arch/mips/mm/mmap.c
> @@ -21,8 +21,9 @@ unsigned long shm_align_mask = PAGE_SIZE - 1; /* Sane caches */
>  EXPORT_SYMBOL(shm_align_mask);
>
>  /* gap between mmap and stack */
> -#define MIN_GAP (128*1024*1024UL)
> -#define MAX_GAP ((TASK_SIZE)/6*5)
> +#define MIN_GAP                (128*1024*1024UL)
> +#define MAX_GAP                ((TASK_SIZE)/6*5)
> +#define STACK_RND_MASK (0x7ff >> (PAGE_SHIFT - 12))
>
>  static int mmap_is_legacy(struct rlimit *rlim_stack)
>  {
> @@ -38,6 +39,15 @@ static int mmap_is_legacy(struct rlimit *rlim_stack)
>  static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
>  {
>         unsigned long gap = rlim_stack->rlim_cur;
> +       unsigned long pad = stack_guard_gap;
> +
> +       /* Account for stack randomization if necessary */
> +       if (current->flags & PF_RANDOMIZE)
> +               pad += (STACK_RND_MASK << PAGE_SHIFT);
> +
> +       /* Values close to RLIM_INFINITY can overflow. */
> +       if (gap + pad > gap)
> +               gap += pad;
>
>         if (gap < MIN_GAP)
>                 gap = MIN_GAP;
> --
> 2.20.1
>

-- 
Kees Cook
