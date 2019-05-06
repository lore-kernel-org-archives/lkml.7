Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A58AC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372272087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557160028;
	bh=RZmHO++7U13n+Ra8hHX1FYZI9YLr/7lO2Xy//HK2TV4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fbGh4bMOEZAx9hO9XQRdx+kzUIwRY0AKqOgBJ0GcVihXiObaaskvx/z7lwLfvnLGU
	 pDgQmmygI5/3TvMeJpBhhlQZSsx1TDn+F7oJBhAUL9vf2ropZ8AkPVoLwL/BjYwtcD
	 025Sydk7bEgGeoGHA1DQiatKDdhO2W9tApIlbB38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfEFQ1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 12:27:07 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37847 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEFQ1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 12:27:06 -0400
Received: by mail-lf1-f65.google.com with SMTP id h126so9603885lfh.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 09:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YVhVdCTcPM0PTipUC5cKupbZldiZWmaMJ+OXUnCYkpU=;
        b=Uf62pHFtgllYqALvEUKMKV6I76IKCFItvVqLvjkQ3d2lCpV1XjpBx0yJQ+iFGh0+Ij
         IF7dcBQsUWv2vieVJNPLLPfGaN2XG0Ytn2qDMwNEB3RNtdjQ3+fNKlJGrdwbxOWlqMDS
         z9PbLEvLjajjgofELNpGz9INcqnXVrYbR8qgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YVhVdCTcPM0PTipUC5cKupbZldiZWmaMJ+OXUnCYkpU=;
        b=eFdPSGA4c0BthVnYuc+yeCJ9RBxV0KNGu21qfG1EBNdnLMqNJxZ1h/GdVJnJnPEU4w
         wDquK9M9HB7p6mYbIkvVEj4HIyYIdyZKkSDw1DlOQUR3JwPyxxOGido544BE6VyhppBW
         6nrhdeIJPlWZlWM3rX0TuiBMXEyxScv6n00Rnsjng4G6Rcz95KTnl5b8BY2uhPH08arK
         kLyzSaIs6zcBORCOexUOENpcYvyfz+0wU1ZEkgIdNYsye7yXNgSNdIgR3ZrFDq4O6bVq
         8KNUtmmO/wS5WS7uAtfb22goNU69O6akBomg5wUNTMEY/2KxrkR7hjTqwmxWTyAyNIe8
         RITA==
X-Gm-Message-State: APjAAAVNcZ5Gz9QNXzZkbCJJmjZwnGIWY523UdWjHHeu3bTnGRmiiHAv
        uCWH2V22GPM6hy5cETlZpsdwEcpLqrA=
X-Google-Smtp-Source: APXvYqzKWTgnXZVZHtutOUSsu84buwJOYZukLmX6lVHq3TpacZ96PQy/JPOPWmXkj/ketK1yt6Ckrg==
X-Received: by 2002:ac2:485a:: with SMTP id 26mr13566398lfy.23.1557160024350;
        Mon, 06 May 2019 09:27:04 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id r3sm2509811ljr.7.2019.05.06.09.27.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 09:27:04 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id k8so11619927lja.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 09:27:03 -0700 (PDT)
X-Received: by 2002:a05:651c:8f:: with SMTP id 15mr13394592ljq.118.1557159592300;
 Mon, 06 May 2019 09:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190502181811.GY2623@hirez.programming.kicks-ass.net>
 <CAHk-=wi6A9tgw=kkPh5Ywqt687VvsVEjYXVkAnq0jpt0u0tk6g@mail.gmail.com>
 <20190502202146.GZ2623@hirez.programming.kicks-ass.net> <20190502185225.0cdfc8bc@gandalf.local.home>
 <20190502193129.664c5b2e@gandalf.local.home> <20190502195052.0af473cf@gandalf.local.home>
 <20190503092959.GB2623@hirez.programming.kicks-ass.net> <20190503092247.20cc1ff0@gandalf.local.home>
 <2045370D-38D8-406C-9E94-C1D483E232C9@amacapital.net> <CAHk-=wjrOLqBG1qe9C3T=fLN0m=78FgNOGOEL22gU=+Pw6Mu9Q@mail.gmail.com>
 <20190506081951.GJ2606@hirez.programming.kicks-ass.net> <20190506095631.6f71ad7c@gandalf.local.home>
 <CAHk-=wgw_Jmn1iJWanoSFb1QZn3mbTD_JEoMsWcWj5QPeyHZHA@mail.gmail.com>
In-Reply-To: <CAHk-=wgw_Jmn1iJWanoSFb1QZn3mbTD_JEoMsWcWj5QPeyHZHA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 May 2019 09:19:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjs8hhEdLUb=rD1tZC-JzBHALpi0hQSNf=esw96Gnta6A@mail.gmail.com>
Message-ID: <CAHk-=wjs8hhEdLUb=rD1tZC-JzBHALpi0hQSNf=esw96Gnta6A@mail.gmail.com>
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

On Mon, May 6, 2019 at 9:17 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So what is it that doesn't actually work? I've looked at the patch
> even more, and I can't for the life of me see how it wouldn't work.

And I do still react to PeterZ's

 arch/x86/entry/entry_32.S            | 150 +++++++++++++++++++++++++++++------

vs

 arch/x86/entry/entry_32.S            |  7 ++++++-

for mine. And PeterZ's  apparently still had bugs.

Yes, mine can have bugs too, but I really *have* done some basic
testing, and with 6 lines of code, I think they are more localized.

                Linus
