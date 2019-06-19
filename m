Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8324DC31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 19:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5967021721
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 19:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bK1hlmR9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbfFSTyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 15:54:00 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35551 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfFSTyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 15:54:00 -0400
Received: by mail-pf1-f195.google.com with SMTP id d126so220856pfd.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 12:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KnKs3Uukd2lrvHxJ6CD8APnEly87QqiINvIMRpZ26cM=;
        b=bK1hlmR9RhoNighqOzBq8Okz4bgbnJroSDgEX6wLNu73YFgmjLaURGNrAprqW2kt1g
         uitbKUDjpVOp/kzy9lNDratIeca9kIbXGuwsk/HhEJ1RioABd23I9K+YH2NB3Ybfq1RM
         0FOexXIzEzbQdnqwvNw/Aj9rLQ4KLpxzvFcfd076LJx5rTQbe7x3uPj//SjDiO5wc9Iq
         6WfjIwnqwme7pgRz7q79VntpDvsbircIqQFYEZ4BhcnvvM5D5WDRIEGrrk/U4OQA1q1Z
         LLh/olVLFDNLqqUgKxaAdyDhDy9D9Mo89dTnx3Tl93gYaJ00/2Aqw3NxeO6aifq8Swl8
         HNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KnKs3Uukd2lrvHxJ6CD8APnEly87QqiINvIMRpZ26cM=;
        b=S5OeCF/AzP0ZdQHscwiDxVgLRnwxvGK9xo68XUuS1mwwbt2R28f9x/ePz+fJkzqnMV
         PExEBMc0JrrnJcz9pfVzCLUmt5dNg+DIUqWP/fYarhMwauyY4vcxKhleiXoBsLBHaCYs
         Nbk9xxH/ipeLBKppPQWQ2YHu3zCokKQMBvm//8gXbKMpgmQ4dYW9Ajc6jqMN7mB2MCt8
         bWeJ6hX+3LDQlEwWmOfEKAJsp5wz8pfHe4Rg18Rc+BlTDFBC7ttQ8UZKuauShTlQVSOK
         RrlZnDo2Dztr9ANyLnWjyqpF6v6psrzTSv4WOqjLWNQTSu4yJOaLs1+GOT2jr5feZhWA
         vHdQ==
X-Gm-Message-State: APjAAAXxc1BiAdCLicH5w+HY2/z6Hwnw3AxVeTvAlsdMYktFKkpFZzYo
        9Mdi5fgRfJqrTYMQsJxKXXqFN3vKbw0ipDu0G+vdBA==
X-Google-Smtp-Source: APXvYqxKlFhXj3WmnG4qCwqC15jSfKeakUO2wAY16Vvh5G6o53JgvWDcZ6CtcmQhHTK+yXrfGnXjP+UiA/AhzcY4G0w=
X-Received: by 2002:a17:90a:bf02:: with SMTP id c2mr13026737pjs.73.1560974039324;
 Wed, 19 Jun 2019 12:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190619181844.57696-1-ndesaulniers@google.com> <d4b42858366e50f92b133ceb6399e9f16a7cef88.camel@perches.com>
In-Reply-To: <d4b42858366e50f92b133ceb6399e9f16a7cef88.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 19 Jun 2019 12:53:48 -0700
Message-ID: <CAKwvOdnEbFdOJj2BVsfN75OAVJYgo3hAj1ceXRRC6r0pwNtqnw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add CLANG/LLVM BUILD SUPPORT info
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 11:27 AM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2019-06-19 at 11:18 -0700, Nick Desaulniers wrote:
> > Add keyword support so that our mailing list gets cc'ed for clang/llvm
> > patches.
>
> You'd also possibly get cc'd on patches that merely mention
> clang or llvm like any change to clang-format.  It could be
> many files that aren't interesting.
>
> $ git grep -i -w -P --name-only '(?i:clang|llvm)' | wc -l
> 134

That's very much intentional.  We currently get ~11 emails a day from
various CI services (KernelCI, 0day bot), patch authors, etc. so I
don't think this adds too much more and it's mostly signal (signal to
noise).  Maybe the bpf stuff would be less relevant, but I don't think
it hurts.

> Please use a single tab after each : like below

gah! My editor does flag this
(https://github.com/nickdesaulniers/dotfiles/blob/37359525f5a403b4ed2d3f9d1bbbee2da8ec8115/.vimrc#L35-L41)
whether or not I notice is sadly another story. Good catch, v2
inbound.
-- 
Thanks,
~Nick Desaulniers
