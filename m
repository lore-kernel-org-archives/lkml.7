Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B7CC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE12920693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="1ZC2F6/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730666AbfG3Mpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 08:45:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42683 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729460AbfG3Mpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 08:45:54 -0400
Received: by mail-wr1-f68.google.com with SMTP id x1so15723505wrr.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 05:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RxcCDptzhf2JngnNPfXMmsFQ4XuPBvrGdXRbVQ3//PI=;
        b=1ZC2F6/8g52VaUbVzsOiZw5xPjKgJwr5zNUTtN96CD6DbvZFDr7cSjfbXzEg0AFP0e
         2UDH9sUy8IsP59Q41Nj+nVNJMdBB6FSaBdDqqg2990jYyc+pukJ505qgxLP5poXbEhyz
         8dqDWigT5wZCzjKummkVCgaZq4LJgAFqUt+Q0FScU51WwqyMBve7jmKsLf1naBis9kDR
         U/mjpXH3a+Tl3x4YEahxohAMetsxcNHk4atFJ21BpbYIe/4I0d4b/CMTc9Qo/Bq8qnpE
         a6YxeE8tPHfoZbywzyxwnCKi58cnnzgK2HGHCwecO33HmYM8gOQLpuBOr4NGpP+onit2
         bgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RxcCDptzhf2JngnNPfXMmsFQ4XuPBvrGdXRbVQ3//PI=;
        b=XDEW6L110sx1G/NUzwiK/oi5m8hA5N3FRe9tzhQ3gHFU1VFtvEG409FR11ZNJwPByh
         3+JEUG1rcNAEbWOrW34SQJmaYSBwUTWUZpQX5t4qxeXikjFMbOPN/bl8kCKokUDTjv3Y
         VXh0Jj8+iULaCinHNW6WTZdjjTkkIGJWjkOTd3DbwUE5CdrTFBqDBKXI69tcsfU6d7fL
         0JfAOzS+r85oXzhNqu9NSRVPp4LM4gay63n3/VepDUOrbN+z7Up0PJQwewFkxFRtYvsy
         UiNTV7cFb7YUuVDgSNkNqX75wAw6TVcF8ZNirESFvnrxNRpaGI8d60qvsT0PW2xxcRZ/
         rT4w==
X-Gm-Message-State: APjAAAUS4+ZmWJFATGKmSOhzi8Dzbhbu3ZjPGBy6FWOOgyjFjZY+5qZM
        11JFxjkp8Ijj7wzKXNinBw4TNjkSDyzLFRLE6yE=
X-Google-Smtp-Source: APXvYqxhFio+jJckSpCHx6uaZasX7OyuUoCma8briJuapuFxFWY/Gd79+y6i+J/AomdEMHJzOE7q0DLhsGyObTJtdwQ=
X-Received: by 2002:a5d:6b11:: with SMTP id v17mr50556066wrw.323.1564490751761;
 Tue, 30 Jul 2019 05:45:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190729115544.17895-1-anup.patel@wdc.com> <20190729115544.17895-6-anup.patel@wdc.com>
 <9f9d09e5-49bc-f8e3-cfe1-bd5221e3b683@redhat.com> <CAAhSdy3JZVEEnPnssALaxvCsyznF=rt=7-d5J_OgQEJv6cPhxQ@mail.gmail.com>
 <66c4e468-7a69-31e7-778b-228908f0e737@redhat.com>
In-Reply-To: <66c4e468-7a69-31e7-778b-228908f0e737@redhat.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 30 Jul 2019 18:15:39 +0530
Message-ID: <CAAhSdy3b-o6y1fsYi1iQcCN=9ZuC98TLCqjHCYAzOCx+N+_89w@mail.gmail.com>
Subject: Re: [RFC PATCH 05/16] RISC-V: KVM: Implement VCPU interrupts and
 requests handling
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Radim K <rkrcmar@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 5:42 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 30/07/19 14:00, Anup Patel wrote:
> > On Tue, Jul 30, 2019 at 4:47 PM Paolo Bonzini <pbonzini@redhat.com> wro=
te:
> >>
> >> First, something that is not clear to me: how do you deal with a guest
> >> writing 1 to VSIP.SSIP?  I think that could lead to lost interrupts if
> >> you have the following sequence
> >>
> >> 1) guest writes 1 to VSIP.SSIP
> >>
> >> 2) guest leaves VS-mode
> >>
> >> 3) host syncs VSIP
> >>
> >> 4) user mode triggers interrupt
> >>
> >> 5) host reenters guest
> >>
> >> 6) host moves irqs_pending to VSIP and clears VSIP.SSIP in the process
> >
> > This reasoning also apply to M-mode firmware (OpenSBI) providing timer
> > and IPI services to HS-mode software. We had some discussion around
> > it in a different context.
> > (Refer, https://github.com/riscv/opensbi/issues/128)
> >
> > The thing is SIP CSR is supposed to be read-only for any S-mode SW. Thi=
s
> > means HS-mode/VS-mode SW modifications to SIP CSR should have no
> > effect.
>
> Is it?  The privileged specification says
>
>   Interprocessor interrupts are sent to other harts by implementation-
>   specific means, which will ultimately cause the SSIP bit to be set in
>   the recipient hart=E2=80=99s sip register.

To further explain my rationale ...

Here's some text from RISC-V spec regarding MIP CSR:
"The mip register is an MXLEN-bit read/write register containing informatio=
n
on pending interrupts, while mie is the corresponding MXLEN-bit read/write
register containing interrupt enable bits. Only the bits corresponding to
lower-privilege software interrupts (USIP, SSIP), timer interrupts (UTIP, S=
TIP),
and external interrupts (UEIP, SEIP) in mip are writable through this CSR
address; the remaining bits are read-only."

Here's some text from RISC-V spec regarding SIP CSR:
"software interrupt-pending (SSIP) bit in the sip register. A pending
supervisor-level software interrupt can be cleared by writing 0 to the SSIP=
 bit
in sip. Supervisor-level software interrupts are disabled when the SSIE bit=
 in
the sie register is clear."

Without RISC-V hypervisor extension, the SIP is essentially a restricted
view of MIP CSR. Also as-per above, S-mode SW can only write 0 to SSIP
bit in SIP CSR whereas it can only be set by M-mode SW or some HW
mechanism (such as S-mode CLINT).

There was quite a bit of discussion in last RISC-V Zurich Workshop about
avoiding SBI calls for injecting IPIs. The best suggestion so far is to
eventually have RISC-V systems with separate CLINT HW for M-mode
and S-mode. The S-mode SW can use S-mode CLINT to trigger IPIs to
other CPUs and it will use SBI calls for IPIs only when S-mode CLINT is
not available.

>
>   All bits besides SSIP in the sip register are read-only.
>
> Meaning that sending an IPI to self by writing 1 to sip.SSIP is
> well-defined.  The same should be true of vsip.SSIP while in VS mode.
>
> > Do you still an issue here?
>
> Do you see any issues in the pseudocode I sent?  It gets away with the
> spinlock and request so it may be a good idea anyway. :)

Yes, I am evaluating your psedocode right now. I definitely want to
remove the irq_pending_lock if possible. I will try to in-corporate your
suggestion in v2 series.

Regards,
Anup
