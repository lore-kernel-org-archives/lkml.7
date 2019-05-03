Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D6EC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 16:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201A02075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 16:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556901891;
	bh=8cw3huy9JgI135+NqQSe0fA379tB3gSlEfIQFk7nPPI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iyNqHReUcgqN4hO5WVMKzBJiFbpiSdMeJcZNdblrJJC2NVTc+wjtSg92iR7oOLLfy
	 u6ElS/yMTkurrPx+9zYKDt/pUpH3GbfmGYLZ6pyq1SWgiduDWfRE+ml3g1Wy60P4SB
	 xNkdzA8qFSCEIz+8WLTaEHeGiw+F4ajLS5lyK1vs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbfECQou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 12:44:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727899AbfECQot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 12:44:49 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CBCC214DA
        for <linux-kernel@vger.kernel.org>; Fri,  3 May 2019 16:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556901888;
        bh=8cw3huy9JgI135+NqQSe0fA379tB3gSlEfIQFk7nPPI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a9tcXeVU+XVrv+XaQ98EQO+7o9VnoEC7qSeG5XSuDT3JZciuL59Dzppqzc87hwVPY
         d1bcbxf1pRtY3i6X0cXOTdUWyCZUgF+YFk2nFiABIc3rYcvNfN9mf9Qns0ClUKCaWC
         NgsTgylYZrf5x8w+imb6NLWJzPx1d9C9hZXqJ0KA=
Received: by mail-wr1-f50.google.com with SMTP id l2so8665263wrb.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 09:44:48 -0700 (PDT)
X-Gm-Message-State: APjAAAUOGdZGu4Y9Ru8vI4H/asnI5pvvd8EJa/p8PtoqXXVRCyBNOLZw
        kzKM/gu2yxG5NlAdERXf+eKAHYdPX+y5TBEUOKJbtA==
X-Google-Smtp-Source: APXvYqwdh0bncv2mEhNhDzUjkAso7jUC2TqrfVvEwRSxKalPbLqYKMBf8BsmaQA/bDkxZZthnfNip2uVK/Cx8DvGL2Q=
X-Received: by 2002:adf:ec42:: with SMTP id w2mr5212912wrn.77.1556901887167;
 Fri, 03 May 2019 09:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190502181811.GY2623@hirez.programming.kicks-ass.net>
 <CAHk-=wi6A9tgw=kkPh5Ywqt687VvsVEjYXVkAnq0jpt0u0tk6g@mail.gmail.com>
 <20190502202146.GZ2623@hirez.programming.kicks-ass.net> <20190502185225.0cdfc8bc@gandalf.local.home>
 <20190502193129.664c5b2e@gandalf.local.home> <20190502195052.0af473cf@gandalf.local.home>
 <20190503092959.GB2623@hirez.programming.kicks-ass.net> <20190503092247.20cc1ff0@gandalf.local.home>
 <2045370D-38D8-406C-9E94-C1D483E232C9@amacapital.net> <20190503123126.3a2801be@gandalf.local.home>
 <20190503163527.GI2606@hirez.programming.kicks-ass.net>
In-Reply-To: <20190503163527.GI2606@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 3 May 2019 09:44:35 -0700
X-Gmail-Original-Message-ID: <CALCETrUcEH8kswYGNkoupVVP+3hEsTA4BWTfLk-RY_RfkDsHGw@mail.gmail.com>
Message-ID: <CALCETrUcEH8kswYGNkoupVVP+3hEsTA4BWTfLk-RY_RfkDsHGw@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] x86: Allow breakpoints to emulate call functions
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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

On Fri, May 3, 2019 at 9:35 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, May 03, 2019 at 12:31:26PM -0400, Steven Rostedt wrote:
> > I guess the real question is, what's the performance impact of doing
> > that?
>
> Is there anyone that considers i386 a performance platform?

Not me.  As far as I'm concerned, I will basically always gladly trade
several cycles for simplicity on 32-bit.

--Andy
