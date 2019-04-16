Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014D7C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCFEE20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbfDPQLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:11:13 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43657 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728667AbfDPQLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:11:12 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x3GG9mp1023748
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Apr 2019 12:09:49 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2C4C3420497; Tue, 16 Apr 2019 12:09:48 -0400 (EDT)
Date:   Tue, 16 Apr 2019 12:09:48 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Tobin C. Harding" <me@tobin.cc>, Arnd Bergmann <arnd@arndb.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] random: Move rand_initialize() earlier
Message-ID: <20190416160948.GE3004@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Tobin C. Harding" <me@tobin.cc>, Arnd Bergmann <arnd@arndb.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20181011225421.GA21093@beast>
 <20181012142902.GD2420@thunk.org>
 <CAGXu5jLqg5sf=oCZ_mB+ozTF=kKS7y4SNBKb96a6sBR07BprNg@mail.gmail.com>
 <CAGXu5jJwLSRM4y-SK2d600ha2-ui8ibaGQa_qws8kmP=Yu1+oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJwLSRM4y-SK2d600ha2-ui8ibaGQa_qws8kmP=Yu1+oA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 10:46:34PM -0500, Kees Cook wrote:
> On Fri, Oct 12, 2018 at 9:45 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Fri, Oct 12, 2018 at 7:29 AM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> > > On Thu, Oct 11, 2018 at 03:54:21PM -0700, Kees Cook wrote:
> > >> Right now rand_initialize() is run as an early_initcall(), but it only
> > >> depends on timekeeping_init() (for mixing ktime_get_real() into the
> > >> pools). However, the call to boot_init_stack_canary() for stack canary
> > >> initialization runs earlier, which triggers a warning at boot:
> > >>
> > >> random: get_random_bytes called from start_kernel+0x357/0x548 with crng_init=0
> > >>
> > >> Instead, this moves rand_initialize() to after timekeeping_init(), and moves
> > >> canary initialization here as well.
> > >>
> > >> Note that this warning may still remain for machines that do not have
> > >> UEFI RNG support (which initializes the RNG pools durting setup_arch()),
> > >> or for x86 machines without RDRAND (or booting without "random.trust=on"
> > >> or CONFIG_RANDOM_TRUST_CPU=y).
> > >>
> > >> Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Hi Ted! Did this get lost? This has come up again, and I don't see it
> having landed anywhere yet. Can you take this?

Yeah, sorry, it got lost; my bad.  I'll take it and push it out at the
next merge window.

      	     	    	     	   	- Ted
