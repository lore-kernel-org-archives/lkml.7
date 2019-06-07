Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C07C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822A720868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alYl8sr8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbfFGSUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 14:20:54 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42483 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729474AbfFGSUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:20:54 -0400
Received: by mail-qt1-f193.google.com with SMTP id s15so3351083qtk.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 11:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H7b0K6AHn3lhpoTm1wMSXCMZuAzx8sTZocmvHqLXA2w=;
        b=alYl8sr8SbMctVNVQo3Va9KlGyawdQnhGteScnFY3nMLYOZvLhK1SvtT82TiGi8KTC
         kNzd4D6oFgxpMGUTjWL5kxMUwKxK/5RRlKt5PdfcFSqvyjGuXDJY7kwQOmyz4s6M5WmS
         dIY1W5U/X2yAkdm1iGVneGELzzEdbbEB3iSbly5uhtogv7aox27/iBZ/EpIEXnvf06uc
         ffE41G0KJLFdmZOsc5f3NWVvnvrH5sDAvohiS8LsnMD36YpYVjF/CFoNx9y8nICw4mBt
         Gl+5MWZQNsUfy/c17n9rmMpetw3bUhZkgWNj68PcW7NJ2y87AthglmdZFTRt34iS+aMM
         WymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H7b0K6AHn3lhpoTm1wMSXCMZuAzx8sTZocmvHqLXA2w=;
        b=fLuA1MjQIXRRMA8qfegUSDKmBqLhGWIZ9s2nyAmv3R/5KwZsyMTmaAxBm7jHsTBuqF
         dbhfuC9Y6Z30iK/aUjfg3njeSIEhZUsu5iBXJ1CFN2lt4sgBCYLQiAaEO2RouLbL7c6V
         +gC5EpDWhsLBfCI1DmCS2piBdYXUnYQi37JDmbLNF+434pE4GCJkJEMogcAG9BjMpt2r
         el4FzeTn7MA7Icb0ekc6jRErDsze1pJ/P003Pbk6JijhwJO7Gc2gYjds8Ny3Cxfsc+FF
         /n5udf2PBi3R5LmYV7Y6r3ovW3WWunXuo4oHxulSaW9EiU4mvtuUI7hp+FElbWsgWBIK
         MClg==
X-Gm-Message-State: APjAAAXMyv/6xUGDe4fmp/T55EOAskLs/POMxH4Nrgvp6hq20k0zQkyN
        PHHcKUDvk/BgwbsHq+0earM=
X-Google-Smtp-Source: APXvYqxiQHx/woe8CEJLBaqaKb+PG+tdst3UEIZS36F0s1sf9se+z0/fwTThfPxqlISW5b4GktQGuw==
X-Received: by 2002:aed:218b:: with SMTP id l11mr27818875qtc.66.1559931652639;
        Fri, 07 Jun 2019 11:20:52 -0700 (PDT)
Received: from quaco.ghostprotocols.net (187-26-97-17.3g.claro.net.br. [187.26.97.17])
        by smtp.gmail.com with ESMTPSA id x15sm1404897qtf.15.2019.06.07.11.20.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 11:20:51 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CEE8441149; Fri,  7 Jun 2019 15:20:47 -0300 (-03)
Date:   Fri, 7 Jun 2019 15:20:47 -0300
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     mathieu.poirier@linaro.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org
Subject: Re: [PATCH v2 01/17] perf tools: Configure contextID tracing in
 CPU-wide mode
Message-ID: <20190607182047.GK21245@kernel.org>
References: <20190524173508.29044-1-mathieu.poirier@linaro.org>
 <20190524173508.29044-2-mathieu.poirier@linaro.org>
 <68c1c548-33cd-31e8-100d-7ffad008c7b2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68c1c548-33cd-31e8-100d-7ffad008c7b2@arm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 07, 2019 at 10:21:36AM +0100, Suzuki K Poulose escreveu:
> Hi Mathieu,
> 
> On 24/05/2019 18:34, Mathieu Poirier wrote:
> > When operating in CPU-wide mode being notified of contextID changes is
> > required so that the decoding mechanic is aware of the process context
> > switch.
> > 
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> 
> > Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> I am sorry but, I don't remember reviewing this patch in the previous
> postings. But here we go.

Can I keep it as is? I addressed one of your concerns below, please
check.

- Arnaldo
 
> > +++ b/tools/perf/util/cs-etm.h
> > @@ -103,6 +103,18 @@ struct intlist *traceid_list;
> >   #define KiB(x) ((x) * 1024)
> >   #define MiB(x) ((x) * 1024 * 1024)
> > +/*
> > + * Create a contiguous bitmask starting at bit position @l and ending at
> > + * position @h. For example
> > + * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
> > + *
> > + * Carbon copy of implementation found in $KERNEL/include/linux/bitops.h
> > + */
> > +#define GENMASK(h, l) \
> > +	(((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
> > +
> 
> minor nit: Could this be placed in a more generic header file for the other
> parts of the perf tool to consume ?
> 

Yeah, since we have:

Good catch, we have it already:

[acme@quaco perf]$ tail tools/include/linux/bits.h
 * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
 */
#define GENMASK(h, l) \
	(((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))

#define GENMASK_ULL(h, l) \
	(((~0ULL) - (1ULL << (l)) + 1) & \
	 (~0ULL >> (BITS_PER_LONG_LONG - 1 - (h))))

#endif	/* __LINUX_BITS_H */
[acme@quaco perf]$
[acme@quaco perf]$

So I'm adding this to the pile with a Suggested-by: Suzuki, ok?

commit 3217a621248824fbff8563d8447fdafe69c5316d
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Fri Jun 7 15:14:27 2019 -0300

    perf cs-etm: Remove duplicate GENMASK() define, use linux/bits.h instead
    
    Suzuki noticed that this should be more useful in a generic header, and
    after looking I noticed we have it already in our copy of
    include/linux/bits.h in tools/include, so just use it, test built on
    x86-64 and ubuntu 19.04 with:
    
      perfbuilder@46646c9e848e:/$ aarch64-linux-gnu-gcc --version |& head -1
      aarch64-linux-gnu-gcc (Ubuntu/Linaro 8.3.0-6ubuntu1) 8.3.0
      perfbuilder@46646c9e848e:/$
    
    Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
    Link: https://lkml.kernel.org/r/68c1c548-33cd-31e8-100d-7ffad008c7b2@arm.com
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Jiri Olsa <jolsa@redhat.com>
    Cc: Leo Yan <leo.yan@linaro.org>
    Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: coresight@lists.linaro.org
    Cc: linux-arm-kernel@lists.infradead.org,
    Link: https://lkml.kernel.org/n/tip-69pd3mqvxdlh2shddsc7yhyv@git.kernel.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 33b57e748c3d..bc848fd095f4 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -9,6 +9,7 @@
 
 #include "util/event.h"
 #include "util/session.h"
+#include <linux/bits.h>
 
 /* Versionning header in case things need tro change in the future.  That way
  * decoding of old snapshot is still possible.
@@ -161,16 +162,6 @@ struct cs_etm_packet_queue {
 
 #define CS_ETM_INVAL_ADDR 0xdeadbeefdeadbeefUL
 
-/*
- * Create a contiguous bitmask starting at bit position @l and ending at
- * position @h. For example
- * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
- *
- * Carbon copy of implementation found in $KERNEL/include/linux/bitops.h
- */
-#define GENMASK(h, l) \
-	(((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
-
 #define BMVAL(val, lsb, msb)	((val & GENMASK(msb, lsb)) >> lsb)
 
 #define CS_ETM_HEADER_SIZE (CS_HEADER_VERSION_0_MAX * sizeof(u64))
