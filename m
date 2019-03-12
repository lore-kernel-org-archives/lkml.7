Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAC7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 01:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F307D2084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 01:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k7eUGz8M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfCLBjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 21:39:03 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43922 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfCLBjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 21:39:03 -0400
Received: by mail-qk1-f194.google.com with SMTP id s26so499348qkm.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 18:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HBZnBBRZF0aLfxcwwEv9vKZUR9S58Xw6VP7CJ7jv6AE=;
        b=k7eUGz8MMFIl5qWLHfu9QVq8W5YLH22rwBpuI72b90BbmMeHxIiPG+BjVy0BhjdiDu
         RB4ZWLXoPwrFtNlBynOfm86eZ4xkpXJAH/f56W5JDjk4/Z0RAd5g8+toZvn/Ggz7dIU6
         I7Rkt7yXkoaOpPEmcmIL8GWw49mhJduFS8UxGgguWTlVzcnYqbUsbsMi67dn8+mnAU4w
         1XYCAQPMA26wKuMyhs5C3Ct193/3Zuyi2pfkzREBLincMllKXof6MyO3A3PfRlFnouxc
         B5a/toaBabQcir7pcdgJoCiWWnLrsmVEPgT7vvNo0heYK/BYwLGHfN1jApGINjLd+LC0
         2O5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HBZnBBRZF0aLfxcwwEv9vKZUR9S58Xw6VP7CJ7jv6AE=;
        b=rwz1NqamztG9H60rqU/68T5dDMW8BiTj2J/mewPBjIwNhEe/MHdaFDqWupp8ftLGQB
         VrXr+fc16/0dY7TEc81ZiIfDTQ+VvAzbLJow3fr9Zb2l8AHHnMLeTEPaP7Msf7z7cBY9
         2IdFnZYif/z5ztygXDYKu0gL7U+6JA9WWS/hLA2SUpWx0IuVSJdRfUzpsCkL0Jt6cQ2G
         wQSmCDtdECjDR2w9IdRMJpL/JSAyyPNMAcCSk6ju9z+CTKPJILMzVHZb0SH9E2nDWyMW
         YWCFzGVdEaLXpxp8bSw+dZHxG/mTn+O+zW9b6mY6Fy4yCvF2uhUbvYzg2dbtOCglN4GE
         DVjA==
X-Gm-Message-State: APjAAAWvkkTqa1H8AJ1a9ekFk9pjU+lrsSVRnokaoOekwApmjA85GHLV
        RXkbc2ku3mdHI4JOezfIDY8V+gTDJu05xGIndEzOWQ==
X-Google-Smtp-Source: APXvYqxgAHowETo2Xnx0G2/DpKzzuRp2FwZcY5+8I6FaFuJqYjuBUznYBRjFojfNsQDU2A9ACiKbjjpIfzXlVfcYIU0=
X-Received: by 2002:a37:ef19:: with SMTP id j25mr3463022qkk.176.1552354741560;
 Mon, 11 Mar 2019 18:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190308140251.GC25768@kroah.com> <CAMuHMdUmnrJtu8bBeUgtiU6y_TLHM27z1WxpPia4dXMpApeijw@mail.gmail.com>
 <20190309071648.GE3882@kroah.com> <CAMuHMdUT+UGt9p2QhOXzAtCUmqy-a8YN-ceDa-0qANJE53pWBA@mail.gmail.com>
 <20190309121141.GA30173@kroah.com> <b7296377-9e0c-aed7-61f0-93d24d1ceddd@opersys.com>
 <CAMuHMdV8+XTyGf1ZJ+gMf=zQpzqh3-+b7wgi+gAmXQ6HpUAw3A@mail.gmail.com>
 <3e84e1ef-e266-e983-5874-6c26ac7f38b8@opersys.com> <20190311193612.4f09bf11@oasis.local.home>
 <CAKOZuetHG0O-CiO6h5tD7aht_MT70ebwWMMSPkRUHdiM3wVq0Q@mail.gmail.com>
 <20190312003912.GA170478@google.com> <20190311212823.60684182@oasis.local.home>
In-Reply-To: <20190311212823.60684182@oasis.local.home>
From:   Joel Fernandes <joelaf@google.com>
Date:   Mon, 11 Mar 2019 18:38:49 -0700
Message-ID: <CAJWu+oqsD_wHGWfzj6POFowiY2qcu04auVzkA6Lu9R+LR4gkrQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] Provide in-kernel headers for making it easy to
 extend the kernel
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        atish patra <atishp04@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-trace-devel@vger.kernel.org,
        Manoj Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 6:28 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 11 Mar 2019 20:39:12 -0400
> Joel Fernandes <joel@joelfernandes.org> wrote:
>
> > I think even though the kernel-headers can't have information about all data
> > structures, they do already contain a lot of data structure definitions we
> > need already. And anything needed can/should arguably be moved to include/ if
> > they are really needed for kernel extension by something "external" to the
> > kernel such as kernel modules or eBPF, right?
>
> That's not my worry. I would like to be able to easily walk data
> structures from within the kernel, without having to do a lot of work
> in userspace to get that information. The kprobe_events could then be
> passed type casts or such to access data fields of arguments to
> functions and such.

Ok.

> > In any case, such a solution such as what Steve suggested, still cannot do
> > what we can with headers - such as build kernel modules on the fly using the
> > C-compiler without any auto-generation of C code from any debug artifiacts.
> > Think systemtap working with the module-backend without any need for
> > linux-headers package on the file system. So such a solution would still be a
> > bit orthogonal in scope to what this proposed solution can solve IMO.
> >
>
> With the information I would like to have, it would be trivial to read
> the data to create the header files needed for modules.

But there are macros and other #define things too. We lose all of them
and can't recreate them from just DWARF (AFAIK). Including
include/generated/autoconf.h which #defines the CONFIG options. For
that we either need headers, or full kernel's sources with build
artifacts.

I do see a use case for the debug info you are talking about as you
mentioned for the kprobe_events argument list types, and I already
thought about it. But it does not seem to work for all the use cases I
am referring to here.

thanks,

 - Joel
