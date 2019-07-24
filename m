Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1354BC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA29214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5aKnd5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfGXNuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 09:50:46 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:34111 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfGXNuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 09:50:46 -0400
Received: by mail-qk1-f180.google.com with SMTP id t8so33789258qkt.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 06:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S+B2gVLJtMUBm3asTbNSqVjrt+57LbpLAbR6CL8mWkw=;
        b=G5aKnd5lbKhLGaFVNOtzXvNL4nqhhQs+wLvTfrZ/N1OcPlpWrm1uxwJsqlY1zpDhPL
         DI3BDZSGlMw3REAmde+/VtdJ3jJsqjBEpUO7ed4YYcsJm5sHLTKqV5RmdQQTeIYfyiQT
         Dikc6/cT0s8Yv0n1GK5m130ZKvBR57bT8qDHIRsGfUSOZppcVfGc4/2yl5+79SPgTghO
         l/0hrQHZLN6W5W2Q6vUvcrtItDanq8mlD/m9qCQvlOX8EITxqbtuQaI02tCl/OPTU5RS
         2mpDH+0FZYpwvrHukYrF8kIpuJCqRv8PvBN1OgkU7gNGL8kT1ZSV+TG7pAPxK+nMo3Y9
         gR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S+B2gVLJtMUBm3asTbNSqVjrt+57LbpLAbR6CL8mWkw=;
        b=hCKrvzZmgBgJrZGpJ1AAQuoAs/Ks17nonFOR4BLDQ01Gw3IUHjxOnD+vbrPfvwLwe7
         RH0FftFMyPFJdvQ3rp7O24l6/p44Mom4QE/SzMNbWnLQdWXS4y/pTXZ9I5Dpf8k2jTZG
         DxPTfQSBDjipEmuIK3nrsRkuZiHFSpUdSpePe5UyodBG+q5Res6UUEKZRZ9w8xlUfOMd
         VkxwxHh3bfroirxLYPqhZdcEu0Kr6uagUk79ebNWp6KDniVF4jZ/P7dqyErNcFKMDA6T
         +TviJHy/0SB1LXD6kaq3x4eK4m5fbmoXmim+sfwoWKGyXCTBahSjOu5XYrVvMyN4Apdm
         XKag==
X-Gm-Message-State: APjAAAU7AWrjqjKW2IZqAkRVTP7GGl5Nd/tJ92ymYq9Us4LwhzEIHFib
        MSNtzozs3LfAN3kPl2nZg7Q=
X-Google-Smtp-Source: APXvYqzIPx9rKpu0YusLlt4n80Mko6pj8tTZ5Qp4AwVPQrNYlwIxXKZ/t71QQYjgmGw67lAbGluS9A==
X-Received: by 2002:a37:76c5:: with SMTP id r188mr53736209qkc.394.1563976244860;
        Wed, 24 Jul 2019 06:50:44 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id f133sm22578426qke.62.2019.07.24.06.50.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 06:50:43 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 68CCC40340; Wed, 24 Jul 2019 10:50:40 -0300 (-03)
Date:   Wed, 24 Jul 2019 10:50:40 -0300
To:     Song Liu <songliubraving@fb.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stephane Eranian <eranian@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [RFC 00/79] perf tools: Initial libperf separation
Message-ID: <20190724135040.GA5727@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
 <327EF79F-4573-4387-8DA5-24FFD9EDBBB1@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <327EF79F-4573-4387-8DA5-24FFD9EDBBB1@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 24, 2019 at 07:42:50AM +0000, Song Liu escreveu:
> > On Jul 21, 2019, at 4:23 AM, Jiri Olsa <jolsa@kernel.org> wrote:

> > we have long term goal to separate some of the perf functionality
> > into library. This patchset is initial effort on separating some
> > of the interface.

> > Currently only the basic counting interface is exported, it allows
> > to:
> >  - create cpu/threads maps
> >  - create evlist/evsel objects
> >  - add evsel objects into evlist
> >  - open/close evlist/evsel objects
> >  - enable/disable events
> >  - read evsel counts
 
> Based on my understanding, evsel and evlist are abstractions in
> perf utilities. I think most other tools that use perf UAPIs are 
> not built based on these abstractions. I looked at a few internal
> tools. Most of them just uses sys_perf_event_open() and struct 
> perf_event_attr. I am not sure whether these tools would adopt
> libperf, as libperf changes their existing concepts/abstractions.

Right, and for now we're just trying to have something that is not so
tied to perf and could possibly be useful outside tools/perf/ when the
need arises for whatever new tool or pre-existing one.

There are features there that may be interesting to use outside perf,
time will tell.

> > The initial effort was to have total separation of the objects
> > from perf code, but it showed not to be a good way. The amount
> > of changed code was too big with high chance for regressions,
> > mainly because of the code embedding one of the above objects
> > statically.

> > We took the other approach of sharing the objects/struct details
> > within the perf and libperf code. This way we can keep perf
> > functionality without any major changes and the libperf users
> > are still separated from the object/struct details. We can move
> > to total libperf's objects separation gradually in future.
 
> I found some duplicated logic between libperf and perf, for 
> example, perf_evlist__open() and evlist__open(). Do we plan to 
> merge them in the future? 

He is just slowly moving things to a public libperf while keeping perf
working, in the end the goal is to have as much stuff that is not
super specific to some of the existing perf tools
(tools/perf/builtin-*.c) in libperf as possible.

It is still early in this effort, that is why he is still leaving it in
tools/perf/lib/ and not in tools/lib/perf/ :-)

- Arnaldo
