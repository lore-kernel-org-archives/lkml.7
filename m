Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4B1C433FF
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 19:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8082067D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 19:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwAep6Ug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfHDTiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 15:38:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39093 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfHDTiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 15:38:13 -0400
Received: by mail-lj1-f196.google.com with SMTP id v18so77328054ljh.6
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2019 12:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1FFHYtKFMV/2rUVBEWqxxlBuT8jt7JwtVpdGxJtcgL0=;
        b=KwAep6UgDtrWClq1iSze66fD1WTuPx7njizz33IgGpTcps71ljHk13Az4yKAN49n/n
         mco7jTJfboxs3ck3xyaHfWT3TmkNMx13/W8BVaQPJZtfhIqHRxxBp1XIA15swvRs6yqw
         KSFZFOlCPRaE++pDwNCC/H62dZ7sOsmCJBfzvUFLi5DpD8igKAR4iMLSSMAKannTHM8k
         rM4TzAw8lAPt3TRDxv7vOYcmYOMCpU1MvQeJTpiux6e/A3PFR3ExVoFkhRTuxiJN0hy4
         iVJnDrHZqv0/JlHafd1RSXkQJbJrnOg09+jHRuJ2hcD4DqRrGwB5FORANLJ7PcgbU/AQ
         P+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1FFHYtKFMV/2rUVBEWqxxlBuT8jt7JwtVpdGxJtcgL0=;
        b=IGmEog2nOjr0V7VUfLt9l42zAoJ/c0knPhTAeV4Yn0DKpY5ubcOsok91K9EQBoL28n
         V6yO/lNHbTfU1QAdxEPrbuVQHkZFF0N7YgSBf2dm9FJfgLryGeqwMsbIHBCBozbvK5xS
         6PGwE6lV2blhGvv2RuuYoyI4B3QyTew9+fBcFaOBil1vK06CkgJUrfmg7CoLiCOcHFHo
         ixYNm0pFI02hcEE/V69D9Xq0R3ZGLDVpNUzI1457p3Tggn5KpLO6Swzkxa5BKqZV1Nrh
         IKpvtJYTFsdE3w8JVzuq5HB0OskJXjghJVW27fBRKGp+9vbXmfPdY636cy1c58kYoLNo
         kSPA==
X-Gm-Message-State: APjAAAVCoCuK5k02fDL3c2jBC1dhp4TnP+BEtOw/LgRGZgLcOpYd/+1O
        UqIkBWhNnHxdfP842hU+1lx+9KtHFXiZ7RF1fho=
X-Google-Smtp-Source: APXvYqzZJmqm0gaD6fs8mo9F9MzAw3Cm7VK9UivC4XwoQpM704ZlEnb1pnIlHpWDhBVjw7Drqg99/iQMaKLT9iaV/Aw=
X-Received: by 2002:a2e:8849:: with SMTP id z9mr37043598ljj.203.1564947491487;
 Sun, 04 Aug 2019 12:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com>
 <1d2830aadbe9d8151728a7df5b88528fc72a0095.1564549413.git.joe@perches.com>
 <c0669a7130645a20e99915385b7e712360c31ed9.camel@perches.com> <CAHk-=wg1PAJR6ChVXE7O_H2wEG=1mWxi2uc0fH5bthOC_81uTA@mail.gmail.com>
In-Reply-To: <CAHk-=wg1PAJR6ChVXE7O_H2wEG=1mWxi2uc0fH5bthOC_81uTA@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 4 Aug 2019 21:38:00 +0200
Message-ID: <CANiq72=JadupKyLa09ABG_xAPe85gjTvy4joMQb5ZE21cEZn1g@mail.gmail.com>
Subject: Re: [RFC PATCH] compiler_attributes.h: Add 'fallthrough' pseudo
 keyword for switch/case use
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Joe Perches <joe@perches.com>, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 4, 2019 at 8:09 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So my only real concern is that the comment approach has always been
> the really traditional one, going back all the way to 'lint' days.
>
> And you obviously cannot use a #define to create a comment, so this
> whole keyword model will never be able to do that.
>
> At the same time, all the modern tools we care about do seem to be
> happy with it, either through the gcc attribute, the clang
> [[clang:fallthrough]] or the (eventual) standard C [[fallthrough]]
> model.

Quick note regarding C2x: fallthrough didn't make it yet into the
draft (other attributes already did), but it may still be added.

> So I'm ok with just saying "the comment model may be traditional, but
> it's not very good".
>
> I didn't look at all the patches, but the one I *did* see had a few issues:
>
>  - it didn't seem to handle clang

Hmm... Not sure what this refers to, but note that Clang will likely
get support in the next release (they are working on it at the
moment). As far as I understand, we do not yet establish a minimum
version for Clang since they still solving several issues, no?

>  - we'd need to make -Wimplicit-fallthrough be dependent on the
> compiler actually supporting the attribute, not just on supporting the
> flag.

If the above is correct (i.e. if we do not care about a specific
version of Clang just yet), and since gcc got support for the warning
at the same time as the attribute (7.1), I think we don't need to do
special handing for the warning; but if someone knows about a case
where we do have an issue with it either with GCC or Clang, please let
me know.

> without those changes, nobody can actually start doing any
> conversions. But I assume such patches exist somewhere, and I've just
> missed them.

I think the primary concern has always been the tooling (e.g. Coverity
was mentioned in October and also this time, and well as some
IDEs/text editors), not the compilers themselves.

Cheers,
Miguel
