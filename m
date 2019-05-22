Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10F9C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 11:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A686A217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 11:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFfxQx0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbfEVLI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 07:08:27 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41322 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbfEVLI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 07:08:27 -0400
Received: by mail-qk1-f195.google.com with SMTP id m18so1148661qki.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 04:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pMmkqCL3UPJrqwz90rzNGDcu6Lug81+3J4XTOSHnFoo=;
        b=dFfxQx0w5CGo2K4bRdhb8YGzJbCf+ECw2Hk4Wy3KSZYqNBOr5W2RNLySFynk5joveK
         4kwd1CY7+UukFn/O2e02XsMCaUqaz6Xe1ItyK5G7e6pGonGPVdOkzmXMCJLs6DBu9xdh
         26L6t53862Vbe5F/GLgN1GgrGS6YUZL/Ff3A1bMLNEyX0y0Qk9dvbbeYYqt5GjZJzNOi
         yoIx0BrtkCYyxc2Nyt5YP2cRiVxZARKU75TzcChfgV2edjAXk9r7piV3tlF6XGDscntJ
         nAzP08z9ZbE3RkWqGtuQe5OE9wUch7VjI4z1k/Pj8JK7gUgA25OfLsduYR+3Sya1yZsq
         P8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pMmkqCL3UPJrqwz90rzNGDcu6Lug81+3J4XTOSHnFoo=;
        b=FyyXqUGvuoBRBvRFimm8dYb1PMBV3ojl9wZW28cR4KzYh4ZZqRpoPuRX3p63Vahso5
         8IKeWLfRDsXJlauUurRpUfKv4N1b/1Ockf021fndmXlWz8sfDPYNakR7ec7PmgAybNgg
         GDelLnPiVOK8ZZyQch/hoI9HCTj73ybI307fk0eUMqB6oQ91pVrvEtyxjM0bFxDledRk
         Rv/lYmUUzBCp8Hi9hsGzaS0Bf3bzTbD4WYUh5DJWrPFxjb7y6fnsA6roRKQDB+6rsxGK
         EUvQJpqMQyu26RxGo9gBDqH3MwNzqNP/8Al/8TyHqC0FmeO69naB885K3hHU9ajuqnHa
         R58A==
X-Gm-Message-State: APjAAAUkip4ec14W6ytB00YCaiWFwR6/Ym6JsvWHM75RT1Vt2DVigCld
        NztnfaBu9VmI5BFsmgbQSUEFP39V
X-Google-Smtp-Source: APXvYqyIBDi6YIxuX+OgrVhN1uuZqMDcAR4XgA814CJQJdlPt4msya5tSEbY9V+ODZFyQaY1pby1RA==
X-Received: by 2002:a05:620a:1107:: with SMTP id o7mr61050709qkk.184.1558523306657;
        Wed, 22 May 2019 04:08:26 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id k127sm10976158qkb.96.2019.05.22.04.08.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 22 May 2019 04:08:25 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2B53F404A1; Wed, 22 May 2019 08:08:23 -0300 (-03)
Date:   Wed, 22 May 2019 08:08:23 -0300
To:     Wei Li <liwei391@huawei.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org, xiezhipeng1@huawei.com
Subject: Re: [PATCH v2] fix use-after-free in perf_sched__lat
Message-ID: <20190522110823.GR8945@kernel.org>
References: <20190508143648.8153-1-liwei391@huawei.com>
 <20190522065555.GA206606@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522065555.GA206606@google.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 22, 2019 at 03:56:10PM +0900, Namhyung Kim escreveu:
> On Wed, May 08, 2019 at 10:36:48PM +0800, Wei Li wrote:
> > After thread is added to machine->threads[i].dead in
> > __machine__remove_thread, the machine->threads[i].dead is freed
> > when calling free(session) in perf_session__delete(). So it get a
> > Segmentation fault when accessing it in thread__put().
> > 
> > In this patch, we delay the perf_session__delete until all threads
> > have been deleted.
> > 
> > This can be reproduced by following steps:
> > 	ulimit -c unlimited
> > 	export MALLOC_MMAP_THRESHOLD_=0
> > 	perf sched record sleep 10
> > 	perf sched latency --sort max
> > 	Segmentation fault (core dumped)
> > 
> > Signed-off-by: Zhipeng Xie <xiezhipeng1@huawei.com>
> > Signed-off-by: Wei Li <liwei391@huawei.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

I'll try to analyse this one soon, but my first impression was that we
should just grab reference counts when keeping a pointer to those
threads instead of keeping _all_ threads alive when supposedly we could
trow away unreferenced data structures.

But this is just a first impression from just reading the patch
description, probably I'm missing something.

Thanks for providing instructions on readily triggering the segfault.

- Arnaldo
