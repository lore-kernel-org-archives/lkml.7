Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20A6C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9306820714
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jtMhRC6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbfKTPzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:55:00 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40414 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731558AbfKTPy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:54:59 -0500
Received: by mail-wm1-f67.google.com with SMTP id y5so111326wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 07:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pc/B5s8Op7DZcUpCkoozM2pKb7wkORn3PJUzQ+3VJls=;
        b=jtMhRC6Pk0HadowGTjQERXbTA9SrlkgA6uoK4GrRBBSya5IrU9FKwc5sKWuazC7hWY
         91aODgBraKSoG3+eK4B2Za6Q/SMrQiR5aWNtuyZaBsUjHqSN2Zi+JRcOllkgpeTVuzp8
         KDT853LwBilN+sUKYomYUcWf/qSSmZVkW+82quasRshDxUIO+1hR/nIVZmRvxQmr68TG
         JuuUYYKg35fGImgfsm/WZdIhy6TJt7Bd0SxC2TXYB82TjG7g7WhD7Xc4n2MJVs5c58xj
         OsGpyLKVVbGaZmacdh697dBEAEP6D0PtBat1Xcjiao3BpaFQFCZ1O7xp2tWnSqIW3UyD
         DLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pc/B5s8Op7DZcUpCkoozM2pKb7wkORn3PJUzQ+3VJls=;
        b=Rnbnj/RcITXPHis2xNz9PlkEoFH4A+msbot0fxY4WXhRgQIWmhNJWwZ2so4UmVBdnW
         ebUUSotVYsA4n0b/FbvcgELe6Fct1LTSq8dxT7I7dpnxnYM1MA1sqQOtE/Hta89pAL8E
         hugRwKfFQAcG8iCr4ivXFb/ge2p+0FkmiNnHF8dyIf7XMRXm2EneOZ6zO6Vf5XPGQT51
         mlNHn2n9jQ+tRcVc6sBYyNAYvb1ftv6+uuuR/p9fJruWfljGEEUArmCJeaAT/bZQcDno
         LOTfF6XDPDSa5elktXzubqodQ8bh2BPVqMMLHJj9ICP/9rdpDF6OZvzXe7SdrgaRlNaf
         pk4w==
X-Gm-Message-State: APjAAAVft1/khecaDi7lfNhDeGme/1+rfIKHhtUdh6EfX5iOo7VvsU3S
        tDf2ZCp/V7w2H04qOhkhEVJ00w==
X-Google-Smtp-Source: APXvYqygyv2epnPyQ8ZUCWpvIvDmkk1mlhM7bZ2yAb9gUjZi3pn0UqvfOAVs0g05UGhLYqygkKm6GA==
X-Received: by 2002:a1c:38c3:: with SMTP id f186mr4147629wma.58.1574265294776;
        Wed, 20 Nov 2019 07:54:54 -0800 (PST)
Received: from google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id z6sm33020710wro.18.2019.11.20.07.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 07:54:53 -0800 (PST)
Date:   Wed, 20 Nov 2019 16:54:48 +0100
From:   Marco Elver <elver@google.com>
To:     Qian Cai <cai@lca.pw>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alexander Potapenko <glider@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Daniel Axtens <dja@axtens.net>,
        Daniel Lustig <dlustig@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Luc Maranget <luc.maranget@inria.fr>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-efi@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH v4 00/10] Add Kernel Concurrency Sanitizer (KCSAN)
Message-ID: <20191120155448.GA21320@google.com>
References: <20191114180303.66955-1-elver@google.com>
 <1574194379.9585.10.camel@lca.pw>
 <CANpmjNPynCwYc8-GKTreJ8HF81k14JAHZXLt0jQJr_d+ukL=6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPynCwYc8-GKTreJ8HF81k14JAHZXLt0jQJr_d+ukL=6A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2019, Marco Elver wrote:

> On Tue, 19 Nov 2019 at 21:13, Qian Cai <cai@lca.pw> wrote:
> >
> > On Thu, 2019-11-14 at 19:02 +0100, 'Marco Elver' via kasan-dev wrote:
> > > This is the patch-series for the Kernel Concurrency Sanitizer (KCSAN).
> > > KCSAN is a sampling watchpoint-based *data race detector*. More details
> > > are included in **Documentation/dev-tools/kcsan.rst**. This patch-series
> > > only enables KCSAN for x86, but we expect adding support for other
> > > architectures is relatively straightforward (we are aware of
> > > experimental ARM64 and POWER support).
> >
> > This does not allow the system to boot. Just hang forever at the end.
> >
> > https://cailca.github.io/files/dmesg.txt
> >
> > the config (dselect KASAN and select KCSAN with default options):
> >
> > https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config
> 
> Thanks! That config enables lots of other debug code. I could
> reproduce the hang. It's related to CONFIG_PROVE_LOCKING etc.
> 
> The problem is definitely not the fact that kcsan_setup_watchpoint
> disables interrupts (tested by removing that code). Although lockdep
> still complains here, and looking at the code in kcsan/core.c, I just
> can't see how local_irq_restore cannot be called before returning (in
> the stacktrace you provided, there is no kcsan function), and
> interrupts should always be re-enabled. (Interrupts are only disabled
> during delay in kcsan_setup_watchpoint.)
> 
> What I also notice is that this happens when the console starts
> getting spammed with data-race reports (presumably because some extra
> debug code has lots of data races according to KCSAN).
> 
> My guess is that some of the extra debug logic enabled in that config
> is incompatible with KCSAN. However, so far I cannot tell where
> exactly the problem is. For now the work-around would be not using
> KCSAN with these extra debug options.  I will investigate more, but
> nothing obviously wrong stands out..

It seems that due to spinlock_debug.c containing data races, the console
gets spammed with reports. However, it's also possible to encounter
deadlock, e.g.  printk lock -> spinlock_debug -> KCSAN detects data race
-> kcsan_print_report() -> printk lock -> deadlock.

So the best thing is to fix the data races in spinlock_debug. I will
send a patch separately for you to test.

The issue that lockdep still reports inconsistency in IRQ flags tracing
I cannot yet say what the problem is. It seems that lockdep IRQ flags
tracing may have an issue with KCSAN for numerous reasons: let's say
lockdep and IRQ flags tracing code is instrumented, which then calls
into KCSAN, which disables/enables interrupts, but due to tracing calls
back into lockdep code. In other words, there may be some recursion
which corrupts hardirqs_enabled.

Thanks,
-- Marco
