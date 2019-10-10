Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A402BC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE34218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r9XnX277"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733025AbfJJH5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 03:57:43 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43990 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfJJH5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 03:57:43 -0400
Received: by mail-ed1-f65.google.com with SMTP id r9so4556649edl.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 00:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=abZRbHtx5iae3osvif2/XET2yXd88kPrNl4NEXaM0H8=;
        b=r9XnX277LTpf7y0OwaeUmdL7TPJb44sg1GG0+Tz2Q8tSweblfMVFwsjE55CnbRbBWe
         /qnOwBACZtBt0HW8bItxWWfe7OCuxSyt+F5X9WUTj/rUTYwYUSVRtjixCCUr1y5JL4Lt
         RC2AqdRz46xKNoF82mIqpXp2fiW6OyuhByYfObVCIYHiEKkf6S7+iyAFM0P07H7+YaeD
         2ziYzqRu8hLDWFAdhO4XtnS4O1Oyx2QHx63pjl8w80sxWhSrBHcJtPAYrrEfkSpE3WXG
         vea2xUjE+DjiBwBudQG3TyrUd5+tPoc5PDsvv5cy8jkHTheiu5qQXE2+rGs8E6bf/0ZL
         DxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=abZRbHtx5iae3osvif2/XET2yXd88kPrNl4NEXaM0H8=;
        b=qx317RcLVFKaYFCfg4BjLc1n74f2xjdQ8u4toqFxJAUBdjWAVZ5FEhF3zQhV/4e8T+
         ntbUrj6loyoOKtotlpkLGSKjqRA3S86kyjjmeMFNzVqFG4TmToqIL8KDIqnhHzaEMCuD
         bJLRvky1skzbv/2AYoQHWDAt9jo5ZALLS6twNJECR67e/CXjevCOkTGj1nxZAOPbG/tZ
         8oHCHs4qk8anNQUjvrQ5mAcgrzFIxsp/5kyzheowkjUJZFX9Qshgf//DBEEi1Tfi3rUD
         VPPklgcF8ccTU2tiHzk6fnL71NNLerX33cH+HL/XyCcrjhVYxaPUDmRMtEs6Wg9pVm+/
         cCJg==
X-Gm-Message-State: APjAAAWWAeukIjHtLr6H0iuD17XOXpyM0ZBPGeoNUvF0UBqiJiGc8Iel
        wys1jGkbAWjnlkYQ0usRo/Zt7CM3hDmTTpyQzg==
X-Google-Smtp-Source: APXvYqwmEWgwvP25pdFXR/b7axk7PZGebrq9+ISuMjYmYXb+fFKqTjdRU+5bcRMveO8dou1dM4qt4eh/NyzH3otnpmo=
X-Received: by 2002:a17:906:2410:: with SMTP id z16mr6889645eja.120.1570694262042;
 Thu, 10 Oct 2019 00:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191008220824.7911-1-viktor.rosendahl@gmail.com>
 <20191008220824.7911-5-viktor.rosendahl@gmail.com> <20191009141114.GC143258@google.com>
 <CAPQh3wP93yF4R4LOabmBf8zqTgM7ZVT=_eZRPwgq5WKEESjnyw@mail.gmail.com> <20191009140804.74d9ab1f@gandalf.local.home>
In-Reply-To: <20191009140804.74d9ab1f@gandalf.local.home>
From:   Viktor Rosendahl <viktor.rosendahl@gmail.com>
Date:   Thu, 10 Oct 2019 09:57:31 +0200
Message-ID: <CAPQh3wO1zvwQf0zmb9_ro1spUo+CCxJFCgB2aQJWVW8KZoXQdA@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] ftrace: Add an option for tracing console latencies
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den ons 9 okt. 2019 kl 20:08 skrev Steven Rostedt <rostedt@goodmis.org>:
>
> On Wed, 9 Oct 2019 16:51:07 +0200
> Viktor Rosendahl <viktor.rosendahl@gmail.com> wrote:
>
> > Apologies, I should have replied there but I have been a bit busy the
> > last few days with other topics, and I felt a bit indecisive about
> > that point, so I just sloppily addressed the issue in the cover letter
> > of this new series:
> >
> > "I have retained the fourth patch, although it was suggested that is becoming
> > obsolete soon. I have retained it only because I do not know the status of
> > the code that will make it obsolete. It's the last patch of the series and
> > if there indeed is some code that will remove the latency issues from the
> > printk code, then of course it makes sense to drop it. The first three patches
> > will work without it."
> >
> > I thought that, since it's the last in the series, it would be
> > possible for maintainers to just take the first three if the last one
> > is not wanted.
> >
> > For me it solves a rather important problem though, so if the code
> > that will make it obsolete isn't available for some time, then perhaps
> > it should be considered as a temporary solution.
> >
> > Of course, if there is a commitment to never remove any knobs from
> > /sys/kernel/debug/tracing/trace_options, then I can easily understand
> > that it's not wanted as a temporary fix.
>
> There isn't quite a commitment to not remove knobs, but if a tool
> starts relying on a knob, then, the answer is yes there is :-p
>
> As this will hopefully become something we don't worry about in the
> future, I would rather have this be a kernel command line option. This
> way, it wont be something that tools can really check for.
>
> If you add a trace_console_latency option to the kernel command line,
> we can enable it that way. And then when it becomes obsolete, we can
> simply remove it, without breaking any tools.
>
> Would that work for you?
>

Sounds good to me. I will try to adjust the patch accordingly within a few days.

best regards,

Viktor

> -- Steve
