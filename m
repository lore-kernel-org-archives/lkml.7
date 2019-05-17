Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD77C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 03:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF4E20848
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 03:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Hcu0KCKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfEQDOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 23:14:38 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33463 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbfEQDOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 23:14:37 -0400
Received: by mail-qt1-f193.google.com with SMTP id m32so6527771qtf.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 20:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rKxEaaNHIV6JsHY3ht5oSGzbtWVjHarjvsskL7zAQu8=;
        b=Hcu0KCKbzK/sRRVVgD1EfbjOj2ONoQFhG9B5LizhK6UNMJfPder82blvHI36tqvXmQ
         DdkLTu9uydvQoChzn7CCe+9usejYltN71BWqI/5m+MJFPtI3X5BTtAIdln5pwcnU+MtS
         +pqTTP0wFeyVkMwZ0A0z4vZ3LXuF72HznwsP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rKxEaaNHIV6JsHY3ht5oSGzbtWVjHarjvsskL7zAQu8=;
        b=g8rUccFCtT9oHVNw/XYS9XW7Qc3zAZ5kxCbIFawA9ADnslJ3ZWDdtJY38O9jpO0El2
         qTVkU/UoL5CCrAr1KWzKJqw6SmqOUrhXBwZMLeJRFSh2x4Urx2kxUc9GqQjjG1C1gu5l
         bOhNWmMA5SHKVWljDG9vsnpbIMJUYabAZQZDJHxW4+LXuxV3o34mHrur5P+rzJPFW2/T
         EyMzAwlMNuSnxmEgFUHtFQUBvyjTqCAR7bgWIwQwgunMh9qW6V7teeVYDyxhWmrfsMMC
         H9fWMiHQJ4wtj/rjVq0VpvBJMJYvhG0qCtn/1ZURVi6CKKV/pZL8oPZe9L2eaogJL5Uz
         EU/Q==
X-Gm-Message-State: APjAAAWI/bqIdrUWTiewbiHcV08f1ym5vtfvDc98dSkPO176mUOTAJQL
        B1CRVQ7OhvN28aHiE5WGhUTUURPvA5J/JYH7W4ZTTg==
X-Google-Smtp-Source: APXvYqzOWz36fTK06wwiFIuYg95qsggEx19E8Ej8Lf5TmxRHoryNz2jZfMMn0QfC2FD3F02pGeeMwYRv6eOSw0T1lTA=
X-Received: by 2002:ac8:875:: with SMTP id x50mr44529748qth.345.1558062876675;
 Thu, 16 May 2019 20:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <CABWYdi06NUOWRLingNuybgZZsTZPjhmsOx-9oCGK94qZGYbzcw@mail.gmail.com>
 <CANiq72kvpiC-i53AXM-YsCUvWroHQemmqxsXjnB330ZEeHahUg@mail.gmail.com>
 <CABWYdi1zhTTaN-GSgH0DnPfz7p=SRw0wts5QVYYVtfvoiS0qnQ@mail.gmail.com>
 <CANiq72=fsL5m2_e+bNovFCHy3=YVf53EKGtGE_sWvsAD=ONHuQ@mail.gmail.com> <20190516225013.nvhwqi5tfwtby6qb@treble>
In-Reply-To: <20190516225013.nvhwqi5tfwtby6qb@treble>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Thu, 16 May 2019 20:14:25 -0700
Message-ID: <CABWYdi29E++jBw8boFZAiDZA7iT5NiJhnNmiHb-Rvd9+97hSVA@mail.gmail.com>
Subject: Re: Linux 4.19 and GCC 9
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are building the upstream kernel. There are a few patches, but
nothing related to objtool.

Unless you mean mainline/stable by upstream, I haven't tried that. We
stick to LTS.

On Thu, May 16, 2019 at 7:04 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Thu, May 16, 2019 at 11:20:54PM +0200, Miguel Ojeda wrote:
> > > mm/slub.o: warning: objtool: init_cache_random_seq()+0x36: sibling
> > > call from callable instruction with modified stack frame
> > > mm/slub.o: warning: objtool: slab_out_of_memory()+0x3b: sibling call
> > > from callable instruction with modified stack frame
> > > mm/slub.o: warning: objtool: slab_pad_check.part.0()+0x7c: sibling
> > > call from callable instruction with modified stack frame
> > > mm/slub.o: warning: objtool: check_slab()+0x1c: sibling call from
> > > callable instruction with modified stack frame
> >
> > AFAIK those are non-critical, i.e. stack traces may be wrong (or not),
> > but it does not mean the generated kernel itself is wrong. CC'ing the
> > objtool maintainers too.
>
> I don't think I recognize those warnings.  Do you also see them in the
> upstream kernel?
>
> --
> Josh
