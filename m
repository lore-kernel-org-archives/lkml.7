Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256F3C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA302087E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJ6QMDVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389786AbfKEPhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 10:37:17 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46359 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbfKEPhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 10:37:17 -0500
Received: by mail-qt1-f193.google.com with SMTP id u22so29906654qtq.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 07:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Aa04Qw0VXYDK6FtYWg/olB/CrPBzG1i0OxKRqVmlQBk=;
        b=pJ6QMDVG+oeVr6f2YHkDXCHX2KwLgyAE7pfxX/B3jY9qUepayFAcNzIgeN9UrhEbDg
         S3N4UW5Dgkz2CodOWMtsm0JREkge1fDN3ZHCcNID+1pIxqmt8XGq2efBfX5CbJlMEUpN
         zmSgF5Yiv10jUr9VfNvZLeiziJ0fDuzgOCHbiZCbcBEJuqd6lAWwco5w8OKU3AbbqpY9
         F+rL0u6E2drtCdXYkY19YvMMOopLR3UyGMnd7CvO6kALuAGASkIm3FwbkdjJ9MK23Cdt
         TV/BUPHSxFxUNOI2s3jOngTlBfWB/VyO0Psu7hv8yhDBnhuZudTbh6J7AfWQbmqGos5S
         84BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Aa04Qw0VXYDK6FtYWg/olB/CrPBzG1i0OxKRqVmlQBk=;
        b=NHna2djpIIOAne8rdPXZjjy1oFfMQW+vD+vKhtTjrKaERnf06aTCjt2o6Sx4TNN8KM
         z5+CqZkIC9ZF9iI0jWPOxPJonRYQMFGo//rdngT2veNxw1hPnnZAj0h32PlZxfLGdkDU
         Pe85F0YaawD1EQZMk4/vVmilwHlRONfo3+8myVnb7rUfj8/P35vNje6ImF1cs9xkS/AF
         t1plbblnt9iV6JLejjVJxeDzDbCZymb7ccuiOMVsHTQcn7rImnCDYzNcWeYlAwIlWhB5
         re5PRrLTKcnRQ5/hLmGUhTHRjHXFPYekF7PqspwE2kXz0ycI+HNaQFUGOiMtrma5KZdw
         +SEw==
X-Gm-Message-State: APjAAAVG2V6obuDz8gXhKcpOZASaVq2LGu2zqUR6FnxgqvFGcSCqazqU
        mYpztE8I/21jgNoFht5iBy4=
X-Google-Smtp-Source: APXvYqzr3jAxOeV5J4ky5mzPGwAnKgMhHmYKp3uSDFVFFAUB1IbPxIUKObCUNI5m10gv6OHurJN00A==
X-Received: by 2002:a0c:c392:: with SMTP id o18mr27031115qvi.75.1572968236127;
        Tue, 05 Nov 2019 07:37:16 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id q8sm14263890qta.31.2019.11.05.07.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 07:37:14 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3084C40B1D; Tue,  5 Nov 2019 12:37:12 -0300 (-03)
Date:   Tue, 5 Nov 2019 12:37:12 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCHv2 0/3] perf stat: Add --per-node option
Message-ID: <20191105153712.GE4218@kernel.org>
References: <20190904073415.723-1-jolsa@kernel.org>
 <20191105130354.GE29390@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105130354.GE29390@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 05, 2019 at 02:03:54PM +0100, Jiri Olsa escreveu:
> On Wed, Sep 04, 2019 at 09:34:12AM +0200, Jiri Olsa wrote:
> > hi,
> > adding --per-node option to aggregate stats per NUMA nodes,
> > you can get now use stat command like:
> >     
> >   # perf stat  -a -I 1000 -e cycles --per-node
> >   #           time node   cpus             counts unit events
> >        1.000542550 N0       20          6,202,097      cycles
> >        1.000542550 N1       20            639,559      cycles
> >        2.002040063 N0       20          7,412,495      cycles
> >        2.002040063 N1       20          2,185,577      cycles
> >        3.003451699 N0       20          6,508,917      cycles
> >        3.003451699 N1       20            765,607      cycles
> >   ...
> > 
> > v2 changes:
> >   - use mallox instead of zalloc plus adding comment [Arnaldo]
> >   - rename --per-numa to --per-node [Alexey]
> >   - rename function names to have node instead of numa
> > 
> > Available also in:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> >   perf/fixes
> 
> I forgot about this one ;-) rebased the latest perf/core
> and pushed out..

Thanks, applied.

- Arnaldo
