Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5ED8C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 23:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696E9204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 23:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZCH6EI9t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391671AbfGRXC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 19:02:59 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46962 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbfGRXC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 19:02:58 -0400
Received: by mail-pl1-f196.google.com with SMTP id c2so14590115plz.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 16:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g4WRpCk1XrEk1b73jpApWGwMKkrhqtgqCB2gVeCoQmA=;
        b=ZCH6EI9tXRc3w98A4fnZ0PBEHCgTuOx3uRxBW6aFPWscjuKATpABhx6pE8aP2+W9h+
         TQMgA9SvN1JW45Gx3hK3+ETp4q/U/yrU8hQl/Pmmxy7MsxsVnzCwjmXPHHP+Tr9fiBRT
         9oeKG0iYwy/ZY5kpuPbKXmT3REzZvzydOi4xs6VsMONC1J3O9RB0JX+AdIDxCdV1hmTr
         1yDy31Wz9V5dCUZ/OSWkZbVMHu+ll3om4GFOZU0vBRulZob25sE9Hi4Zis1DYBQX3Jim
         7omXzkdn/x2kDiemxfMfdLq2eCIsBhc6mRgMyPtPGW6H3dYiDDYNfUPIVeoFEjTcLYk9
         8rag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g4WRpCk1XrEk1b73jpApWGwMKkrhqtgqCB2gVeCoQmA=;
        b=iqzKHK50rlVtdaQYuZJGoVJJFmWT4frTEpw/I0hzP9JXepNghh76T2CipdX8JoQ36N
         RlPT5NepwqF0ycq43dvNTjoKSLc25NR0r0txNG0DTfKilF4gQeboSRQQwrhl6Oig6w1y
         kQszPrCFX6HsMMg0UzPjV6vI7VvFHvTmzKhA/1vaHqxm7pqMQOs5TmP9FDX71Ch0w36J
         qnkgA3EfFxcXIc95oLqmuj1Ms/dWPGykJrL/UCpKU5wmrISz9DrFWDE+0TPkmi+eaE+T
         YTd6IVCOSVtBUGWlLWWQChDDGBa3qRqskAR6RqwwlOm5HX3jsJ4SDl7lybYvHvtPGgw3
         dryA==
X-Gm-Message-State: APjAAAUN3IS8yU9gQD4r9CEm+OlPLl5zoZjeSrlTIcR66XXy73P79wi1
        7b0mllb8Sr6Belr5aQSxIrWxipBH7mQ/nSfHTNZlOQ==
X-Google-Smtp-Source: APXvYqx9DhTDatAcTHML0EhoeC0jezXO5/4rnZMQZkl0o5fmjOv+1Axq0niK8rtH74spMCCMRguvn7hLNEyjcHmTBJk=
X-Received: by 2002:a17:902:4aa3:: with SMTP id x32mr50755541pld.119.1563490977679;
 Thu, 18 Jul 2019 16:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1563150885.git.jpoimboe@redhat.com> <9f67aa11794e9eebe5a3249529d1ecf60abf370f.1563150885.git.jpoimboe@redhat.com>
 <CAKwvOdmUX31KcvDpdzOkrO=Jw+FFQ8MuiQkVFFnNeG9n28k5Aw@mail.gmail.com> <20190715172934.4uinmu3ba65vcphv@treble>
In-Reply-To: <20190715172934.4uinmu3ba65vcphv@treble>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 18 Jul 2019 16:02:46 -0700
Message-ID: <CAKwvOd=5jJxkRaAC+sEYOd9s3vfWDdQzN-a3YxHh-Qen7FHBpA@mail.gmail.com>
Subject: Re: [PATCH 20/22] objtool: Fix seg fault on bad switch table entry
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 10:29 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Mon, Jul 15, 2019 at 10:24:24AM -0700, Nick Desaulniers wrote:
> > On Sun, Jul 14, 2019 at 5:37 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >
> > > In one rare case, Clang generated the following code:
> > >
> > >  5ca:       83 e0 21                and    $0x21,%eax
> > >  5cd:       b9 04 00 00 00          mov    $0x4,%ecx
> > >  5d2:       ff 24 c5 00 00 00 00    jmpq   *0x0(,%rax,8)
> > >                     5d5: R_X86_64_32S       .rodata+0x38
> > >
> > > which uses the corresponding jump table relocations:
> > >
> > >   000000000038  000200000001 R_X86_64_64       0000000000000000 .text + 834
> > >   000000000040  000200000001 R_X86_64_64       0000000000000000 .text + 5d9
> > >   000000000048  000200000001 R_X86_64_64       0000000000000000 .text + b96
> > >   000000000050  000200000001 R_X86_64_64       0000000000000000 .text + b96
> > >   000000000058  000200000001 R_X86_64_64       0000000000000000 .text + b96
> > >   000000000060  000200000001 R_X86_64_64       0000000000000000 .text + b96
> > >   000000000068  000200000001 R_X86_64_64       0000000000000000 .text + b96
> > >   000000000070  000200000001 R_X86_64_64       0000000000000000 .text + b96
> > >   000000000078  000200000001 R_X86_64_64       0000000000000000 .text + b96
> > >   000000000080  000200000001 R_X86_64_64       0000000000000000 .text + b96
> > >   000000000088  000200000001 R_X86_64_64       0000000000000000 .text + b96
> > >   000000000090  000200000001 R_X86_64_64       0000000000000000 .text + b96
> > >   000000000098  000200000001 R_X86_64_64       0000000000000000 .text + b96
> > >   0000000000a0  000200000001 R_X86_64_64       0000000000000000 .text + b96
> > >   0000000000a8  000200000001 R_X86_64_64       0000000000000000 .text + b96
> > >   0000000000b0  000200000001 R_X86_64_64       0000000000000000 .text + b96
> > >   0000000000b8  000200000001 R_X86_64_64       0000000000000000 .text + b96
> > >   0000000000c0  000200000001 R_X86_64_64       0000000000000000 .text + b96
> > >   0000000000c8  000200000001 R_X86_64_64       0000000000000000 .text + b96
> > >   0000000000d0  000200000001 R_X86_64_64       0000000000000000 .text + b96
> > >   0000000000d8  000200000001 R_X86_64_64       0000000000000000 .text + b96
> > >   0000000000e0  000200000001 R_X86_64_64       0000000000000000 .text + b96
> > >   0000000000e8  000200000001 R_X86_64_64       0000000000000000 .text + b96
> > >   0000000000f0  000200000001 R_X86_64_64       0000000000000000 .text + b96
> > >   0000000000f8  000200000001 R_X86_64_64       0000000000000000 .text + b96
> > >   000000000100  000200000001 R_X86_64_64       0000000000000000 .text + b96
> > >   000000000108  000200000001 R_X86_64_64       0000000000000000 .text + b96
> > >   000000000110  000200000001 R_X86_64_64       0000000000000000 .text + b96
> > >   000000000118  000200000001 R_X86_64_64       0000000000000000 .text + b96
> > >   000000000120  000200000001 R_X86_64_64       0000000000000000 .text + b96
> > >   000000000128  000200000001 R_X86_64_64       0000000000000000 .text + b96
> > >   000000000130  000200000001 R_X86_64_64       0000000000000000 .text + b96
> > >   000000000138  000200000001 R_X86_64_64       0000000000000000 .text + 82f
> > >   000000000140  000200000001 R_X86_64_64       0000000000000000 .text + 828
> > >
> > > Since %eax was masked with 0x21, only the first two and the last two
> > > entries are possible.
> > >
> > > Objtool doesn't actually emulate all the code, so it isn't smart enough
> > > to know that all the middle entries aren't reachable.  They point to the
> > > NOP padding area after the end of the function, so objtool seg faulted
> > > when it tried to dereference a NULL insn->func.
> > >
> > > After this fix, objtool still gives an "unreachable" error because it
> > > stops reading the jump table when it encounters the bad addresses:
> > >
> > >   /home/jpoimboe/objtool-tests/adm1275.o: warning: objtool: adm1275_probe()+0x828: unreachable instruction
> > >
> > > While the above code is technically correct, it's very wasteful of
> > > memory -- it uses 34 jump table entries when only 4 are needed.  It's
> > > also not possible for objtool to validate this type of switch table
> > > because the unused entries point outside the function and objtool has no
> > > way of determining if that's intentional.  Hopefully the Clang folks can
> > > fix it.
> >
> > So this came from
> > drivers/hwmon/pmbus/adm1275.c ?

$ grep switch drivers/hwmon/pmbus/adm1275.c | wc -l
8
$ grep switch drivers/hwmon/pmbus/adm1275.c
switch (reg) {
switch (reg) {
switch (reg) {
switch (data->id) {
switch (config & ADM1075_IRANGE_MASK) {
switch (config & (ADM1275_VRANGE | ADM1272_IRANGE)) {
switch (config & ADM1293_VIN_SEL_MASK) {
switch (config & ADM1293_IRANGE_MASK) {

Looking specifically at the definition of adm1275_probe, I see:

...
        switch (data->id) {
                ...
                switch (config & ADM1075_IRANGE_MASK) {
                ...
                switch (config & (ADM1275_VRANGE | ADM1272_IRANGE)) {
                ...
                switch (config & ADM1293_VIN_SEL_MASK) {
                ...
                switch (config & ADM1293_IRANGE_MASK) {

So I assume that the two level switch statement is somehow related.
Maybe the two level switch is transformed into a one level switch with
duplicated case labels?  Let me play around in <strikethrough>my
sandbox</strikethrough>godbolt and see if I can reproduce with that
pattern.
-- 
Thanks,
~Nick Desaulniers
