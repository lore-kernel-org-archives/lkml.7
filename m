Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68189C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A042A20870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lonelycoder.com header.i=@lonelycoder.com header.b="JbiJASYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730480AbfIEUAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 16:00:33 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40786 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfIEUAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 16:00:32 -0400
Received: by mail-ot1-f66.google.com with SMTP id y39so3482101ota.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 13:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lonelycoder.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kYbfxjyep6baFu31BTNCvbKxo9XSMomaphW0a6NF1fA=;
        b=JbiJASYb3UBO8o5tlD5TlGdhbHX+n5lCJgTSiUK4YBmH461KYIP/YaUP0HrXEIbWT5
         iDZ13WDbIL2kHzpv1TO3nnuccYT8mbJKcU7dw/uJTedARmYZYiVuoPvsnotURr3zmvBx
         IY4QUkYIWGmLSXfA6MqWbRKHPjrv2SPeA5tBxGMiuuZ1hPoKHL5/1emMjCc2ClsFUTHN
         dkfB9dcrU7TiTsQYQ4O1t75Lp7cg0d/kYrMt8H3w7RnP4T4N8aEAIMw174BVnN+wkRu+
         GIUCA4VvXGQ5s9NYwiTwvJeSkOF6+MN124ERC68qibk50pQt2v+8rVNrNreKg6iq6dMm
         OZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kYbfxjyep6baFu31BTNCvbKxo9XSMomaphW0a6NF1fA=;
        b=pS64AH04sd/m4LAYeJqQ0bG/opwPFZ0vFLUCH3Qljf9kFuxnGf0OwRTqs7fRsz0+2C
         QqvEk7cCIBkrvkF6vZGDA+pX5+oVDse1L+UMoy2U1i1quM7POaCyUt2LZhrM++qbsX4u
         fqiP7lblX926YryOcH8FAS8S1NPO8bY3BqKFd/CISbW9owWnPUs8P67wKZjYz2eM4ubE
         O6jVRZ+zegKzhalOy5wn45b6I9vvD3mYmTqRGUGxC45ZI7HTxBcwNAs5OUmbQ1Pwry4f
         eK5O/HyRg2+QxktcZPzKR2Ykp7F2FnV1P6/g1Nv9q98zIKykFPFes3kaAXbg6b8gIoop
         QtRg==
X-Gm-Message-State: APjAAAWtQRv9YQJO7eEf1wPbuD4/DigTkowfeEDa+QZCvE5ii3XzmWMW
        cbf7n2+qrNb/0RayMCzr0+VPvKlIT0PnQMEKUPztGg==
X-Google-Smtp-Source: APXvYqwMSGL1dyw+dICgAaGva7Qmuz5wumaM8x3YtaA5uG52urC1NJlseB3zMpe+xw4XLbcBonJioM7EsYTFsY7v3qY=
X-Received: by 2002:a9d:21a6:: with SMTP id s35mr4468457otb.77.1567713631363;
 Thu, 05 Sep 2019 13:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190904214505.GA15093@swahl-linux> <CAKwvOdnX3qVq1wGovViyGJSnySKzCATU4SU_ASsL-9XfDZ8+Eg@mail.gmail.com>
 <CAObFT-RqSa+8re=jLfM-=yyFH38dz89jRjrwGjnhHhGszKxXmQ@mail.gmail.com> <CAKwvOdk00-v=yT3C3NfN=-FJWLF+9sAYXm_LeFXo+DBZ-vKSxw@mail.gmail.com>
In-Reply-To: <CAKwvOdk00-v=yT3C3NfN=-FJWLF+9sAYXm_LeFXo+DBZ-vKSxw@mail.gmail.com>
From:   Andreas Smas <andreas@lonelycoder.com>
Date:   Thu, 5 Sep 2019 13:00:20 -0700
Message-ID: <CAObFT-Tj=Ye9NbKQjvBP1YtjOKSTMi77i2rc9LFTaLxDwvbLWw@mail.gmail.com>
Subject: Re: [PATCH 1/1] x86/purgatory: Change compiler flags to avoid
 relocation errors.
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Vaibhav Rustagi <vaibhavrustagi@google.com>,
        russ.anderson@hpe.com, dimitri.sivanich@hpe.com,
        mike.travis@hpe.com, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 5, 2019 at 11:20 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Sep 4, 2019 at 10:34 PM Andreas Smas <andreas@lonelycoder.com> wrote:
> >
> > On Wed, Sep 4, 2019 at 3:19 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > Thanks for confirming the fix.  While it sounds like -mcmodel=large is
> > > the only necessary change, I don't object to -ffreestanding of
> > > -fno-zero-initialized-in-bss being readded, especially since I think
> > > what you've done with PURGATORY_CFLAGS_REMOVE is more concise.
> >
> > Without -ffreestanding this results in undefined symbols (as before this patch)
>
> Thanks for the report and sorry for the breakage.  Can you test
> Steve's patch and send your tested by tag?  Steve will likely respin
> the final patch today with Boris' feedback, so now is the time to get
> on the train.
>
> >
> > $ readelf -a arch/x86/purgatory/purgatory.ro|grep UND
> >      0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
>
> ^ what's that? A <strikethrough>horse</strikethrough> symbol with no name?

No idea TBH. Not enough of an ELF-expert to explain that. It's also there with
the -ffreestanding -patch (when kexec() works for me again)
so it doesn't seem to cause any harm.

>
> >     51: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __stack_chk_fail
>
> ^ so I would have expected the stackprotector changes in my and Steve
> commits to prevent compiler emission of that runtime-implemented
> symbol.  ie. that `-ffreestanding` affects that and not removing the
> stackprotector flags begs another question.  Without `-ffreestanding`
> and `-fstack-protector` (or `-fstack-protector-strong`), why would the
> compiler emit references to __stack_chk_fail?  Which .o file that
> composes the .ro file did we fail to remove the `-fstack-protector*`
> flag from?  `-ffreestanding` seems to be covering that up.

So, I'm using

$ gcc --version
gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0

I think the problem is that stock ubuntu gcc defaults to -fstack-protector.
I haven't figured out where to check how/where ubuntu configures gcc except
an ancient discussion here: https://wiki.ubuntu.com/GccSsp.

Both -fno-stack-protector or -ffreestanding fixes the issue. I'm not sure
which would be preferred? -ffreestanding sounds a bit better to me though,
as that's really what we are dealing with here.

So,

Tested-by: Andreas Smas <andreas@lonelycoder.com>


FWIW, one of the offending functions is sha256_transform() where the u32 W[64];
triggers insert of a stack guard variable. (since -fstack-protector is
default on)


End of sha256_transform()

        /* clear any sensitive info... */
        a = b = c = d = e = f = g = h = t1 = t2 = 0;
        memset(W, 0, 64 * sizeof(u32));
}
    1aab:       48 8b 84 24 00 01 00    mov    0x100(%rsp),%rax
    1ab2:       00
    1ab3:       65 48 33 04 25 28 00    xor    %gs:0x28,%rax
    1aba:       00 00
        state[0] += a; state[1] += b; state[2] += c; state[3] += d;
    1abc:       44 89 37                mov    %r14d,(%rdi)
    1abf:       44 89 47 0c             mov    %r8d,0xc(%rdi)
        state[4] += e; state[5] += f; state[6] += g; state[7] += h;
    1ac3:       44 89 6f 10             mov    %r13d,0x10(%rdi)
    1ac7:       89 4f 14                mov    %ecx,0x14(%rdi)
    1aca:       89 5f 18                mov    %ebx,0x18(%rdi)
}
    1acd:       75 12                   jne    1ae1 <sha256_transform+0x1ae1>
    1acf:       48 81 c4 08 01 00 00    add    $0x108,%rsp
    1ad6:       5b                      pop    %rbx
    1ad7:       5d                      pop    %rbp
    1ad8:       41 5c                   pop    %r12
    1ada:       41 5d                   pop    %r13
    1adc:       41 5e                   pop    %r14
    1ade:       41 5f                   pop    %r15
    1ae0:       c3                      retq
    1ae1:       e8 00 00 00 00          callq  1ae6 <sha256_transform+0x1ae6>


.rela.text:

1ae2  001100000002 R_X86_64_PC32     __stack_chk_fail - 4


Same thing with this latest patch (ie, -ffreestanding)

        /* clear any sensitive info... */
        a = b = c = d = e = f = g = h = t1 = t2 = 0;
        memset(W, 0, 64 * sizeof(u32));
    1aa2:       ba 00 01 00 00          mov    $0x100,%edx
        state[4] += e; state[5] += f; state[6] += g; state[7] += h;
    1aa7:       89 47 1c                mov    %eax,0x1c(%rdi)
        state[0] += a; state[1] += b; state[2] += c; state[3] += d;
    1aaa:       44 89 47 0c             mov    %r8d,0xc(%rdi)
        memset(W, 0, 64 * sizeof(u32));
    1aae:       31 f6                   xor    %esi,%esi
        state[4] += e; state[5] += f; state[6] += g; state[7] += h;
    1ab0:       89 4f 14                mov    %ecx,0x14(%rdi)
        memset(W, 0, 64 * sizeof(u32));
    1ab3:       48 b8 00 00 00 00 00    movabs $0x0,%rax    <- &memset()
    1aba:       00 00 00
    1abd:       48 89 e7                mov    %rsp,%rdi
    1ac0:       ff d0                   callq  *%rax
}
    1ac2:       48 81 c4 00 01 00 00    add    $0x100,%rsp
    1ac9:       5b                      pop    %rbx
    1aca:       5d                      pop    %rbp
    1acb:       41 5c                   pop    %r12
    1acd:       41 5d                   pop    %r13
    1acf:       41 5e                   pop    %r14
    1ad1:       41 5f                   pop    %r15
    1ad3:       c3                      retq


1ab5  001100000001 R_X86_64_64           memset + 0

It's interesting / odd (?) that the memset() is eliminated when
stack-guard is enabled.
I've no idea why this happens. But I suppose that's a separate thing.
