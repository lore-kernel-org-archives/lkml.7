Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7F5C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 21:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F3820709
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 21:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KkzxVX4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfKNVkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 16:40:52 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40578 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfKNVkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 16:40:51 -0500
Received: by mail-wr1-f65.google.com with SMTP id i10so8498568wrs.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 13:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NJ5AXjvvGN3rmW3ly7bYsvI92wsOVyTwzutsVT4lLNU=;
        b=KkzxVX4KS4qUbANz1HTGSsWZdZzlQgYcP4L+xwokL21HbQezyUbqQ6EfS+GIrEojKW
         qolcEzO7f8J4GuMkwtVM0Vw+OWs6C/FquGDsmPYKp5GCBvQPLk0Ai2pgMo/yRGZSsW0R
         Hxp34epB4D9Xm5l9AZILC/g195nful0nHEODuXbTEtzsf4C/RqAjYi5YpZ+IhP+zk9co
         ExYstrLDd6SmytbC8Da/c+AzupNT/O3AYjIykxQuG5MKh2tKvXcznWVAlAjinThl7yDS
         egF7XKBOLWeLu+VGVtUXRHHTxS8g9JEHTPLmpcyqy1+P5UtKkk3/KEIcSe29aQas68ki
         HOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NJ5AXjvvGN3rmW3ly7bYsvI92wsOVyTwzutsVT4lLNU=;
        b=EL6aZGZdwwx7SHVA+WGkCe3U5FhxBUo7q54zmMJWUDdRjuG5EA40PPQu0kfKBkfJyc
         LIZqZAKqUVQXxwmREWTi8EI8BZ8CVGLGxsuVDue5WCBYDbII9fwuE4MjNSs58xn+h5C1
         XvW3IIFxgePEH92O/wmiC3syW4Zvdp1jZzQSM2y5Uga/i5mrP4M5QWfJoHmHBsBbZwe0
         2faOGy8rFVKqvaPnfamEu+ZakiOrXho/G/HtNxL0edCrVjesO5LOufKmvFh5Z9a6+/mC
         usgPUHUXgGK24L3llAcv7rvvLsG+KYHT0pDVR4lFKGJC9PG/rAGfUSaJNnY4HIvDssK6
         l5Qw==
X-Gm-Message-State: APjAAAVflO+543vqlnq39fD4olcZ00IV2qOX5z2LlIOdW1FBn8KYzlWP
        ugrhVaShC4NS9Zcq1hfF+OTY3g==
X-Google-Smtp-Source: APXvYqxkzPUiAzHpYfIdHWdk2kJMpAHkpms7E0w+/ME72VBfjNCIjRRJ9EpFjTlEbgwComBDbaQnbw==
X-Received: by 2002:adf:ef91:: with SMTP id d17mr10599325wro.145.1573767190754;
        Thu, 14 Nov 2019 13:33:10 -0800 (PST)
Received: from google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id i13sm8361956wrp.12.2019.11.14.13.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 13:33:09 -0800 (PST)
Date:   Thu, 14 Nov 2019 22:33:03 +0100
From:   Marco Elver <elver@google.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     akiyks@gmail.com, stern@rowland.harvard.edu, glider@google.com,
        parri.andrea@gmail.com, andreyknvl@google.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, arnd@arndb.de, boqun.feng@gmail.com,
        bp@alien8.de, dja@axtens.net, dlustig@nvidia.com,
        dave.hansen@linux.intel.com, dhowells@redhat.com,
        dvyukov@google.com, hpa@zytor.com, mingo@redhat.com,
        j.alglave@ucl.ac.uk, joel@joelfernandes.org, corbet@lwn.net,
        jpoimboe@redhat.com, luc.maranget@inria.fr, mark.rutland@arm.com,
        npiggin@gmail.com, peterz@infradead.org, tglx@linutronix.de,
        will@kernel.org, edumazet@google.com, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v4 00/10] Add Kernel Concurrency Sanitizer (KCSAN)
Message-ID: <20191114213303.GA237245@google.com>
References: <20191114180303.66955-1-elver@google.com>
 <20191114195046.GP2865@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114195046.GP2865@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2019, Paul E. McKenney wrote:

> On Thu, Nov 14, 2019 at 07:02:53PM +0100, Marco Elver wrote:
> > This is the patch-series for the Kernel Concurrency Sanitizer (KCSAN).
> > KCSAN is a sampling watchpoint-based *data race detector*. More details
> > are included in **Documentation/dev-tools/kcsan.rst**. This patch-series
> > only enables KCSAN for x86, but we expect adding support for other
> > architectures is relatively straightforward (we are aware of
> > experimental ARM64 and POWER support).
> > 
> > To gather early feedback, we announced KCSAN back in September, and have
> > integrated the feedback where possible:
> > http://lkml.kernel.org/r/CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com
> > 
> > The current list of known upstream fixes for data races found by KCSAN
> > can be found here:
> > https://github.com/google/ktsan/wiki/KCSAN#upstream-fixes-of-data-races-found-by-kcsan
> > 
> > We want to point out and acknowledge the work surrounding the LKMM,
> > including several articles that motivate why data races are dangerous
> > [1, 2], justifying a data race detector such as KCSAN.
> > 
> > [1] https://lwn.net/Articles/793253/
> > [2] https://lwn.net/Articles/799218/
> 
> I queued this and ran a quick rcutorture on it, which completed
> successfully with quite a few reports.

Great. Many thanks for queuing this in -rcu. And regarding merge window
you mentioned, we're fine with your assumption to targeting the next
(v5.6) merge window.

I've just had a look at linux-next to check what a future rebase
requires:

- There is a change in lib/Kconfig.debug and moving KCSAN to the
  "Generic Kernel Debugging Instruments" section seems appropriate.
- bitops-instrumented.h was removed and split into 3 files, and needs
  re-inserting the instrumentation into the right places.

Otherwise there are no issues. Let me know what you recommend.

Thanks,
-- Marco
