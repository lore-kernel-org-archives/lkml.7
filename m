Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9665FC4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A4620665
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CTujHcuV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732539AbfFXVyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 17:54:07 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46881 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfFXVyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 17:54:07 -0400
Received: by mail-pl1-f196.google.com with SMTP id e5so7625175pls.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 14:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vO+9Uc5/8MpdDSQOEwUbxCiZ1Bx7hoIB/5okbCwKM1o=;
        b=CTujHcuVYvjgTnnebk59WpuccyprXg13CV/pDBG4EoN7hwAitLfrrh2gu/pQP+alA7
         3oDngUEzwlVS7V/si4lRF+khXT6PpOrSQogFuOFHbBE+A3Obp3HX5rsjLRIzL1wumSv+
         AbTj6C5s+q/m/4BO8/YccHSjoKC0WZyciFF8CuZuO7RyNkG9ZY9iKXssP6G/Ty7WqcuE
         Hq6UynV8pADROYHKGwvrTi3FMx0c04k9ufSJLorDTuqaRxX9umZL9bxUnMCSeYP4n6ri
         2xZFFM/rk8ZAMAUK33izskwAMFyuo+6/7kylbSrRrT3GsAoktTNusiDO9pXcWgfqDSiy
         vU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vO+9Uc5/8MpdDSQOEwUbxCiZ1Bx7hoIB/5okbCwKM1o=;
        b=aD3ZXuaVzFfI/zP7+CZPSUH2GimzynfON9aSkXbcLdJ4d8XUyH62TVaOIQHj9pK+5z
         ezvqqSGw6LFbljQMJCwBpFz2/CY89BFO8I7W9sYrl9FWLoWM9+5Rq6gWdZHFbnk2Bf0t
         pQ3jj6uGYoIFVAUP0lhJGV10jxiGwTZsX/yRdVruT6hagLRPNzk4nzgotSeXgpCTqUXq
         Oy0Oc5K2+C6z0Vg00iLtiIR5WvKRzeraruPLMP6Oo4By8nIaml+8GsUu1VJcKR5yl+gs
         EXy+ztQmNhamiLfQ2b2pIaKilh59TUAl8O1rQFnK/LKPKizHedJ8eoTLIVrY4U1YoDGT
         hF5A==
X-Gm-Message-State: APjAAAWUMMa6qq+2AYoR0iigvAlqJtQ45kAVNvrRt4YgO3jjo+L46pej
        HYy+iEXXf+aEofL8UhQV2YgNUFSvvJZ2ippLyR2+Rw==
X-Google-Smtp-Source: APXvYqyNL5yUDZYuTwdwu3sv5dL/r2T0URaTuRutk0hGCMdHdZ4Qg7SG8vSkh9qUpC8ItgHXMnXtxbjgSZIyi/AI96o=
X-Received: by 2002:a17:902:9f93:: with SMTP id g19mr134338486plq.223.1561413246282;
 Mon, 24 Jun 2019 14:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190617222034.10799-1-linux@rasmusvillemoes.dk>
 <20190617222034.10799-8-linux@rasmusvillemoes.dk> <CAKwvOdn5fhCTqtciKBwAj3vYQMhi06annzxcdC1GjKxri=dHnw@mail.gmail.com>
 <12bd1adc-2258-ad5d-f6c9-079fdf0821b8@rasmusvillemoes.dk>
In-Reply-To: <12bd1adc-2258-ad5d-f6c9-079fdf0821b8@rasmusvillemoes.dk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Jun 2019 14:53:55 -0700
Message-ID: <CAKwvOdkqy8=V17qEM_SMDEAh=UX5Y2-nj9EUkC169nEiXc_JzA@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] dynamic_debug: add asm-generic implementation for DYNAMIC_DEBUG_RELATIVE_POINTERS
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 1:46 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 18/06/2019 00.35, Nick Desaulniers wrote:
> > On Mon, Jun 17, 2019 at 3:20 PM Rasmus Villemoes
> > <linux@rasmusvillemoes.dk> wrote:
> >>
> >> It relies on
> >>
> >> (1) standard assembly directives that should work on
> >> all architectures
> >> (2) the "i" constraint for an constant, and
> >> (3) %cN emitting the constant operand N without punctuation
> >>
> >> and of course the layout of _ddebug being what one expects.
> >>
> >> Now, clang before 9.0 doesn't satisfy (3) for non-x86 targets.
> >
> > Thanks so much for resending with this case fixed, and sorry I did not
> > implement (3) sooner!  I appreciate your patience.
> > Acked-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > I'm happy to help test this series, do you have a tree I could pull
> > these from quickly?
>
> I've pushed them to https://github.com/Villemoes/linux/tree/dyndebug_v6
> . They rebase pretty cleanly to just about anything you might prefer
> testing on. Enabling it for arm64 or ppc64 is a trivial two-liner
> similar to the x86 patch (and similar to the previous patches for those
> arches). Thanks for volunteering to test this :)

Compile tested x86_64 allyesconfig
boot tested x86_64 defconfig+CONFIG_DYNAMIC_DEBUG

(just curious why the Kconfig changes for arm64 or ppc64 aren't
included in this set?)

>
> > Anything I should test at runtime besides a boot
> > test?
>
> Well, apart from booting, I've mostly just tested that the debugfs
> control file is identical before and after enabling relative pointers,

mainline x86_64 defconfig+CONFIG_DYNAMIC_DEBUG
$ cat /dfs/dynamic_debug/control  | wc -l
2488


mainline x86_64 defconfig+CONFIG_DYNAMIC_DEBUG+this patch series
$ cat /dfs/dynamic_debug/control  | wc -l
2486

(seems like maybe 2 are missing?  Let me try to collect a diff. Maybe
2 were removed in this series?)

> and that enabling/disabling various pr_debug()s by writing to the
> control file takes effect. I should only be changing the format for

Can you suggest one that's easy to test?

> storing the metadata in the kernel image, so I think that should be enough.
>
> While this is still not merged, some new user of one of the string
> members could creep in, but that should be caught at build time.


-- 
Thanks,
~Nick Desaulniers
