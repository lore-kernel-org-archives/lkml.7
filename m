Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AECC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 19:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A189A2189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 19:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfH1TmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 15:42:05 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46804 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfH1TmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 15:42:05 -0400
Received: by mail-qk1-f194.google.com with SMTP id p13so789863qkg.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 12:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GW0tqEqMsiVVgwwzpWylrg4uBDcBgz1jfCvWma45dGA=;
        b=pBBNm8yjtROtTr6BcUH88l326fzf/1yTHSAHYUF7KCvMJjsZKCHpVZhra0ubNn1x9v
         gWsz2Xsl2YZJUP9cWsW1XBykAn2LEdpVhEQGXhLD+YtZK/mAS1xOeR1lYu6EcwXpTrSt
         jGnuEK6KkFAZ/O9P4y1p5YCxFuD2vuVpjSuqyACQAlgt1kDdYNsko6nBKnsa3dnSLnM6
         EjAjGLYXoqczQKOej+5jNLBn/g9EONddvFvaUPPxCaVh7lyc1UHjV56I4CpxJeL3keCH
         iCpazqCQknA3KUP7ZfW7BvTwZOGx5IatSkwK7QUKv65C1z3982srn4+fjZwEG2Sf5RZM
         WQdw==
X-Gm-Message-State: APjAAAX9vKyxT1duUfi9MbjIzaaufw+1hC0yW09V9vKiKky6o0je1/xn
        Bq/eQi85a4ldzDz9BbgsYiHQ+ZgA4nFdGwrymBI=
X-Google-Smtp-Source: APXvYqzLAvB/Xb/+yr0cNVd+/T5DESTxs1MbrXkH83HBhT3IA8D06GJEO7du4tL3Ed1bHQuUxz5fssaWKyxJVME+34w=
X-Received: by 2002:a37:bd44:: with SMTP id n65mr5815134qkf.286.1567021323862;
 Wed, 28 Aug 2019 12:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a3G=GCpLtNztuoLR4BuugAB=zpa_Jrz5BSft6Yj-nok1g@mail.gmail.com>
 <20190827145102.p7lmkpytf3mngxbj@treble> <CAHFW8PRsmmCR6TWoXpQ9gyTA7azX9YOerPErCMggcQX-=fAqng@mail.gmail.com>
 <CAK8P3a2TeaMc_tWzzjuqO-eQjZwJdpbR1yH8yzSQbbVKdWCwSg@mail.gmail.com>
 <20190827192255.wbyn732llzckmqmq@treble> <CAK8P3a2DWh54eroBLXo+sPgJc95aAMRWdLB2n-pANss1RbLiBw@mail.gmail.com>
 <CAKwvOdnD1mEd-G9sWBtnzfe9oGTeZYws6zNJA7opS69DN08jPg@mail.gmail.com>
 <CAK8P3a0nJL+3hxR0U9kT_9Y4E86tofkOnVzNTEvAkhOFxOEA3Q@mail.gmail.com>
 <20190828145102.o7h3la3ofb2b4aie@treble> <CAK8P3a1gkA4cqbKbLLCAukiX-0tA9fV_FTG6PLTfv+DSHp44GQ@mail.gmail.com>
 <20190828175713.s7jub3sf6l7vyfoj@treble>
In-Reply-To: <20190828175713.s7jub3sf6l7vyfoj@treble>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 28 Aug 2019 21:41:47 +0200
Message-ID: <CAK8P3a0C6jvBqsO2KXOV-j3eQ07zvCjUWqaYdTKDfne72EWUDA@mail.gmail.com>
Subject: Re: objtool warning "uses BP as a scratch register" with clang-9
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 7:57 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> On Wed, Aug 28, 2019 at 05:29:39PM +0200, Arnd Bergmann wrote:
> > On Wed, Aug 28, 2019 at 4:51 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> exit.o: warning: objtool: abort()+0x3: unreachable instruction
> hugetlb.o: warning: objtool: hugetlb_vm_op_fault()+0x3: unreachable instruction
> idle.o: warning: objtool: switched_to_idle()+0x3: unreachable instruction
> madvise.o: warning: objtool: hugepage_madvise()+0x3: unreachable instruction
> privcmd.o: warning: objtool: privcmd_ioctl_mmap_batch()+0x5dd: unreachable instruction
> process.o: warning: objtool: play_dead()+0x3: unreachable instruction
> rmap.o: warning: objtool: anon_vma_clone()+0x1c2: unreachable instruction
> s5c73m3-core.o: warning: objtool: s5c73m3_probe()+0x262: unreachable instruction
> videobuf2-core.o: warning: objtool: vb2_core_dqbuf()+0xae6: unreachable instruction
> xfrm_output.o: warning: objtool: xfrm_outer_mode_output()+0x109: unreachable instruction
> - clang issue: trying to finish frame pointer setup after BUG() in unreachable code path
>
> pinctrl-ingenic.o: warning: objtool: ingenic_pinconf_set()+0x10d: sibling call from callable instruction with modified stack frame
> - bad clang bug: sibling call without first popping registers

I reduced the last one to https://godbolt.org/z/7lZZL3

enum { PIN_CONFIG_BIAS_DISABLE } pinconf_to_config_param(void);
void ingenic_pinconf_set() {
  switch (pinconf_to_config_param())
  case PIN_CONFIG_BIAS_DISABLE: {
    asm("%c0:\n\t.pushsection .discard.unreachable\n\t.long %c0b - "
        ".\n\t.popsection\n\t"
        :
        : "i"(6));
    __builtin_unreachable();
  }
}
void ingenic_pinconf_group_set() {}

$ clang-9  -Os -mretpoline-external-thunk -fno-omit-frame-pointer -c
pinctrl-ingenic.i
$ objtool check  --retpoline --uaccess pinctrl-ingenic.o
pinctrl-ingenic.o: warning: objtool: ingenic_pinconf_set()+0xb:
sibling call from callable instruction with modified stack frame

$objdump -d pinctrl-ingenic.o
0000000000000000 <ingenic_pinconf_set>:
   0: 55                    push   %rbp
   1: 48 89 e5              mov    %rsp,%rbp
   4: e8 00 00 00 00        callq  9 <ingenic_pinconf_set+0x9>
5: R_X86_64_PLT32 pinconf_to_config_param-0x4
   9: 85 c0                test   %eax,%eax
   b: 74 02                je     f <ingenic_pinconf_group_set>
   d: 5d                    pop    %rbp
   e: c3                    retq

000000000000000f <ingenic_pinconf_group_set>:
   f: c3                    retq

I suspect that's actually another variant of the others. It doesn't
seem to be an
actual sibling call, just branching into what happens to be the start of the
next function in an unreachable code path.

Using '-O2' instead of '-0s', I get

pinctrl-ingenic.o: warning: objtool: ingenic_pinconf_set() falls
through to next function ingenic_pinconf_group_set()

0000000000000000 <ingenic_pinconf_set>:
   0: 55                    push   %rbp
   1: 48 89 e5              mov    %rsp,%rbp
   4: e8 00 00 00 00        callq  9 <ingenic_pinconf_set+0x9>
5: R_X86_64_PLT32 pinconf_to_config_param-0x4
   9: 85 c0                test   %eax,%eax
   b: 74 02                je     f <ingenic_pinconf_set+0xf>
   d: 5d                    pop    %rbp
   e: c3                    retq
   f: 90                    nop

0000000000000010 <ingenic_pinconf_group_set>:
  10: c3                    retq

        Arnd
