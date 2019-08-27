Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C90C3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 05:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A416F20828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 05:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="n7XMRyf/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbfH0FtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 01:49:03 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43604 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfH0FtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 01:49:02 -0400
Received: by mail-ot1-f66.google.com with SMTP id e12so17548710otp.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 22:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7RBGb3OLJpAQau2j2snbl6ZXBD+gjXfBLYIYixGrB0c=;
        b=n7XMRyf/Ux88Ml8xjGhdXA9Q3iFgJtT0BpZPsWc98cEcFJ6TQiYB0p3+BFgdYbK0ks
         Eu6G39nq/TPJjUAhyfj0u+5OUinp0KQQSzJb09SUoRMsiIXwOyxTb5qs0uc/7EP8YyrJ
         W0wpqtSvCeW+9p6v4bb2bvW6uJsUMRjVaHF1W+6kItySBxerIkc2Qt5F8b8CAxBSG8f6
         beq5q5PWSa66mvnAnFGcQ60seo1+/Fc4DBSkpO6xcYSrysoRPzNKuhGk/92p3SlULFnL
         VitTGP0DJ0qVGff0ycBHaSWfSQ5vpt3KcbNH2fMIMCskHaD0I0YeRxiE1UqwrywY3q4F
         x3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7RBGb3OLJpAQau2j2snbl6ZXBD+gjXfBLYIYixGrB0c=;
        b=hcNqbJVCj3HZWdsINPJDgSAeAELSH9B2oizJ6qQV+8P4pc3rjcRirs7K1yDAeXhQBV
         V8vZJFYefFCGcBma726vqf+nvPqQMqKrBAQxTBMgSU3m5FdVNudzR8qAomIT5ZSF3Plk
         sUgZw4fZCECAPRua77l1Y2Bq5+LuXBxNgCR0QiS4mC6LXLKc4xAwrr5HhBu8y8VWVWk5
         ujdAZB9EWyK3Foo09Y6dW0PeY/lflb9TJa2/vXp1Ge0mzPD3Xqabbi7maSEtWjU6QxFQ
         W0xQyHXYPanzfUmzrtgZlyHFUbDxZGKLvviqta9HQ6LCLPkMHHBp5ogkTCcxsss5fSjs
         aaQA==
X-Gm-Message-State: APjAAAXY0q1iw5i/MyATJ5hXnOFrtevjsfXBbt8sINx7EkXphkw26J3O
        x2FRpv9dkoKMb+mf9JEIvfu5UCw0bR96DAHkH5x7bA==
X-Google-Smtp-Source: APXvYqyHt3ylRYIOT6ImiUvFQ/SX/9gr7Aon0ozM+XiDQ3ga7QMUZtYdtrQMwzADy4l4V7UM7IwD4lDixKw+wDlCjEs=
X-Received: by 2002:a05:6830:458:: with SMTP id d24mr12220534otc.126.1566884941281;
 Mon, 26 Aug 2019 22:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <155993563277.3036719.17400338098057706494.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155993567002.3036719.5748845658364934737.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190607202332.GB32656@bombadil.infradead.org>
In-Reply-To: <20190607202332.GB32656@bombadil.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 26 Aug 2019 22:48:50 -0700
Message-ID: <CAPcyv4gU_AfUoh7certr31f+7eZWfkEVqmNLtY2v7H54BxZK1w@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] lib/memregion: Uplevel the pmem "region" ida to
 a global allocator
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        X86 ML <x86@kernel.org>, linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 7, 2019 at 1:23 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Jun 07, 2019 at 12:27:50PM -0700, Dan Williams wrote:
> > diff --git a/lib/memregion.c b/lib/memregion.c
> > new file mode 100644
> > index 000000000000..f6c6a94c7921
> > --- /dev/null
> > +++ b/lib/memregion.c
> > @@ -0,0 +1,15 @@
> > +#include <linux/idr.h>
> > +
> > +static DEFINE_IDA(region_ids);
> > +
> > +int memregion_alloc(gfp_t gfp)
> > +{
> > +     return ida_alloc(&region_ids, gfp);
> > +}
> > +EXPORT_SYMBOL(memregion_alloc);
> > +
> > +void memregion_free(int id)
> > +{
> > +     ida_free(&region_ids, id);
> > +}
> > +EXPORT_SYMBOL(memregion_free);
>
> Does this trivial abstraction have to live in its own file?  I'd make
> memregion_alloc/free static inlines that live in a header file, then
> all you need do is find a suitable .c file to store memregion_ids in,
> and export that one symbol instead of two.

It turns out yes, this needs to live in its own file. It's an optional
library that does not fit anywhere else, everywhere I've thought to
stash it has either triggered obscure build errors based on idr.h
include dependencies or does not fit due to build dependencies.
