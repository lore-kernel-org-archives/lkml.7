Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8B1C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E4F2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfH1OGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 10:06:49 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45766 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfH1OGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:06:49 -0400
Received: by mail-qt1-f195.google.com with SMTP id k13so3077668qtm.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 07:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HCYlD95JsHarElAe+L4VlohLW1cThA2+xRRSBnbJqFM=;
        b=B/srqm0ctCvfPe5ecd1L9osjFfvEawSLPgqEfrbJBR41YaASiXlyOkb1qq47wiYssE
         N3sLA/eAI2YGt7DR+kYfO+x7Lm09QBq81UvBDpHO8xEPpq/DG2co60ngXKNKi6Zd6kFx
         1ENvKecmfxy0Y7Z8aOzNOYWEVVAoYsGWZ4gs+CaAV0tVVnrfc5Gfb9usWzGuD2YpaCoR
         diGXU8FWV09muhm0ohuqDFEfDpsvy/XiEiuInQOamoZsD01dfJBvbNeobzjRVD1E6u6g
         G/1Fg63YT7zh3g0JkJaavuFareZHgsVdQrWKbojnJCbKJPTolCzD+2g7B4bvKOZ8qF2v
         /IUA==
X-Gm-Message-State: APjAAAVC3JqtEAhhmTfJvtol19zJagPmSnGK5VIybLoMBLDzc3MKt97y
        sD0BJ/+uqL1lvG/gnL4uWDvj8pCAEl/sU3fgUVk=
X-Google-Smtp-Source: APXvYqxsbJeBGM7IU7QJquPXMN7X7kVaWdKQyvaMU4eI2H116h4/4DWw85uMpMpeYhha+XgPxYfR3j/BGT7QlEQPzdA=
X-Received: by 2002:a0c:e74b:: with SMTP id g11mr2805518qvn.62.1567001208190;
 Wed, 28 Aug 2019 07:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a3G=GCpLtNztuoLR4BuugAB=zpa_Jrz5BSft6Yj-nok1g@mail.gmail.com>
 <20190827145102.p7lmkpytf3mngxbj@treble> <CAHFW8PRsmmCR6TWoXpQ9gyTA7azX9YOerPErCMggcQX-=fAqng@mail.gmail.com>
 <CAK8P3a2TeaMc_tWzzjuqO-eQjZwJdpbR1yH8yzSQbbVKdWCwSg@mail.gmail.com>
 <20190827192255.wbyn732llzckmqmq@treble> <CAK8P3a2DWh54eroBLXo+sPgJc95aAMRWdLB2n-pANss1RbLiBw@mail.gmail.com>
 <CAKwvOdnD1mEd-G9sWBtnzfe9oGTeZYws6zNJA7opS69DN08jPg@mail.gmail.com> <CAK8P3a0nJL+3hxR0U9kT_9Y4E86tofkOnVzNTEvAkhOFxOEA3Q@mail.gmail.com>
In-Reply-To: <CAK8P3a0nJL+3hxR0U9kT_9Y4E86tofkOnVzNTEvAkhOFxOEA3Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 28 Aug 2019 16:06:32 +0200
Message-ID: <CAK8P3a0XqxBwRH2mkge0Ah87BnqobNWGkE4rhpmvNxGxjgExww@mail.gmail.com>
Subject: Re: objtool warning "uses BP as a scratch register" with clang-9
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 11:00 AM Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Aug 27, 2019 at 11:22 PM 'Nick Desaulniers' via Clang Built Linux <clang-built-linux@googlegroups.com> wrote:

> http://paste.ubuntu.com/p/XjdDsypRxX/
> 0x5BA1B7A1:arch/x86/ia32/ia32_signal.o: warning: objtool:
> ia32_setup_rt_frame()+0x238: call to memset() with UACCESS enabled
> 0x5BA1B7A1:arch/x86/kernel/signal.o: warning: objtool:
> __setup_rt_frame()+0x5b8: call to memset() with UACCESS enabled
> 0x5BA1B7A1:mm/kasan/common.o: warning: objtool: kasan_report()+0x44:
> call to __stack_chk_fail() with UACCESS enabled
> 0x5BA1B7A1:kernel/trace/trace_selftest_dynamic.o: warning: objtool:
> __llvm_gcov_writeout()+0x13: call without frame pointer save/setup
> 0x5BA1B7A1:kernel/trace/trace_selftest_dynamic.o: warning: objtool:
> __llvm_gcov_flush()+0x0: call without frame pointer save/setup
> 0x5BA1B7A1:kernel/trace/trace_clock.o: warning: objtool:
> __llvm_gcov_writeout()+0x14: call without frame pointer save/setup
> 0x5BA1B7A1:kernel/trace/trace_clock.o: warning: objtool:
> __llvm_gcov_flush()+0x0: call without frame pointer save/setup
> 0x5BA1B7A1:kernel/trace/*: # many more of the same, all in this directory
> 0x5BA1B7A1:kernel/trace/trace_uprobe.o: warning: objtool:
> __llvm_gcov_flush()+0x0: call without frame pointer save/setup

I had a look here and opened
https://bugs.llvm.org/show_bug.cgi?id=43141

It seems that CONFIG_FRAME_POINTER is ignored for the functions
that are generated with CONFIG_GCOV_KERNEL. See also:

$ clang-9 -fprofile-arcs -fno-omit-frame-pointer -c -xc /dev/null   -o null.o
$ ./tools/objtool/objtool check null.o
null.o: warning: objtool: __llvm_gcov_writeout()+0x3e: call without
frame pointer save/setup
null.o: warning: objtool: __llvm_gcov_flush()+0x1: call without frame
pointer save/setup
null.o: warning: objtool: __llvm_gcov_init()+0x15: call without frame
pointer save/setup

       Arnd
