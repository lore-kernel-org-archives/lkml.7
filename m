Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FFEC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 07:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1269222C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 07:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajZuDc4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbfIZHc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 03:32:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37297 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729053AbfIZHc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 03:32:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id y5so1320479pfo.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 00:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o/J6iHI85e+wEB++J3d1QKg3q1i6YzasUsRz3PmFc4k=;
        b=ajZuDc4iRSYZBy9r1XWsFfH0e9ars1+g2ccxyEQJ+jQtSq2TiiPrpGtUG/BQ8+2Buf
         eBVVb24Y9s9AjLZ9/f03bYp8RI008QVUvw2WG/d3yVsBuCYq4XDt0mEdN5JOtV8fqWjm
         E+IrgoDlXeTbSOP7x3OGehi73nW4QM29GfRKNQuyavPst966P1fo/rs3szamcXOf9lZe
         egYdXUv0QmJy2AP/qZ0W5LLcwRZi/HUabHIpEqENS4PuxedTz6eSIzhw7EC30PtUCgXL
         dm77GJUrCiqmV4/tf/w5E+HMQbLqpeaku79Tw/Nl+JaKKWWjDuCWVjqzBaHa0Yryvbpk
         /KFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o/J6iHI85e+wEB++J3d1QKg3q1i6YzasUsRz3PmFc4k=;
        b=Z7PWcuPXWuca0EWwSxeX8RmzqD3J0zFREEt3vyLgW1ZzxAAH8aNruOdxdh6y18Eqp3
         Jh3QOJA8Q/agdF6yD9SuYoxMF9zKGKXdE+LVAneOGLxqVYnbK83av6pTg8fzNhF5QYvD
         o+b9em9dab/1MmjmkStAPqXV3leMEVmYp9kK4KqXJ0YQTQyM8uLpxb5v4VcNi8pnaK6F
         96XR2epPJF9fo+zYNpXuyUixP5f1FPprT/m8nXobI/8PGXAUDV6bbIo894e6lg/BWz7l
         OmLisSE2i2MVZ8CAG2Is+vlYDhK/5YmGjzwnkHms3zRO1SVK4OTwBwfEt8KSQqtvT4EQ
         Wwqw==
X-Gm-Message-State: APjAAAXzX33fem3hDKgFFrB268HD9dq3pEtcKPGY85V0Dwl4PpJ5v/7u
        EabZNxu/Gp/EjCF4fyIGinsGpNmhQ+jqFvlHzdAmqWRHSh0=
X-Google-Smtp-Source: APXvYqyQfY+TlTYmegrKxmmmUZOEYuUkfGZlH4ElJdg36mxg2eozME8NEVwyTUOIF2I55gNM3viOx6tpZmr9klzQ6XM=
X-Received: by 2002:a63:170e:: with SMTP id x14mr2036279pgl.4.1569483145379;
 Thu, 26 Sep 2019 00:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VdQES5oasGzi0JdnZAEL2AfCozHJaHBa9dpg1Ya_N17-A@mail.gmail.com>
 <20190920111207.129106-1-wangkefeng.wang@huawei.com> <20190920111207.129106-3-wangkefeng.wang@huawei.com>
 <CAHp75VesyCCKqHKfa-L9gW7sufJZs2Tm60OgrgkY_H0ZcEuDYA@mail.gmail.com>
 <627e842d-cd00-e370-643f-fcaa0222cad5@huawei.com> <CAHp75VcyuaWYLAQZhwvPLO=JHKUpuTujSEAQL1PMeV5jK7QnCw@mail.gmail.com>
 <6251b209-ed1a-78ff-51df-ca0e663f5b05@huawei.com>
In-Reply-To: <6251b209-ed1a-78ff-51df-ca0e663f5b05@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 26 Sep 2019 10:32:14 +0300
Message-ID: <CAHp75Vd4DNqY-m6cz0t2Bg6ZS=v3qQ1oagYgbUwfd4daxLTyFA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] platform/x86: intel_oaktrail: Use pr_warn instead
 of pr_warning
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 9:09 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> On 2019/9/26 13:48, Andy Shevchenko wrote:
> > On Thu, Sep 26, 2019 at 4:29 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> >> On 2019/9/25 23:04, Andy Shevchenko wrote:
> >>> On Fri, Sep 20, 2019 at 1:55 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> >>> You have to send to proper mailing lists and people.
> >> Used get_maintainer.pl to find the people, and all already in the CC,  will add proper maillist into each patch.
> >>
> >>> Don't spam the rest!
> >> Not so clearly, should I not CC other people not in the list below?
> >>
> >> [wkf@localhost linux]$ ./scripts/get_maintainer.pl pr_warning/v3/0018-platform-x86-eeepc-laptop-Use-pr_warn-instead-of-pr_.patch
> >> Corentin Chary <corentin.chary@gmail.com> (maintainer:ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS)
> >> Darren Hart <dvhart@infradead.org> (odd fixer:X86 PLATFORM DRIVERS)
> >> Andy Shevchenko <andy@infradead.org> (odd fixer:X86 PLATFORM DRIVERS)
> > You put a lot more people in Cc, than above list contains.
>
> This is a treewide change, and finally kill pr_warning in the whole linux code, so I add more people into Cc list.

No _this_ is change for only one subsystem / driver.
Since the set is of independent patches, you may add all people to
cover letter which I happened not to see and to the patches that are
core of the series (like one with pr_warning() kill).

For now I considered them as completely independent to push thru my tree.
In any case you have to carefully choose the Cc list per each patch in
a treewide changes.

> Here is a brief discussion about how this be picked up,  is this ok for you?
>
> https://lore.kernel.org/lkml/82fe3d04-2985-7844-31bb-269655c83873@huawei.com/

I haven't got this. Care to do what I said above about cover letter
and tell all stakeholders what you are expecting from them to do.

-- 
With Best Regards,
Andy Shevchenko
