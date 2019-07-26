Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1B5C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 10:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA44218EA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 10:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfGZKl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 06:41:58 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41570 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfGZKl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 06:41:58 -0400
Received: by mail-ot1-f65.google.com with SMTP id o101so54866743ota.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 03:41:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mxtQTyz1jr4asSEEq6Sox9bcILV4txWbsV0XEV0OPp8=;
        b=PekS4KR0X9vn0yTHgOLNKd0Pehxn9bLXQ0I1jUk+92Rd7mFWzB8NTki85n2UyH67gx
         C5lBeNAPS0cAZv7ms8oG9OibPi5F5dcww9tMvqmD7FDHCyVK/LmCkDHKFJsKwvnuTPXt
         H/sYlVMdA4GaIgKE4YmsY4l0tDUtxeWkW5JCXQrL278fVwssRycr3MU87isArd3oLaqj
         x2z0w4o/I4lDXntH9fV7fGZQu/bZT64HzyZWiwVX7NQJMt6QDiE1V2VQhSCpzTFxxbDB
         PcNsT2YJ2aJy+qXvOUTtbAkdGun5U6EuTEfpvr7WmGsItrf7VojQNLdfuiyEGSpNRSFi
         MU5Q==
X-Gm-Message-State: APjAAAXKaKbVVidK74/06qkfAEl11O6kvzlljCS2JieKrGVVnaUl2gHd
        ljvrzGYxRZiA5NoBQTyLyek4DeR9Q94sG7kL4H4XlA==
X-Google-Smtp-Source: APXvYqyxrU4o2HGUGHrd34/TFhwl/qvazu9c6jLmZEf8byRR7dTkCcMl260sDIPvnIzfxhJy9Je7Fbd6Um030HCtn04=
X-Received: by 2002:a9d:758b:: with SMTP id s11mr30138097otk.130.1564137717287;
 Fri, 26 Jul 2019 03:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <xunytvceoyob.fsf@redhat.com> <f703360d-57c5-4858-e308-1e378a9cc0dc@iogearbox.net>
In-Reply-To: <f703360d-57c5-4858-e308-1e378a9cc0dc@iogearbox.net>
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Date:   Fri, 26 Jul 2019 13:41:41 +0300
Message-ID: <CANoWswn=gQq83fUE0p3DogAR1_hROJFHq=dmTU3qR_FLPkt+rQ@mail.gmail.com>
Subject: Re: bpf: test_verifier: sanitation: alu with different scalars
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        Jiri Benc <jbenc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Daniel,

On Tue, Jun 25, 2019 at 12:39 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 06/25/2019 10:29 AM, Yauheni Kaliuta wrote:
> > Hi!
> >
> > I'm wondering, how the sanitaion tests (#903 5.2-rc6 for example)
> > are supposed to work on BE arches:
> >
> > {
> >       "sanitation: alu with different scalars 1",
> >       .insns = {
> >       BPF_MOV64_IMM(BPF_REG_0, 1),
> >       BPF_LD_MAP_FD(BPF_REG_ARG1, 0),
> >       BPF_MOV64_REG(BPF_REG_ARG2, BPF_REG_FP),
> >       BPF_ALU64_IMM(BPF_ADD, BPF_REG_ARG2, -16),
> >       BPF_ST_MEM(BPF_DW, BPF_REG_FP, -16, 0),
> >       BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
> >       BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
> >       BPF_EXIT_INSN(),
> >       BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
> >
> > reads one byte 0 on BE and 28 on LE (from ->index) since
> >
> >       struct test_val {
> >               unsigned int index;
> >               int foo[MAX_ENTRIES];
> >       };
> >
> >         struct test_val value = {
> >               .index = (6 + 1) * sizeof(int),
> >               .foo[6] = 0xabcdef12,
> >       };
> >
> >       BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 3),
> >
> > So different branches are taken depending of the endianness.
> >
> >       BPF_MOV64_IMM(BPF_REG_2, 0),
> >       BPF_MOV64_IMM(BPF_REG_3, 0x100000),
> >       BPF_JMP_A(2),
> >       BPF_MOV64_IMM(BPF_REG_2, 42),
> >       BPF_MOV64_IMM(BPF_REG_3, 0x100001),
> >       BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_3),
> >       BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
> >       BPF_EXIT_INSN(),
> >       },
> >       .fixup_map_array_48b = { 1 },
> >       .result = ACCEPT,
> >       .retval = 0x100000,
> > },
>
> Let me get my hands on a s390x box later today and get back to you.

Any progress with that?

-- 
WBR, Yauheni
