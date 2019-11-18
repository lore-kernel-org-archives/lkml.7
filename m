Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E186C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB0B2071C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574064227;
	bh=ljFTozo0gwpQjJFCChDl+Z9GI1FvNaVpNkYRC3JPChE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IoVYAkfWO5wq6BuxWarKsl9R4mygg4UaBN7ulIlHpfFql+o631waEvC3jbX/6HYLR
	 jy6UW4M3L0zdsA5JAVmtdPxvjxK4iEDHay+H4nTEWTLUeednOmXxERjHAXN/1KVHmD
	 a5HMWMmiIR/kbsCQFryfMMSaKdgCkKVeTGOdgLbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfKRIDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 03:03:45 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33634 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfKRIDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 03:03:45 -0500
Received: by mail-wr1-f65.google.com with SMTP id w9so18246537wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 00:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D8ZHyfdnNZoxlHq4H5CPfT+mJBnr0mBGZIvRSoVcmck=;
        b=Jz243xXn8J6lOJvHL2ya9NEbeiYV3qjHIEPanTHw7g9eLN03dXgytb6PymXYfxBkvv
         y3okdCKUR6RnrrKbBINkmJDVFj/OhzCsteu8a2g5Ik2ARr481SCsV5DEH47U+wzq3mR6
         ulwy4SK4R+AlP4JZ7aXZwh+/4wyClLjhvUumrgVhMiRx5oLr8NQyk1pEaGncxpPcCK4a
         v952nF9/SWkTO8rAywQpl45BYF7fQ/hQkt/uGo9NouDnHs8qdNXK5+m/IcgmR9aYikKe
         VBk+hprh7Ni6aa8pLxbNyswIHx0gcogn8qsW4xpSeD7pI2n7m6y6OOSVuymk5833+dWO
         jNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=D8ZHyfdnNZoxlHq4H5CPfT+mJBnr0mBGZIvRSoVcmck=;
        b=gICH2jcl2ogF8poU3PAJWWHiEfr41r7Y7cjWOzomcmFsfKRsZFTaCkHRsdjmVR2oUj
         /xVOe2C27p0F28R1DCj8mzOuG2+DRner16HJpO+YaooSilVu4IL57MZJgkirTew3yVwm
         phI48/isx7BDEnPUgP3P1WA8ezaDFluBlkdmTV40G1RwpTrqXAbXotSUuDhg7w4BH/Rl
         W27ZR5d5gamyBarSit15e5GUTbEeMK+909fD8pDYDYid8rqrvoWH7LCivF6uybjtIHHQ
         4t6J55Tcm51lZISEfXkoatbM2kSCrTK8zT6oGjahkOt0zW/7brCWCW5XH/P10oGXDM94
         yCdA==
X-Gm-Message-State: APjAAAUqml41N1zvU0S6uGIyqn+ukh52j/l1aHCfEwrJPu0IM0M/EEOq
        TB4cA/Je/kfdOgKiVYGN+WA=
X-Google-Smtp-Source: APXvYqxOBfj1xQppNrVBXOHyI1/gaqhPZ155qCiihoCgpMSk4p8A2tgqQkvFmLztDE4nK2uQK5ty6A==
X-Received: by 2002:a5d:5444:: with SMTP id w4mr27480496wrv.164.1574064221989;
        Mon, 18 Nov 2019 00:03:41 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id d11sm22159273wrn.28.2019.11.18.00.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 00:03:41 -0800 (PST)
Date:   Mon, 18 Nov 2019 09:03:39 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] scheduler fixes
Message-ID: <20191118080339.GA48190@gmail.com>
References: <20191116213742.GA7450@gmail.com>
 <ab6f2b5a-57f0-6723-c62f-91a8ce6eddac@arm.com>
 <20191117094549.GB126325@gmail.com>
 <4e4b0828-abba-e27d-53f6-135df06eba1a@arm.com>
 <CAHk-=wiEz7kG8YSbmAAALdP3Vnna_f4+LY4TPM0NQczeh3mviQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiEz7kG8YSbmAAALdP3Vnna_f4+LY4TPM0NQczeh3mviQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, Nov 17, 2019 at 2:20 AM Valentin Schneider
> <valentin.schneider@arm.com> wrote:
> >
> > AFAIUI the requirement for the enum type is that it has to be an int 
> > type that covers all its values, so I could see some funky 
> > optimization (e.g. check the returned value is < 512 but it's assumed 
> > the type for the enum is 8 bits so this becomes always true). Then 
> > again we don't have any explicit check on those returned values, plus 
> > they fit in 11 bits, so as you say it's mostly likely inconsequential 
> > (and I didn't see any compile diff).
> 
> Gcc can - and does - narrow enums to smaller integer types with the 
> '-fshort-enums' flag.

Good point - but at least according to the GCC 9.2.1 documentation, 
-fshort-enums is a non-default code generation option:

   Options for Code Generation Conventions

       These machine-independent options control the interface 
       conventions used in code generation.

       Most of them have both positive and negative forms; the negative 
       form of -ffoo is -fno-foo.  In the table below, only one of the 
                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
       forms is listed---the one that is not the default.  You can figure 
       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
       out the other form by either removing no- or adding it.

   [...]

       -fshort-enums

           Allocate to an "enum" type only as many bytes as it needs for 
           the declared range of possible values.  Specifically, the 
           "enum" type is equivalent to the smallest integer type that 
           has enough room.

           Warning: the -fshort-enums switch causes GCC to generate code 
           that is not binary compatible with code generated without that 
           switch.  Use it to conform to a non-default application binary 
           interface.

Unless this option is used AFAIK GCC will treat enums as "int" if at 
least one enumeration constant is negative, it's "unsigned int" 
otherwise.

The only current use reference to the non-standard -fshort-enums option 
within the kernel source is the Hexagon arch, which (seemingly 
unnecessarily) disables the option:

  arch/hexagon/Makefile:KBUILD_CFLAGS += -fno-short-enums

That flag came with the original Hexagon commits, 8 years ago:

  e95bf452a9e22   (Richard Kuo    2011-10-31 18:55:58 -0500       10)# Do not use single-byte enums; these will overflow.
  e95bf452a9e22   (Richard Kuo    2011-10-31 18:55:58 -0500       11)KBUILD_CFLAGS += -fno-short-enums

Maybe they had a GCC build where it was on by default? Or GCC changed 
this option sometime in the past? Or it's simply an unnecessary but 
harmless code generation flag out of paranoia?

Out of curiosity I searched all the historic trees, none ever made use of 
the -f*short-enums option, so I don't think this is a GCC option we ever 
actively utilized or ran into.

> However, in practice nobody uses that, and it can cause interop 
> problems. So I think for us, enums are always at least 'int' (they can 
> be bigger).

Yeah, the GCC documentation specifically warns that it breaks the ABI: 
the size of structs using enums will generally change from 4 bytes to 1 
or 2 bytes, and function call signatures will change incompatibly as 
well.

BTW., -fshort-enum looks like a bad code generation option to me, on x86 
at least, because it will also use 16-bit width, which is generally a bad 
idea on x86. If it limited itself to u8 and 32-bit types it could even be 
useful.

Also, I wouldn't be surprised if the kernel ABI broke if we attempted to 
use -short-enum, I bet there's a lot of accidental reliance on 
enum=int/uint.

> That said, mixing enums and values that are bigger than the enumerated 
> ones is just a bad idea
> 
> It will, for example, cause us to miss compiler warnings (eg switch 
> statements with an enum will warn if you don't handle all cases, but 
> the 'all cases' is based on the actual enum range, not on the 
> _possible_ invalid values).

That's true. Will check whether we can do something about improving the 
affected uclamp data structures.

Thanks,

	Ingo
