Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D1FC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 05:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B72222C4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 05:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sDJI+baR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392385AbfIZFsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 01:48:13 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35824 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392337AbfIZFsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 01:48:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id a24so900270pgj.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 22:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XptaLUwU65jjbOqDPjMlN4CkPI1uiW9/0c4wfJJnTj0=;
        b=sDJI+baRANeUYQZ+eQWgxjGC2Op+xufIkS1uW8u232Epz+rvNlV2vRJn5Qrrcwx29N
         FIfwr1ldcd0Z5iYDDyYCKoyld1l5x40ubmmeo/lNzyt8hVFfo7kS7mHk4jnlNAiX7XXy
         ch3VczAxRhr/1PI6+ztozY/Lq/qhwImisZkCEQw+qjR6geMMIm3KcPriDfrQ8w7Q/l+G
         myue6HI/WWVgJt16viKKdODiKuohXJ8eeGjD3Bdf2brWSNrNkrCCSKvhKBkPImq8jrek
         kgkTw19FZB/5Spo/9o9G9ANgMrJU/x+6/RJdLcFCNMPxe7WvSiQx7vHSM42+JE+QPsAR
         FhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XptaLUwU65jjbOqDPjMlN4CkPI1uiW9/0c4wfJJnTj0=;
        b=XhTH1oskLW572Cg4ogHx93uH0jaD+492soz7HNure8aV7jUebC/feKjm9yJL6wDUJq
         42u5ZLKtv64SQ1Xz7nvGoSDjcKlpKe8h2aWP59HDKVBdknrMklHLN+RZpWAds0nz7U0h
         ztCGkGDtob9LyHmpzYLghLzBDedBOrAhf+ysigKe9YydCSh5LuNQ+14LjVuKrNNGPkbM
         RTEludgcTzx8HIvfsVeT6ro/ZObVxwpZp3KcCXYGcyb+5VWX8cuQiORec7kgo2RZpdp8
         WSqIcyfid9oonc7unpZtGXm6l6IwvMArXA+9Gb8gqi/hxxgwPIMe/dx8opEuGhmyxTnv
         1QIQ==
X-Gm-Message-State: APjAAAWwToUda74LFWLKDj273JXpJQdkprTT1HXwKrE/obSSJ3ocDWdv
        OeP76LiBDJz76JF9ghd4Ld8fhvfH1+1b+RS2S24=
X-Google-Smtp-Source: APXvYqzBxzIGNSWGQC8Usmc61FE2E4uL2g2OeITh9jenE6ut8Z+xIImoBr0uFk7QHc3TBJnRO99WGGOWdqV0PIt4R6Y=
X-Received: by 2002:a62:d101:: with SMTP id z1mr1742679pfg.151.1569476892265;
 Wed, 25 Sep 2019 22:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VdQES5oasGzi0JdnZAEL2AfCozHJaHBa9dpg1Ya_N17-A@mail.gmail.com>
 <20190920111207.129106-1-wangkefeng.wang@huawei.com> <20190920111207.129106-3-wangkefeng.wang@huawei.com>
 <CAHp75VesyCCKqHKfa-L9gW7sufJZs2Tm60OgrgkY_H0ZcEuDYA@mail.gmail.com> <627e842d-cd00-e370-643f-fcaa0222cad5@huawei.com>
In-Reply-To: <627e842d-cd00-e370-643f-fcaa0222cad5@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 26 Sep 2019 08:48:00 +0300
Message-ID: <CAHp75VcyuaWYLAQZhwvPLO=JHKUpuTujSEAQL1PMeV5jK7QnCw@mail.gmail.com>
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

On Thu, Sep 26, 2019 at 4:29 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> On 2019/9/25 23:04, Andy Shevchenko wrote:
> > On Fri, Sep 20, 2019 at 1:55 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> > You have to send to proper mailing lists and people.
>
> Used get_maintainer.pl to find the people, and all already in the CC,  will add proper maillist into each patch.
>
> > Don't spam the rest!
> Not so clearly, should I not CC other people not in the list below?
>
> [wkf@localhost linux]$ ./scripts/get_maintainer.pl pr_warning/v3/0018-platform-x86-eeepc-laptop-Use-pr_warn-instead-of-pr_.patch
> Corentin Chary <corentin.chary@gmail.com> (maintainer:ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS)
> Darren Hart <dvhart@infradead.org> (odd fixer:X86 PLATFORM DRIVERS)
> Andy Shevchenko <andy@infradead.org> (odd fixer:X86 PLATFORM DRIVERS)

You put a lot more people in Cc, than above list contains.

> acpi4asus-user@lists.sourceforge.net (open list:ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS)

> platform-driver-x86@vger.kernel.org (open list:ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS)

This had been absent in your submission.

> linux-kernel@vger.kernel.org (open list)

-- 
With Best Regards,
Andy Shevchenko
