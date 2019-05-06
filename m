Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3158BC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 20:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01975206BF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 20:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557175900;
	bh=hSoA7j3jL+em1awyzkuiGU7y2XPFhn958JVf5N++p9w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eXCPtPrgOUHRvcCrtGcQn7rBcDFRxhFoUX+OlKIC0fiIclECPdmTCXnkWCRY8pzYU
	 eE1NsHNWKW4Xgmc77QRvRThjgokOJ8bnNg6CHc+Rs9PpD56u8o0RAoQiDr+BRX7Yv5
	 n/8oQTEkx0LE0QHh8OleOkvGsypzBBpcHTU7AP0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfEFUvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 16:51:39 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37553 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfEFUvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 16:51:38 -0400
Received: by mail-lj1-f194.google.com with SMTP id 132so4597932ljj.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 13:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7tr1nwcY+Mo7JIjJHKVLKIn3srZa+DVPkvnBKBRzf9s=;
        b=Wx0wBv+MylrKm2tMM2EjzWS61fm9xNahf5H0jqXMieHoP7JIkuDeMOtkWoWb3N/RXa
         zTBuN8pbi5tRyMSpWlaexirS081WZT8udlBXEwXx+fqFNsgl6F0LP8y/LHZSEjMdt26D
         KO9SQD+Phs5cXpErrLaOl8w3aKdvsA9v+duGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7tr1nwcY+Mo7JIjJHKVLKIn3srZa+DVPkvnBKBRzf9s=;
        b=ozjpt7KHIInWH5BY8MSpd0mtTHi8jk4C28PLYQ2iD4TQf22ZxcJOhYNx2QsQDUaA5C
         xcRkROr6SDELH0ciDEFpHsPI2aaHxT1tUMtpcJ5a4hU0NSJ7UpVplgyiA/Vj1RuXDbkL
         D9HO8i8IODlRuNNVS6aZi/iHBfhTpD27fylAflt5Jpcz1L8M25WdNY0W+ifcPRBrvKbd
         afLD81iSqCftjxOgJa8IKiVrZSZQj5pSrE+xEG0EMJGDKGFyVwlCLVDeDA6WCkNoi8Ms
         YYLYwjfAV6aBxV/YDPWikhpnicPbBsa5CgxQ5XZk0hBDuJhyDMSoYzGpxEK1odBUyQmY
         Rp9Q==
X-Gm-Message-State: APjAAAXj+cZg1pQzgubcPl/WRh2T1muChaBLG9SOaiSmTEmZbPwV17pu
        ukqTUAfHv1DG7oRx59Qjo96vzl33TIo=
X-Google-Smtp-Source: APXvYqySjS9cQwHSaDD+JoqoCbPSuBMj0LW5o2A9jHKpo0HM1o8GabhLM6uDtB5piRidB5+8ylo4fA==
X-Received: by 2002:a2e:8602:: with SMTP id a2mr7832363lji.21.1557175896244;
        Mon, 06 May 2019 13:51:36 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id o68sm120151lfe.86.2019.05.06.13.51.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 13:51:36 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id h21so12282424ljk.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 13:51:35 -0700 (PDT)
X-Received: by 2002:a2e:801a:: with SMTP id j26mr5517472ljg.2.1557175508545;
 Mon, 06 May 2019 13:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190502181811.GY2623@hirez.programming.kicks-ass.net>
 <CAHk-=wi6A9tgw=kkPh5Ywqt687VvsVEjYXVkAnq0jpt0u0tk6g@mail.gmail.com>
 <20190502202146.GZ2623@hirez.programming.kicks-ass.net> <20190502185225.0cdfc8bc@gandalf.local.home>
 <20190502193129.664c5b2e@gandalf.local.home> <20190502195052.0af473cf@gandalf.local.home>
 <20190503092959.GB2623@hirez.programming.kicks-ass.net> <20190503092247.20cc1ff0@gandalf.local.home>
 <2045370D-38D8-406C-9E94-C1D483E232C9@amacapital.net> <CAHk-=wjrOLqBG1qe9C3T=fLN0m=78FgNOGOEL22gU=+Pw6Mu9Q@mail.gmail.com>
 <20190506081951.GJ2606@hirez.programming.kicks-ass.net> <20190506095631.6f71ad7c@gandalf.local.home>
 <CAHk-=wgw_Jmn1iJWanoSFb1QZn3mbTD_JEoMsWcWj5QPeyHZHA@mail.gmail.com>
 <20190506130643.62c35eeb@gandalf.local.home> <CAHk-=whesas+GDtHZks62wqXWXe4d_g3XJ359GX81qj=Fgs6qQ@mail.gmail.com>
 <20190506145745.17c59596@gandalf.local.home> <CAHk-=witfFBW2O5v6g--FmqnAFsMkKNLosTFfWyaoJ7euQF8kQ@mail.gmail.com>
 <20190506162915.380993f9@gandalf.local.home> <CAHk-=wi5KBWUOvM94aTOPnoJ5L_aQG=vgLQ4SxxZDeQD0pF2tQ@mail.gmail.com>
In-Reply-To: <CAHk-=wi5KBWUOvM94aTOPnoJ5L_aQG=vgLQ4SxxZDeQD0pF2tQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 May 2019 13:44:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgsi+FQN6bnued8K4KQ2fF53k0JW4TUY+q0XOJyiULXmw@mail.gmail.com>
Message-ID: <CAHk-=wgsi+FQN6bnued8K4KQ2fF53k0JW4TUY+q0XOJyiULXmw@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] x86: Allow breakpoints to emulate call functions
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
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

On Mon, May 6, 2019 at 1:42 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> What *can* make sense is "Oh, I'm emulating a call, but I know that
> call will be rewritten, so let me emulate the call and then
> short-circuit the emulation immediately".

That made no sense. The end should have been "and then short-circuit
the _rewriting_ immediately" of course.

The "emulate a call" is just to make the "struct pt_regs" state look
like it would have after the call. The "short circuit the rewriting"
part is the thing that then rewrites the actual instruction based on
that pt_regs state.

                 Linus
