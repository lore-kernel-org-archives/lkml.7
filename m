Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37658C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2F52070B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k0ZQSWb3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbfKTOYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:24:46 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34599 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbfKTOYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:24:46 -0500
Received: by mail-ot1-f67.google.com with SMTP id w11so1365923ote.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 06:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yOFfvevSyIuI2uXnhKhqs1DyN3AcbeT8ZG1uPgE2BRM=;
        b=k0ZQSWb3hHNPjkhWrDg2UG82nir6GbQ/mlgsdzhvvgoMpyhvl+WwEu8779bjiQnu8g
         8d5a4OB9oudrxxWTA3M+PIQA00bJVw9pxOwDdRafaWH8irq0hvJwWLtTy90novOcWX6v
         CG9/af+Aq5GNBsYEEFoaDEKOLIR5rG1HUXON1DMCuszitFxtWbIWH1IruF11xMCusAm/
         MkvvNaQVNSiPZLyCItyHwGJN4fLJTo4NZxDPSdSBRGFV26B9h/LxHq8BmbKlc+ObLAfH
         7/srbRhE9fSN4novjtVNT5vl07GAt0+CJE1hiUN05VDBx+Nl1cTrDF41FIEdcvMfgtj/
         ehxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yOFfvevSyIuI2uXnhKhqs1DyN3AcbeT8ZG1uPgE2BRM=;
        b=NKh63KiIL+TJmJbmFIIsoY/mEIVZoJvslULuyO/WR+02Wyhv7GtL2KaYFa9pC2lAIW
         Z0YzPbNWvE6AE+cl96mRAFV/w8KZsoe9x8fztnDsKGmK9STUJwB5xSkWAQBhFVwl06Sc
         /C6UDYRNmeUU27qCDkl87bD9eivn1JkOGzG5kTpyPsqZ9TSW0LU8Qpdr3m+rvEdA9Jj0
         B6F5EZlbMxqmn/ULr4fPSPsFzK6w6uv0HRKZ3W8fouv2yzwwlb4dahWJ89NIJ9/Kjc0h
         c0W6fNYnA68lH4Lam9YjoZ+SwKTXWyVet7shitZkBqqO52pLQN8aWcDhZTtYf9KBZo46
         hGzA==
X-Gm-Message-State: APjAAAVzMarg6tc9lVxtoWh/uLPy/q4vsR8rd2EMfA3MElyJghDMBhch
        kUNQro6fldDT5sttijQy77y9v03M7v0tdE/OvIEaUw==
X-Google-Smtp-Source: APXvYqxnA8G81rljm9PRI4kMBgFx5xHF8npsvEDLPsgJihuMyGPwNDoGsLgkc8I5MZdAQ/Tvtt1EXptQF2KV3j41oYA=
X-Received: by 2002:a9d:328:: with SMTP id 37mr2126736otv.228.1574259884942;
 Wed, 20 Nov 2019 06:24:44 -0800 (PST)
MIME-Version: 1.0
References: <20191115191728.87338-1-jannh@google.com> <20191115191728.87338-2-jannh@google.com>
 <87lfsbfa2q.fsf@linux.intel.com> <CAG48ez2QFz9zEQ65VTc0uGB=s3uwkegR=nrH6+yoW-j4ymtq7Q@mail.gmail.com>
 <20191120135607.GA84886@tassilo.jf.intel.com>
In-Reply-To: <20191120135607.GA84886@tassilo.jf.intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 20 Nov 2019 15:24:17 +0100
Message-ID: <CAG48ez11aL5OsDCTF=E6h=_DF6ojmunwp1BcWL73EsQLrmsttQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] x86/traps: Print non-canonical address on #GP
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 2:56 PM Andi Kleen <ak@linux.intel.com> wrote:
> > Is there a specific concern you have about the instruction decoder? As
> > far as I can tell, all the paths of insn_get_addr_ref() only work if
> > the instruction has a mod R/M byte according to the instruction
> > tables, and then figures out the address based on that. While that
> > means that there's a wide variety of cases in which we won't be able
> > to figure out the address, I'm not aware of anything specific that is
> > likely to lead to false positives.
>
> First there will be a lot of cases you'll just print 0, even
> though 0 is canonical if there is no operand.

Why would I print zeroes if there is no operand? The decoder logic
returns a -1 if it can't find a mod r/m byte, which causes the #GP
handler to not print any address at all. Or are you talking about some
weird instruction that takes an operand that is actually ignored, or
something weird like that?

> Then it might be that the address is canonical, but triggers
> #GP anyways (e.g. unaligned SSE)

Which is an argument for printing the address even if it is canonical,
as Ingo suggested, I guess.

> Or it might be the wrong address if there is an operand,
> there are many complex instructions that reference something
> in memory, and usually do canonical checking there.

In which case you'd probably usually see a canonical address in the
instruction's argument, which causes the error message to not appear
(in patch v2/v3) / to be different (in my current draft for patch v4).
And as Ingo said over in the other thread, even if the argument is not
directly the faulting address at all, it might still help with
figuring out what's going on.

> And some other odd cases. For example when the instruction length
> exceeds 15 bytes.

But this is the #GP handler. Don't overlong instructions give you #UD instead?

> I know there is fuzzing for the instruction
> decoder, but it might be worth double checking it handles
> all of that correctly. I'm not sure how good the fuzzer's coverage
> is.
>
> At a minimum you should probably check if the address is
> actually non canonical. Maybe that's simple enough and weeds out
> most cases.

The patch you're commenting on does that already; quoting the patch:

+       /* Bail out if insn_get_addr_ref() failed or we got a kernel address. */
+       if (addr_ref >= ~__VIRTUAL_MASK)
+               return;
+
+       /* Bail out if the entire operand is in the canonical user half. */
+       if (addr_ref + insn.opnd_bytes - 1 <= __VIRTUAL_MASK)
+               return;

But at Ingo's request, I'm planning to change that in the v4 patch;
see <https://lore.kernel.org/lkml/20191120111859.GA115930@gmail.com/>
and <https://lore.kernel.org/lkml/CAG48ez0Frp4-+xHZ=UhbHh0hC_h-1VtJfwHw=kDo6NahyMv1ig@mail.gmail.com/>.
