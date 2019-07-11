Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D2FC74A35
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D7021670
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LQSni2QX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbfGKPJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 11:09:01 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41053 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbfGKPJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 11:09:00 -0400
Received: by mail-pl1-f195.google.com with SMTP id m9so3167862pls.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 08:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6Y7/EmhYa6i3GEsi4Y7y5f9hDRN5qiF/ifdOoyJesEU=;
        b=LQSni2QXLXswE/M1jbF0EOI21lueLWhC/pRwpcUKf3JlktEQ9xnYvfv0m884j88kDu
         xsqHchYyVuLK+mORVh1Y1kXPJC+w90SkovvGnf85vvxKir6kk8OO1QPCOuQDmJXyi6d2
         OiUhDpscvaAWfWIUAIiYNc3bOwd6vjZ5oV23k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Y7/EmhYa6i3GEsi4Y7y5f9hDRN5qiF/ifdOoyJesEU=;
        b=LTob9BC24Cb+L1M6Q//JlEKskAS4/JQE8xSPGFazE7L7svFrwGTKBzBnqXYs92hO83
         q69JLn/qCUsEXW95mYDCOHVZcmRmZCU6FzuSqQjFy3UlGeunPMRKdObziXA7HhBhkE7s
         Im+4t4P34iU5uRKfHY9jAdwGtEqPNVuXU/z5RsmHnlxM6gRMGmQbqB5nQeduLHjJjF8Z
         A/UuWm95wpqUBsUQzWCghecnRPKIdHZsRFi9ysmnEKbc4I2iOrNebYbxZnf+TxpFgw6e
         MnDDgZrWgs6xFT6aGHRHuLRI+te/gAeKCbjpBvXH7Cq3xFv5qhBQ5MJlPdxM3p3fBl/X
         F/Zg==
X-Gm-Message-State: APjAAAVoQ8sdAoWQWi1cp+peSHxtgeyMEf7qRwn0C5twJU87yZrtxKvt
        hLqBDdKDJP3UUiadIf9GI4b6uQ==
X-Google-Smtp-Source: APXvYqxKOdcWT8/jMUFvp2VRjTE1nnN9wmqs4QauNiOZLRPkNmkmt/lH4FZJPsf7Of+VP8sB3rRqqA==
X-Received: by 2002:a17:902:da4:: with SMTP id 33mr4748129plv.209.1562857739978;
        Thu, 11 Jul 2019 08:08:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p1sm6929343pff.74.2019.07.11.08.08.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Jul 2019 08:08:59 -0700 (PDT)
Date:   Thu, 11 Jul 2019 08:08:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nadav Amit <namit@vmware.com>, Jiri Kosina <jikos@kernel.org>,
        Xi Ruoyao <xry111@mengyan1223.wang>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [GIT PULL] x86/topology changes for v5.3
Message-ID: <201907110806.9C79329@keescook>
References: <201907091727.91CC6C72D8@keescook>
 <1ad2de95e694a29909801d022fe2d556df9a4bd5.camel@mengyan1223.wang>
 <cb6d381ed7cd0bf732ae9d8f30c806b849b0f94b.camel@mengyan1223.wang>
 <alpine.DEB.2.21.1907101404570.1758@nanos.tec.linutronix.de>
 <nycvar.YFH.7.76.1907101425290.5899@cbobk.fhfr.pm>
 <768463eb26a2feb0fcc374fd7f9cc28b96976917.camel@mengyan1223.wang>
 <20190710134433.GN3402@hirez.programming.kicks-ass.net>
 <nycvar.YFH.7.76.1907101621050.5899@cbobk.fhfr.pm>
 <89EBC357-BEAC-4252-915F-E183C2D350C4@vmware.com>
 <20190711080134.GT3402@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711080134.GT3402@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 10:01:34AM +0200, Peter Zijlstra wrote:
> On Thu, Jul 11, 2019 at 07:11:19AM +0000, Nadav Amit wrote:
> > > On Jul 10, 2019, at 7:22 AM, Jiri Kosina <jikos@kernel.org> wrote:
> > > 
> > > On Wed, 10 Jul 2019, Peter Zijlstra wrote:
> > > 
> > >> If we mark the key as RO after init, and then try and modify the key to
> > >> link module usage sites, things might go bang as described.
> > >> 
> > >> Thanks!
> > >> 
> > >> 
> > >> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> > >> index 27d7864e7252..5bf7a8354da2 100644
> > >> --- a/arch/x86/kernel/cpu/common.c
> > >> +++ b/arch/x86/kernel/cpu/common.c
> > >> @@ -366,7 +366,7 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
> > >> 	cr4_clear_bits(X86_CR4_UMIP);
> > >> }
> > >> 
> > >> -DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
> > >> +DEFINE_STATIC_KEY_FALSE(cr_pinning);
> > > 
> > > Good catch, I guess that is going to fix it.
> > > 
> > > At the same time though, it sort of destroys the original intent of Kees' 
> > > patch, right? The exploits will just have to call static_key_disable() 
> > > prior to calling native_write_cr4() again, and the protection is gone.
> > 
> > Even with DEFINE_STATIC_KEY_FALSE_RO(), I presume you can just call
> > set_memory_rw(), make the page that holds the key writable, and then call
> > static_key_disable(), followed by a call to native_write_cr4().
> 
> Or call text_poke_bp() with the right set of arguments.

Right -- the point is to make it defended against an arbitrary write,
not arbitrary execution. Nothing is safe from arbitrary exec, but we can
do our due diligence on making things read-only.

-- 
Kees Cook
