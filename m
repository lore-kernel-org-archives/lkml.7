Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027A1C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C567F2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nArkzuvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfDKRAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:00:38 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35939 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfDKRAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 13:00:37 -0400
Received: by mail-vs1-f67.google.com with SMTP id n4so3913904vsm.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 10:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PL+/ApLhDtv/wuvORoq89qLIs51XROLHFnFu0SSGf9A=;
        b=nArkzuvOWz6ap6xqQ7o4EL4Pj4K5clN+0yGEVjAynJHikPUUMmeE24oEmeGQBKodA6
         V81t5+MrdU9vD1lRQhVXrFeOkz6KrQpWLK7rXWl/4QY55WClp86EeACiDxPF91ji4mQZ
         tM0wF2tqj6OUD5DxCGsABtDJw58PU39ITFxJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PL+/ApLhDtv/wuvORoq89qLIs51XROLHFnFu0SSGf9A=;
        b=gsZ6eNrMvrE1WQpQQclaSE0lSGgUKXHquU7lTBaHVTrZ5HqwPP4V/DA4CcGhAt8ynN
         ye180YKpmEc1jML/19LvA7RH/SB5TnIbhrfHTTph3Vt1MQC1edsKsW8t6Jlk7rhulnNd
         m6LUEO06+Had2GnmjJDvGiW5RVZjcBIb8qKqdcJsSGJBvIW9fG736rkyNsa1VeOtk+Sj
         o2dLBGUHUhPMZ11/pCKtmrxh29QZ5/OQ3oi+bemZrQDHAS9qQ18amEHlhACX+jWrSbKa
         BO+owjwU0kzeO32BWh+Kw05tgPmtOao1+FRWlGQlcm/m3k5kTMTWg8W0A+uEcpuQS8ev
         ufEg==
X-Gm-Message-State: APjAAAVxEnn7oJMtA1mEmB9XTyN+mLDH1lsl7nsb1KDp/6nzzSMf+C5A
        686B07LxsIiQ6cjWqoE0b4BxxD5nAEo=
X-Google-Smtp-Source: APXvYqzpwOfUhPRHhV0aEYlvhXtpSLuFrtH9Yk1pDk7VqL5Igog6txL33nO6T0LEws67IAOWusBRxA==
X-Received: by 2002:a67:f256:: with SMTP id y22mr12439651vsm.19.1555002036914;
        Thu, 11 Apr 2019 10:00:36 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id x80sm9585893vkd.22.2019.04.11.10.00.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 10:00:36 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id g24so1534553vki.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 10:00:36 -0700 (PDT)
X-Received: by 2002:a1f:264b:: with SMTP id m72mr17588022vkm.43.1555002035746;
 Thu, 11 Apr 2019 10:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190411005634.8495-1-okaya@kernel.org> <CAGXu5jLU8Nh0+9rMSeOxwv4hUoPFWSiGf_L_SKpSHO_=VZxisg@mail.gmail.com>
 <CAK7LNAQqcKjs6Cnp5fK8OYhj2G_xbXpZc3WtTany3D+=RUpaew@mail.gmail.com>
In-Reply-To: <CAK7LNAQqcKjs6Cnp5fK8OYhj2G_xbXpZc3WtTany3D+=RUpaew@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 11 Apr 2019 10:00:24 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKnMUH_Gavg+6Q4ft98GxYZ49Z=fzUTHhzkfONSCL4ARg@mail.gmail.com>
Message-ID: <CAGXu5jKnMUH_Gavg+6Q4ft98GxYZ49Z=fzUTHhzkfONSCL4ARg@mail.gmail.com>
Subject: Re: [PATCH v3] init: Do not select DEBUG_KERNEL by default
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Sinan Kaya <okaya@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 10:34 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Thu, Apr 11, 2019 at 11:47 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Wed, Apr 10, 2019 at 5:56 PM Sinan Kaya <okaya@kernel.org> wrote:
> > >
> > > We can't seem to have a kernel with CONFIG_EXPERT set but
> > > CONFIG_DEBUG_KERNEL unset these days.
> > >
> > > While some of the features under the CONFIG_EXPERT require
> > > CONFIG_DEBUG_KERNEL, it doesn't apply for all features.
> > >
> > > It looks like CONFIG_KALLSYMS_ALL is the only feature that
> > > requires CONFIG_DEBUG_KERNEL.
> > >
> > > Select CONFIG_EXPERT when CONFIG_DEBUG_KERNEL is chosen but
> > > you can still choose CONFIG_EXPERT without CONFIG_DEBUG_KERNEL.
> > >
> > > Signed-off-by: Sinan Kaya <okaya@kernel.org>
> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> >
> > Masahiro, should this go via your tree, or somewhere else?
>
>
> I think somewhere else.

Okay. Andrew, can you take this?

-- 
Kees Cook
