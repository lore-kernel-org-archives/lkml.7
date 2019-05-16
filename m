Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8522C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 21:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DC620818
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 21:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="bIdTWxV9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfEPVZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 17:25:00 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33742 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfEPVZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 17:25:00 -0400
Received: by mail-qk1-f195.google.com with SMTP id p18so2688495qkk.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 14:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mlYpzDmtlsvC1/mmC4ysTMSsHaOni64XRA7rkjJcGEI=;
        b=bIdTWxV9bgtKvw0UhjzPSojWTBxxQMcW6TdA2vwpQAMXlUs/xTgK1R111IzVxs/XTC
         hj8HjQnL/ks5LMuZClq4g+ezQO6+jZM/pqmcxID7fKKX0snOVzCxnZsUTvOFdv4gIRTY
         aKWojmxmHiX8whwe6evh5HGOek2jta92VrwHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mlYpzDmtlsvC1/mmC4ysTMSsHaOni64XRA7rkjJcGEI=;
        b=jcwFdzu6Z23C9z/kFXOhTHz1qzgscRbAFIXzZqF+Vwizj6hjB04a/YwKMpg6VkPnPY
         O5GAQ1630zA6A+HmesOmWokUfOt2+265ImcIs44yg9yhfPu0yc57tt7WECz8QkGKySJr
         y4QiOK8k8zxoe6j0zXNq9U+v+iPWIbpBHNQ8ZNDz3/+KafkXEdAo/R7JN9ZKrl/Ukf+y
         AEFD0hwprCpM3wGne1ln7p1O+LuTIjbO9ArJ8WHYh0UwAT/ovr8YGzhcThTXsSH/zI/Q
         k65da9IqLR5NoQ5okaATOAZNHUJVkGAXXzwL2WClyFC4mARvaM/Kuo2uBfZM945+o2re
         xn3w==
X-Gm-Message-State: APjAAAVKRHYRlgebJYQRV0tepCKN6qBKB0cq0TkbCJ5xNPym4ozO2iOV
        hQ1It2+xoABnhp59BiIlPkNuc6IO8rIBOp03URtroA==
X-Google-Smtp-Source: APXvYqxOktug4IxjC7Dq+Bhrld0Om9NPYohQRA5pumFfH1kxMvTE9740E7df1S5lNz8bEDwhZ9gxydj5YC+XbC7vzIU=
X-Received: by 2002:a05:620a:408:: with SMTP id 8mr27848609qkp.239.1558041899186;
 Thu, 16 May 2019 14:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <CABWYdi06NUOWRLingNuybgZZsTZPjhmsOx-9oCGK94qZGYbzcw@mail.gmail.com>
 <CANiq72kvpiC-i53AXM-YsCUvWroHQemmqxsXjnB330ZEeHahUg@mail.gmail.com>
 <CABWYdi1zhTTaN-GSgH0DnPfz7p=SRw0wts5QVYYVtfvoiS0qnQ@mail.gmail.com> <CANiq72=fsL5m2_e+bNovFCHy3=YVf53EKGtGE_sWvsAD=ONHuQ@mail.gmail.com>
In-Reply-To: <CANiq72=fsL5m2_e+bNovFCHy3=YVf53EKGtGE_sWvsAD=ONHuQ@mail.gmail.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Thu, 16 May 2019 14:24:48 -0700
Message-ID: <CABWYdi1cPLUGws9bxk3FxVKO1v0i-GrKaov0kAJFuLBf8AS25w@mail.gmail.com>
Subject: Re: Linux 4.19 and GCC 9
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
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

On Thu, May 16, 2019 at 2:21 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Hi,
>
> On Thu, May 16, 2019 at 10:11 PM Ivan Babrou <ivan@cloudflare.com> wrote:
> >
> > Hey Miguel,
> >
> > The first error is during perf build process (make -C tools/perf install):
> >
> > [17:38:21] In file included from /usr/include/string.h:635,
> > [17:38:21]                  from ui/tui/helpline.c:4:
> > [17:38:21] In function 'strncpy',
> > [17:38:21]     inlined from 'tui_helpline__push' at ui/tui/helpline.c:27:2:
> > [17:38:21] /usr/include/x86_64-linux-gnu/bits/string3.h:126:10: error:
> > '__builtin_strncpy' specified bound 512 equals destination size
> > [-Werror=stringop-truncation]
> > [17:38:21]   126 |   return __builtin___strncpy_chk (__dest, __src,
> > __len, __bos (__dest));
> > [17:38:21]       |
> > ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > [17:38:21] cc1: all warnings being treated as errors
> > [17:38:21] /cfsetup_build/build/linux-4.19.43/tools/build/Makefile.build:96:
> > recipe for target '/cfsetup_build/build/amd64/perf/ui/tui/helpline.o'
> > failed
> > [17:38:21] mv: cannot stat
> > '/cfsetup_build/build/amd64/perf/ui/tui/.helpline.o.tmp': No such file
> > or directory
> > [17:38:21] make[6]: ***
> > [/cfsetup_build/build/amd64/perf/ui/tui/helpline.o] Error 1
> > [17:38:21] make[5]: *** [tui] Error 2
> > [17:38:21] make[4]: *** [ui] Error 2
> >
> > I see that stringop-truncation is disabled in toplevel Makefile, but
> > not sure if perf is using it.
>
> Ah, alright -- CC'ing the perf maintainers then in case they want to chime in.
>
> > If I disable perf build, the next thing is warnings like these:
> >
> > mm/slub.o: warning: objtool: init_cache_random_seq()+0x36: sibling
> > call from callable instruction with modified stack frame
> > mm/slub.o: warning: objtool: slab_out_of_memory()+0x3b: sibling call
> > from callable instruction with modified stack frame
> > mm/slub.o: warning: objtool: slab_pad_check.part.0()+0x7c: sibling
> > call from callable instruction with modified stack frame
> > mm/slub.o: warning: objtool: check_slab()+0x1c: sibling call from
> > callable instruction with modified stack frame
>
> AFAIK those are non-critical, i.e. stack traces may be wrong (or not),
> but it does not mean the generated kernel itself is wrong. CC'ing the
> objtool maintainers too.

I really like my stack traces definitely correct :)

Thanks for looping in the right people.

> > After patching that I see:
> >
> > In file included from /tmp/build/linux-4.19.43/arch/x86/crypto/aes_glue.c:6:
> > /tmp/build/linux-4.19.43/include/linux/module.h:133:6: warning:
> > 'init_module' specifies less restrictive attribute than its target
> > 'aes_init': 'cold' [-Wmissing-attributes]
> >   133 |  int init_module(void) __attribute__((alias(#initfn)));
> >       |      ^~~~~~~~~~~
> > /tmp/build/linux-4.19.43/arch/x86/crypto/aes_glue.c:64:1: note: in
> > expansion of macro 'module_init'
> >    64 | module_init(aes_init);
> >       | ^~~~~~~~~~~
> > /tmp/build/linux-4.19.43/arch/x86/crypto/aes_glue.c:54:19: note:
> > 'init_module' target declared here
> >    54 | static int __init aes_init(void)
> >       |                   ^~~~~~~~
>
> Ditto here, those can be ignored too (unless something has changed in
> GCC that I am not aware of).
>
> > I'm not really comfortable with all the warnings, so I stopped the
> > build, maybe it indeed compiles through the end.
>
> It does (on my GCC 9.1.1 compiled from source).
>
> I am not sure what is the policy on backporting (someone from the
> stable team can probably answer that; Greg?), but note that this
> kernel (and 4.20 and 5.0) was released before GCC 9 did -- and some
> (all?) of this was cleaned up before GCC 9 itself released, so we were
> ahead of it :-)
>
> Cheers,
> Miguel
