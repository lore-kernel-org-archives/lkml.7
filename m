Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272E0C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31D9215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556569550;
	bh=otwvmaSfMgY75fve8vo1H12KsAf0x57dknjXuMelZrg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hy96+3BXoO+qR+DhYzS8kJ5Wx53Q/cNAQIlOYZLgmWk/SbBHykyYeLwY9/5c1Bmm0
	 I27vqj1POVrfp0oZJ3Pd1XJc3hSrLi4+of0ZgZM2l56x0Z+JmWmgAHYX6yH28o1aTS
	 Vh68ZFQPfyi5S4RbR/+YfS3DLvN3zYp7i5zTVWfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbfD2UZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 16:25:48 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37203 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729252AbfD2UZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 16:25:48 -0400
Received: by mail-lj1-f194.google.com with SMTP id b12so9449320lji.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 13:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w50mZSoHkn4YcdVSRzxMDCW63EO0vPkQ2Zrko7ZDpHk=;
        b=AoO6Qi9m5Ef2LQWrXsqnatYGBHOrBL3A+gnuAsmezQFUMAvvmPyPcegTT9th39HlUb
         s0behpUfbgVFRk/qomTxJbvucaUEQ+T1StzlVKWLMf0QmKqLJwshHyUYFwvc5w4cct+e
         ULknvqmm/IVR0Nk7kkerKDJNE3EHy3hhGQff4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w50mZSoHkn4YcdVSRzxMDCW63EO0vPkQ2Zrko7ZDpHk=;
        b=ZxQnChEi7PfwMupSmUBqlIK+j7k3D384mTZNqtfLTtke0TFExDJzA24TLv8aV4eVo5
         YBXPK291tZGq7VcDW1VyR7rktx2j10xS+TnFQKXuuxKgcFk1AhMSFgph2TuW0M/dsJEU
         rdDpLyN9XX5u4/AUBbWafSLgW3mILZp+XlsCCbuLQMAwdF77RkSJoJI4rxWJqX7yVP9S
         7j5LPd8ICtIF2VVQoD/+pGHKN/w3Vs1ZTSXgqa7hgBfNORSnOr9UMfqxxvYFlsUAz03L
         dIVM38NImKoC+zI0GUtHbCASIdUvn8XS1cGZ37l4nUWlvRD/1xmIDGPrclDl1esn9Vew
         ou5Q==
X-Gm-Message-State: APjAAAUwzrElqptzghlAkf2ESxKHka6k1K5zGPkxKNcCWBhs5RTwJevg
        m+v/85Auo+/K+4Zq0kHK/g3hUwWQvc8=
X-Google-Smtp-Source: APXvYqw98zVbiHIsood6UOEC7lEDfY/9I555y4lSANphWEygxexHw+vbnGPa6o5Q6Qb0G1LFyc/ruw==
X-Received: by 2002:a2e:3815:: with SMTP id f21mr10741307lja.25.1556569545816;
        Mon, 29 Apr 2019 13:25:45 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id q15sm2201559lfh.59.2019.04.29.13.25.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 13:25:45 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id f23so10675723ljc.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 13:25:45 -0700 (PDT)
X-Received: by 2002:a2e:8090:: with SMTP id i16mr8383998ljg.135.1556569221934;
 Mon, 29 Apr 2019 13:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190427100639.15074-1-nstange@suse.de> <20190427100639.15074-4-nstange@suse.de>
 <20190427102657.GF2623@hirez.programming.kicks-ass.net> <20190428133826.3e142cfd@oasis.local.home>
 <CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com>
 <20190429145250.1a5da6ed@gandalf.local.home> <CAHk-=wjm93jLtVxTX4HZs6K4k1Wqh3ujjmapqaYtcibVk_YnzQ@mail.gmail.com>
 <20190429150724.6e501d27@gandalf.local.home> <CAHk-=wgbC-wiSrdDYAh1ORF4EKmecY+MkNsJBF=BWf4W1bXXgA@mail.gmail.com>
In-Reply-To: <CAHk-=wgbC-wiSrdDYAh1ORF4EKmecY+MkNsJBF=BWf4W1bXXgA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Apr 2019 13:20:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiMG95TmkMm5AK7w73=mn+is8qnNztS7iJVfz23-A44Yg@mail.gmail.com>
Message-ID: <CAHk-=wiMG95TmkMm5AK7w73=mn+is8qnNztS7iJVfz23-A44Yg@mail.gmail.com>
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

On Mon, Apr 29, 2019 at 1:06 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Only do the 'call' instructions one at a time. Why would you change
> _existing_ code?

Side note: if you want to, you can easily batch up rewriting 'call'
instructions to the same target using the exact same code. You just
need to change the int3 handler case to calculate the
bp_int3_call_return from the fixed one-time address to use sopmething
like

     this_cpu_write(bp_call_return, int3_address-1+bp_int3_call_size);

instead (and you'd need to also teach the function that there's not
just a single int3 live at a time)

                Linus
