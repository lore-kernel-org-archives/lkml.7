Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471DBC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041CE22CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kJN/7pmh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfH1VmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 17:42:13 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55613 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfH1VmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 17:42:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id f72so1541264wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 14:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9cUJTalk9UT065cy7J/NUfxyGrICB2f0wc49I6zU5Q4=;
        b=kJN/7pmheA+InmF5KtWUWMzBtSOESyyTW+USV1YM83xekT1h153KEu9IbmmJMDE5ek
         l6S5X2qixTwye9mi7j67MC9Wdzf+c66cmbG7iV2OGjhLAJZbeG624TAGyRgWtOySwV05
         eRC+BnNgobC1I9P6ObA622jQrkGm8WuID8P9Yr1UggCuTAWplbw/7b40sDu4rqHHRSiI
         VSDAwdaf6bYmoxMcKxbxxrxIL4c4i41Mp5aZk8BrgKbZ2EDeGLzHmjJ6WVf+zlVEACVL
         vpEg6fDwPkDkBHoNvXHfXVdWEKr7vvMlvZM51hA7DOkv6bm1PnYgmLmSakPrZuViRvQ5
         /HZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9cUJTalk9UT065cy7J/NUfxyGrICB2f0wc49I6zU5Q4=;
        b=jDs62tW9ttfVTPX4p50vwCP4yc71u4s0YdKRQHwh/iMc5C7/XxKHSA0QytaUW7G+Tk
         Rze87LwXTycmKXuexNdMUhzcrQPQKqmHrUusM8CaNIc2G37KgZ/0UpmocJnQLhj9HY54
         XKbkroD1cXoLRzaeYVdQDUtm3SLh+DCcK/RMHBJ1nNMH3sgDOVTdmMCnXkzDqoKrTtK3
         rgE5mPelivL4bq8TqJmpWXi3mC3DwEVGPieJdCpDqrzNjEyBzyxmb5EiUb10A1wJcwpj
         88/oKaPx75vERH5MB+BbItypmIoyEQXk0Abnfb4PKYay4LOGzWS/6aZseHlge+EUHUtR
         FJHw==
X-Gm-Message-State: APjAAAV050LjkE9OBkKMJmTI1BhuIoco58GU/kfYMZlWrM7keE1eWxoP
        7HcSjjNWNGLrH1qbremRJxFm9g==
X-Google-Smtp-Source: APXvYqxKQxTbvoB4+l8ypE9/XNNnCohkPRwiPD2P5IbHpI3y4/6JjoMT+BmXEILa3fjrCMNPSPldwQ==
X-Received: by 2002:a1c:6087:: with SMTP id u129mr7000155wmb.108.1567028528895;
        Wed, 28 Aug 2019 14:42:08 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id d16sm262566wrv.55.2019.08.28.14.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 14:42:08 -0700 (PDT)
Date:   Wed, 28 Aug 2019 22:42:05 +0100
From:   Matthias Maennich <maennich@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Debian kernel maintainers <debian-kernel@lists.debian.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Sandeep Patil <sspatil@google.com>,
        Steve Muckle <smuckle@google.com>,
        Alessio Balsini <balsini@google.com>,
        Stephen Hines <srhines@google.com>,
        Jessica Yu <jeyu@kernel.org>, Dodji Seketeli <dodji@redhat.com>
Subject: Re: a bug in genksysms/CONFIG_MODVERSIONS w/ __attribute__((foo))?
Message-ID: <20190828214205.GC30359@google.com>
References: <CAKwvOdnJAApaUhTQs7w_VjSeYBQa0c-TNxRB4xPLi0Y0sOQMMQ@mail.gmail.com>
 <CAKwvOdkbY_XatVfRbZQ88p=nnrahZbvdjJ0OkU9m73G89_LRzg@mail.gmail.com>
 <1566899033.o5acyopsar.astroid@bobo.none>
 <CAK7LNARHacanVT6XjRDkFJDETWX6qHfUJCFhskCVG6aDL-bt1g@mail.gmail.com>
 <1566908344.dio7j9zb2h.astroid@bobo.none>
 <daacccf8e36132b6a747fa4b42626a8812906eaa.camel@decadent.org.uk>
 <1566955930.uir50f8wen.astroid@bobo.none>
 <CAKwvOdmtT4in42Nwsm0ndqm8CB2jzaCKvtX+nmhdpA2dgMpBmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAKwvOdmtT4in42Nwsm0ndqm8CB2jzaCKvtX+nmhdpA2dgMpBmw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 10:17:27AM -0700, Nick Desaulniers wrote:
>On Tue, Aug 27, 2019 at 7:26 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>>
>> Ben Hutchings's on August 28, 2019 1:34 am:
>> > On Tue, 2019-08-27 at 22:42 +1000, Nicholas Piggin wrote:
>> >> Masahiro Yamada's on August 27, 2019 8:49 pm:
>> >> > Hi.
>> >> >
>> >> > On Tue, Aug 27, 2019 at 6:59 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>> >> > > Nick Desaulniers's on August 27, 2019 8:57 am:
>> >> > > > On Mon, Aug 26, 2019 at 2:22 PM Nick Desaulniers
>> >> > > > <ndesaulniers@google.com> wrote:
>> >> > > > > I'm looking into a linkage failure for one of our device kernels, and
>> >> > > > > it seems that genksyms isn't producing a hash value correctly for
>> >> > > > > aggregate definitions that contain __attribute__s like
>> >> > > > > __attribute__((packed)).
>> >> > > > >
>> >> > > > > Example:
>> >> > > > > $ echo 'struct foo { int bar; };' | ./scripts/genksyms/genksyms -d
>> >> > > > > Defn for struct foo == <struct foo { int bar ; } >
>> >> > > > > Hash table occupancy 1/4096 = 0.000244141
>> >> > > > > $ echo 'struct __attribute__((packed)) foo { int bar; };' |
>> >> > > > > ./scripts/genksyms/genksyms -d
>> >> > > > > Hash table occupancy 0/4096 = 0
>> >> > > > >
>> >> > > > > I assume the __attribute__ part isn't being parsed correctly (looks
>> >> > > > > like genksyms is a lex/yacc based C parser).
>> >> > > > >
>> >> > > > > The issue we have in our out of tree driver (*sadface*) is basically a
>> >> > > > > EXPORT_SYMBOL'd function whose signature contains a packed struct.
>> >> > > > >
>> >> > > > > Theoretically, there should be nothing wrong with exporting a function
>> >> > > > > that requires packed structs, and this is just a bug in the lex/yacc
>> >> > > > > based parser, right?  I assume that not having CONFIG_MODVERSIONS
>> >> > > > > coverage of packed structs in particular could lead to potentially
>> >> > > > > not-fun bugs?  Or is using packed structs in exported function symbols
>> >> > > > > with CONFIG_MODVERSIONS forbidden in some documentation somewhere I
>> >> > > > > missed?
>> >> > > >
>> >> > > > Ah, looks like I'm late to the party:
>> >> > > > https://lwn.net/Articles/707520/
>> >> > >
>> >> > > Yeah, would be nice to do something about this.
>> >> >
>> >> > modversions is ugly, so it would be great if we could dump it.
>> >> >
>> >> > > IIRC (without re-reading it all), in theory distros would be okay
>> >> > > without modversions if they could just provide their own explicit
>> >> > > versioning. They take care about ABIs, so they can version things
>> >> > > carefully if they had to change.
>> >
>> > Debian doesn't currently have any other way of detecting ABI changes
>> > (other than eyeballing diffs).
>> >
>> > I know there have been proposals of using libabigail for this instead,
>> > but I'm not sure how far those progressed.
>> >
>> >> > We have not provided any alternative solution for this, haven't we?
>> >> >
>> >> > In your patch (https://lwn.net/Articles/707729/),
>> >> > you proposed CONFIG_MODULE_ABI_EXPLICIT.
>> >>
>> >> Right, that was just my first proposal, but I am not confident that I
>> >> understood everybody's requirements. I don't think the distro people
>> >> had much time to to test things out.
>> >>
>> >> One possible shortcoming with that patch is no per-symbol version. The
>> >> distro may break an ABI for a security fix, but they don't want to break
>> >> all out of tree modules if it's an obscure ABI.
>> >
>> > Right, for example the KVM kABI is only meant for in-tree modules (like
>> > kvm_intel) and in Debian we do not change the "ABI version" and require
>> > rebuilding out-of-tree modules just because that ABI changes.
>> > Currently we maintain explicit lists of exported symbols and exporting
>> > modules for which we ignore ABI changes at build time.
>> >
>> >> The counter argument to
>> >> that is they should just rename the symbol in their kernel for such
>> >> cases, so I didn't implement it without somebody describing a good
>> >> requirement.
>> > [...]
>> >
>> > Sometimes it is just a single function that changes, but often a
>> > structure change can affect large numbers of functions.  For example,
>> > if KVM adds a member to an operations struct that can indirectly change
>> > the ABI for most of its exported functions.  We wouldn't want to change
>> > the ABI version but would still want to prevent loading mismatched kvm
>> > and kvm_intel versions.  It would be a lot more work to change all of
>> > the affected function names.
>>
>> You could change just a single symbol name though :)
>>
>> > An alternative to symbol version matching that I think would work for
>> > us is: if a module's exports or imports match the "changes ignored"
>> > list then the module can only be loaded on the exact version of the
>> > kernel, otherwise it only needs to match the ABI version.  I think that
>> > would avoid the need for carrying symbol versions, but we would still
>> > need a build-time ABI check and a way of flagging which symbols need
>> > the tighter version match.
>>
>> Just trying to think how best to express that.
>>
>> [ Aside, the whole symbol name resolution linking stuff does matching on
>>   on any number of ~arbitrary strings that you can generate as you like,
>>   and symbol tables are something that all existing tools and libs
>>   understand.
>>
>>   So I strongly favour using that as the back end for our "version"
>>   resolution system _if at all possible_ rather than adding these extra
>>   bits of crud that really just do the same thing. At least for a first
>>   pass, I don't want to over-engineer things.
>>
>>   Then it hopefully becomes a matter of adding some helper macros and
>>   build facilities on top of that which can contain everyone's
>>   requirements mostly within .config and perhaps a very small patch.
>>   A bit more work with preprocessor macros etc is far preferable to
>>   linking and loading "features" IMO]
>>
>> Back to your case, is it sufficient to have just an internal and an
>> external module version where the kernel provides both and your in-tree
>> modules match on the internal, others match on external?
>>
>> Thanks,
>> Nick
>>
>
>+ some Android folks who are looking into libabigail
>
>(root thread for context:
>https://lore.kernel.org/lkml/CAKwvOdnJAApaUhTQs7w_VjSeYBQa0c-TNxRB4xPLi0Y0sOQMMQ@mail.gmail.com/)
>
>I'm only roughly aware of their issue/work, but hopefully they can
>collaborate and add their insights to a list of requirements we could
>collect, for any kind of replacement to CONFIG_MODVERSIONS/genksyms.
>I'm not sure if they were planning on presenting this work at Linux
>Plumber's Conference coming up or not, but I hope so.  Hopefully that
>work will be a general solution for all kernel developers and distros,
>not just Android.

Several people are currently working on improving libabigail's
capabilities to deal with the kernel binaries. That ranges from fixes
for newer kernel versions or fixes for binaries built with clang to
performance improvements to better integrate the tool into build
processes etc. There is still some work to do to be an actual
replacement for what is used right now to detect ABI incompatibilities.
But things look promising. The work that is done there is supposed to
address general issues, not just Android. In particular, libabigail
should be able to reliably keep track of the observable in-kernel ABI of
the kernel binaries to detect potential incompatibilities with
previously released kernel binaries. Please note, that this all happens
after the build by inspecting binaries. As opposed to other solutions,
in its current form, libabigail does not introduce any checks at
runtime (i.e. module load time).

There are discussions about this topic scheduled at Plumber's in the
Distro MC and the Android MC.

Cheers,
Matthias

>This issue is now blocking my compiler upgrade, so I'm going to focus
>on just fixing the yacc based parser to understand __attribute__'s on
>struct/enum/union declarations.
>
>Speaking with Arnd about this issue, he came up with the test case:
>$ echo 'struct __attribute__((packed)) foo { char bar; int baz; };' |
>./scripts/genksyms/genksyms -d
>Hash table occupancy 0/4096 = 0
>$ echo 'struct __attribute__((packed)) foo { char bar; };' |
>./scripts/genksyms/genksyms -d
>Hash table occupancy 0/4096 = 0
>
>The implication being that because attributes don't parse correctly,
>these symbols get a hash value of 0x00 in Module.symvers, meaning we
>currently can't detect size changes of packed structs (or any other
>attribute-qualified type) and happily proceed loading modules with
>different ABIs than the kernel.
>
>I'll probably add some kind of script for unit tests for genksyms,
>too.  Feels like overkill for something known to be broken where
>active replacements are being discussed, but it's blocking my compiler
>upgrade for our products, so I'm just going to fix it for now.
