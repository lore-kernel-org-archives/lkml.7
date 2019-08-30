Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDE2C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 19:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FDDC23430
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 19:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mj6S2MUD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbfH3Tsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 15:48:53 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:32808 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfH3Tsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 15:48:52 -0400
Received: by mail-qk1-f193.google.com with SMTP id w18so7252092qki.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 12:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mrmtHfKsF7k4Ey3JAyc4Hsn5TajQLncbKq8guatQ088=;
        b=mj6S2MUDy42PNrcTwWa1mK3Mgh0z35qW74iVTPR+Hhs7qa2M/dkxP15ygsp9ladFzk
         TTsZ+xxlNWMs7TtGtWReIKMcuUAO5hNhC3cKQd1Nyg3h87uwLqJLX0vLmrmdsWYkbbBq
         3cEZnLv8Q5f6DGlFsZAqIgokAo7RniisFLSYgBUH35NWh39Npqei6s/9uWNfYoxmVzuX
         85hZ8fkZejEk1dxMUqSPJ0fLJcGRrnmWESj+IR7aOvL4wul8mEdGXctf1qotYLahygW9
         ap6Sm7saUsaPpaIjvxyqRj+XsgZ1O+78icSEx+m6ZKlms0p5r842NEkP4W4okqfV5eA+
         K3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mrmtHfKsF7k4Ey3JAyc4Hsn5TajQLncbKq8guatQ088=;
        b=Gl+4Kw48vAb3FSDrzHL4h6YggJ5f1puVuAh20Kl2fuIgIW79UW67zaxPivKdbv6Ze5
         YAq6qKmGCeH4JQ+RtrHV166Pg/qCQNBbKRZNA/BvZ9bxwlcS4WjSJlZ2zBjqt4bgR6O0
         YcP1FHsyP+1cuL7ntMsS4UYlpbwwbmJ0Kyg1nERVTGIWoh7LHhkG+vHckHJRt4ZmAbqI
         hOvVNEa37cA9SXxZR7kdv0jKurInMeWFhp9pQ9dUtW9nNJgfOj7QMdvwHmzCqKt0a1wy
         w/lNuv10RE9I9HhkLlGtt+X4hzTN932WbcZTe3wQjoPywzgNbRx8kezqHp8AfqHVS6Sy
         uBWg==
X-Gm-Message-State: APjAAAV2rLilu6JGk6TuJ7ocxsjRiXEpP9qUQel945HFfQSBAomDEs0t
        xTtR80IcfRluADzI6KdRZhg=
X-Google-Smtp-Source: APXvYqytlF0VLZOctSk4hU7jRUubzHLmqZLxkl9Adn+SFMasrkXnECyyHTZBkU1xz2g35pXSMYqNBg==
X-Received: by 2002:a37:4ac8:: with SMTP id x191mr17351381qka.400.1567194531676;
        Fri, 30 Aug 2019 12:48:51 -0700 (PDT)
Received: from quaco.ghostprotocols.net (187-26-100-20.3g.claro.net.br. [187.26.100.20])
        by smtp.gmail.com with ESMTPSA id y25sm2855606qtf.83.2019.08.30.12.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 12:48:50 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C05F941146; Fri, 30 Aug 2019 16:48:45 -0300 (-03)
Date:   Fri, 30 Aug 2019 16:48:45 -0300
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 0/4] objtool,perf: Use shared x86 insn decoder
Message-ID: <20190830194845.GI28011@kernel.org>
References: <cover.1567118001.git.jpoimboe@redhat.com>
 <20190830184020.GG28011@kernel.org>
 <20190830190058.GH28011@kernel.org>
 <20190830193109.p7jagidsrahoa4pn@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830193109.p7jagidsrahoa4pn@treble>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 30, 2019 at 02:31:09PM -0500, Josh Poimboeuf escreveu:
> On Fri, Aug 30, 2019 at 04:00:58PM -0300, Arnaldo Carvalho de Melo wrote:
> > I.e. we need to make sure that it always gets the x86 stuff, not
> > something that is tied to the host arch, with the patch below we get it
> > to work, please take a look.
> > 
> > Probably this should go to the master copy, i.e. to the kernel sources,
> > no?
> > 
> > That or we'll have to ask the check-headers.sh and objtool sync-check
> > (hey, this should be unified, each project could provide just the list
> > of things it uses, but I digress) to ignore those lines...
> > 
> > I.e. we want to decode intel_PT traces on other arches, ditto for
> > CoreSight (not affected here, but similar concept).
> > 
> > will kick the full container build process now.
> 
> Interesting, I didn't realize other arches would be using it.  The patch

Yeah, decoding CoreSight (aarch64) hardware traces on x86_64 should be
as possible as decoding Intel PT hardware traces on aarch64 :-)

> looks good to me.
> 
> Ideally there wouldn't be any differences between the headers, but if
> that's unavoidable then I guess we can just use the same 'diff -I' trick

I'll go with this now, but...

> we were using before in the check script(s).

Masami? What do you think of applying the patch to the main kernel
sources so that building a decoder for x86 on any other arch becomes
possible?

- Arnaldo
