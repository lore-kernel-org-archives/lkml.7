Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B75C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6A621848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VpbQlUwj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732185AbfJIReK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:34:10 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:37678 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731919AbfJIReK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:34:10 -0400
Received: by mail-pf1-f177.google.com with SMTP id y5so2068352pfo.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 10:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UjqBpI06iiBQsYq2V/w1u3B49phxB0GEC0jogQFNuAQ=;
        b=VpbQlUwjjLfHn3Nl+VhVs9C7cU3yzf7C0n4quuU8lytEoqyUJC0yVNtMeHEZxONwBG
         +eV+gN3RZwnzE7CxdlcBlpmJZraEgcFjy2kIGL6jfc/1KK+D8rNWCiTKduAB3N91NGvj
         cQhRgcL9EpWrytbjz1xyIeg327Oyr2RrgIQn04UvW3L7ffdwYj/uGlzs5ITF5lphYCOT
         8RTQY1UykssE6uoOOc8lVJG8jdMk3eNpBL6a1Er12MGcEzMBrhbz/GG0unCR7nXMnCZs
         W/OHJSaChQcwRhiX4KQjVyBnvdmlpCn+i1k6ns8NjGzkY2C5ENY+sqH72upAzEDIjRkh
         uN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UjqBpI06iiBQsYq2V/w1u3B49phxB0GEC0jogQFNuAQ=;
        b=KWOIsrLMFpafTKdZhJIgJ6SbAudPYs3gPJDUHXGvpIjTpwQ38gpoKVq5p6hud+qCA7
         Cj4zpH+EtGwU1P4SWe7yPuEQOKn9Bgv52MY+Vb0MyiaStimvQGedhWOH9AKca/+iKEQt
         DIl9cGpWf4RplMCmHTSNQ7VrDjW5uuWs4xx3ByRM1YkK/ncUApGMjs3PZv5WeD4+wOBy
         W4qiTamhPsnvAcY9GDe3nUSXL/bJZyDAW2JtklrfbfiCQhuZbIBS1gwiLE061d04+jwH
         VqPQuRG1/V7d7sqhHXMTk0Z2/DO+cbzyDYff67453zHBiVVSSQiGCqQyB4uOrWu1evfD
         v8Sw==
X-Gm-Message-State: APjAAAUhrtYsPnCy8imUCtLgNAGVOv7gHZvNY++9btTLTeylAnU6uFAk
        J7ydMZ0scElnyuauhgBKoBEhGEdztreRPSu4peGvpg==
X-Google-Smtp-Source: APXvYqwqUks7z0CCplcskgsaNVDeVXtoWQQW90hGAq5OkREAcD/1wk1zlhagtSzy/wUXtmb6E4JS72pJV8olbVRaXeg=
X-Received: by 2002:a63:5a03:: with SMTP id o3mr5500405pgb.381.1570642448938;
 Wed, 09 Oct 2019 10:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <75f70e5e-9ece-d6d1-a2c5-2f3ad79b9ccb@web.de> <20191009110943.7ff3a08a@gandalf.local.home>
 <CAKwvOdk3OTaAVmbV9Cu+Dzg8zuojjU6ENZfu4cUPaKS2a58d3w@mail.gmail.com>
 <20191009122735.17415f9c@gandalf.local.home> <CAKwvOdkvgeHnQ_SyR7QUqpsmtMPRe1SCJ_XJLQYv-gvLB6rbLg@mail.gmail.com>
 <b8bdfb25-deb8-9da0-3572-408b19bb0507@web.de>
In-Reply-To: <b8bdfb25-deb8-9da0-3572-408b19bb0507@web.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 9 Oct 2019 10:33:57 -0700
Message-ID: <CAKwvOd=Jo5UkQN9A9rTJf0WtsxXNjaJ=jxf2gwHFdW8om-fbTQ@mail.gmail.com>
Subject: Re: string.h: Mark 34 functions with __must_check
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        kernel-janitors@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 10:04 AM Markus Elfring <Markus.Elfring@web.de> wrote:
>
> > Ah, granted, I was surprised, too.
>
> Thanks for this view.

I mean, it's a good thing that we don't have any issues that this
patch would catch today.  Seems Steven and I were surprised
(pessimistic?).

>
>
> > Maybe would be helpful to mention that in the commit message.
>
> My Linux software build resources might be too limited to take
> more system configuration variations safely into account
> for this issue.

That's understandable. I think if the patch bakes in linux-next, it
might flush out some problematic cases in other ARCH's.

> Would you like to achieve further checks here?

I reviewed the functions here and believe the ones you added checks
for all look good.  I value Rasmus' feedback, so I'd like to hear what
he thinks about my earlier comments.  I have no comment if we should
go further/annotate more, other than that that can be done in a follow
up patch.  Though Joe's comment on the relative order of where the
annotation appears in the function declarations should be addressed in
a V2 IMO.
-- 
Thanks,
~Nick Desaulniers
