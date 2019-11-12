Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407A4C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14550214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573574572;
	bh=1CMxmS3TS0nhlPw8twQjXwDSJXuLjM688gXVI0oIUN4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=12k00kf0OxApEAMuj9JDIWGrl4j/stqCrKnIZQ2EaHeq9W7p4TiCn1631ov3Wi0ra
	 SGTYwJBj5oHptUvyMP+MRKcLX1pcq9TTaDdDvmjRbmIPXLK4YkkMIilERgcPiib/au
	 6AFCRTJFY3phEz6aJyH92G0ovahYsPgFpIOtUHI0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfKLQCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 11:02:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:54496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfKLQCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 11:02:50 -0500
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90C1321D7F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 16:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573574567;
        bh=1CMxmS3TS0nhlPw8twQjXwDSJXuLjM688gXVI0oIUN4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O2eqyj5L+Dl00jw1cGJef3CBRJO3ktBvJsNs53SXCG8aZ6w1uxItJG7MOIQMRqdr4
         4hqIv0VkKhmvBFuaNfYm3QuxtuA4N3QubBQCVx/NNWVrlWUR0BAl50E1iXX2VnfMyp
         XzO+0sUvLa9nmkX1OCLObAQeUzOZ/rV8FHq85r9s=
Received: by mail-wr1-f49.google.com with SMTP id n1so19096051wra.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 08:02:47 -0800 (PST)
X-Gm-Message-State: APjAAAWLxWECO5u9odNmXDaiKbtxSMndKyZ3IyhM9fSB279gt0kUCfin
        Mf0Lt19YCDsoL8XaFxx3GHDeWpfz8Avev+qpKh6ADQ==
X-Google-Smtp-Source: APXvYqz0p0M3QBHix1u3I4U/YEqbCd1mAZK00jJTpr4A+prh5EWpl2ya7eUeDyRuOVY6K2kR1RE/6I/y3KYx9QBKN2w=
X-Received: by 2002:a5d:4412:: with SMTP id z18mr4294420wrq.149.1573574566063;
 Tue, 12 Nov 2019 08:02:46 -0800 (PST)
MIME-Version: 1.0
References: <20191111220314.519933535@linutronix.de> <20191111223052.199713620@linutronix.de>
In-Reply-To: <20191111223052.199713620@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 12 Nov 2019 08:02:34 -0800
X-Gmail-Original-Message-ID: <CALCETrX=T+d2ygrcGKMJpb+Dwz-E8cGWLB8=67eV-gXjd77Dhw@mail.gmail.com>
Message-ID: <CALCETrX=T+d2ygrcGKMJpb+Dwz-E8cGWLB8=67eV-gXjd77Dhw@mail.gmail.com>
Subject: Re: [patch V2 07/16] x86/ioperm: Move iobitmap data into a struct
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 2:35 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> No point in having all the data in thread_struct, especially as upcoming
> changes add more.
>
> Make the bitmap in the new struct accessible as array of longs and as array
> of characters via a union, so both the bitmap functions and the update
> logic can avoid type casts.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: New patch
> ---
>  arch/x86/include/asm/iobitmap.h  |   15 ++++++++
>  arch/x86/include/asm/processor.h |   21 +++++------
>  arch/x86/kernel/cpu/common.c     |    2 -
>  arch/x86/kernel/ioport.c         |   69 +++++++++++++++++++--------------------
>  arch/x86/kernel/process.c        |   38 +++++++++++----------
>  arch/x86/kernel/ptrace.c         |   12 ++++--
>  6 files changed, 89 insertions(+), 68 deletions(-)
>
> --- /dev/null
> +++ b/arch/x86/include/asm/iobitmap.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_IOBITMAP_H
> +#define _ASM_X86_IOBITMAP_H
> +
> +#include <asm/processor.h>
> +
> +struct io_bitmap {
> +       unsigned int            io_bitmap_max;
> +       union {
> +               unsigned long   bits[IO_BITMAP_LONGS];
> +               unsigned char   bitmap_bytes[IO_BITMAP_BYTES];
> +       };

Now that you have bytes and longs, can you rename io_bitmap_max so
it's obvious which one it refers to?
