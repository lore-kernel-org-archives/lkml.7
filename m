Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43188C468BD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213ED2133D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559929707;
	bh=hIXobvLX7vSg9N90a5o3ipY0obvHhHGB6Vs/UR79BiQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=C04XJ8IvHDunOpmJ0s1PGRBNE8NiQ/Dc5Ps2huIl8GLIShRFoBNduZnns/WelWaXN
	 cudYdx3zIiSaOg9VAz1BSysnZemEfx3X7GXo1ELw8nnNOHA3TQMJ0QtifihD7jRfUp
	 WyATjg0m6KN640fHGlhhhYWB+RcAJaNWKWkcfUWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbfFGRs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 13:48:26 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37154 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbfFGRs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 13:48:26 -0400
Received: by mail-lf1-f68.google.com with SMTP id m15so2257140lfh.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 10:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i7/otFLhJ3bDHgjDfO6mj7CHsE7BUGZdynbRLEhHFUQ=;
        b=bS9qEaH/73TPk8ga/eF/YyZ737I0ef7FUTSLE99EhdCnXv6YIbVGezMaX/eEd+xlcD
         ser1nRz6S0lRSXjtod9Lb8kOYRftd8H1I24RE2bO6B8NweysAqC1P4GkPElOkBexIIkL
         wnj9Y6t62H8vqO7RCIiQD3sjYJTXvtBXqZ57k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i7/otFLhJ3bDHgjDfO6mj7CHsE7BUGZdynbRLEhHFUQ=;
        b=KQ5ibC2BtYLKIEhgC2ue+pd4JLvviNxkL+JhM9OmaeSr+JO2LnqOBSGgxjCphP/3D2
         GltDarzqfzvkEfrcEpAogi5EkbuikVAQC3ShfmiN6M48rr1WTjFJumBYKPg227w5eXa/
         3ps3K50NJSF75AEqBOiEuh78/jKeCggIVcXCO68WRmNnKAzQp4ReDfDrDZ65CSFY8/WM
         6V7ZCxcKyGCEL+EbXi8e2JwahsJb3rqn+iGj/oxeqZlzI0DysmFwKjElBdZehVFLe4H3
         acU1kE2Wg0S12JSLEvTdJwPfVHX98Kr77SqA9fi6uo5Wg9KabBYgAHVsHcXHOA5bpJBk
         CcZg==
X-Gm-Message-State: APjAAAVqgWQg9S+NQ7oCzNL0KOCOUuasexRVLho123lHohwugo84PKom
        eAo56BlGvU0W+eisOdY+uxw5oIhWbVI=
X-Google-Smtp-Source: APXvYqweB7R3iCft6JHzQTs82bzB9A/M4mmiyAu8GEf+LQPAo33IwL6voHgd/wda3ot2xAf5FH+fFw==
X-Received: by 2002:ac2:5ec6:: with SMTP id d6mr29683822lfq.131.1559929703358;
        Fri, 07 Jun 2019 10:48:23 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id x19sm489463ljb.6.2019.06.07.10.48.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 10:48:22 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id y198so2273661lfa.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 10:48:22 -0700 (PDT)
X-Received: by 2002:ac2:4565:: with SMTP id k5mr23954642lfm.170.1559929701965;
 Fri, 07 Jun 2019 10:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190605130753.327195108@infradead.org> <20190605131945.005681046@infradead.org>
 <20190608004708.7646b287151cf613838ce05f@kernel.org> <20190607173427.GK3436@hirez.programming.kicks-ass.net>
In-Reply-To: <20190607173427.GK3436@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Jun 2019 10:48:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg9dk6jXUcAE3FRkwHMqOra1MerS1Ehfgx-a2QQ22-Esg@mail.gmail.com>
Message-ID: <CAHk-=wg9dk6jXUcAE3FRkwHMqOra1MerS1Ehfgx-a2QQ22-Esg@mail.gmail.com>
Subject: Re: [PATCH 08/15] x86/alternatives: Teach text_poke_bp() to emulate instructions
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 7, 2019 at 10:34 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> I was/am lazy and didn't want to deal with:
>
> arch/x86/include/asm/nops.h:#define GENERIC_NOP5_ATOMIC NOP_DS_PREFIX,GENERIC_NOP4
> arch/x86/include/asm/nops.h:#define K8_NOP5_ATOMIC 0x66,K8_NOP4
> arch/x86/include/asm/nops.h:#define K7_NOP5_ATOMIC NOP_DS_PREFIX,K7_NOP4
> arch/x86/include/asm/nops.h:#define P6_NOP5_ATOMIC P6_NOP5

Ugh. Maybe we could just pick one atomic sequence, and not have the
magic atomic nops be dynamic.

It's essentially what STATIC_KEY_INIT_NOP #define seems to do anyway.

NOP5_ATOMIC is already special, and not used for the normal nop
rewriting, only for kprobe/jump_label/ftrace.

So I suspect we could just replace all cases of

   ideal_nops[NOP_ATOMIC5]

with

   STATIC_KEY_INIT_NOP

and get rid of the whole "let's optimize the atomic 5-byte nop" entirely.

Hmm?

By definition, NOP_ATOMIC5 is just a single nop anyway, it's not used
for the potentially more complex alternative rewriting cases.

                Linus
