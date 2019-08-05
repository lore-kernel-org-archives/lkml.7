Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72ACC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA58C214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565029280;
	bh=7ay6wCzrCYZ7STww6F38sr5K1boDOH6OylBRvj6rcbA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OycKywcJXRBQdVZTSZwLBahDOUG+cc+4xpr/puMDxWkuHj6ufJPwaXyqjQ7XLTvo1
	 fTqsZcm6AD3oWVx0QTkCOYhidKOIczMnsV0TxRGl+HcbnKFybi5CXE42lO2wNBpyct
	 U115P39C+MMzvuBaycqHTaY4A9XDsOl9u6gN3S+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbfHESVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 14:21:19 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43822 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbfHESVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 14:21:19 -0400
Received: by mail-lf1-f68.google.com with SMTP id c19so58768886lfm.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 11:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WGQ5IB84E7mhKplViJK5IrEC3u7IzYyrnw83fJb3J2I=;
        b=CLhlvp6oMG8Ynt6VPrXmi8rSjn6ZKK/3dkRZCW83Uk58mLwN52g7vuodlXSP55jKd7
         F4LA1YdX8tA54qpVwhkDFvL7lHM6G2zE0lqeWe0lqMijcj8j0HopsDCHXiJ4L55BgPMJ
         6kDvCBK2ELmZP/VK4yyFLL/MPNcWLz/M4kXFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WGQ5IB84E7mhKplViJK5IrEC3u7IzYyrnw83fJb3J2I=;
        b=IBRwFDfe2ITWzgCvkKe2CN1+3x55o2nfM21lG/9nS1+necZcld6WHT78nlLWALTNeh
         MsgcDRTZguNpi7BI/qFqSjAoCdKLSeSuSmP9KpKkvtPQQ34hVjw8XNFeu0SsX+PtZVo7
         gwsCcx9v6nOe3RzUqiKaZvVyoeP3mpLfoM3Ul1oa7v26GYXlMrtitSyIeDoHHRgHXWnm
         AoDqPRASqvzRf5npEZKO9jLMyPkazoFZ3x+F1OAOdjGXiecxjfTwAHuBfGb0h4Oo3OVn
         MPDTKxwcCH4FhRqgH3nBPtJEL//xmHu1WYtng23VcRMiYDfFq2TTmIxyQhrQ30RIKMGg
         IJAQ==
X-Gm-Message-State: APjAAAU1/SwsOLqYnLBnnPGnFVMwcM1QnWPeRmW3Yc/0XSVCxT6+XtZR
        pWEWdjjrgYIerPDDPkJr1t67VwKhKsE=
X-Google-Smtp-Source: APXvYqyfbgUpF85WWNf0+Eplof2v4YhXEBP9PeaKFCUrpsHKSdr8fU1stMWkFbnu526ZXl8LbHW0Bg==
X-Received: by 2002:a19:c213:: with SMTP id l19mr53344611lfc.83.1565029276964;
        Mon, 05 Aug 2019 11:21:16 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id u18sm14972024lfe.65.2019.08.05.11.21.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 11:21:16 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 62so53902821lfa.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 11:21:16 -0700 (PDT)
X-Received: by 2002:ac2:428d:: with SMTP id m13mr7524597lfh.52.1565029275746;
 Mon, 05 Aug 2019 11:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccMXEVktpuPS5BwkGqTo++dGcpHAuSUZo7WgJhAzFByz0g@mail.gmail.com>
 <CAHk-=whZzJ8WxAeHcirUghcbeOYxmpCr+XxeS9ngH3df3+=p2Q@mail.gmail.com>
 <CAJ-EccOqmmrf2KPb7Z7NU6bF_4W1XUawLLy=pLekCyFKqusjKQ@mail.gmail.com>
 <CAHk-=wgT7Z3kCbKS9Q1rdA=OVxPL32CdBovX=eHvD2PppWCHpQ@mail.gmail.com> <20190805142756.GA4887@chatter.i7.local>
In-Reply-To: <20190805142756.GA4887@chatter.i7.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 5 Aug 2019 11:20:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgdiiBVprEVoi8+mpicGnOVNZ4Lb9YUJVskOXahO50sXw@mail.gmail.com>
Message-ID: <CAHk-=wgdiiBVprEVoi8+mpicGnOVNZ4Lb9YUJVskOXahO50sXw@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID MAINTAINERS file update for v5.3
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Micah Morton <mortonm@chromium.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 5, 2019 at 7:28 AM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> On Sun, Aug 04, 2019 at 10:47:54AM -0700, Linus Torvalds wrote:
> > - maybe pr-tracker-bot ignores follow-up emails with "Re:" in the
> > subject?
>
> Yes, this is the culprit. Here are the matching regexes:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/mricon/korg-helpers.git/tree/pr-tracker-bot.py#n41
>
> Normally, pull requests don't come in as replies -- this is the first
> one that got missed in months, to my knowledge.

Most pull requests certainly are proper starts of threads. And I
generally wish they were, because I know I myself tend to skim over
emails much more quickly if it's some old discussion that I either
consider solved or where somebody else is handling it, so if I see a
pull request in the middle of a thread, it's much more likely that I'd
miss it.

It does happen, though. Not just in situations like this, where I
replied to the original pull request with some reason for why I
wouldn't pull it, and then the fixed pull came in as part of the
thread.

Al Viro does that to me occasionally, for example. Some discussion
about a vfs problem, and then the pull request is in the middle of
that thread. You can see an example of that here:

     https://lore.kernel.org/lkml/20180125002151.GR13338@ZenIV.linux.org.uk/

although in that case it was Davem who merged it (in merge commit 8ec59b44a006.

Of course, pr-tracker-bot wouldn't have noticed that one anyway,
because it also doesn't have "GIT PULL" or anything like that in the
subject line at all. So maybe it's not a great example.

I don't know if it's worth changing the pr-tracker-bot rules. I *do*
think that the whole unquoted

   for you to fetch changes up to [hex string]

is by far the strongest single signal for a pull request, but it's not
clear that it's worth spending a lot of CPU time looking for that
unless you have a strong signal in the subject line.

So I consider this "solved", and maybe people should just realize that
they won't get the automated responses unless they do everything just
right.

                  Linus
