Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A01C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDED6208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erG8sMXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbfFQQAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 12:00:21 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]:33544 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbfFQQAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 12:00:20 -0400
Received: by mail-qk1-f175.google.com with SMTP id r6so6514017qkc.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 09:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gQdQx+tCWDPyy/9UDOIuFTwtIpBuDWpkuhd+XgoWxXA=;
        b=erG8sMXr2Fdpxxmq/d3hC3657nCW1K/YVE2dJpzb6MhnIiJJC4ieM1MgYq9X1PSLsI
         eJ0RzlXBvb5LbaVuSpnaEOCrZxQgAlfycgtM00nodNj3Hx3sckdo//CsPxaiYcJzlEf/
         dOMLluQDyTTLsON8UNSfn39Lp4pTMrv/Wspumf6xLxs9Jdfs09INgmXyC7cM68WypHFC
         /FIOm2tV9SwCZYl0KYol0w34rE0oWTTlZZSRlaMaXr4Vwj+7wAJZJairZQJ8MFUKfjOJ
         WfgGjpATeLhQzvYpDAPrmE6e0Nmh1nv7QJhGlR399ZR+NrW9eneEs7UlRr26GW2R/dkH
         FYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gQdQx+tCWDPyy/9UDOIuFTwtIpBuDWpkuhd+XgoWxXA=;
        b=kbPycGzuOSC2IoKR1zHiTHH9AupwUy+3r0CmLJvCadQfaqZS+WSMR8j5MyqZ9MghM0
         2teByjbyD0rN7q1RvQV7hPDbkSKbKWtxZJEXM3SPmffU26KFLz2ebKqX8UItQxA1/t7d
         yijsLNggQ9mJZxeU/NFYKZRdujSBc+yEa4iP7xXVm6dKJNHKt5F++YqrMatFIfeNVpfU
         QBUsL2h2q9lnfljj5Gpl/rhTLL4mQxSK4GBGsWaCjAp0ISh3iOwn05WL5tqblTzzMTKR
         tb9nQU6WCtbjlMEKYFMzm5HdoMiKOzu/oJiAFZOH80kGhpJau5eABfFKGHUUyKepCpwK
         B4rQ==
X-Gm-Message-State: APjAAAXp79YfPVyicgQokQ8cSttVTLjn+u3ZRox07eGfyZmgXTAaThxs
        LlWE8VEo4e6VErrMhoJoVno=
X-Google-Smtp-Source: APXvYqw6J9aKpYbckaYyrNnIMgxkcnvqk3QVZvEhdT+VKdJBjPQPWz03+9Xxzi9PK01uk6wDXQsJzA==
X-Received: by 2002:a37:624c:: with SMTP id w73mr70663346qkb.139.1560787216090;
        Mon, 17 Jun 2019 09:00:16 -0700 (PDT)
Received: from quaco.ghostprotocols.net (179-240-145-61.3g.claro.net.br. [179.240.145.61])
        by smtp.gmail.com with ESMTPSA id u19sm7917983qka.35.2019.06.17.09.00.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 09:00:15 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D297741149; Mon, 17 Jun 2019 13:00:11 -0300 (-03)
Date:   Mon, 17 Jun 2019 13:00:11 -0300
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Andi Kleen <andi@firstfloor.org>,
        Kan Liang <kan.liang@intel.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf: Add missing newline at end of file
Message-ID: <20190617160011.GB3927@kernel.org>
References: <20190617144725.6415-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617144725.6415-1-geert+renesas@glider.be>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 17, 2019 at 04:47:25PM +0200, Geert Uytterhoeven escreveu:
> "git diff" says:
> 
>     \ No newline at end of file
> 
> after modifying the files.

Auto generated files, IIRC, Andi, Kan, Sukadev?

- Arnaldo
 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  tools/perf/pmu-events/arch/powerpc/power9/cache.json            | 2 +-
>  tools/perf/pmu-events/arch/powerpc/power9/floating-point.json   | 2 +-
>  tools/perf/pmu-events/arch/powerpc/power9/frontend.json         | 2 +-
>  tools/perf/pmu-events/arch/powerpc/power9/marked.json           | 2 +-
>  tools/perf/pmu-events/arch/powerpc/power9/memory.json           | 2 +-
>  tools/perf/pmu-events/arch/powerpc/power9/other.json            | 2 +-
>  tools/perf/pmu-events/arch/powerpc/power9/pipeline.json         | 2 +-
>  tools/perf/pmu-events/arch/powerpc/power9/pmc.json              | 2 +-
>  tools/perf/pmu-events/arch/powerpc/power9/translation.json      | 2 +-
>  tools/perf/pmu-events/arch/x86/bonnell/cache.json               | 2 +-
>  tools/perf/pmu-events/arch/x86/bonnell/floating-point.json      | 2 +-
>  tools/perf/pmu-events/arch/x86/bonnell/frontend.json            | 2 +-
>  tools/perf/pmu-events/arch/x86/bonnell/memory.json              | 2 +-
>  tools/perf/pmu-events/arch/x86/bonnell/other.json               | 2 +-
>  tools/perf/pmu-events/arch/x86/bonnell/pipeline.json            | 2 +-
>  tools/perf/pmu-events/arch/x86/bonnell/virtual-memory.json      | 2 +-
>  tools/perf/pmu-events/arch/x86/broadwell/cache.json             | 2 +-
>  tools/perf/pmu-events/arch/x86/broadwell/floating-point.json    | 2 +-
>  tools/perf/pmu-events/arch/x86/broadwell/frontend.json          | 2 +-
>  tools/perf/pmu-events/arch/x86/broadwell/memory.json            | 2 +-
>  tools/perf/pmu-events/arch/x86/broadwell/other.json             | 2 +-
>  tools/perf/pmu-events/arch/x86/broadwell/pipeline.json          | 2 +-
>  tools/perf/pmu-events/arch/x86/broadwell/uncore.json            | 2 +-
>  tools/perf/pmu-events/arch/x86/broadwell/virtual-memory.json    | 2 +-
>  tools/perf/pmu-events/arch/x86/broadwellde/cache.json           | 2 +-
>  tools/perf/pmu-events/arch/x86/broadwellde/floating-point.json  | 2 +-
>  tools/perf/pmu-events/arch/x86/broadwellde/frontend.json        | 2 +-
>  tools/perf/pmu-events/arch/x86/broadwellde/memory.json          | 2 +-
>  tools/perf/pmu-events/arch/x86/broadwellde/other.json           | 2 +-
>  tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json        | 2 +-
>  tools/perf/pmu-events/arch/x86/broadwellde/virtual-memory.json  | 2 +-
>  tools/perf/pmu-events/arch/x86/broadwellx/cache.json            | 2 +-
>  tools/perf/pmu-events/arch/x86/broadwellx/floating-point.json   | 2 +-
>  tools/perf/pmu-events/arch/x86/broadwellx/frontend.json         | 2 +-
>  tools/perf/pmu-events/arch/x86/broadwellx/memory.json           | 2 +-
>  tools/perf/pmu-events/arch/x86/broadwellx/other.json            | 2 +-
>  tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json         | 2 +-
>  tools/perf/pmu-events/arch/x86/broadwellx/virtual-memory.json   | 2 +-
>  tools/perf/pmu-events/arch/x86/cascadelakex/cache.json          | 2 +-
>  tools/perf/pmu-events/arch/x86/cascadelakex/floating-point.json | 2 +-
>  tools/perf/pmu-events/arch/x86/cascadelakex/frontend.json       | 2 +-
>  tools/perf/pmu-events/arch/x86/cascadelakex/memory.json         | 2 +-
>  tools/perf/pmu-events/arch/x86/cascadelakex/other.json          | 2 +-
>  tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json       | 2 +-
>  tools/perf/pmu-events/arch/x86/cascadelakex/virtual-memory.json | 2 +-
>  tools/perf/pmu-events/arch/x86/goldmont/cache.json              | 2 +-
>  tools/perf/pmu-events/arch/x86/goldmont/frontend.json           | 2 +-
>  tools/perf/pmu-events/arch/x86/goldmont/memory.json             | 2 +-
>  tools/perf/pmu-events/arch/x86/goldmont/other.json              | 2 +-
>  tools/perf/pmu-events/arch/x86/goldmont/pipeline.json           | 2 +-
>  tools/perf/pmu-events/arch/x86/goldmont/virtual-memory.json     | 2 +-
>  tools/perf/pmu-events/arch/x86/goldmontplus/cache.json          | 2 +-
>  tools/perf/pmu-events/arch/x86/goldmontplus/frontend.json       | 2 +-
>  tools/perf/pmu-events/arch/x86/goldmontplus/memory.json         | 2 +-
>  tools/perf/pmu-events/arch/x86/goldmontplus/other.json          | 2 +-
>  tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json       | 2 +-
>  tools/perf/pmu-events/arch/x86/goldmontplus/virtual-memory.json | 2 +-
>  tools/perf/pmu-events/arch/x86/haswell/cache.json               | 2 +-
>  tools/perf/pmu-events/arch/x86/haswell/floating-point.json      | 2 +-
>  tools/perf/pmu-events/arch/x86/haswell/frontend.json            | 2 +-
>  tools/perf/pmu-events/arch/x86/haswell/memory.json              | 2 +-
>  tools/perf/pmu-events/arch/x86/haswell/other.json               | 2 +-
>  tools/perf/pmu-events/arch/x86/haswell/pipeline.json            | 2 +-
>  tools/perf/pmu-events/arch/x86/haswell/uncore.json              | 2 +-
>  tools/perf/pmu-events/arch/x86/haswell/virtual-memory.json      | 2 +-
>  tools/perf/pmu-events/arch/x86/haswellx/cache.json              | 2 +-
>  tools/perf/pmu-events/arch/x86/haswellx/floating-point.json     | 2 +-
>  tools/perf/pmu-events/arch/x86/haswellx/frontend.json           | 2 +-
>  tools/perf/pmu-events/arch/x86/haswellx/memory.json             | 2 +-
>  tools/perf/pmu-events/arch/x86/haswellx/other.json              | 2 +-
>  tools/perf/pmu-events/arch/x86/haswellx/pipeline.json           | 2 +-
>  tools/perf/pmu-events/arch/x86/haswellx/virtual-memory.json     | 2 +-
>  tools/perf/pmu-events/arch/x86/ivybridge/cache.json             | 2 +-
>  tools/perf/pmu-events/arch/x86/ivybridge/floating-point.json    | 2 +-
>  tools/perf/pmu-events/arch/x86/ivybridge/frontend.json          | 2 +-
>  tools/perf/pmu-events/arch/x86/ivybridge/memory.json            | 2 +-
>  tools/perf/pmu-events/arch/x86/ivybridge/other.json             | 2 +-
>  tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json          | 2 +-
>  tools/perf/pmu-events/arch/x86/ivybridge/uncore.json            | 2 +-
>  tools/perf/pmu-events/arch/x86/ivybridge/virtual-memory.json    | 2 +-
>  tools/perf/pmu-events/arch/x86/ivytown/cache.json               | 2 +-
>  tools/perf/pmu-events/arch/x86/ivytown/floating-point.json      | 2 +-
>  tools/perf/pmu-events/arch/x86/ivytown/frontend.json            | 2 +-
>  tools/perf/pmu-events/arch/x86/ivytown/memory.json              | 2 +-
>  tools/perf/pmu-events/arch/x86/ivytown/other.json               | 2 +-
>  tools/perf/pmu-events/arch/x86/ivytown/pipeline.json            | 2 +-
>  tools/perf/pmu-events/arch/x86/ivytown/virtual-memory.json      | 2 +-
>  tools/perf/pmu-events/arch/x86/jaketown/cache.json              | 2 +-
>  tools/perf/pmu-events/arch/x86/jaketown/floating-point.json     | 2 +-
>  tools/perf/pmu-events/arch/x86/jaketown/frontend.json           | 2 +-
>  tools/perf/pmu-events/arch/x86/jaketown/memory.json             | 2 +-
>  tools/perf/pmu-events/arch/x86/jaketown/other.json              | 2 +-
>  tools/perf/pmu-events/arch/x86/jaketown/pipeline.json           | 2 +-
>  tools/perf/pmu-events/arch/x86/jaketown/virtual-memory.json     | 2 +-
>  tools/perf/pmu-events/arch/x86/knightslanding/cache.json        | 2 +-
>  tools/perf/pmu-events/arch/x86/knightslanding/frontend.json     | 2 +-
>  tools/perf/pmu-events/arch/x86/knightslanding/memory.json       | 2 +-
>  tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json     | 2 +-
>  .../perf/pmu-events/arch/x86/knightslanding/virtual-memory.json | 2 +-
>  tools/perf/pmu-events/arch/x86/nehalemep/cache.json             | 2 +-
>  tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json    | 2 +-
>  tools/perf/pmu-events/arch/x86/nehalemep/frontend.json          | 2 +-
>  tools/perf/pmu-events/arch/x86/nehalemep/memory.json            | 2 +-
>  tools/perf/pmu-events/arch/x86/nehalemep/other.json             | 2 +-
>  tools/perf/pmu-events/arch/x86/nehalemep/pipeline.json          | 2 +-
>  tools/perf/pmu-events/arch/x86/nehalemep/virtual-memory.json    | 2 +-
>  tools/perf/pmu-events/arch/x86/nehalemex/cache.json             | 2 +-
>  tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json    | 2 +-
>  tools/perf/pmu-events/arch/x86/nehalemex/frontend.json          | 2 +-
>  tools/perf/pmu-events/arch/x86/nehalemex/memory.json            | 2 +-
>  tools/perf/pmu-events/arch/x86/nehalemex/other.json             | 2 +-
>  tools/perf/pmu-events/arch/x86/nehalemex/pipeline.json          | 2 +-
>  tools/perf/pmu-events/arch/x86/nehalemex/virtual-memory.json    | 2 +-
>  tools/perf/pmu-events/arch/x86/sandybridge/cache.json           | 2 +-
>  tools/perf/pmu-events/arch/x86/sandybridge/floating-point.json  | 2 +-
>  tools/perf/pmu-events/arch/x86/sandybridge/frontend.json        | 2 +-
>  tools/perf/pmu-events/arch/x86/sandybridge/memory.json          | 2 +-
>  tools/perf/pmu-events/arch/x86/sandybridge/other.json           | 2 +-
>  tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json        | 2 +-
>  tools/perf/pmu-events/arch/x86/sandybridge/uncore.json          | 2 +-
>  tools/perf/pmu-events/arch/x86/sandybridge/virtual-memory.json  | 2 +-
>  tools/perf/pmu-events/arch/x86/silvermont/cache.json            | 2 +-
>  tools/perf/pmu-events/arch/x86/silvermont/frontend.json         | 2 +-
>  tools/perf/pmu-events/arch/x86/silvermont/memory.json           | 2 +-
>  tools/perf/pmu-events/arch/x86/silvermont/other.json            | 2 +-
>  tools/perf/pmu-events/arch/x86/silvermont/pipeline.json         | 2 +-
>  tools/perf/pmu-events/arch/x86/silvermont/virtual-memory.json   | 2 +-
>  tools/perf/pmu-events/arch/x86/skylake/cache.json               | 2 +-
>  tools/perf/pmu-events/arch/x86/skylake/floating-point.json      | 2 +-
>  tools/perf/pmu-events/arch/x86/skylake/frontend.json            | 2 +-
>  tools/perf/pmu-events/arch/x86/skylake/memory.json              | 2 +-
>  tools/perf/pmu-events/arch/x86/skylake/other.json               | 2 +-
>  tools/perf/pmu-events/arch/x86/skylake/pipeline.json            | 2 +-
>  tools/perf/pmu-events/arch/x86/skylake/uncore.json              | 2 +-
>  tools/perf/pmu-events/arch/x86/skylake/virtual-memory.json      | 2 +-
>  tools/perf/pmu-events/arch/x86/skylakex/cache.json              | 2 +-
>  tools/perf/pmu-events/arch/x86/skylakex/floating-point.json     | 2 +-
>  tools/perf/pmu-events/arch/x86/skylakex/frontend.json           | 2 +-
>  tools/perf/pmu-events/arch/x86/skylakex/memory.json             | 2 +-
>  tools/perf/pmu-events/arch/x86/skylakex/other.json              | 2 +-
>  tools/perf/pmu-events/arch/x86/skylakex/pipeline.json           | 2 +-
>  tools/perf/pmu-events/arch/x86/skylakex/virtual-memory.json     | 2 +-
>  tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json         | 2 +-
>  .../perf/pmu-events/arch/x86/westmereep-dp/floating-point.json  | 2 +-
>  tools/perf/pmu-events/arch/x86/westmereep-dp/frontend.json      | 2 +-
>  tools/perf/pmu-events/arch/x86/westmereep-dp/memory.json        | 2 +-
>  tools/perf/pmu-events/arch/x86/westmereep-dp/other.json         | 2 +-
>  tools/perf/pmu-events/arch/x86/westmereep-dp/pipeline.json      | 2 +-
>  .../perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json  | 2 +-
>  tools/perf/pmu-events/arch/x86/westmereep-sp/cache.json         | 2 +-
>  .../perf/pmu-events/arch/x86/westmereep-sp/floating-point.json  | 2 +-
>  tools/perf/pmu-events/arch/x86/westmereep-sp/frontend.json      | 2 +-
>  tools/perf/pmu-events/arch/x86/westmereep-sp/memory.json        | 2 +-
>  tools/perf/pmu-events/arch/x86/westmereep-sp/other.json         | 2 +-
>  tools/perf/pmu-events/arch/x86/westmereep-sp/pipeline.json      | 2 +-
>  .../perf/pmu-events/arch/x86/westmereep-sp/virtual-memory.json  | 2 +-
>  tools/perf/pmu-events/arch/x86/westmereex/cache.json            | 2 +-
>  tools/perf/pmu-events/arch/x86/westmereex/floating-point.json   | 2 +-
>  tools/perf/pmu-events/arch/x86/westmereex/frontend.json         | 2 +-
>  tools/perf/pmu-events/arch/x86/westmereex/memory.json           | 2 +-
>  tools/perf/pmu-events/arch/x86/westmereex/other.json            | 2 +-
>  tools/perf/pmu-events/arch/x86/westmereex/pipeline.json         | 2 +-
>  tools/perf/pmu-events/arch/x86/westmereex/virtual-memory.json   | 2 +-
>  tools/perf/scripts/python/bin/intel-pt-events-report            | 2 +-
>  164 files changed, 164 insertions(+), 164 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/powerpc/power9/cache.json b/tools/perf/pmu-events/arch/powerpc/power9/cache.json
> index 8510721050544204..222d954f829d87cc 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power9/cache.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power9/cache.json
> @@ -104,4 +104,4 @@
>      "EventName": "PM_CMPLU_STALL_LARX",
>      "BriefDescription": "Finish stall because the NTF instruction was a larx waiting to be satisfied"
>    }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/powerpc/power9/floating-point.json b/tools/perf/pmu-events/arch/powerpc/power9/floating-point.json
> index 8a83bca26552a149..18c1df3bef08896f 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power9/floating-point.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power9/floating-point.json
> @@ -29,4 +29,4 @@
>      "EventName": "PM_THRESH_NOT_MET",
>      "BriefDescription": "Threshold counter did not meet threshold"
>    }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/powerpc/power9/frontend.json b/tools/perf/pmu-events/arch/powerpc/power9/frontend.json
> index f9fa84b16fb5968b..0656c1ac3458131c 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power9/frontend.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power9/frontend.json
> @@ -354,4 +354,4 @@
>      "EventName": "PM_IPTEG_FROM_L31_ECO_MOD",
>      "BriefDescription": "A Page Table Entry was loaded into the TLB with Modified (M) data from another core's ECO L3 on the same chip due to a instruction side request"
>    }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/powerpc/power9/marked.json b/tools/perf/pmu-events/arch/powerpc/power9/marked.json
> index b1954c38bab1a5d8..cb41a7add534fd94 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power9/marked.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power9/marked.json
> @@ -624,4 +624,4 @@
>      "EventName": "PM_MRK_BR_MPRED_CMPL",
>      "BriefDescription": "Marked Branch Mispredicted"
>    }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/powerpc/power9/memory.json b/tools/perf/pmu-events/arch/powerpc/power9/memory.json
> index 2e2ebc700c747ab0..d471601d89cf6628 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power9/memory.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power9/memory.json
> @@ -124,4 +124,4 @@
>      "EventName": "PM_DARQ1_4_6_ENTRIES",
>      "BriefDescription": "Cycles in which 4, 5, or 6 DARQ1 entries (out of 12) are in use"
>    }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/powerpc/power9/other.json b/tools/perf/pmu-events/arch/powerpc/power9/other.json
> index 48cf4f920b3ff09d..c47fec746f292bc5 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power9/other.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power9/other.json
> @@ -2334,4 +2334,4 @@
>      "EventName": "PM_L3_PF_USAGE",
>      "BriefDescription": "Rotating sample of 32 PF actives"
>    }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json b/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
> index b4772f54a271890e..536fbde7ed7e0d63 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
> @@ -529,4 +529,4 @@
>      "EventName": "PM_MRK_DATA_FROM_L21_SHR_CYC",
>      "BriefDescription": "Duration in cycles to reload with Shared (S) data from another core's L2 on the same chip due to a marked load"
>    }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/powerpc/power9/pmc.json b/tools/perf/pmu-events/arch/powerpc/power9/pmc.json
> index 8b3b0f3be6644c65..98b08ce2d2ccb721 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power9/pmc.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power9/pmc.json
> @@ -114,4 +114,4 @@
>      "EventName": "PM_1FLOP_CMPL",
>      "BriefDescription": "one flop (fadd, fmul, fsub, fcmp, fsel, fabs, fnabs, fres, fsqrte, fneg) operation completed"
>    }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/powerpc/power9/translation.json b/tools/perf/pmu-events/arch/powerpc/power9/translation.json
> index b27642676244576c..d8721c4d22332030 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power9/translation.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power9/translation.json
> @@ -224,4 +224,4 @@
>      "EventName": "PM_CMPLU_STALL_TLBIE",
>      "BriefDescription": "Finish stall because the NTF instruction was a tlbie waiting for response from L2"
>    }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/bonnell/cache.json b/tools/perf/pmu-events/arch/x86/bonnell/cache.json
> index ffab90c5891c6fe9..66179defeda9b217 100644
> --- a/tools/perf/pmu-events/arch/x86/bonnell/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/bonnell/cache.json
> @@ -743,4 +743,4 @@
>          "SampleAfterValue": "10000",
>          "BriefDescription": "Retired loads that miss the L2 cache"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/bonnell/floating-point.json b/tools/perf/pmu-events/arch/x86/bonnell/floating-point.json
> index f0e090cdb9f0543c..70c36a70ec711ee3 100644
> --- a/tools/perf/pmu-events/arch/x86/bonnell/floating-point.json
> +++ b/tools/perf/pmu-events/arch/x86/bonnell/floating-point.json
> @@ -258,4 +258,4 @@
>          "SampleAfterValue": "2000000",
>          "BriefDescription": "Saturated arithmetic instructions retired."
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/bonnell/frontend.json b/tools/perf/pmu-events/arch/x86/bonnell/frontend.json
> index ef69540ab61dbbce..db6415c0d4ec0b04 100644
> --- a/tools/perf/pmu-events/arch/x86/bonnell/frontend.json
> +++ b/tools/perf/pmu-events/arch/x86/bonnell/frontend.json
> @@ -80,4 +80,4 @@
>          "BriefDescription": "This event counts the cycles where 1 or more uops are issued by the micro-sequencer (MS), including microcode assists and inserted flows, and written to the IQ.",
>          "CounterMask": "1"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/bonnell/memory.json b/tools/perf/pmu-events/arch/x86/bonnell/memory.json
> index 3ae843b20c8acfd3..0655462932ec2802 100644
> --- a/tools/perf/pmu-events/arch/x86/bonnell/memory.json
> +++ b/tools/perf/pmu-events/arch/x86/bonnell/memory.json
> @@ -151,4 +151,4 @@
>          "SampleAfterValue": "200000",
>          "BriefDescription": "Any Software prefetch"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/bonnell/other.json b/tools/perf/pmu-events/arch/x86/bonnell/other.json
> index 4bc1c582d1cd2c0e..e7c1ada258b794b5 100644
> --- a/tools/perf/pmu-events/arch/x86/bonnell/other.json
> +++ b/tools/perf/pmu-events/arch/x86/bonnell/other.json
> @@ -447,4 +447,4 @@
>          "SampleAfterValue": "200000",
>          "BriefDescription": "Hardware interrupts received."
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/bonnell/pipeline.json b/tools/perf/pmu-events/arch/x86/bonnell/pipeline.json
> index 09c6de13de20dd3c..333a97217cb239ce 100644
> --- a/tools/perf/pmu-events/arch/x86/bonnell/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/bonnell/pipeline.json
> @@ -361,4 +361,4 @@
>          "SampleAfterValue": "200000",
>          "BriefDescription": "Micro-op reissues on a store-load collision (At Retirement)"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/bonnell/virtual-memory.json b/tools/perf/pmu-events/arch/x86/bonnell/virtual-memory.json
> index 7bb8175887217b2c..9ac07962530bee81 100644
> --- a/tools/perf/pmu-events/arch/x86/bonnell/virtual-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/bonnell/virtual-memory.json
> @@ -121,4 +121,4 @@
>          "SampleAfterValue": "200000",
>          "BriefDescription": "Retired loads that miss the DTLB (precise event)."
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/broadwell/cache.json b/tools/perf/pmu-events/arch/x86/broadwell/cache.json
> index 7938bf5689abae4c..889dba72d3f9aa5c 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwell/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwell/cache.json
> @@ -3396,4 +3396,4 @@
>          "Offcore": "1",
>          "CounterHTOff": "0,1,2,3"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/broadwell/floating-point.json b/tools/perf/pmu-events/arch/x86/broadwell/floating-point.json
> index 15291239c1285375..0dc65066535da3c3 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwell/floating-point.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwell/floating-point.json
> @@ -169,4 +169,4 @@
>          "CounterMask": "1",
>          "CounterHTOff": "0,1,2,3"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/broadwell/frontend.json b/tools/perf/pmu-events/arch/x86/broadwell/frontend.json
> index aa4a5d762f212bf5..d33eae0e69a64eca 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwell/frontend.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwell/frontend.json
> @@ -283,4 +283,4 @@
>          "BriefDescription": "Decode Stream Buffer (DSB)-to-MITE switch true penalty cycles.",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/broadwell/memory.json b/tools/perf/pmu-events/arch/x86/broadwell/memory.json
> index b6b5247d3d5a79b4..597abc42da75845b 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwell/memory.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwell/memory.json
> @@ -3042,4 +3042,4 @@
>          "Offcore": "1",
>          "CounterHTOff": "0,1,2,3"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/broadwell/other.json b/tools/perf/pmu-events/arch/x86/broadwell/other.json
> index 4f829c5febbe6f89..dd4e44d99618ad9e 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwell/other.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwell/other.json
> @@ -41,4 +41,4 @@
>          "BriefDescription": "Cycles when L1 and L2 are locked due to UC or split lock",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json b/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
> index bb25574b8d212f5e..f5f45deade9642aa 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
> @@ -1426,4 +1426,4 @@
>          "BriefDescription": "Counts the total number when the front end is resteered, mainly when the BPU cannot provide a correct prediction and this is corrected by other branch handling mechanisms at the front end.",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/broadwell/uncore.json b/tools/perf/pmu-events/arch/x86/broadwell/uncore.json
> index 28e1e159a3cb5a44..0849ba08c3ff7b65 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwell/uncore.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwell/uncore.json
> @@ -275,4 +275,4 @@
>      "Invert": "0",
>      "EdgeDetect": "0"
>    }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/broadwell/virtual-memory.json b/tools/perf/pmu-events/arch/x86/broadwell/virtual-memory.json
> index 2a015e4c7e21a9c6..a07319c626ed6adc 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwell/virtual-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwell/virtual-memory.json
> @@ -385,4 +385,4 @@
>          "BriefDescription": "STLB flush attempts",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/cache.json b/tools/perf/pmu-events/arch/x86/broadwellde/cache.json
> index bf243fe2a0ec3c64..c873ccd8ae359cfe 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellde/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellde/cache.json
> @@ -806,4 +806,4 @@
>          "SampleAfterValue": "100003",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/floating-point.json b/tools/perf/pmu-events/arch/x86/broadwellde/floating-point.json
> index d7b9d9c9c518850c..044974bb906535ad 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellde/floating-point.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellde/floating-point.json
> @@ -162,4 +162,4 @@
>          "SampleAfterValue": "100003",
>          "CounterHTOff": "0,1,2,3"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/frontend.json b/tools/perf/pmu-events/arch/x86/broadwellde/frontend.json
> index 72781e1e3362fe41..d62e60ac92f7014e 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellde/frontend.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellde/frontend.json
> @@ -283,4 +283,4 @@
>          "SampleAfterValue": "2000003",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/memory.json b/tools/perf/pmu-events/arch/x86/broadwellde/memory.json
> index e44f73c24ac8555c..243f7c72840fdb41 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellde/memory.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellde/memory.json
> @@ -429,4 +429,4 @@
>          "SampleAfterValue": "101",
>          "CounterHTOff": "3"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/other.json b/tools/perf/pmu-events/arch/x86/broadwellde/other.json
> index 4475249ea9da6ac3..bb06ddd28007cd89 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellde/other.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellde/other.json
> @@ -41,4 +41,4 @@
>          "SampleAfterValue": "2000003",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json b/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
> index e2f0540625a240ac..2874145e34acaeb2 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
> @@ -1420,4 +1420,4 @@
>          "SampleAfterValue": "100003",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/virtual-memory.json b/tools/perf/pmu-events/arch/x86/broadwellde/virtual-memory.json
> index 7d79c707c6d150b5..1eb84d12804db071 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellde/virtual-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellde/virtual-memory.json
> @@ -385,4 +385,4 @@
>          "SampleAfterValue": "100007",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/cache.json b/tools/perf/pmu-events/arch/x86/broadwellx/cache.json
> index 75a3098d5775e89a..17c1c6013d556d6d 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellx/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellx/cache.json
> @@ -963,4 +963,4 @@
>          "SampleAfterValue": "100003",
>          "CounterHTOff": "0,1,2,3"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/floating-point.json b/tools/perf/pmu-events/arch/x86/broadwellx/floating-point.json
> index ba0e0c4e74eb21ac..2285dfeb5a7367a1 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellx/floating-point.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellx/floating-point.json
> @@ -162,4 +162,4 @@
>          "SampleAfterValue": "100003",
>          "CounterHTOff": "0,1,2,3"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/frontend.json b/tools/perf/pmu-events/arch/x86/broadwellx/frontend.json
> index 72781e1e3362fe41..d62e60ac92f7014e 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellx/frontend.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellx/frontend.json
> @@ -283,4 +283,4 @@
>          "SampleAfterValue": "2000003",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/memory.json b/tools/perf/pmu-events/arch/x86/broadwellx/memory.json
> index ecb413bb67cafbfa..18f96aa82752af4e 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellx/memory.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellx/memory.json
> @@ -676,4 +676,4 @@
>          "SampleAfterValue": "100003",
>          "CounterHTOff": "0,1,2,3"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/other.json b/tools/perf/pmu-events/arch/x86/broadwellx/other.json
> index 4475249ea9da6ac3..bb06ddd28007cd89 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellx/other.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellx/other.json
> @@ -41,4 +41,4 @@
>          "SampleAfterValue": "2000003",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json b/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
> index c2f6932a581737f0..27929cb7f0483205 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
> @@ -1420,4 +1420,4 @@
>          "SampleAfterValue": "100003",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/virtual-memory.json b/tools/perf/pmu-events/arch/x86/broadwellx/virtual-memory.json
> index 7d79c707c6d150b5..1eb84d12804db071 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellx/virtual-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellx/virtual-memory.json
> @@ -385,4 +385,4 @@
>          "SampleAfterValue": "100007",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/cache.json b/tools/perf/pmu-events/arch/x86/cascadelakex/cache.json
> index 143077c2caf49874..d8f6effe1bbce54e 100644
> --- a/tools/perf/pmu-events/arch/x86/cascadelakex/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/cascadelakex/cache.json
> @@ -10169,4 +10169,4 @@
>          "SampleAfterValue": "100003",
>          "CounterHTOff": "0,1,2,3"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/floating-point.json b/tools/perf/pmu-events/arch/x86/cascadelakex/floating-point.json
> index 91b38de138f2d675..a8919a0894c05e2e 100644
> --- a/tools/perf/pmu-events/arch/x86/cascadelakex/floating-point.json
> +++ b/tools/perf/pmu-events/arch/x86/cascadelakex/floating-point.json
> @@ -82,4 +82,4 @@
>          "SampleAfterValue": "100003",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/frontend.json b/tools/perf/pmu-events/arch/x86/cascadelakex/frontend.json
> index 954e64574ee28243..f88b44d891ee5cb6 100644
> --- a/tools/perf/pmu-events/arch/x86/cascadelakex/frontend.json
> +++ b/tools/perf/pmu-events/arch/x86/cascadelakex/frontend.json
> @@ -479,4 +479,4 @@
>          "SampleAfterValue": "100007",
>          "CounterHTOff": "0,1,2,3"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/memory.json b/tools/perf/pmu-events/arch/x86/cascadelakex/memory.json
> index dfee925963795eae..a0c89ef8224d6270 100644
> --- a/tools/perf/pmu-events/arch/x86/cascadelakex/memory.json
> +++ b/tools/perf/pmu-events/arch/x86/cascadelakex/memory.json
> @@ -9906,4 +9906,4 @@
>          "SampleAfterValue": "100003",
>          "CounterHTOff": "0,1,2,3"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/other.json b/tools/perf/pmu-events/arch/x86/cascadelakex/other.json
> index 73e27c48bd6e36b3..9b326ff4c6d89723 100644
> --- a/tools/perf/pmu-events/arch/x86/cascadelakex/other.json
> +++ b/tools/perf/pmu-events/arch/x86/cascadelakex/other.json
> @@ -8905,4 +8905,4 @@
>          "SampleAfterValue": "100003",
>          "CounterHTOff": "0,1,2,3"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json b/tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json
> index 5b7df05f900cc0d9..51900c3e55f396dc 100644
> --- a/tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json
> @@ -966,4 +966,4 @@
>          "SampleAfterValue": "100003",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/virtual-memory.json b/tools/perf/pmu-events/arch/x86/cascadelakex/virtual-memory.json
> index 579733168e233dde..ec5811b3275b5f4a 100644
> --- a/tools/perf/pmu-events/arch/x86/cascadelakex/virtual-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/cascadelakex/virtual-memory.json
> @@ -282,4 +282,4 @@
>          "SampleAfterValue": "100007",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/goldmont/cache.json b/tools/perf/pmu-events/arch/x86/goldmont/cache.json
> index 52a105666afcbc99..971e0c7964aac0a2 100644
> --- a/tools/perf/pmu-events/arch/x86/goldmont/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/goldmont/cache.json
> @@ -1302,4 +1302,4 @@
>          "BriefDescription": "Counts demand cacheable data reads of full cache lines that hit the L2 cache.",
>          "Offcore": "1"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/goldmont/frontend.json b/tools/perf/pmu-events/arch/x86/goldmont/frontend.json
> index 9ba08518649ee5bc..d386539b2cb87e6b 100644
> --- a/tools/perf/pmu-events/arch/x86/goldmont/frontend.json
> +++ b/tools/perf/pmu-events/arch/x86/goldmont/frontend.json
> @@ -49,4 +49,4 @@
>          "SampleAfterValue": "200003",
>          "BriefDescription": "Decode restrictions due to predicting wrong instruction length"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/goldmont/memory.json b/tools/perf/pmu-events/arch/x86/goldmont/memory.json
> index 197dc76d49ddc75a..52a4111cbbd3b693 100644
> --- a/tools/perf/pmu-events/arch/x86/goldmont/memory.json
> +++ b/tools/perf/pmu-events/arch/x86/goldmont/memory.json
> @@ -31,4 +31,4 @@
>          "SampleAfterValue": "200003",
>          "BriefDescription": "Machine clears due to memory ordering issue"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/goldmont/other.json b/tools/perf/pmu-events/arch/x86/goldmont/other.json
> index 959cadd7cb0e8171..d3b6fe6b7216c2f5 100644
> --- a/tools/perf/pmu-events/arch/x86/goldmont/other.json
> +++ b/tools/perf/pmu-events/arch/x86/goldmont/other.json
> @@ -79,4 +79,4 @@
>          "SampleAfterValue": "200003",
>          "BriefDescription": "Cycles pending interrupts are masked"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/goldmont/pipeline.json b/tools/perf/pmu-events/arch/x86/goldmont/pipeline.json
> index 6342368accf8a45c..98ebf2928dccd2f5 100644
> --- a/tools/perf/pmu-events/arch/x86/goldmont/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/goldmont/pipeline.json
> @@ -449,4 +449,4 @@
>          "SampleAfterValue": "200003",
>          "BriefDescription": "BACLEARs asserted for conditional branch"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/goldmont/virtual-memory.json b/tools/perf/pmu-events/arch/x86/goldmont/virtual-memory.json
> index 343d66bbd777003e..d755f197b08b44aa 100644
> --- a/tools/perf/pmu-events/arch/x86/goldmont/virtual-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/goldmont/virtual-memory.json
> @@ -75,4 +75,4 @@
>          "BriefDescription": "Memory uops retired that missed the DTLB (Precise event capable)",
>          "Data_LA": "1"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/goldmontplus/cache.json b/tools/perf/pmu-events/arch/x86/goldmontplus/cache.json
> index 5a6ac8285ad4bfe3..5f2641e4f7d99435 100644
> --- a/tools/perf/pmu-events/arch/x86/goldmontplus/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/goldmontplus/cache.json
> @@ -1464,4 +1464,4 @@
>          "BriefDescription": "Counts data read, code read, and read for ownership (RFO) requests (demand & prefetch) outstanding, per cycle, from the time of the L2 miss to when any response is received.",
>          "Offcore": "1"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/goldmontplus/frontend.json b/tools/perf/pmu-events/arch/x86/goldmontplus/frontend.json
> index a7878965ceab278a..eb1cd44a549ccea6 100644
> --- a/tools/perf/pmu-events/arch/x86/goldmontplus/frontend.json
> +++ b/tools/perf/pmu-events/arch/x86/goldmontplus/frontend.json
> @@ -59,4 +59,4 @@
>          "SampleAfterValue": "200003",
>          "BriefDescription": "Decode restrictions due to predicting wrong instruction length"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/goldmontplus/memory.json b/tools/perf/pmu-events/arch/x86/goldmontplus/memory.json
> index 91e0815f3ffbb15b..cf92358b3f101d7e 100644
> --- a/tools/perf/pmu-events/arch/x86/goldmontplus/memory.json
> +++ b/tools/perf/pmu-events/arch/x86/goldmontplus/memory.json
> @@ -35,4 +35,4 @@
>          "SampleAfterValue": "20003",
>          "BriefDescription": "Machine clears due to memory ordering issue"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/goldmontplus/other.json b/tools/perf/pmu-events/arch/x86/goldmontplus/other.json
> index b860374418abb1a4..8e50690050c9c2c1 100644
> --- a/tools/perf/pmu-events/arch/x86/goldmontplus/other.json
> +++ b/tools/perf/pmu-events/arch/x86/goldmontplus/other.json
> @@ -95,4 +95,4 @@
>          "SampleAfterValue": "200003",
>          "BriefDescription": "Cycles pending interrupts are masked"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json b/tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json
> index e3fa1a0ba71b6356..757f8828715712e0 100644
> --- a/tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json
> @@ -538,4 +538,4 @@
>          "SampleAfterValue": "200003",
>          "BriefDescription": "BACLEARs asserted for conditional branch"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/goldmontplus/virtual-memory.json b/tools/perf/pmu-events/arch/x86/goldmontplus/virtual-memory.json
> index 0d32fd26ded14e6c..da7fdfda3ec143fe 100644
> --- a/tools/perf/pmu-events/arch/x86/goldmontplus/virtual-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/goldmontplus/virtual-memory.json
> @@ -218,4 +218,4 @@
>          "BriefDescription": "Memory uops retired that missed the DTLB (Precise event capable)",
>          "Data_LA": "1"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/haswell/cache.json b/tools/perf/pmu-events/arch/x86/haswell/cache.json
> index 7fb0ad8d8ca1da02..2e5ed218f5419b29 100644
> --- a/tools/perf/pmu-events/arch/x86/haswell/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/haswell/cache.json
> @@ -1060,4 +1060,4 @@
>          "Offcore": "1",
>          "CounterHTOff": "0,1,2,3"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/haswell/floating-point.json b/tools/perf/pmu-events/arch/x86/haswell/floating-point.json
> index f5a3beaa19fc8d74..7cfc6d48cc02009a 100644
> --- a/tools/perf/pmu-events/arch/x86/haswell/floating-point.json
> +++ b/tools/perf/pmu-events/arch/x86/haswell/floating-point.json
> @@ -89,4 +89,4 @@
>          "CounterMask": "1",
>          "CounterHTOff": "0,1,2,3"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/haswell/frontend.json b/tools/perf/pmu-events/arch/x86/haswell/frontend.json
> index c0a5bedcc15c0d37..42d43b80fb16a09f 100644
> --- a/tools/perf/pmu-events/arch/x86/haswell/frontend.json
> +++ b/tools/perf/pmu-events/arch/x86/haswell/frontend.json
> @@ -291,4 +291,4 @@
>          "BriefDescription": "Decode Stream Buffer (DSB)-to-MITE switch true penalty cycles.",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/haswell/memory.json b/tools/perf/pmu-events/arch/x86/haswell/memory.json
> index ef13ed88e2eae681..7f49e414cd8fef1f 100644
> --- a/tools/perf/pmu-events/arch/x86/haswell/memory.json
> +++ b/tools/perf/pmu-events/arch/x86/haswell/memory.json
> @@ -673,4 +673,4 @@
>          "Offcore": "1",
>          "CounterHTOff": "0,1,2,3"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/haswell/other.json b/tools/perf/pmu-events/arch/x86/haswell/other.json
> index 8a4d898d76c11b18..7ad2bcf427a42aa5 100644
> --- a/tools/perf/pmu-events/arch/x86/haswell/other.json
> +++ b/tools/perf/pmu-events/arch/x86/haswell/other.json
> @@ -40,4 +40,4 @@
>          "BriefDescription": "Cycles when L1 and L2 are locked due to UC or split lock",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/haswell/pipeline.json b/tools/perf/pmu-events/arch/x86/haswell/pipeline.json
> index 734d3873729e8048..84bcb14ef9f29691 100644
> --- a/tools/perf/pmu-events/arch/x86/haswell/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/haswell/pipeline.json
> @@ -1340,4 +1340,4 @@
>          "BriefDescription": "Counts the total number when the front end is resteered, mainly when the BPU cannot provide a correct prediction and this is corrected by other branch handling mechanisms at the front end.",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/haswell/uncore.json b/tools/perf/pmu-events/arch/x86/haswell/uncore.json
> index 3ef5c21fef56b796..23b87c1df82fe899 100644
> --- a/tools/perf/pmu-events/arch/x86/haswell/uncore.json
> +++ b/tools/perf/pmu-events/arch/x86/haswell/uncore.json
> @@ -371,4 +371,4 @@
>      "Invert": "0",
>      "EdgeDetect": "0"
>    }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/haswell/virtual-memory.json b/tools/perf/pmu-events/arch/x86/haswell/virtual-memory.json
> index 777b500a5c9f3ef2..bc5f3fafa79921df 100644
> --- a/tools/perf/pmu-events/arch/x86/haswell/virtual-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/haswell/virtual-memory.json
> @@ -481,4 +481,4 @@
>          "BriefDescription": "STLB flush attempts",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/haswellx/cache.json b/tools/perf/pmu-events/arch/x86/haswellx/cache.json
> index a9e62d4357af0635..1df96cc19557820e 100644
> --- a/tools/perf/pmu-events/arch/x86/haswellx/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/haswellx/cache.json
> @@ -1094,4 +1094,4 @@
>          "SampleAfterValue": "100003",
>          "CounterHTOff": "0,1,2,3"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/haswellx/floating-point.json b/tools/perf/pmu-events/arch/x86/haswellx/floating-point.json
> index bc08cc1f2f7eb85d..28453b278e425c9a 100644
> --- a/tools/perf/pmu-events/arch/x86/haswellx/floating-point.json
> +++ b/tools/perf/pmu-events/arch/x86/haswellx/floating-point.json
> @@ -80,4 +80,4 @@
>          "SampleAfterValue": "100003",
>          "CounterHTOff": "0,1,2,3"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/haswellx/frontend.json b/tools/perf/pmu-events/arch/x86/haswellx/frontend.json
> index a4d9f1fcf940b67b..0c6f731498306da2 100644
> --- a/tools/perf/pmu-events/arch/x86/haswellx/frontend.json
> +++ b/tools/perf/pmu-events/arch/x86/haswellx/frontend.json
> @@ -291,4 +291,4 @@
>          "SampleAfterValue": "2000003",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/haswellx/memory.json b/tools/perf/pmu-events/arch/x86/haswellx/memory.json
> index a42d5ce86b6f4ae4..bf51a2551a0a4ea7 100644
> --- a/tools/perf/pmu-events/arch/x86/haswellx/memory.json
> +++ b/tools/perf/pmu-events/arch/x86/haswellx/memory.json
> @@ -764,4 +764,4 @@
>          "SampleAfterValue": "100003",
>          "CounterHTOff": "0,1,2,3"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/haswellx/other.json b/tools/perf/pmu-events/arch/x86/haswellx/other.json
> index 800e65df31bc5e22..151f16a9d6450143 100644
> --- a/tools/perf/pmu-events/arch/x86/haswellx/other.json
> +++ b/tools/perf/pmu-events/arch/x86/haswellx/other.json
> @@ -40,4 +40,4 @@
>          "SampleAfterValue": "2000003",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/haswellx/pipeline.json b/tools/perf/pmu-events/arch/x86/haswellx/pipeline.json
> index 26f2888341ee03ed..15c0cded89fc6dbe 100644
> --- a/tools/perf/pmu-events/arch/x86/haswellx/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/haswellx/pipeline.json
> @@ -1337,4 +1337,4 @@
>          "SampleAfterValue": "100003",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/haswellx/virtual-memory.json b/tools/perf/pmu-events/arch/x86/haswellx/virtual-memory.json
> index 168df552b1a82d33..300ef1d360c2cb17 100644
> --- a/tools/perf/pmu-events/arch/x86/haswellx/virtual-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/haswellx/virtual-memory.json
> @@ -481,4 +481,4 @@
>          "SampleAfterValue": "100003",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/cache.json b/tools/perf/pmu-events/arch/x86/ivybridge/cache.json
> index 5f6cb2abc3840162..3e877d7d4a565e83 100644
> --- a/tools/perf/pmu-events/arch/x86/ivybridge/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/ivybridge/cache.json
> @@ -1099,4 +1099,4 @@
>          "BriefDescription": "Counts all data/code/rfo references (demand & prefetch)",
>          "CounterHTOff": "0,1,2,3"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/floating-point.json b/tools/perf/pmu-events/arch/x86/ivybridge/floating-point.json
> index 950b62c0908e445a..d7ba0ac68d7e9344 100644
> --- a/tools/perf/pmu-events/arch/x86/ivybridge/floating-point.json
> +++ b/tools/perf/pmu-events/arch/x86/ivybridge/floating-point.json
> @@ -148,4 +148,4 @@
>          "CounterMask": "1",
>          "CounterHTOff": "0,1,2,3"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/frontend.json b/tools/perf/pmu-events/arch/x86/ivybridge/frontend.json
> index efaa949ead31ee20..894ccfaaf6106887 100644
> --- a/tools/perf/pmu-events/arch/x86/ivybridge/frontend.json
> +++ b/tools/perf/pmu-events/arch/x86/ivybridge/frontend.json
> @@ -302,4 +302,4 @@
>          "BriefDescription": "Cycles when Decode Stream Buffer (DSB) fill encounter more than 3 Decode Stream Buffer (DSB) lines",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/memory.json b/tools/perf/pmu-events/arch/x86/ivybridge/memory.json
> index a74d54f56192c0cf..09ee7dab292cccbb 100644
> --- a/tools/perf/pmu-events/arch/x86/ivybridge/memory.json
> +++ b/tools/perf/pmu-events/arch/x86/ivybridge/memory.json
> @@ -233,4 +233,4 @@
>          "BriefDescription": "Counts LLC replacements",
>          "CounterHTOff": "0,1,2,3"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/other.json b/tools/perf/pmu-events/arch/x86/ivybridge/other.json
> index 4eb83ee404123989..db4c3d9219ee4093 100644
> --- a/tools/perf/pmu-events/arch/x86/ivybridge/other.json
> +++ b/tools/perf/pmu-events/arch/x86/ivybridge/other.json
> @@ -41,4 +41,4 @@
>          "BriefDescription": "Cycles when L1 and L2 are locked due to UC or split lock",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json b/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json
> index 2a0aad91d83d05e3..9e7181957967e2ea 100644
> --- a/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json
> @@ -1302,4 +1302,4 @@
>          "BriefDescription": "Counts the total number when the front end is resteered, mainly when the BPU cannot provide a correct prediction and this is corrected by other branch handling mechanisms at the front end.",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/uncore.json b/tools/perf/pmu-events/arch/x86/ivybridge/uncore.json
> index 42c70eed05a2f0b7..8c96fc33f0ea21ce 100644
> --- a/tools/perf/pmu-events/arch/x86/ivybridge/uncore.json
> +++ b/tools/perf/pmu-events/arch/x86/ivybridge/uncore.json
> @@ -311,4 +311,4 @@
>      "Invert": "0",
>      "EdgeDetect": "0"
>    }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/virtual-memory.json b/tools/perf/pmu-events/arch/x86/ivybridge/virtual-memory.json
> index f243551b4d1293aa..12a3256d1c94fb23 100644
> --- a/tools/perf/pmu-events/arch/x86/ivybridge/virtual-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/ivybridge/virtual-memory.json
> @@ -177,4 +177,4 @@
>          "BriefDescription": "STLB flush attempts",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/ivytown/cache.json b/tools/perf/pmu-events/arch/x86/ivytown/cache.json
> index 6dad3ad6b102765e..e9045c9b97f62907 100644
> --- a/tools/perf/pmu-events/arch/x86/ivytown/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/ivytown/cache.json
> @@ -1257,4 +1257,4 @@
>          "BriefDescription": "Counts non-temporal stores",
>          "CounterHTOff": "0,1,2,3"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/ivytown/floating-point.json b/tools/perf/pmu-events/arch/x86/ivytown/floating-point.json
> index 950b62c0908e445a..d7ba0ac68d7e9344 100644
> --- a/tools/perf/pmu-events/arch/x86/ivytown/floating-point.json
> +++ b/tools/perf/pmu-events/arch/x86/ivytown/floating-point.json
> @@ -148,4 +148,4 @@
>          "CounterMask": "1",
>          "CounterHTOff": "0,1,2,3"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/ivytown/frontend.json b/tools/perf/pmu-events/arch/x86/ivytown/frontend.json
> index efaa949ead31ee20..894ccfaaf6106887 100644
> --- a/tools/perf/pmu-events/arch/x86/ivytown/frontend.json
> +++ b/tools/perf/pmu-events/arch/x86/ivytown/frontend.json
> @@ -302,4 +302,4 @@
>          "BriefDescription": "Cycles when Decode Stream Buffer (DSB) fill encounter more than 3 Decode Stream Buffer (DSB) lines",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/ivytown/memory.json b/tools/perf/pmu-events/arch/x86/ivytown/memory.json
> index 3a7b86af88166546..cf074bebbec39f22 100644
> --- a/tools/perf/pmu-events/arch/x86/ivytown/memory.json
> +++ b/tools/perf/pmu-events/arch/x86/ivytown/memory.json
> @@ -500,4 +500,4 @@
>          "BriefDescription": "Counts prefetch (that bring data to LLC only) data reads that miss in the LLC",
>          "CounterHTOff": "0,1,2,3"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/ivytown/other.json b/tools/perf/pmu-events/arch/x86/ivytown/other.json
> index 4eb83ee404123989..db4c3d9219ee4093 100644
> --- a/tools/perf/pmu-events/arch/x86/ivytown/other.json
> +++ b/tools/perf/pmu-events/arch/x86/ivytown/other.json
> @@ -41,4 +41,4 @@
>          "BriefDescription": "Cycles when L1 and L2 are locked due to UC or split lock",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json b/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json
> index 2a0aad91d83d05e3..9e7181957967e2ea 100644
> --- a/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json
> @@ -1302,4 +1302,4 @@
>          "BriefDescription": "Counts the total number when the front end is resteered, mainly when the BPU cannot provide a correct prediction and this is corrected by other branch handling mechanisms at the front end.",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/ivytown/virtual-memory.json b/tools/perf/pmu-events/arch/x86/ivytown/virtual-memory.json
> index 4645e9d3f46040b5..d03ffdbcdf24da21 100644
> --- a/tools/perf/pmu-events/arch/x86/ivytown/virtual-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/ivytown/virtual-memory.json
> @@ -195,4 +195,4 @@
>          "BriefDescription": "STLB flush attempts",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/jaketown/cache.json b/tools/perf/pmu-events/arch/x86/jaketown/cache.json
> index 52dc6ef40e635c12..ecd76d3f4a57af4b 100644
> --- a/tools/perf/pmu-events/arch/x86/jaketown/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/jaketown/cache.json
> @@ -1287,4 +1287,4 @@
>          "BriefDescription": "Counts all data/code/rfo references (demand & prefetch)",
>          "CounterHTOff": "0,1,2,3"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/jaketown/floating-point.json b/tools/perf/pmu-events/arch/x86/jaketown/floating-point.json
> index 982eda48785ec878..9adf675c743a7f7e 100644
> --- a/tools/perf/pmu-events/arch/x86/jaketown/floating-point.json
> +++ b/tools/perf/pmu-events/arch/x86/jaketown/floating-point.json
> @@ -135,4 +135,4 @@
>          "CounterMask": "1",
>          "CounterHTOff": "0,1,2,3"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/jaketown/frontend.json b/tools/perf/pmu-events/arch/x86/jaketown/frontend.json
> index 1b7b1dd36c68ec25..d9c6e3ffadbc1995 100644
> --- a/tools/perf/pmu-events/arch/x86/jaketown/frontend.json
> +++ b/tools/perf/pmu-events/arch/x86/jaketown/frontend.json
> @@ -302,4 +302,4 @@
>          "CounterMask": "1",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/jaketown/memory.json b/tools/perf/pmu-events/arch/x86/jaketown/memory.json
> index 27e636428f4ff9f8..c378e3573d881748 100644
> --- a/tools/perf/pmu-events/arch/x86/jaketown/memory.json
> +++ b/tools/perf/pmu-events/arch/x86/jaketown/memory.json
> @@ -419,4 +419,4 @@
>          "BriefDescription": "This event counts all remote cache-to-cache transfers (includes HITM and HIT-Forward) for all demand and L2 prefetches. LLC prefetches are excluded.",
>          "CounterHTOff": "0,1,2,3"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/jaketown/other.json b/tools/perf/pmu-events/arch/x86/jaketown/other.json
> index 64b195b82c502c8b..80fd47f1f7859528 100644
> --- a/tools/perf/pmu-events/arch/x86/jaketown/other.json
> +++ b/tools/perf/pmu-events/arch/x86/jaketown/other.json
> @@ -55,4 +55,4 @@
>          "BriefDescription": "Cycles when L1 and L2 are locked due to UC or split lock.",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json b/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
> index 783a5b4a67b19725..ed5079639d68bb5c 100644
> --- a/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
> @@ -1213,4 +1213,4 @@
>          "BriefDescription": "Count XClk pulses when this thread is unhalted and the other thread is halted.",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/jaketown/virtual-memory.json b/tools/perf/pmu-events/arch/x86/jaketown/virtual-memory.json
> index a654ab771fce7a5a..a1a8115f36bf1b90 100644
> --- a/tools/perf/pmu-events/arch/x86/jaketown/virtual-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/jaketown/virtual-memory.json
> @@ -146,4 +146,4 @@
>          "BriefDescription": "STLB flush attempts.",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/cache.json b/tools/perf/pmu-events/arch/x86/knightslanding/cache.json
> index e847b0fd696df6cc..4500eb60b18c120f 100644
> --- a/tools/perf/pmu-events/arch/x86/knightslanding/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/knightslanding/cache.json
> @@ -2302,4 +2302,4 @@
>          "BriefDescription": "Counts any Prefetch requests that accounts for reponses from snoop request hit with data forwarded from it Far(not in the same quadrant as the request)-other tile L2 in E/F/M state. Valid only in SNC4 Cluster mode.",
>          "Offcore": "1"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/frontend.json b/tools/perf/pmu-events/arch/x86/knightslanding/frontend.json
> index 6d38636689a47ba3..0fc6bf172d8b17ff 100644
> --- a/tools/perf/pmu-events/arch/x86/knightslanding/frontend.json
> +++ b/tools/perf/pmu-events/arch/x86/knightslanding/frontend.json
> @@ -31,4 +31,4 @@
>          "SampleAfterValue": "200003",
>          "BriefDescription": "Counts the number of times the MSROM starts a flow of uops."
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/memory.json b/tools/perf/pmu-events/arch/x86/knightslanding/memory.json
> index c6bb16ba0f8653aa..bc3d065579262f83 100644
> --- a/tools/perf/pmu-events/arch/x86/knightslanding/memory.json
> +++ b/tools/perf/pmu-events/arch/x86/knightslanding/memory.json
> @@ -1107,4 +1107,4 @@
>          "BriefDescription": "Counts any Read request  that accounts for responses from DDR (local and far)",
>          "Offcore": "1"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json b/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
> index 92e4ef2e22c62da9..588b9b956e66ca63 100644
> --- a/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
> @@ -429,4 +429,4 @@
>          "SampleAfterValue": "200003",
>          "BriefDescription": "Counts the number of mispredicted far branch instructions retired."
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/virtual-memory.json b/tools/perf/pmu-events/arch/x86/knightslanding/virtual-memory.json
> index 9e493977771f178c..6313fa16263166c0 100644
> --- a/tools/perf/pmu-events/arch/x86/knightslanding/virtual-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/knightslanding/virtual-memory.json
> @@ -62,4 +62,4 @@
>          "SampleAfterValue": "200003",
>          "BriefDescription": "Counts the total number of core cycles for all the page walks. The cycles for page walks started in speculative path will also be included."
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/cache.json b/tools/perf/pmu-events/arch/x86/nehalemep/cache.json
> index 1c4fd6af138229e3..b5318f5fc19fde54 100644
> --- a/tools/perf/pmu-events/arch/x86/nehalemep/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/nehalemep/cache.json
> @@ -3226,4 +3226,4 @@
>          "BriefDescription": "Offcore prefetch requests that HITM in a remote cache",
>          "Offcore": "1"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json b/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json
> index 7d2f71a9dee3ef04..07d1ff95ed07d46a 100644
> --- a/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json
> +++ b/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json
> @@ -226,4 +226,4 @@
>          "SampleAfterValue": "200000",
>          "BriefDescription": "SIMD integer 64 bit unpack operations"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/frontend.json b/tools/perf/pmu-events/arch/x86/nehalemep/frontend.json
> index e5e21e03444d7b2b..f16116b3454d3889 100644
> --- a/tools/perf/pmu-events/arch/x86/nehalemep/frontend.json
> +++ b/tools/perf/pmu-events/arch/x86/nehalemep/frontend.json
> @@ -23,4 +23,4 @@
>          "SampleAfterValue": "2000000",
>          "BriefDescription": "Two Uop instructions decoded"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/memory.json b/tools/perf/pmu-events/arch/x86/nehalemep/memory.json
> index 029a7fc8561c0629..52fc032987e2a2cc 100644
> --- a/tools/perf/pmu-events/arch/x86/nehalemep/memory.json
> +++ b/tools/perf/pmu-events/arch/x86/nehalemep/memory.json
> @@ -736,4 +736,4 @@
>          "BriefDescription": "Offcore prefetch requests satisfied by a remote DRAM",
>          "Offcore": "1"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/other.json b/tools/perf/pmu-events/arch/x86/nehalemep/other.json
> index af0860622445280b..52ceb500c3bc1621 100644
> --- a/tools/perf/pmu-events/arch/x86/nehalemep/other.json
> +++ b/tools/perf/pmu-events/arch/x86/nehalemep/other.json
> @@ -207,4 +207,4 @@
>          "SampleAfterValue": "2000000",
>          "BriefDescription": "Super Queue full stall cycles"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/pipeline.json b/tools/perf/pmu-events/arch/x86/nehalemep/pipeline.json
> index 41006ddcd8933493..54633582497788f7 100644
> --- a/tools/perf/pmu-events/arch/x86/nehalemep/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/nehalemep/pipeline.json
> @@ -878,4 +878,4 @@
>          "BriefDescription": "Total cycles (Precise Event)",
>          "CounterMask": "16"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/virtual-memory.json b/tools/perf/pmu-events/arch/x86/nehalemep/virtual-memory.json
> index 0596094e0ee9ebee..5cba00c1b6442f9f 100644
> --- a/tools/perf/pmu-events/arch/x86/nehalemep/virtual-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/nehalemep/virtual-memory.json
> @@ -106,4 +106,4 @@
>          "SampleAfterValue": "200000",
>          "BriefDescription": "Retired stores that miss the DTLB (Precise Event)"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/nehalemex/cache.json b/tools/perf/pmu-events/arch/x86/nehalemex/cache.json
> index 980352618ad7e987..2cdd2ff8544fa4fc 100644
> --- a/tools/perf/pmu-events/arch/x86/nehalemex/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/nehalemex/cache.json
> @@ -3181,4 +3181,4 @@
>          "BriefDescription": "Offcore prefetch requests that HITM in a remote cache",
>          "Offcore": "1"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json b/tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json
> index 7d2f71a9dee3ef04..07d1ff95ed07d46a 100644
> --- a/tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json
> +++ b/tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json
> @@ -226,4 +226,4 @@
>          "SampleAfterValue": "200000",
>          "BriefDescription": "SIMD integer 64 bit unpack operations"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/nehalemex/frontend.json b/tools/perf/pmu-events/arch/x86/nehalemex/frontend.json
> index e5e21e03444d7b2b..f16116b3454d3889 100644
> --- a/tools/perf/pmu-events/arch/x86/nehalemex/frontend.json
> +++ b/tools/perf/pmu-events/arch/x86/nehalemex/frontend.json
> @@ -23,4 +23,4 @@
>          "SampleAfterValue": "2000000",
>          "BriefDescription": "Two Uop instructions decoded"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/nehalemex/memory.json b/tools/perf/pmu-events/arch/x86/nehalemex/memory.json
> index 029a7fc8561c0629..52fc032987e2a2cc 100644
> --- a/tools/perf/pmu-events/arch/x86/nehalemex/memory.json
> +++ b/tools/perf/pmu-events/arch/x86/nehalemex/memory.json
> @@ -736,4 +736,4 @@
>          "BriefDescription": "Offcore prefetch requests satisfied by a remote DRAM",
>          "Offcore": "1"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/nehalemex/other.json b/tools/perf/pmu-events/arch/x86/nehalemex/other.json
> index af0860622445280b..52ceb500c3bc1621 100644
> --- a/tools/perf/pmu-events/arch/x86/nehalemex/other.json
> +++ b/tools/perf/pmu-events/arch/x86/nehalemex/other.json
> @@ -207,4 +207,4 @@
>          "SampleAfterValue": "2000000",
>          "BriefDescription": "Super Queue full stall cycles"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/nehalemex/pipeline.json b/tools/perf/pmu-events/arch/x86/nehalemex/pipeline.json
> index 41006ddcd8933493..54633582497788f7 100644
> --- a/tools/perf/pmu-events/arch/x86/nehalemex/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/nehalemex/pipeline.json
> @@ -878,4 +878,4 @@
>          "BriefDescription": "Total cycles (Precise Event)",
>          "CounterMask": "16"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/nehalemex/virtual-memory.json b/tools/perf/pmu-events/arch/x86/nehalemex/virtual-memory.json
> index 0596094e0ee9ebee..5cba00c1b6442f9f 100644
> --- a/tools/perf/pmu-events/arch/x86/nehalemex/virtual-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/nehalemex/virtual-memory.json
> @@ -106,4 +106,4 @@
>          "SampleAfterValue": "200000",
>          "BriefDescription": "Retired stores that miss the DTLB (Precise Event)"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/cache.json b/tools/perf/pmu-events/arch/x86/sandybridge/cache.json
> index bb79e89c2049d272..7d40a248e0cb7099 100644
> --- a/tools/perf/pmu-events/arch/x86/sandybridge/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/sandybridge/cache.json
> @@ -1876,4 +1876,4 @@
>          "BriefDescription": "REQUEST = PF_LLC_IFETCH and RESPONSE = ANY_RESPONSE",
>          "CounterHTOff": "0,1,2,3"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/floating-point.json b/tools/perf/pmu-events/arch/x86/sandybridge/floating-point.json
> index ce26537c7d47f912..7472bd56fb297332 100644
> --- a/tools/perf/pmu-events/arch/x86/sandybridge/floating-point.json
> +++ b/tools/perf/pmu-events/arch/x86/sandybridge/floating-point.json
> @@ -135,4 +135,4 @@
>          "CounterMask": "1",
>          "CounterHTOff": "0,1,2,3"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/frontend.json b/tools/perf/pmu-events/arch/x86/sandybridge/frontend.json
> index e58ed14a204cc8dc..7fc434f8e26829cc 100644
> --- a/tools/perf/pmu-events/arch/x86/sandybridge/frontend.json
> +++ b/tools/perf/pmu-events/arch/x86/sandybridge/frontend.json
> @@ -302,4 +302,4 @@
>          "BriefDescription": "Cases of cancelling valid Decode Stream Buffer (DSB) fill not because of exceeding way limit.",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/memory.json b/tools/perf/pmu-events/arch/x86/sandybridge/memory.json
> index 78c1a987f9a2294a..959925808106a935 100644
> --- a/tools/perf/pmu-events/arch/x86/sandybridge/memory.json
> +++ b/tools/perf/pmu-events/arch/x86/sandybridge/memory.json
> @@ -442,4 +442,4 @@
>          "BriefDescription": "REQUEST = PF_LLC_IFETCH and RESPONSE = LLC_MISS_LOCAL and SNOOP = DRAM",
>          "CounterHTOff": "0,1,2,3"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/other.json b/tools/perf/pmu-events/arch/x86/sandybridge/other.json
> index 874eb40a2e0f737c..83929405f9e2ebf9 100644
> --- a/tools/perf/pmu-events/arch/x86/sandybridge/other.json
> +++ b/tools/perf/pmu-events/arch/x86/sandybridge/other.json
> @@ -55,4 +55,4 @@
>          "BriefDescription": "Cycles when L1 and L2 are locked due to UC or split lock.",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json b/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
> index b7150f65f16d6402..99e22ef37f61bdb7 100644
> --- a/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
> @@ -1223,4 +1223,4 @@
>          "BriefDescription": "Counts the total number when the front end is resteered, mainly when the BPU cannot provide a correct prediction and this is corrected by other branch handling mechanisms at the front end.",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/uncore.json b/tools/perf/pmu-events/arch/x86/sandybridge/uncore.json
> index 42c70eed05a2f0b7..8c96fc33f0ea21ce 100644
> --- a/tools/perf/pmu-events/arch/x86/sandybridge/uncore.json
> +++ b/tools/perf/pmu-events/arch/x86/sandybridge/uncore.json
> @@ -311,4 +311,4 @@
>      "Invert": "0",
>      "EdgeDetect": "0"
>    }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/virtual-memory.json b/tools/perf/pmu-events/arch/x86/sandybridge/virtual-memory.json
> index b8eccce5d75d4a21..a2c49c352438e924 100644
> --- a/tools/perf/pmu-events/arch/x86/sandybridge/virtual-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/sandybridge/virtual-memory.json
> @@ -146,4 +146,4 @@
>          "BriefDescription": "STLB flush attempts.",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/silvermont/cache.json b/tools/perf/pmu-events/arch/x86/silvermont/cache.json
> index 805ef14365399768..d1ce1045ce4111de 100644
> --- a/tools/perf/pmu-events/arch/x86/silvermont/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/silvermont/cache.json
> @@ -809,4 +809,4 @@
>          "BriefDescription": "Counts demand and DCU prefetch data read that have any response type.",
>          "Offcore": "1"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/silvermont/frontend.json b/tools/perf/pmu-events/arch/x86/silvermont/frontend.json
> index 204473badf5ab599..44d62ce27a71e3b7 100644
> --- a/tools/perf/pmu-events/arch/x86/silvermont/frontend.json
> +++ b/tools/perf/pmu-events/arch/x86/silvermont/frontend.json
> @@ -44,4 +44,4 @@
>          "SampleAfterValue": "200003",
>          "BriefDescription": "Counts the number of times a decode restriction reduced the decode throughput due to wrong instruction length prediction"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/silvermont/memory.json b/tools/perf/pmu-events/arch/x86/silvermont/memory.json
> index d72e09a5f9297054..c2338715feec335c 100644
> --- a/tools/perf/pmu-events/arch/x86/silvermont/memory.json
> +++ b/tools/perf/pmu-events/arch/x86/silvermont/memory.json
> @@ -8,4 +8,4 @@
>          "SampleAfterValue": "200003",
>          "BriefDescription": "Stalls due to Memory ordering"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/silvermont/other.json b/tools/perf/pmu-events/arch/x86/silvermont/other.json
> index 47814046fa9d4893..7bd9ec324378bb57 100644
> --- a/tools/perf/pmu-events/arch/x86/silvermont/other.json
> +++ b/tools/perf/pmu-events/arch/x86/silvermont/other.json
> @@ -17,4 +17,4 @@
>          "SampleAfterValue": "200003",
>          "BriefDescription": "Cycles code-fetch stalled due to any reason."
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json b/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
> index 1ed62ad4cf778201..6805fede792a8862 100644
> --- a/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
> @@ -353,4 +353,4 @@
>          "SampleAfterValue": "200003",
>          "BriefDescription": "Counts the number of taken branch instructions retired"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/silvermont/virtual-memory.json b/tools/perf/pmu-events/arch/x86/silvermont/virtual-memory.json
> index ad31479f8f6019f6..ac50244bc65a045f 100644
> --- a/tools/perf/pmu-events/arch/x86/silvermont/virtual-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/silvermont/virtual-memory.json
> @@ -66,4 +66,4 @@
>          "SampleAfterValue": "200003",
>          "BriefDescription": "Total cycles for all the page walks. (I-side and D-side)"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/skylake/cache.json b/tools/perf/pmu-events/arch/x86/skylake/cache.json
> index 720458139049c1f4..fe6640afa8e1c38d 100644
> --- a/tools/perf/pmu-events/arch/x86/skylake/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/skylake/cache.json
> @@ -2925,4 +2925,4 @@
>          "Offcore": "1",
>          "CounterHTOff": "0,1,2,3"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/skylake/floating-point.json b/tools/perf/pmu-events/arch/x86/skylake/floating-point.json
> index 213dd6230cf2b6e1..e39e796005acf6f2 100644
> --- a/tools/perf/pmu-events/arch/x86/skylake/floating-point.json
> +++ b/tools/perf/pmu-events/arch/x86/skylake/floating-point.json
> @@ -64,4 +64,4 @@
>          "CounterMask": "1",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/skylake/frontend.json b/tools/perf/pmu-events/arch/x86/skylake/frontend.json
> index 7fa95a35e3cacc98..e6e342d469464982 100644
> --- a/tools/perf/pmu-events/arch/x86/skylake/frontend.json
> +++ b/tools/perf/pmu-events/arch/x86/skylake/frontend.json
> @@ -479,4 +479,4 @@
>          "TakenAlone": "1",
>          "CounterHTOff": "0,1,2,3"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/skylake/memory.json b/tools/perf/pmu-events/arch/x86/skylake/memory.json
> index f197b4c7695beb45..12f8b791703236d3 100644
> --- a/tools/perf/pmu-events/arch/x86/skylake/memory.json
> +++ b/tools/perf/pmu-events/arch/x86/skylake/memory.json
> @@ -1601,4 +1601,4 @@
>          "Offcore": "1",
>          "CounterHTOff": "0,1,2,3"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/skylake/other.json b/tools/perf/pmu-events/arch/x86/skylake/other.json
> index 84a316d380acbd2a..07fbf4b01bbe5c72 100644
> --- a/tools/perf/pmu-events/arch/x86/skylake/other.json
> +++ b/tools/perf/pmu-events/arch/x86/skylake/other.json
> @@ -45,4 +45,4 @@
>          "BriefDescription": "Number of hardware interrupts received by the processor.",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/skylake/pipeline.json b/tools/perf/pmu-events/arch/x86/skylake/pipeline.json
> index 4a891fbbc4bb2ba2..31af384556ea24c2 100644
> --- a/tools/perf/pmu-events/arch/x86/skylake/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/skylake/pipeline.json
> @@ -964,4 +964,4 @@
>          "BriefDescription": "Counts the total number when the front end is resteered, mainly when the BPU cannot provide a correct prediction and this is corrected by other branch handling mechanisms at the front end.",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/skylake/uncore.json b/tools/perf/pmu-events/arch/x86/skylake/uncore.json
> index dbc193252fb30d6e..e46e38d7822243e0 100644
> --- a/tools/perf/pmu-events/arch/x86/skylake/uncore.json
> +++ b/tools/perf/pmu-events/arch/x86/skylake/uncore.json
> @@ -251,4 +251,4 @@
>      "Invert": "0",
>      "EdgeDetect": "0"
>    }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/skylake/virtual-memory.json b/tools/perf/pmu-events/arch/x86/skylake/virtual-memory.json
> index 2bcba7daca14d920..935b4679a308fb64 100644
> --- a/tools/perf/pmu-events/arch/x86/skylake/virtual-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/skylake/virtual-memory.json
> @@ -281,4 +281,4 @@
>          "BriefDescription": "STLB flush attempts",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/skylakex/cache.json b/tools/perf/pmu-events/arch/x86/skylakex/cache.json
> index 24df183693faa5ab..3c638e710735bd10 100644
> --- a/tools/perf/pmu-events/arch/x86/skylakex/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/skylakex/cache.json
> @@ -1660,4 +1660,4 @@
>          "SampleAfterValue": "100003",
>          "CounterHTOff": "0,1,2,3"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/skylakex/floating-point.json b/tools/perf/pmu-events/arch/x86/skylakex/floating-point.json
> index c5d0babe89fcef11..ea5cc60129e432ef 100644
> --- a/tools/perf/pmu-events/arch/x86/skylakex/floating-point.json
> +++ b/tools/perf/pmu-events/arch/x86/skylakex/floating-point.json
> @@ -82,4 +82,4 @@
>          "SampleAfterValue": "100003",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/skylakex/frontend.json b/tools/perf/pmu-events/arch/x86/skylakex/frontend.json
> index 4dc583cfb5459c29..de03a98624c49f34 100644
> --- a/tools/perf/pmu-events/arch/x86/skylakex/frontend.json
> +++ b/tools/perf/pmu-events/arch/x86/skylakex/frontend.json
> @@ -479,4 +479,4 @@
>          "SampleAfterValue": "100007",
>          "CounterHTOff": "0,1,2,3"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/skylakex/memory.json b/tools/perf/pmu-events/arch/x86/skylakex/memory.json
> index 48a9cdf81307cbdd..2827a02d071f3e26 100644
> --- a/tools/perf/pmu-events/arch/x86/skylakex/memory.json
> +++ b/tools/perf/pmu-events/arch/x86/skylakex/memory.json
> @@ -1393,4 +1393,4 @@
>          "SampleAfterValue": "100003",
>          "CounterHTOff": "0,1,2,3"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/skylakex/other.json b/tools/perf/pmu-events/arch/x86/skylakex/other.json
> index 778a541463eb6cab..1b76d8594fc5bbb6 100644
> --- a/tools/perf/pmu-events/arch/x86/skylakex/other.json
> +++ b/tools/perf/pmu-events/arch/x86/skylakex/other.json
> @@ -161,4 +161,4 @@
>          "SampleAfterValue": "100003",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/skylakex/pipeline.json b/tools/perf/pmu-events/arch/x86/skylakex/pipeline.json
> index 369f56c1d1b5a444..df1c6d5d583aa0c7 100644
> --- a/tools/perf/pmu-events/arch/x86/skylakex/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/skylakex/pipeline.json
> @@ -964,4 +964,4 @@
>          "SampleAfterValue": "100003",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/skylakex/virtual-memory.json b/tools/perf/pmu-events/arch/x86/skylakex/virtual-memory.json
> index 7f466c97e485ddc6..95f1f87ca8662446 100644
> --- a/tools/perf/pmu-events/arch/x86/skylakex/virtual-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/skylakex/virtual-memory.json
> @@ -281,4 +281,4 @@
>          "SampleAfterValue": "100007",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json b/tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json
> index 6e61ae20d01a064f..84a6c9ce0d9a299f 100644
> --- a/tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json
> @@ -2814,4 +2814,4 @@
>          "BriefDescription": "REQUEST = PREFETCH and RESPONSE = REMOTE_CACHE_HITM",
>          "Offcore": "1"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json b/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json
> index 7d2f71a9dee3ef04..07d1ff95ed07d46a 100644
> --- a/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json
> +++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json
> @@ -226,4 +226,4 @@
>          "SampleAfterValue": "200000",
>          "BriefDescription": "SIMD integer 64 bit unpack operations"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/frontend.json b/tools/perf/pmu-events/arch/x86/westmereep-dp/frontend.json
> index e5e21e03444d7b2b..f16116b3454d3889 100644
> --- a/tools/perf/pmu-events/arch/x86/westmereep-dp/frontend.json
> +++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/frontend.json
> @@ -23,4 +23,4 @@
>          "SampleAfterValue": "2000000",
>          "BriefDescription": "Two Uop instructions decoded"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/memory.json b/tools/perf/pmu-events/arch/x86/westmereep-dp/memory.json
> index 6e0829b7617ffad7..0c36efc9f75fd874 100644
> --- a/tools/perf/pmu-events/arch/x86/westmereep-dp/memory.json
> +++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/memory.json
> @@ -755,4 +755,4 @@
>          "BriefDescription": "REQUEST = PREFETCH and RESPONSE = REMOTE_DRAM",
>          "Offcore": "1"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/other.json b/tools/perf/pmu-events/arch/x86/westmereep-dp/other.json
> index 85133d6a5ce018e1..7715ac7bcdf05f19 100644
> --- a/tools/perf/pmu-events/arch/x86/westmereep-dp/other.json
> +++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/other.json
> @@ -284,4 +284,4 @@
>          "SampleAfterValue": "2000000",
>          "BriefDescription": "Super Queue full stall cycles"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/pipeline.json b/tools/perf/pmu-events/arch/x86/westmereep-dp/pipeline.json
> index f130510f761617ae..35fc501936689d6c 100644
> --- a/tools/perf/pmu-events/arch/x86/westmereep-dp/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/pipeline.json
> @@ -896,4 +896,4 @@
>          "BriefDescription": "Total cycles (Precise Event)",
>          "CounterMask": "16"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json b/tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json
> index 57b53562e2bd65e8..d61cf9e9fa600ccf 100644
> --- a/tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json
> @@ -170,4 +170,4 @@
>          "SampleAfterValue": "200000",
>          "BriefDescription": "Retired stores that miss the DTLB (Precise Event)"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/westmereep-sp/cache.json b/tools/perf/pmu-events/arch/x86/westmereep-sp/cache.json
> index 62cddfff9781766d..565af853eea9c481 100644
> --- a/tools/perf/pmu-events/arch/x86/westmereep-sp/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/westmereep-sp/cache.json
> @@ -3230,4 +3230,4 @@
>          "BriefDescription": "Offcore prefetch requests that HITM in a remote cache",
>          "Offcore": "1"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json b/tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json
> index 7d2f71a9dee3ef04..07d1ff95ed07d46a 100644
> --- a/tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json
> +++ b/tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json
> @@ -226,4 +226,4 @@
>          "SampleAfterValue": "200000",
>          "BriefDescription": "SIMD integer 64 bit unpack operations"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/westmereep-sp/frontend.json b/tools/perf/pmu-events/arch/x86/westmereep-sp/frontend.json
> index e5e21e03444d7b2b..f16116b3454d3889 100644
> --- a/tools/perf/pmu-events/arch/x86/westmereep-sp/frontend.json
> +++ b/tools/perf/pmu-events/arch/x86/westmereep-sp/frontend.json
> @@ -23,4 +23,4 @@
>          "SampleAfterValue": "2000000",
>          "BriefDescription": "Two Uop instructions decoded"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/westmereep-sp/memory.json b/tools/perf/pmu-events/arch/x86/westmereep-sp/memory.json
> index 8355b5d3945ba8fa..52657bea8dd6f080 100644
> --- a/tools/perf/pmu-events/arch/x86/westmereep-sp/memory.json
> +++ b/tools/perf/pmu-events/arch/x86/westmereep-sp/memory.json
> @@ -736,4 +736,4 @@
>          "BriefDescription": "Offcore prefetch requests satisfied by a remote DRAM",
>          "Offcore": "1"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/westmereep-sp/other.json b/tools/perf/pmu-events/arch/x86/westmereep-sp/other.json
> index 85133d6a5ce018e1..7715ac7bcdf05f19 100644
> --- a/tools/perf/pmu-events/arch/x86/westmereep-sp/other.json
> +++ b/tools/perf/pmu-events/arch/x86/westmereep-sp/other.json
> @@ -284,4 +284,4 @@
>          "SampleAfterValue": "2000000",
>          "BriefDescription": "Super Queue full stall cycles"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/westmereep-sp/pipeline.json b/tools/perf/pmu-events/arch/x86/westmereep-sp/pipeline.json
> index f130510f761617ae..35fc501936689d6c 100644
> --- a/tools/perf/pmu-events/arch/x86/westmereep-sp/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/westmereep-sp/pipeline.json
> @@ -896,4 +896,4 @@
>          "BriefDescription": "Total cycles (Precise Event)",
>          "CounterMask": "16"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/westmereep-sp/virtual-memory.json b/tools/perf/pmu-events/arch/x86/westmereep-sp/virtual-memory.json
> index 2153b3f5d7b0b498..bb4e99b3a0c252b4 100644
> --- a/tools/perf/pmu-events/arch/x86/westmereep-sp/virtual-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/westmereep-sp/virtual-memory.json
> @@ -146,4 +146,4 @@
>          "SampleAfterValue": "200000",
>          "BriefDescription": "Retired stores that miss the DTLB (Precise Event)"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/westmereex/cache.json b/tools/perf/pmu-events/arch/x86/westmereex/cache.json
> index 30266602fc82e85d..898af4db1010568e 100644
> --- a/tools/perf/pmu-events/arch/x86/westmereex/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/westmereex/cache.json
> @@ -3222,4 +3222,4 @@
>          "BriefDescription": "Offcore prefetch requests that HITM in a remote cache",
>          "Offcore": "1"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json b/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json
> index 7d2f71a9dee3ef04..07d1ff95ed07d46a 100644
> --- a/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json
> +++ b/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json
> @@ -226,4 +226,4 @@
>          "SampleAfterValue": "200000",
>          "BriefDescription": "SIMD integer 64 bit unpack operations"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/westmereex/frontend.json b/tools/perf/pmu-events/arch/x86/westmereex/frontend.json
> index e5e21e03444d7b2b..f16116b3454d3889 100644
> --- a/tools/perf/pmu-events/arch/x86/westmereex/frontend.json
> +++ b/tools/perf/pmu-events/arch/x86/westmereex/frontend.json
> @@ -23,4 +23,4 @@
>          "SampleAfterValue": "2000000",
>          "BriefDescription": "Two Uop instructions decoded"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/westmereex/memory.json b/tools/perf/pmu-events/arch/x86/westmereex/memory.json
> index 794e6773bf74cc0c..3c15f9e067727173 100644
> --- a/tools/perf/pmu-events/arch/x86/westmereex/memory.json
> +++ b/tools/perf/pmu-events/arch/x86/westmereex/memory.json
> @@ -744,4 +744,4 @@
>          "BriefDescription": "Offcore prefetch requests satisfied by a remote DRAM",
>          "Offcore": "1"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/westmereex/other.json b/tools/perf/pmu-events/arch/x86/westmereex/other.json
> index 85133d6a5ce018e1..7715ac7bcdf05f19 100644
> --- a/tools/perf/pmu-events/arch/x86/westmereex/other.json
> +++ b/tools/perf/pmu-events/arch/x86/westmereex/other.json
> @@ -284,4 +284,4 @@
>          "SampleAfterValue": "2000000",
>          "BriefDescription": "Super Queue full stall cycles"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/westmereex/pipeline.json b/tools/perf/pmu-events/arch/x86/westmereex/pipeline.json
> index 799c57d94c39617f..8a999cfbdebad68e 100644
> --- a/tools/perf/pmu-events/arch/x86/westmereex/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/westmereex/pipeline.json
> @@ -902,4 +902,4 @@
>          "BriefDescription": "Total cycles (Precise Event)",
>          "CounterMask": "16"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/westmereex/virtual-memory.json b/tools/perf/pmu-events/arch/x86/westmereex/virtual-memory.json
> index ad989207e8f8b85e..a6a04d23f481ffa2 100644
> --- a/tools/perf/pmu-events/arch/x86/westmereex/virtual-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/westmereex/virtual-memory.json
> @@ -170,4 +170,4 @@
>          "SampleAfterValue": "200000",
>          "BriefDescription": "Retired stores that miss the DTLB (Precise Event)"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/scripts/python/bin/intel-pt-events-report b/tools/perf/scripts/python/bin/intel-pt-events-report
> index 9a9c92fcd026871b..3933b489f6aaf55c 100644
> --- a/tools/perf/scripts/python/bin/intel-pt-events-report
> +++ b/tools/perf/scripts/python/bin/intel-pt-events-report
> @@ -1,3 +1,3 @@
>  #!/bin/bash
>  # description: print Intel PT Power Events and PTWRITE
> -perf script $@ -s "$PERF_EXEC_PATH"/scripts/python/intel-pt-events.py
> \ No newline at end of file
> +perf script $@ -s "$PERF_EXEC_PATH"/scripts/python/intel-pt-events.py
> -- 
> 2.17.1

-- 

- Arnaldo
