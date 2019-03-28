Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE697C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE77C2186A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553806613;
	bh=W/Wxmp0XycESAD7gJuwLziX+ntp6DLCkTd81eY+Tf1Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=amYlPpJC/9JEJQjX9EWwzS+gGkimjZzMxT40m+hR5NLJusW8YYZa/XJxKC154EgNV
	 NAoxmPQ9AdVAcGyU3cPAjr4dVH3CtdFjGnnNKAeDh+CWFNInxJM8uuFgK6vB78mZ7a
	 /937l4I+OLK0gYOQ9EvI+8ydJ4wN3hM8jL9l7Wkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfC1U4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:56:52 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42441 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbfC1U4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 16:56:52 -0400
Received: by mail-lj1-f193.google.com with SMTP id v22so60991lje.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 13:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lIaJ5zGl40TvmZP8WPoGlGdOuZUcsgvjcrKL1kd5VzA=;
        b=WxTImTR+QbeSEDanVx7BSBg44DPaa07/TW7qJCZttsSwUGNfm8Dykr6OIWqFA58GT5
         5mLOnZelYL5c5BrRgckClUbT1aC/umRo9KxJddlf7sXkJCkQlB3vXFjbD1WmDD9Ptkns
         iJTGfxKI5jHv8UK0bNKYAh4nMcRFX7o4UQXf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lIaJ5zGl40TvmZP8WPoGlGdOuZUcsgvjcrKL1kd5VzA=;
        b=MARsHDYFx4+gqoJR+2lBf+nscBOQRGaHvlSZRJ0F80msfd2wJ9iBNTBUc6d9i2uRxp
         XfJdiLW2ZSWbZ/ySw5NYTWbJCNA7+2aYD0PUZ1Wc0O6IJKNsTLfl1IX6nbSL0fbV24kJ
         1j3n3MAzJy0BCEYbwGc2j/iMka5twHQ/mekLNaC01+gnoLGBbBPSujons726kEYs9YB4
         Eajph229I2I7D94aUZuGR2992kjnBOLxXx8JO7Ny6qfQ7dDvnIEmwfrh5xapccLThUPE
         pzVuXHt6gQAUh63Y2NykRz0XT8fUrwjDWFqhqAIdBIMAMhD8LPo3dS2KfGeW+cQ9CBH5
         E7Hg==
X-Gm-Message-State: APjAAAU7sc43ntQEE5CZL/T6PSj+hDUvkyYv5VSzuJTbxaGMAfHyhSE6
        syDOxY/+6m0EDhKRH/7eLkIKocPhnHE=
X-Google-Smtp-Source: APXvYqxMffVG4ZT7SezCfIk0wEef68nVrELMWU6bFWPqPEKehKrdxFFsQz0KTtjEaK0oo+7iJty6qw==
X-Received: by 2002:a2e:8658:: with SMTP id i24mr23826699ljj.194.1553806609297;
        Thu, 28 Mar 2019 13:56:49 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id r1sm5129939lfm.7.2019.03.28.13.56.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 13:56:48 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id u2so14926330lfd.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 13:56:48 -0700 (PDT)
X-Received: by 2002:a05:6512:1ca:: with SMTP id f10mr16624139lfp.136.1553806607767;
 Thu, 28 Mar 2019 13:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190328181106.22887-1-longman@redhat.com> <20190328181106.22887-13-longman@redhat.com>
 <CAHk-=wh7eanC+W7DpSpAsAAYeRTp3EB5qUxMnDFW3HqNQC0GFQ@mail.gmail.com>
In-Reply-To: <CAHk-=wh7eanC+W7DpSpAsAAYeRTp3EB5qUxMnDFW3HqNQC0GFQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 Mar 2019 13:56:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi67qBi9d7zKfECs7ZnVJqbMoMx-ez-ohO39POqD9YR3Q@mail.gmail.com>
Message-ID: <CAHk-=wi67qBi9d7zKfECs7ZnVJqbMoMx-ez-ohO39POqD9YR3Q@mail.gmail.com>
Subject: Re: [PATCH 12/12] locking/rwsem: Make MSbit of count as guard bit to
 fail readlock
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 1:47 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Mar 28, 2019 at 11:12 AM Waiman Long <longman@redhat.com> wrote:
> >
> > With the merging of owner into count for x86-64, there is only 16 bits
> > left for reader count. It is theoretically possible for an application to
> > cause more than 64k readers to acquire a rwsem leading to count overflow.
>
> Ahh, and here's the thing that makes 16 bits work for readers.

Hmm. Does it?

Isn't there a race here? We're adding the READ bias, and then noticing
that it his the guard bit, and then the down_read_failed will make it
all good again.

But this isn't actually done with preemption disabled, so things
*could* get preempted in between, and if we have a huge run of bad
luck, it can still overflow.

Ok, so you need to have a 32k series run of bad luck (and hit
*exactly* the right small preemption point window every time), and I'm
certainly willing to say "yeah, not an issue", but maybe it's still
worth at least documenting?

                  Linus
