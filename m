Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D72C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 18:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7DD62075E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 18:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556823101;
	bh=3UmAsUJNtf9bvtz4GHkqUnzOcLvCU4i5Y5vxHvB4z/M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EVz6AuIjTrL5FXKNNBFTpluTEVlmWwDR7bVFBMyagU4PCbC+GX9UwKY9CvzAvJM8k
	 ztg17Awc1SCNuxvH3TQXP/nSLtyA6nF2w+v6+gnj5HGRYZKz36H6ny8BQoNarz9Aku
	 Ug/FV2vQ3LHnkpbN9qYBfMTQl2dLyHU6dymZvdKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfEBSvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 14:51:40 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46611 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBSvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 14:51:40 -0400
Received: by mail-lj1-f194.google.com with SMTP id h21so3120327ljk.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 11:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jRZt+D8O8akEME1deiXcwDybfKiwpthrXzyaDQKQw+o=;
        b=DOe1Odxc1gK8brv9R5zvAAh8GUyJ0YnhuXPXnXKLY6rlveLN+SrMsrIhlmdzjwzc3A
         +gpmg7E+x+gFu/OGE9tnfORqGbP7/EJEKg5bLaODW4PNZqGswJ1xp/er7T39ChKACNGs
         gUroHv8DdOMTYzXZZhWIDTz6VqI7ZdBhWPnGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jRZt+D8O8akEME1deiXcwDybfKiwpthrXzyaDQKQw+o=;
        b=dbQEldQIp6waaxS/AYplu6/6/6uZ1OMImx3iCQXBM3pDWhVjr0RT9xe1UyAtRS2CRL
         7SY2RaaNzj2tOI7jBuTt3sub52SjPbzQiA5o97fUQVRUhO3M8TK/s9oRsYmP1xGsmFsp
         Yp6/Ok0GqRAV3rvFJ1XSjemDl6T/ORssdDgHDi8gEsM/Micgx6BbCZXIr3Un1Bh9jXTw
         6ZV0Ed3z3hb46HMw7292i6HS2kQkgMsAO59Ccy4eofIh3TpZ2E+Pgi2dgrVQAnKQjHRz
         sEgdliL9RiTEtjyLwi/oqhI2LJStzmNVA8PIqqoro6zZhSTjss0s6BzHuuYtSbdccBp6
         kBlw==
X-Gm-Message-State: APjAAAWuBr60qMEtYRpiSP0m1uyaR/R5lPcEtbfZ1vJSj1FHfPFpd2BJ
        RjJ4cr/536NnAf7SyQ7XlkH1Y9TwKA8=
X-Google-Smtp-Source: APXvYqz75hwNfBzsxvhfbt080ImCb6f1uQUYXmdzXobdWAzEPno/fqLaoRPBkzPAv+h97YU5ggm0jg==
X-Received: by 2002:a2e:9283:: with SMTP id d3mr2857941ljh.8.1556823097483;
        Thu, 02 May 2019 11:51:37 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id z6sm2832450ljb.56.2019.05.02.11.51.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 11:51:37 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id e18so3165617lja.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 11:51:37 -0700 (PDT)
X-Received: by 2002:a2e:9a84:: with SMTP id p4mr2295002lji.22.1556822633649;
 Thu, 02 May 2019 11:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190501202830.347656894@goodmis.org> <20190501203152.397154664@goodmis.org>
 <20190501232412.1196ef18@oasis.local.home> <20190502162133.GX2623@hirez.programming.kicks-ass.net>
 <CAHk-=wijZ-MD4g3zMJ9W2r=h8LUWneiu29OWuxZEoSfAF=0bhQ@mail.gmail.com> <20190502181811.GY2623@hirez.programming.kicks-ass.net>
In-Reply-To: <20190502181811.GY2623@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 May 2019 11:43:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi6A9tgw=kkPh5Ywqt687VvsVEjYXVkAnq0jpt0u0tk6g@mail.gmail.com>
Message-ID: <CAHk-=wi6A9tgw=kkPh5Ywqt687VvsVEjYXVkAnq0jpt0u0tk6g@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] x86: Allow breakpoints to emulate call functions
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
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
        Joerg Roedel <jroedel@suse.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 2, 2019 at 11:18 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> We could fix this by not using the common exit path on int3; not sure we
> want to go there, but that is an option.

I don't think it's an option in general, because *some* int3
invocations will need all the usual error return.

But I guess we could make "int3 from kernel space" special.

I'm not sure how much that would help, but it might be worth looking into.

> ARGH; I knew it was too pretty :/ Yes, something like what you suggest
> will be needed, I'll go look at that once my brain recovers a bit from
> staring at entry code all day.

Looks like it works based on your other email.

What would it look like with the "int3-from-kernel is special" modification?

Because *if* we can make the "kernel int3" entirely special, that
would make the "Eww factor" much less of this whole thing.

I forget: is #BP _only_ for the "int3" instruction? I know we have
really nasty cases with #DB (int1) because of "pending exceptions
happen on the first instruction in kernel space", and that makes it
really really nasty to handle with all the stack switch and %cr3
handling etc.

But if "int3 from kernel space" _only_ happens on actual "int3"
instructions, then we really could just special-case that case. We'd
know that %cr3 has been switched, we'd know that we don't need to do
fsgs switching, we'd know we already have a good stack and percpu data
etc set up.

So then special casing #BP would actually allow us to have a simple
and straightforward kernel-int3-only sequence?

And then having that odd stack setup special case would be *much* more
palatable to me.

               Linus
