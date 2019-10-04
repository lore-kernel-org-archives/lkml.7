Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF42C10F14
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 02:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E9CF20862
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 02:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ot+hcWop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731921AbfJDCfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 22:35:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47069 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730427AbfJDCfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 22:35:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id o18so5046710wrv.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 19:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I93vQSd8IGeG5xXfRzvrfqxszKIBcOEcMuHo1qpnQuo=;
        b=ot+hcWopZc+S4xbMq3sLXCBe331x+L+D/YloM7sk4hcOB1oXSJXI0q3kjhKlWlPvn6
         861UuPl8EvYpzcSiLpRAbrEigzgpICWUZvgTREbMCGjUsZywFAueiELwaaGwU/eoPWCj
         0u5i10ADkSPPnTo+BpknygAwMeCmlCKkaw+yuFJt7f1C+UZUS0i0jeD30XNlFZR8dTuy
         ZXgRZx4/tekD1YLQJaU89o2WCHVrBcBRAjutpNvf2dfgPrYyDBlHLj+8QTH78QnXDCjb
         qxrBddLLzOC/ee3nwXsaaXOthxohIIVMK4a6bifNm4L2GU9mHps2IQx79taOVWfzRHwg
         V/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I93vQSd8IGeG5xXfRzvrfqxszKIBcOEcMuHo1qpnQuo=;
        b=syH7p75jH6QiQcIhv64e7T8x2BEFCHtwHbkm7QvksB1x2mumrKu4QCzrd+xtmJG89Q
         5Q9jyZ5M+Uy5o7OAfqYqkVr0KtGssNvbnLphHKuZE+UB7DOhMqv0VHUYt/NmMXv5naSn
         P8Jeqt1HtXBfHAIVsNv7c3u6sEyLYtYpedBhsBwT3kLacZIDbKzl2TRU81w6Rgfv2bQ4
         UZPOFFp2d4ujsjFoANjfva3SJO05x3FMLYkzL52MHFESirM3IKXG8cNornX2GX2D9IMv
         fZdpl40a2Zu0DhqWQf4KN7OnDx2Mj+T2uLKNoE2Olsu180DULoFKw6t4JmLl8tm4f8OG
         DBxQ==
X-Gm-Message-State: APjAAAWLS9FuMlkmXv6/Lq4e0iZs0GiAAWoeP/ew7n/SrR7LB7yuOlZk
        IcCT1eJa8Od+6SYwYa2P2DA=
X-Google-Smtp-Source: APXvYqwYgvoRu/4Ifn8ELWh/L+Me7eGt3fMMGc5sq0CwBseKQcg3Sb3KS+glpDAJfNylbFGh68Ws3Q==
X-Received: by 2002:a5d:43d0:: with SMTP id v16mr9555898wrr.390.1570156544298;
        Thu, 03 Oct 2019 19:35:44 -0700 (PDT)
Received: from mail.google.com ([104.238.174.53])
        by smtp.gmail.com with ESMTPSA id s12sm7947262wra.82.2019.10.03.19.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 19:35:43 -0700 (PDT)
Date:   Fri, 4 Oct 2019 10:35:37 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] perf: add support for logging debug messages to
 file
Message-ID: <20191004023535.3ddpkym64xb2cvvl@mail.google.com>
References: <20190922023823.12543-1-changbin.du@gmail.com>
 <20190929073951.GA15099@krava.homenet.telecomitalia.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190929073951.GA15099@krava.homenet.telecomitalia.it>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2019 at 09:44:07AM +0200, Jiri Olsa wrote:
> On Sun, Sep 22, 2019 at 10:38:21AM +0800, Changbin Du wrote:
> > When in TUI mode, it is impossible to show all the debug messages to
> > console. This make it hard to debug perf issues using debug messages.
> > This patch adds support for logging debug messages to file to resolve
> > this problem.
> > 
> > v2:
> >   o specific all debug options one time.
> > 
> > Changbin Du (2):
> >   perf: support multiple debug options separated by ','
> >   perf: add support for logging debug messages to file
> 
> hi,
> getting segfault with:
> 
> [jolsa@krava perf]$ ./perf --debug verbose=2,file report
> build id event received for [kernel.kallsyms]: bf6ca14c03795fd67b4d88113681ba4af2b8c18a
> Segmentation fault (core dumped)
>
Hmm, this because the va_list variable cannot be used twice. I resolve this by
making stderr and file options exclusive.

> jirka
> 
> > 
> >  tools/perf/Documentation/perf.txt |  14 ++--
> >  tools/perf/util/debug.c           | 106 ++++++++++++++++++------------
> >  2 files changed, 73 insertions(+), 47 deletions(-)
> > 
> > -- 
> > 2.20.1
> > 

-- 
Cheers,
Changbin Du
