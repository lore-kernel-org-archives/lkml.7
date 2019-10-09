Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EA4C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81CB206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KdRyUgsn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731695AbfJIQlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 12:41:12 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40162 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731083AbfJIQlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 12:41:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id x127so1965079pfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 09:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4KCOuyU/ywH5UdEeKKy1ZD5cSa0qM6JRtRuTi6ZEGfg=;
        b=KdRyUgsnV+XebI3lT10g3MSaM0BW6c17+YU4pUx+2eA+C9am1YEdku6d6tBGCdXm2c
         W04Hb/MWT6rZjMR+dwzmQq1sDhw8PjMnfxOk6EG4alrLHwtojAXHHcvd1/2vZaNj1ikx
         4lIXwa8qgSRdy9uDvik5vjDrWjfTTdwTGAmkqU1AGTC4I3a1alWEbZTXvqYuNB7MgXFh
         RyMjomorAY5pHNMW1A29VDRSLitZHRhdG0Fz7giZTJXeaiLPM8EHhjTh7a9sVdAkXwni
         +9xyhywhTJsFJEz/Ely4TDIoHVC0Us0NGQszz6LqNiaUU/Ulh03mZCkJGJkmBMElv0DZ
         l6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4KCOuyU/ywH5UdEeKKy1ZD5cSa0qM6JRtRuTi6ZEGfg=;
        b=slVITVD2CgBv9zw2ML7U4uCw3V6h5zqRsJJ9GOohtNIuMiZ/ybNrzqoqhfQQ8ZrOyD
         fv1YklLRvfsfRncJtf90WDF6dfm7Vl6T8DcErLm/vYX2/UKjkiYFMxpVUSVMSWvc860a
         kWh0OYtlwOE6B3+lweBH7r84nxqAiNiuRksd/KMpRMJKkRoXHSVQ+7PAKKQkfa3kZLVl
         Cet7KxqBgqF1rgHyK0rcWJjn4Eb1aMTLB3eEU3QkK6xvgmUpxcZer/N0o8NpoPswuF1r
         LI+REdxx0LlMSWsUAOY778czGwrJdvdNYGN9fwjNajVI+poScOiLD0DPxKYdb2IXKVwO
         a3pw==
X-Gm-Message-State: APjAAAWmYbkbDIR8fQZYE9wKejuQvI6ErY7LIVq4EYkqsT4zY91sw1aK
        EzU6tjwnsjT38L3xQj7XhR0q4CthaX6tsKUhq12Efg==
X-Google-Smtp-Source: APXvYqxxtqdLlqdJ+oeX5eyUnxCGbj6bA/T+ZV6iNXBuLdhXsG5XJ83Ds5MVom+4xZBSMAzFV1PS/jlj78IrXr5cH9Y=
X-Received: by 2002:a65:464b:: with SMTP id k11mr5449394pgr.263.1570639271341;
 Wed, 09 Oct 2019 09:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <75f70e5e-9ece-d6d1-a2c5-2f3ad79b9ccb@web.de> <20191009110943.7ff3a08a@gandalf.local.home>
 <CAKwvOdk3OTaAVmbV9Cu+Dzg8zuojjU6ENZfu4cUPaKS2a58d3w@mail.gmail.com> <20191009122735.17415f9c@gandalf.local.home>
In-Reply-To: <20191009122735.17415f9c@gandalf.local.home>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 9 Oct 2019 09:40:59 -0700
Message-ID: <CAKwvOdkvgeHnQ_SyR7QUqpsmtMPRe1SCJ_XJLQYv-gvLB6rbLg@mail.gmail.com>
Subject: Re: [PATCH] string.h: Mark 34 functions with __must_check
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 9:27 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 9 Oct 2019 09:13:17 -0700
> Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> > On Wed, Oct 9, 2019 at 8:09 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > I'm curious. How many warnings showed up when you applied this patch?
> >
> > I got zero for x86_64 and arm64 defconfig builds of linux-next with
> > this applied.  Hopefully that's not an argument against the more
> > liberal application of it?  I view __must_check as a good thing, and
> > encourage its application, unless someone can show that a certain
> > function would be useful to call without it.
>
> Not at all, I was just curious, because I would have expected patches
> to fix possible bugs with it.

Ah, granted, I was surprised, too.  Maybe would be helpful to mention
that in the commit message.
-- 
Thanks,
~Nick Desaulniers
