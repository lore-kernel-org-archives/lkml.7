Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDE9C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 19:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1AAF21721
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 19:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uAX5khEU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfFSTue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 15:50:34 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45339 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfFSTud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 15:50:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id s21so216469pga.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 12:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DZChMikjAO3PKudQBAI8B1YDg/B4twPluki0ZMCxSIs=;
        b=uAX5khEUlOhxoZniQNjo8u3dnMil0nwkHv/puLD90VYqZ0OPcVSo0UK1nTX4ncwsAh
         nFD23dUC/PL9lzXuBb+Vw0RS1j3HHq8E6OeL9vJVxpOtIMn8MzCNtMf6UQvBzqA8P0mV
         oEAqohOTMlKDoBLvZ94oqIAHtBfbdioqyTqlf9wZ9H70VK4rnFd1d3EPrUTAFsLpPIKo
         98YbzCSkIqeAgBvatd910y5tR2RAWmGEMTIYUU0K+Q+x2ORwoU9L7nYE0HphC3PnQHdI
         Mm3VYoULxrCuMVdMziInouFOFisXSsTpD1fsP/ELB8za3v6Z5TGtqipds/Eclg+QTWze
         f58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DZChMikjAO3PKudQBAI8B1YDg/B4twPluki0ZMCxSIs=;
        b=bB7pzG4uQX+LKMj2wWXTIiUKRSliQVj43xYVeW2zv9/Pzk0lsefdellLRAenV8gA98
         Ezw2cLT/6+9cy409Tt7Gh0+PgJMcQ32FvHvNq7cU5/oivnvUZX18qQQAlImPoU2BMHen
         n4AkqCxoYG86E79YkOF3jvhxBWNlRACQqtGfdFJW9+Gxb0lqrYt385vw0ihiovYxRYs0
         2m50dWf/9su/FzkvSzuDoXXsy4FB29Bm847z50eNmhyZgez5fuOt/kxEGeEsUrotV05G
         rHDe2+6owPGo1XdwAdYnRD47f5yrfhykHAbfH+/tA1iJRVS4I6a9Dif6JmNAnBNwMkpV
         PGng==
X-Gm-Message-State: APjAAAXdX5dqAbCxy3mynNEAQ70Dap2Qc/VjxT9XiwB2PKKlNODCYh7I
        DVPkYyHirl9n54dPrUd7LCyeuS1U4TyPqVdvOYF9mw==
X-Google-Smtp-Source: APXvYqyjCBtQEr2rOg6EN5DHa/HLlH7APyqHI/pOkGz7IZqPsvs7me8bqrliv/gzcx50ktbRfyv+oRvr1kIMba9BH38=
X-Received: by 2002:a17:90a:ac11:: with SMTP id o17mr13171269pjq.134.1560973832424;
 Wed, 19 Jun 2019 12:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190619181844.57696-1-ndesaulniers@google.com> <20190619191605.GA5837@gmail.com>
In-Reply-To: <20190619191605.GA5837@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 19 Jun 2019 12:50:21 -0700
Message-ID: <CAKwvOdmZuxZyRF1FoKNqunin6AnWfwjni5PKsf0TV12hLJttyw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add CLANG/LLVM BUILD SUPPORT info
To:     Louis Taylor <louis@kragniz.eu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Joe Perches <joe@perches.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 12:17 PM Louis Taylor <louis@kragniz.eu> wrote:
>
> On Wed, Jun 19, 2019 at 11:18:44AM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
> > Add keyword support so that our mailing list gets cc'ed for clang/llvm
> > patches. We're pretty active on our mailing list so far as code review.
> > There are numerous Googlers like myself that are paid to support
> > building the Linux kernel with Clang and LLVM.
> > +CLANG/LLVM BUILD SUPPORT
> > +L: clang-built-linux@googlegroups.com
>
> I think this should have "(moderated for non-subscribers)" added.

The current setting is "anyone from the web [may post]" as otherwise
the various CI services reporting there have issues.  There is a basic
spam filter that emails me every so often.  Not sure if that's quite
considered "moderated for non-subscribers" or if I'm just being overly
pedantic? (Point being that I don't think you have to subscribe to
post)
-- 
Thanks,
~Nick Desaulniers
