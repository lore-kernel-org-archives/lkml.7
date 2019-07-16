Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806D1C76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCBD2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILTfJYZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388580AbfGPSsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 14:48:18 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45801 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbfGPSsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 14:48:17 -0400
Received: by mail-qk1-f193.google.com with SMTP id s22so15429817qkj.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 11:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i6md9rIChQVXhaUo7ltMaY/nR+bnXEpUHUJSCYG9md0=;
        b=ILTfJYZA0dsy4ktuQXFAJJYv14hDbEnQAQCVgh7Iaq+NYq0ff/1ayrPU5xg8E1z/kR
         msIuoxQRjAX7FB7gbclF903P0R8cbXcTQb8MeEL9Xfb/4OKT5VbEQIGsI0DHb8jpDBKL
         O29YGMYytCg1G9XJY0B2oxN2ONXNgzp/NLscQHBHkg3vf+ckCuMnvV9DA4jiDP7gjZde
         kP0JVrT5cnwABvkRHFI6Kq39KhSX3UFmPO3zam73ETw1hfkd6EUOdOoC3Y4W0rVSKk2T
         HKM0OSlBQmuTeUIpgNVtOqAnJMtsXhJJIQMY1e+iwZ6keCRCZMAV7YUnv1J2rCNjQNSS
         U/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i6md9rIChQVXhaUo7ltMaY/nR+bnXEpUHUJSCYG9md0=;
        b=jEGi5cYAVwSVRYs6jiJMjEhE1H1KJX9bCUBprr4rjhLyesN0Zcx/rQHzUGIuDYsLo7
         yttt3gIP9SHST5Zhu5KNMl8S/rdVncfvgRQnpbTqwJWPsgRcQ+bf5ph5lVdcWj9psdaB
         GJIhx0ERBnmzUhHFIGVsHydkeeK0NWx7aVO3gV8sOLXob2spioqiTPMw8Pq2v9ARCO1l
         6ni4JfGXbfD3W8DpQhmkAuOgMOepzFsvl4vuOZvcudASDC1pXY7DTOegB1LTE8wdY2jw
         mlm/p6OeUcRCBxwW4zOcm9Hy7nz1znyDPV/1yH3nSQCUAPTa4j7jLsEqN+AWL/Ww/7xr
         G1VQ==
X-Gm-Message-State: APjAAAWJATNti58UifcIYmI9lZV8ePNfB9anbuXOoAe6Wcnwxu1ANOQ2
        3fjX0UtamwoLYhmIjsBL5CI=
X-Google-Smtp-Source: APXvYqy319fobg/H7CDwBog85rwBv9IKwqRXEjceaqrEo2S3dg9dnFe9DcIwzCwCcTaOlA6cSPOZ2g==
X-Received: by 2002:a37:9a0b:: with SMTP id c11mr23468713qke.204.1563302895920;
        Tue, 16 Jul 2019 11:48:15 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id h19sm7111975qto.3.2019.07.16.11.48.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 11:48:15 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F279F40340; Tue, 16 Jul 2019 15:48:10 -0300 (-03)
Date:   Tue, 16 Jul 2019 15:48:10 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Numfor Mbiziwo-Tiapo <nums@google.com>,
        Stephane Eranian <eranian@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>, mbd@fb.com,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf stat: Fix segfault for event group in repeat mode
Message-ID: <20190716184810.GF3624@kernel.org>
References: <20190710204540.176495-1-nums@google.com>
 <20190714204432.GA8120@krava>
 <20190714205505.GB8120@krava>
 <CABPqkBSq35HZVk2CNi8xy9j7eb3EWRXSdgPKd+fmv2XaKPjOqA@mail.gmail.com>
 <20190715075912.GA2821@krava>
 <CABPqkBR=arE==2H2H0t1uAU2aTgPOr6Yucgh16J0rKughf_=CQ@mail.gmail.com>
 <20190715083105.GB2821@krava>
 <20190715142121.GC6032@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715142121.GC6032@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jul 15, 2019 at 04:21:21PM +0200, Jiri Olsa escreveu:
> Numfor Mbiziwo-Tiapo reported segfault on stat of event
> group in repeat mode:
> 
>   # perf stat -e '{cycles,instructions}' -r 10 ls
> 
> It's caused by memory corruption due to not cleaned
> evsel's id array and index, which needs to be rebuilt
> in every stat iteration. Currently the ids index grows,
> while the array (which is also not freed) has the same
> size.
> 
> Fixing this by releasing id array and zeroing ids index
> in perf_evsel__close function.
> 
> We also need to keep the evsel_list alive for stat
> record (which is disabled in repeat mode).

Thanks, applied.

- Arnaldo
