Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45650C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 16:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10CA52774C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 16:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559405678;
	bh=8I76hpSNyuE8ERni7sGyWZ013DnMWGJIFydMjyyt+xk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Bd+Bu7BMVXSYhomDIXdwK1lUit9+lVWAbsr7lYLwAPom/rOL14+D7SJ4x+vtCV4Fe
	 EPn+lzY3yOOM6zuztDcIbx2VluboECp6zmwKj5I4KiM5Wi0mJAB5s9BWmjahoDa0iu
	 C7Bd874JrUr+bUwvCVUgG1+2HIVYU02YhgZaEZDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfFAQOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 12:14:37 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35856 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfFAQOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 12:14:36 -0400
Received: by mail-lf1-f65.google.com with SMTP id q26so10365781lfc.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2019 09:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TKTAJ8E7sNy2vEZhocfTI/IVyiugHenGqfHPAGmTqUU=;
        b=RdmXCPI1V+CWEuQQLIpoDnZHvNbMKl90LuqFIcI1YnEKXhPCSK5AUEFPNd650/ERUV
         Qh10sm7MSlB6HnOBHykL5KhchRGHirJ9ssAdIkVcDYKPumYo1Zi2YYM6BhTRVFDVSg7U
         Nczzjs9o+pp1b0tTsgtO9YPvDZ1uwi7oKCdAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TKTAJ8E7sNy2vEZhocfTI/IVyiugHenGqfHPAGmTqUU=;
        b=ayZdzRqSd4dMh46ljB5TZUh8louDyL2/vyV9S4OwaeAeYbvF5Yu7XG/vCcIHFjE8Fy
         cRcsaGx+CQN+qNOuCeSGJw0Mhc2jUavEy82Si/WYmexGiUQ9dPEAf4OyhwQa0UG/efWN
         exTR0OHeO4YLx61DWZHZCJZLnKspZxyOpVPI9kThGPO1d/8c47B0N/nct8t4RUXnppio
         iqPyQW5hWDkRrNFm88p6nTOwZ8HmIUHRbEMWZV3gdwoauaNqwAJ4YKdHOq4jFZMZJLw4
         yLoq2JKaN9LKXKFglNgnA+vm3OKWvkqENogU93Dm7RZDQT5tl+pvsWVay8eyP62y3Sn4
         AUug==
X-Gm-Message-State: APjAAAWjZ2yPJEe1oCTVGPrZYDEUYkxy8ljleA+Oi76+e+7I+ddzy8q9
        4PFTmY81c5Dnrk30ZR7OCphB0Ve0XbA=
X-Google-Smtp-Source: APXvYqzOV8PUu7s2C30nL0b2Ji/D+NRcNaZWjUeRvds0wRCU4lvNCj5oLvFofG0nHSw4N6EF80nDGA==
X-Received: by 2002:a19:ee12:: with SMTP id g18mr8741228lfb.58.1559405674583;
        Sat, 01 Jun 2019 09:14:34 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id e19sm1882392ljj.62.2019.06.01.09.14.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jun 2019 09:14:34 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id y13so10329595lfh.9
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2019 09:14:33 -0700 (PDT)
X-Received: by 2002:a19:ae01:: with SMTP id f1mr8899724lfc.29.1559405673566;
 Sat, 01 Jun 2019 09:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190601074959.14036-1-hch@lst.de> <20190601074959.14036-4-hch@lst.de>
In-Reply-To: <20190601074959.14036-4-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 1 Jun 2019 09:14:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=whusWKhS=SYoC9f9HjVmPvR5uP51Mq=ZCtktqTBT2qiBw@mail.gmail.com>
Message-ID: <CAHk-=whusWKhS=SYoC9f9HjVmPvR5uP51Mq=ZCtktqTBT2qiBw@mail.gmail.com>
Subject: Re: [PATCH 03/16] mm: simplify gup_fast_permitted
To:     Christoph Hellwig <hch@lst.de>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-mips@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Linux-MM <linux-mm@kvack.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 1, 2019 at 12:50 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Pass in the already calculated end value instead of recomputing it, and
> leave the end > start check in the callers instead of duplicating them
> in the arch code.

Good cleanup, except it's wrong.

> -       if (nr_pages <= 0)
> +       if (end < start)
>                 return 0;

You moved the overflow test to generic code - good.

You removed the sign and zero test on nr_pages - bad.

The zero test in particular is _important_ - the GUP range operators
know and depend on the fact that they are passed a non-empty range.

The sign test it less so, but is definitely appropriate. It might be
even better to check that the "<< PAGE_SHIFT" doesn't overflow in
"long", of course, but with callers being supposed to be trusted, the
sign test at least checks for stupid underflow issues.

So at the very least that "(end < start)" needs to be "(end <=
start)", but honestly, I think the sign of the nr_pages should be
continued to be checked.

                      Linus
