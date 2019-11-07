Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E9CC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35EE32166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUS/BWOo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388028AbfKGMGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 07:06:50 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33450 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfKGMGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 07:06:49 -0500
Received: by mail-qk1-f195.google.com with SMTP id 71so1747166qkl.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 04:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ut33lTd+bs8Wz+qNBreL2KP/eGD0cRKA6+sRfDain58=;
        b=UUS/BWOoKdv92simHAjU0rbpLeFTOtR79KozGwf4SSe6hr9uddS5O4AcYwTVuHdOz0
         gFJ/6LO8+a4OFT6VfiVfZmHnhohacQPKrSYhVlooFPvPauhtRhWmETh9SjQHtBVUd/tf
         fU2xH5/bWFPGgx2azdxiu7SfCK1x2h3hZScURycY0vi4aKZrsfQ4yky+ytRee8D6xMaX
         cEQOVEvmw2btwt+oJhH++wrv7V/lz4lLSkQ0LtnjKFZ0C6h+v2rLOxpTA45DqrbRaVGH
         ocIdnX27+gmD1XLBKrs02zTXqY0gjoJNneYbjZMoIexD706u/axq1UiNR8srke7/zMTz
         RQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ut33lTd+bs8Wz+qNBreL2KP/eGD0cRKA6+sRfDain58=;
        b=FxOw5Lq12wZBZW4qWPlIMUTnak50g0i4szPXfa4bOYuQ1YSCXD0nGId29WTxN/L4kZ
         ZhCAjSBWcwSuo6OjIRz209hdZO++z19V4qhEywVl/347ctuJ+zNI0PnAaS7FHx0xBKUn
         tNOCzI6q9PZC54gZ5UAuYqwZiLJChOPpAGqsTolNRhgZM86y0UGr+rToqz4p98kl4EhB
         NkCGAemRHJmI0TLHtvgaUGoImDsF1L0Etgg8XqYveWCJbqmaxk9qU7iLpaxM20M31i23
         5PGj07I2UlSYDULimVpfKUtTpSR4tEBegnkb7Rv2xlYwHgF3Om7a0SPCTLS0dXhla1Lz
         Fi5w==
X-Gm-Message-State: APjAAAXBaKI9hoLky4ds8IjjdwiqYtRF2p3QfbK4D4/GmK0iHiCclw6L
        zxV1vmKB1msveGtWnKFG7HE=
X-Google-Smtp-Source: APXvYqzAm+is0FBAMipnzM1bON0Y/8EfbeobYSb+HkXy8QiGVEFefywku1PIvgZQuCHHoGYyO0m2gg==
X-Received: by 2002:a05:620a:13e2:: with SMTP id h2mr2487999qkl.114.1573128407008;
        Thu, 07 Nov 2019 04:06:47 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id p66sm1154730qkd.1.2019.11.07.04.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 04:06:46 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9BF0440B1D; Thu,  7 Nov 2019 09:06:43 -0300 (-03)
Date:   Thu, 7 Nov 2019 09:06:43 -0300
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH v2] perf tests: Fix out of bounds memory access
Message-ID: <20191107120643.GA11372@kernel.org>
References: <20191107020244.2427-1-leo.yan@linaro.org>
 <20191107094226.GC14657@krava>
 <20191107102029.GA32679@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107102029.GA32679@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 07, 2019 at 06:20:29PM +0800, Leo Yan escreveu:
> On Thu, Nov 07, 2019 at 10:42:26AM +0100, Jiri Olsa wrote:
 
> [...]
 
> > > To fix this issue, we will use evlist__open() and evlist__close() pair
> > > functions to prepare and cleanup context for evlist; so 'evsel->id' and
> > > 'evsel->ids' can be initialized properly when invoke do_test() and avoid
> > > the out of bounds memory access.
 
> > right, we need to solve this on libperf level, so it's possible
> > to call mmap/munmap multiple time without close/open.. I'll try
> > to send something, but meanwhile this is good workaround
> > 
> > Reviewed-by: Jiri Olsa <jolsa@kernel.org>
 
> Thanks for reviewing, Jiri.
 
> You are welcome to send us the fixing patches, I am glad to test it on
> qemu_arm.

Thanks, applied after adding:

Fixes: ee74701ed8ad ("perf tests: Add test to check backward ring buffer")
Cc: stable@vger.kernel.org # v4.10+

Please consider doing it next time,

- Arnaldo
