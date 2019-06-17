Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7922C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54EE208CB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fod9JZEq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbfFQP4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:56:49 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33976 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbfFQP4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:56:47 -0400
Received: by mail-qt1-f196.google.com with SMTP id m29so11333364qtu.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 08:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fMbBupmKpvqxTbAa++1G7QLKFVGIh4tCJDJCcA32Xlk=;
        b=Fod9JZEqts/1042T9cVWGi94vW7ZK18VpVXHmYeddLbBsDX2u1q/DxEQke0lLtZp0T
         NjTprvnENSl12aQ/9Rj0gG9NQZpUTDwKM/VgYxHQRx/byC1SMJ6UYx7ExLnurBw9qKK2
         kkedodrEkGFlaJWFgR8tsCkCQHjqHScLETggUrAqfuIHFx3GItyF+H/YQNkIjHi7NwJt
         4qEry9Q+jVSNt+nJJaqmC8XEvGn1JVig+HDSQdDCdPcwoy1RVd5krkPlFYHcBLYL8iH6
         OhyUGqVVk5Uxr3xjaJXelO7gby8yFEi7s34o5pSbxcw2GFYcYCclOOBnLqb2KQKdLmOR
         wExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fMbBupmKpvqxTbAa++1G7QLKFVGIh4tCJDJCcA32Xlk=;
        b=IKV88wyjR7VXf0+wq/VO+dAN6w8WzBtniB50CefC3JjXf28hL5xtbfT0giCVUVWVb/
         Hk492EcUWQUBADcx3X4NMPRHZhRMdNvib+5ecpjY1PTHQ4vJeEfO9IvAgpVS6r1Vr1iw
         1hfY5D7m5BcNQa7y15Edcw59Dkb07tGvH3b/L3o39eT/kkzhI5OE5DeeaxLH/Z54KUwJ
         MJLXUw3CzW8pe6Z1es0OSXldRMCuDIvB4YaK3whQtxAzUTixporaCgNjlL6c7p5v7Cji
         XSQjL132VtnFlKyYgB5/iJ0L/KgAdHaYPLncfA03xoSzPTi4eSLl6o3VQHflz0i2GAtA
         YxwQ==
X-Gm-Message-State: APjAAAV0i1HPZ90aSEbygcHIeWSGyBp0+TYi+lOa8Z+f2Uvm46Xky3Dr
        WgVmfp5JOafN1FwerE2GxgY=
X-Google-Smtp-Source: APXvYqySNRnWvTNhT/YvNusD5TpqNeN3LvLJ5o15qOWwvkii1KTh+GIzNVcLdsD97MjObAC8fhoDCA==
X-Received: by 2002:ac8:29c9:: with SMTP id 9mr68508667qtt.196.1560787006073;
        Mon, 17 Jun 2019 08:56:46 -0700 (PDT)
Received: from quaco.ghostprotocols.net (179-240-145-61.3g.claro.net.br. [179.240.145.61])
        by smtp.gmail.com with ESMTPSA id s134sm7068493qke.51.2019.06.17.08.56.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 08:56:45 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F2CB541149; Mon, 17 Jun 2019 12:56:33 -0300 (-03)
Date:   Mon, 17 Jun 2019 12:56:33 -0300
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Andi Kleen <andi@firstfloor.org>, Kan Liang <kan.liang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH trivial] perf vendor events intel: Assorted style fixes
Message-ID: <20190617155633.GA3927@kernel.org>
References: <20190617142156.2526-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617142156.2526-1-geert+renesas@glider.be>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 17, 2019 at 04:21:56PM +0200, Geert Uytterhoeven escreveu:
>   - Do not use apostrophes for plurals,
>   - Insert commas before "and",
>   - Spelling s/statisfied/satisfied/.

I think these files are generated from some other material from Intel,
i.e. if they update something somewhere else and regenerate those files,
your changes would be lost, right Andi, Kan? (Adding them to the CC list).

- Arnaldo
 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  tools/perf/pmu-events/arch/x86/nehalemep/cache.json  | 12 ++++++------
>  tools/perf/pmu-events/arch/x86/nehalemep/memory.json |  4 ++--
>  tools/perf/pmu-events/arch/x86/nehalemex/cache.json  | 12 ++++++------
>  tools/perf/pmu-events/arch/x86/nehalemex/memory.json |  4 ++--
>  .../pmu-events/arch/x86/westmereep-sp/cache.json     | 12 ++++++------
>  .../pmu-events/arch/x86/westmereep-sp/memory.json    |  4 ++--
>  tools/perf/pmu-events/arch/x86/westmereex/cache.json | 12 ++++++------
>  .../perf/pmu-events/arch/x86/westmereex/memory.json  |  4 ++--
>  8 files changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/cache.json b/tools/perf/pmu-events/arch/x86/nehalemep/cache.json
> index a11029efda2f01e6..1c4fd6af138229e3 100644
> --- a/tools/perf/pmu-events/arch/x86/nehalemep/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/nehalemep/cache.json
> @@ -1804,7 +1804,7 @@
>          "EventName": "OFFCORE_RESPONSE.DATA_IN.IO_CSR_MMIO",
>          "MSRIndex": "0x1A6",
>          "SampleAfterValue": "100000",
> -        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the IO, CSR, MMIO unit",
> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the IO, CSR, MMIO unit",
>          "Offcore": "1"
>      },
>      {
> @@ -1815,7 +1815,7 @@
>          "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_NO_OTHER_CORE",
>          "MSRIndex": "0x1A6",
>          "SampleAfterValue": "100000",
> -        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the LLC and not found in a sibling core",
> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC and not found in a sibling core",
>          "Offcore": "1"
>      },
>      {
> @@ -1826,7 +1826,7 @@
>          "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_OTHER_CORE_HIT",
>          "MSRIndex": "0x1A6",
>          "SampleAfterValue": "100000",
> -        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the LLC and HIT in a sibling core",
> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC and HIT in a sibling core",
>          "Offcore": "1"
>      },
>      {
> @@ -1837,7 +1837,7 @@
>          "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_OTHER_CORE_HITM",
>          "MSRIndex": "0x1A6",
>          "SampleAfterValue": "100000",
> -        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the LLC  and HITM in a sibling core",
> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC  and HITM in a sibling core",
>          "Offcore": "1"
>      },
>      {
> @@ -1892,7 +1892,7 @@
>          "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_CACHE_HIT",
>          "MSRIndex": "0x1A6",
>          "SampleAfterValue": "100000",
> -        "BriefDescription": "Offcore data reads, RFO's and prefetches that HIT in a remote cache ",
> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches that HIT in a remote cache ",
>          "Offcore": "1"
>      },
>      {
> @@ -1903,7 +1903,7 @@
>          "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_CACHE_HITM",
>          "MSRIndex": "0x1A6",
>          "SampleAfterValue": "100000",
> -        "BriefDescription": "Offcore data reads, RFO's and prefetches that HITM in a remote cache",
> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches that HITM in a remote cache",
>          "Offcore": "1"
>      },
>      {
> diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/memory.json b/tools/perf/pmu-events/arch/x86/nehalemep/memory.json
> index f914a4525b651d0f..029a7fc8561c0629 100644
> --- a/tools/perf/pmu-events/arch/x86/nehalemep/memory.json
> +++ b/tools/perf/pmu-events/arch/x86/nehalemep/memory.json
> @@ -293,7 +293,7 @@
>          "EventName": "OFFCORE_RESPONSE.DATA_IN.LOCAL_DRAM",
>          "MSRIndex": "0x1A6",
>          "SampleAfterValue": "100000",
> -        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the local DRAM.",
> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the local DRAM.",
>          "Offcore": "1"
>      },
>      {
> @@ -304,7 +304,7 @@
>          "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_DRAM",
>          "MSRIndex": "0x1A6",
>          "SampleAfterValue": "100000",
> -        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the remote DRAM",
> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the remote DRAM",
>          "Offcore": "1"
>      },
>      {
> diff --git a/tools/perf/pmu-events/arch/x86/nehalemex/cache.json b/tools/perf/pmu-events/arch/x86/nehalemex/cache.json
> index 21a0f8fd057e8388..980352618ad7e987 100644
> --- a/tools/perf/pmu-events/arch/x86/nehalemex/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/nehalemex/cache.json
> @@ -1759,7 +1759,7 @@
>          "EventName": "OFFCORE_RESPONSE.DATA_IN.IO_CSR_MMIO",
>          "MSRIndex": "0x1A6",
>          "SampleAfterValue": "100000",
> -        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the IO, CSR, MMIO unit",
> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the IO, CSR, MMIO unit",
>          "Offcore": "1"
>      },
>      {
> @@ -1770,7 +1770,7 @@
>          "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_NO_OTHER_CORE",
>          "MSRIndex": "0x1A6",
>          "SampleAfterValue": "100000",
> -        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the LLC and not found in a sibling core",
> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC and not found in a sibling core",
>          "Offcore": "1"
>      },
>      {
> @@ -1781,7 +1781,7 @@
>          "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_OTHER_CORE_HIT",
>          "MSRIndex": "0x1A6",
>          "SampleAfterValue": "100000",
> -        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the LLC and HIT in a sibling core",
> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC and HIT in a sibling core",
>          "Offcore": "1"
>      },
>      {
> @@ -1792,7 +1792,7 @@
>          "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_OTHER_CORE_HITM",
>          "MSRIndex": "0x1A6",
>          "SampleAfterValue": "100000",
> -        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the LLC  and HITM in a sibling core",
> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC  and HITM in a sibling core",
>          "Offcore": "1"
>      },
>      {
> @@ -1847,7 +1847,7 @@
>          "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_CACHE_HIT",
>          "MSRIndex": "0x1A6",
>          "SampleAfterValue": "100000",
> -        "BriefDescription": "Offcore data reads, RFO's and prefetches that HIT in a remote cache ",
> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches that HIT in a remote cache ",
>          "Offcore": "1"
>      },
>      {
> @@ -1858,7 +1858,7 @@
>          "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_CACHE_HITM",
>          "MSRIndex": "0x1A6",
>          "SampleAfterValue": "100000",
> -        "BriefDescription": "Offcore data reads, RFO's and prefetches that HITM in a remote cache",
> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches that HITM in a remote cache",
>          "Offcore": "1"
>      },
>      {
> diff --git a/tools/perf/pmu-events/arch/x86/nehalemex/memory.json b/tools/perf/pmu-events/arch/x86/nehalemex/memory.json
> index f914a4525b651d0f..029a7fc8561c0629 100644
> --- a/tools/perf/pmu-events/arch/x86/nehalemex/memory.json
> +++ b/tools/perf/pmu-events/arch/x86/nehalemex/memory.json
> @@ -293,7 +293,7 @@
>          "EventName": "OFFCORE_RESPONSE.DATA_IN.LOCAL_DRAM",
>          "MSRIndex": "0x1A6",
>          "SampleAfterValue": "100000",
> -        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the local DRAM.",
> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the local DRAM.",
>          "Offcore": "1"
>      },
>      {
> @@ -304,7 +304,7 @@
>          "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_DRAM",
>          "MSRIndex": "0x1A6",
>          "SampleAfterValue": "100000",
> -        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the remote DRAM",
> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the remote DRAM",
>          "Offcore": "1"
>      },
>      {
> diff --git a/tools/perf/pmu-events/arch/x86/westmereep-sp/cache.json b/tools/perf/pmu-events/arch/x86/westmereep-sp/cache.json
> index dad20f0e3cac235f..62cddfff9781766d 100644
> --- a/tools/perf/pmu-events/arch/x86/westmereep-sp/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/westmereep-sp/cache.json
> @@ -1808,7 +1808,7 @@
>          "EventName": "OFFCORE_RESPONSE.DATA_IN.IO_CSR_MMIO",
>          "MSRIndex": "0x1a6,0x1a7",
>          "SampleAfterValue": "100000",
> -        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the IO, CSR, MMIO unit",
> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the IO, CSR, MMIO unit",
>          "Offcore": "1"
>      },
>      {
> @@ -1819,7 +1819,7 @@
>          "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_NO_OTHER_CORE",
>          "MSRIndex": "0x1a6,0x1a7",
>          "SampleAfterValue": "100000",
> -        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the LLC and not found in a sibling core",
> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC and not found in a sibling core",
>          "Offcore": "1"
>      },
>      {
> @@ -1830,7 +1830,7 @@
>          "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_OTHER_CORE_HIT",
>          "MSRIndex": "0x1a6,0x1a7",
>          "SampleAfterValue": "100000",
> -        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the LLC and HIT in a sibling core",
> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC and HIT in a sibling core",
>          "Offcore": "1"
>      },
>      {
> @@ -1841,7 +1841,7 @@
>          "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_OTHER_CORE_HITM",
>          "MSRIndex": "0x1a6,0x1a7",
>          "SampleAfterValue": "100000",
> -        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the LLC  and HITM in a sibling core",
> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC  and HITM in a sibling core",
>          "Offcore": "1"
>      },
>      {
> @@ -1896,7 +1896,7 @@
>          "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_CACHE_HIT",
>          "MSRIndex": "0x1a6,0x1a7",
>          "SampleAfterValue": "100000",
> -        "BriefDescription": "Offcore data reads, RFO's and prefetches that HIT in a remote cache ",
> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches that HIT in a remote cache ",
>          "Offcore": "1"
>      },
>      {
> @@ -1907,7 +1907,7 @@
>          "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_CACHE_HITM",
>          "MSRIndex": "0x1a6,0x1a7",
>          "SampleAfterValue": "100000",
> -        "BriefDescription": "Offcore data reads, RFO's and prefetches that HITM in a remote cache",
> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches that HITM in a remote cache",
>          "Offcore": "1"
>      },
>      {
> diff --git a/tools/perf/pmu-events/arch/x86/westmereep-sp/memory.json b/tools/perf/pmu-events/arch/x86/westmereep-sp/memory.json
> index 90eb6aac357b5ffa..8355b5d3945ba8fa 100644
> --- a/tools/perf/pmu-events/arch/x86/westmereep-sp/memory.json
> +++ b/tools/perf/pmu-events/arch/x86/westmereep-sp/memory.json
> @@ -293,7 +293,7 @@
>          "EventName": "OFFCORE_RESPONSE.DATA_IN.LOCAL_DRAM",
>          "MSRIndex": "0x1a6,0x1a7",
>          "SampleAfterValue": "100000",
> -        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the local DRAM.",
> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the local DRAM.",
>          "Offcore": "1"
>      },
>      {
> @@ -304,7 +304,7 @@
>          "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_DRAM",
>          "MSRIndex": "0x1a6,0x1a7",
>          "SampleAfterValue": "100000",
> -        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the remote DRAM",
> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the remote DRAM",
>          "Offcore": "1"
>      },
>      {
> diff --git a/tools/perf/pmu-events/arch/x86/westmereex/cache.json b/tools/perf/pmu-events/arch/x86/westmereex/cache.json
> index f9bc7fdd48d6e648..30266602fc82e85d 100644
> --- a/tools/perf/pmu-events/arch/x86/westmereex/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/westmereex/cache.json
> @@ -1800,7 +1800,7 @@
>          "EventName": "OFFCORE_RESPONSE.DATA_IN.IO_CSR_MMIO",
>          "MSRIndex": "0x1A6",
>          "SampleAfterValue": "100000",
> -        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the IO, CSR, MMIO unit",
> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the IO, CSR, MMIO unit",
>          "Offcore": "1"
>      },
>      {
> @@ -1811,7 +1811,7 @@
>          "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_NO_OTHER_CORE",
>          "MSRIndex": "0x1A6",
>          "SampleAfterValue": "100000",
> -        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the LLC and not found in a sibling core",
> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC and not found in a sibling core",
>          "Offcore": "1"
>      },
>      {
> @@ -1822,7 +1822,7 @@
>          "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_OTHER_CORE_HIT",
>          "MSRIndex": "0x1A6",
>          "SampleAfterValue": "100000",
> -        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the LLC and HIT in a sibling core",
> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC and HIT in a sibling core",
>          "Offcore": "1"
>      },
>      {
> @@ -1833,7 +1833,7 @@
>          "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_OTHER_CORE_HITM",
>          "MSRIndex": "0x1A6",
>          "SampleAfterValue": "100000",
> -        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the LLC  and HITM in a sibling core",
> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC  and HITM in a sibling core",
>          "Offcore": "1"
>      },
>      {
> @@ -1888,7 +1888,7 @@
>          "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_CACHE_HIT",
>          "MSRIndex": "0x1A6",
>          "SampleAfterValue": "100000",
> -        "BriefDescription": "Offcore data reads, RFO's and prefetches that HIT in a remote cache ",
> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches that HIT in a remote cache ",
>          "Offcore": "1"
>      },
>      {
> @@ -1899,7 +1899,7 @@
>          "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_CACHE_HITM",
>          "MSRIndex": "0x1A6",
>          "SampleAfterValue": "100000",
> -        "BriefDescription": "Offcore data reads, RFO's and prefetches that HITM in a remote cache",
> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches that HITM in a remote cache",
>          "Offcore": "1"
>      },
>      {
> diff --git a/tools/perf/pmu-events/arch/x86/westmereex/memory.json b/tools/perf/pmu-events/arch/x86/westmereex/memory.json
> index 3ba555e73cbd60d5..794e6773bf74cc0c 100644
> --- a/tools/perf/pmu-events/arch/x86/westmereex/memory.json
> +++ b/tools/perf/pmu-events/arch/x86/westmereex/memory.json
> @@ -301,7 +301,7 @@
>          "EventName": "OFFCORE_RESPONSE.DATA_IN.LOCAL_DRAM",
>          "MSRIndex": "0x1A6",
>          "SampleAfterValue": "100000",
> -        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the local DRAM.",
> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the local DRAM.",
>          "Offcore": "1"
>      },
>      {
> @@ -312,7 +312,7 @@
>          "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_DRAM",
>          "MSRIndex": "0x1A6",
>          "SampleAfterValue": "100000",
> -        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the remote DRAM",
> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the remote DRAM",
>          "Offcore": "1"
>      },
>      {
> -- 
> 2.17.1

-- 

- Arnaldo
