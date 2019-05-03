Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE79C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 18:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA2C205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 18:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556909865;
	bh=1Zg5g4rcVwi8vbQcV2hs6oOZgJf/wk8FYAua9yhhSyo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2Cobuu9p9W6Yn0a4lb1XFOiKG5Sw2KCpuq/oN8Iq1yu0my2DSMXXr0brOmdW64gCO
	 xMDY7uoQW5n5bZ7ayh9VCI84YgAnIRBeLZ0dejtuIWGwgxWGVEnrc7ip+SbuT0CKLy
	 rEAz6/0YI5bd6gTVDxptFeT5et1wx+n0q3+zDzMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfECS5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 14:57:44 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:32887 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfECS5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 14:57:43 -0400
Received: by mail-lf1-f65.google.com with SMTP id j11so5139876lfm.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 11:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FSgswcQFEYeHSdxX8AtrFGdX43ZrY81aC7FjCdnF1lw=;
        b=hNiCDOYPcNqnXKK/3FcnwPtAVxPFyrBg+J8d2W/RIoQtc6yDsjbQlTRVrCZF7yVBbf
         GTfzaeel2+A/oHQFAzZEgiHULvVGHr0RUbX7HmdD+IU7HwQy2urlZR/fO3433IvfJrgP
         +aivOpr26ud9zTNlsEaBbSi32zQ6a4Z2OLgV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FSgswcQFEYeHSdxX8AtrFGdX43ZrY81aC7FjCdnF1lw=;
        b=MgKR3VNCkU/5ltgZNPvktidGRewY7GUw7diTPwwxI6KL4ry9Ek/lTYhnRz+CseN6hC
         oVi0g8N6LlXMfRU6qwYUArT0KgtbyILQsK6Ts+PDQuGEt1bTYCigjt8ApK+SSibRKF4/
         05fOjcg+/TzLCfpj7HPGrazd+gcXJLf8TK0PIX8BUA3OO3ow2xBbwxJlusv0p8c3EGaF
         mYtZOYTLyJtV0lT0jnr+w9Dd7ksjTo2IcgOBTAToZAoTlvjK2wYAD1OOFESDNmes8PC0
         QNmpr1t2BBsXGYSV9RKs3EP5JbBCz/y5eLqdSwnENdwgGc+90CFZVwG8nDaAC0JHFidG
         1wvw==
X-Gm-Message-State: APjAAAUySqq/MQT/ZQQ3Nwa75eHUN6f0waJea9zkstOTrRvjMb74nAZt
        4TEFDP/a34EBdMpNiVJgu606M2lzM3s=
X-Google-Smtp-Source: APXvYqy2fHSSPyA0G3uaW5lsLAWmIDAx1wBUX9pDGqshnQDdRnBjhfta8oAvG7J11cDA/fXBq4qXgw==
X-Received: by 2002:a19:c746:: with SMTP id x67mr5789857lff.152.1556909860872;
        Fri, 03 May 2019 11:57:40 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id w2sm602941ljh.72.2019.05.03.11.57.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 11:57:39 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id u17so5126251lfi.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 11:57:38 -0700 (PDT)
X-Received: by 2002:a19:ca02:: with SMTP id a2mr5916283lfg.88.1556909858698;
 Fri, 03 May 2019 11:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190501203152.397154664@goodmis.org> <20190501232412.1196ef18@oasis.local.home>
 <20190502162133.GX2623@hirez.programming.kicks-ass.net> <CAHk-=wijZ-MD4g3zMJ9W2r=h8LUWneiu29OWuxZEoSfAF=0bhQ@mail.gmail.com>
 <20190502181811.GY2623@hirez.programming.kicks-ass.net> <CAHk-=wi6A9tgw=kkPh5Ywqt687VvsVEjYXVkAnq0jpt0u0tk6g@mail.gmail.com>
 <20190502202146.GZ2623@hirez.programming.kicks-ass.net> <20190502185225.0cdfc8bc@gandalf.local.home>
 <20190502193129.664c5b2e@gandalf.local.home> <20190502195052.0af473cf@gandalf.local.home>
 <20190503092959.GB2623@hirez.programming.kicks-ass.net> <20190503092247.20cc1ff0@gandalf.local.home>
 <2045370D-38D8-406C-9E94-C1D483E232C9@amacapital.net>
In-Reply-To: <2045370D-38D8-406C-9E94-C1D483E232C9@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 May 2019 11:57:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjrOLqBG1qe9C3T=fLN0m=78FgNOGOEL22gU=+Pw6Mu9Q@mail.gmail.com>
Message-ID: <CAHk-=wjrOLqBG1qe9C3T=fLN0m=78FgNOGOEL22gU=+Pw6Mu9Q@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] x86: Allow breakpoints to emulate call functions
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 3, 2019 at 9:21 AM Andy Lutomirski <luto@amacapital.net> wrote:
>
> So here=E2=80=99s a somewhat nutty suggestion: how about we tweak the 32-=
bit entry code to emulate the sane 64-bit frame, not just for int3 but alwa=
ys?

What would the code actually end up looking like? I don't necessarily
object, since that kernel_stack_pointer() thing certainly looks
horrible, but honestly, my suggestion to just pass in the 'struct
pt_regs' and let the call emulation fix it up would have also worked,
and avoided that bug (and who knows what else might be hiding).

I really think that you're now hitting all the special case magic
low-level crap that I wanted to avoid.

                   Linus
