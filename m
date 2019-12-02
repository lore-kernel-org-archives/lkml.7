Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B00C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0968C20637
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSfk1Fo+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfLBSew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 13:34:52 -0500
Received: from mail-qt1-f177.google.com ([209.85.160.177]:40553 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbfLBSev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 13:34:51 -0500
Received: by mail-qt1-f177.google.com with SMTP id z22so752127qto.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 10:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MqhHi4rCuh6TvqrsVK79PQTZcVaqrX9peBZXHH9YOKU=;
        b=KSfk1Fo+iX32GznlIZ8cBnBv6JOoGV0L+WXcCCIJj7e75u0PHYW1KbKpWYbrYZrvPj
         nl5JK4ScwOb5u+SsNL874pXW7e0dY1VyIW69UbshDULcXILLouBYOf7RrMOBDZMHAu6S
         sUo7+ny3koz01hiouB3u3AJtoe2o7OoafbQ7ipU+akYi/ORB3bG/38/wHuZh6DYx1qNW
         ZbJ9Hfn13YLlJuog/Dkn+EN8fHOyOA/wN4j0YAGDyBFPL3mCXiagipbVBvCMQaQRcFNJ
         TDrJ3mQQ5OfLlHDehGxBynHICcb9EOtVFeBLrUqH4i7CXKkhZUc4UFEGmZ02hajQANZ+
         3KjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MqhHi4rCuh6TvqrsVK79PQTZcVaqrX9peBZXHH9YOKU=;
        b=cNZn5gZ8CFyi8r13b1MMdD614BKmIFOmZPtO05OTiRpYvlwY5H85WOdsxeuQzYtCJ2
         vtKofT0tub7+rBFEprGmfI7AAyxhejISZj9GJ92y0aDxiGITwzuy85/vnVxsV5CGfof6
         Zf4THtUFl3kTYxRlZvAwnkkZNJdTE6YwYEtjUe+ztVL7vvKZzwkiHCmRzRHZ26jwUB9I
         Fy9xHrhDPVPGlwYdw1PITB4QTpuSSlfEuPFLyLkoiL2D0wiOQpiIANsCkL2RGCRg7plc
         CJnWUbjohegZN+/6AC5lNBRqwI3OfknutGXigLTrhiEuTpgRJnEH2a802gfuF56E5urf
         dFsg==
X-Gm-Message-State: APjAAAU8vPy+LFdaxHhdT56OkKT+d+lJ2z3ogWXvTlHZcI/7LL6h7i/v
        92q7irQfyjGpMI6x2/VVQkg=
X-Google-Smtp-Source: APXvYqzBuHCdkxgehb7X+eDXke0CbSH+9Y+e3slwvOpECAsa3UpJf2+6SC3H7hd6NxHsA6OGutNIKQ==
X-Received: by 2002:ac8:614a:: with SMTP id d10mr754528qtm.373.1575311690621;
        Mon, 02 Dec 2019 10:34:50 -0800 (PST)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id w128sm217601qkb.9.2019.12.02.10.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 10:34:49 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 713C3405B6; Mon,  2 Dec 2019 15:20:32 -0300 (-03)
Date:   Mon, 2 Dec 2019 15:20:32 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>, Leo Yan <leo.yan@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf jit: move test functionality in to a test
Message-ID: <20191202182032.GF4063@kernel.org>
References: <20191126235913.41855-1-irogers@google.com>
 <20191127152328.GI22719@kernel.org>
 <20191127160558.GM22719@kernel.org>
 <CAP-5=fVhXvMFtGU18-TMt29BsuZNySZ8sPvj_3r7GGsfZLPvuA@mail.gmail.com>
 <20191128131928.GD4063@kernel.org>
 <CAP-5=fWYUF7fnvVX1pDeTFg1u7Mfe9=1+E5zBiUX3QGTp2wDHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWYUF7fnvVX1pDeTFg1u7Mfe9=1+E5zBiUX3QGTp2wDHw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 02, 2019 at 09:30:19AM -0800, Ian Rogers escreveu:
> On Thu, Nov 28, 2019 at 5:19 AM Arnaldo Carvalho de Melo
> > But I'll defer this for later, not to hold what I have too much, after
> > my next pull req I'll revisit this, if you haven't found a fix by then
> > :-)

> > The current patch is below, with my fixes, and looking at it again it
> > seems its just to replace that HAVE_LIBELF_SUPPORT with HAVE_JITDUMP,
> > will confirm that later, after sending the pull req to Ingo.
 
> Your fix sounds correct, I should work on getting a build test setup.
> It sounds like you have it covered but if you need me to do anything
> let me know.

Right, everything seems to be in good shape now and should go Ingo's way
soon.

- Arnaldo
