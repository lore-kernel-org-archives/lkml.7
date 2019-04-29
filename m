Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08CAC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7772067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556568718;
	bh=yHFuD1yqCum2y2trfA6le7Rc2q/f7UbNCSi1KupUDQw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OjYgVd4WBDokcN4PeyWZzS8sord3jg+NRum7hQTDAKdm7YDvUSuAEZnFsnZcJLBz9
	 DjXmxlKa44iUnjKurTBuICDvgT7vPd4bnnqE9ZIw0JQ4npOxKgVeB4n+z6XE/dvRob
	 z/a1D/CJ3UbbMQUS0XRNPrjIQf5ntt5NmLaayWG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbfD2UL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 16:11:57 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46428 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbfD2UL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 16:11:56 -0400
Received: by mail-lf1-f68.google.com with SMTP id k18so8859619lfj.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 13:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6BzF2OGCOW6HJd/OnyiluqOmAxSSof4acOvoZOgQm9o=;
        b=USATFDoZDh4xC+n5UqEtvteBhBowGyyECGRsSRhXKOP5PzafOvxupieg8HOTz7c/tT
         PXOh2kw9Riqlvj6y0JnovEQkM5Sxqs6/eA/GdnQ1+qDmrJni0xr2WjZhGxpsNJCXOf6b
         lOAASJsanyZBZOXaJ0IkarPkyAoriW6kXsvF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6BzF2OGCOW6HJd/OnyiluqOmAxSSof4acOvoZOgQm9o=;
        b=Dq/kDHuF/O6URex9WPc2R6M8zg2kU+LlrZz9j8wxCcBTMY/+01bnyEB1LSx5Xv8IH2
         yggPcVvCRv4F4UDBPi7DYYS3lrGw7t67ssq0jhUTQKlpMQsQcb+U5NV4L0ZKNauoi/AA
         WdVKW3zds73kciRWyWnOAfz3rPC4/5e5t63IMUMDygAhb+9N+/PGHVkamNwnxARvBunk
         kNX+Guua56y0l0nrhIOuuSL2Tbu8HylTGV8pys1dwLLyFSZS9GeLZk5ncTtuak5hXhqj
         vkFscity5DP+IjPWEF+zCEbXiAyHBa5Y9SmcOJupR+ZlumPjCyRT+hhkzyGqO75amPFJ
         BPrw==
X-Gm-Message-State: APjAAAVcuQOKD4tjfrQ3GUArqB+5HJ6Y6JQM4FHqVTTFAbqNm9TwcRUN
        N27hLUAXIWiuQ2pirdiCOoyQ5HIftH0=
X-Google-Smtp-Source: APXvYqylBVmx87Z1ny03VsamMro+Ta/VzuqeiRPzCihHKd0X19lzdNDpr35cHUguwvqUBjSSN/IMVQ==
X-Received: by 2002:ac2:5207:: with SMTP id a7mr35414412lfl.70.1556568713912;
        Mon, 29 Apr 2019 13:11:53 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id z7sm7555127lfg.40.2019.04.29.13.11.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 13:11:53 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id t1so477801lje.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 13:11:53 -0700 (PDT)
X-Received: by 2002:a2e:3e0e:: with SMTP id l14mr33501765lja.125.1556568393207;
 Mon, 29 Apr 2019 13:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190427100639.15074-1-nstange@suse.de> <20190427100639.15074-4-nstange@suse.de>
 <20190427102657.GF2623@hirez.programming.kicks-ass.net> <20190428133826.3e142cfd@oasis.local.home>
 <CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com>
 <20190429145250.1a5da6ed@gandalf.local.home> <CAHk-=wjm93jLtVxTX4HZs6K4k1Wqh3ujjmapqaYtcibVk_YnzQ@mail.gmail.com>
 <20190429150724.6e501d27@gandalf.local.home>
In-Reply-To: <20190429150724.6e501d27@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Apr 2019 13:06:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgbC-wiSrdDYAh1ORF4EKmecY+MkNsJBF=BWf4W1bXXgA@mail.gmail.com>
Message-ID: <CAHk-=wgbC-wiSrdDYAh1ORF4EKmecY+MkNsJBF=BWf4W1bXXgA@mail.gmail.com>
Subject: Re: [PATCH 3/4] x86/ftrace: make ftrace_int3_handler() not to skip
 fops invocation
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
        Andy Lutomirski <luto@kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 12:07 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Are you suggesting that I rewrite the code to do it one function at a
> time? This has always been batch mode. This is not something new. The
> function tracer has been around longer than the text poke code.

Only do the 'call' instructions one at a time. Why would you change
_existing_ code?

                 Linus
