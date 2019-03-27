Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89A1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98BA02087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="JR7085O0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbfC0OCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:02:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46858 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfC0OCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:02:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id t17so2071231wrw.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 07:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JoV6bHeNIWFARGZA9fpZFkp4vt76l1ftGl/d9i602jk=;
        b=JR7085O087ON4qh3se8Ob4x8KaZ/8TKWkBubB1RIJOnZ73mWzX6ZUO3HH2PFSwUVu2
         2Mnuwe8oeQxPGAkuD6qTTt8wIN8Yf0EBGmzb200YlrxzrHAz0mZP0bkL+g4JQqyney4I
         D6uYV9r5bbdd0N5eSYjDdL4pBUEmS+PEvJcpED1BHrdgMkQ9Kde/6AmyUJHMapwCAUgK
         p5Sj9yZLqSkD0NLCJf0jzWUCY+YMvuKMHiBi04FpiQ1pnhvvCHQqDVp+i6APkDJf2u2/
         QyPmFh2BgCLNnf6kRgD3JqXTqZvIhCdt5JM5CNjZYp2F3vKu1UBkm0UHMqHjx9LUWG6a
         R5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JoV6bHeNIWFARGZA9fpZFkp4vt76l1ftGl/d9i602jk=;
        b=GQKYARJ0KAS7NIaBSIFiRItYtll4wV+dho+ri6HBGeSlaaNBsPqfaoUwkWXQXVdrjy
         nWMCSyX4diW8k26TTyQohkD1vcM1JSiPG6Nt5vzSvMwVEMdFTT0mS8Hqxlaae1jkgm0J
         0DrpRCbPEaQVaTYZEYy8hl95Rs8NTnbpeAFxz9TZl4uA9+kPaNDLRXYVH3HZe2ERVO8v
         N6KCAzXXTKa9rORak/ZbvL5oAPp1mWa1nk/D8pkIlm1O0QhAdrZFj/2ywE5urIbbnWlP
         9WBldz8ijiyHqS8auER44pi5C1t4KVjwzCLE2fb423gi6DTvfu0UEXM8UTfLkL0QeTl8
         maTw==
X-Gm-Message-State: APjAAAUSmH7/fqMwji1l/HB4UrEVhxNSY8cEWzc825qrTf8jUpiXKMfi
        /Ja2I6Dlbs80FknQfYHOqMV1yksrapA0t+9XYoNxVQ==
X-Google-Smtp-Source: APXvYqxegEcblAAV9k0hlKqCN+vFlscaWLUFUBFCzJWluTmPjmcu7C3LtNaHKreASp6eAwm0ODeI47k9Wuti/sSyIio=
X-Received: by 2002:a5d:5108:: with SMTP id s8mr21441512wrt.99.1553695362323;
 Wed, 27 Mar 2019 07:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190327100201.32220-1-anup.patel@wdc.com> <7edf91f1-1df5-5513-d372-d84edd12edf3@garyguo.net>
 <CAAhSdy1+rc9ge02uqNvse5Z6XmDxsRH0G=5GnMsh+6m1LMLFYg@mail.gmail.com> <74227a1d-3928-3e92-c7a9-5c3e093b29ab@garyguo.net>
In-Reply-To: <74227a1d-3928-3e92-c7a9-5c3e093b29ab@garyguo.net>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 27 Mar 2019 19:32:31 +0530
Message-ID: <CAAhSdy1K6OiZ2nDGcERi7J1z-i6hDC2eWubYDnSqPGCxQKkn5g@mail.gmail.com>
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

On Wed, Mar 27, 2019 at 7:12 PM Gary Guo <gary@garyguo.net> wrote:
>
> I would also like to mention that your code assumes 64-bit atomics
> support which we don't have on 32-bit systems. Using 32-bit to track
> ASID generations isn't sufficient and will cause overflows. That's why I
> have asid_generation_overflow to handle the case (this is super
> error-prone as well).

Thanks for catching. I will fix issues with 32bit systems and send v2
soon.

Regards,
Anup
