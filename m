Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262B6C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 20:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E992720578
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 20:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556830540;
	bh=45Rdfhr1bntZwkSCUyzJ4d2d7mBe7xp+jSE4IRmie1s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uWVln/POIFyZKehVoaxOgkHeTMea18qtfy8JUY5+AqFoptqo5EG+kXdGf5VrJmmeo
	 qBhvgaFGAkPLT28vxS5trtB2yE/OW+zaOjqmXD0uB3d5hP2ckbAznJCGQiwQ9K+6Pf
	 fRY4pms3j38/V4Imo/NOFDlxo+YeTMeLTdM21OQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfEBUzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 16:55:38 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41262 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfEBUzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 16:55:38 -0400
Received: by mail-lf1-f67.google.com with SMTP id d8so2907294lfb.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 13:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9eWa5vFKZPEJ8DW2XaC7JXAPKdGCG2IN2Y9wVvZv45s=;
        b=Cx3zQ0UKjjMz51LsOvr1ic+6VE8tQ4HPzkevgcUly/S86/MNpxZqSG4o20EQv0So+W
         xHmowGihlJAYSjpRF77/Gi8EjbFtkwBPUA5dnvni2jvpBKK7LKBaOoNVRF0Hc3/Mrf0r
         AikJgVeOLVaZ2oVA0t3qkDKimhPFDbi9a26ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9eWa5vFKZPEJ8DW2XaC7JXAPKdGCG2IN2Y9wVvZv45s=;
        b=UhR/uRO3E88lH39I9M/fu0cXnDDOykNyLUQNpvM+NhRXS72CPua8QLFh5GlavrcTd7
         p+KDDNzZvo1h0AipRF5UiTdBZew8C+VD2CFq6tfGV6bRbbIqZfY03TeYyfjrhhxjviGJ
         1qG/0vhUvQ1WMTvvjHX2I+RsqnNvpLbECNTcQvd/hlm/kFbPAOEcVozBlOI/lZDty3x4
         aWuMLFVL8pWPmfhG5cNILfMKwDfvfF9jPiqDbuTsGvqZ4O7LO8zdxnO1tJXwZ7fVgJ5q
         594THYpigmrqDelM/OvXCt2bcn1vq439bMA2exvTif7WifLnV5GsAgmHndsHqu92KLWt
         BBOg==
X-Gm-Message-State: APjAAAWGfdnhHQIHPug/gsasmqKt4uHZ+p2N7pNQ+BXdNEhdl06XspSO
        U/FbsW0Q4+ECRfZHwUo7tbRFQow46KM=
X-Google-Smtp-Source: APXvYqy9AbTPk0e/LJq8Q+PBptznS1ckVtfPLZfqORfl44KT8CyzkmhqUCllKhTCN7tl+LEqRFaJcQ==
X-Received: by 2002:a19:c216:: with SMTP id l22mr3001231lfc.112.1556830536162;
        Thu, 02 May 2019 13:55:36 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id s6sm13014ljh.65.2019.05.02.13.55.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 13:55:35 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id v18so725433lfi.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 13:55:35 -0700 (PDT)
X-Received: by 2002:ac2:598b:: with SMTP id w11mr3275555lfn.62.1556830185843;
 Thu, 02 May 2019 13:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190501202830.347656894@goodmis.org> <20190501203152.397154664@goodmis.org>
 <20190501232412.1196ef18@oasis.local.home> <20190502162133.GX2623@hirez.programming.kicks-ass.net>
 <CAHk-=wijZ-MD4g3zMJ9W2r=h8LUWneiu29OWuxZEoSfAF=0bhQ@mail.gmail.com>
 <20190502181811.GY2623@hirez.programming.kicks-ass.net> <CAHk-=wi6A9tgw=kkPh5Ywqt687VvsVEjYXVkAnq0jpt0u0tk6g@mail.gmail.com>
 <20190502202146.GZ2623@hirez.programming.kicks-ass.net>
In-Reply-To: <20190502202146.GZ2623@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 May 2019 13:49:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh8bi5c_GkyjPtDAiaXaZRqtmhWs30usUvs4qK_F+c9tg@mail.gmail.com>
Message-ID: <CAHk-=wh8bi5c_GkyjPtDAiaXaZRqtmhWs30usUvs4qK_F+c9tg@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] x86: Allow breakpoints to emulate call functions
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joerg Roedel <jroedel@suse.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 2, 2019 at 1:22 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Something like so; it boots; but I could've made some horrible mistake
> (again).

This actually looks much better to me.

Maybe it's more lines (I didn't check), but it's a lot simpler in that
now the magic of the int3 stack doesn't get exposed to anything else.

We *could* also make this kernel-mode-only do_int3() be a special
function, and do something like

        # args: pt_regs pointer (no error code for int3)
        movl %esp,%eax
        # allocate a bit of extra room on the stack, so that
'kernel_int3' can move the pt_regs
        subl $8,%esp
        call kernel_int3
        movl %eax,%esp

and not do any stack switching magic in the asm code AT ALL. We'd do

    struct pt_regs *kernel_int3(struct pt_regs *regs)
    {
        ..
        return regs;
    }

and now you the rule for call emulation ends up being that you need to
"memmove()" the ptregs up and down properly, and return the new
pt_regs pointer.

Hmm? That would simplify the asm code further, but some people might
find it objectionable?

                  Linus
