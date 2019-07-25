Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FFAC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 22:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C462086D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 22:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BpzZ2pwO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfGYW5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 18:57:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33905 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfGYW5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 18:57:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so17529527pgc.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 15:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8t4snaNVdB4o/7apaQCvfFukpJka0ULnzwTuIhY7zEc=;
        b=BpzZ2pwOVOfTeyVPr+QJBtq0h8Eh3glocVaUca9wbGD9ANEseRGRawNrCF7vN610F5
         UAg9oGFmxaq9wz9LCmq4f5GoRimECUvjtO/sPtTqCjqKG4g9ou+bHewVwNB2f2UF4Wvi
         60+81i+YHPRQzXiMioSt8O0sqW0WvgZefGRIaqB7hBth/JiOI1q6xekeikjgMXN+gPAO
         +q6r8jHM5CJc9FzjSDqXhaAvFmLucYCEX8MYpHYKFByBlAaDBwjb5sACPJiltXrqsiX5
         BvkUB7Sq70KEApIEHbK+lsJGIWXh8wGfUi7BJSXPhPcWh6pQnEylx3rRRFoNnC5WOhIe
         9wLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8t4snaNVdB4o/7apaQCvfFukpJka0ULnzwTuIhY7zEc=;
        b=oWueQN+ITOUEI89DBaPBERMrv6DttsAusckwE/RhGN7pz07QAI495mRCDvobfrHgbo
         c9UQ2YndCohMNfGjtMgcH5z0nhFjEpqLOny8LTnuKFKKLwer4OirQJNRO01dtzDkVS3Z
         kaHyRXfzq8ZMUDL9jAsyMHLxNeMX2hn2bat38nWSgkT9ToXRP9DVPDGdg/ZM2NPGzBOi
         vFe9ZBv4yrVtNaMHsQTMSC68NB/PXfR+kg+hmJOyIFIhPmAd8NPtul3P5vkFNujgvVcI
         meNsPzVdmYGbSdiS381zza9mlhfb3J7CegHeOnH/2fF3GEzWBFCGxCN2VYuOQOl0NXkL
         iPgQ==
X-Gm-Message-State: APjAAAUVsyvfMeGe/YPHgBmBd6ukgrl0Dt/q8tDCH5a1TWnhuCz6duoA
        xVaAmtJrFN1uPD+zuv6E/P0JwifJXfCaTwWkQTPuVQ==
X-Google-Smtp-Source: APXvYqzWgb1YdZEXoKAEnj7fCe68s7FNPhgqEwKmuZS9h7pNHZW1dYVy6NtW7QdERaM8UB6ykhs1aE2a9TffXhVqesY=
X-Received: by 2002:a63:2cd1:: with SMTP id s200mr84167645pgs.10.1564095465592;
 Thu, 25 Jul 2019 15:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190725200625.174838-1-ndesaulniers@google.com>
 <20190725200625.174838-3-ndesaulniers@google.com> <alpine.DEB.2.21.1907260038580.1791@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907260038580.1791@nanos.tec.linutronix.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 25 Jul 2019 15:57:34 -0700
Message-ID: <CAKwvOdnBKcEFkv2qEWPaFEjPSmR_SXBo2ZGz7ho9pBc88dZJBA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Support kexec/kdump for clang built kernel
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 3:51 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Thu, 25 Jul 2019, Nick Desaulniers wrote:
>
> I'm really impressed how you manage to make the cover letter (0/N) a reply
> to 1/N instead of 1..N/N being a reply to 0/N.
>
>   In-Reply-To: <20190725200625.174838-1-ndesaulniers@google.com>
>   Message-Id: <20190725200625.174838-3-ndesaulniers@google.com>
>
> Is that a new git feature to be $corp top-posting compliant?

It appears to be a hidden bonus feature of:
$ git-send-email purgatory/v4-000*

> > V4 of: https://lkml.org/lkml/2019/7/23/864
>
> Please don't use lkml.org references. I know it's popular but equally
> unreliable at times.

Oh?

>
> The long term reliable reference is message id based, i.e.:
>
>  lkml.kernel.org/r/$MSGID
>
> or
>
>  lore.kernel.org/lkml/$MSGID
>
> even if the base URLs would cease to exist, the message id will give you a
> trivial way to find the relevant thread, but if '2019/7/23/864' stops to
> work, good luck in finding the original post. I wasted hours on that just
> because a subject line changed enough to confuse the big internet stalking
> machines.

Thanks for the tips; I'll try to use lore.kernel.org going forward.

-- 
Thanks,
~Nick Desaulniers
