Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB42BC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98CBA2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ambiewkc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfFTR6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 13:58:11 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42391 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfFTR6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:58:10 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so2082107pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 10:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S2gqNASMdYK2WX/SCojHs3iwdhiVO/ELWHI9nIiuc08=;
        b=AmbiewkcaBZfbv3X6k0K9MkP95lI+TEtZi+vGAdEh+o40lZrmh5S6BZVYsUH2ICrSF
         tpGdVMyZeNnqbpPHBk9WWVFcJMCTUsCjZ2KI4VFEydIFPBh8yvw0ay8avXt28l/r3kNI
         4EFjqRRfNz4dNjG3sFQGvIQS4qDDYucB0v3jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S2gqNASMdYK2WX/SCojHs3iwdhiVO/ELWHI9nIiuc08=;
        b=L+mEH/3OaZ+21IiTXzYldQJPFnwfz279J3pYk4UyPkGFs7ARc1Cwz7iPy4ZV1Gwvi/
         UCyhaU9zzFmjv0qGVfoc6+VgRe/n/0Oha1skfUn7uOLNGD1vpmnz5YJiAPsGcm/LBkeY
         xtnIcL7PmNtTxmsiZmyLjApPrCnDpeYzRZGh5WCGmvjPnbjqZ3Ic2ZQ/hVgcl3P6JhjZ
         j7upNY49LManolpPq/l3Kaom8TlZpkyLY42mjiPrSXis2PKPXmL6bXSLDIt7RgTrTuz2
         jpiNgg41c6Ch/vjTbx7t//0E0aNco8jcScCklOpEB0I9EgP1I/fWlqdgUtGWEnmuxN1j
         7usA==
X-Gm-Message-State: APjAAAXAT3i7RukmFAVV7o6kpSB9QZf1QkiuRKpTYDNUfCi1QOu++RN9
        ahI0L2UO9LsY3hy5c7KB6wRKVL8YgVM=
X-Google-Smtp-Source: APXvYqz+/nctrhTKu2rrQH0p8RYodLUvmv9QWgIYE5zMalFX2xFyZLCGds0IQDjcEJPnz2dR7N7FHA==
X-Received: by 2002:a63:5247:: with SMTP id s7mr13372297pgl.29.1561053490021;
        Thu, 20 Jun 2019 10:58:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t8sm144231pfq.31.2019.06.20.10.58.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 10:58:09 -0700 (PDT)
Date:   Thu, 20 Jun 2019 10:58:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ross Zwisler <zwisler@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc:     Johannes Hirte <johannes.hirte@datenkhaos.de>,
        Klaus Kusche <klaus.kusche@computerix.info>, bp@suse.de,
        x86@kernel.org, samitolvanen@google.com,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@google.com>,
        Ross Zwisler <zwisler@google.com>
Subject: Re: [PATCH] x86/build: Move _etext to actual end of .text
Message-ID: <201906201042.3BF5CD6@keescook>
References: <502d5b36-e0d0-ffcc-5dd4-35db9d033561@computerix.info>
 <20190609184013.GA11237@probook>
 <CAOxpaSXKXRcZi0KnQz_6SxajZ6Nv61Bjm5xmG0Ydw3Madv0-tQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOxpaSXKXRcZi0KnQz_6SxajZ6Nv61Bjm5xmG0Ydw3Madv0-tQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 12:37:11PM -0600, Ross Zwisler wrote:
> On Sun, Jun 9, 2019 at 1:00 PM Johannes Hirte
> <johannes.hirte@datenkhaos.de> wrote:
> > On 2019 Jun 09, Klaus Kusche wrote:
> > > Hello,
> > >
> > > Same problem for linux 5.1.7:
> > > Kernel building fails with the same relocation error.
> > >
> > > 5.1.5 does not have the problem, builds fine for me.
> > >
> > > Is there anything I can do to investigate the problem?
> > >
> >
> > Please try linux 5.1.8. The problematic patch was reverted there.
> 
> I'm having this same issue with v5.2-rc5 using an older version of gcc
> (4.9.2).  If I use a more recent version of gcc (7.3.0) it works fine.
> 
> Reverting this patch allows gcc v4.9.2 to build kernel v5.2-rc5 successfully.
> 
> You said in this chain that you were reverting this patch in stable
> kernels.  Are you going to revert it in tip-of-tree as well?

My original rationale was that we shouldn't break old toolchains on
old kernels (i.e. if a stable kernel built before it should continue to
bulid). For the latest kernel it was fixing a future problem and
regularizing the linker script (other architectures already do it in
this style), however, it seems to not only be an old gcc issue, but also
a Gold linker issue. Building with LD=ld.gold blows up on a modern gcc
too:

$ gcc --version
gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
...
$ ld.gold --version
GNU gold (GNU Binutils for Ubuntu 2.30) 1.15
...
$ make LD=ld.gold ...
...
Invalid absolute R_X86_64_32S relocation: _etext

Ingo, seems like this should be reverted. What do you think?

-- 
Kees Cook
