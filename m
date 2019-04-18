Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0255DC10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 04:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C605B2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 04:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OLkbJU7m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfDREhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 00:37:15 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:46024 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbfDREhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 00:37:15 -0400
Received: by mail-vk1-f194.google.com with SMTP id h127so186089vkd.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 21:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=92tRgfUMbeMv1ITsQnVX2nfQxbImxEmC6NtEESfsrL8=;
        b=OLkbJU7m0JSpwXyWqa9ZSVBZbJJbsitwwGD9ZFTANpCONTXMGZ81AhxDTno9r38sEv
         Z0JotjuwKOUss922IFDFo/63cZ+UAJRNvTAAAwjPU190WnPbTuipbvAcYF0az0veXucS
         uACiUuIuiBILnxrE6ReQLiWsvSB24QasvXBQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=92tRgfUMbeMv1ITsQnVX2nfQxbImxEmC6NtEESfsrL8=;
        b=X4PDbq3aRwzhZxwqGWEevuHUDKL/5CBhUfBp64T29MefgM63t9YIshKJ6b6Jp1VQZL
         +XmQEitYIChTNGlGyMKs2CLXRrLcsBR5MztIeVXhYqI9OKJUcRE2rX7xHGmJ6JA3fVh5
         cUOJ7Um5aux+h6m7017kWjKB3ORZAUWZEYJtKsQef7I7xrYbeTlp4bVvEUBDHyNZ13j6
         DpeGUQspBrxgRpweAvtJMMDTsDD6Ax56fqX42M7qLNUEWiuLz69s/hm0DQ+MN+VSuf2n
         2SjoQXzI6pmLwn2OtVnOiBaVZklxCyvtFhXZoh9P68pn40ufp6iORDQwnCmcliV+GSh9
         Y39w==
X-Gm-Message-State: APjAAAXGwZ60PxyB9nqDDON7jW32OdEbIlMgoX0WiFIWG1TcyO5WCcCz
        NHd2TapNv8ldnuIYGG2qZOWBBXWgtmA=
X-Google-Smtp-Source: APXvYqxZJ5KMoz6kxLjRhyZNWw4mpinMJCDEUpPt+PUV5AtvCCNy8IblDkD6vMysggS6Y4A2/ghP5Q==
X-Received: by 2002:a1f:1185:: with SMTP id 127mr40822199vkr.6.1555562233712;
        Wed, 17 Apr 2019 21:37:13 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id y127sm174698vsc.26.2019.04.17.21.37.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 21:37:12 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id s2so460020vsi.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 21:37:12 -0700 (PDT)
X-Received: by 2002:a67:7c8a:: with SMTP id x132mr50675686vsc.172.1555562232106;
 Wed, 17 Apr 2019 21:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190417052247.17809-1-alex@ghiti.fr> <20190417052247.17809-4-alex@ghiti.fr>
In-Reply-To: <20190417052247.17809-4-alex@ghiti.fr>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 17 Apr 2019 23:37:00 -0500
X-Gmail-Original-Message-ID: <CAGXu5jKo26zXw=jfKSzr_pnfx5Zux+fVbY7V9bJwEMApDcFi8w@mail.gmail.com>
Message-ID: <CAGXu5jKo26zXw=jfKSzr_pnfx5Zux+fVbY7V9bJwEMApDcFi8w@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] arm64: Consider stack randomization for mmap
 base only when necessary
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

On Wed, Apr 17, 2019 at 12:26 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> Do not offset mmap base address because of stack randomization if
> current task does not want randomization.

Maybe mention that this makes this logic match the existing x86 behavior too?

> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/arm64/mm/mmap.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
> index ed4f9915f2b8..ac89686c4af8 100644
> --- a/arch/arm64/mm/mmap.c
> +++ b/arch/arm64/mm/mmap.c
> @@ -65,7 +65,11 @@ unsigned long arch_mmap_rnd(void)
>  static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
>  {
>         unsigned long gap = rlim_stack->rlim_cur;
> -       unsigned long pad = (STACK_RND_MASK << PAGE_SHIFT) + stack_guard_gap;
> +       unsigned long pad = stack_guard_gap;
> +
> +       /* Account for stack randomization if necessary */
> +       if (current->flags & PF_RANDOMIZE)
> +               pad += (STACK_RND_MASK << PAGE_SHIFT);
>
>         /* Values close to RLIM_INFINITY can overflow. */
>         if (gap + pad > gap)
> --
> 2.20.1
>


-- 
Kees Cook
