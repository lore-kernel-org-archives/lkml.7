Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FB9CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 07:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43BAD20830
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 07:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571644789;
	bh=799xe0mW8gBVbGXDGOHFYlfgTbwaDxFyDSrCeM7KuD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Sj31kpmz2TjlIqxWQhO9faCyGs7A9IH2p4iJ7TK17RdmXjc+AxkAXFUu9xvQObB8l
	 yDmfQC1/zeOwAw6O8+S63wCZiDc18MBCD1kQNvNX4EZJHt0B4xV0rRJFRRtDkAD2K8
	 UdE72otYrZzL68fUyH6/d0kfHiiHvwkO4ZjJPOJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfJUH7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 03:59:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36239 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfJUH7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 03:59:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id w18so12145968wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 00:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dusALXNtOXXNZZZbyl/xMwyt1ewPplJLSYZZzGVsFtQ=;
        b=qiafQ9k1U2DEi5MXUxnyA2elBLak4Jl7I2nvYPbcwxYvjPnfosv9ThSnvwmRa7miPt
         FnQGp0dEFOCpG7XAosjMZNVbRZcFIxD5F+ZMDLde90azxVFLhdK9C3rbOPvkeVit979k
         4z1coeQPD6A08SVYYE9Lt4SYYaC3UEyEp5Vkfsp+/u3UvWNW6yLt4AeVFyGr/YaunX/t
         WatGQADyAaQEK7HyiNFd2a5ByhSYLkC1gVQG1uxKI735ZwEj2htzEkPpB8zlgVe3nDq+
         KVYFUMJ6+6ay2fAGY/GakrO5JyHpmlnQ3Jz6HpTNcM8gDl10wc7aoUlZQU96r425a2k4
         6hxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dusALXNtOXXNZZZbyl/xMwyt1ewPplJLSYZZzGVsFtQ=;
        b=UtbdstpbvGdVCs9qrbqy1CYjAwPbIrWLRg/luctxMWCzNTDmyULNmyBgDp33AQQebQ
         XF4cA4uR1xzN6S2pqYHrwEIJfHzNt2deuQ1slFbbmDMn37zcsY7RVmxxQs4Mup5MEksu
         LMApU4lTT0jRBHBbOZm1y3vnKrkZz4HWWAGfnwkYt1wDQMD1xZM7xjksO0f4kBNtCq6w
         s7esinbeqJykkMoHAdCBpBZf6l/tkde3+pnw5ftPD0cRJ78xtSO8T8+Qpdt3O8Cms5O3
         Z/Hzc3cEps2rO8vD9hua5+zZx5xdKX1ukFHsSYrcDBoAPNQnw3aUGsTMx6zMK4UrIWgP
         4K6w==
X-Gm-Message-State: APjAAAX/pXHc3JfcrxxLcJUKOopA5yCBLb0w6H2X1msqtA31UIgytmz2
        i3pf3pyX0S9uO5G2kSicVomIkh6R
X-Google-Smtp-Source: APXvYqw6dtNHsaG2r1LYnC/n9/CqcFOW3KoFgm/jtKGuA3KWUgzEWl2MbXMWgikVcqOEKdLmpObT6Q==
X-Received: by 2002:a5d:638f:: with SMTP id p15mr9417011wru.150.1571644785585;
        Mon, 21 Oct 2019 00:59:45 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id z9sm13901595wrv.1.2019.10.21.00.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 00:59:45 -0700 (PDT)
Date:   Mon, 21 Oct 2019 09:59:42 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] perf/core,x86: synchronize PMU task contexts on
 optimized context switches
Message-ID: <20191021075942.GA8809@gmail.com>
References: <0b20a07f-d074-d3da-7551-c9a4a94fe8e3@linux.intel.com>
 <f3253a36-c174-8051-a462-9728ef721766@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3253a36-c174-8051-a462-9728ef721766@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Alexey Budankov <alexey.budankov@linux.intel.com> wrote:

> +			/*
> +			 * PMU specific parts of task perf context may require
> +			 * additional synchronization, at least for proper Intel
> +			 * LBR callstack data profiling;
> +			 */
> +			pmu->sync_task_ctx(ctx->task_ctx_data,
> +					   next_ctx->task_ctx_data);

Firstly, I'm pretty sure you never run this on a CPU where 
pmu->sync_task_ctx is NULL, right? ;-)

Secondly, even on Intel CPUs in many cases we'll just call into a ~2 deep 
function pointer based call hierarchy, just to find that nothing needs to 
be done, because there's no LBR call stack maintained:

+       if (!one || !another)
+               return;

So while it's technically a layering violation, it might make sense to 
elevate this check to the generic layer and say that synchronization 
calls by the core layer will always provide two valid pointers?

Thanks,

	Ingo
