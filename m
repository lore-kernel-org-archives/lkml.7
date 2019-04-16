Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8330C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7023E20880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q1UYs2i2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730671AbfDPXAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 19:00:25 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34473 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbfDPXAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 19:00:24 -0400
Received: by mail-vs1-f65.google.com with SMTP id t78so12545064vsc.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 16:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=CJLH9Riaz1ZW2p6BviyE1C6hzGVgv3wYjT+Z8vtXe7Y=;
        b=Q1UYs2i2EDW4u4rTVLGXBjIbWVS9F7GJ/HVDkLdAFMqGUgQLUxVljfRAjIXyd/KeAr
         jfXHhVqHdfrRnWAy6UkHKw5vXKbHelCPJuPPPTy7N83QWtgiuKY+c9NAN/GNzk9HrVSw
         FGxaRLTxNRJ9CEiHjGQbO9V2MyEnoJvj394ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=CJLH9Riaz1ZW2p6BviyE1C6hzGVgv3wYjT+Z8vtXe7Y=;
        b=lEpoLFEpHNQjLaJZgXPNQqHWHST6IyUS3qj6EM9IfSAkIJnsATjxLyz5ASxnsaipRY
         WPuknF0k6mmLw6pWhDpFlXjiQRRWaxRo9cXr1eOy8ovyJ1PEw87uPal5o8WsOiXa3ujy
         aZHVhqlSmhNj3x1x5PFkpq1KIJXX9s02iYLl5Y4h1dvowC43co8d7aph7He57IhprXMS
         Bp2TIngwOdYYIZgkM6ZFm9FZn0O7FWm0fjh7QI1CHps1DoRdWAX9Qnhmpm5PlDq7I21C
         /udUVTOfmWaJAlQqqnwlAnRi+WUinAg3/epxhQDAalqEI+RhuJ9C90bP3gKvZq2B4z8+
         6K7w==
X-Gm-Message-State: APjAAAVOb6wt09vG9WOwk3hCueS0gSDKnaaVXj3XPqZzxo1oQLNoCNDf
        T3X80a3wisoj1qIJ0br76ggeC7kA2Vc=
X-Google-Smtp-Source: APXvYqwiDBOApM8Tv8DtEzvqDIILkOuFMwOnC61NK9PmEqL71/mtghNzOP1WUdD7O0D/cCejcAMUpA==
X-Received: by 2002:a67:8010:: with SMTP id b16mr47237767vsd.189.1555455623096;
        Tue, 16 Apr 2019 16:00:23 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id y1sm56932539uai.0.2019.04.16.16.00.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 16:00:21 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id s2so12535003vsi.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 16:00:21 -0700 (PDT)
X-Received: by 2002:a67:1345:: with SMTP id 66mr45079098vst.30.1555455621141;
 Tue, 16 Apr 2019 16:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20181011225421.GA21093@beast> <20181012142902.GD2420@thunk.org>
 <CAGXu5jLqg5sf=oCZ_mB+ozTF=kKS7y4SNBKb96a6sBR07BprNg@mail.gmail.com>
 <CAGXu5jJwLSRM4y-SK2d600ha2-ui8ibaGQa_qws8kmP=Yu1+oA@mail.gmail.com> <20190416160948.GE3004@mit.edu>
In-Reply-To: <20190416160948.GE3004@mit.edu>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 16 Apr 2019 18:00:09 -0500
X-Gmail-Original-Message-ID: <CAGXu5jLNUTiLo4oZC257PDW+vc2pCf=CPgj0nCP6Z005-=d8JA@mail.gmail.com>
Message-ID: <CAGXu5jLNUTiLo4oZC257PDW+vc2pCf=CPgj0nCP6Z005-=d8JA@mail.gmail.com>
Subject: Re: [PATCH] random: Move rand_initialize() earlier
To:     "Theodore Ts'o" <tytso@mit.edu>, Kees Cook <keescook@chromium.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 11:09 AM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Mon, Apr 15, 2019 at 10:46:34PM -0500, Kees Cook wrote:
> > On Fri, Oct 12, 2018 at 9:45 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Fri, Oct 12, 2018 at 7:29 AM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> > > > On Thu, Oct 11, 2018 at 03:54:21PM -0700, Kees Cook wrote:
> > > >> Right now rand_initialize() is run as an early_initcall(), but it only
> > > >> depends on timekeeping_init() (for mixing ktime_get_real() into the
> > > >> pools). However, the call to boot_init_stack_canary() for stack canary
> > > >> initialization runs earlier, which triggers a warning at boot:
> > > >>
> > > >> random: get_random_bytes called from start_kernel+0x357/0x548 with crng_init=0
> > > >>
> > > >> Instead, this moves rand_initialize() to after timekeeping_init(), and moves
> > > >> canary initialization here as well.
> > > >>
> > > >> Note that this warning may still remain for machines that do not have
> > > >> UEFI RNG support (which initializes the RNG pools durting setup_arch()),
> > > >> or for x86 machines without RDRAND (or booting without "random.trust=on"
> > > >> or CONFIG_RANDOM_TRUST_CPU=y).
> > > >>
> > > >> Signed-off-by: Kees Cook <keescook@chromium.org>
> >
> > Hi Ted! Did this get lost? This has come up again, and I don't see it
> > having landed anywhere yet. Can you take this?
>
> Yeah, sorry, it got lost; my bad.  I'll take it and push it out at the
> next merge window.

Awesome; thanks!

-- 
Kees Cook
