Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F7EC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9618D206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vVfAGx1j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfGBODB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 10:03:01 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46051 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbfGBODA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 10:03:00 -0400
Received: by mail-qk1-f193.google.com with SMTP id s22so13995552qkj.12;
        Tue, 02 Jul 2019 07:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EpOO0LgQ0rvdUVXjo4gLJe9UVHPVTcCTFqX491FET28=;
        b=vVfAGx1jU5j+/G/3DyyXDcgOVlCke9Imj7QjpWlV46J5DubTI5Hr6Kqkho5gJJT+P6
         Mu5PZeYjTMzGLZKvxZgpsHtx7/epPWE+un1WO4s7fFdN/jY/wTbaRZRlYRtuJBX2Ccey
         0ryViQj1znwdHLCvfyNjh6S2xthNb9geyqTgRFtNw3tF7jP3I5dNYxpffw08gi8FJFEO
         m/+XGR93aNCTLrzCoShmQDLrUpubIPsByES4GU0arSPNcxld6tZ9LhDuDx5hrhBAJJtd
         l8gU8D7pG1XwQfJjuSJ82zieGXCWtUwAxmiDX390S584r885EYq4fh1fktqaxjqrMlgq
         kdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EpOO0LgQ0rvdUVXjo4gLJe9UVHPVTcCTFqX491FET28=;
        b=oTsEcd3Gn9rpO23MoDpFpjvGG+36bEZAd5L68W3Imr0zAk0555a2H3mLFl7hNcTaM3
         qxeENQH5JVeR07fdjgT1nHVkBTA1zaT4YYFxnnKAc/S+MCBveA4CNSjpbeyLlCNz59dp
         dA7GSTzAQZH1rOmCLjHTQN2S2CmmZgG7GZEcZAOTPmtqxW1zrmmvK+aIKPl77Z/NlAqn
         s0cCjNLNXQtpXmI4gUwtJHZanUR88VeTosgzSj52ucBy+/DY4kL3ayhePGljeMKep0vX
         jWNBVvA1tj+aFF0M4xPK5xTRw+5RoRAWONVqFoXUtP64qfAdBBShSKR8vDzpoLtLqTf2
         W5qA==
X-Gm-Message-State: APjAAAUVaqOPWRvOOqHgSrMZefqTulrHmK0NkZLBFc0zrLWa+rLv86h6
        rwhePIaDJkA3kHls9ZTgHmg=
X-Google-Smtp-Source: APXvYqzpXcje/3MXWSlcYg9rZ5SHv/lpd6mI6QrIE3CEOcd2uRqQ12IbI1AhpK6nsg5b0Sbl1fVfZA==
X-Received: by 2002:a37:6650:: with SMTP id a77mr26428586qkc.452.1562076179200;
        Tue, 02 Jul 2019 07:02:59 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id p23sm5724451qkm.55.2019.07.02.07.02.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 07:02:58 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D27F641153; Tue,  2 Jul 2019 11:02:55 -0300 (-03)
Date:   Tue, 2 Jul 2019 11:02:55 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?iso-8859-1?Q?Andr=E9?= Goddard Rosa <andre.goddard@gmail.com>
Subject: Re: [PATCH 23/43] tools lib: Adopt skip_spaces() from the kernel
 sources
Message-ID: <20190702140255.GC15462@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
 <20190702022616.1259-24-acme@kernel.org>
 <20190702121240.GB12694@krava>
 <20190702134603.GA15462@kernel.org>
 <20190702134815.GB15462@kernel.org>
 <20190702135432.GC12694@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702135432.GC12694@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 02, 2019 at 03:54:32PM +0200, Jiri Olsa escreveu:
> On Tue, Jul 02, 2019 at 10:48:15AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Jul 02, 2019 at 10:46:03AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Tue, Jul 02, 2019 at 02:12:40PM +0200, Jiri Olsa escreveu:
> > > > this breaks objtool build, because it adds _ctype dependency via isspace call
> > > > patch below fixes it for me

> > > Thanks for  spotting this, I'll have it in my next pull request.

> > I'm adding a Signed-off-by: you, ok?

> sure, I did not post full patch, because I thought you might thought
> of some other solution

I think this is it for now, at some point we need to make a
tools/lib/liblinux.{a,so} to group what we're getting from the linux
lib/ directory to adapt and use in tools/ living code and then, as a
a starter, tools/objtool/ and tools/perf/ should link with it.

- Arnaldo
