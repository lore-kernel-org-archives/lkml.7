Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC29C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DAED206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556314002;
	bh=D0t+02sSwcut5ajzNNivlJU0Ro11fXksLOee2pRrCfg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sbQG95S5IDam/GLIanDazobPm4JubXDjCIUt32vuek8aSTZIqN3UCZsQnzVBe0udK
	 856Miq4CNz4du2TGRBaBiBALfDPfZIH1En/eecKfH94bXvg9R4/4FJYxBVF/m8aBF+
	 IZ5syUhMnBDgDZknL9f7tY9/uzBSTpoyBIOEJxa0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfDZV0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 17:26:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbfDZV0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 17:26:41 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99BE0208CA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 21:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556313999;
        bh=D0t+02sSwcut5ajzNNivlJU0Ro11fXksLOee2pRrCfg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KFqBx7lJ2xW/ZYaXv2tmORF55+e/veZZXqQxhZIbRAnePpvb1GCT5XYj1AD/huJEH
         iI1AgObnyI+W19QqZRYgfw/E6RYOX1P5dY0hC8gkxHhdUxRWBGcXxbO5JlStPsGXIr
         OWZIvKE14i9KB8xnl8JGYbKLum/88xqqSVfwjhAE=
Received: by mail-wm1-f42.google.com with SMTP id o25so5420527wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 14:26:39 -0700 (PDT)
X-Gm-Message-State: APjAAAUbCYI6NXtEemxfo0XG4tYoe/n6EPoCERIwGeUEuyKixKJiCyKn
        ZBDwwglh2F8CKkfclYfI+x4FwHSLFRWyLth23j0epA==
X-Google-Smtp-Source: APXvYqx5vVtLlO1GHUeQ6vSPjFFZIHSGfe1r7pnfuGjJ54r5DCtxtD71D80YSEb7dID4Wuyom+otxiT+VXyT6tcj2mM=
X-Received: by 2002:a05:600c:211a:: with SMTP id u26mr9839645wml.74.1556313998090;
 Fri, 26 Apr 2019 14:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <1556228754-12996-1-git-send-email-rppt@linux.ibm.com>
 <1556228754-12996-3-git-send-email-rppt@linux.ibm.com> <20190426083144.GA126896@gmail.com>
 <20190426095802.GA35515@gmail.com>
In-Reply-To: <20190426095802.GA35515@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 26 Apr 2019 14:26:26 -0700
X-Gmail-Original-Message-ID: <CALCETrV3xZdaMn_MQ5V5nORJbcAeMmpc=gq1=M9cmC_=tKVL3A@mail.gmail.com>
Message-ID: <CALCETrV3xZdaMn_MQ5V5nORJbcAeMmpc=gq1=M9cmC_=tKVL3A@mail.gmail.com>
Subject: Re: [RFC PATCH 2/7] x86/sci: add core implementation for system call isolation
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jonathan Adams <jwadams@google.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-MM <linux-mm@kvack.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Apr 26, 2019, at 2:58 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ingo Molnar <mingo@kernel.org> wrote:
>
>> I really don't like it where this is going. In a couple of years I
>> really want to be able to think of PTI as a bad dream that is mostly
>> over fortunately.
>>
>> I have the feeling that compiler level protection that avoids
>> corrupting the stack in the first place is going to be lower overhead,
>> and would work in a much broader range of environments. Do we have
>> analysis of what the compiler would have to do to prevent most ROP
>> attacks, and what the runtime cost of that is?
>>
>> I mean, C# and Java programs aren't able to corrupt the stack as long
>> as the language runtime is corect. Has to be possible, right?
>
> So if such security feature is offered then I'm afraid distros would be
> strongly inclined to enable it - saying 'yes' to a kernel feature that
> can keep your product off CVE advisories is a strong force.
>
> To phrase the argument in a bit more controversial form:
>
>   If the price of Linux using an insecure C runtime is to slow down
>   system calls with immense PTI-alike runtime costs, then wouldn't it be
>   the right technical decision to write the kernel in a language runtime
>   that doesn't allow stack overflows and such?
>
> I.e. if having Linux in C ends up being slower than having it in Java,
> then what's the performance argument in favor of using C to begin with?
> ;-)
>
> And no, I'm not arguing for Java or C#, but I am arguing for a saner
> version of C.
>
>

IMO three are three credible choices:

1. C with fairly strong CFI protection. Grsecurity has his (supposedly
=E2=80=94 there=E2=80=99s a distinct lack of source code available), and cl=
ang is
gradually working on it.

2. A safe language for parts of the kernel, e.g. drivers and maybe
eventually filesystems.  Rust is probably the only credible candidate.
Actually creating a decent Rust wrapper around the core kernel
facilities would be quite a bit of work.  Things like sysfs would be
interesting in Rust, since AFAIK few or even no drivers actually get
the locking fully correct.  This means that naive users of the API
cannot port directly to safe Rust, because all the races won't compile
:)

3. A sandbox for parts of the kernel, e.g. drivers.  The obvious
candidates are eBPF and WASM.

#2 will give very good performance.  #3 gives potentially stronger
protection against a sandboxed component corrupting the kernel
overall, but it gives much weaker protection against a sandboxed
component corrupting itself.

In an ideal world, we could do #2 *and* #3.  Drivers could, for
example, be written in a language like Rust, compiled to WASM, and run
in the kernel.
