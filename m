Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC30C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 23:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713B2214E0
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 23:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CfxhObTV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392926AbfIFXaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 19:30:06 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39531 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392731AbfIFXaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 19:30:06 -0400
Received: by mail-ed1-f65.google.com with SMTP id u6so7998746edq.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 16:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Eqinxltb4P+tBqyuO4WEtRUcfdT4qbszA3gfVj1CVng=;
        b=CfxhObTVAmcNKpN/uttdeqMFFuot/dgQ8oBhunu1p3A2/KXMdnJc7eTmTJi6e2ocMn
         NDFZD/Qh8ub6N+V6n8nGKJNHUKm6leUg+lflNX9keuez69bvdXFvHkCOlVvCSi5FCwQp
         GqpsxbxIXF0lypQ9v5DbU9u4VRzHE/ky6Ttco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eqinxltb4P+tBqyuO4WEtRUcfdT4qbszA3gfVj1CVng=;
        b=aP99GEvRuTWDaxdHxa9xqgjredvn0X56FzgD5OEepPkgwMDs6NMhoV2THneB9PJIyl
         SwlxKhPzGIO/f2ErvCkrn5oEiLiV4msLM7U4HbvQB2DljWW3Q8U+oFa2vTAzCvRsnckD
         UB2jDc7dtkCPyBWWTkttIocraWCeeB2tZOYzj4xO3tqbGVkxWMTk2fPEUiN+6iD09kLB
         jObYIOQZT38Cyi3Omqkg5+G72h7mqV90i05XEwUNjKn3MKXk3IyhdLL+5yR8DEbdKA2d
         kxY5wiF08if8B1SlG8/E8KpHO7nriG3BxZK5kIylYwidcxb3kJV9eQcDyjP6BKO4gpQ7
         Eb/A==
X-Gm-Message-State: APjAAAVlwbrcb1Oy1glGLsD1tQNFItsAYqIW9w5hrgc0Kd/7AGJ3wIur
        6XebCU0tM1b1oRpSEGpmXigOJ2cXN/E=
X-Google-Smtp-Source: APXvYqzBJlh78K+G/YRwwriM/LbVv76Xk764DtnFxcOl7k0QHK+IiwYAY+meGonR5FZ/vHsm5MfsuA==
X-Received: by 2002:a50:9438:: with SMTP id p53mr12476291eda.291.1567812604206;
        Fri, 06 Sep 2019 16:30:04 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id g21sm1216793edv.0.2019.09.06.16.30.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2019 16:30:04 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id w13so8144825wru.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 16:30:03 -0700 (PDT)
X-Received: by 2002:adf:de08:: with SMTP id b8mr8516944wrm.200.1567812179254;
 Fri, 06 Sep 2019 16:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190730191303.206365-1-thgarnie@chromium.org>
 <20190806154347.GD25897@zn.tnic> <20190806155034.GP2349@hirez.programming.kicks-ass.net>
 <CAJcbSZETvvQYmh6U_Oauptdsrp-emmSG_QsAZzKLv+0-b2Yxig@mail.gmail.com>
In-Reply-To: <CAJcbSZETvvQYmh6U_Oauptdsrp-emmSG_QsAZzKLv+0-b2Yxig@mail.gmail.com>
From:   Thomas Garnier <thgarnie@chromium.org>
Date:   Fri, 6 Sep 2019 16:22:47 -0700
X-Gmail-Original-Message-ID: <CAJcbSZEc07UJtWyM5i-DGRpNTtoxoY7cDpdyDh3N-Bb+G3s0gA@mail.gmail.com>
Message-ID: <CAJcbSZEc07UJtWyM5i-DGRpNTtoxoY7cDpdyDh3N-Bb+G3s0gA@mail.gmail.com>
Subject: Re: [PATCH v9 00/11] x86: PIE support to extend KASLR randomization
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Nadav Amit <namit@vmware.com>, Jann Horn <jannh@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Maran Wilson <maran.wilson@oracle.com>,
        Enrico Weigelt <info@metux.net>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 12:55 PM Thomas Garnier <thgarnie@chromium.org> wrote:
>
> On Tue, Aug 6, 2019 at 8:51 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Aug 06, 2019 at 05:43:47PM +0200, Borislav Petkov wrote:
> > > On Tue, Jul 30, 2019 at 12:12:44PM -0700, Thomas Garnier wrote:
> > > > These patches make some of the changes necessary to build the kernel as
> > > > Position Independent Executable (PIE) on x86_64. Another patchset will
> > > > add the PIE option and larger architecture changes.
> > >
> > > Yeah, about this: do we have a longer writeup about the actual benefits
> > > of all this and why we should take this all? After all, after looking
> > > at the first couple of asm patches, it is posing restrictions to how
> > > we deal with virtual addresses in asm (only RIP-relative addressing in
> > > 64-bit mode, MOVs with 64-bit immediates, etc, for example) and I'm
> > > willing to bet money that some future unrelated change will break PIE
> > > sooner or later.
>
> The goal is being able to extend the range of addresses where the
> kernel can be placed with KASLR. I will look at clarifying that in the
> future.
>
> >
> > Possibly objtool can help here; it should be possible to teach it about
> > these rules, and then it will yell when violated. That should avoid
> > regressions.
> >
>
> I will look into that as well.

Following a discussion with Kees. I will explore objtool in the
follow-up patchset as we still have more elaborate pie changes in the
second set. I like the idea overall and I think it would be great if
it works.
