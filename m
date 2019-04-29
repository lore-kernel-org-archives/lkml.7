Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AC5C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 21:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC8E2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 21:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556573940;
	bh=GrP8cZOBRMBSsF8r0U8rosVWXZkA2KIhYapxx/V4Les=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=a+U5F7QT1XxlXWUD5hHbXLNhP17cB2UIe7XbKM6LsEUrnx3pulLHNBFfQ1Asxlwmx
	 h6qFowfW+VW4zUeVgdjq6SPwCZ7AZufzW6Efg9lEsiQYJKYSJOwyEKWJzgm/5XkXDW
	 CD/zTaPLtATEiaaaMGvO82j9edMVMEuSxrfSXgS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbfD2Vi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 17:38:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36058 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729336AbfD2Vi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 17:38:58 -0400
Received: by mail-lj1-f194.google.com with SMTP id y8so4395804ljd.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 14:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wSiV79NBIztMusWk2QP2VKKhKOlea+n31l0AFUl2Bg8=;
        b=ZMLzPqHi9lETwhRL66Ic7OfH6fw2vR3J8CHiKq3pfDQQ78NgprQyY154J6Rqvkqc7s
         C42c14gHHilvBkmQFjpiBuapTUcRjDejOz3oZMhlsRfav1CrKiKeXa5cwy+w5bWoRtOe
         i2ztzqxJfLNJSPQmCXpPj6ttEC4mfbjCWUHRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wSiV79NBIztMusWk2QP2VKKhKOlea+n31l0AFUl2Bg8=;
        b=X0nYMUj3QQc1Pdw8IAMjOFjLsPpbskkcvXQAgwrQBenQco4I8L/wCowTluxsDZr2/G
         bhH8YZQrcCYVMConvkmDPLnYATX58z9KwEUdmfxFIrAnphfhQ+psA/2O3nkLoVh++8CI
         Tc1MUfZBcvt/5s7eAznP6qzijta+erPVfKXbk5u9ZdPt9xSTIId/hxsLKyHlZv33BJgw
         FxooVtbVa8qaW23XAAg3s57hqc4dlMziA517wFm3/0zQa1zuouKTZqVkDuGzpj2Na5v/
         o9WVs9yKlOlw1a3jG6K9+qwNY9V/SGNjVodkIzmFBjRT+Dc4d9X/WUUx7ddotxJueZoc
         eiGg==
X-Gm-Message-State: APjAAAWsX/N6YksAh3qgMR+XsA78kGRKeK8lGnsqDIg8oh0hDxJkd1+L
        xMki93Ovr4xdg4YMyH8lktKXgLQV0wU=
X-Google-Smtp-Source: APXvYqw6b2XnbFrw7BSLw+7VXZOlHqu+jA7VzPOEZoyPR24nhbg5JQgvTuJSCUiY/OgMo07i8S7Fyw==
X-Received: by 2002:a2e:4b19:: with SMTP id y25mr2448696lja.106.1556573936325;
        Mon, 29 Apr 2019 14:38:56 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id v141sm7473859lfa.52.2019.04.29.14.38.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 14:38:54 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id m18so6179475lje.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 14:38:53 -0700 (PDT)
X-Received: by 2002:a2e:9ac8:: with SMTP id p8mr30631636ljj.79.1556573932539;
 Mon, 29 Apr 2019 14:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190427100639.15074-1-nstange@suse.de> <20190427100639.15074-4-nstange@suse.de>
 <20190427102657.GF2623@hirez.programming.kicks-ass.net> <20190428133826.3e142cfd@oasis.local.home>
 <CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com>
 <20190429145250.1a5da6ed@gandalf.local.home> <CAHk-=wjm93jLtVxTX4HZs6K4k1Wqh3ujjmapqaYtcibVk_YnzQ@mail.gmail.com>
 <20190429150724.6e501d27@gandalf.local.home> <CAHk-=wgbC-wiSrdDYAh1ORF4EKmecY+MkNsJBF=BWf4W1bXXgA@mail.gmail.com>
 <20190429163043.535f4272@gandalf.local.home>
In-Reply-To: <20190429163043.535f4272@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Apr 2019 14:38:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjGquN7-kQCoa+LHCuiVTjefkk38qwaysd4wLLtoSZhpg@mail.gmail.com>
Message-ID: <CAHk-=wjGquN7-kQCoa+LHCuiVTjefkk38qwaysd4wLLtoSZhpg@mail.gmail.com>
Subject: Re: [PATCH 3/4] x86/ftrace: make ftrace_int3_handler() not to skip
 fops invocation
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andy Lutomirski <luto@kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 1:30 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> The update from "call custom_trampoline" to "call iterator_trampoline"
> is where we have an issue.

So it has never worked. Just tell people that they have two chocies:

 - you do the careful rewriting, which takes more time

 - you do it by rewriting as nop and then back, which is what
historically has been done, and that is fast and simple, because
there's no need to be careful.

Really. I find your complaints completely incomprehensible. You've
never rewritten call instructions atomically before, and now you
complain about it being slightly more expensive to do it when I give
you the code? Yes it damn well will be slightly more expensive. Deal
with it.

Btw, once again - I several months ago also gave a suggestion on how
it could be done batch-mode by having lots of those small stubs and
just generating them dynamically.

You never wrote that code *EITHER*. It's been *months*.

So now I've written the non-batch-mode code for you, and you just
*complain* about it?

I'm done with this discussion. I'm totally fed up.

                 Linus
