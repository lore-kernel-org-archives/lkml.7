Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B684C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593F1206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="leBDzQpK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbfC0Lm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 07:42:27 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53434 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfC0Lm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 07:42:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id q16so15805539wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 04:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YNNdbSS+C3KJAabfM9Oo1cBSnZKSRht7rzVdKUeZ6F0=;
        b=leBDzQpK8dYKG+NM4xP5w+oTyJYG5WWEhS5kvnN0UcM+D2SuFxRxv46g5EZ9QtRIfk
         GgEHV3D98wAbU87hp1GW8xVKm0QvMQ1rtGLfZ3lXPC2JTvGhoT7fVyPWLwHbKrPaLk3g
         uq+v84/6VbwUv/jTwx64qtPTGdAyvhCpIhRE3p+pfODBkxD1IWz3nmP7S4oaY5DseX0h
         iQaViAAUzSro5l9MQwuDBnrs9RqcmdhJW59Vneo82bq8QltnbAYEqBoEKs2tLMx3ElDs
         CZaTkCg6Egobrk3UkSbPLD3bqjfdcqiEv82RZAwacQLNBWeodPOpVr2bQ/AkkOaiyysY
         bceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YNNdbSS+C3KJAabfM9Oo1cBSnZKSRht7rzVdKUeZ6F0=;
        b=DH6O1ywVekg1bX817ej63w6hmkjLm6/grlBar1CSlmM5J+yMTUekCM15imHzOFz957
         r71ltPDfoa15/QNIW67JIuRWPRSWkfFCKe3hbSJcjzREpS++H975kb2eJsXgVNMVjR/X
         xKEa6MvesVWLDs3s8vL9fwNASDiLkcnvd7Zfc7LB2EIPQYHMKYBuRv+o3cFyB36Fy1QQ
         KbDRfhOn9Ad5oACq7RuhexAU5bvRjfayeFu+Hq4a3UJYMCMadlVkS1F+eZI7rBNWVny6
         /vfSEt7gtsNl4+yLTy4E8umrcoUzaVu4sT4FAawlB5j3fk+qhcMTZLZTdwQDDRcWLUWu
         UJJQ==
X-Gm-Message-State: APjAAAWNWer3kmO0Z9i0Q9Ye4TumxVbo1rogvIRrQcRMudMEsINQcPF5
        Imho4kCgIwURXJZw7JXcfW5JMK7FXcJDk3V29Nagrw==
X-Google-Smtp-Source: APXvYqxwNOCUbbIVKFyWW/n2pea8HQ53zOVo5USOjGCNbbaJPHEwdBuNU3w9Eh2giuxdKIkODLu82TRP2KHZoVzAghg=
X-Received: by 2002:a7b:cf18:: with SMTP id l24mr9709637wmg.132.1553686944711;
 Wed, 27 Mar 2019 04:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190327100201.32220-1-anup.patel@wdc.com> <7edf91f1-1df5-5513-d372-d84edd12edf3@garyguo.net>
In-Reply-To: <7edf91f1-1df5-5513-d372-d84edd12edf3@garyguo.net>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 27 Mar 2019 17:12:13 +0530
Message-ID: <CAAhSdy1+rc9ge02uqNvse5Z6XmDxsRH0G=5GnMsh+6m1LMLFYg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Implement ASID allocator
To:     Gary Guo <gary@garyguo.net>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 4:57 PM Gary Guo <gary@garyguo.net> wrote:
>
> Hi Anup,
>
> This won't work in an actual hardware with ASID support. There're more

Can you elaborate why?

This implementation is based on Linux ARM64 ASID allocator which is
tested for large number of CPUs on real HW.

> interactions with TLB flushes that need to be considered. You won't see

Yap, already considered. Please point me to unhandled case.

> this on both QEMU and SiFive board, as QEMU does not have ASID, so it
> pretends that ASID is supported by just flushing its TLB everytime you

Nope, it does not. It detects whether ASID is supported or not. If supported
it will also figure-out number of ASID bits supported by HW.

SiFive board does not have ASID bits so this implementation successfully
detects that number of ASID bits are 0 and fallbacks to original way of
local TLB flushes.

> change sptbr. I suspect the performance gain you see is just due to
> saved TLB flush as TLB flush is super expensive in QEMU (all translation
> block jumps need to be cleared).

Yes, performance gain is due to saved TLB flushes.

On HW which supports ASID bits, we will see more performance
improvements.

>
> I have my version here https://github.com/nbdd0121/linux/tree/asid. I
> haven't done code cleanups yet, but this version has correctness of its
> ASID code tested on our TLB simulator tool (which unfortunately I can't
> share right now as it involves with unpublished works).

Except few minor differences. You version of ASID allocator is same as
mine. In fact there are lot of similar code framgements in your version
compared to Linux ARM64 as well. I am sure this patch will work for you.

>
> In fact my submit my previous patch series exactly as the basis of this
> patch.

This patch is based your patch series so I suggest you take this patch
and try it on your simulator.

Suggestions and improvements to this patch are welcomed.

I would be happy if you can assist me to try on your HW.

Regards,
Anup
