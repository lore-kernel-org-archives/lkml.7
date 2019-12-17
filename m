Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB48C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACCA52053B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576615447;
	bh=YED4RPfRYlt98bF0R98iY51ABN4X2dYsrsJd5BxgjPw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EvNacbs1aKz+EsB6e5nCNank6xqGi+2R95/tl5jwU/35kYGW3QErPdCcF1Td49AXZ
	 Qg5HMDjr4dq+MwVsCB6xeFxypHIbTW1m/NLDjVm+2lSZCYgxPmCFhSgEIARvEiiBEu
	 2fLg/i5q1B+ur/v9Jj6IGuvA6ytl8nlwcfFaMMvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbfLQUoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:44:06 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43228 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbfLQUoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:44:06 -0500
Received: by mail-lj1-f196.google.com with SMTP id a13so12462394ljm.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 12:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2cf4f/QMuXkJeMkXz5zpiT8/Vid/X0vf07yHkg4bF34=;
        b=AiH6mnOw1/7BYh931DcV6Hdvt+DTFflY7cdUvCiSJPSv1jGSEGCxXohtV7+Ndw/fuS
         LK39OyGZBJvOBtZI32H4AROOrz4v5Iwx8JYmkW266IF3WT4lBy9qVzCGcKPqWT7Vgz1V
         eockp+SBbZ6O9i1DvC9E2d5sGe2PfxvehWel0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2cf4f/QMuXkJeMkXz5zpiT8/Vid/X0vf07yHkg4bF34=;
        b=DrVtNnKhtvF1uSUk5IRcKgTWFo4ZIQ7GrC4rA55URGWjWjdXBwyvC1B0/3Q2p49pwg
         LjlqrfzQU7mw4f5+pYgSttxsOBTR5jtj2HGA98ID1LqUun0anYbaNU+gxknTH0N1untz
         NMjS+SttE6+4bghdDMdPc8v5MAWja+4OaD3296+RuTAqmQR7CouIjArpV1udIS2AKlTZ
         Wvzagi7EbSCzPYIq9kXe+5pnkoLCvSVibMqyeKbLU4T6+jUmZ2/trm/9yhBEev76AuwX
         RLHyg2pth1Ykuxy4ttGPRUV/0MHk8y54+cSzEy5xIhgDqQFHFH5uxLilIJ3MsOdndwFF
         nczQ==
X-Gm-Message-State: APjAAAW85WNFzFAut2KmPLXRnFSUGcUdKevLUqnsjNpF17rZIn6Zkw38
        K43wTlS/25blHuuL1ZOWkGjBcjBs9UM=
X-Google-Smtp-Source: APXvYqw3WnRIlCmg67xgkYmulpzi3iBkzx56zxDaCjwMlvID5TrFUFSjteZx3zLMHf6mcQHremqCRA==
X-Received: by 2002:a2e:814e:: with SMTP id t14mr4554954ljg.149.1576615443378;
        Tue, 17 Dec 2019 12:44:03 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id d24sm13114852lja.82.2019.12.17.12.44.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 12:44:02 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id r19so12493223ljg.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 12:44:02 -0800 (PST)
X-Received: by 2002:a2e:9ad1:: with SMTP id p17mr2567128ljj.26.1576615442111;
 Tue, 17 Dec 2019 12:44:02 -0800 (PST)
MIME-Version: 1.0
References: <20191217115547.GA68104@gmail.com> <CAHk-=wiVZMU69qB7nmkkyvjtDenQ+89V94V=3mmdY88uWYrZiQ@mail.gmail.com>
 <20191217193039.GF2844@hirez.programming.kicks-ass.net> <CAHk-=wgH8bSsgxnUAjuoUyDwHPKZwdVirH__=mJQu7RCFfCwZA@mail.gmail.com>
 <20191217203506.GI2844@hirez.programming.kicks-ass.net>
In-Reply-To: <20191217203506.GI2844@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Dec 2019 12:43:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=whccvKaB-Fezv9w9XuZx4JDz4jDiJd+dATTj7yErhvpKQ@mail.gmail.com>
Message-ID: <CAHk-=whccvKaB-Fezv9w9XuZx4JDz4jDiJd+dATTj7yErhvpKQ@mail.gmail.com>
Subject: Re: [GIT PULL] timer fixes
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 12:35 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Pray.. the TSC MSR is still writable from SMM, so BIOS monkeys could
> still do what they've been doing for decades.

Sure. And the HPET is unreliable, so the checking causes issues.

Which one should we worry about?

> Also, what consititutes a 'modern' CPU?

I think anything that has TSC_STABLE set should likely be considered
more reliable than HPET.

Or whatever the bit is called. The "doesn't stop in idle" thing.

> > The HPET seems to get disabled on all the modern platforms, why do we
> > even have it enabled by default?
>
> These new ones yeah, cuz they wrecked HPET in PC10 :/

That's my point. HPET isn't _used_ by Windows, so it gets no testing,
so it will continue to have bugs.

At least the TSC is used.

I do agree about the whole SMM issue, but it seems less of a pain than
the HPET issue.

             Linus
