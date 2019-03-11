Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BFCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609832147C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2rGoJH8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbfCKVFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:05:13 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37617 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbfCKVFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:05:12 -0400
Received: by mail-qt1-f194.google.com with SMTP id z17so231719qtn.4;
        Mon, 11 Mar 2019 14:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lPW+umpbqOxuSeCoeKj43cDCuBgsCOWzFgpQA+MWtHI=;
        b=A2rGoJH8UmNMDB/SQKDwfOztxQObQncRfTW7KcNoZ58lOA7BBYnjkSdYZ2f60iWwws
         bmL3Gh7AFq5nnqldAyQpVGryEkP/l3Czi9MTaoRoSqO77b/MWSOWdBZ/3XywFlNRHy+E
         XJ0XyGTMafdEp60yCJn+IXoILgJDVHj2XdQ9K/ueAU0CaBzUDkQSDt1o3rJ4mdZJiY07
         jiet5GBKBCNh6/WT/ViZHoxQbYrS5L92wgarq32KaKk8lzgbiFN/+LVSGImA6W93bqB2
         x1MFSTMotNfuxOyZwFP7fHZVYaCk6N007rQ0H7disvFozanW6ejc2hIkR33a3I1oKg9V
         4aIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lPW+umpbqOxuSeCoeKj43cDCuBgsCOWzFgpQA+MWtHI=;
        b=hPYEXQpq18foN0GRV+nsiDO1IoLtZNBQHbGoQObE8NDM1DjLIj2jubdSQc4aGkmMpQ
         oLv83Uu5m5cs5JuIX/KOhkdISFCtHFUrHq6R5IuFJjXoCIEOh+tuJAGcXwESHAYh+8IJ
         hdlHq+xcJ44Nj2DYjsOM7HTDZbCSXXoyvFrLkGatGyOttm2wd3f+tRZcJxjzUPsrfqPR
         gDDZf2K+6KSUnHZeoAYb0jLIhN9v81mzgI1rO/pgCn7aLOamsn+T6/6esHHi/DPYIedU
         QuslSqqDs0HofjkTo2DoBXSX955ycBxKfPdP/tyuWB3rCo61hJr3MTObCpCmhFyTRSJp
         kiXw==
X-Gm-Message-State: APjAAAXidYh+n8rM7O6GwM7PyOs1inIuXT0BSYnq+m15nrQvRBMpeydR
        z6rSYAxKYwOnrBdAd7f1b1s=
X-Google-Smtp-Source: APXvYqy32CVX7Ow1B0rf+IaOTwojQ4pMN4ZU35cHWfcFjwbuK0DWfY41GtDYmjR3XorvnQPALCytpQ==
X-Received: by 2002:ac8:2c51:: with SMTP id e17mr26487173qta.254.1552338311009;
        Mon, 11 Mar 2019 14:05:11 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id b142sm4819399qka.74.2019.03.11.14.05.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 14:05:10 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7A28B4039C; Mon, 11 Mar 2019 18:05:07 -0300 (-03)
Date:   Mon, 11 Mar 2019 18:05:07 -0300
To:     Song Liu <songliubraving@fb.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "sdf@fomichev.me" <sdf@fomichev.me>
Subject: Re: [PATCH v8 perf,bpf 00/15] perf annotation of BPF programs
Message-ID: <20190311210507.GF10690@kernel.org>
References: <20190311195555.889995-1-songliubraving@fb.com>
 <20190311202414.GA3078@redhat.com>
 <B72EC7B0-6B8B-4739-87A0-15364D3DE44F@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B72EC7B0-6B8B-4739-87A0-15364D3DE44F@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 11, 2019 at 09:01:48PM +0000, Song Liu escreveu:
> 
> 
> > On Mar 11, 2019, at 1:24 PM, Arnaldo Carvalho de Melo <acme@redhat.com> wrote:
> > 
> > Em Mon, Mar 11, 2019 at 12:55:40PM -0700, Song Liu escreveu:
> >> ===================== Note on patch dependency  ========================
> >> This set has dependency in both bpf-next tree and tip/perf/core. Current
> >> version is developed on bpf-next tree with the following commits
> >> cherry-picked from tip/perf/core (or acme/perf/core):
> >> 
> >> (from 1/11 to 11/11)
> >> commit 76193a94522f ("perf, bpf: Introduce PERF_RECORD_KSYMBOL")
> >> commit d764ac646491 ("tools headers uapi: Sync tools/include/uapi/linux/perf_event.h")
> >> commit 6ee52e2a3fe4 ("perf, bpf: Introduce PERF_RECORD_BPF_EVENT")
> >> commit df063c83aa2c ("tools headers uapi: Sync tools/include/uapi/linux/perf_event.h")
> >> commit 9aa0bfa370b2 ("perf tools: Handle PERF_RECORD_KSYMBOL")
> >> commit 45178a928a4b ("perf tools: Handle PERF_RECORD_BPF_EVENT")
> >> commit 7b612e291a5a ("perf tools: Synthesize PERF_RECORD_* for loaded BPF programs")
> >> commit a40b95bcd30c ("perf top: Synthesize BPF events for pre-existing loaded BPF programs")
> >> commit 6934058d9fb6 ("bpf: Add module name [bpf] to ksymbols for bpf programs")
> >> commit 811184fb6977 ("perf bpf: Fix synthesized PERF_RECORD_KSYMBOL/BPF_EVENT")
> >> comimt 94816add0005 ("perf tools: Add perf_exe() helper to find perf binary")
> >> ========================================================================
> > 
> > These csets are already upstream, i.e. already hit torvalds/master, i.e.
> > will be in 5.1, can you check that we still need doing this
> > cherry-picking?
> > 
> > - Arnaldo
> 
> I just checked that 02-15 of the set could apply to torvalds/master (with 
> some minor conflicts), and it works as expected. 

So no need to cherrypick, just use torvalds/master as a base, ok.

- Arnaldo
