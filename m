Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5494C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 15:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77BA721744
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 15:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRfjxNgE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfIBPnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 11:43:33 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42739 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfIBPnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 11:43:33 -0400
Received: by mail-qt1-f196.google.com with SMTP id t12so15994168qtp.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 08:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m9XP5nIZMFuLEvytrkaRg1Divk5b4NiiJacy/t5k+NQ=;
        b=nRfjxNgEJHwsLswXpBj7r+R6znfxzh13Quxvt3Q6D0cxUbIoJ2LG2u72BN1byeLND1
         +Sjom77W0ZXYVqOQtSn4Iv2CMNRVlkUHwOgq5rB+wrUAIXs85Qb525pdStSmxtCN1jwD
         mj3VThvJvHUQ01e9gYQnSdVfy41q4hQYe9mJWmb61GjyOOYR/bKR0PS879crltUnRcSH
         Asrjz2930JN7eXMAKKZ7mTplbqydyfxL/hq5UnmeIhyd0eeMHic0j0ep1ZV4taSmnugM
         OCRXjAUm84shD9fzMssf5F/hiCLouNN+5CXGTFfgomiQogKE3X0Ej87q2ZSek57lK1AX
         Gp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m9XP5nIZMFuLEvytrkaRg1Divk5b4NiiJacy/t5k+NQ=;
        b=FSBwTYl4PA1dVzauF1mJpS1JG1nWFgJfN6X0vxpSFDK8QjPqEdvpqmBEyi+dwfQbZK
         kanPcBpq+zVT3tdyURSC4DaZGS6SiSSId3961+zFvB9dyeg7itbvODiaWJ/5BG+xYOA3
         RHZGLDFtnXJi31LZyR28IurlMtR4X78FPmUhmk0vdS9lUg7Yfd7AWD0hMatn5Zn4G/J0
         V882r0k6D/41xYMT1pn1Xu2qnULqwGQoRPxEqABxhVjSKcz34K8eE56Jks8E0hM7q/9D
         1LgbUc4Ue1+8/+BRu+eVn+pzNlmHMu2KJydh0D34e1xlYUCqe/ZlrUYwOqtIZ+UgauDX
         PcHg==
X-Gm-Message-State: APjAAAWf7PCOBX2Lmk0sncQpAldajcJvncpZtJe0MZcdPaTwnpHFWP6I
        6o1dszqu5FOwHoz0PMrRuPxjcpu8
X-Google-Smtp-Source: APXvYqzPeMEqGetfuhf3I5OMIZQdt5bB6219X4/Ta+M5U1EBKWmuyzcwNwB/4U8bOc1jn382A/JfAA==
X-Received: by 2002:ac8:690:: with SMTP id f16mr27952678qth.202.1567439012424;
        Mon, 02 Sep 2019 08:43:32 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id d133sm2054151qkg.31.2019.09.02.08.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 08:43:31 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D6D1041146; Mon,  2 Sep 2019 12:43:29 -0300 (-03)
Date:   Mon, 2 Sep 2019 12:43:29 -0300
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 3/3] perf stat: Add --per-numa agregation support
Message-ID: <20190902154329.GE8396@kernel.org>
References: <20190902121255.536-1-jolsa@kernel.org>
 <20190902121255.536-4-jolsa@kernel.org>
 <bdf81661-4c70-797f-51f2-726f4458d812@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdf81661-4c70-797f-51f2-726f4458d812@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 02, 2019 at 06:13:17PM +0300, Alexey Budankov escreveu:
> 
> On 02.09.2019 15:12, Jiri Olsa wrote:
> > Adding new --per-numa option to aggregate counts per NUMA
> > nodes for system-wide mode measurements.
> > 
> > You can specify --per-numa in live mode:
> > 
> >   # perf stat  -a -I 1000 -e cycles --per-numa
> >   #           time numa   cpus             counts unit events
> 
> It might probably better have 'node' instead of 'numa' as in the 
> option name '--per-node' as in the table header, like this:

Agreed

> 
>     #           time node     cpus             counts unit events
>          1.000542550 0        20          6,202,097      cycles
>          1.000542550 1        20            639,559      cycles
>          2.002040063 0        20          7,412,495      cycles
>          2.002040063 1        20          2,185,577      cycles
>          3.003451699 0        20          6,508,917      cycles
>          3.003451699 1        20            765,607      cycles
>    ...
> 
> BR,
> Alexey

-- 

- Arnaldo
