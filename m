Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BDDC04AA8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 11:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2342F2089E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 11:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ocallahan-org.20150623.gappssmtp.com header.i=@ocallahan-org.20150623.gappssmtp.com header.b="0H9qZOLd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfEBLft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 07:35:49 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33776 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfEBLfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 07:35:48 -0400
Received: by mail-lf1-f66.google.com with SMTP id j11so1640007lfm.0;
        Thu, 02 May 2019 04:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ocallahan-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=j++TiTibQtSVl9YAF3/oqacqYf/6ZNJGN6BZGgzoCww=;
        b=0H9qZOLdO21+HdB9rbdwA4TdkIwgdYm+/OeqS3IwlILWryk4o/i6fMK92cnzjlf5d+
         0OAwzQOkeD28c7YH6eco8BUodMbodQLIvMA9K/+hCj9FFBanIhHsDTxWIaOFko8EKel3
         zSFRM58Enni/0sfu1lojb+Rh0349rNJQwgnCVUMe353c38F3CMEFovePsjxDPeRfeIx/
         utSiV3/LMYR2Dqu3XV4xeErBtRaiDgc5Sv6BSJuLmXC6Es8cPhdkIirs2LVr0GMugKnW
         NBPJtLw2jgN5szGLBemMxX5/jwWj73+3M2fiJlRQZpw9YccJDve++TtuuJsE8ML9PRrE
         NoqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=j++TiTibQtSVl9YAF3/oqacqYf/6ZNJGN6BZGgzoCww=;
        b=LzL8/o0JZ8WQ/PaA9eYx8Nz886+Ks3cXE67uAJEtk51k96rwG38RpQ/lvsfFYuFlaA
         TrjzaPVGxRflPQgqNagU+anIfDO1S2JrrxqOyXGxfFCj1d/OZa8lhN8oUNn/3HVxp4x8
         TKKF+ckYezFEDIv0v8jQovfZpjL4Y2OsLmE3LLI/0pQo83i7rP/qX8HKTfKo6QoKRLpy
         1hKg9L5drT6T5WlzMARwmrN2V6/Pp70nSsLRpVVtzNb/EmPTPKOqo0YbtUEa16ejKPft
         53FQMZ5qPHZKT9U57YxD/rqXoFlhgdbskH7caVMt75P48VXWJHY4eRWCJ5bkt9i6s56L
         6PAA==
X-Gm-Message-State: APjAAAWwhPUmxxRP/42BqWUBXaJWJIbUUg3GSTJbkmCPx0V3+ct15LNL
        fVA7Cx/ZQswpkHMWDboT7kiAvinvVt4a/Nj+5Hk=
X-Google-Smtp-Source: APXvYqzxeUby9yFoLptAe0k7AKsIZUdYS+XMP7+LA0QnUSMXo1qvkRNSzH4R87VA/WRCVh9nvlZswwxjI6mg8WhdsxI=
X-Received: by 2002:ac2:5a47:: with SMTP id r7mr1883560lfn.116.1556796946527;
 Thu, 02 May 2019 04:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <1556228754-12996-1-git-send-email-rppt@linux.ibm.com>
 <1556228754-12996-3-git-send-email-rppt@linux.ibm.com> <20190426083144.GA126896@gmail.com>
 <20190426095802.GA35515@gmail.com> <CALCETrV3xZdaMn_MQ5V5nORJbcAeMmpc=gq1=M9cmC_=tKVL3A@mail.gmail.com>
 <20190427084752.GA99668@gmail.com> <20190427104615.GA55518@gmail.com>
In-Reply-To: <20190427104615.GA55518@gmail.com>
Reply-To: robert@ocallahan.org
From:   "Robert O'Callahan" <robert@ocallahan.org>
Date:   Thu, 2 May 2019 23:35:35 +1200
Message-ID: <CAOp6jLa1Rs2xrhJ2wpWoFbJGHyB99OX9doQZc+dNqOSUMgURsw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/7] x86/sci: add core implementation for system call isolation
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 10:46 PM Ingo Molnar <mingo@kernel.org> wrote:
>  - A C language runtime that is a subset of current C syntax and
>    semantics used in the kernel, and which doesn't allow access outside
>    of existing objects and thus creates a strictly enforced separation
>    between memory used for data, and memory used for code and control
>    flow.
>
>  - This would involve, at minimum:
>
>     - tracking every type and object and its inherent length and valid
>       access patterns, and never losing track of its type.
>
>     - being a lot more organized about initialization, i.e. no
>       uninitialized variables/fields.
>
>     - being a lot more strict about type conversions and pointers in
>       general.
>
>     - ... and a metric ton of other details.

Several research groups have tried to do this, and it is very
difficult to do. In particular this was almost exactly the goal of
C-Cured [1]. Much more recently, there's Microsoft's CheckedC [2] [3],
which is less ambitious. Check the references of the latter for lots
of relevant work. If anyone really pursues this they should talk
directly to researchers who've worked on this, e.g. George Necula; you
need to know what *didn't* work well, which is hard to glean from
papers. (Academic publishing is broken that way.)

One problem with adopting "safe C" or Rust in the kernel is that most
of your security mitigations (e.g. KASLR, CFI, other randomizations)
probably need to remain in place as long as there is a significant
amount of C in the kernel, which means the benefits from eliminating
them will be realized very far in the future, if ever, which makes the
whole exercise harder to justify.

Having said that, I think there's a good case to be made for writing
kernel code in Rust, e.g. sketchy drivers. The classes of bugs
prevented in Rust are significantly broader than your usual safe-C
dialect (e.g. data races).

[1] https://web.eecs.umich.edu/~weimerw/p/p477-necula.pdf
[2] https://www.microsoft.com/en-us/research/uploads/prod/2019/05/checkedc-post2019.pdf
[3] https://github.com/Microsoft/checkedc

Rob
-- 
Su ot deraeppa sah dna Rehtaf eht htiw saw hcihw, efil lanrete eht uoy
ot mialcorp ew dna, ti ot yfitset dna ti nees evah ew; deraeppa efil
eht. Efil fo Drow eht gninrecnoc mialcorp ew siht - dehcuot evah sdnah
ruo dna ta dekool evah ew hcihw, seye ruo htiw nees evah ew hcihw,
draeh evah ew hcihw, gninnigeb eht morf saw hcihw taht.
