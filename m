Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D73EC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 19:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A56120873
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 19:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsiUojvN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfEMToS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 15:44:18 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37723 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfEMToS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 15:44:18 -0400
Received: by mail-qk1-f194.google.com with SMTP id d10so2751857qko.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 12:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3of5NwBsJIwhFZUzRPv9V1acIeEP5JoDrMUzpAggel8=;
        b=LsiUojvNbEGBsgkK5x+IzVQGDCFvwxW9KjGwcF8L6AnA5SwfWPGLbMStMqXdygHRC1
         GBXj4otKANUbNSiLsMFtSD+MC46QYyceAVOyuds/13qfzpTCkrXkhQF7KubVZ8bL3QFf
         fNGjNPgnQ7BE1QFeGrAhOiN4N669WegtQDgJQopxHuYNBNVp9poprb2YmwPXiiHZAUGM
         YCBKvt/4bdm2Do87T+wFXFZTgzeirirt2zLt1lNwqr7M5vMmZwhDJ3lgID8Hhbl8HSQc
         eDRQCjsEu/EtMChT8RP6TeM/Hcey/ICtByN5Kj37DmxlrOU/u95gn/J0uu8o9Fiqp3KP
         S9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3of5NwBsJIwhFZUzRPv9V1acIeEP5JoDrMUzpAggel8=;
        b=kh7BXVxp1+EmkLYSJGmDJa1VaBUhlZQSt6acH6f1CMT8LK94y4su2p6PAbKSvmrHMu
         Dri295GsXViBmAQGLfxBzzXPahEoj4S79V4emqb2X3IL7XCf9nNjCl8S9EdhMM3MdVHP
         okc83UeERPsynm8EbflKYYNMzjRIbg8WPtLeTSpjo1uUux/LUUW2VTqS9cAWNEV7drmS
         vXCeZY6DuhANMbRquoONul4w+uD1MC+1UCz/wVT/z6GdELPjDDDMR4nRXwLgEJJxIIS7
         aXmo10owkJ2XE3ELLKovazenSQ+d1lQT0HgrcXqydhIUPrFurEpSDIyPMV86F6zo7Bm1
         W8Hg==
X-Gm-Message-State: APjAAAUDV0cRSBco1/uRTFICcmo7rykVTvd99MoigUzBUk8ZfrvY813u
        96Q+W5sXoNimoZucikW1twziVZpQ
X-Google-Smtp-Source: APXvYqwZ6iEzQj9zkSg8Sdy0uyZ3Zc6t+uAkUZZm2DLdBTdDz3ssC37aQ4kzDIZz3WyD2xEIl3b+Qg==
X-Received: by 2002:a05:620a:12ea:: with SMTP id f10mr24831685qkl.28.1557776657144;
        Mon, 13 May 2019 12:44:17 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id s42sm8856007qth.45.2019.05.13.12.43.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 12:44:16 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0381E403AD; Mon, 13 May 2019 16:43:17 -0300 (-03)
Date:   Mon, 13 May 2019 16:43:17 -0300
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] perf record: collect user registers set jointly with
 dwarf stacks
Message-ID: <20190513194317.GA3198@kernel.org>
References: <b34d8f60-9163-beac-7faa-4fa5e897c0f7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b34d8f60-9163-beac-7faa-4fa5e897c0f7@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 22, 2019 at 05:37:52PM +0300, Alexey Budankov escreveu:
> 
> When dwarf stacks are collected jointly with user specified register
> set using --user-regs option like below the full register context is
> still captured on a sample:
> 
>   $ perf record -g --call-graph dwarf,1024 --user-regs=IP,SP,BP -- matrix.gcc.g.O3
> 
>   188143843893585 0x6b48 [0x4f8]: PERF_RECORD_SAMPLE(IP, 0x4002): 23828/23828: 0x401236 period: 1363819 addr: 0x7ffedbdd51ac
>   ... FP chain: nr:0
>   ... user regs: mask 0xff0fff ABI 64-bit
>   .... AX    0x53b
>   .... BX    0x7ffedbdd3cc0
>   .... CX    0xffffffff
>   .... DX    0x33d3a
>   .... SI    0x7f09b74c38d0
>   .... DI    0x0
>   .... BP    0x401260
>   .... SP    0x7ffedbdd3cc0
>   .... IP    0x401236
>   .... FLAGS 0x20a
>   .... CS    0x33
>   .... SS    0x2b
>   .... R8    0x7f09b74c3800
>   .... R9    0x7f09b74c2da0
>   .... R10   0xfffffffffffff3ce
>   .... R11   0x246
>   .... R12   0x401070
>   .... R13   0x7ffedbdd5db0
>   .... R14   0x0
>   .... R15   0x0
>   ... ustack: size 1024, offset 0xe0
>    . data_src: 0x5080021
>    ... thread: stack_test2.g.O:23828
>    ...... dso: /root/abudanko/stacks/stack_test2.g.O3
> 
> After applying the change suggested in the patch the sample data contain
> only user specified register values:
> 
>   $ perf record -g --call-graph dwarf,1024 --user-regs=BP -- matrix.gcc.g.03
> 
>   188368474305373 0x5e40 [0x470]: PERF_RECORD_SAMPLE(IP, 0x4002): 23839/23839: 0x401236 period: 1260507 addr: 0x7ffd3d85e96c
>   ... FP chain: nr:0
>   ... user regs: mask 0x1c0 ABI 64-bit
>   .... BP    0x401260
>   .... SP    0x7ffd3d85cc20
>   .... IP    0x401236
>   ... ustack: size 1024, offset 0x58
>    . data_src: 0x5080021
>    ... thread: stack_test2.g.O:23839
>    ...... dso: /root/abudanko/stacks/stack_test2.g.O3
> 
> IP and SP registers (dwarf_regs) are collected anayways regardless of
> the --user-regs option value provided from the command line:

So user asks for a, b and c and gets a, b, c + d and e? At the very
least we should warn that those registers are being added to the mix,
i.e. something like:

WARNING: specified --user-regs register set doesn't include registers
needed by also specified --call-graph=dwarf, auto adding missing
registers (list of missing registers auto-added).

- Arnaldo

P.S. Back from vacation, going thru backlog, hopefully will apply your
perf.data compression patchkit after testing its patches one by one,
sorry for the delay for that one (and this :))
 
>   -g call-graph dwarf,K                         full_regs
>   -g call-graph dwarf,K --user-regs=user_regs	user_regs | dwarf_regs
>   --user-regs=user_regs                         user_regs
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
> Changes in v3:
> - avoid changes in platform specific header files
> 
> Changes in v2:
> - implemented dwarf register set to avoid corrupted trace 
>   when --user-regs option value omits IP,SP
> 
> ---
>  tools/perf/util/evsel.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 84cfb9fe2fc6..e5e61ee3c6e7 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -669,6 +669,9 @@ int perf_evsel__group_desc(struct perf_evsel *evsel, char *buf, size_t size)
>  	return ret;
>  }
>  
> +#define DWARF_REGS_MASK ((1ULL << PERF_REG_IP) | \
> +			 (1ULL << PERF_REG_SP))
> +
>  static void __perf_evsel__config_callchain(struct perf_evsel *evsel,
>  					   struct record_opts *opts,
>  					   struct callchain_param *param)
> @@ -702,7 +705,10 @@ static void __perf_evsel__config_callchain(struct perf_evsel *evsel,
>  		if (!function) {
>  			perf_evsel__set_sample_bit(evsel, REGS_USER);
>  			perf_evsel__set_sample_bit(evsel, STACK_USER);
> -			attr->sample_regs_user |= PERF_REGS_MASK;
> +			if (opts->sample_user_regs)
> +				attr->sample_regs_user |= DWARF_REGS_MASK;
> +			else
> +				attr->sample_regs_user |= PERF_REGS_MASK;
>  			attr->sample_stack_user = param->dump_size;
>  			attr->exclude_callchain_user = 1;
>  		} else {
> -- 
> 2.20.1

-- 

- Arnaldo
