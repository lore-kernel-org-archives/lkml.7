Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CEEC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 22:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20BC2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 22:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbfD2WWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 18:22:25 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33259 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbfD2WWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 18:22:25 -0400
Received: by mail-lj1-f193.google.com with SMTP id f23so10932259ljc.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 15:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5qP8LPIS9WDXF+q33OLMR6KRblHE0TT1uumAzaN6KT0=;
        b=QKFSL/deTMOIdpGPkhEC6Sa5Tc3PDmxJ1ztlOZroRrlxBmc2bIh8FOBhFGZD+ByhKJ
         Wg+JVpJY0LLKBw/nuzqrRWp9pAp1p4ueIwRuq6HIY1374mAUaxvBASYaK1Suza6O4gAy
         t+hZlhJfCEaHwtbVNJRdUJ3CUn2MVhqRtfanVlx8y7lSYG0906FEfFJrRLGoIQjM1yJ5
         mkk6jsKk+h5zs+rswQZTMycT5q/fK8dqe1z7ifdfad9FiuI1EfPyfSJH/P4t34ZrSWy0
         wSdHAtChFnAKaeIrYFtIlvozFZOVVxHhjEZ4FGN3TSxuDkxxWsyjJYITl1WP29UkRBUB
         F2DQ==
X-Gm-Message-State: APjAAAWYUCd+L26f3lgAhpp5Lvd79fE1IkrSAdcJu4ew0PDN/n8esdtg
        ya2wjdKtLUfICeQo898xXfs9ZI1OT1BOSK5ilxUlKqKY
X-Google-Smtp-Source: APXvYqyFZYLdrVWAfiZGBUTfAQ0jQ8XQ1atTo8351Lb5qmzNE9slvzcJcGUpJTDRiGIet8unu7MfR9SsFwZcZRYPzKw=
X-Received: by 2002:a2e:8884:: with SMTP id k4mr10439134lji.138.1556576543331;
 Mon, 29 Apr 2019 15:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190417131531.9525-1-mcroce@redhat.com> <20190418154045.2ad0bd50e73a6e71c0fac768@linux-foundation.org>
 <1109DAD2-E25B-47A3-8381-E02260FE51B9@redhat.com> <20190419010714.GH7751@bombadil.infradead.org>
 <5C263FB9-DC10-4D51-B6E4-776ED03C0E9E@redhat.com>
In-Reply-To: <5C263FB9-DC10-4D51-B6E4-776ED03C0E9E@redhat.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Tue, 30 Apr 2019 00:21:47 +0200
Message-ID: <CAGnkfhyhFUyL6wBT81XntCL92SgFoyz70cA0BahiBMVRuwd5fg@mail.gmail.com>
Subject: Re: [PATCH v3] proc/sysctl: add shared variables for range check
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 5:28 AM Matteo Croce <mcroce@redhat.com> wrote:
>
> On April 19, 2019 10:07:14 AM GMT+09:00, Matthew Wilcox <willy@infradead.org> wrote:
> > On Fri, Apr 19, 2019 at 09:17:17AM +0900, Matteo Croce wrote:
> > > > extern const int sysctl_zero;
> > > > /* comment goes here */
> > > > #define SYSCTL_ZERO ((void *)&sysctl_zero)
> > > >
> > > > and then use SYSCTL_ZERO everywhere.  That centralizes the
> > ugliness
> > > > and
> > > > makes it easier to switch over if/when extra1&2 are constified.
> > > >
> > > > But it's all a bit sad and lame :(
> > >
> > > No, we didn't decide yet. I need to check for all extra1,2
> > assignment. Not an impossible task, anyway.
> > >
> > > I agree that the casts are ugly. Your suggested macro moves the
> > ugliness in a single point, which is good. Or maybe we can do a single
> > macro like:
> > >
> > > #define SYSCTL_VAL(x) ((void *)&sysctl_##x)
> > >
> > > to avoid defining one for every value. And when we decide that
> > everything can be const, we just update the macro.
> >
> > If we're going to do that, we can save two EXPORTs and do:
> >
> > const int sysctl_vals[] = { 0, 1, -1 };
> > EXPORT_SYMBOL(sysctl_vals);
> >
> > #define SYSCTL_ZERO   ((void *)&sysctl_vals[0])
>
> Hi Matthew,
>
> I like this approach, regardless of the const or not const extra1.
>
> I'll be AFK for a few days, then I will investigate if extra1,2 can be made const and then prepare a v4 with the single export.

Hi all,

I turned extra{1,2) to const and I see no issues.
I'm sending a v4 with extra{1,2} const, a single export for all vars
as suggested by Matthew, and the define suggested by Andrew.
Comments are welcome as usual.

Regards,
--
Matteo Croce
per aspera ad upstream
