Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40205C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 14:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FAC720B7C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 14:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557241065;
	bh=7/5kbEC0Wk2MWN/w0C8L2Jq9B4gw2Wm8s6J85a0NRqg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=c+F5EyKXpF8QmB4z2XBmFnHETH7S4Z0q2AHTTSixwficY4PCW1WIlyOyp3QGa/PeT
	 Q+na/QnUkvxcl+ZYoMdNhjIUELOY7e0xVNZ3qlCn+jNgm5UZVnWPlTya6bkfk9T9sA
	 1RpAlm4ZA0tVY2fipfYazp5w5dC0jdaM9ZGcxiR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfEGO5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 10:57:43 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42867 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfEGO5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 10:57:43 -0400
Received: by mail-lj1-f196.google.com with SMTP id y10so8113529lji.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 07:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rbrh0+eAfH6c7Xl2PV8FyhyJfKNvVcOio3KOqwrWtto=;
        b=Rbs4zhZWSZAoIEvFW8ZqicaczCDoK8wfJtXVM/czDDUkauJt0TcGt6pZghqByNBQb0
         ehSlEkONi7tskD0aHaudB30RNMZSHHZykUVA+izGKdIq/z2+gRVDVhHjGCa4I43HAqLa
         yuB6PrQdRmt/3nK2dXUGpm0su0mwkDdFFseIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rbrh0+eAfH6c7Xl2PV8FyhyJfKNvVcOio3KOqwrWtto=;
        b=Jqs5g2k0SS60bd0JKjhc11IqAtxEV41qQVAtCrsTAY3NGpq6sejt5VwrSXEgUF8oXy
         wrEZlwf0MHjU3wrRMSd18JmyOxh2QjJolFB7oyOnurDZ4uVoV+QwTjj0ROSbIOYdFHDP
         I7xRqSfZYCJZw8YSJk/l2eXj4Oe3AFNFnnjdF0uZiDcJxMH+zNFpU7+jHSIc++/pDki5
         VL2XwL4caYqI0IWM5cPvzID6PSTMUR0VX62H9SvstIxqPL/8/Bzlpt8A/tGtaobzU7eo
         byYpUMDmLbGD/nXn2t+nIhMsKU/lAEu358RloRXNbSFQQKjiBljPeFYjRIzVe/zeyZbf
         HBAw==
X-Gm-Message-State: APjAAAVNyYHBt7gG9uZXdGJysUg8Y2NBHxWdb2qMExXtbOGgfq+yLHzY
        DWsnzKTVFWPmmdf6HbcjEdiQGOnYL8s=
X-Google-Smtp-Source: APXvYqyvMmPpRVlNUYFsh+Ao+JwcqPwAJpT9u+eJVE1UZQ4HO4As9BrX1uDXCTjmuwJKB0L2vnoDvw==
X-Received: by 2002:a2e:5dcb:: with SMTP id v72mr2170175lje.54.1557241060933;
        Tue, 07 May 2019 07:57:40 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id o28sm3384679lfi.64.2019.05.07.07.57.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 07:57:40 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id z1so2420537ljb.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 07:57:39 -0700 (PDT)
X-Received: by 2002:a2e:9ac8:: with SMTP id p8mr16118039ljj.79.1557241059252;
 Tue, 07 May 2019 07:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190502181811.GY2623@hirez.programming.kicks-ass.net>
 <20190503092247.20cc1ff0@gandalf.local.home> <2045370D-38D8-406C-9E94-C1D483E232C9@amacapital.net>
 <CAHk-=wjrOLqBG1qe9C3T=fLN0m=78FgNOGOEL22gU=+Pw6Mu9Q@mail.gmail.com>
 <20190506081951.GJ2606@hirez.programming.kicks-ass.net> <20190506095631.6f71ad7c@gandalf.local.home>
 <CAHk-=wgw_Jmn1iJWanoSFb1QZn3mbTD_JEoMsWcWj5QPeyHZHA@mail.gmail.com>
 <20190506130643.62c35eeb@gandalf.local.home> <CAHk-=whesas+GDtHZks62wqXWXe4d_g3XJ359GX81qj=Fgs6qQ@mail.gmail.com>
 <20190506145745.17c59596@gandalf.local.home> <CAHk-=witfFBW2O5v6g--FmqnAFsMkKNLosTFfWyaoJ7euQF8kQ@mail.gmail.com>
 <20190506162915.380993f9@gandalf.local.home> <CAHk-=wi5KBWUOvM94aTOPnoJ5L_aQG=vgLQ4SxxZDeQD0pF2tQ@mail.gmail.com>
 <20190506174511.2f8b696b@gandalf.local.home> <CAHk-=wj3R_s0RTJOmTBNaUPhu4fz2shNBUr4M6Ej65UYSNCs-g@mail.gmail.com>
 <20190506210416.2489a659@oasis.local.home> <CAHk-=whZwqzbu-=1r_j_cXfd=ta1q7RFCuneqBZfQQhS_P-BmQ@mail.gmail.com>
 <20190506215353.14a8ef78@oasis.local.home> <CAHk-=wjLXmOn=Cp=uOfO4gE01eN_-UcOUyrMTTw5-f_OfPO48Q@mail.gmail.com>
 <48BDF7B6-252B-4D29-9116-844363010BC0@amacapital.net>
In-Reply-To: <48BDF7B6-252B-4D29-9116-844363010BC0@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 May 2019 07:57:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjMFRZ7bX4NFc1+=Sy5NDHh=8rAvK-JBqB+HySM1W-Nbg@mail.gmail.com>
Message-ID: <CAHk-=wjMFRZ7bX4NFc1+=Sy5NDHh=8rAvK-JBqB+HySM1W-Nbg@mail.gmail.com>
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
        <linux-kselftest@vger.kernel.org>, stable <stable@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 7, 2019 at 7:48 AM Andy Lutomirski <luto@amacapital.net> wrote:
>
> IOW I think your trick only works if the old and new states are CALL, but=
 we don=E2=80=99t know that until we=E2=80=99ve looked up the record, at wh=
ich point we can just use the result of the lookup.

It would indeed only work for call instructions. I was thinking we'd
know that because we only ever batch up call instructions, though.

But it doesn't matter. I was looking at the ftrace code because I
thought there was some subtle timing bug or race or similar. But it
turned out my "memmove()" was the problem. See the patch I just sent
out.

               Linus
