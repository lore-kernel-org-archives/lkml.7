Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA19C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A4AE2148D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="HBY7dkAy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbfDXGp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:45:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33383 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfDXGp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:45:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id a3so13816323wrx.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 23:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AyVK2GRakZiSagpjjAHHtZd/+k3S6z9JMKxhTl4oqnk=;
        b=HBY7dkAyqC/HNR6mbKXMpZUMyhGjlkdKC62ZFnZYR5uBPx8SHDEmBv6ED1ytC9vtH4
         RTVl6nNHJQbWTzaozEuAwJSbGgIPnbI83yCwU3+gE+YVQDkVtjlRf0ZM2Ouj9KzfYfUp
         YnWsVi7npWgoTCdpANmv807o7SDGbttPdKMVqK3N9jNvdyr/s2DoGwPdcXav8wGPb1zf
         OJ/9pxg5K10iquAiPB6zFKbM/xDGiEXIN4wYtSVhxSRn68arFNd9FQj6RRzsOW5Y/8l2
         qck+ko5bSQm9K4CCVJb9fW605JGurqLUudZz0jhCZI12+1ZlUoMUMkCMg4cpuTUcQWU2
         uenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AyVK2GRakZiSagpjjAHHtZd/+k3S6z9JMKxhTl4oqnk=;
        b=VJvujiSRYoFqVofHFercmgRgJO2LHvTDqVy9acVU6mVb0gGxUNXOHt1N1EmYvf023u
         IOiMov3xf9kq/YlugvnoQpg4Zmj850a5aar4zw9Un7qUurPleSqesJBckmCwSEwOfWS6
         Iiwe3135t825eu66WzoR5FMI8P22LLctb/oVwA6IGxTtwvgqaH9tObWqla22b8LupKgq
         XQXqTeYF1FgfgMfJLTRgLi5ZpslKBcl6OqLrLHxAX2f60q95cRGaPK/MrBCJOn+EeHPL
         K73KxENwLXmRSoaTazp8DnfNcRe6NMT/aBvvWCMG+HEXvO9m2YCUNxAgk6rVM9XALwHe
         cl+Q==
X-Gm-Message-State: APjAAAW2zM/QDea8RiE4ALtvHb+NQxpJAw/qDJbtDOaSutDT0fQW/siN
        4jDyuwENnYZ/rTnMPCYLBRkw7u6mcy7GHGi+0+XP8kbfNbk=
X-Google-Smtp-Source: APXvYqxnhEnqYUaQjOU8P7vuX1aGF73xOst194+h6qMRyX7r29YrcCS4BF62VPpUrDDVmD9r4VXvO8hQgndSvryLl2E=
X-Received: by 2002:a5d:5346:: with SMTP id t6mr21566738wrv.59.1556088357115;
 Tue, 23 Apr 2019 23:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190415093648.7525-1-anup.patel@wdc.com> <20190415093648.7525-3-anup.patel@wdc.com>
 <20190424062947.GB10400@infradead.org>
In-Reply-To: <20190424062947.GB10400@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 24 Apr 2019 12:15:45 +0530
Message-ID: <CAAhSdy1Xc9AjPKY0RzLL_qsBs6wax23fi2BTVtMhuS0mAoKZmQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] RISC-V: Add interrupt related SCAUSE defines in asm/csr.h
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 11:59 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Apr 15, 2019 at 09:37:23AM +0000, Anup Patel wrote:
> > This patch adds SCAUSE interrupt flag and SCAUSE interrupt related
> > defines to asm/csr.h. We also use these defines in kernel/irq.c and
> > express SIE/SIP flags in-terms of SCAUSE interrupt causes.
>
> I'm not a fan of this.  For one this pollutes csr.h with bits not really
> needed by most users, and it makes adding the M-mode nommu port which has
> to use the M-mode causes much harder:

It's not polluting asm/csr.h because when we get interrupt numer in lower bits
of SCAUSE CSR.

These defines certainly belong to asm/csr.h because they represent possible
exception causes when we get interrupt.

We need these defines for programming HIDELEG CSR in KVM kernel module
so it will be used at multiple places.

>
> http://git.infradead.org/users/hch/misc.git/commitdiff/1221f5c32345ebe7ea2c1cd6e8a01ad4b422aaba

You can certainly use these defines in your nommu commit by using
"#ifdef CONFIG_M_MODE" in switch case of do_IRQ().

Regards,
Anup
