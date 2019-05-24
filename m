Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE5FC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 07:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6AE2175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 07:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558681290;
	bh=ZmvlpHvxGyk/NSgi+zudMi7xz8PLs2ggVcwCb+7Twgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Px/WDvAI7g+3JTWfoD4lE4cSE7t3kDTyJmU+X1Hsoiw1uklBpYHx+QuGXdNexZERK
	 DKnsqvoYepgrB5LNYTOJJ+fzFbScqtjTNn2WZ2VuFgWXgxwcYRiEKRRaXgsCMiOT+s
	 uWV/bEEezw/FZknhmILUBwNhVjhdE7obFIs3SMxo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389003AbfEXHB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 03:01:29 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36139 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388689AbfEXHB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 03:01:29 -0400
Received: by mail-wm1-f65.google.com with SMTP id v22so776712wml.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 00:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cD+QKfx54qleGjQuzLkKBuFuX5HsGQPpWu1Zk02xUxg=;
        b=MPdxeBjPI/0Tbxev05h5rrf9JzQqpBmPERQJCBn3JVsNT1macRKaj5TQq9jWsY8gna
         tRM/zOzk9NAnoxQ2eiktaoIk10yjclhR0q/+hoRdmuG++X6sS9i3G7Bat2Nhq+n0PgLh
         7Ndn4xvNcgZ/RV7T8uA2zFahbVS6qaTVLJA/FymVXCz1MQF5zGJAsAX9284WAlur8q/k
         XlLZgIM9u27cHwa+xd85i0ry22HXKRGxXlrLozF+tcsLRmVE5UpmJzTxUjdyj5sulhdG
         6z5tDxTo6UL7AeFj4ETYUN2YNUMhId3I6i1dd+sUFewDr4vZFeHXobXqxyD9QwQPaYJa
         WBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cD+QKfx54qleGjQuzLkKBuFuX5HsGQPpWu1Zk02xUxg=;
        b=TeW+O5mfVl4hdF5ZQeyWsZDx0pRjI3nZqGA0ugnzpVtaEAcgL26SXINSnbWbJSukFG
         WkF4j5YdI2SH/3IQmvJmlQxFm6XMpyBPWgLCpmFhhy58jlK97q48EfL1C/zbDr+kgLTz
         +2dNgZmpbeYHHdFdjookwzXcmR+Ry98iunreTS4D+m1neNOCTcVLhtFE+Y3ntLLDigPY
         RTMtBa3fXsHiOdw7DoE+W7fvb4jDbP0/7AYRwpot543SIrGyjepBzd2f/acXPAnivmRi
         6cqcLoqa4vjXNS1El5q4ruoyKAw0X05x7eVPN4yf9HEJOMnmSdC6TBF217TULaWrJo0b
         xHeg==
X-Gm-Message-State: APjAAAUuJfA/0gU8oVcMe5qMu+Tj5HZ7yB3xt3cc8toRzwn/EzYHuQbf
        8aDFABiSxrqVc824EiXL/QU=
X-Google-Smtp-Source: APXvYqzpcuwD1m5xZjDyFb76oiplEO6VonPQ3y47FqXPP06zV3tx/kjIWzSw39SYNqIQ3KJ9UlvI7A==
X-Received: by 2002:a7b:c842:: with SMTP id c2mr1792682wml.28.1558681286913;
        Fri, 24 May 2019 00:01:26 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x68sm2215915wmf.13.2019.05.24.00.01.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 00:01:26 -0700 (PDT)
Date:   Fri, 24 May 2019 09:01:24 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     yabinc@google.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 1/4] perf/ring_buffer: Fix exposing a temporarily
 decreased data_head.
Message-ID: <20190524070124.GA11882@gmail.com>
References: <20190517115230.437269790@infradead.org>
 <20190517115418.224478157@infradead.org>
 <20190517130509.GA90824@gmail.com>
 <20190517142648.GC2589@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517142648.GC2589@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, May 17, 2019 at 03:05:09PM +0200, Ingo Molnar wrote:
> > 
> > * Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > In perf_output_put_handle(), an IRQ/NMI can happen in below location and
> > > write records to the same ring buffer:
> > > 	...
> > > 	local_dec_and_test(&rb->nest)
> > > 	...                          <-- an IRQ/NMI can happen here
> > > 	rb->user_page->data_head = head;
> > > 	...
> > > 
> > > In this case, a value A is written to data_head in the IRQ, then a value
> > > B is written to data_head after the IRQ. And A > B. As a result,
> > > data_head is temporarily decreased from A to B. And a reader may see
> > > data_head < data_tail if it read the buffer frequently enough, which
> > > creates unexpected behaviors.
> > > 
> > > This can be fixed by moving dec(&rb->nest) to after updating data_head,
> > > which prevents the IRQ/NMI above from updating data_head.
> > > 
> > > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Jiri Olsa <jolsa@redhat.com>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > > Fixes: ef60777c9abd ("perf: Optimize the perf_output() path by removing IRQ-disables")
> > > Signed-off-by: Yabin Cui <yabinc@google.com>
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Link: https://lkml.kernel.org/r/20190516184010.167903-1-yabinc@google.com
> > 
> > So these are missing a bunch of:
> > 
> >   From: Yabin Cui <yabinc@google.com>
> > 
> > lines, right?
> > 
> 
> The first. certainly, the rest, while inspired by his patch, is more
> complete than what he did.

Oh, indeed - I adjusted the first patch only.

Thanks,

	Ingo
